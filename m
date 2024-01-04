Return-Path: <linux-kernel+bounces-16221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D40823AF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF721F26348
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50D523D;
	Thu,  4 Jan 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fds30FCP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D31862D;
	Thu,  4 Jan 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704337346; x=1735873346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kEeu5OoCJZYtIvABKcgN2LQCqoiaYmhWrqX0iME1HsY=;
  b=Fds30FCPTARE4r0O3lmb+g9x+zqHoGc1e0KObbf+1ZzfphZsANpmcEca
   Q5k8WzgkDyRaaPNvYwkaQfnRNvDV4qIcRFTQ71vvrAlDC+BH5b5+gw2B+
   It+AnCaZwTE1sOt8wYmzYJoXRRozteoeLJx4KddYqIqSd/B0ETws0ulug
   2zI6w1y2xIBQjPBBUwO0T7KZWC5p6FatJYQd0c9uAmZ3pFEGB4CZu47DC
   zISgpREM3OrTJcz2KUpMIKmiRV/5LKLFaWGkG7oXRWgX/CVqGBDuQNeF6
   xiKpr2xTcierJE+eDEK9incWCeRL/3ay5u8Cw9MBy1t6X0QmQsFDegSdR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="461426058"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="461426058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780197606"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="780197606"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:02:25 -0800
Date: Wed, 3 Jan 2024 19:04:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
Message-ID: <20240104030402.GB12718@ranerica-svr.sc.intel.com>
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
 <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jan 03, 2024 at 02:34:26PM +0100, Rafael J. Wysocki wrote:
> The subject should say "add a PM notifier" to indicate that
> hibernation is covered too.
> 
> On Wed, Jan 3, 2024 at 5:13 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The kernel gives the HFI hardware a memory region that the latter uses to
> > provide updates to the HFI table. The kernel allocates this memory region
> > at boot. It remains constant throughout runtime time.
> >
> > When resuming from suspend or hibernation, the restore kernel allocates a
> 
> The restore kernel is only used during resume from hibernation, so
> this particular problem is hibernation-specific.

Agreed. This correction is pertinent.
> 
> It is possible, at least in principle, that the address of the HFI
> table is "lost" by the processor during resume from "deep" suspend
> (ACPI S3), in which case it may not survive the firmware-driven part
> of the suspend-resume cycle.  It is thus prudent to disable HFI on
> suspend and re-enable it on resume for the boot CPU (under the
> assumption that the other CPUs will be taken care of by CPU offline),

Indeed, this patch aims to handle this scenario.

> but for a somewhat different reason than in the hibernation case.

I will correct the commit message to reflect this reasoning


