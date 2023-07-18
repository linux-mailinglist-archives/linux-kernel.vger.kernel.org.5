Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03774758286
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGRQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGRQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:51:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1582199;
        Tue, 18 Jul 2023 09:51:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so61625585e9.2;
        Tue, 18 Jul 2023 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699111; x=1692291111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MN6YwH/Sg2GWW0btTszOmesTuh4cunm9Lg6HKMqqnCw=;
        b=egfysYxgLkUoEleL1gyoe/YSMlHqdSH48uaDD4e/3n+ywjtXgUQutVP+GXKZzMiku9
         SvXy2p5WOAoco6rrCaqJJp/Ik2oXBysd3Fs4clBrawSOPtl9y8elKKmU8+AhNwHGL6ne
         YC3F67N7Bu37kJBH/JYkH2DnzkznRTwAi1noYg3b2EyJ8KHMmltUKdqpcx3Ih3RJpMKy
         BjVJBu3V5HAP6Ge5mFZqDY8gcB3BRL+Rsbg+L0kTRQHNvFy9ypKUY3kaP//+QKpjVe5/
         YvbyKsyb/6xC1vC47PS4BTCmPBh+YS9BkuHrKnWoL2ehaBK8FJaFQTDZMhV9BqXs/GcT
         XsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699111; x=1692291111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MN6YwH/Sg2GWW0btTszOmesTuh4cunm9Lg6HKMqqnCw=;
        b=IBo5K5amqfMgbJMx2Og7gSWKYhj+5u7i4xypz61Qr4IfmJrY9G3g2Midr4zN2/PMs8
         laIKuVoiiMgYsdrLicyl5p4WZva8VG5ntKOikkJ1N1aES+b9G1KupAGNHfyeAuJX8n77
         IqhIXlTmkOpYthQVssV8yV01PaxL13CJoMZeG7k8Ap9YU8o/Tx6B3I4fM+X/mVCu1GAe
         DsEwGWF1etVHw8YmwjRBza3KavPcHfT+HMXJ3vEgV/cO3C4l1mDRNK/PQujTT1RDMMk7
         zt7w5dwFofwP9DXp/x9d7ikwR3L+T56/8ZLduNb2uGHEpld4ae07UZO2dcuku/PA59Kr
         1Hmw==
X-Gm-Message-State: ABy/qLYeSup6cdp7PIpYjOkPIegaeHl9Vjt6NZIQrUAYXg1rjODd+yqa
        iYT1mpG/R4BbPxhLmeUcLnc=
X-Google-Smtp-Source: APBJJlHOFvWvbot+HP++JP3fT3TaaKdoAq2pAqKoUA88Vosh8ICwrFeGwoU1pwkBqV7ju6n7ny7FzQ==
X-Received: by 2002:a1c:6a0a:0:b0:3fa:aeac:e96c with SMTP id f10-20020a1c6a0a000000b003faaeace96cmr2796662wmc.9.1689699111032;
        Tue, 18 Jul 2023 09:51:51 -0700 (PDT)
Received: from [192.168.70.38] ([37.174.75.194])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c261300b003fbb5506e54sm2568348wma.29.2023.07.18.09.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 09:51:49 -0700 (PDT)
Message-ID: <d3090a47-4bf9-4aef-34f4-6dc06198189b@gmail.com>
Date:   Tue, 18 Jul 2023 18:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND v2] staging: fbtft: ili9341: use macro
 FBTFT_REGISTER_SPI_DRIVER
Content-Language: en-US, fr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230718081759.28902-1-rgallaispou@gmail.com>
 <2023071817-enslave-unlovable-f8ae@gregkh>
From:   =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <2023071817-enslave-unlovable-f8ae@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 18/07/2023 à 15:33, Greg Kroah-Hartman a écrit :
> On Tue, Jul 18, 2023 at 10:17:59AM +0200, Raphael Gallais-Pou wrote:
>> Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
>> ultimately causes a warning when the module probes. Fixes it.
>>
>> Changes in v2:
>> 	- dropped MODULE_ALIAS changes
>> 	- changed commit log for more accurate description
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>   drivers/staging/fbtft/fb_ili9341.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Why is this a resend? >
> And the changes need to go below the --- line as per the documentation.

I messed up the first send and forgot the changelog.
Thanks for your insights, I understand now that I shouldn't have sent a 
'RESEND', but rather a v3 with a third entry in the changelog.

Regards,
Raphaël
> 
> thanks,
> 
> greg k-h
