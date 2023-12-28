Return-Path: <linux-kernel+bounces-12779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24281F9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1051C2283F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A0F50C;
	Thu, 28 Dec 2023 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdY9aVsN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F10F4EC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703781657; x=1735317657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HpZoHXNF8wQeyDACOOvCNble18MrpAlcxrmoQ9Npfds=;
  b=FdY9aVsN/hn/1FvKYofVCp0rlQe0l6AbvWAaLv8vmt73PU7mR2MDUEB3
   XF9vSrEDkTMEtNY1rQ5dDRrLNj6Y0QvZK7j1hMexVMmGc9p9m0nhmp2+u
   OhA34SfWJLQNizsZvX9ekq+TgFia24dczULly0GtO9XToYPLPHIcIIOlQ
   nEKj1b8tqqGRFYFu6OUmwvPoE2n/0IKLRvOFx2BiOJETmd7ytCYtKbsRm
   37UBJigViDCljRv/iw+dwgafysmZPpDjvvJa0X5mnG1KpJFPAl4HaVHEi
   2TbBGIOK/pMHjqMFRD7NGjoQPzj494jDA5CcMuyDfeLtsHAVSCaIWJzKh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3856586"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="3856586"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="728353451"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="728353451"
Received: from ceyeghel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.50.226])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:40:48 -0800
Date: Thu, 28 Dec 2023 17:40:44 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2 3/4] drm/i915/guc: reconcile Excess struct member
 kernel-doc warnings
Message-ID: <ZY2lDJ4BkwO1AZGj@ashyti-mobl2.lan>
References: <20231226195432.10891-1-rdunlap@infradead.org>
 <20231226195432.10891-3-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226195432.10891-3-rdunlap@infradead.org>

Hi Randy,

[...]

> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
> @@ -105,61 +105,67 @@ struct intel_guc {
>  	 */


struct { } interrupts is missing here.

>  	struct {
>  		/**
> -		 * @lock: protects everything in submission_state,
> -		 * ce->guc_id.id, and ce->guc_id.ref when transitioning in and

[...]

> +		 * we start bypassing the schedule disable delay
>  		 */
>  		unsigned int sched_disable_gucid_threshold;
>  	} submission_state;

Here struct { } send_regs is missing

But as for this patch:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

>  	struct {
>  		/**
> -		 * @lock: Lock protecting the below fields and the engine stats.
> +		 * @timestamp.lock: Lock protecting the below fields and

[...]

