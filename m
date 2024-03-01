Return-Path: <linux-kernel+bounces-88823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2786E731
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6FE2895C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371DF51F;
	Fri,  1 Mar 2024 17:29:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34B79C2;
	Fri,  1 Mar 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314152; cv=none; b=RxWQ3iHI0sZF3yWYnq2lBwNYQq7GvuIrkeC9JkrDuR52aOg6YfouztYe8ND4JQwV+tS5AK8kMywt0WRtgMXh+ptOf+oPkE/Qu/Q8SzEkEQLS4E8/IJaSDePUv1g6nqb2bFGgzjWqrSvT3755+7+irXFEKah6AEcupIrixR7QCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314152; c=relaxed/simple;
	bh=cQbj9nw1nsXY6pJq/AyxfpVBj7eJaG3yYixrJ/2GWGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENeskhQVTkg4cOhg4Qr61nIBxZ2YX1ZHqOgVTN1paQ6o9kC1Q++hqiqeG3xDYKSZwtFfJ6s2Rj4+8M19RimbzuqpRVxx3o6/xlahqx0IDtZI0SFLr5VESmS0hX438gn6ayrE46Y808Dz/XqGyG3IZ/UAO6CMOIUvj/Y7ntfeA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15273528"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15273528"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:29:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914020951"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914020951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:29:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rg6h1-0000000910F-01ei;
	Fri, 01 Mar 2024 19:29:07 +0200
Date: Fri, 1 Mar 2024 19:29:06 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] string: Convert selftest to KUnit
Message-ID: <ZeIQYkRc_5lj6dd6@smile.fi.intel.com>
References: <20240301002416.it.092-kees@kernel.org>
 <20240301002650.1544829-1-keescook@chromium.org>
 <CAHp75VdhY6-OmNYtbpnb+dv1Du=LTnignsTRSU9+8yqpbFqPsQ@mail.gmail.com>
 <202403010921.65C845411@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202403010921.65C845411@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 09:25:07AM -0800, Kees Cook wrote:
> On Fri, Mar 01, 2024 at 01:09:27PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 1, 2024 at 2:26 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Convert test_string.c to KUnit so it can be easily run with everything
> > > else.
> > 
> > Have you run it?
> 
> Yes:

Of course I new the answer :-)

The problem as I described is the (absence of) fault injection in KUnit itself.
When tests are passed the picture is nice, when they are not, the reports become
a disaster (if this is applied).

-- 
With Best Regards,
Andy Shevchenko



