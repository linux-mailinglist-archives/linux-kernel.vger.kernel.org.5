Return-Path: <linux-kernel+bounces-161907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6228B5320
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BE82822F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF4D175AD;
	Mon, 29 Apr 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwuLoxnx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDF15E8B;
	Mon, 29 Apr 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379315; cv=none; b=jHv5mJHkqiMprVCreZcsN/0vDO5ssadi0GBZYTjPjLFxleEKG2aliffYa0AiM+J1PvrW/kdaX2/dj/C9vCTg2RgOUf1aFscYTTbLKtXCwuKeu8yQEkIbVVR9Fg0Mfby+v8jMY+TqnqIsK3RgskSRulH/Gw6P0YTzKuO+qNHZ0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379315; c=relaxed/simple;
	bh=z2vGEtEwQgWYrDDKbib2/oFVDFE3vbryndLEEjqI+h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9jFs3B6AN1o9epEvMgfQyzsQlSGhTeEs1IgJFJw29tDTlF0bTlnQ1kCpGmH0QgbHVxIcBQCvtwvZNTl1Q+MaTg1tMPYOIc0R2z8PPxtfqgNA8Zlj5OrPTT6nsExmiUtwYEsRtZcAGqR9r1cI85W434QZsU0bkvR5/CLGU5pVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwuLoxnx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714379313; x=1745915313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2vGEtEwQgWYrDDKbib2/oFVDFE3vbryndLEEjqI+h4=;
  b=bwuLoxnxAnAlxIlL1JfwrgBlhOdTSTKkbgT9jPMO9/xH67EvAzROrMtv
   zMoDtVsdOL5Jvc+9gmD0Hw/irhxeaCKWCoS2Gc4m4Ol+eUmSzZPTI3oTc
   +NmhHiuFH755gkGz6EnZynuUYQ0RvK25hB9xJu0dPUbPYPy6pP8u2mVPx
   cd+Wj4EgJLxRk/+vYdr7nzlv/wW4XKRRVxFwBXXFPgg6YcWYga0xGs/4k
   NVxwulwRaFOpB2NMCwsFEEnTOhapBroYscAoicuaBkrMupOjbu6eJQg1u
   BufHorP7+VC0X0qO/VVW/M9N+EzF9vk/AxXhmubZj4lMugejnfPXsHfMP
   w==;
X-CSE-ConnectionGUID: Te/HxkeLS3GFaXWM/stO3g==
X-CSE-MsgGUID: f2fIcHTOQ0qXoc2PFQnNrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9891912"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9891912"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:28:33 -0700
X-CSE-ConnectionGUID: 9ZPXB2RdRpGWbqzfc7mywA==
X-CSE-MsgGUID: eLtAfOSETzuGh3LyL8mFPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30862918"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa004.jf.intel.com with SMTP; 29 Apr 2024 01:28:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Apr 2024 11:28:28 +0300
Date: Mon, 29 Apr 2024 11:28:28 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, kyletso@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org,
	frank.wang@rock-chips.com, broonie@kernel.org,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Check for port partner validity
 before consuming it
Message-ID: <Zi9aLJS2vlHxwaFP@kuha.fi.intel.com>
References: <20240427202812.3435268-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427202812.3435268-1-badhri@google.com>

On Sat, Apr 27, 2024 at 08:28:12PM +0000, Badhri Jagan Sridharan wrote:
> typec_register_partner() does not guarantee partner registration
> to always succeed. In the event of failure, port->partner is set
> to the error value or NULL. Given that port->partner validity is
> not checked, this results in the following crash:
> 
> Unable to handle kernel NULL pointer dereference at virtual address xx
>  pc : run_state_machine+0x1bc8/0x1c08
>  lr : run_state_machine+0x1b90/0x1c08
> ..
>  Call trace:
>    run_state_machine+0x1bc8/0x1c08
>    tcpm_state_machine_work+0x94/0xe4
>    kthread_worker_fn+0x118/0x328
>    kthread+0x1d0/0x23c
>    ret_from_fork+0x10/0x20
> 
> To prevent the crash, check for port->partner validity before
> derefencing it in all the call sites.
> 
> Cc: stable@vger.kernel.org
> Fixes: c97cd0b4b54e ("usb: typec: tcpm: set initial svdm version based on pd revision")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ab6ed6111ed0..e1c6dffe5f8b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1580,7 +1580,8 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>  	port->partner_ident.cert_stat = p[VDO_INDEX_CSTAT];
>  	port->partner_ident.product = product;
>  
> -	typec_partner_set_identity(port->partner);
> +	if (port->partner)
> +		typec_partner_set_identity(port->partner);
>  
>  	tcpm_log(port, "Identity: %04x:%04x.%04x",
>  		 PD_IDH_VID(vdo),
> @@ -1742,6 +1743,9 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
>  	struct typec_altmode *altmode;
>  	int i;
>  
> +	if (!port->partner)
> +		return;
> +
>  	for (i = 0; i < modep->altmodes; i++) {
>  		altmode = typec_partner_register_altmode(port->partner,
>  						&modep->altmode_desc[i]);
> @@ -4231,7 +4235,10 @@ static int tcpm_init_vconn(struct tcpm_port *port)
>  
>  static void tcpm_typec_connect(struct tcpm_port *port)
>  {
> +	struct typec_partner *partner;
> +
>  	if (!port->connected) {
> +		port->connected = true;
>  		/* Make sure we don't report stale identity information */
>  		memset(&port->partner_ident, 0, sizeof(port->partner_ident));
>  		port->partner_desc.usb_pd = port->pd_capable;
> @@ -4241,9 +4248,13 @@ static void tcpm_typec_connect(struct tcpm_port *port)
>  			port->partner_desc.accessory = TYPEC_ACCESSORY_AUDIO;
>  		else
>  			port->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
> -		port->partner = typec_register_partner(port->typec_port,
> -						       &port->partner_desc);
> -		port->connected = true;
> +		partner = typec_register_partner(port->typec_port, &port->partner_desc);
> +		if (IS_ERR(partner)) {
> +			dev_err(port->dev, "Failed to register partner (%ld)\n", PTR_ERR(partner));
> +			return;
> +		}
> +
> +		port->partner = partner;
>  		typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
>  	}
>  }
> @@ -4323,9 +4334,11 @@ static void tcpm_typec_disconnect(struct tcpm_port *port)
>  	port->plug_prime = NULL;
>  	port->cable = NULL;
>  	if (port->connected) {
> -		typec_partner_set_usb_power_delivery(port->partner, NULL);
> -		typec_unregister_partner(port->partner);
> -		port->partner = NULL;
> +		if (port->partner) {
> +			typec_partner_set_usb_power_delivery(port->partner, NULL);
> +			typec_unregister_partner(port->partner);
> +			port->partner = NULL;
> +		}
>  		port->connected = false;
>  	}
>  }
> @@ -4549,6 +4562,9 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
>  
>  static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
>  {
> +	if (!port->partner)
> +		return;
> +
>  	switch (port->negotiated_rev) {
>  	case PD_REV30:
>  		break;
> 
> base-commit: 3f12222a4bebeb13ce06ddecc1610ad32fa835dd
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

