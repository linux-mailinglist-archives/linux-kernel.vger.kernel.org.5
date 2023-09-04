Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AA791264
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbjIDHk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjIDHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:40:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C4138
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:40:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1483947a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693813217; x=1694418017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQjKqdQjnv3PMe5OqcJ+jHGfcq2cLTpjtNSkHV3ltZw=;
        b=biBzFW+p66RCE+Y/ldLax4Ll4FzdOsd8Sm4WLlPZiYCrkvPR6Y9OMgrsf7lj1VtcBf
         ynF3bcQUaCOsSgNWyb571R7DQC/Wcrf0fqGeqiYjX9jkua7TBAeESlZYPZXLjUQxsahH
         LOKyOJxCuDFFzth9u8YUsI6OgXUyrZYFP+2xRC/ixDidZYppJJX4zLy4QkVFtxNP1OBE
         2qPNCIgFP0mSz/35Wpfg9zJFexlZeCaWdk2NXJkSS1PR38M1GYk2KOs+Dh1sntxb9aPd
         7DS66xFEkd0lH0GsqEwcP9lrjq3DKEK5y2IgeFsGpCMdKS8xKv8AQm0/3TDrOevrpPdj
         9YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813217; x=1694418017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQjKqdQjnv3PMe5OqcJ+jHGfcq2cLTpjtNSkHV3ltZw=;
        b=A2NUjjs+Ssf7hLaQKZ4z4eCgb6HVNCbOUyQ1i2GPJKnfhF2k2r2Kxo3UF66cve3HBy
         h5dIczx8U0ghXtM7OtDbXKT9Bzg9utOtYtNDTHYRqoB4gQwqFZSqYM4bOuPRC8b7+ccl
         rKRCi5YumXQOec8NGyiSIYlGbWt0URuS8ZjCOv7IGV5tYpH65b2iOTOu0jP2n3FV/Y2T
         nG4N03AvPwyu8FqxQb17VPUXUXBlGHWnjVIe6DvO/nAYC13cTHaYCePPtnRebWV9z03W
         CcDyRnIPb9zJlhjrLMz9xtyywtLO3dZzT/CFbw1AYu0ZNPSUY2JDBMklySZ+0NQ5l8Rr
         /jtA==
X-Gm-Message-State: AOJu0Yy+AfFtn3iIbroUIzGV08Fs6hpasrakN8MIEEQR9COWxFeo2N7I
        TQb8QiPqw4b3WOjXFXvCHQ5E4A==
X-Google-Smtp-Source: AGHT+IF+iT/dkRg4acU9/UI6JfKKp3ZeC5AsmWMXEg5lVCySIqfHTR3Hxy8Ffc+kE8/6092Ro6zdzg==
X-Received: by 2002:a05:6402:124b:b0:523:100b:462b with SMTP id l11-20020a056402124b00b00523100b462bmr7068044edw.5.1693813217425;
        Mon, 04 Sep 2023 00:40:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id d3-20020a056402516300b005256771db39sm5480392ede.58.2023.09.04.00.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:40:16 -0700 (PDT)
Message-ID: <915a9e2d-36ea-4a74-7b1b-9688f215b6f1@linaro.org>
Date:   Mon, 4 Sep 2023 09:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/3] kconfig: add dependencies of POWER_RESET for mips
 malta
Content-Language: en-US
To:     Yuan Tan <tanyuan@tinylab.org>, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, mingo@redhat.com,
        tsbogend@alpha.franken.de, hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1693535514.git.tanyuan@tinylab.org>
 <1c17f017d6c837ef887d08bd2f85102df3fbc17c.1693535514.git.tanyuan@tinylab.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1c17f017d6c837ef887d08bd2f85102df3fbc17c.1693535514.git.tanyuan@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/9/23 04:42, Yuan Tan wrote:
> MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
> POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
> for convenience.
> 
> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>   arch/mips/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index bc8421859006..13bacbd05125 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -547,6 +547,9 @@ config MIPS_MALTA
>   	select MIPS_L1_CACHE_SHIFT_6
>   	select MIPS_MSC
>   	select PCI_GT64XXX_PCI0
> +	select PCI if POWER_RESET
> +	select PCI_QUIRKS if POWER_RESET
> +	select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
>   	select SMP_UP if SMP
>   	select SWAP_IO_SPACE
>   	select SYS_HAS_CPU_MIPS32_R1

Shouldn't we also update the _defconfig files?
