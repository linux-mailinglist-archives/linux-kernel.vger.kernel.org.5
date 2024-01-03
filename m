Return-Path: <linux-kernel+bounces-15798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA282332D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B411C23B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C61C298;
	Wed,  3 Jan 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJtJBiNZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17931C280;
	Wed,  3 Jan 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704302816; x=1735838816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJE3hRpgK0X23wIsKdiyvAzh6pSGgJFYMhCfGWSeSWc=;
  b=MJtJBiNZoMJMrCXxgFmqDk221JUfRAy3g1DTgKZkkTYsYBbpFL8LqdKK
   Hq6D2B7N8oA+bclF+KQP51jyvNRQljZleend+40frvaXHGZst4JoK8ajS
   oTTyWu8XmTftWa9GKDONFx/VyBg+/1J+tc2uvTKuJICS3a45/IxCCEfhC
   2XUf7Vldi4c5Mx570ga8GGRVEeLYvfkpP0P/11vl+EKi9Awv/2YByVaUL
   25RCODabia2S0UILg/sJjALo1+lMUT1/ahHCHN6eAYgccuIhSAbbyM8Xo
   OaoBmcekpKCz4bbWmMT68WbOnSvcUJxyK+lA1kN4j8QmilKSxs1Q4zxXh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="18561802"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="18561802"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="953283636"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="953283636"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.57])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:26:51 -0800
Date: Wed, 3 Jan 2024 16:02:34 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
Message-ID: <ZZV3CgnaWznmzFKF@linux.intel.com>
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
 <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>

On Wed, Jan 03, 2024 at 02:34:26PM +0100, Rafael J. Wysocki wrote:
> > +static int hfi_pm_notify(struct notifier_block *nb,
> > +                        unsigned long mode, void *unused)
> > +{
> > +       struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
> > +       struct hfi_instance *hfi = info->hfi_instance;
> > +       int ret = 0;
> > +
> > +       /* HFI may not be in use. */
> > +       if (!hfi)
> > +               return ret;
> > +
> > +       mutex_lock(&hfi_instance_lock);
> > +       /*
> > +        * Only handle the HFI instance of the package of the boot CPU. The
> > +        * instances of other packages are handled in the CPU hotplug callbacks.
> > +        */
> > +       switch (mode) {
> > +       case PM_HIBERNATION_PREPARE:
> > +       case PM_SUSPEND_PREPARE:
> > +       case PM_RESTORE_PREPARE:
> > +               ret = smp_call_function_single(0, hfi_do_disable, NULL, true);
> > +               break;
> > +
> > +       case PM_POST_RESTORE:
> > +       case PM_POST_HIBERNATION:
> > +       case PM_POST_SUSPEND:
> > +               ret = smp_call_function_single(0, hfi_do_enable, hfi, true);
> > +               break;
> 
> Because this handles the boot CPU only, one has to wonder if it should
> be a syscore op rather than a PM notifier.
> 
> It does not sleep AFAICS, so it can run in that context, and it is
> guaranteed to run on the boot CPU then, so it is not necessary to
> force that.  Moreover, syscore ops are guaranteed to be
> non-concurrent, so locking is not needed.

There are below warnings in smp_call_function_single() :

        /*
         * Can deadlock when called with interrupts disabled.
         * We allow cpu's that are not yet online though, as no one else can
         * send smp call function interrupt to this cpu and as such deadlocks
         * can't happen.
         */
        WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
                     && !oops_in_progress);

        /*
         * When @wait we can deadlock when we interrupt between llist_add() and
         * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
         * csd_lock() on because the interrupt context uses the same csd
         * storage.
         */
        WARN_ON_ONCE(!in_task());

And this one in syscore_suspend(): 

        WARN_ONCE(!irqs_disabled(),
                "Interrupts enabled before system core suspend.\n");
                                                                     
So seems they are not compatible.

Regards
Stanislaw

