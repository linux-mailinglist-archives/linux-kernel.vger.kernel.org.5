Return-Path: <linux-kernel+bounces-136410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C889D3C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4064CB20CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EEB7E116;
	Tue,  9 Apr 2024 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDs2tXkF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561269DF4;
	Tue,  9 Apr 2024 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649914; cv=none; b=MZ9M3qhR7IrQWJ4HDnM/TOJ4Y8ETI08XhKUA7/bUVKaR1hHEOJl5OzqlnkonTh0HhElxYqPMzxPoY/tJhnVbqgOSqeZEMSzkNSTXMEJHRrfNgw+i2ApGD5T9jHcpfQK53oJ8CalHVTQtaEeB0+E+3GPsslTuRsRQxdX0XD9+Prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649914; c=relaxed/simple;
	bh=G+z6oXhYsSEPNHieDlTJJ1G7pqLswl3Dl4SmhdePMOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwBnOjte7kp4oKz9rsUvLmaaJ2tJkZa8yxydGdRj0i//RfFOHd43HGAqOhhwQq/AhUPuAqTgg5dufo9msZgjOX5EKwCPdLGg3IgKn5nhA+ZAV//J85zTpMQAvGlnfPF4OYeIBWgS3abRWIwLJpoqS5YKsrf7ucl0reODNRp5u5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDs2tXkF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712649913; x=1744185913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+z6oXhYsSEPNHieDlTJJ1G7pqLswl3Dl4SmhdePMOI=;
  b=CDs2tXkF/JVs7GNPSTsGW/tFAFOvKR7obcGfgW65h5JBms8pgC4l725s
   NqaO1mYRFSPvirDbxkzNWbqCj8HxUIX7Awf8nNRa78MNY4kNClg6vAzic
   iHusndGoXYeG1ZoAdhqTYgmW4EgzVm2033IXExQw8xL6fF2Q4eOY8wfut
   HpNuXhxLoSXgRaPFON69ZjJK+bdLB6NxGtu9nyhYyKaetm/2TX8KmL5v3
   7I7dtOl3ceEBuRe8Ql0lveUcBuBFMI2UacWk5Cc43pRzEBMssD6UuO6sm
   n7s06bGKPB/YhDTB16GLapWKi/Mq6i4wnT8V+uB3M+Ev/O4Cw/CYkhdvv
   g==;
X-CSE-ConnectionGUID: S4KLZgVmQOWI6sofC/m13A==
X-CSE-MsgGUID: M0qE0d3QTfmrX4mZCxpwtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11750101"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11750101"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093185"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093185"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Apr 2024 01:05:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2024 11:05:09 +0300
Date: Tue, 9 Apr 2024 11:05:09 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] usb: typec: ucsi: make it orientation-aware
Message-ID: <ZhT2tUFHinglhQu5@kuha.fi.intel.com>
References: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
 <20240408-ucsi-orient-aware-v1-4-95a74a163a10@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-ucsi-orient-aware-v1-4-95a74a163a10@linaro.org>

Hi Dmitry,

On Mon, Apr 08, 2024 at 07:30:52AM +0300, Dmitry Baryshkov wrote:
> The UCSI 1.0 is not orientation aware. Only UCSI 2.0 has added
> orientation status to GET_CONNECTOR_STATUS data. However the glue code
> can be able to detect cable orientation on its own (and report it via
> corresponding typec API). Add a flag to let UCSI mark registered ports
> as orientation aware.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 ++
>  drivers/usb/typec/ucsi/ucsi.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7ad544c968e4..6f5adc335980 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1551,6 +1551,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  	cap->svdm_version = SVDM_VER_2_0;
>  	cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
>  
> +	cap->orientation_aware = !!(ucsi->quirks & UCSI_ORIENTATION_AWARE);
> +
>  	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_AUDIO_ACCESSORY)
>  		*accessory++ = TYPEC_ACCESSORY_AUDIO;
>  	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_DEBUG_ACCESSORY)
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 6599fbd09bee..e92be45e4c1c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -410,6 +410,7 @@ struct ucsi {
>  	unsigned long quirks;
>  #define UCSI_NO_PARTNER_PDOS	BIT(0)	/* Don't read partner's PDOs */
>  #define UCSI_DELAY_DEVICE_PDOS	BIT(1)	/* Reading PDOs fails until the parter is in PD mode */
> +#define UCSI_ORIENTATION_AWARE	BIT(2)	/* UCSI is orientation aware */

You are not using that flag anywhere in this series. But why would
orientation need a "quirk" in the first place?

I'm not sure where you are going with this, but please try to avoid
the quirk flags in general in this driver rather than considering them
as the first way of solving things. Use them only as the last resort.

I don't want this driver to end up like xhci and some other drivers,
where refactoring is almost impossible because every place is full of
conditions checking the quirks, and where in worst case a quirk meant
to solve a problem on one hardware causes problems on another.

thanks,

-- 
heikki

