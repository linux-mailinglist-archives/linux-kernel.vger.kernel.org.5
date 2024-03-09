Return-Path: <linux-kernel+bounces-98049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0500D87740B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7928263D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05551C33;
	Sat,  9 Mar 2024 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4osKetT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C84F8A2;
	Sat,  9 Mar 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710020703; cv=none; b=L+Z/Wu40iTngsGPW+Kvr+aMcBCIoOjrLqVptZToZuvj8MQup5jypJkds/XCcJSsrsnsCH1ik5OfOfpVyp/MFh+MJF8N7aGchsNq1aZ7DvwPJ8EbfC/z4syoRgOCTgFoLvCGgHEm43A29yNIPTYe7kI/GKhcYCndbvG5zBggx2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710020703; c=relaxed/simple;
	bh=FLuhvhHPRxE99p2eGB2Vj+c+o8BQRr2d1HWMOmmd/Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQgr2+pZCIiEWVwh5VbUHe3K5StfZz37X9j3u8xcrPfLIvRYltEIC0hSiiDQlt/HLRn3EwgicwKRvdLvyADN62XPQw9wdKPneAbAqXfvjzbgEd92hRV/XPAYWVMnvNQuR+7bLRXcaBhj78JfzdZD35UpRmfL5r77nJrDeTLMITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4osKetT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E2C433C7;
	Sat,  9 Mar 2024 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710020703;
	bh=FLuhvhHPRxE99p2eGB2Vj+c+o8BQRr2d1HWMOmmd/Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4osKetTIGw6nGPFfUWdf5fXywb/lk9zXENF5diB7+AsADp6x+S3xWt8W4CT+kw5G
	 cyuG1ebtSINg0iLR8XiQhoraP4pv0Q1fuDP8NRZOMVMMeDN9ML+xMJvUL1D3W88sB/
	 LBkMvELHSHxopIUflY9Gw10WqRNlM0qA1b8NWRmb9R/oNOVHUusYzTbmS3haMIy1WW
	 5aG3U+W+ykBK5mx6T10aRh5NH61wnx7/s8f293zOntrvAGk6muJaEpNX0dvL2LGa3F
	 bdWdKt1D+Hyd0/vgN0zsMPLBx8UrsUI9bqBwJVCRXocCwzxxcc8XgGJ/8SWbVaOLIR
	 sKM1ijRwgCMKw==
Received: by pali.im (Postfix)
	id 29E5A7D5; Sat,  9 Mar 2024 22:45:00 +0100 (CET)
Date: Sat, 9 Mar 2024 22:45:00 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add XPS 9315 to fan control whitelist
Message-ID: <20240309214500.ktp4uykeagpenpov@pali>
References: <20240309212025.13758-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240309212025.13758-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716

On Saturday 09 March 2024 22:20:25 Armin Wolf wrote:
> A user reported that on this machine, disabling BIOS fan control
> is necessary in order to change the fan speed.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

If it is working fine for that machine then I do not have any
objections.

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 6d8c0f328b7b..4fa837e65a61 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1450,10 +1450,15 @@ struct i8k_fan_control_data {
>  };
> 
>  enum i8k_fan_controls {
> +	I8K_FAN_30A3_31A3,
>  	I8K_FAN_34A3_35A3,
>  };
> 
>  static const struct i8k_fan_control_data i8k_fan_control_data[] __initconst = {
> +	[I8K_FAN_30A3_31A3] = {
> +		.manual_fan = 0x30a3,
> +		.auto_fan = 0x31a3,
> +	},
>  	[I8K_FAN_34A3_35A3] = {
>  		.manual_fan = 0x34a3,
>  		.auto_fan = 0x35a3,
> @@ -1517,6 +1522,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell XPS 9315",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
> +	},
>  	{ }
>  };
> 
> --
> 2.39.2
> 

