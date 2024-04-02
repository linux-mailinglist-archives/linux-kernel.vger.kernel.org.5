Return-Path: <linux-kernel+bounces-127721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C873894FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AA1282B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF05D47A;
	Tue,  2 Apr 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6pQV4IO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365085822A;
	Tue,  2 Apr 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053289; cv=none; b=ZpCokvEYf3VHrwpNoUv2U+GdeM0uw4A9FiKXepNrufAiwnv2X3O059pA/EYpMpSYjVTEfkJ7Kjk1QY8M+AEclCnla+IVgho+ifj7obod1p44CIvaAA/k9z5RkAy2gczgOiW1Pl+xM0wCZAMXhGhT9BSvnkUjAwE4FRLtQCuZQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053289; c=relaxed/simple;
	bh=qalQSIBm8kJNLYRo/npeSSeBNJbaSFRhkcTX3KDyPt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIJHcgB8vKV2scZ4HeeZkkVJ31qP1DyY25dwDDwfOBI1/D0KTmn3n/hB0Nnf8RXzN0z+OPw3H8zYBR9Uvkj+KlsjqRUvXeiydizcUR1LQE5LvGIOO5RcI6MuMSkBdzhz8kJXZ7N20Ey9NovQNQX0GG8D2h9/Nd6U/Wi4j7Ks9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6pQV4IO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712053289; x=1743589289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qalQSIBm8kJNLYRo/npeSSeBNJbaSFRhkcTX3KDyPt0=;
  b=D6pQV4IOIpKR3XT1acBzEO5rTp+6MxRdY7BYnYfp4BmNczXsFhdJWxYg
   SwTy1RxrlsFwlNqHUkDITQ3BrYUrL+OLSxtZ/UDBWFaNYj+onwWqxvBUK
   qcfZgHi36y/nqh5TnI1hX+iVqMjywRkMnpFCr5+AO7F/bmSQ5BJjqn5VE
   aCn6IOWprSXtteYfywsTof0ITwK7mAhZalvOnHpAdzz2PpRZPuNBOKcR+
   Ihfe98BsrkCCazOmd8okE5XCTLOVN3kzBgx5lQsCHs5ehKV0ER5rTwRD+
   FSu+6L6Vqf8CZ2BcviWfejbzxKQfB+g8X3m9PswZZzJg47noxqmsOIArr
   w==;
X-CSE-ConnectionGUID: m4os/K1VRzKwzCRiDhvHsQ==
X-CSE-MsgGUID: /gVvrdZdQfOTSVITMZjszQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24671008"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="24671008"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="937083286"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="937083286"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Apr 2024 03:21:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Apr 2024 13:21:24 +0300
Date: Tue, 2 Apr 2024 13:21:24 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] usb: typec: tipd: fix event checking in
 interrupt service routines
Message-ID: <ZgvcJPTJS7d4aYgr@kuha.fi.intel.com>
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>

On Thu, Mar 28, 2024 at 05:55:50PM +0100, Javier Carrasco wrote:
> The ISRs of the tps25750 and tps6598x do not handle generated events
> properly under all circumstances.
> 
> The tps6598x ISR does not read all bits of the INT_EVENTX registers,
> leaving events signaled with bits above 64 unattended. Moreover, these
> events are not cleared, leaving the interrupt enabled.
> 
> The tps25750 reads all bits of the INT_EVENT1 register, but the event
> checking is not right because the same event is checked in two different
> regions of the same register by means of an OR operation.
> 
> This series aims to fix both issues by reading all bits of the
> INT_EVENTX registers, and limiting the event checking to the region
> where the supported events are defined (currently they are limited to
> the first 64 bits of the registers, as the are defined as BIT_ULL()).
> 
> If the need for events above the first 64 bits of the INT_EVENTX
> registers arises, a different mechanism might be required. But for the
> current needs, all definitions can be left as they are.
> 
> Note: resend to add the Cc tag for 'stable' (fixes in the series).

So this should be v3 (or v2?). Next time please follow the guide
when submitting patches:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

thanks,

-- 
heikki

