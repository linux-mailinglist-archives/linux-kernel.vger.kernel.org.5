Return-Path: <linux-kernel+bounces-95542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3B874F33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747C51C229B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56712BEA5;
	Thu,  7 Mar 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmpiMxyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBF12881C;
	Thu,  7 Mar 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814878; cv=none; b=BDe1e9MfVje+ZUK047TMeFww4L70Mrcx6suu3jmSz14EPHjmWqADtXrrLYSF22CU/ln+LsKDkcNCc6T+SAgFL6Ss7FMVMxby1ALWeoJmnrygii6Y0pT3MAtZT8M9Ai5tSxujVKNcM5hkFS47YZVl+pxZ/y/iFiyvPbSDo2iXJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814878; c=relaxed/simple;
	bh=BvAvilTGYuQBuxg/VkWEO98QsQNG4+isNYq/1wZqKww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfeK/YvqVxPtaqnKgCcYpSW1y/WAyu+VSfBuRl35hZydb5avW7CmKQ5l9G9U7GxXjx+b0EhHReQP4G0E4EFkEjeisiGPNpvhzmctGsPhiU76xWiJdEtHHOwgkDYLKzzs7wcEX1D8JFSoGWMXDzdjezu3LKHRqg4ghuVMaF4f5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmpiMxyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E68C433C7;
	Thu,  7 Mar 2024 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709814878;
	bh=BvAvilTGYuQBuxg/VkWEO98QsQNG4+isNYq/1wZqKww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GmpiMxylS6Xl3bIHxxo/gypLff/ee2i+qpEr+hVbvn+Ij7s0G6zQ/rSn/1lqNCPVp
	 RolkjveZ9nGF2nu+6pvMeK7fuLzayNil6bl5iOZIkIPx0htF7cA1hBXV5bVp90uw+y
	 COAssc5Spszl9duXjpGMCIlCxLTX7S8j5bPeib11S7SgaVlSFgur0FuySxLWIxph8m
	 oRwCT4kYk1hYAcjIRGXO7UqSK/TaTId7Koc19FsLxrbKfaXb2OahVJJD3rz3Jf8MbQ
	 OB+mCtAeSEPPfBZJTPkJbcnpj9wvB40LWoJak4tXQPjg0iQ94WOCgchEahPsWkuqlz
	 uQ1bBvKC7fz2A==
Message-ID: <6f9c1ee1-3b3a-44e3-96c6-ae1bef52d51d@kernel.org>
Date: Thu, 7 Mar 2024 14:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] usb: cdns3-ti: support reset-on-resume behavior
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-4-5ec7615431f3@bootlin.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240307-j7200-usb-suspend-v4-4-5ec7615431f3@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/03/2024 11:55, Théo Lebrun wrote:
> Add match data support, with one boolean to indicate whether the
> hardware resets after a system-wide suspend. If hardware resets, we
> force execute ->runtime_resume() at system-wide resume to run the
> hardware init sequence.
> 
> No compatible exploits this functionality, just yet.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 4c8a557e6a6f..f76327566798 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -57,9 +57,14 @@ struct cdns_ti {
>  	unsigned vbus_divider:1;
>  	struct clk *usb2_refclk;
>  	struct clk *lpm_clk;
> +	const struct cdns_ti_match_data *match_data;
>  	int usb2_refclk_rate_code;
>  };
>  
> +struct cdns_ti_match_data {
> +	bool reset_on_resume;
> +};
> +
>  static const int cdns_ti_rate_table[] = {	/* in KHZ */
>  	9600,
>  	10000,
> @@ -101,6 +106,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
>  
>  	data->dev = dev;
> +	data->match_data = device_get_match_data(dev);
>  
>  	data->usbss = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(data->usbss)) {
> @@ -220,8 +226,29 @@ static int cdns_ti_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int cdns_ti_suspend(struct device *dev)
> +{
> +	struct cdns_ti *data = dev_get_drvdata(dev);
> +
> +	if (data->match_data && data->match_data->reset_on_resume)
> +		return pm_runtime_force_suspend(dev);
> +	else
> +		return 0;
> +}
> +
> +static int cdns_ti_resume(struct device *dev)
> +{
> +	struct cdns_ti *data = dev_get_drvdata(dev);
> +

Instead of this just do Reset and re-init here on affected
platforms.
This is after you remove reset/re-init code from .runtime_resume().

> +	if (data->match_data && data->match_data->reset_on_resume)
> +		return pm_runtime_force_resume(dev);
> +	else
> +		return 0;
> +}
> +
>  static const struct dev_pm_ops cdns_ti_pm_ops = {
>  	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(cdns_ti_suspend, cdns_ti_resume)
>  };
>  
>  static const struct of_device_id cdns_ti_of_match[] = {
> 

-- 
cheers,
-roger

