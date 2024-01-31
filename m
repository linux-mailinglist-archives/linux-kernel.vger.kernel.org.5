Return-Path: <linux-kernel+bounces-45572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58484328E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D24A1C2479D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45A15AF;
	Wed, 31 Jan 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsstPPHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EED1368;
	Wed, 31 Jan 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663368; cv=none; b=nSILEafDdQMMKSuAOajobcl6t8MDPY7iAatvDQzT/f2igsqfQq6shDaOeYPSk7nUE2WUBSb5Kk+5fziESFLoEefuyfFuQHNouONBzrqVTvhbfiDbl8IZSTXmVzRehrRblDjLMTBWxiYvVZBmcTBEmbAliCN9ZyXdcHLqiG1+fmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663368; c=relaxed/simple;
	bh=GdArBPbBjQlx8Ti50cz+N0yZGlmVHlTS3IHwASRVRp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLj7vLOCY8icUMY1uguR59jasf50y5fW6xCPd6YWlJMGr9Ec2ENTNsS1nXwp6r5w4GlxLKCd9HKB0sAEuf5QhQslt4OhyiAYKYljA/C4nBLwEsv/rV9fz3CYgEJdOyfFc61N/MlwK25NQo5omyR9yNZrw3KY3Hi5/CAmZXIFCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsstPPHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F954C433C7;
	Wed, 31 Jan 2024 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706663367;
	bh=GdArBPbBjQlx8Ti50cz+N0yZGlmVHlTS3IHwASRVRp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsstPPHCkltVZEEzKwHkIB1x5kAMx2nXLWPf5UNDjqnvjXIizPNyW/5kn3ndPHXZs
	 I33paSjEFttYp3rrFkbw4O4FmxtUYpNlMwMLaj4xdb/jJ28e8aZ5RxLsOCBsMYegF8
	 2ERG01fIzc1OdURjtnfXGGat+OCmlSDMuIm9KM3WTzAckt+3w04I0WEefOpSVP23+9
	 0N/ohXhtle2DXlYDVzeVvGBlMhjMMKkM+2pEUpc6u9ZTf7LitcKPLijsdDenW2gQf5
	 TqmGYWcCD6IfpGndPduQsVwe7gaajid1xbNp3xLRvMKXlskQlfFNtgaSnQPi68cM7S
	 jYbHWwcWcjoJg==
Date: Tue, 30 Jan 2024 19:09:24 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to
 be managed by HW
Message-ID: <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>

On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Some power-domains may be capable of relying on the HW to control the power
> for a device that's hooked up to it. Typically, for these kinds of
> configurations the consumer driver should be able to change the behavior of
> power domain at runtime, control the power domain in SW mode for certain
> configurations and handover the control to HW mode for other usecases.
> 
> To allow a consumer driver to change the behaviour of the PM domain for its
> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> which the genpd provider should implement if it can support switching
> between HW controlled mode and SW controlled mode. Similarly, add the
> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> genpd provider can also implement for reading back the mode from the
> hardware.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h | 17 ++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a1f6cba3ae6c..41b6411d0ef5 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
>  
> +/**
> + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.

This isn't proper kernel-doc

> + *
> + * @dev: Device for which the HW-mode should be changed.
> + * @enable: Value to set or unset the HW-mode.
> + *
> + * Some PM domains can rely on HW signals to control the power for a device. To
> + * allow a consumer driver to switch the behaviour for its device in runtime,
> + * which may be beneficial from a latency or energy point of view, this function
> + * may be called.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + *
> + * Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> +{
> +	struct generic_pm_domain *genpd;
> +	int ret = 0;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return -ENODEV;
> +
> +	if (!genpd->set_hwmode_dev)
> +		return -EOPNOTSUPP;
> +
> +	genpd_lock(genpd);
> +
> +	if (dev_gpd_data(dev)->hw_mode == enable)

Between this and the gdsc patch, the hw_mode state might not match the
hardware state at boot.

With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
false) will not bring control to SW - which might be fatal.

Regards,
Bjorn

