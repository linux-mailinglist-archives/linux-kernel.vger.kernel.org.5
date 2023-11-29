Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD80E7FD010
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjK2HqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2Hp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:45:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9F1710
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:46:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3331974c2d2so139764f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701243964; x=1701848764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yN+tUdd9HKDL5IxRS3qriGU+Y1r/NfH7A0nKJ7ANPiw=;
        b=wYOhHE0nVE68Kb7iiUww+UIln55znOnEo+V/sLENFNLJKdsS7PVR+4X+yyh7bbwUak
         wspfPNwW4jOeyM3Zuwq8GgQIw9ON+VzezSSdbmQRKGxRY+n11Kbf1+OsXUyPm5FwHHNF
         U9fMMDlksMgjiMGgPxIDDRsXvqdcr/pLBpShsAKSyl1zde7wMALVeQHzLXMWuqFHql8A
         bzSVHSk5PwNmFlWZi8bLn/2R8tmzlJK9iiKsOSFT4J5SDLC8sBg20bibUfMm40ANQsSE
         oVSxSK576EtA0fMx2JjaQCCVb5aaSp+Dck43c/gUXkHN01gY30tRIorbBPYBxMTRvIJq
         qqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243964; x=1701848764;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yN+tUdd9HKDL5IxRS3qriGU+Y1r/NfH7A0nKJ7ANPiw=;
        b=RvRIvowWtebyjqWu0fs8hINtIaH+1qmpGjEo2FKmqlrin7UACze8f6urox9ZE4PdE9
         4MMhaPOsVLPIC+9viVpD95NcWcrqWQTKX/WHIOUpjwDafN39SaiEoUccC5pldhUDj/89
         HCXvRngaMfiizs35lB4EoUyUupnVyiJobAvrANR/XbWe1i/LIRo5w+3bvKK4XKN9DnpQ
         IcCOXk0dYQf4IgvUk7mjJO3GZuB6SN3XWBsPD/45UnSmumk2dEzAITKKw8biOLcfRhRg
         D7++xB4ffd8fp1/VAvBtIM3wUR5XcKLjzfUATxCrH7cPW1Epa+4II/Ie51epGH+zUCoj
         jKxA==
X-Gm-Message-State: AOJu0Yw5o4Xv99FrY2FBHQgKLtOMTV6hyD/zyscH6N82JftbWHm1vUHf
        Zyo9vo2553TOLrIn4F4tOHdsSw==
X-Google-Smtp-Source: AGHT+IEZvxP6pS9h2j8jtvDdPYUEovMoR8W9UmelKPapkGQD84xi4FuUfLE7t+kF/Bgeqj7DCMUC1g==
X-Received: by 2002:a5d:464f:0:b0:32d:a54a:f57c with SMTP id j15-20020a5d464f000000b0032da54af57cmr12396758wrs.25.1701243964350;
        Tue, 28 Nov 2023 23:46:04 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b00332cbece829sm17137026wra.59.2023.11.28.23.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 23:46:03 -0800 (PST)
Message-ID: <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
Date:   Wed, 29 Nov 2023 07:46:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
Content-Language: en-US
To:     AceLan Kao <acelan.kao@canonical.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231129064311.272422-2-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 06:43, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 

Hi,

> When the software reset command isn't supported, we now stop reporting
> the warning message to avoid unnecessary warnings and potential confusion.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

You haven't specified who shall take these patches. Is it fine for you
if I take just the SPI NOR bits? If you want Mark to queue both:

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> ---
> v2. only lower the priority for the not supported failure
> v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only
> v4. move the version information below the '---' line
> v5. remove dev_warn if soft reset operation is not supported
> ---
>  drivers/mtd/spi-nor/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 87cb2047df80..96a207751cf2 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3237,7 +3237,8 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
>  
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		if (ret != -EOPNOTSUPP)
> +			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
>  		return;
>  	}
>  
