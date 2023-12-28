Return-Path: <linux-kernel+bounces-12780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8079A81F9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88BC1C22C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4B101CE;
	Thu, 28 Dec 2023 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhuOUA1B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0016101C1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703781725; x=1735317725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bGoDjQUeOkn6UgVsqR9D7ly0PoUYf0ufzyTN3TMtWd8=;
  b=YhuOUA1BiAWDQYUFu7P0/sOJ21H/mhdbJh/hWRvqsTf5fFuVWr5g1GNS
   m8kiD1Eqb4ClK8rSUOJGtiTI7s/o4fxR57sMtYVFMJmThDRbP+BrKFhxZ
   iYauldM0qYXNi+UTGD3i76b05wLIU3v5JHCws/egEbi63lp942J6aGoVz
   YcL3XfM/Gvn2f88DvWyBoLLF/0sWzDzIQ+kJtoFXWRUWpB70/uxe0AxVe
   Qp/f+nnhpVjsdjoHEtMPhqvi5qb4Yw+Lvm0IxWseLVYCoAacWx5kUIhav
   QxfWvi1OE38CG0AgOxKSYun4lqG23jkRbQ0IJ2QKXfWYPCv7GIjVZoyo3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3640311"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="3640311"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="771754101"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="771754101"
Received: from ceyeghel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.50.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:41:59 -0800
Date: Thu, 28 Dec 2023 17:41:56 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2 4/4] drm/i915/perf: reconcile Excess struct member
 kernel-doc warnings
Message-ID: <ZY2lVLEaOI3XVZUs@ashyti-mobl2.lan>
References: <20231226195432.10891-1-rdunlap@infradead.org>
 <20231226195432.10891-4-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226195432.10891-4-rdunlap@infradead.org>

Hi Randy,

On Tue, Dec 26, 2023 at 11:54:32AM -0800, Randy Dunlap wrote:
> Document nested struct members with full names as described in
> Documentation/doc-guide/kernel-doc.rst.
> 
> i915_perf_types.h:341: warning: Excess struct member 'ptr_lock' description in 'i915_perf_stream'
> i915_perf_types.h:341: warning: Excess struct member 'head' description in 'i915_perf_stream'
> i915_perf_types.h:341: warning: Excess struct member 'tail' description in 'i915_perf_stream'
> 3 warnings as Errors
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

