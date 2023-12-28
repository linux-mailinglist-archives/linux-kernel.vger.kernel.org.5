Return-Path: <linux-kernel+bounces-12765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C4F81F9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9781C22666
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE48F4FD;
	Thu, 28 Dec 2023 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC4AYyKC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6AF4E3;
	Thu, 28 Dec 2023 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703778224; x=1735314224;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hd3EavwOQW0OaMdWfCDBUm6GSWuwvo8Z9sDjrMbIH10=;
  b=DC4AYyKCGbQ/bhKgxT9kjcX3lvczoJavvFxF7PKi74olAvA+Z9Oqon9E
   o0LAf1yjYMbXobGqoXvGe3ueHzFlrZezRYcCSaNgLV2LnN4QHCJGG7heX
   7kc+rNsepoBhIfmY4sikKOTg9Zl1Xk+6mES0uC48lOWMcGgruFbotZQXD
   HCkpHG7ZgYo/109zznqibgH6eCvKaWnKfIzwMkAXYn2HEZ4tCmq4filbE
   s590cLtKEO3UFsaMPcU7HsSEqiNv6mECIU7XCBNIoYmAdh4vltKOSFdEA
   Xz5yTpn+DGXs3bTsGF/qWnoFXjyPvtEl0iN1CkrIfbqC9oR98cdacMBn4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427729100"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="427729100"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="897231092"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="897231092"
Received: from rbiessy-mobl.ger.corp.intel.com (HELO flakhal-mobl.ger.corp.intel.com) ([10.252.50.223])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:43:41 -0800
Date: Thu, 28 Dec 2023 17:43:39 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: "David E. Box" <david.e.box@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, rajvi.jingar@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] platform/x86/intel/pmc: Allow reenabling LTRs
In-Reply-To: <e83492f-8c94-b43b-6fdc-aed6ea6251@linux.intel.com>
Message-ID: <fd427a94-fc7d-131b-8f44-3cd0bba51757@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com> <20231223032548.1680738-5-david.e.box@linux.intel.com> <e83492f-8c94-b43b-6fdc-aed6ea6251@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-282832193-1703778223=:2140"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-282832193-1703778223=:2140
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 27 Dec 2023, Ilpo Järvinen wrote:

> On Fri, 22 Dec 2023, David E. Box wrote:
> 
> > Commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
> > core_configure()") caused a network performance regression due to the GBE
> > LTR ignore that it added during probe. The fix will move the ignore to
> > occur at suspend-time (so as to not affect suspend power). This will
> > require the ability to enable the LTR again on resume. Modify
> > pmc_core_send_ltr_ignore() to allow enabling an LTR.
> > 
> > Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel/pmc/adl.c  | 2 +-
> >  drivers/platform/x86/intel/pmc/cnp.c  | 2 +-
> >  drivers/platform/x86/intel/pmc/core.c | 9 ++++++---
> >  drivers/platform/x86/intel/pmc/core.h | 3 ++-
> >  drivers/platform/x86/intel/pmc/mtl.c  | 2 +-
> >  drivers/platform/x86/intel/pmc/tgl.c  | 2 +-
> >  6 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
> > index 882f2d5d8937..fbe0678f766c 100644
> > --- a/drivers/platform/x86/intel/pmc/adl.c
> > +++ b/drivers/platform/x86/intel/pmc/adl.c
> > @@ -327,7 +327,7 @@ int adl_core_init(struct pmc_dev *pmcdev)
> >  	 * when a cable is attached. Tell the PMC to ignore it.
> >  	 */
> >  	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
> > -	pmc_core_send_ltr_ignore(pmcdev, 3);
> > +	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> > index 59298f184d0e..80f73242f9dd 100644
> > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > @@ -220,7 +220,7 @@ int cnp_core_init(struct pmc_dev *pmcdev)
> >  	 * when a cable is attached. Tell the PMC to ignore it.
> >  	 */
> >  	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
> > -	pmc_core_send_ltr_ignore(pmcdev, 3);
> > +	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> > index 31905003bb05..aa44c6612af9 100644
> > --- a/drivers/platform/x86/intel/pmc/core.c
> > +++ b/drivers/platform/x86/intel/pmc/core.c
> > @@ -476,7 +476,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
> >  
> > -int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
> > +int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
> 
> Nothing seems to need int for anything and it's used like a bool. So 

Note that I've merged this change without changing these into bool. Please 
consider making a follow up change to the type after next -rc1 when 
things have settled down.

> > +++ b/drivers/platform/x86/intel/pmc/core.h
> > @@ -567,7 +567,8 @@ extern const struct pmc_reg_map arl_pchs_reg_map;
> >  
> >  extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
> >  extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
> > -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
> > +extern int
> > +pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
> 
> extern is unnecessary.

While merging, I dropped this one as I had to resolve a conflict here 
anyway.

Patches 3-5 are now in review-ilpo towards fixes branch. Please do double 
check they're correct because the conflicts were quite large.


-- 
 i.

--8323329-282832193-1703778223=:2140--

