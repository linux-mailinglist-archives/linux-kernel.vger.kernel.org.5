Return-Path: <linux-kernel+bounces-95407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95999874D45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366A71F2526F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B71292FC;
	Thu,  7 Mar 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp0rPK08"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAB128812
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810404; cv=none; b=jg/pxXu6txCRG05QW4uQb47SoJf3r2j0iTD5ZrwXNM2Yo9pm0UhlYirnagtYtF2xKFKo7EIG12sr80WLZFZ+7vaV0V2qXDUhi5t2JmNfhWBAsk0xS53o+r/q8swSV76HldqGFQ0B8JmIy5VAQfIxIJh5PFwUj+ANM/ZCEU1kX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810404; c=relaxed/simple;
	bh=DfswE7HJLLqy77GWnPiVArfI05VtoLAEZZ8wtl2bLVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blKMuy+xCr0OE0LX6igEGgPxaI34EHbK/5+fe8b946W0LeQ6EExUX/8M89h11oKK0++UX78LePPFkhY7wM9rpd1Gfx3XXs7NBiBxekFiaxze5u6DoRJa96fLh68MYd4ujy7K0yGvadNVZ47fMtxOCWCDrG3XOb2CDQutwq5sydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qp0rPK08; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso9407911fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709810400; x=1710415200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTSBVVVJ5YriwXW83Xu49WC7Hj5VHh4fFgiqujVWr9o=;
        b=Qp0rPK08swaXH27iS0DcRBQgAvckoR8HEpAoYS75USBCO417zqthTf/8gr09pzXI4p
         uAxVuczpD7demMAmO9HaWD0yfB8mJ4HqDtDv3vGdDFZSTlJ3OzpH7EzAQR95wlpbM9oR
         d4fLEFmDr1WWv7KDbD8S9gjCAQhFG6nrhA3ekE/8txkEPblhd8mY/SphVCwirZ1kgBXi
         s03TsrU4L9ByfepDDzgQb0Eq/E4PZZ1kZF0SNcVRvuKBRN8UalR8kKLC/hYGsZlOmgSe
         RfeF9Nm3vNdxPoT+IwZj1WiO9N+cAp75bsgodOTOvBEWSjmDky+HmXMJcFo7LoKO2XrR
         4irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810400; x=1710415200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTSBVVVJ5YriwXW83Xu49WC7Hj5VHh4fFgiqujVWr9o=;
        b=fJo5g9b6oi6klSbz1QQRYemB4dPpYud6smA9dCFcZeeZ8/edYcntDZZEF7hg9nF0kx
         10b7NwFch7WpLx7aHIYRAXtNyc+HorXfuyUvMby8INjtYQNmi8T3ApTdgmVED/hC/8y4
         7sBeGPVpi+zMjVS55ja+uxsgbT3ibvlTvykhUoTbXahKoN5/DgdjsJj1Zki1XIT+Nrkz
         Uppv4BjoD7GDMYEDsYmQ6QGlK2uAfj2J5EiMAdkKqUD/Qz5AX8jmC9tocp+q/GVgZypj
         E/RTIh0CkNWYr0zsov9AzqP3/d69VPruPYU03MufOzqOF1nm/U0JOok3b4yByj3PrD5V
         Vb8g==
X-Forwarded-Encrypted: i=1; AJvYcCV32kOucnbm21G4BNYUYSs8/rluMhVfnDPKTMvCamE9qi0DCAFM+/F8+RTJX7X7uGvxrSnP+fLEA+KXz6sawTUNyHOnfqQSdmpIsN/q
X-Gm-Message-State: AOJu0YwqQS6zkh4ZeBpeBsjf+DhRdszDqTKZKGh+B+SNg9eKvg2jZhAC
	Afc69xS9iJ+sA+xzIQRlFYrct0ckg8DsanQMM4Uwm39grQlQLyqVm9NR8/VdZa4=
X-Google-Smtp-Source: AGHT+IEJFP45iEkqRIJfjQVGnd9vf8NSboPCjm6h35YrqWvxgwSyal1JJf1HtYzDNDxj06EzP2Td4A==
X-Received: by 2002:a2e:6804:0:b0:2d4:5f4:dee with SMTP id c4-20020a2e6804000000b002d405f40deemr1190422lja.18.1709810400006;
        Thu, 07 Mar 2024 03:20:00 -0800 (PST)
Received: from [172.30.204.36] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s6-20020a2e9c06000000b002d38f36f3a4sm2003570lji.117.2024.03.07.03.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:19:59 -0800 (PST)
Message-ID: <afc709b5-4e4e-4308-a399-e0b521592250@linaro.org>
Date: Thu, 7 Mar 2024 12:19:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Enable BDF to SID translation properly
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/24 12:05, Manivannan Sadhasivam wrote:
> Qcom SoCs making use of ARM SMMU require BDF to SID translation table in
> the driver to properly map the SID for the PCIe devices based on their BDF
> identifier. This is currently achieved with the help of
> qcom_pcie_config_sid_1_9_0() function for SoCs supporting the 1_9_0 config.
> 
> But With newer Qcom SoCs starting from SM8450, BDF to SID translation is
> set to bypass mode by default in hardware. Due to this, the translation
> table that is set in the qcom_pcie_config_sid_1_9_0() is essentially
> unused and the default SID is used for all endpoints in SoCs starting from
> SM8450.
> 
> This is a security concern and also warrants swapping the DeviceID in DT
> while using the GIC ITS to handle MSIs from endpoints. The swapping is
> currently done like below in DT when using GIC ITS:
> 
> 			/*
> 			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> 			 * Hence, the IDs are swapped.
> 			 */
> 			msi-map = <0x0 &gic_its 0x5981 0x1>,
> 				  <0x100 &gic_its 0x5980 0x1>;
> 
> Here, swapping of the DeviceIDs ensure that the endpoint with BDF (1:0.0)
> gets the DeviceID 0x5980 which is associated with the default SID as per
> the iommu mapping in DT. So MSIs were delivered with IDs swapped so far.
> But this also means the Root Port (0:0.0) won't receive any MSIs (for PME,
> AER etc...)
> 
> So let's fix these issues by clearing the BDF to SID bypass mode for all
> SoCs making use of the 1_9_0 config. This allows the PCIe devices to use
> the correct SID, thus avoiding the DeviceID swapping hack in DT and also
> achieving the isolation between devices.
> 
> Cc:  <stable@vger.kernel.org> # 5.11
> Fixes: 4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Looks sensible..

Does switching away from bypass show any performance degradation?

Konrad

