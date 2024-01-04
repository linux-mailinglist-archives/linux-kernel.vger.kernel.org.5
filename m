Return-Path: <linux-kernel+bounces-16220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C1823AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E880D288316
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F65240;
	Thu,  4 Jan 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxDhnQvY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7671DFD8;
	Thu,  4 Jan 2024 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704337240; x=1735873240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yaDLGvF9wR/ctjP624ukW1EH4EGl70kMewqF1RnroX0=;
  b=CxDhnQvYNVGuUDB6b0x1rv5eRzu/HFhn2L30qwPLkW5WTgreqlff/UOf
   q+M/dbRph5vR+jJbzfdobz4T2OOD1fJQBcdSdqOijYfiD7qBARbQJT4ar
   U7Ytyc4uEdE51CdAtNZSbChtbfpP5hGaVMWEpVeNG4TEkS4douSqbX+Xe
   xbO7VF85Wfz5mPD+As2DK8Qyr1qNuDpaS9YykbHiVKVvtBddgJGOUyXto
   yv2ddQTc6WPK7m+itHa/+FRf/sjqJTIUYPzfLlMEaQTL1XNKnTRs3OIrT
   OPDDfXBbfN31oU0jWyf4pSz6wK5Sx7TMpkf/oUs5XPbcTX6oe8sz6jn4W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4191099"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="4191099"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1111566979"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="1111566979"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:00:38 -0800
Date: Wed, 3 Jan 2024 19:02:15 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
Message-ID: <20240104030215.GA12718@ranerica-svr.sc.intel.com>
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
 <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
 <CAJZ5v0inNopOHMJ85pjHNLXi0kRuJaLLA2aF=fZF3jWTbC7r=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0inNopOHMJ85pjHNLXi0kRuJaLLA2aF=fZF3jWTbC7r=g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jan 03, 2024 at 02:38:26PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 3, 2024 at 2:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > The subject should say "add a PM notifier" to indicate that
> > hibernation is covered too.
> >
> > On Wed, Jan 3, 2024 at 5:13 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > The kernel gives the HFI hardware a memory region that the latter uses to
> > > provide updates to the HFI table. The kernel allocates this memory region
> > > at boot. It remains constant throughout runtime time.
> > >
> > > When resuming from suspend or hibernation, the restore kernel allocates a
> >
> > The restore kernel is only used during resume from hibernation, so
> > this particular problem is hibernation-specific.
> >
> > It is possible, at least in principle, that the address of the HFI
> > table is "lost" by the processor during resume from "deep" suspend
> > (ACPI S3), in which case it may not survive the firmware-driven part
> > of the suspend-resume cycle.  It is thus prudent to disable HFI on
> > suspend and re-enable it on resume for the boot CPU (under the
> > assumption that the other CPUs will be taken care of by CPU offline),
> > but for a somewhat different reason than in the hibernation case.
> >
> > > second memory buffer and reprograms the HFI hardware with the new location
> > > as part of a normal boot. The location of the second memory buffer may
> > > differ from the one allocated by the image kernel. Subsequently, when the
> > > restore kernel transfers control to the image kernel, the second buffer
> > > becomes invalid, potentially leading to memory corruption if the hardware
> > > writes to it (hardware continues using the buffer from the restore kernel).
> > >
> > > Add a suspend notifier to disable all HFI instances before jumping to the
> > > image kernel and enable them once the image kernel has been restored. Use
> > > the memory buffer that the image kernel allocated.
> > >
> > > For non-boot CPUs, rely on the CPU hotplug callbacks as CPUs are disabled
> > > and enabled during suspend and resume, respectively.
> > >
> > > The CPU hotplug callbacks do not cover the boot CPU. Handle the HFI
> > > instance of the boot CPU from the suspend notifier callback.
> > >
> > > Cc: Chen Yu <yu.c.chen@intel.com>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: stable@vger.kernel.org    # 6.1
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > --
> > > Changes since v1:
> > >  * Moved registration of the suspend notifier towards the end of
> > >    intel_hfi_init(). (Stan)
> > >  * Renamed hfi_do_pm_[enable|disable]() to hfi_do_[enable|disable](). Stan
> > >    will use these functions outside the suspend notifier. (Stan)
> > >  * Added locking to calls to hfi_[enable|disable]() from the suspend
> > >    notifier. (Rafael)
> > > ---
> > >  drivers/thermal/intel/intel_hfi.c | 62 +++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >
> > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > index 22445403b520..8d6e4f8dc67a 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -30,11 +30,13 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/math.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/notifier.h>
> > >  #include <linux/percpu-defs.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/processor.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/suspend.h>
> > >  #include <linux/string.h>
> > >  #include <linux/topology.h>
> > >  #include <linux/workqueue.h>
> > > @@ -571,6 +573,60 @@ static __init int hfi_parse_features(void)
> > >         return 0;
> > >  }
> > >
> > > +static void hfi_do_enable(void *info)
> > > +{
> > > +       struct hfi_instance *hfi_instance = info;
> > > +
> > > +       hfi_set_hw_table(hfi_instance);
> > > +       hfi_enable();
> > > +}
> > > +
> > > +static void hfi_do_disable(void *info)
> > > +{
> > > +       hfi_disable();
> > > +}
> > > +
> > > +static int hfi_pm_notify(struct notifier_block *nb,
> > > +                        unsigned long mode, void *unused)
> > > +{
> > > +       struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
> > > +       struct hfi_instance *hfi = info->hfi_instance;
> > > +       int ret = 0;
> > > +
> > > +       /* HFI may not be in use. */
> > > +       if (!hfi)
> > > +               return ret;
> > > +
> > > +       mutex_lock(&hfi_instance_lock);
> > > +       /*
> > > +        * Only handle the HFI instance of the package of the boot CPU. The
> > > +        * instances of other packages are handled in the CPU hotplug callbacks.
> > > +        */
> > > +       switch (mode) {
> > > +       case PM_HIBERNATION_PREPARE:
> > > +       case PM_SUSPEND_PREPARE:
> > > +       case PM_RESTORE_PREPARE:
> > > +               ret = smp_call_function_single(0, hfi_do_disable, NULL, true);
> > > +               break;
> > > +
> > > +       case PM_POST_RESTORE:
> > > +       case PM_POST_HIBERNATION:
> > > +       case PM_POST_SUSPEND:
> > > +               ret = smp_call_function_single(0, hfi_do_enable, hfi, true);
> > > +               break;
> >
> > Because this handles the boot CPU only, one has to wonder if it should
> > be a syscore op rather than a PM notifier.
> >
> > It does not sleep AFAICS, so it can run in that context, and it is
> > guaranteed to run on the boot CPU then, so it is not necessary to
> > force that.  Moreover, syscore ops are guaranteed to be
> > non-concurrent, so locking is not needed.
> >
> > In addition, disabling HFI from a PM notifier is generally observable
> > by user space, because PM notifiers run before user space is frozen,
> > but doing it from a syscore op wouldn't be.

Yes, we only have to handle the boot CPU. The rest are handled via CPU
offline. Then syscore ops look like a good fit for me.

> 
> One more thing: PM notifiers run on all variants of system suspend and
> resume, including suspend-to-idle in which case HFI need not be
> disabled/enabled IIUC and syscore ops only run in hibernation and
> "deep" suspend cycles, so they cover the cases in which the special
> handling is really needed and don't add useless overhead otherwise.

I verified that the HFI configuration survives suspend-to-idle. No extra
handling is needed.

