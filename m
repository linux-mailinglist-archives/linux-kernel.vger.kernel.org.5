Return-Path: <linux-kernel+bounces-13067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D1081FF37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8771C21497
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5011188;
	Fri, 29 Dec 2023 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jt7ULrp6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4910A33
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703850160; x=1735386160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAS9P/54UQNO0nMPbKSc45N56/5YdBhRyYmLD1EKfjc=;
  b=jt7ULrp6yH+ISp5wZZtUO1UBUpKemJ1OHx608+bEExLhV7HTL8/Z3GPg
   XB6vNYNGJaHLgswXX1Ak4wSH95pSnRyvAnxAK75Cm6hI4ulE8K0Nwz43M
   GjDGHfvdfxcasmQ+DVJshGfRIhSJxLkBArNHY4TQfZA8kEHTGSywFdyhR
   OoPpGUYcCRDRVnr/2hVQcxPPKTs17D+gEeUUYFCEU/iXq7QQKE2gUPvne
   3J1Sl7aav/k+7rLiw8c7ksD9HETEbtCM2gcqI7znMnaWoTSye3Ye7Fq1H
   NrZ/UE1fDKFIIH8BVxCvBbfvOQH72+gRR+ZNsT22nMTpfAJ2qwL6DQIZ/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="387077531"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="387077531"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 03:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="13266452"
Received: from dmansoco-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.35.87])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 03:42:36 -0800
Date: Fri, 29 Dec 2023 12:42:27 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2.1 2/4] drm/i915/gt: reconcile Excess struct member
 kernel-doc warnings
Message-ID: <ZY6wo9U-PdmC7QWw@ashyti-mobl2.lan>
References: <20231228234946.12405-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228234946.12405-1-rdunlap@infradead.org>

Hi Randy,

On Thu, Dec 28, 2023 at 03:49:46PM -0800, Randy Dunlap wrote:
> Document nested struct members with full names as described in
> Documentation/doc-guide/kernel-doc.rst.
> 
> intel_gsc.h:34: warning: Excess struct member 'gem_obj' description in 'intel_gsc'
> 
> Also add missing field member descriptions.
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
> Cc: Andi Shyti <andi.shyti@linux.intel.com>

Reviewed and applied.

Thanks,
Andi

