Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5E7DABC1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 09:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJ2INZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2INX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 04:13:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB199C9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 01:13:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso11523901fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698567199; x=1699171999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N3IEgtU7JR8WKcBUVeE1FIaoHBFT1S6Y8xwuqLUGT4c=;
        b=XLAxMuELYv89gzYOyelgoT9QdONoxobJWrB1j5aDxZhmpzY/stwkpAJCxQXGnzfG6W
         IF5ix3pSINBavYexepxNrVGT4140QKZ0D8vc9MXCA+trkEdmgTc5NQ7ZzuiD+j5tGzy6
         1y7t9oWF3+e4Vpv5zYVnJ+hpp6NdKdg5NMMCwlBuz7KnyG+akB2/T/wI/C2o1o4UO2P4
         oyKS1AI4adL9PnXRzznOrgO2e1026SR5eGvlO0La0kw7OgobTduP6xd4ndkNSAwkG+kg
         gsNmPFHCqo3rO6YCGbBjeMH3CmAo5o3WY8Gg5qiCiIeUEZpRU2PGzEhMBaSQtzTN3R+x
         WFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698567199; x=1699171999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3IEgtU7JR8WKcBUVeE1FIaoHBFT1S6Y8xwuqLUGT4c=;
        b=jr/7fCGDBXUTD/qyMZeOPSRTpRigccEnCNoHbBT3YUoJ3Lsn2wzkESJSI+wPweaZ/8
         ZEpN6zYuIn/kiw1zRTe4BzZjOe+eskG/pNE+vke8bV6aVkN+trFyMVe7AUMBMp+mh57b
         e4QwXJx0omvd3mc+9sRorlPI8ZfxKHiPd6rxU0Lj/fgWtYu1yOuFgM4IyTZnSbZIQeF7
         rHgJy/AX2N4jjT1oixk5pLwzYW0KxatbTWBI5jRiTnZtuDkU+uo28F9T+C7Tahh2i2iF
         9yRlMh59w5OH14rqvoQbV9eZcS/qbEBHVyw7JAF35qmQ6dOnHCNdXazdVfm0JaoB7MQv
         9org==
X-Gm-Message-State: AOJu0YxJ7O9LQU/rGMvOnHPRWipRPciK7Gpe0Ia4DsZ0ExNJZSZiDy/4
        6sCK4qslCf0g4whPgBz/SLV4RsW8XNY2rhntKko=
X-Google-Smtp-Source: AGHT+IETMGgkdG5/NVtK91Lv/Qf58GV0j5iwZR1ZSq7O3PKsY64DKQ+8Il1RSGc9RxV4tD4lg4iJQw==
X-Received: by 2002:a2e:9457:0:b0:2c5:a5ef:abad with SMTP id o23-20020a2e9457000000b002c5a5efabadmr5461485ljh.22.1698567198692;
        Sun, 29 Oct 2023 01:13:18 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9b97000000b002c50c93b053sm794496lji.61.2023.10.29.01.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 01:13:18 -0700 (PDT)
Message-ID: <5f685552-4bbf-480a-b1d7-9573b554dcdc@linaro.org>
Date:   Sun, 29 Oct 2023 09:13:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
To:     jrodrigues <jrodrigues@ubimet.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231027211548.21a6cee7@pcn112>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231027211548.21a6cee7@pcn112>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 21:15, jrodrigues wrote:
> 

1. Drop stray blank line
2. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC (and consider --no-git-fallback argument). It
might happen, that command when run on an older kernel, gives you
outdated entries. Therefore please be sure you base your patches on
recent Linux kernel.

Your patch will be ignored since you did not send it to anyone :(


> TQMa7x (revision 01xxx) uses a different (LM75A) temperature sensor.
> The two sensors use different I2C address, so we can set both sensors
> simultaneously.
> 
> Signed-off-by: João Rodrigues <jrodrigues@ubimet.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> index fe42b0a468..b87560d037 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> @@ -128,7 +128,14 @@ vgen6_reg: vldo4 {
>  		};
>  	};
>  
> -	/* NXP SE97BTP with temperature sensor + eeprom */
> +	/* LM75A - temperature sensor, TQMa7x 01xx */
> +	lm75a: temperature-sensor@48 {
> +		compatible = "national,lm75a";
> +		reg = <0x48>;
> +		status = "okay";

Drop status.

> +	};
> +
> +	/* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
>  	se97b: temperature-sensor-eeprom@1e {
>  		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
>  		reg = <0x1e>;
> --
> 
> The differences in the ICs are shown here:
> The TQMa7 manual only references the latest version
> https://www.tq-group.com/filedownloads/files/products/embedded/manuals/arm/embedded-modul/TQ-Socket/TQMa7x/TQMa7x.UM.0203.pdf
> in section 3.2.4, while the board manual
> https://www.tq-group.com/filedownloads/files/products/embedded/manuals/arm/carrierboard/MBa7x/MBa7x.UM.0101.pdf
> in section 4.1.2 references the old version, introduced by this patch.
> 
> I have tested this change in a board which uses the TQMa7x
> module, and with this patch we always a temperature sensors available.

This does not look like patch at all... Patches are created the easiest
with b4 or git format-patch.

Best regards,
Krzysztof

