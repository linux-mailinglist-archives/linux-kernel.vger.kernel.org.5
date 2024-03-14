Return-Path: <linux-kernel+bounces-102919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672387B857
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A83A1C20F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C6E17BB6;
	Thu, 14 Mar 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdyZVyja"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0317BA0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400326; cv=none; b=pKAlwd6Gz+A0+8DRSeqFsMAvjEdfo1zJZS9Dd6o5YcoyrzoHDUJnfmPA+rKWAZqezISD6Hjz+vaHIOnaSmGe2FGJe7STDLt6DCLdBdrAFsjCjKYviFXAwMylFr3di5xVYgYHQ3CleruWN5v98gODKjj1Ky/BEi40PuXNhPGTrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400326; c=relaxed/simple;
	bh=BPrV9jTl3t9cZJ9doXOoiYwziihg/zLAKhGnYVrtRAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMNIEauaOyBvhcQr5BD43ZN1oai1hivayM16KwyDFKQvPWFn9nknxzu6W1xryG7y1ILvJSvOoN9JZi56DeIDr7hhQF4VotPfZHFOYku3zf3+mDjFJru8au2FIcKeEtMwWV2gf0JSnB26CRNbDadV1BYWbJG5rS2VYxrlvFuylVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdyZVyja; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512b3b04995so658457e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710400322; x=1711005122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0w6EcVUBOZCiyEEemWiI1OO3Qe7bW7Ap5u/rGycFcww=;
        b=OdyZVyjaxDEpiu/CHvcciXoyBlhDA9B3mg7p/IP6mSFg53u6m8A0wLHoom/UaM3nry
         ri0u4Q2st4375mnldpaF3UfbCC60x0t4jv2tfp+8GDdOMLJqtGgWbqDdjYkf2DyPQQtv
         ewzZXdFuj7cd4hM5kXHIsGq3A2me5SLYOon+CdYbZMrrGtEdm08M6FbAAX1q/pQ7qt20
         KB3yIRSq4/DqKXey080lbkoFSyySjBLBFXkhVlQuzN8t1m1b3PEZlXOPUUQC8ZH32kpi
         Ff+oyxxi+PY64Tx+VTxI/q0pi0m/GGrXgkjs9BSuOfnNuKL11ZPs5FqSoIWVYTYbwILI
         eAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710400322; x=1711005122;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w6EcVUBOZCiyEEemWiI1OO3Qe7bW7Ap5u/rGycFcww=;
        b=DUHmhodsa5ycYECuSFv16Tqva8Xs9xEwrVONgvin8ne5HnCo5TaGOwDGZXw+QcyIdO
         9oJQh0xOIKR6CpQiTJ4BTSzqukMdelfqdZu5Btejida6rdfLHvGL9qxFrYjbOrj/C7WE
         QGJjv8pL8Zujmia1WTh1F+ZuIY5NemzJ2KE6WAeITAQCg55YDKRUeW34KBpoiZrMVoIy
         Z/hfvHstRsGgn8O339sNS/1FfJ0TrcGJr8/piOnE7pgjV0xlWzvnFk2XKz9ln4RtWUcx
         DZtNKugznHNH4v1mTkLoVBUWZ0sR3upWs4F3nPxRkIykojWjUgbqt2GrFnziuNJMjOri
         rBLg==
X-Forwarded-Encrypted: i=1; AJvYcCXPXc3GOij532b+gLSzH9NBg270N/C0bTyRLHy7xLF3FjlhANt3lUpgsCv5amkKydPHaOAEGydgi76EUHCVpkpexJ2FK4lkCtbCgccg
X-Gm-Message-State: AOJu0YyIbHQBJOR5Bi8w6/3H/K1fbGCt5JoD1ZiFfON704PI7WE5oKqC
	ZHlBEb8bmVQsMx6ZevYc9jTAvxzyZSIK/puRQbiyObrJDkfMS4AWZc/UlHOR3V4=
X-Google-Smtp-Source: AGHT+IHHuCXjlVqAPvOo3pvV9QnVZxcjFxB2DpUD+aYnuMg71L6L87M4W2YiwTyvB+SMgQbh548/JA==
X-Received: by 2002:ac2:5d48:0:b0:513:c996:84c3 with SMTP id w8-20020ac25d48000000b00513c99684c3mr433591lfd.53.1710400322275;
        Thu, 14 Mar 2024 00:12:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s19-20020a195e13000000b00513c1fecb6esm155297lfb.173.2024.03.14.00.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:12:01 -0700 (PDT)
Message-ID: <111346d3-8357-4ca3-9249-a43ebc225fcb@linaro.org>
Date: Thu, 14 Mar 2024 08:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic
 secure-monitor SoC Information driver
Content-Language: en-US
To: Viacheslav Bocharov <adeep@lexina.in>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240314070433.4151931-1-adeep@lexina.in>
 <20240314070433.4151931-3-adeep@lexina.in>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240314070433.4151931-3-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 07:59, Viacheslav Bocharov wrote:
> Amlogic SoCs have a SoC information secure-monitor call for SoC type,
> package type, revision information and chipid.
> This patchs adds support for secure-monitor call decoding and exposing
> with the SoC bus infrastructure in addition to the previous SoC
> Information driver.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>  drivers/soc/amlogic/Kconfig               |  10 ++
>  drivers/soc/amlogic/Makefile              |   1 +
>  drivers/soc/amlogic/meson-gx-socinfo-sm.c | 192 ++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c
> 
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index d08e398bdad4..82fc77ca3b4b 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -26,6 +26,16 @@ config MESON_GX_SOCINFO
>  	  Say yes to support decoding of Amlogic Meson GX SoC family
>  	  information about the type, package and version.
>  
> +config MESON_GX_SOCINFO_SM
> +	bool "Amlogic Meson GX SoC Information driver via Secure Monitor"
> +	depends on (ARM64 && ARCH_MESON || COMPILE_TEST) && MESON_SM=y
> +	default ARCH_MESON && MESON_SM
> +	select SOC_BUS
> +	help
> +	  Say yes to support decoding of Amlogic Meson GX SoC family
> +	  information about the type, package and version via secure
> +	  monitor call.
> +

I wonder, why do you need socinfo driver per each SoC? Usually it is one
or two per entire arch.

> +
> +static int meson_gx_socinfo_sm_probe(struct platform_device *pdev)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *sm_np;
> +	struct meson_sm_firmware *fw;
> +	struct regmap *regmap;
> +	union meson_cpu_id socinfo;
> +	struct device *dev;
> +	int ret;
> +
> +	/* check if chip-id is available */
> +	if (!of_property_read_bool(pdev->dev.of_node, "amlogic,has-chip-id"))
> +		return -ENODEV;
> +
> +	/* node should be a syscon */
> +	regmap = syscon_node_to_regmap(pdev->dev.of_node);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "failed to get regmap\n");

Syntax is:

return dev_err_probe()

> +		return -ENODEV;

Anyway wrong return code, use the real one you got.

> +	}
> +
> +	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
> +	if (!sm_np) {
> +		dev_err(&pdev->dev, "no secure-monitor node found\n");
> +		return -ENODEV;

-EINVAL

> +	}
> +
> +	fw = meson_sm_get(sm_np);
> +	of_node_put(sm_np);
> +	if (!fw) {
> +		dev_info(&pdev->dev, "secure-monitor device not ready, probe later\n");

No, you never print messages on deferred probe.

> +		return -EPROBE_DEFER;
> +	}
> +
> +	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo.raw);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!socinfo.raw) {
> +		dev_err(&pdev->dev, "invalid regmap chipid value\n");
> +		return -EINVAL;
> +	}
> +
> +	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
> +				    GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->serial_number = socinfo_get_chipid(&pdev->dev, fw, &socinfo);
> +
> +	soc_dev_attr->family = "Amlogic Meson";
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
> +					   socinfo.v1.major_id,
> +					   socinfo.v1.chip_rev,
> +					   socinfo.v1.pack_id,
> +					   (socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
> +	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
> +					 socinfo_v1_to_soc_id(socinfo),
> +					 socinfo_v1_to_package_id(socinfo));
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +
> +
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr->revision);
> +		kfree_const(soc_dev_attr->soc_id);
> +		kfree(soc_dev_attr);

That's a double free. This was not tested.

> +		return PTR_ERR(soc_dev);
> +	}
> +
> +	dev = soc_device_to_device(soc_dev);
> +	platform_set_drvdata(pdev, soc_dev);
> +
> +	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected (SM)\n",
> +			soc_dev_attr->soc_id,
> +			socinfo.v1.major_id,
> +			socinfo.v1.chip_rev,
> +			socinfo.v1.pack_id,
> +			(socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
> +
> +	return PTR_ERR_OR_ZERO(dev);
> +}
> +
> +
> +static int meson_gx_socinfo_sm_remove(struct platform_device *pdev)
> +{
> +	struct soc_device *soc_dev = platform_get_drvdata(pdev);
> +
> +	soc_device_unregister(soc_dev);

If you free the memory in probe() error path, why you did not decide to
free it here as well? It is symmetrical, so this should make you wonder
- error path is wrong.


Best regards,
Krzysztof


