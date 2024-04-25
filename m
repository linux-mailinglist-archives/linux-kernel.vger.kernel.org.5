Return-Path: <linux-kernel+bounces-159103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB338B297B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4F628680C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38BF152E1A;
	Thu, 25 Apr 2024 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh2AigTX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20454152516;
	Thu, 25 Apr 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075937; cv=none; b=fD7PZDgMY758/WW/+rnw4JD+AEnSIMDo8Ft/4BuvAvI4aqcAlj1Szgd5Nrvo1sM9LBEKn5etI8bncYiKrPtnwkFRKBpaO/rpjqrfWIsf+TOxJXqL+bCz66JFxoeCRMybl3uiH1i4BMsHB728bIda1i0VNnrC3t39tySchnVQYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075937; c=relaxed/simple;
	bh=uzqhaKfS1s0sqE04vRFRHadopSwBj8lYISF5m8m7AzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahdg0Twhbd46B0ObuSNbLPe9zCItJqhB/dXfN9LBhkntqcx36++XIQ459Qmtxwd4wMW8i7Xo/B7ldfAGt3HWdRDJkHU4NdC3rgfnHPv2zPi1SxATSvx4JEsqGWBA6421iqV8g++T30QGEECtUwJ7rg2sX9ryLfV0JA/inS53Oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh2AigTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2D0C113CC;
	Thu, 25 Apr 2024 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714075936;
	bh=uzqhaKfS1s0sqE04vRFRHadopSwBj8lYISF5m8m7AzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sh2AigTXt5NNpno9XyNGHCgvgfolk+A9ol4bxASJOaEydEJ4eDzMjxh3W/RFdAOM7
	 T9DDXbW7ZuuVb8EJTCUaEW/JpCA3Dd2ploLRN9YbGfln/CncG/X/UOXff8ApLnM3CA
	 3EIepIegDvx5r9QnghXXa7L/rKNuY2j/ejnfmCpF4L2EsfaqQ9amCGQ31fHRAT6LF1
	 WBLPfPuuHi6t6zkCgoxTOCUxYjLfcwXJi+bWr/LuHGRs721sZdPUDEQ02wXf4ui3oT
	 ozd2/KdJlPabXCkX0IkdkU3/kwGBg3RNSB6AoAvD43l1wu3gVLXZq3EC2st0IaDqXv
	 0N8PiDkBJ6thg==
Received: by pali.im (Postfix)
	id 0BFE970C; Thu, 25 Apr 2024 22:12:13 +0200 (CEST)
Date: Thu, 25 Apr 2024 22:12:13 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <20240425201213.apwdxazbdbjddtpr@pali>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
User-Agent: NeoMutt/20180716

On Thursday 25 April 2024 11:27:57 Lyndon Sanche wrote:
> +int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	ret = thermal_get_supported_modes(&supported_modes);
> +
> +	if (ret != 0 || supported_modes == 0)
> +		return -ENXIO;
> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if ((supported_modes >> DELL_QUIET) & 1)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if ((supported_modes >> DELL_BALANCED) & 1)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if ((supported_modes >> DELL_PERFORMANCE) & 1)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	platform_profile_register(thermal_handler);
> +
> +	return 0;
> +}
> +
> +void thermal_cleanup(void)
> +{
> +	platform_profile_remove();
> +	kfree(thermal_handler);
> +}
> +
>  static struct led_classdev mute_led_cdev = {
>  	.name = "platform::mute",
>  	.max_brightness = 1,
> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
>  		mute_led_registered = true;
>  	}
>  
> +	// Do not fail module if thermal modes not supported,
> +	// just skip
> +	if (thermal_init() != 0)
> +		pr_warn("Unable to setup platform_profile, skipping");

I think that -ENOMEM error should be failure of the loading the driver.
It does not make sense to continue of memory allocation failed.

On the other hand when the thermal modes are not support (e.g. old
Latitude models) then there should not be a warning message. It is
expected that on systems without thermal modes the setup fails.

> +
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return 0;

