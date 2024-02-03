Return-Path: <linux-kernel+bounces-51214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDB8487DC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822611F26011
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574F5FB82;
	Sat,  3 Feb 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kCMx8q0m"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DFE5F864;
	Sat,  3 Feb 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706980429; cv=none; b=L/oYtWRkKIUTSNgz1Yy2W5sjNDr6yVPeSFt01excAgGWcr1pdwYJYTsxdadgDn3iomcS08jW/HxU8qS+VDlngeqZYIUahxc3Dr0YAMwJJ54JoPq+LkjND5v145QImHxQVLXZgD6tKhOk/lpSi0kseiwXXAElmn0+xUD7VnhcmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706980429; c=relaxed/simple;
	bh=IGm2jTqgqGhtGWxCRpNVRFap1O7T144tLi9Mbfa9Kp0=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=fgOIotwqwAXEL3t0c+9ONH/DSXpiF08Cc9aUl73+Rcc1L+EsdoQuLEWZGEuMmCTLoOyc30hTfi3T1yDbLnfvX1LoiojTuTQP46HzvIyBBa27KFr5qvha8GIS6Ncsh3ZquUlU19f8D7WPMM+iG7pf4FbHyJM0fMk3wuNWoCY9Jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kCMx8q0m; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id WJZ5r8EMLWeJzWJZ5r3AWG; Sat, 03 Feb 2024 18:12:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706980356;
	bh=ay6OCUA7f665DqUoUex+m2wntbywTqOyj8cITOvN8KA=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To;
	b=kCMx8q0mDjuLPqDx/7+dWEIEE7lW8OT9Y5QLRj4N5/t8G2hNphXtndT49IBqx1acW
	 XB+W2IBQY0HrTHcD5EhobF1wPMfpI5ZKbl4vBUo4wTeyUQRjEtIXheQezSoNeuvpSO
	 TucK/VPKWZh8z6kE3lYW6uOMQSo8EdGvDWV7TsRtlKAXEkK92cZBTO1sXJ8zqrEEoA
	 AKDsDrT4e3NBeKtrkkJb84bS1sX98TV3yEQIqZ4LrYqX+lA+jn4JKbV+oYgH37wx7V
	 dweJuDy+gPkmydNUCqD4D0C8h/lnLBT14lniu84QJVTfnHOVnNZbswo3O9rC4SpFOc
	 LI1vxqSTSFK+Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Feb 2024 18:12:36 +0100
X-ME-IP: 92.140.202.140
Message-ID: <9dd39fe9-9e9d-4093-b914-13006ac99792@wanadoo.fr>
Date: Sat, 3 Feb 2024 18:12:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 02/12] phy: freescale: add Samsung HDMI PHY
Content-Language: en-MW
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-3-aford173@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: aford173@gmail.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 alexander.stein@ew.tq-group.com, andrzej.hajda@intel.com,
 catalin.marinas@arm.com, conor+dt@kernel.org, daniel@ffwll.ch,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 festevam@gmail.com, frieder.schrempf@kontron.de, jernej.skrabec@gmail.com,
 jonas@kwiboo.se, kernel@pengutronix.de, kishon@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, l.stach@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, maarten.lankhorst@linux.intel.com, marex@denx.de,
 mripard@kernel.org, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 rfoss@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org, tzimmermann@suse.de, ulf.hansson@linaro.org,
 victor.liu@nxp.com, vkoul@kernel.org, will@kernel.org
In-Reply-To: <20240203165307.7806-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/02/2024 à 17:52, Adam Ford a écrit :
> From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> This adds the driver for the Samsung HDMI PHY found on the
> i.MX8MP SoC.
> 
> Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Alexander Stein <alexander.stein-W3o+9BuWjQaZox4op4iWzw@public.gmane.org>
> ---

..

> +static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
> +{
> +	struct fsl_samsung_hdmi_phy *phy;
> +	int ret;
> +
> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy);
> +	phy->dev = &pdev->dev;
> +
> +	phy->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(phy->regs))
> +		return PTR_ERR(phy->regs);
> +
> +	phy->apbclk = devm_clk_get(phy->dev, "apb");
> +	if (IS_ERR(phy->apbclk))
> +		return dev_err_probe(phy->dev, PTR_ERR(phy->apbclk),
> +				     "failed to get apb clk\n");
> +
> +	phy->refclk = devm_clk_get(phy->dev, "ref");
> +	if (IS_ERR(phy->refclk))
> +		return dev_err_probe(phy->dev, PTR_ERR(phy->refclk),
> +				     "failed to get ref clk\n");
> +
> +	ret = clk_prepare_enable(phy->apbclk);
> +	if (ret) {
> +		dev_err(phy->dev, "failed to enable apbclk\n");
> +		return ret;
> +	}
> +
> +	pm_runtime_get_noresume(phy->dev);
> +	pm_runtime_set_active(phy->dev);
> +	pm_runtime_enable(phy->dev);
> +
> +	ret = phy_clk_register(phy);
> +	if (ret) {
> +		dev_err(&pdev->dev, "register clk failed\n");
> +		goto register_clk_failed;
> +	}
> +
> +	pm_runtime_put(phy->dev);
> +
> +	return 0;
> +
> +register_clk_failed:
> +	clk_disable_unprepare(phy->apbclk);
> +
> +	return ret;
> +}
> +
> +static int fsl_samsung_hdmi_phy_remove(struct platform_device *pdev)
> +{
> +	of_clk_del_provider(pdev->dev.of_node);

A clk_disable_unprepare(phy->apbclk) call seems to be missing here.
Or maybe devm_clk_get_enabled() should be used for 'apbclk'?

CJ

> +
> +	return 0;
> +}

..

