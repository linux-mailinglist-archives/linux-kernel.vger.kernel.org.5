Return-Path: <linux-kernel+bounces-135227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340589BD53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD136B22B15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFCF58108;
	Mon,  8 Apr 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ/brF4y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038C56461;
	Mon,  8 Apr 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572419; cv=none; b=sFYNWcsrzqu5DnmA/luurmvN5VEzcSdckJV+B5AH+ZpOJBP8hnEMGRPEjWJP1A858h7jt8wYipejF+hDu2xnat/lfbzbKuk5XsiKOp1ezdJez7+X8iFFkTCzlyYkCPEQZ3eho7eZvYEbnsF9wEa59/aZkyQL6dYPSmLKIyul+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572419; c=relaxed/simple;
	bh=ClOpZ0AHH9yZZkGvJ+uxL1FXrhBie5+wy8x5tlWlRsc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R17yFJXsVZjjssFUzIPZoQQlSKpBUveaIn40srMn9/H/y0eGAN0oycoWRCRqgDEw7e+MNlj1pFvZbO1iQKLkka4tDIV2XguOD1i/MlA+Oa7QeHnyB7mAtaMaGuzyeJrCy1WKs5O/6Teerqpv95xxDrrMQj+Ng7fqEl0hoF/elEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ/brF4y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712572418; x=1744108418;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ClOpZ0AHH9yZZkGvJ+uxL1FXrhBie5+wy8x5tlWlRsc=;
  b=ZZ/brF4yf1EaHXq0cvyumsOHxd5xJ9rAAWoavKai/qe9LTbel3Qs6GVp
   IfBwkp1fflM7usGAIsptrCgr2qLYmA85U8LOwsYWr+C0z1ShXNpnydVgu
   W4YMv/dWPbQYLCbQr/P01/isEypqA+c90yfAoj8N+1Mkw4t1/4TfWLGUn
   pg9wkpItkdPTeJYfTywuDLZYzKogVlScSTNUK3c2SW8ngTs+hjRXibYAx
   gGCz1LCwbXgRqJF7QIPDU4eElKLJXlyqlutlvRoBx4WWCWFxBsuxFNuOC
   EHiEeWlbgtJdYEeEWp+omFQQennzf7xEXV8zgdBQ7mLK1He9j2F5DucMp
   A==;
X-CSE-ConnectionGUID: rbWS5ig5TXK3Pb6GG89llA==
X-CSE-MsgGUID: qjBqXD34QUaPMklqCImTKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19212441"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19212441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:33:37 -0700
X-CSE-ConnectionGUID: 40eWzVcvT8+d8Jcpadl6ew==
X-CSE-MsgGUID: /KCd51CkSYuRPI3FXVJx9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24586450"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:33:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 13:33:29 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
    linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: quickstart: Fix race condition when
 reporting input event
In-Reply-To: <b5d808fd-f9c4-48d5-b888-c4ded4b0cad6@redhat.com>
Message-ID: <6d89b1f3-f37d-918d-b497-fc9b877ac297@linux.intel.com>
References: <20240327214524.123935-1-W_Armin@gmx.de> <f662fab0-0f47-4b71-ab71-2b9492253483@gmx.de> <b5d808fd-f9c4-48d5-b888-c4ded4b0cad6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 7 Apr 2024, Hans de Goede wrote:
> On 4/6/24 8:57 PM, Armin Wolf wrote:
> > Am 27.03.24 um 22:45 schrieb Armin Wolf:
> > 
> >> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
> >> on all CPUs"), the ACPI core allows multiple notify calls to be active
> >> at the same time. This means that two instances of quickstart_notify()
> >> running at the same time can mess which each others input sequences.
> >>
> >> Fix this by protecting the input sequence with a mutex.
> >>
> >> Compile-tested only.
> > 
> > Any thoughts on this?
> 
> I wonder if we need this at all ?
> 
> The input_event() / input_report_key() / input_sync() functions
> which underpin sparse_keymap_report_event() all are safe to be called
> from multiple threads at the same time AFAIK.
> 
> The only thing which can then still go "wrong" if we have
> 2 sparse_keymap_report_event() functions racing for the same
> quickstart button and thus for the same keycode is that we may
> end up with:
> 
> input_report_key(dev, keycode, 1);
> input_report_key(dev, keycode, 1); /* This is a no-op */
> input_sync(); /* + another input_sync() somewhere which is a no-op */
> input_report_key(dev, keycode, 0);
> input_report_key(dev, keycode, 0); /* This is a no-op */
> input_sync(); /* + another input_sync() somewhere which is a no-op */
> 
> IOW if 2 racing notifiers hit the perfect race conditions then
> only 1 key press is reported, instead of 2 which seems like
> it is not a problem since arguably if the same event gets
> reported twice at the exact same time it probably really
> is only a single button press.
> 
> Also I think it is highly unlikely we will actually see
> 2 notifiers for this racing in practice.
> 
> So I don't think we need this at all. But if others feel strongly
> about adding this I can still merge it... ?

Hi,

I know you already merged this and I agree it's not very likely race but 
still it can turn two presses into one which seems unwanted side-effect, 
even if it's unlikely to occur in practice.

-- 
 i.


