Return-Path: <linux-kernel+bounces-29966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D608315F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFADD2885DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707720307;
	Thu, 18 Jan 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTWZHrcV"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C071A279;
	Thu, 18 Jan 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570534; cv=none; b=jVH1H/YbByeW/PNcvkq4raFhdEtN7MN5gwXW/e+SNpOadeWVH0ueXv6w3L/MAx5ptol1YvPqxfAqiFNreJ+b8ouEYXg9Ks54PuExblVFv20kNBcO8aaYOKH9Dm1NivM4HvunE9qyQiEAV1gJXBjWPwDqqdplNqanpECw/JaGIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570534; c=relaxed/simple;
	bh=T4Ti0+es4BWBBqEZhqetvYtgl/51hOp0bVrzLlQeB4A=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=C3bhLfx7HnOJVQGxulriLruFZen7GupvMfNjwqq77ZzopHJQ111HCzWpW2eHOssOv7n+8LaSSvfAENF3r/27WHCdVegNXPG/bhR/gRGnpEhIGYvTuvsH4xwc85/UudI/pR/Qx7tUWYLWTT291B9X+9mrg182QKgKBsSuEsFgq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTWZHrcV; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705570532; x=1737106532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T4Ti0+es4BWBBqEZhqetvYtgl/51hOp0bVrzLlQeB4A=;
  b=BTWZHrcVwdZ+TeThMvjyAQ86a4H/V8+vuYb5tOBcYc2AwCfEohwGTe7n
   1wn/xqKOcchn27EhpYtFBe4GVyZybBAUMwX1Lyfq/bHgJY6GercXEU6KR
   OpuWJU7pK5P//eXxKAUnfVl+F5Qs/krDYxir68VUQLXX7aKvq94JFnn66
   vPREuMtvz8kunvoZr/3G9hmQqvPkc222tKTMz21SZCXO6Uh5LcFZrRBBA
   Mbg0m4Dbz0UvAJT+PDmEbpzmnYDrFhXwtEAqZ6h4nK411PRA722xzR5po
   PFUSUNhdwWqhtvINftv8OmEGGi1FnqkyOD2q63zUbXncgPlczfXLnINV/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404166150"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="404166150"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 01:35:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788042529"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="788042529"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 18 Jan 2024 01:35:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 18 Jan 2024 11:35:27 +0200
Date: Thu, 18 Jan 2024 11:35:27 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, kyletso@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org,
	frank.wang@rock-chips.com,
	=?iso-8859-1?Q?G=E1bor?= Stefanik <netrolller.3d@gmail.com>
Subject: Re: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
Message-ID: <Zajw3+8TOiDxiOR8@kuha.fi.intel.com>
References: <20240117114742.2587779-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117114742.2587779-1-badhri@google.com>

Hi,

On Wed, Jan 17, 2024 at 11:47:42AM +0000, Badhri Jagan Sridharan wrote:
> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
> 
> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> the CC pins, setting CC pins to default state during PORT_RESET
> breaks error recovery.
> 
> 4.5.2.2.2.1 ErrorRecovery State Requirements
> The port shall not drive VBUS or VCONN, and shall present a
> high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.
> 
> Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
> CC pins are set to default state after tErrorRecovery in
> PORT_RESET_WAIT_OFF.
> 
> 4.5.2.2.2.2 Exiting From ErrorRecovery State
> A Sink shall transition to Unattached.SNK after tErrorRecovery.
> A Source shall transition to Unattached.SRC after tErrorRecovery.
> 
> Cc: stable@vger.kernel.org
> Cc: Frank Wang <frank.wang@rock-chips.com>
> Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5945e3a2b0f7..9d410718eaf4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PORT_RESET:
>  		tcpm_reset_port(port);
> -		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> -			    TYPEC_CC_RD : tcpm_rp_cc(port));
> +		tcpm_set_cc(port, TYPEC_CC_OPEN);
>  		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>  			       PD_T_ERROR_RECOVERY);
>  		break;

Gábor had some concerns with this in v1.

thanks,

-- 
heikki

