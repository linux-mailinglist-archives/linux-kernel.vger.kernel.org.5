Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82BE772A17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHGQFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHGQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:05:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62B10C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:05:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so76021811fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691424343; x=1692029143;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3NRCQqXbUSCCrnt/9oEbb5aA3KgrkhtMfzTxdax6mo=;
        b=DcuLzHXQ3nc+8APwug6vkpTZHBbXaTio3nT5EOkFocbPjbgKovZOdK9cnlRPvNRL6/
         pUD/jwsoM155THkC0Z5H5klF1i8aPH3HZZ1hboqV4MAR7Z7lQ2esFRPgXwX9CU9CZyCJ
         0mgicKVZzzwhuDZrI2tIzAOwI7h/Pagd0DuZuolmmW3lAXL7LjdVuLBNKcI8fbV6x++T
         VInGiEaLBCv1Pmu523XUgSsqWkKowfP8Mr6KYzP565U0SRxwPoQ3aTE72ZWz2DbY0oI1
         yhE5cUoUiElPJYvF7Svb7VvCZg2nD+rYXgxeD38jrChX0wlGVUQV/cU0YqSW5uirNglA
         nSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424343; x=1692029143;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3NRCQqXbUSCCrnt/9oEbb5aA3KgrkhtMfzTxdax6mo=;
        b=BOGVDW152X5YuM4pEgMPpTsNPGz48UoIlyI6zgV+JbxskMHxPVNEvQSgYQNIVW0ZCl
         JRWQLiVc/Yl/sE7WVks1Yb0UR+5n/zSMIMNBUlgpy0lY3uc7prBt4bdmrIb1BRzAvWbJ
         vH9vz5LbRsUGyR+0jEipL8BSaX3wKgprwq/gB+Oajg6RFXPVsISI3ogF5XDzY1qOMVld
         hOODdyzW2wgSXkt/QEf2Mg7S72CaQ4fhFd+/wMTubi4sSiBkxaV7n+zDOHR7e3fFRCgA
         7mPAZh7xoLJbLpqbfaLtkf/JNFgd0r/2PP4Dc11m8O8tOJjY2CByNMCrl+v3W+uinhg1
         mKyw==
X-Gm-Message-State: AOJu0YwRX8M1NzlsRU10D2jtgjHuCZa1ek/LbrW/I4KhkLVQ1rVHFJtk
        QpeMqYG5udO0e1wLzoFreGsfMQ==
X-Google-Smtp-Source: AGHT+IFrZnmkbOq1VoMJWoNd8Q5ead/2nUoLqt46vZNA2VGEa4H5MCmc0wtEyHk6dF0qHjlSjUymWA==
X-Received: by 2002:a2e:a0cc:0:b0:2b9:ee3e:240c with SMTP id f12-20020a2ea0cc000000b002b9ee3e240cmr6846867ljm.24.1691424342886;
        Mon, 07 Aug 2023 09:05:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id e8-20020a2e8188000000b002b724063010sm1884883ljg.47.2023.08.07.09.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 09:05:42 -0700 (PDT)
Message-ID: <27bd3a9e-192f-43e9-b417-784c6d9c3ecd@linaro.org>
Date:   Mon, 7 Aug 2023 18:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add device tree for Xiaomi Mi 11
 Ultra
Content-Language: en-US
To:     wuxilin123@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-3-0c384e8b5737@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230806-xiaomi-star-v1-3-0c384e8b5737@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.08.2023 19:03, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add support for Xiaomi Mi 11 Ultra. This commit brings support for:
> * Front and rear display panels (initialized by bootloader)
> * USB
> * UFS
> * PCIe0
> * Thermistor sensors
> * ADSP/CDSP/Modem/SLPI
> * IR Transmitter
> * RTC provided by PMK8350
> * Buttons
> 
> To create a working boot image, you need to run:
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8350-xiaomi-\
> star.dtb > .Image.gz-dtb
> 
> mkbootimg \
> --kernel .Image.gz-dtb \
> --ramdisk some_initrd.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline "SOME_CMDLINE" \
> --dtb_offset 0x1f00000 \
> --header_version 1 \
> --os_version 14.0.0 \
> --os_patch_level 2099-12 \
> -o boot.img-xiaomi-star
> 
> Then, you can flash it to slot b on the device:
> 
> // You have to either pull vbmeta{"","_system"} from
> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
> fastboot --disable-verity --disable-verification flash vbmeta_b vbmeta.img
> fastboot --disable-verity --disable-verification flash vbmeta_system_b \
> vbmeta_system.img
> 
> fastboot flash boot_b boot.img-xiaomi-star
> fastboot erase dtbo_b
> fastboot set_active b
> fastboot reboot
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
[...]


> +&adsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8350/xiaomi/star/adsp.mbn";
> +};
Please keep status as the last property, everywhere.

BTW, is the rear screen connected via DSI, or is it some stupid
SPI display?

Konrad
