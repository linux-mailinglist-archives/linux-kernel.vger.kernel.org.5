Return-Path: <linux-kernel+bounces-160968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411968B4540
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36754B20F68
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4945C0C;
	Sat, 27 Apr 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pl0qkU7o"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363341C84
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714208469; cv=none; b=aYb44RmK9Yu9hDAw/Hd465+FgPGmoSDUAhV8ogYBUcH5urgqcHBNnd90wjc6yvga1v+xM+6jDIBpxFgZJLJuK4LXIJ87TeAp7/8U6uN2lkjCqADeSfWccXJNgkQ30QeE/vU6HvBagro5sbw30nP3o6Kuk28Ibq59GNJskonJuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714208469; c=relaxed/simple;
	bh=QKT7BbT0qdBcKFjzr1eNmhMAp51nbEYUTEgPS9pJd/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl9ND/FOsLGxrhHcpIqSzf8on20IjxNpZDzglwvvU1sBNXmucQ6ra8P1RVdGjcKiygVCmpYtpdIKqzhpLW6HSW5rH2wYp9+3veyk6EXDN1uQKFfcTnYQOO82LzUYgl6sQDNkNucqCWMoeBb8arQpuOWJRPjbawpIIsTeMxwikuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pl0qkU7o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e9320c2ef6so21220095ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714208466; x=1714813266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Vr7JWEB2T4GWYXcygc/EdGZmH7vUwdeKPTcNVaexOg=;
        b=Pl0qkU7oeaDmIiRWWY5jRf6WfYYn1jbkwJ32SVPZzHZGJGBwk1C1oPQ+XCq8lGntJ/
         R73Lv5z0HoWntj5NJ2i7yDJudOF+TmCJ2AHtZmQ70mvs4extWUToWt6IvqEiwEJaEnuz
         NbNlB+PRPDV7vQeSNaGuqH/vbtvmL+STcOmzCshb6mhiaFZZG+wcD5oBhrtifoz1PyDc
         abOv26ligdQCuipvgzpLpujw5YgydBxA9buh9GkDGjJDdaRoNTanZrVoUkwdnHmrO8ID
         HJdQudCCe02/g9G15Xw594mtYcYOHg0tmQetibfY2hkyoUyERiJ4tdfyHQGwEyUwyqph
         Bhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714208466; x=1714813266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vr7JWEB2T4GWYXcygc/EdGZmH7vUwdeKPTcNVaexOg=;
        b=DSIjrI6RllwKRmOw0KQsw9YXZKhxDioICnhZ15xO8eMkCi4fTajBpClMyFZjl06Zr4
         rbbOxCgRn6qd61dSp3oKvunPM/s8xzXKCGaCIml4MfwsrtgogVNo513Ax14KlqthVr/W
         Mmw7/+wiFv/mjHGPR5yS7xlc77HVTCbx2jMZdaW5IZ0KrVJ7O0X2n93oJGuMGd2AXUnX
         PF+hPOQXxzRWEGQXbZkXTbuuMZ7ZvLkuiVAaXKf2SQgfjneR93gs6t74wjJZ5b/bfG2x
         PgGNAtSbl6Crf9+wM+lTVqOVMZKR1WpDo4S9MrhP7oD27pZU8llabUUvi+xymlHVcSU9
         eEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1a0KFPuM5+AEk9Y/SaGsVfU7ixAIpBG0jdE0gUA3t1WCVuaO0z+37RkblQ5Hyya9+taJPA0gsw87/+UlmaHLHYZjYyyNZKd7Al0fi
X-Gm-Message-State: AOJu0Yw7MC7uv6fO7aM3xZIftqqW19yzcknaN0KFCX9INXEj9BPeANnB
	9lZegYkMjNMtMEcHWxQIHQjRoXsUj1zjEGWhei1KNUKumtpZIINQhiRMDy46WQ==
X-Google-Smtp-Source: AGHT+IHkIXGWPg97/VUL48rQXl/r6tasTmDAIegAIO6ujBMNWegRRUnBy7wEvErIfoXUBhtG5bde6A==
X-Received: by 2002:a17:903:234b:b0:1e7:d482:9e32 with SMTP id c11-20020a170903234b00b001e7d4829e32mr5854001plh.7.1714208465952;
        Sat, 27 Apr 2024 02:01:05 -0700 (PDT)
Received: from thinkpad ([120.60.53.237])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001e89e7b2b74sm16138858plk.235.2024.04.27.02.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:01:05 -0700 (PDT)
Date: Sat, 27 Apr 2024 14:30:57 +0530
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
Subject: Re: [PATCH v3 01/11] PCI: imx6: Fix PCIe link down when i.MX8MM and
 i.MX8MP PCIe is EP mode
Message-ID: <20240427090057.GF1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-1-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-1-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:37AM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Both IMX8MM_EP and IMX8MP_EP have the "IMX6_PCIE_FLAG_HAS_APP_RESET"
> set indeed. Otherwise, the LTSSM_EN bit wouldn't be asserted anymore.
> That's the root cause that PCIe link is down when i.MX8MM and i.MX8MP
> PCIe are in the EP mode.
> 

This commit message is difficult to understand. I think the issue you are fixing
is that these 2 SoCs do not control the 'apps_reset', due to which the LTSSM
state is not configured properly.

Referring Link Down is confusing at its best. Is the link training happens first
of all?

- Mani

> Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 99a60270b26cd..e43eda6b33ca7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1568,7 +1568,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
> @@ -1579,7 +1580,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

