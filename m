Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410257A8E68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjITV1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjITV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:27:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD11E5;
        Wed, 20 Sep 2023 14:26:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1ff5b741cso2098585ad.2;
        Wed, 20 Sep 2023 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695245218; x=1695850018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OW1bCapNnc1pk804XZRkkc9oHw8Yk6bRTQr+o6NDMqY=;
        b=Edq/jF3IDa3RTxb0IdCYRb9uFq9vEeOWU0lXDn7+NkfsuniJh/izyZTTa0uB7TeD6H
         UI7flZ34QQkINvEOOycvFhQT0JT0HJW6PuS4rNg/RiZO6AsX+lT7QUAR7lkrggFc+uTG
         fJ/NRIsUJUE28fWX1X6dOuulYShumLmc2maZRwAFYdGVGTFguRf2AsOvL2BuRDAS1APu
         ZAfJcGrT566sdz/6uxMrzQrxtPBlwSv5XW2JmfIsLGXVUgF1xtjDT7qq5qT0IToduBrI
         zDziY1VkuxbDKcSebZwAqTSwNChpiQplFZa1wuk7yd8n13PTdQvy8mWbSI/Px5JgbEAw
         S/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245218; x=1695850018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OW1bCapNnc1pk804XZRkkc9oHw8Yk6bRTQr+o6NDMqY=;
        b=RrTyzMCKsFyT/EWStB+I4kwTdhHmMK8rBpjglpiTchmFcq2G9IQgL/AI2y4DJIu0K+
         oAgsnOPJS8PHz3RInyq0dc6YiGZ8P3+DE2S04FJUe2wgLEBTKVjR69NmGYefnU0fnSrb
         dV4wxNQl2pkoTldhhFvYWdHWXSzsJSM65I6pBqVP8K8roxK4Qd02t9WlVCFGyIlAvXRV
         q5kZmA9WvjCxC+XU2OxEQ7TFHFBuv6lZ8zvBBi1e4MLvtSJE5T7zocw1u9YmIAfkLCqQ
         8tIdcX77Gt95CG+acpcOdkQh65rwuHX0i/jFHx/Pco04M2zpm1sS55UtdRzYM3JjjPiw
         +X5Q==
X-Gm-Message-State: AOJu0YxEc3qUqbt+74e5ZxUnv0e8wfpTaGGEBt2whSKtLChsSBph/F/D
        /Yd5Gj7FNttguSrMr5lGDgs=
X-Google-Smtp-Source: AGHT+IGxQgG724Kp+Ls03txNsv0GZaXgxL1G1SYNw1KTDuPn8lU1gPwHqtMo2lhhvLrVOt0ZXch4Dw==
X-Received: by 2002:a17:902:7202:b0:1bb:77a2:edda with SMTP id ba2-20020a170902720200b001bb77a2eddamr2751222plb.36.1695245218001;
        Wed, 20 Sep 2023 14:26:58 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170902c10900b001b9d7c8f44dsm10936885pli.182.2023.09.20.14.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:26:55 -0700 (PDT)
Message-ID: <12861f5b-a618-fc78-a0c2-05c2aab326f3@gmail.com>
Date:   Wed, 20 Sep 2023 14:26:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] net: cpmac: remove driver to prepare for platform
 removal
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-6-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920201035.3445-6-wsa+renesas@sang-engineering.com>
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
> AR7 is going to be removed from the Kernel, so remove its networking
> support in form of the cpmac driver. This allows us to remove the
> platform because this driver includes a platform specific header.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

