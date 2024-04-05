Return-Path: <linux-kernel+bounces-132494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326D8995DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DA51C21CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC928E2B;
	Fri,  5 Apr 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcN9OhNq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BC2557A;
	Fri,  5 Apr 2024 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299797; cv=none; b=fVX5ugiaR7j81W/eO0ovqlNiAqP3z+3KjohzhysxRQEk00XT5A41RuBLAZWOdciEsIRO1CFXkoGQuQBEOJg3PDByhEmsWZ5xOX2EYK5jUfGeiSYxC1No31ueRP/aKuEfq5WCm1NDyM27WRi3YfIgGROvIRxn59XqXu1iB4/ctYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299797; c=relaxed/simple;
	bh=pM5eyZ6ngQNS72PsWbWA/pEt9fJ2yCxrs53GYxHbrvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQj7HaPvW5sGllPkXQ51inXjCb+vxVaE9o/H4FNtgb2GJeo434oSTywjbd9wN4bcICvbunW9nyZyw6wrFa3hfdK/q6YqP/sFAQlslVfVN2ZUzBNhP13o1JyPP9OaOcnQ41yUVeQB6rRrMRGOKDbeLuoOXcy29BMC127+GWCS5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcN9OhNq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712299796; x=1743835796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pM5eyZ6ngQNS72PsWbWA/pEt9fJ2yCxrs53GYxHbrvI=;
  b=GcN9OhNq/TZ5ZMoxa4x86i7JO6ewKpJpQEHWdxuQ29tmxyp5qDDbWgYj
   NAvg/+JVd/9gUq4EAPGcZMVk3sxd3KNfnSQaM9psI9SuM0FBq33oXIYOv
   QaXiXqIsptyDKTLgQentGNM539HaWHUuhdhU1v6I62FBzo0wVL6HYc4kG
   NcUqMpd959JVbQMjFty8er9xfimn3kVgMshAd/Iu+ZFq5QB19JVfH1naZ
   GcqFpBaPWXpv6A+AyB/LtcX5DomE3HDQr0Beew2+5BHJECEZoeGwGzJaa
   7ZyfDss7H4vy9zfAAaCBVOKQY8anZ2D2JLg5qLiShSSXQzkSiiF3iSBOE
   w==;
X-CSE-ConnectionGUID: kYLUhW6QTPimlfPCOXGN5Q==
X-CSE-MsgGUID: M+i4ae5VQ+Ssl51iDt6ObQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="30090098"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="30090098"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 23:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937087429"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="937087429"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2024 23:49:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Apr 2024 09:49:51 +0300
Date: Fri, 5 Apr 2024 09:49:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] usb: typec: tipd: fix event checking for
 tps6598x
Message-ID: <Zg+fD6w1MykCsEe6@kuha.fi.intel.com>
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
 <20240328-tps6598x_fix_event_handling-v1-2-502721ff705b@wolfvision.net>
 <ZgveG5Ly3mw0O0eo@kuha.fi.intel.com>
 <b6bf7f8e-7d46-4b70-930c-9483f13fd80a@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bf7f8e-7d46-4b70-930c-9483f13fd80a@wolfvision.net>

On Wed, Apr 03, 2024 at 10:55:29AM +0200, Javier Carrasco wrote:
> >> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
> >> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
> >> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
> > 
> > This is not going to work with the older TI PD controllers.
> > 
> > The lenght of these registers is 8 bytes on the older TI PD
> > controllers (TPS65981, TPS65982, etc.). I think we need to split this
> > function.
> > 
> 
> That is a good point. I had a look at the older TI PD controllers and I
> agree with you that we should split the function to cover both register
> lengths separately.
> 
> I was thinking about adding a new compatible for the newer PD
> controllers (tps65987 and tps65988), keeping the current tps6598x for
> the older ones as well as backwards compatibility. But backwards
> compatibility would also mean that flags beyond the first 8 bytes would
> be ignored.
> 
> On the other hand, the upper flags are only relevant for firmware
> updates, so we could check those (i.e. read 11 bytes) if a firmware was
> provided via "firmware-name", and ignore them (i.e. read 8 bytes) otherwise.
> 
> Other ideas or improvements to mine are more than welcome.

I don't have any good ideas. On ACPI platforms the same device ID may
be used with all of these, so we should actually try to figure out the
version from registers like VID, DID and Version (if they are
available).

thanks,

-- 
heikki

