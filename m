Return-Path: <linux-kernel+bounces-158365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67C8B1ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCE21C23D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A08624F;
	Thu, 25 Apr 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSmXmBmo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE28594A;
	Thu, 25 Apr 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039934; cv=none; b=teAmiDfDzHRq4YXLuyoqUxFIKgIOKT/ron1vB6ekzkqLr7xgdJnAYiw6Cj7khTdyLFzDSnBGX3ScZcRJ49tkaXRo6FSNssuUWS96Ti+7Y7dvEt3y9EoLDEcfzL2KFaG5KXv78GTvWH1NK9oxTa63TMLbF9jFGoHjyFdFudWCGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039934; c=relaxed/simple;
	bh=i+Mgc+IvSKQFeZHQCkY0AhEGIHTzpP4YUoIUEeKS914=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7MEXTeJyyPoeu7cmEiEb2vKa9nr+sT2toTszCQCkba/7gMiKUGYKHUdlOlBravyBLOcxEfAgk2bbV4qR+Vdq+spxgeDBoFZQenlumWSzVP9gRj/hGu1oNyDOiAvqZFmL+2R40Xz0/t8J625VcEZm1EjHZ7xJKXhVnbLf1I18y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSmXmBmo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714039933; x=1745575933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+Mgc+IvSKQFeZHQCkY0AhEGIHTzpP4YUoIUEeKS914=;
  b=aSmXmBmoZm8k6tRyRzkH5HeQkXf+CIlkJmg+HGnAJnlwzUjwCN4tk8jE
   cNSX5ubue/02P3toCTsvMsnmvgb7wNmiZFP41fWsPbLTZyH5jBnWTWGlc
   21PEtnqa53CasW4LnNZQfsNSExjjWt9dJSUqzRzqTUp/VdkMLQpNTwboH
   oj5XL8slaDr/ZFzs+Jmx+eb5/N6/rhLpxI32EbqjW0+Lul1mma4tat2O+
   eMl5MFMcm/ZA6a6fDNOma6G2kaZcXLvW/FZCMHFV5qON9CxYdTHeMBLB8
   v81Q17TOUUuVJyTMORDb9CRP9ZWjWWNFPYtB4zeyDFtf2gwsAHwqzn5qA
   g==;
X-CSE-ConnectionGUID: ET++B3E7TjiBpGy2nPL5Rg==
X-CSE-MsgGUID: ntF5uHqIRgqf63lXo3n91g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20405251"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="20405251"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:12:12 -0700
X-CSE-ConnectionGUID: U9hB78A2SzOiwFhmqGJYUw==
X-CSE-MsgGUID: 1XrYexgaQ0OHHn/BznmIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29648450"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa004.fm.intel.com with SMTP; 25 Apr 2024 03:12:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Apr 2024 13:12:08 +0300
Date: Thu, 25 Apr 2024 13:12:08 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	rdbabiera@google.com, linux-usb@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] usb: typec: tcpm: unregister existing source caps
 before re-registration
Message-ID: <ZiosePYrX5Q6qD70@kuha.fi.intel.com>
References: <20240424223227.1807844-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424223227.1807844-1-amitsd@google.com>

On Wed, Apr 24, 2024 at 03:32:16PM -0700, Amit Sunil Dhamne wrote:
> Check and unregister existing source caps in tcpm_register_source_caps
> function before registering new ones. This change fixes following
> warning when port partner resends source caps after negotiating PD contract
> for the purpose of re-negotiation.
> 
> [  343.135030][  T151] sysfs: cannot create duplicate filename '/devices/virtual/usb_power_delivery/pd1/source-capabilities'
> [  343.135071][  T151] Call trace:
> [  343.135076][  T151]  dump_backtrace+0xe8/0x108
> [  343.135099][  T151]  show_stack+0x18/0x24
> [  343.135106][  T151]  dump_stack_lvl+0x50/0x6c
> [  343.135119][  T151]  dump_stack+0x18/0x24
> [  343.135126][  T151]  sysfs_create_dir_ns+0xe0/0x140
> [  343.135137][  T151]  kobject_add_internal+0x228/0x424
> [  343.135146][  T151]  kobject_add+0x94/0x10c
> [  343.135152][  T151]  device_add+0x1b0/0x4c0
> [  343.135187][  T151]  device_register+0x20/0x34
> [  343.135195][  T151]  usb_power_delivery_register_capabilities+0x90/0x20c
> [  343.135209][  T151]  tcpm_pd_rx_handler+0x9f0/0x15b8
> [  343.135216][  T151]  kthread_worker_fn+0x11c/0x260
> [  343.135227][  T151]  kthread+0x114/0x1bc
> [  343.135235][  T151]  ret_from_fork+0x10/0x20
> [  343.135265][  T151] kobject: kobject_add_internal failed for source-capabilities with -EEXIST, don't try to register things with the same name in the same directory.
> 
> Fixes: 8203d26905ee ("usb: typec: tcpm: Register USB Power Delivery Capabilities")
> Cc: linux-usb@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ab6ed6111ed0..d8eb89f4f0c3 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2996,7 +2996,7 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  {
>  	struct usb_power_delivery_desc desc = { port->negotiated_rev };
>  	struct usb_power_delivery_capabilities_desc caps = { };
> -	struct usb_power_delivery_capabilities *cap;
> +	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
>  
>  	if (!port->partner_pd)
>  		port->partner_pd = usb_power_delivery_register(NULL, &desc);
> @@ -3006,6 +3006,9 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
>  	caps.role = TYPEC_SOURCE;
>  
> +	if (cap)
> +		usb_power_delivery_unregister_capabilities(cap);
> +
>  	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
>  	if (IS_ERR(cap))
>  		return PTR_ERR(cap);
> 
> base-commit: 0d31ea587709216d88183fe4ca0c8aba5e0205b8
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

