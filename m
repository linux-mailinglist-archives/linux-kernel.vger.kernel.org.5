Return-Path: <linux-kernel+bounces-150204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D698A9BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D975EB20F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316416086C;
	Thu, 18 Apr 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfKz6XKj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764FEAD2;
	Thu, 18 Apr 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448317; cv=none; b=eGDOolQl9N3fOoPFAmDgUeczqziUgX9m7QWJKFYMAllUShczcPShPe6RnvQBTcdh0Dc5fRog5jZggfRyd0omNMjIEYZGfTZuFiwPnJ6M9sLW9dcV3BTQuuza8VoAHQrIrFhMYow4NDI5ghgfqnQSiFyCl61sVX0fBoLRCQXjvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448317; c=relaxed/simple;
	bh=/AePQYYlE4rgjN8mQKUL+TS+cAZpdj5pA/ak+RGccg0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f74mTJ0v4oEfLYNe8MEzINp0yb6+xgf8B56aANiRs6meup5LdOLv9UQv37+QG0w/y/B5cpHj8G3sPgpI8JwVcCZv8r2jsC//QykwpTymTsS6/LRP8aer3+C7vhzE1/uJYSgyDJdZKgPLsSuQtAqfJtnvkzxIlKwjBUpjznt0EcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfKz6XKj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713448316; x=1744984316;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/AePQYYlE4rgjN8mQKUL+TS+cAZpdj5pA/ak+RGccg0=;
  b=EfKz6XKj//AsIqmokuvJy/0wjWZ1af32eMvDaLHCuQt71a7ClLJKjWTV
   VPIURnNIoB5gJ2l2j44Kvm7szf/vA7Na6+YO4/MK0mjmA4SMyYUifdVcs
   BsqAFTt5i76lqIJZ3WpYHm4w4x/l0buldwBC616nxUO0D/EqCvFSUdVrh
   nKuCICCzUgz2fKQITEYgUdY8UcUoJbdCeEa+Oi+67TVHRBrytvLbC2s2N
   WtgCLW542F0nh0VMZptO70hm+AZ5yE7f8TrPtVGaRlzDIKV9dmQmrA2yv
   7yyTbsExPeLaCrt7Fitfnsgoca/jCC5p0oznoCUh5dgtMQQZBJ02G+WQY
   A==;
X-CSE-ConnectionGUID: r6vBJUM1QJmfqwhuRiMyOw==
X-CSE-MsgGUID: mRYn5ptDSF6uaJO/rk6aKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12782296"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12782296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:51:55 -0700
X-CSE-ConnectionGUID: ixemoxb4TrCbHevpB1fLhw==
X-CSE-MsgGUID: JzYUla7xQQyT19Tsnj/nWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="60415341"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:51:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 16:51:48 +0300 (EEST)
To: Mario Limonciello <superm1@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    Carlos Bilbao <carlos.bilbao@amd.com>, 
    "open list:AMD HSMP DRIVER" <platform-driver-x86@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] platform/x86/amd: Don't allow HSMP to be loaded on
 non-server hardware
In-Reply-To: <1071ea83-7919-469a-ac5b-3209fe9e018c@gmail.com>
Message-ID: <85728284-d771-bf06-9ed3-333633ebf8b0@linux.intel.com>
References: <20240416182057.8230-1-superm1@gmail.com> <ca6e0dc7-f5ea-4c0a-b9fe-0667fadc78a6@redhat.com> <1071ea83-7919-469a-ac5b-3209fe9e018c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 18 Apr 2024, Mario Limonciello wrote:
> On 4/18/24 04:04, Hans de Goede wrote:
> > On 4/16/24 8:20 PM, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > If the HSMP driver is compiled into the kernel or a module manually loaded
> > > on client hardware it can cause problems with the functionality of the PMC
> > > module since it probes a mailbox with a different definition on servers.
> > > 
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2414
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3285
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v1->v2:
> > >   * use pm preferred profile instead
> > 
> > Thanks, patch looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Mario, should this go in as a fix for the 6.9 cylce, or is
> > this for-next material ?  (I'm not sure what to do myself)
> The main risk with this patch is if there are servers that previously loaded
> amd-hsmp no longer working because of a BIOS bug to exporting the incorrect
> profile.  I think this is quite unlikely but not non-zero.
> 
> To at least give some time for anything like that to be raised I feel this
> should go to for-next.

I was also thinking it would be better to route this through for-next.

> Ideally I do want to see it go to stable kernels after we're all sufficiently
> happy though.  Random bug reports to me like the ones I added to the commit
> message get raised mostly by people who compile their own (stable) kernels and
> enable all the AMD stuff because they have AMD hardware.
> 
> So how about we target for-next, but also add a stable tag for when it gets
> merged in the 6.10 cycle?

That's possible but if you want to retain true control over it, don't add 
stable tag at all now. You can send it on your own volition into stable 
address later once the change is in Linus' tree and your "happy" condition 
is met (Option 3 in Documentation/process/stable-kernel-rules.rst). 

Otherwise, stable will autoselect it the moment it lands into Linus' tree
and you don't have much control over the timeline from that point on (I've 
seen stable folks to grumble when somebody asked to delay including a 
patch marked for stable, their reasoning was that their autotools keep 
reselecting the patch over and over again).

-- 
 i.


