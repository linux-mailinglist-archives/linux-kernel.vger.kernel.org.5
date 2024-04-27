Return-Path: <linux-kernel+bounces-161038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD28B462C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D87289C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A084D5AC;
	Sat, 27 Apr 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UprG36up"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7D1E52C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217816; cv=none; b=iebuiTQhD9hHNGlhSeR5f/Y9cR/MilR/yb0leWrSBZRe43Rwtfdf1XvK1inMFOdJgacxQqOOIWd02CKx6YDkM/6NJXViq2YRueiKzAWK+/HzuonLPd7TIc0VuXGGaC4Huv4UWbz3ElYYWNVv7zv2dzQdz49ND3qbyVeeuyP5TBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217816; c=relaxed/simple;
	bh=4ZrINV4KLgHRlvgk/hu79PRnd4meIKu7L4pWkSEktc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOiurmeAMRxLIN7XScGyTFvac9MGsnndqrfYSnusEu2FUbSIkSvlD5IB8qZx8TbrxCQsQsRO/L9MCHNZ9FNTrQgpNCuKV+FgUDEaio3s+ha9Dd5+1N7a+K4Bsy+4UL9mGjfPYjQuCC9Faxmbu4zisn72eSmxdlqDAKrITupJLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UprG36up; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1835588b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714217813; x=1714822613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jp4hRN3U63+VTp/kbaxaSBNFon3bWbhJwCyaL1wC8dE=;
        b=UprG36upcSxmUcaOso/Qv5/e7kS9Aoi9uslK1U6aLKfMvkyxMxOL1ugL3aJGXaKj5P
         trmZ19yQw0KqHHPNy+4aH0z6l1vLyX0VYs8VFfLONaLHPjp5vQFMt6t0yMxNjnsA+xfG
         6iQnyQkO31/q7hWWPNe8IVGekOCShLRokqUclF8FAkFHNOu/viwHGwrZ1FdMAmzNXWCd
         UNxU2y7EttbHBWIoqF89niBIpJ3bXr9L5wIFzKb1CqjBQF0eKbxFweDm/mKSNkpv1CEO
         8t9mxoRj9npgiexXTwZ8dUT5CLklgtNIEhM6z5W7XCLZ1TQ7IFfPwc2j+qZwzn6VodZY
         bFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714217813; x=1714822613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp4hRN3U63+VTp/kbaxaSBNFon3bWbhJwCyaL1wC8dE=;
        b=UUVeputY1F6oKdnEpv+UuRkVO+ou1IW9ysctlgIUKwWTkZMQEbObEdeW3weygswi2c
         ueUIeG0SDaxKy69bYxEUMZWu87pYgnCQGFej7Qs93pOrKrWpYfdLqzJTirhe87wqgSOv
         Zuq7yUJU39hcLYP5H6zGYISlEETh6Z/CIj3ZDAF49+sZntWuYoZe/kITZah4speKFhnt
         S0r0QKazyy+qlUKOm7hETdy/tpteChM9dhiu372D4x0p/pAJrKj00Bka+O72vJsdiG59
         6mhO6grAEy+BSgYt+2hN4Yun1kTJokTDmfA9ZrgbZrrBTQObgBvlxXG2KxL5BdH6jNDy
         CCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD8S0RAR9C94vS8KeiAZwZsz9u+Ua9w0EVd0CELNgdDNBHXsCgSk4xTfrqdlclxEwCi2CLpEZgfNxZ7FylbRt/O/9NbDhBP5HMam7f
X-Gm-Message-State: AOJu0YwSWHnNQ2PsL+/KYQIa7Ps4CxvJru9WY9DYjN9Mwq/5UV+DkHuZ
	NlTk4FjZ6cP/MkJuT4pKYF6nSMUIwOjxtmWD23Ax2s/UOB5NIQWqXabEj4RWHw==
X-Google-Smtp-Source: AGHT+IFPz6Ruq5+jtEUhJad2ZGgPJk+uB6ynLPk+rZsXWFAqu91AklU9J738m/6o+4YI5RYMxlBsTg==
X-Received: by 2002:a05:6a00:ace:b0:6e7:b3c4:43a4 with SMTP id c14-20020a056a000ace00b006e7b3c443a4mr6315088pfl.25.1714217812667;
        Sat, 27 Apr 2024 04:36:52 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id s6-20020aa78286000000b006f0aea608efsm15463745pfm.143.2024.04.27.04.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:36:52 -0700 (PDT)
Date: Sat, 27 Apr 2024 17:06:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/11] PCI: imx: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240427113643.GM1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>

PCI: imx6: Add support for configuring BDF to SID mapping for i.MX95

On Tue, Apr 02, 2024 at 10:33:44AM -0400, Frank Li wrote:
> i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the

Did you mean BDF? Here and everywhere.

> same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
> map to the same stream id. Then config LUT related registers.
> 

These DT properties not documented in the binding.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-imx.c | 175 ++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> index af0f960f28757..653d8e8ee1abc 100644
> --- a/drivers/pci/controller/dwc/pcie-imx.c
> +++ b/drivers/pci/controller/dwc/pcie-imx.c
> @@ -55,6 +55,22 @@
>  #define IMX95_PE0_GEN_CTRL_3			0x1058
>  #define IMX95_PCIE_LTSSM_EN			BIT(0)
>  
> +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> +#define IMX95_PEO_LUT_RWA			BIT(16)
> +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> +
> +#define IMX95_PE0_LUT_DATA1			0x100c
> +#define IMX95_PE0_LUT_VLD			BIT(31)
> +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> +
> +#define IMX95_PE0_LUT_DATA2			0x1010
> +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> +
> +#define IMX95_SID_MASK				GENMASK(5, 0)
> +#define IMX95_MAX_LUT				32
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx_pcie_variants {
> @@ -217,6 +233,159 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>  
> +static int imx_pcie_update_lut(struct imx_pcie *imx_pcie, int index, u16 reqid, u16 mask, u8 sid)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 data1, data2;
> +
> +	if (sid >= 64) {
> +		dev_err(dev, "Too big stream id: %d\n", sid);

'Invalid SID for index (%d): %d\n', index, sid

> +		return -EINVAL;
> +	}
> +
> +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> +	data1 |= IMX95_PE0_LUT_VLD;
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> +
> +	data2 = mask;
> +	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, index);
> +
> +	return 0;
> +}
> +
> +struct imx_of_map {

imx_iommu_map

> +	u32 bdf;
> +	u32 phandle;
> +	u32 sid;
> +	u32 sid_len;
> +};
> +
> +static int imx_check_msi_and_smmmu(struct imx_pcie *imx_pcie,
> +				   struct imx_of_map *msi_map, u32 msi_size, u32 msi_map_mask,
> +				   struct imx_of_map *smmu_map, u32 smmu_size, u32 smmu_map_mask)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	int i;
> +

	if (!msi_map || !smmu_map)
		return 0;

> +	if (msi_map && smmu_map) {
> +		if (msi_size != smmu_size)
> +			return -EINVAL;
> +		if (msi_map_mask != smmu_map_mask)
> +			return -EINVAL;

	if (msi_size != smmu_size || msi_map_mask != smmu_map_mask)
		return -EINVAL;

> +
> +		for (i = 0; i < msi_size / sizeof(*msi_map); i++) {
> +			if (msi_map->bdf != smmu_map->bdf) {
> +				dev_err(dev, "bdf setting is not match\n");

'BDF mismatch between msi-map and iommu-map'

> +				return -EINVAL;
> +			}
> +			if ((msi_map->sid & IMX95_SID_MASK) != smmu_map->sid) {
> +				dev_err(dev, "sid setting is not match\n");

'SID mismatch between msi-map and iommu-map'

> +				return -EINVAL;
> +			}
> +			if ((msi_map->sid_len & IMX95_SID_MASK) != smmu_map->sid_len) {
> +				dev_err(dev, "sid_len setting is not match\n");

'SID length  mismatch between msi-map and iommu-map'

> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Simple static config lut according to dts settings DAC index and stream ID used as a match result
> + * of LUT pre-allocated and used by PCIes.
> + *

Please reword the above sentence.

> + * Currently stream ID from 32-64 for PCIe.
> + * 32-40: first PCI bus.
> + * 40-48: second PCI bus.

I believe this is an SoC specific info. So better not add it here. It belongs to
DT.

> + *
> + * DAC_ID is index of TRDC.DAC index, start from 2 at iMX95.
> + * ITS [pci(2bit): streamid(6bits)]
> + *	pci 0 is 0
> + *	pci 1 is 3
> + */
> +static int imx_pcie_config_sid(struct imx_pcie *imx_pcie)
> +{
> +	struct imx_of_map *msi_map = NULL, *smmu_map = NULL, *cur;
> +	int i, j, lut_index, nr_map, msi_size = 0, smmu_size = 0;
> +	u32 msi_map_mask = 0xffff, smmu_map_mask = 0xffff;
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 mask;
> +	int size;
> +
> +	of_get_property(dev->of_node, "msi-map", &msi_size);
> +	if (msi_size) {

You mentioned in the commit message that msi-map and iommu-map needs to be the
same for this SoC. But here you are just ignoring the absence of 'msi-map'
property.

> +		msi_map = devm_kzalloc(dev, msi_size, GFP_KERNEL);
> +		if (!msi_map)
> +			return -ENOMEM;
> +
> +		if (of_property_read_u32_array(dev->of_node, "msi-map", (u32 *)msi_map,
> +					       msi_size / sizeof(u32)))
> +			return -EINVAL;
> +
> +		of_property_read_u32(dev->of_node, "msi-map-mask", &msi_map_mask);
> +	}
> +
> +	cur = msi_map;
> +	size = msi_size;
> +	mask = msi_map_mask;
> +
> +	of_get_property(dev->of_node, "iommu-map", &smmu_size);

Same comment as above.

> +	if (smmu_size) {
> +		smmu_map = devm_kzalloc(dev, smmu_size, GFP_KERNEL);
> +		if (!smmu_map)
> +			return -ENOMEM;
> +
> +		if (of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)smmu_map,
> +					       smmu_size / sizeof(u32)))
> +			return -EINVAL;
> +
> +		of_property_read_u32(dev->of_node, "iommu_map_mask", &smmu_map_mask);
> +	}
> +
> +	if (imx_check_msi_and_smmmu(imx_pcie, msi_map, msi_size, msi_map_mask,
> +				     smmu_map, smmu_size, smmu_map_mask))
> +		return -EINVAL;
> +

Hmm, so you want to continue even if the 'msi-map' and 'iommu-map' properties
don't exist i.e., for old platforms?

> +	if (!cur) {
> +		cur = smmu_map;
> +		size = smmu_size;
> +		mask = smmu_map_mask;
> +	}
> +
> +	nr_map = size / (sizeof(*cur));
> +
> +	lut_index = 0;

Just initialize it while defining itself.

> +	for (i = 0; i < nr_map; i++) {
> +		for (j = 0; j < cur->sid_len; j++) {
> +			imx_pcie_update_lut(imx_pcie, lut_index, cur->bdf + j, mask,
> +					    (cur->sid + j) & IMX95_SID_MASK);
> +			lut_index++;
> +		}
> +		cur++;
> +
> +		if (lut_index >= IMX95_MAX_LUT) {
> +			dev_err(dev, "its-map/iommu-map exceed HW limiation\n");

'Too many msi-map/iommu-map entries'

But I think you can just continue to use the allowed entries.

> +			return -EINVAL;
> +		}
> +	}
> +
> +	devm_kfree(dev, smmu_map);
> +	devm_kfree(dev, msi_map);

Please don't explicitly free the devm_ managed resources unless really needed.
Else don't use devm_ at all.

> +
> +	return 0;
> +}
> +
>  static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
>  {
>  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> @@ -950,6 +1119,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		goto err_phy_off;
>  	}
>  
> +	ret = imx_pcie_config_sid(imx_pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to config sid:%d\n", ret);

'Failed to config BDF to SID mapping: %d\n'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

