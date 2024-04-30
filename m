Return-Path: <linux-kernel+bounces-164116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6838B7931
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FACCB2570F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA917967F;
	Tue, 30 Apr 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnoV6neI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A617332C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486404; cv=none; b=ORwszeEioK8pJVcRIzhYHoMeZ5hqfMR2CtaAfCKycih0r6/ACdf5LZhvk1MbEgpebnmgOE9sm783FRzScP6cfkUcs0k5ocQPJJzd1QVKWlmr8ASLRkQl8V63CMtXtoEx6WNbm3sUTfInDXU+cYwMDPH4OwefymbEuyDmGn8lGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486404; c=relaxed/simple;
	bh=lelmsBYbONgVYqEn7nVVHP02HO1K0e9/ctQsupwxquk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slw4dKMMtHoLNz5r+80zIII892CR7h9SHTinED2Xp/yPlRM39n/+i2CcyB8e2o0nc8GMZK1hHlJieUQ5SLl46MZgo8A68n1tzutRaLU+R5kOZJcA1+xc6GSzCMnqMoDTiz8XcXU1wOn5/Pi2zP5OAsxCFKKFkQ9te+g0GDFldGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnoV6neI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714486402; x=1746022402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lelmsBYbONgVYqEn7nVVHP02HO1K0e9/ctQsupwxquk=;
  b=mnoV6neIsWUqCOZfWHl4BbIe8PGP19YEkHtdgfkUGAf6EgjBkOhKNvVZ
   Kb+AohTt6wggmQiGtKxWyy58bX0+8jfM0tJoTeqDiJKiOnzgSAbogZVrs
   PIh5BtNJgG7WmlCqSC+VM7kXVYIO1KRdrPGVYXLeCjhytyhFH4eSyql+R
   5TwpRzNPj/c52oBQgg+S7oXaQ7n7viuC6U/KHVa9DpKPXUbY0gOPbGuiW
   1HeyAzwCyikOcpuyAG7QALiwLNpKcEPAsaQzcK3a7Hl0vAYYcZ9GrQpbu
   cppCaqcZ9nsRT92/REhVekuWnqO5OwhvvxexYHnWNVqeE/0Q46Lxsvyaj
   Q==;
X-CSE-ConnectionGUID: bSjri0yMRfaBYnjaNioi9A==
X-CSE-MsgGUID: q9Nn2PBLTYGTwoT/BRiXRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10415869"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10415869"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:13:21 -0700
X-CSE-ConnectionGUID: 7SWS+IY4Rm2nTarWhsdxmw==
X-CSE-MsgGUID: DoelbldRQBW16bD2Dl8VJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31272374"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:13:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1oEN-00000002gh3-0hw4;
	Tue, 30 Apr 2024 17:13:15 +0300
Date: Tue, 30 Apr 2024 17:13:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <ZjD8eoO3TmuCUj-a@smile.fi.intel.com>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
 <ZiqrLfezhns4UycR@smile.fi.intel.com>
 <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:
> On 2024/4/26 03:12, Andy Shevchenko wrote:
> > On Fri, Apr 26, 2024 at 02:53:22AM +0800, Sui Jingfeng wrote:
> > > On 2024/4/26 02:08, Sui Jingfeng wrote:

..

> > Are you speaking to yourself? I'm totally lost.
> > 
> > Please, if you want to give a constructive feedback, try to understand
> > the topic from different aspects and then clearly express it.
> 
> OK,
> 
> The previous email analysis the non-DT cases exhaustively, this email intend to
> demonstrate the more frequently use case.
> 
> That is, in the *DT('OF')* based systems,
> device_get_match_data() is completely equivalent to
> of_device_get_match_data().

> So the net results of applying this patch are "no gains and no lost".

This is not true. It's only part of the cases, i.e. DT. So, I assume you meant

  "So the net results of applying this patch are "no gains and no lost" in DT case".

> Things will become clear if we divide the whole problem into two cases(DT and non-DT)
> to discuss, that's it. That's all I can tell.

Not really. non-DT cases can also be divided to "fwnode backed or not", and
the former might be subdivided to "is it swnode backed or real fwnode one?"

-- 
With Best Regards,
Andy Shevchenko



