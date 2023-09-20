Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4237A8E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjITVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:25:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15383C2;
        Wed, 20 Sep 2023 14:25:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3bd829b86so2197665ad.0;
        Wed, 20 Sep 2023 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695245152; x=1695849952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMbPNeYy+UGMgyZDyxPbuxTcd7HPf3Y3TrYovIXSs50=;
        b=VtIWFE8FnbXo/Q774ZoU87GqsvfliKaWbI/wCg4iLT4Ir/e3yD4qdq40sb83Qv3VKL
         K0m2h43RY7YtJmK8B6vxBd4mcS51st8K9JNPrdiE9o35Kj5eIw1dhif5ncWa/S4/E0Oy
         p/MV/FPsdFXWd5STDc7WhlSaXiHQBT3HCaHQ9Vv6dhsxI7QTay5I9lEl85ZgAV6nBU1s
         4G7NvsbAGDn5kwqVdWKn/zZz5mxXESvJIVCfcTIULFqBYxvNtPB038jIPpZ56hnHqf91
         RmncYxa0sDmlnAwSixVINp+3azZysoxg8tgV6IpKFm98g4eNm3pdi1NuKqoV5KRSFLHI
         YBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245152; x=1695849952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMbPNeYy+UGMgyZDyxPbuxTcd7HPf3Y3TrYovIXSs50=;
        b=cZPF9m0bckB9/a3JhxQc4Itwx1CW+TGyCYbmJYjKZa28Z026K8KNcv12rZZ19+Q0nd
         HcL0L0/OVRhqNV9W0JHL8i12uSVlLNkJxhPgJiuSw+eDifDIBOIyjV7N9q6ksAB1xqKP
         MnOQ4DGlVfm9mjDYZgHd3kfCp0kRBa02hQwByj2Su5A0xzISXc6SNAsb9maZUd0X6+Vq
         Ux6ykjKcoPPuWPybZCCBRU1nizpLFd5vM7OpH1FRIIKG2SFbNzJWK3oeW75XU5mT0akJ
         wZ/lv8w7FWuqs7YiXxYYbJY799xAp+ip+9LdNb+6o0gVXPhhYROJYMygiNgc1G8BALYg
         RmxA==
X-Gm-Message-State: AOJu0Yzop82YHooqGXSor+OlILUqiUr9JE4X9PWHN/nYYp08Hd/2Mzk1
        JWAeboSWrOgOiPyFhBC87w5QmvXIV4r86w==
X-Google-Smtp-Source: AGHT+IGzqX77C1WpExcjByUyYVEVr2I38LrIA4s3nXcrHk/SqCMeB6QNSE8/IB5ycHUd/IjSg1YsTg==
X-Received: by 2002:a17:903:32c5:b0:1c3:411c:9b7d with SMTP id i5-20020a17090332c500b001c3411c9b7dmr4053435plr.57.1695245152274;
        Wed, 20 Sep 2023 14:25:52 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o10-20020a170902d4ca00b001bf3bdbceb5sm12286208plg.134.2023.09.20.14.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:25:51 -0700 (PDT)
Message-ID: <f814cce5-9721-f64a-e8f6-cf390d1c43e6@gmail.com>
Date:   Wed, 20 Sep 2023 14:25:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:10, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its type
> definition from 8250 code. As with previous removals, I checked with
> Debian Code Search that 'PORT_AR7' is not used in userspace.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

