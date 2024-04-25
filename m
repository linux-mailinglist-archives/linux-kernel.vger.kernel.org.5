Return-Path: <linux-kernel+bounces-158334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800728B1E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44858288F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338978624E;
	Thu, 25 Apr 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ir0I5AtE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFC6AFB6;
	Thu, 25 Apr 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038704; cv=none; b=RZ6kPHaezzAZW5H4M1if4aCIeqPoRJ4je52Se2xFv0qXuIYGbMyiBQPCsl4E6niS19fby961/mRlpt1knP4CuaTCBXUYHR9oECUYGAF9eW3MPVdT2DAxOyPnThacF5nkeN8EZ0/WHTBiHrJjtF/As7xjJCIgMJIwHb5wnkOgv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038704; c=relaxed/simple;
	bh=lU8tV3G8euvf2o7zJo7VAJNX9vi9q7wDMvvI2z8B19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyzKXgFKx2b7F1/AYDtiCVLUZ/+ILqCWzrS5HCP/tguuJ5+dLyG+7Bg9PCvehOZJHGnyRhFHqWbwq5tB1i4ClKGKLFZ/fNQdBXOu5p4UTWdrL3Io9228L/l+OLXa3Fcc+56SZjIiUB4IHbo9rde/DfrFlhlTs8djdZmv5Kl38SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ir0I5AtE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038703; x=1745574703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lU8tV3G8euvf2o7zJo7VAJNX9vi9q7wDMvvI2z8B19M=;
  b=ir0I5AtElYTuA0Ys5cSxrMoP+hlNkMISMt5bN0u0+8jmhqR7XlFOhH82
   uvQ2+J6S5rVMi3uskzkEVL3LFAe6WKm41T0sVhEdFPHGrfH1zzU+yl/EX
   0ABSJOFekw6ZqdNBDaACIoQ11wsrCYJZeYKhOYXLiaN2GWzKbwQnw2Vyy
   XQl73AgR4K2vzjn8aUUkt5uFTe8iwxIaV34kyaUvzix+/pW4cjMUqL4s7
   XCbhnyEgeGzHBtdPPv2SZrEiAdubas37J6o2iCc4OEwtrCSYpdh3tAG6X
   hz9V2ds/KmtwVBcAqSnMUh5TPy3r6AyH+wnanBwL2SdgBEueVM+nw+H4m
   w==;
X-CSE-ConnectionGUID: hY+1uHJzS6SSUt/MaHc89A==
X-CSE-MsgGUID: BkTvoFmTSfej5F6x/ok+Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21133659"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="21133659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:51:42 -0700
X-CSE-ConnectionGUID: 8qPQ5SUIS6eAAHnrJAef6w==
X-CSE-MsgGUID: JDYMhXx7TxC/X5eesRDeOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25006598"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa009.fm.intel.com with SMTP; 25 Apr 2024 02:51:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Apr 2024 12:51:38 +0300
Date: Thu, 25 Apr 2024 12:51:38 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: clear pd_event queue in PORT_RESET
Message-ID: <Zionqg7KXa7m8yuc@kuha.fi.intel.com>
References: <20240423202715.3375827-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423202715.3375827-2-rdbabiera@google.com>

On Tue, Apr 23, 2024 at 08:27:16PM +0000, RD Babiera wrote:
> When a Fast Role Swap control message attempt results in a transition
> to ERROR_RECOVERY, the TCPC can still queue a TCPM_SOURCING_VBUS event.
> 
> If the event is queued but processed after the tcpm_reset_port() call
> in the PORT_RESET state, then the following occurs:
> 1. tcpm_reset_port() calls tcpm_init_vbus() to reset the vbus sourcing and
> sinking state
> 2. tcpm_pd_event_handler() turns VBUS on before the port is in the default
> state.
> 3. The port resolves as a sink. In the SNK_DISCOVERY state,
> tcpm_set_charge() cannot set vbus to charge.
> 
> Clear pd events within PORT_RESET to get rid of non-applicable events.
> 
> Fixes: b17dd57118fe ("staging: typec: tcpm: Improve role swap with non PD capable partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c26fb70c3ec6..6dcafbaf10a2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5605,6 +5605,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PORT_RESET:
>  		tcpm_reset_port(port);
> +		port->pd_events = 0;
>  		if (port->self_powered)
>  			tcpm_set_cc(port, TYPEC_CC_OPEN);
>  		else
> 
> base-commit: 684e9f5f97eb4b7831298ffad140d5c1d426ff27
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

