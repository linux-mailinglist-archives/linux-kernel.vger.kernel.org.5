Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7537F785B08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjHWOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjHWOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:47:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E2E69
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:47:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so4738487a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692802057; x=1693406857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lttCoUpW+33nWPwSh/VvbJtmmiP9aE3qbjp47of8qLA=;
        b=XVSfLiuRLRXRjwIBYBvYTnKu/h/xG2mJ7V0rORmITY+tEWz5U1qaDvzAax2H1zZ0f8
         0x7N4NPX5EuSLlH8UJfLSYQRNXFEUlUqF1MYfSdpWXLQDf6+8gjDbKfetLlqNILzXDFB
         etHUxCnde9Hye40mLGcFfQ9DNVbSTExsiRshI0TzcJqK30w5xTyE0Fe0yQ+2sj09ufgu
         UZpzXpIdyHFVbyD/Vv5J4hG3XO8hhFTm8kf6vxrG0NqAWQNJKh5EDmjRpdRZUcsPM071
         lpC5brHIkvTyHbKp0lRWLhB+OdPohxue+b/VsB8gGBXQqJhb+HZkrny6HZvMGhX3eU2x
         +Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802057; x=1693406857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lttCoUpW+33nWPwSh/VvbJtmmiP9aE3qbjp47of8qLA=;
        b=MfcXYdth+pg2Fe5T0FDlzo6/wsuPr99dKRDtPCDQgQVn0TGjWglbAlmovwCSUoaObx
         NddS2I/FOgdJvr/FgVpFLLlqRrQTuIgqCl36v/L/3lEEC9AGZbMZ8lC8rXJnu1GYgTGi
         XP2AZ9YPsnYd3xq9P51A0IKj/m2ZJufO8rUN9TEG5U1zo45JD93xHysDYYYJP9cByqcZ
         d4CHuYrKR3utm4NyD9gFxLR7pwuL6d4TVPVq9I70QU6V5o/KkqAf/BNnwEXW3jUf8c3f
         7+5NMczE50R6m/Ihm/NME7W9cXCsyp6ImuOezMMu5AOci1H0P7d2f9qCbye8d7WeOtnr
         DKwA==
X-Gm-Message-State: AOJu0YzmPrIGRdp8TBHz3L3CmO+UZMAUxlMIwNI7iSTDz4y7xrT/xWdl
        hNX7mIZ4qB8JrhMiFP82cfRIklz43uAgdwt0LgA=
X-Google-Smtp-Source: AGHT+IEpcF9SwW9BgoGhzfnDWp6nVY70dMbEpFSWMxJ6LRPGYqflgbb8qyuqxwNro4p06uM5uTRQJA==
X-Received: by 2002:a17:907:a04a:b0:99c:4ea0:ed18 with SMTP id gz10-20020a170907a04a00b0099c4ea0ed18mr9027724ejc.8.1692802056960;
        Wed, 23 Aug 2023 07:47:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id c18-20020a170906341200b0099d9dee8108sm9959968ejb.149.2023.08.23.07.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:47:36 -0700 (PDT)
Message-ID: <7c3cd9b5-89cf-274f-a6e7-351ed2aaed2e@linaro.org>
Date:   Wed, 23 Aug 2023 15:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/22] nvmem: patches for v6.6
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
 <2023082329-impotence-escalator-61c5@gregkh>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023082329-impotence-escalator-61c5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2023 15:35, Greg KH wrote:
> On Wed, Aug 23, 2023 at 02:27:22PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Here are some nvmem patches slightly more than usual for 6.6 that includes
>>
>> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
>> - core level cleanup around error handling and layout creation.
>> - few minor cleanups across providers drivers to use better
>>    apis and a typo fix.
>>
>> Can you please queue them up for 6.6.
> 
> Better, but I don't have your gpg key, is it in the kernel keyring?

Its not in kernel keyring yet, I sent it out today morning for 
inclusion. But key should be some of the old keyservers though.

> 
> Grabbing thread from lore.kernel.org/all/20230823132744.350618-1-srinivas.kandagatla@linaro.org/t.mbox.gz
> Analyzing 23 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    ✗ [PATCH v2 1/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
>    ✗ [PATCH v2 2/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
>    ✗ [PATCH v2 3/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH v2 4/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
>    ✗ [PATCH v2 5/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
>    ✗ [PATCH v2 6/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH v2 7/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH v2 8/22] nvmem: qfprom: do some cleanup
>    ✗ [PATCH v2 9/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH v2 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
>    ✗ [PATCH v2 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
>    ✗ [PATCH v2 12/22] nvmem: add new NXP QorIQ eFuse driver
>    ✗ [PATCH v2 13/22] nvmem: Explicitly include correct DT includes
>    ✗ [PATCH v2 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
>    ✗ [PATCH v2 15/22] dt-bindings: nvmem: Add compatible for QCM2290
>    ✗ [PATCH v2 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
>    ✗ [PATCH v2 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
>    ✗ [PATCH v2 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
>    ✗ [PATCH v2 19/22] nvmem: core: Create all cells before adding the nvmem device
>    ✗ [PATCH v2 20/22] nvmem: core: Return NULL when no nvmem layout is found
>    ✗ [PATCH v2 21/22] nvmem: core: Do not open-code existing functions
>    ✗ [PATCH v2 22/22] nvmem: core: Notify when a new layout is registered
>    ---
>    ✗ BADSIG: openpgp/srinivas.kandagatla@linaro.org
>    ✓ Signed: DKIM/linaro.org
> 
> At least DKIM passes :)

> 
> Anyway, all now queued up, they pass my local build tests, thanks for
> fixing that up.

thanks for picking these up.

--srini
> 
> greg k-h
