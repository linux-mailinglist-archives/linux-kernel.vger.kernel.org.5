Return-Path: <linux-kernel+bounces-150605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1528AA1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C84CB20D97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA6177983;
	Thu, 18 Apr 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAKnZiBT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D416ABE3;
	Thu, 18 Apr 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463103; cv=none; b=Ge2rIPoW9PL6R6cnKPGU+TeCp2JARHxIIL6qwOjprjXWSbycniokuEfx0VhMrkffNmsDrFJgr81HGWAkuxxup5b8CTeMFqSahwBbzySGGJLqwGdj6XuOz9ahdfQGNzh91J1ClqtZXyUarH6mNlUhp5Zw4WTEP703SKroXH5K57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463103; c=relaxed/simple;
	bh=27/uXdpGHcncFOlSxDwRdjvgNaliKyoLpv4C5/cBwrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU0OpAJ7KqIQuwrxR40jFbCQpgOvla+3MVmhLybG0y1uMiNKnbt9pOayVVZt6f6eriG4NQLZXVh7E2VfC+FJaHvD2/2UTYpmVSjopAoZUCDug3mAdFoYECCi06ZIrPtHJihoXL+IDA7lQb3o/sJXanJM+MpW+o/cGqMXG9Ulpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAKnZiBT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713463102; x=1744999102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=27/uXdpGHcncFOlSxDwRdjvgNaliKyoLpv4C5/cBwrE=;
  b=jAKnZiBTs2/pWxLe4w4bwaJXu9GWWdGjHYxTm+wMzDFJmjq8S5WsnB38
   1cUf3Xu7560ECqkADeIhdKG3z2fGShE/0yN7NQl0xuTh0IaQwU6Muzkuo
   KEHynvJLXQd/VUDpUORZHalAeRCSt94VeKQf0vyriwEyPMHvHkcSEVehQ
   YqqKmKhWEiMWltltf75gE1mxQtJM28rtsu06xOmgz3ovPBXu5SteyJK95
   twuXaOHoVNAQUL/Kb9eexFUKh7An3sloK+8Hg8vzcFMt8SiC8ZB7ePyk5
   U7qJp1l5vQYsWBczNUmLB5JpAO6O4+dM+NDpErVVQduKaxWXxah/Uc/p4
   g==;
X-CSE-ConnectionGUID: /2jmpFMiSNSSIGbFsT3cOg==
X-CSE-MsgGUID: 00n/7oQGQfeEKdzBHrNOcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8956787"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8956787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:58:21 -0700
X-CSE-ConnectionGUID: 2LW46ca+RAaObzm62NgxXQ==
X-CSE-MsgGUID: +45gGWBQR5irnhv7ELeu7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27891075"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:58:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxW1W-00000000Qd4-30aR;
	Thu, 18 Apr 2024 20:58:14 +0300
Date: Thu, 18 Apr 2024 20:58:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
Message-ID: <ZiFfNl-wj3pzZqiH@smile.fi.intel.com>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
 <20240418170610.759838-2-rilian.la.te@ya.ru>
 <ZiFacIT0wzvhzaEk@smile.fi.intel.com>
 <CAF1WSuyauXes-RncLqRrYYaeP1KaDyfG82YcAaa8gK_mFUWCHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1WSuyauXes-RncLqRrYYaeP1KaDyfG82YcAaa8gK_mFUWCHg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 08:52:36PM +0300, Konstantin P. wrote:

Please, do not top post!

> How I should check this? Vladimir does not said anything about his tag
> scope - whether it applies only to patch 2 or to series as a whole, and
> initially I assumed than his tag were given only to patch 2.

If there was not explicitly said, the algo is following:
- if the tag against cover letter — all patches are covered
- otherwise only the patches reply to which has been sent

> But then you said than I missed his tag, so, I thought that it applies to
> series as a whole and in version 3 I added his tag to all patches.

I might missed the difference explained above. Sorry about that.

> On Thu, Apr 18, 2024, 20:37 Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Apr 18, 2024 at 08:06:05PM +0300, Konstantin Pugin wrote:
> > > From: Konstantin Pugin <ria.freelander@gmail.com>

..

> > I might have been not clear about Vladimir's tag. Please double check
> > if he gave it against the certain patch or the entire series.

-- 
With Best Regards,
Andy Shevchenko



