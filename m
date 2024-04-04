Return-Path: <linux-kernel+bounces-131470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F048898847
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7661F220AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887482869;
	Thu,  4 Apr 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1MtXQGT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605021E4A2;
	Thu,  4 Apr 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235096; cv=none; b=bgqtMH5bDx971ij4UmuB98XDq6y5RfO7M7y6lmMoxbT92TtM3P4XKaBo6E3G31n1aY74iLf0yAyf2h0VWkXUoe4LFnygfP2ykJnLqSfZgocahCObkDvjzRbW+04RZbEFGWmCEJuAy/i8PfVGes/Gw7MTJXpesvGkzbnBcBtbuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235096; c=relaxed/simple;
	bh=u4ww7v50CEjBfg1xgPiOEg+4022lXm9deC4xNxtry7M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k2sxapD3llKzxSdiNuRITK6E9R9TaO6n0FYk80HWmk41baTwlNr/nbsymdPk1Zdg3VJvNBSJCUIX0CdQrkn/QPYvWLjBKusulKkniz13cCGaZ26Py5SRsIBfX1hcLHCsmYkruBJ7LK6KNeOzunegITZ7C2qE3lo3BprQ1kIDcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1MtXQGT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712235092; x=1743771092;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=u4ww7v50CEjBfg1xgPiOEg+4022lXm9deC4xNxtry7M=;
  b=A1MtXQGTwOGaU3UBCnDgMzVtftasxT6wYnEODkzvA0WU3slchrKR4CrG
   er9KApRcjkOLNu2rHwBWdDr/NfIhDaVSL7Tt+PlLeM+S4j17+WMvwlO8n
   NM27sp0x9uim0NxcuyAUWbAlexe/Y3H1QPucteJ5XKwmzV9jnVzuDrryF
   ii2dI2zSCzKApgumvMQplVK3zSjGxzsRpY05Td2mpNm+2tT6CytVndCu4
   AJyVChg8ywkAO6qjV+Q1O3p4F8TCfTHz952ABIZf3hke8KVtZ9072vCtb
   4J1abyOM66+/A8jEa6HBPmFpbrE4cOHiEx9XpzApgdaK4wUURQWijE8t1
   g==;
X-CSE-ConnectionGUID: lKLZJo59TYe+8K+cUvPiyA==
X-CSE-MsgGUID: chhJ+CFuQ8G84ZOQM/Ipdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18245247"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18245247"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:51:27 -0700
X-CSE-ConnectionGUID: dc4W9nU5Tpq3eyvtZLpAog==
X-CSE-MsgGUID: YUucM6zASWCHFftmf3PyIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18704359"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.26])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:51:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 4 Apr 2024 15:51:19 +0300 (EEST)
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
In-Reply-To: <5181e9fa-2acc-4bc3-9f22-77ec519941ac@gmail.com>
Message-ID: <fde354a7-4947-e32f-4c35-8b5453257d8e@linux.intel.com>
References: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com> <980459bc-a781-1d2b-374c-da023d601c58@linux.intel.com> <998ee474-5e0c-4877-8a95-b22b0edd7837@gmail.com> <69e28674-58b8-4e77-b4b1-033ccb7e4dce@linux.intel.com>
 <5181e9fa-2acc-4bc3-9f22-77ec519941ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1823717409-1712234718=:2725"
Content-ID: <bdb796b6-f4a8-7bf1-8bd0-98d4177b0363@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1823717409-1712234718=:2725
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b08fb703-b434-9196-93b3-c9bebfa2f57d@linux.intel.com>

On Wed, 27 Mar 2024, Carlos Ferreira wrote:

> On 3/27/24 1:05 PM, Ilpo J=E4rvinen wrote:
>=20
> > On Tue, 26 Mar 2024, Carlos Ferreira wrote:
> >=20
> >> Hi, i have changed some of the code. How does it look now?
> >>
> >> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> >> ---
> >=20
> > First of all, you need to make a proper submission with versioning, tha=
t=20
> > is:
> >=20
> > - Put version into the subject: PATCH v2
> > - Don't put extra stuff into changelog like the above question, if you=
=20
> > need to ask something, put your question underneath the first --- line.
> > - List the changes you made underneath the first --- line (see ML=20
> > archives for examples about formatting)
>=20
> Should i submit the v2 patch with the current state or with the changes=
=20
> suggested such as the use of the leds API?=20

Please send v3 once you've made the changes, there's no need to send=20
patches which we know to become obsolete.

> >>  drivers/platform/x86/hp/hp-wmi.c | 251 +++++++++++++++++++++++++++++-=
-
> >>  1 file changed, 241 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/h=
p/hp-wmi.c
> >> index e53660422..8108ca7e9 100644
> >> --- a/drivers/platform/x86/hp/hp-wmi.c
> >> +++ b/drivers/platform/x86/hp/hp-wmi.c
> >> @@ -27,6 +27,7 @@
> >>  #include <linux/rfkill.h>
> >>  #include <linux/string.h>
> >>  #include <linux/dmi.h>
> >> +#include <linux/bitfield.h>
> >=20
> > Try to put it earlier, these should eventually be in alphabetic order=
=20
> > (again, ordered by a separate patch, not this one).
>=20
> You mean organizing all the imports like this?
> #include <linux/acpi.h>
> #include <linux/bitfield.h>
> #include <linux/dmi.h>
> #include <linux/hwmon.h>
> #include <linux/init.h>
> #include <linux/input.h>
> #include <linux/input/sparse-keymap.h>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/platform_device.h>
> #include <linux/platform_profile.h>
> #include <linux/rfkill.h>
> #include <linux/slab.h>
> #include <linux/string.h>
> #include <linux/types.h>

Yes.

If adding to a non-sorted list, the include should be placed before any=20
entries that are alphabetically after it but providing another patch=20
to sort them is of course even better than that.

--=20
 i.
--8323328-1823717409-1712234718=:2725--

