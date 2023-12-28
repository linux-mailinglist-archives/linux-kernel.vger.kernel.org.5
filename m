Return-Path: <linux-kernel+bounces-12764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDC81F9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16EC285819
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8FF4FD;
	Thu, 28 Dec 2023 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU/y6kVU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FEF4E1;
	Thu, 28 Dec 2023 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703777946; x=1735313946;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=UDVSTUQkGYULwaIRbz5h7mWYWZvGcpZTi+WQx2eabC0=;
  b=mU/y6kVUtoluoMzARZrNxaOos9uxkV65wNKP8Rc+jLzhp2g55TMppi+j
   DfS0DxR3DDge7c39I7U4qjfqdvNLojXQ85QJ8xm+5zc7kPtiWUIc1SIMR
   r5ukPKBg+DHoyMrl5E0nJgG5vXt/35JMHOj5sq6e33rF2WHJS3KvdrJLL
   QsXlVh9+YcC8Uhf3mx/VVGu/+YC5CFJQlfHf5CQHbQ6otDAst1y+LYzRP
   BbSS5/HN7TD7XwyicWwyrN8gvPSIGE4jAfsC7im1HboF1GOsj+GgbIZJy
   H5IaB6VqCzGpTWxJpuoQuxS0XndZ21CXPKqQeohDYzuQz1F7eroDHLNgA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="482736180"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="482736180"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="13027745"
Received: from rbiessy-mobl.ger.corp.intel.com (HELO flakhal-mobl.ger.corp.intel.com) ([10.252.50.223])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:39:03 -0800
Date: Thu, 28 Dec 2023 17:38:56 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
cc: "David E. Box" <david.e.box@linux.intel.com>, rajvi.jingar@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] Intel PMC Core GBE LTR regression fix
In-Reply-To: <f51a4bc1-b38c-43c0-8e8a-28463c49c1f6@redhat.com>
Message-ID: <eb9c49c5-f74d-7b69-f5ae-2b18d174dfe8@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com> <652cf483-6098-5e0-94ef-fdca344fa2ac@linux.intel.com> <f51a4bc1-b38c-43c0-8e8a-28463c49c1f6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1661720780-1703777570=:2140"
Content-ID: <b8163021-cde-4c24-b0c1-3983797ba3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1661720780-1703777570=:2140
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <7f1f1131-2141-7769-469b-e9365cb3eb14@linux.intel.com>

On Thu, 28 Dec 2023, Hans de Goede wrote:
> On 12/27/23 19:14, Ilpo Järvinen wrote:
> > On Fri, 22 Dec 2023, David E. Box wrote:
> > 
> >> This patch series addresses the network performance regression caused by
> >> commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
> >> core_configure()").
> >>
> >> Unfortunately, the regression is included in the recent Lunar Lake and
> >> Arrow Lake support patches in the review branch. Patches 1 and 2 remove the
> >> LTR ignore without a fix. They may be folded into the respective enabling
> >> patches indicated in the changelog. This is done so that the next patches
> >> fixing the regression can be backported to stable kernels with fewer, if
> >> any, conflicts.
> >>
> >> Patches 3 and 4 provide the support needed for Patch 5 to move the GBE LTR
> >> ignore from probe-time to suspend/resume time. All three carry the same
> >> Fixes tag so that the stable kernels can pick them up without causing a
> >> separate suspend-time PC10 regression.
> >>
> >> Patches 6 and 7 then add the LTR suspend/resume fix for Arrow Lake and
> >> Lunar Lake. Of course, they cannot be folded into the enabling patches
> >> unless the LTR fixes (3-5) are applied before. Sorry about this :(.
> > 
> > Wow, this is messy...
> > 
> > So the best order would be placing 3-5 before these Arrow Lake and Lunar 
> > Lake commits in for-next:
> >   119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
> >   f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
> > ? And then folding 1-2 and 6-7 into those respective commits?
> > 
> > It makes me wonder though why those two commits couldn't have been delayed 
> > slightly to get these fixes included first... :-/
> 
> To untangle this mess I have squashed patches 1-2 into the original
> commits in for-next, so that there won't be a conflict
> between next and fixes when merging patches 3-5 into fixes.

Dream on, there will be conflicts, rest assured...

> Ilpo can you pick-up patches 3-5 for the fixes branch ?

I've now done that and resolved a few conflicts while doing so which 
you'll encounter while back-merging.

> And maybe also "platform/x86: p2sb: Allow p2sb_bar() calls during PCI
> device probe" fix ? I know you have a small review comment on this patch,
> but IMHO waiting for the small unrelated cleanup to be split out is not
> worth delaying this deadlock fix. As for the missing fixes tag I believe
> that should be:
> 
> Fixes: 9745fb07474f ("platform/x86/intel: Add Primary to Sideband (P2SB) bridge support")
> 
> And then do one more fixes pull-request for the GBT LTR fixes +
> the P2SB deadlock fix ?
> 
> I know it is the holiday season, but if you feel up to it,
> it would be nice to get those fixes on their way to Linus
> and the stable kernels a bit earlier then before 6.8-rc1 .

They're in the hands of lkp.

> I'll merge patches 6-8 into for-next then after back-merging
> the fixes.

-- 
 i.
--8323329-1661720780-1703777570=:2140--

