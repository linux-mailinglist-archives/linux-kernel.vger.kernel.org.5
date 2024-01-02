Return-Path: <linux-kernel+bounces-14000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3038216AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595581F2190A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193310EC;
	Tue,  2 Jan 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mvb+BPh4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9920E0;
	Tue,  2 Jan 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704166753; x=1735702753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mXMcv0AhIvrLmeabUc73o/ZBWaLRRjH+EzWOYT+W7IM=;
  b=Mvb+BPh4MbYQQizCjMfpYbkE2Pw56M5Q+xEamQRlqNd53mX0N8F+sAyp
   EG2JZU2a+nkjsOEzoqYCEvMYcZNACLYVt0b0VzY/ZE/En3PXySgvHYAjK
   HZUkEnw6J/2sUbVTVUEirtjWlTlHJOS5alGCkU+RUWy2umLX8zKS771td
   4KQw24O4sTDuS6xS3hDoZZKKDpIWBjLziBoJcnN+GNF3iOY8tOxeZITSa
   5xeW35qUzRwCyK+mjlvD81gfGNOUpQN4Md4ovP2rCjz+Ai4AhUWlb07NV
   JIDocYeHJapOqKBip7h55iSGhlc198brx4WZNgll/ZbMuRGdlVTlnYG+b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="395721108"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="395721108"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="21355779"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:39:13 -0800
Date: Mon, 1 Jan 2024 19:40:50 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	stable@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 4/4] thermal: intel: hfi: Add a suspend notifier
Message-ID: <20240102034050.GA8661@ranerica-svr.sc.intel.com>
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
 <20231227062940.10780-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hHu7R+mnW=w1NM80=Ha0QL853+O6i3RKrw18wuhRPUOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hHu7R+mnW=w1NM80=Ha0QL853+O6i3RKrw18wuhRPUOg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Dec 29, 2023 at 06:27:30PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 27, 2023 at 7:28 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The kernel gives the HFI hardware a memory region that the latter uses to
> > provide updates to the HFI table. The kernel allocates this memory region
> > at boot. It remains constant throughout runtime time.
> >
> > When resuming from suspend or hibernation, the restore kernel allocates a
> > second memory buffer and reprograms the HFI hardware with the new location
> > as part of a normal boot. The location of the second memory buffer may
> > differ from the one allocated by the image kernel. Subsequently, when the
> > restore kernel transfers control to the image kernel, the second buffer
> > becomes invalid, potentially leading to memory corruption if the hardware
> > writes to it (hardware continues using the buffer from the restore kernel).
> >
> > Add a suspend notifier to disable all HFI instances before jumping to the
> > image kernel and enable them once the image kernel has been restored. Use
> > the memory buffer that the image kernel allocated.
> >
> > For non-boot CPUs, rely on the CPU hotplug callbacks as CPUs are disabled
> > and enabled during suspend and resume, respectively.
> >
> > The CPU hotplug callbacks do not cover the boot CPU. Handle the HFI
> > instance of the boot CPU from the suspend notifier callback.
> >
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 53 +++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index d2c874f43786..965c245e5e78 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -30,11 +30,13 @@
> >  #include <linux/kernel.h>
> >  #include <linux/math.h>
> >  #include <linux/mutex.h>
> > +#include <linux/notifier.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/printk.h>
> >  #include <linux/processor.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/suspend.h>
> >  #include <linux/string.h>
> >  #include <linux/topology.h>
> >  #include <linux/workqueue.h>
> > @@ -569,11 +571,62 @@ static __init int hfi_parse_features(void)
> >         return 0;
> >  }
> >
> > +static void hfi_do_pm_enable(void *info)
> > +{
> > +       struct hfi_instance *hfi_instance = info;
> > +
> > +       hfi_set_hw_table(hfi_instance);
> > +       hfi_enable();
> 
> The above do RMW, so should locking be used here?
> 
> > +}
> > +
> > +static void hfi_do_pm_disable(void *info)
> > +{
> > +       hfi_disable();
> > +}
> 
> And here?

On single-package systems, HFI enable/disable only happens on the boot CPU,
via either the CPU hotplug callbacks or the suspend notifier. It is
unlikely they will run concurrently, IMO. It also looks as good hygiene to
me to use locking, just in case. I will use the hfi_instance_lock in my
next version.

On multi-package systems, HFI instance of non-boot packages are always
handled via the CPU hotplug callbacks.
 
> 
> > +
> > +static int hfi_pm_notify(struct notifier_block *nb,
> > +                        unsigned long mode, void *unused)
> > +{
> > +       struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
> > +       struct hfi_instance *hfi_instance = info->hfi_instance;
> > +
> > +       /* HFI may not be in use. */
> > +       if (!hfi_instance)
> > +               return 0;
> > +
> > +       /*
> > +        * Only handle the HFI instance of the package of the boot CPU. The
> > +        * instances of other packages are handled in the CPU hotplug callbacks.
> > +        */
> > +       switch (mode) {
> > +       case PM_HIBERNATION_PREPARE:
> > +       case PM_SUSPEND_PREPARE:
> > +       case PM_RESTORE_PREPARE:
> > +               return smp_call_function_single(0, hfi_do_pm_disable,
> > +                                               NULL, true);
> > +
> > +       case PM_POST_RESTORE:
> > +       case PM_POST_HIBERNATION:
> > +       case PM_POST_SUSPEND:
> > +               return smp_call_function_single(0, hfi_do_pm_enable,
> > +                                               hfi_instance, true);
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static struct notifier_block hfi_pm_nb = {
> > +       .notifier_call = hfi_pm_notify,
> > +};
> > +
> >  void __init intel_hfi_init(void)
> >  {
> >         struct hfi_instance *hfi_instance;
> >         int i, j;
> >
> > +       if (register_pm_notifier(&hfi_pm_nb))
> > +               return;
> > +
> >         if (hfi_parse_features())
> >                 return;
> >
> > --

