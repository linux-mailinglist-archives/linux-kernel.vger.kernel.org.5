Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A717B2558
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjI1Sey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjI1Sev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:34:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC599
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:34:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so358203266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695926088; x=1696530888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8YCZOrXCtY9QJc+2PHdkCvZcfQzxTrikDnrW4s8264=;
        b=avCW5BsYhSfXrVuP09aHsbdc1a9yDAfuIky2qNlamXkb78cDzEqJgn0q5vBFpgZkpH
         e5CIUqxUNrUPV+0qApVMlGFh0dL2YqzTJgbxXrkGcJKrRNGAahRAUN7cwFSxL+8AGimG
         gOATQsF48xnPk+JuXJXoh/bhlrmwjQoXGsoRbAJgbUDcSfyFrHSrntmCxQ7BUb9P2Wyq
         pJp2iZ4Az6ky0fE3cWBfevKpDpsKVSQgbQkCrVy8CVHio0vVLy+rpaKyC6ZHP4ubp5/e
         WMqpIRGtbgwyDzeIblJx6RJRW4bejSfY60qarQZ0Si+BdsTBvbcrpoUp/IFe51W2e9P5
         6xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926088; x=1696530888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8YCZOrXCtY9QJc+2PHdkCvZcfQzxTrikDnrW4s8264=;
        b=IotF8sTLYC3IjJdJRiNDLZ+2JHM/HtE78NZYix5y+Kld8ligNtjd378f04ZLn/8+lP
         8PkxqE9VsRGOklWQS6Im6Ci2PT0ZG9b1pdkJtVGYRYK76KwbW/6SUZHDUfAFfrB56rk7
         zZXkPv0+g50wJItxwK/VhZHoBzAxFLDQ9ftXroIp2W3Q++Y5a9hqbHonxhkXSYkv5pMl
         JhnpCaE0g7GNIcRafdJ2wcIxXGji/iciDOlEIjYy21MJKyoTludxnMArKl9ETHro44TZ
         +YyoyzezOsP/tKHRhGy2y4o71g8C5ScKJBKbqqpyogbsSpnWILYwpNsaipHmtyMlnu6s
         0PCA==
X-Gm-Message-State: AOJu0YxVCQmmAl9nPjzpPMhq7TKbsKRbTfxBpIDZRG+wBVui/5SwRFzz
        LsFitUHzEyjB/nb15MmIyj96rq6t8Vw=
X-Google-Smtp-Source: AGHT+IG+R6r6uVFSHt81A5+xmTYS0oUuXl/0ult+laZt34ylx/+aTK9Zt3AjV2HBBkCOd7bjp3PLTA==
X-Received: by 2002:a17:906:5352:b0:9a1:d79a:4190 with SMTP id j18-20020a170906535200b009a1d79a4190mr1603063ejo.2.1695926087816;
        Thu, 28 Sep 2023 11:34:47 -0700 (PDT)
Received: from [192.168.0.106] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906140700b009829d2e892csm11535641ejc.15.2023.09.28.11.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 11:34:47 -0700 (PDT)
Message-ID: <29dc3df5-f313-f194-7f73-3207215e0864@gmail.com>
Date:   Thu, 28 Sep 2023 20:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] staging: vt6655: Type encoding info dropped from
 array name "abyBBVGA"
Content-Language: en-US
To:     Pavan Bobba <opensource206@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZRWWcGiySdLbCM3z@ubuntu.myguest.virtualbox.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZRWWcGiySdLbCM3z@ubuntu.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 17:06, Pavan Bobba wrote:
> array name "abyBBVGA" updated like below:
> 
> a.type encoding info dropped from name
> b.camelcase name replaced by snakecase
> 
> Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba<opensource206@gmail.com>


A coverletter is missing.

I tested all three patches.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
