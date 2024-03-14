Return-Path: <linux-kernel+bounces-103232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A087BCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21DA1C213FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E458A6F520;
	Thu, 14 Mar 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="LafwZSN5"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61394691
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418994; cv=none; b=mNhuv8zWCpnExhCTFntRbOSc0xPhrt5X6032f3vh1Fyn0G9x7xAHOlNkEHIJ0UQbU9ofslv2n2TxCup/fvKdUMZ+DGWcFiF/5afoOUr1k1TyUcwVEqWdo1hZ0sbQJHiIchsBmx9vDfB4X2zhAFFCoo4Xf5cgXKHPzt32rDfuL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418994; c=relaxed/simple;
	bh=GpqYI0gyK4Opn2pfYF2VGSNALl2Ym8Vov9yKvg+WUYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDbQL61DY0AdD57GRq6+04uFiyHZTljJPJs4XBX/ARLteWzDI6FY+dlzXlzJ65pFYSBRDeTyIARs6Vy3hZuzjcgn/hhhqv8glXXV64OhZAbTCXQoi9ooXx9F6ox/6VUY3+qUNJxnijjzr9bScaHUdhKV1UxannJd5ZVTPDV1fNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=LafwZSN5; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C50CF11F9AA;
	Thu, 14 Mar 2024 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1710418982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=ANh2zigzfjMl+2rZIn2BGwf6KNQ9gCM1HpjNkKiuPCM=;
	b=LafwZSN5rEefY+3lWZGQupNVIAK0j0gd/h4w+Pm+JhdCMO0BKu7w9Ht2hE/ccwuAtAm58D
	KSyQSD88yWacpx9cH9TKUoD63fFGyKaIjWFxJFMq3QPsotmj13WNnDhOFZHcshP3IgmTwd
	hEPkpMqh6IssEUUVbmnhcIr+RF8xp2Z7ipcsQTSMqiRapT+Ypz7wboyMz/Znck1TijV2Iu
	qRUAHvz4zKfsDSuTqL14v1cNks4+rEo/CWJBTKksVHKuWPJohA2aEceiTVatHrKxkNBBS+
	LBuiuZh55nYVlj9qDu1TTbBfJLERO4X0JtA2MnmjBkKBxM18vvg4wQjnKSAPiA==
Message-ID: <9292d2ee-138a-4a59-9c96-31c1b4473a4e@lexina.in>
Date: Thu, 14 Mar 2024 15:22:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic
 secure-monitor SoC Information driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240314070433.4151931-1-adeep@lexina.in>
 <20240314070433.4151931-3-adeep@lexina.in>
 <111346d3-8357-4ca3-9249-a43ebc225fcb@linaro.org>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <111346d3-8357-4ca3-9249-a43ebc225fcb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi!
Thanks for review.

14/03/2024 10.11, Krzysztof Kozlowski wrote:
> On 14/03/2024 07:59, Viacheslav Bocharov wrote:
>> Amlogic SoCs have a SoC information secure-monitor call for SoC type,
>> package type, revision information and chipid.
>> This patchs adds support for secure-monitor call decoding and exposing
>> with the SoC bus infrastructure in addition to the previous SoC
>> Information driver.
>>
>> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
>> ---
>>   drivers/soc/amlogic/Kconfig               |  10 ++
>>   drivers/soc/amlogic/Makefile              |   1 +
>>   drivers/soc/amlogic/meson-gx-socinfo-sm.c | 192 ++++++++++++++++++++++
>>   3 files changed, 203 insertions(+)
>>   create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index d08e398bdad4..82fc77ca3b4b 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -26,6 +26,16 @@ config MESON_GX_SOCINFO
>>   	  Say yes to support decoding of Amlogic Meson GX SoC family
>>   	  information about the type, package and version.
>>   
>> +config MESON_GX_SOCINFO_SM
>> +	bool "Amlogic Meson GX SoC Information driver via Secure Monitor"
>> +	depends on (ARM64 && ARCH_MESON || COMPILE_TEST) && MESON_SM=y
>> +	default ARCH_MESON && MESON_SM
>> +	select SOC_BUS
>> +	help
>> +	  Say yes to support decoding of Amlogic Meson GX SoC family
>> +	  information about the type, package and version via secure
>> +	  monitor call.
>> +
> 
> I wonder, why do you need socinfo driver per each SoC? Usually it is one
> or two per entire arch.

We use this driver for GX and almost all newer SoCs from AmLogic 
(similar to the original meson-gx-socinfo).
In the fourth patch, this driver is specifically enabled for the GX, G12 
(g12a, g12b, sm1), AXG, A1 families.

> 
>> +
>> +static int meson_gx_socinfo_sm_probe(struct platform_device *pdev)
>> +{
>> +	struct soc_device_attribute *soc_dev_attr;
>> +	struct soc_device *soc_dev;
>> +	struct device_node *sm_np;
>> +	struct meson_sm_firmware *fw;
>> +	struct regmap *regmap;
>> +	union meson_cpu_id socinfo;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	/* check if chip-id is available */
>> +	if (!of_property_read_bool(pdev->dev.of_node, "amlogic,has-chip-id"))
>> +		return -ENODEV;
>> +
>> +	/* node should be a syscon */
>> +	regmap = syscon_node_to_regmap(pdev->dev.of_node);
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(&pdev->dev, "failed to get regmap\n");
> 
> Syntax is:
> 
> return dev_err_probe()
> 
>> +		return -ENODEV;
> 
> Anyway wrong return code, use the real one you got.
> 

Thanks!
I'l fix all dev_err&return calls to this helper.

>> +	}
>> +
>> +	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
>> +	if (!sm_np) {
>> +		dev_err(&pdev->dev, "no secure-monitor node found\n");
>> +		return -ENODEV;
> 
> -EINVAL

Fixed.

> 
>> +	}
>> +
>> +	fw = meson_sm_get(sm_np);
>> +	of_node_put(sm_np);
>> +	if (!fw) {
>> +		dev_info(&pdev->dev, "secure-monitor device not ready, probe later\n");
> 
> No, you never print messages on deferred probe.

Fixed to dev_dbg like in dev_err_probe.

> 
>> +		return -EPROBE_DEFER;
>> +	}
>> +
>> +	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo.raw);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (!socinfo.raw) {
>> +		dev_err(&pdev->dev, "invalid regmap chipid value\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
>> +				    GFP_KERNEL);
>> +	if (!soc_dev_attr)
>> +		return -ENOMEM;
>> +
>> +	soc_dev_attr->serial_number = socinfo_get_chipid(&pdev->dev, fw, &socinfo);
>> +
>> +	soc_dev_attr->family = "Amlogic Meson";
>> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
>> +					   socinfo.v1.major_id,
>> +					   socinfo.v1.chip_rev,
>> +					   socinfo.v1.pack_id,
>> +					   (socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
>> +	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
>> +					 socinfo_v1_to_soc_id(socinfo),
>> +					 socinfo_v1_to_package_id(socinfo));
>> +
>> +	soc_dev = soc_device_register(soc_dev_attr);
>> +
>> +
>> +	if (IS_ERR(soc_dev)) {
>> +		kfree(soc_dev_attr->revision);
>> +		kfree_const(soc_dev_attr->soc_id);
>> +		kfree(soc_dev_attr);
> 
> That's a double free. This was not tested.


Please, describe the problem.
I don't quite understand what the issue is:

- kfree() releases memory allocated with kmalloc()
- kasprintf() allocates memory using kmalloc_track_caller()

Technically, I see no difficulty in freeing the newly allocated memory. 
In case of memory allocation issues in kasprintf, we would just get 
NULL, which kfree should also handle properly. Considering that we don't 
need soc_dev_attr anymore, we don't need to worry about the contents of 
revision and .soc_id.

I see that kfree_const has crept in by accident, which is essentially 
needed here only if we replace kasprintf with kasprintf_const for 
soc_id, but it does not introduce any erroneous behavior.

> 
>> +		return PTR_ERR(soc_dev);
>> +	}
>> +
>> +	dev = soc_device_to_device(soc_dev);
>> +	platform_set_drvdata(pdev, soc_dev);
>> +
>> +	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected (SM)\n",
>> +			soc_dev_attr->soc_id,
>> +			socinfo.v1.major_id,
>> +			socinfo.v1.chip_rev,
>> +			socinfo.v1.pack_id,
>> +			(socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
>> +
>> +	return PTR_ERR_OR_ZERO(dev);
>> +}
>> +
>> +
>> +static int meson_gx_socinfo_sm_remove(struct platform_device *pdev)
>> +{
>> +	struct soc_device *soc_dev = platform_get_drvdata(pdev);
>> +
>> +	soc_device_unregister(soc_dev);
> 
> If you free the memory in probe() error path, why you did not decide to
> free it here as well? It is symmetrical, so this should make you wonder
> - error path is wrong.

This is something I can easily explain:

In the case where we have successfully registered with 
soc_device_register, we clean up everything that was manually allocated 
and not used.
In the case of unloading the driver, the cleanup should be handled by 
the soc_device_unregister command.

Technically, it's not possible to insert memory release because until 
the command is called, the driver is active, and afterwards, there's no 
guarantee of the pointer's validity.
Perhaps it would have been better if soc_device_register copied the 
entire soc_device_attribute structure and took care of memory allocation 
and release itself, then we could comfortably free any excess memory 
back in _probe.

Are you currently recommending not to release memory within the if 
(IS_ERR(soc_dev)) section?

-- 
Best regards
Viacheslav

