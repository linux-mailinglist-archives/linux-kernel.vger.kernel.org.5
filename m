Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662B07A35B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjIQNfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjIQNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:35:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004B1130
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:34:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so482520666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694957694; x=1695562494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWOIwMaeelG56oTd3igAqYlGt4sv3Gxn9NfbjC0dhrM=;
        b=M3xEsxGGjdSkLxr3X2EF7ErI1uoF0Di5NB84GGs4psFbywtxK3zWEi1gF8jO6rpdFo
         Tl256yh/7KIx7K4fo8gppuROm0wlDhQA7wt+1QtXRZP6s9tPVS12kQ0svDozlz7lZHwE
         vx7TbsLRf/VwXa1EN9JiBOcIh3d4FglrU+JTogEAqCGBLN8/Cfh0yqYCbRWlr8QuTicZ
         BR3U8u6mb0gmusPKt+kC6bDDEPR02tT4GHOHK01CisxsW2fy7kRoHSAIOqtxuCFJtaiQ
         YFLMLmOgBCus1JFb8VeNmKwjVW6tFUlumymR/803+NaS3Gt1y3H5lXgcxZzd6RXjH4B6
         9W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694957694; x=1695562494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWOIwMaeelG56oTd3igAqYlGt4sv3Gxn9NfbjC0dhrM=;
        b=wK5RQ2xX3HiUtX2OqKOWs6aOMt+jgjoqDUeQJUJe9Hgy6pPWNJ90Yn+6Gt4r6vMMSR
         Gd1QY+3vmxDG/1YKa60rPcO5NnkupnC/xBOjvUy/pjxKCYK0Qsqw4EcfHqRNFi8iXCtk
         ZKEBQEol3hG5TrpEFr7cS1be04MuHLhVLli73edwO4IydKRhu9ojx4YUD3Utj3TOvjLf
         tmp9U7HSHwTNMd+c4lFZ5elwilIGs3FKPFh7Ri7Yw0FqHxyS8esGu2J+LXlHgsJCB6M+
         C8Gf4r+FuxIKez146I6amVjDhcvzQqHQ6rAUGpD81UdQrQ1VPMtQOEt4/OR3xxl0nJzD
         /N5Q==
X-Gm-Message-State: AOJu0Yw2LQsg1KZpH4l2aXVVteDADiM6aeGyxLFxp8YYJuymLtYv+hg3
        bGiq4qa9aaA00bmLB7RxnkAAzQ==
X-Google-Smtp-Source: AGHT+IFq1DuC8gVGOM1KafgMnOTrYOWZ1O+GOqJSVrbBxJ0CpnfT0kqwQclDZm45Cul5QAxfbC+i1A==
X-Received: by 2002:a17:907:7856:b0:9a1:edfd:73b2 with SMTP id lb22-20020a170907785600b009a1edfd73b2mr5448628ejc.2.1694957694496;
        Sun, 17 Sep 2023 06:34:54 -0700 (PDT)
Received: from [192.168.69.115] (ric62-h01-176-170-218-28.dsl.sta.abo.bbox.fr. [176.170.218.28])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b00997d7aa59fasm5090745ejp.14.2023.09.17.06.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 06:34:54 -0700 (PDT)
Message-ID: <72722f5d-0d11-e25f-e33e-1d898e422919@linaro.org>
Date:   Sun, 17 Sep 2023 15:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] Kconfig: add dependencies of POWER_RESET for mips
 malta
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com,
        linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net
References: <cover.1694865711.git.tanyuan@tinylab.org>
 <413b332868bac086c32b7486a7cb9c6fc81c15c0.1694865711.git.tanyuan@tinylab.org>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <413b332868bac086c32b7486a7cb9c6fc81c15c0.1694865711.git.tanyuan@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/9/23 14:07, Yuan Tan wrote:
> MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
> POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
> for convenience.
> Then regenerate malta_defconfig with 'make savedefconfig'.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I haven't suggested that, just reviewed your patches, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

(I don't remember Christophe suggesting this either)

> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>   arch/mips/Kconfig                 | 3 +++
>   arch/mips/configs/malta_defconfig | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index fc6fba925aea..b63a93e39f23 100644
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
> diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
> index 7ae07d57b79a..99049e993192 100644
> --- a/arch/mips/configs/malta_defconfig
> +++ b/arch/mips/configs/malta_defconfig
> @@ -192,7 +192,6 @@ CONFIG_CFG80211=m
>   CONFIG_MAC80211=m
>   CONFIG_MAC80211_MESH=y
>   CONFIG_RFKILL=m
> -CONFIG_PCI=y
>   CONFIG_DEVTMPFS=y
>   CONFIG_CONNECTOR=m
>   CONFIG_MTD=y
> @@ -284,7 +283,6 @@ CONFIG_MOUSE_PS2_ELANTECH=y
>   CONFIG_SERIAL_8250=y
>   CONFIG_SERIAL_8250_CONSOLE=y
>   CONFIG_POWER_RESET=y
> -CONFIG_POWER_RESET_PIIX4_POWEROFF=y
>   CONFIG_POWER_RESET_SYSCON=y
>   # CONFIG_HWMON is not set
>   CONFIG_FB=y

