Return-Path: <linux-kernel+bounces-158327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6C8B1E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD758B27FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B3285C52;
	Thu, 25 Apr 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1h+dT50"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4384E06;
	Thu, 25 Apr 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038586; cv=none; b=LHS00i4qZ4XPyppRjYTI9/C6o9w3ANN5yU/wLzaiTtAG/YOVAyp8Q0uFYdnQ3ht7Zag079Su02MZWaP7iIHhlRh4WVA3XXH0R0dlh+e48V3Ixkb/ghdknORxgQ5N4lGpinXw3YyZTA93k525rBT6PSLbvDmR0O4FpkKnXI+W3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038586; c=relaxed/simple;
	bh=QXFUf2dig+J5niW70mDgvb8l8rJWffgfwjHbPDKxhQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaBhurzt9qH4ZPDacP95preuQ1i34aM2KSApmOawx2hiKrta7A5XNCh5051C36/lUYpuRe4ZAxd3u6YSxjtovoXveE/8ksqVFta7RxxCj0xnV+MFQmzo5aaGi0YLy0g+ulTQdnkaAPftcdXioVWcleIYHNYhju7+bfSQ7X06fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1h+dT50; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038585; x=1745574585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXFUf2dig+J5niW70mDgvb8l8rJWffgfwjHbPDKxhQc=;
  b=a1h+dT50I1kHP5ZEK0Bjh4UNt1pJ6nzqYxq4FK5cd76gEVVrupCoIfix
   OmyVKOwVhDpnOxWCHO33p/U5yguyO5XucDgHE30C2gLdxsrvhy3ALbc9W
   KZRhfuDoHsJFDu33z8z6n6D9Mk5bUgZahrCm9KbD0rYNTCeAwBGq3F9I4
   ZXp6XVoKdmB+qWpeX4MNaOGP/zuXNwtu3ELf6yi35KcaOQNWd0q7eCTg5
   buVvAzEteIp6OIWh3xXrDCcHtRYI2FA3yQdd/X9dOhHLWUqwOKLTHh3uW
   hcgy9XiRFdkeashQvLbRrs15hLCvAZTucR3Bt7yUX458igPQl0TMAYUy7
   w==;
X-CSE-ConnectionGUID: dPDhQElGT8+zHT08G60n8w==
X-CSE-MsgGUID: 3nWNCZe9Su+MuNOpv81OxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9582694"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9582694"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:49:21 -0700
X-CSE-ConnectionGUID: OXFqQfJhS1OaxPgw+eHWxQ==
X-CSE-MsgGUID: nbxUm9SeTkujsYTuA25Xvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25050465"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 25 Apr 2024 02:49:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Apr 2024 12:49:17 +0300
Date: Thu, 25 Apr 2024 12:49:17 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, hdegoede@redhat.com,
	badhri@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: enforce ready state when queueing
 alt mode vdm
Message-ID: <ZionHYcUvvc865z4@kuha.fi.intel.com>
References: <20240423202356.3372314-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423202356.3372314-2-rdbabiera@google.com>

On Tue, Apr 23, 2024 at 08:23:57PM +0000, RD Babiera wrote:
> Before sending Enter Mode for an Alt Mode, there is a gap between Discover
> Modes and the Alt Mode driver queueing the Enter Mode VDM for the port
> partner to send a message to the port.
> 
> If this message results in unregistering Alt Modes such as in a DR_SWAP,
> then the following deadlock can occur with respect to the DisplayPort Alt
> Mode driver:
> 1. The DR_SWAP state holds port->lock. Unregistering the Alt Mode driver
> results in a cancel_work_sync() that waits for the current dp_altmode_work
> to finish.
> 2. dp_altmode_work makes a call to tcpm_altmode_enter. The deadlock occurs
> because tcpm_queue_vdm_unlock attempts to hold port->lock.
> 
> Before attempting to grab the lock, ensure that the port is in a state
> vdm_run_state_machine can run in. Alt Mode unregistration will not occur
> in these states.

I'm probable missing something, but wouldn't it be safer to check
port->state after grabbing the lock?

> Fixes: 03eafcfb60c0 ("usb: typec: tcpm: Add tcpm_queue_vdm_unlocked() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c26fb70c3ec6..6fa1601ac259 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1564,6 +1564,10 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
>  				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
>  {
> +	if (port->state != SRC_READY && port->state != SNK_READY &&
> +	    port->state != SRC_VDM_IDENTITY_REQUEST)
> +		return;
> +
>  	mutex_lock(&port->lock);
>  	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
>  	mutex_unlock(&port->lock);
> 
> base-commit: 684e9f5f97eb4b7831298ffad140d5c1d426ff27
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

