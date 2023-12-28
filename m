Return-Path: <linux-kernel+bounces-12772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DE81F9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7FF285B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15247F50E;
	Thu, 28 Dec 2023 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncXu2Kjc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539BF4F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703780475; x=1735316475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vPPwiSf/usejUsjALBFvqgyVM1AHjnr7aw+GHuW/3LA=;
  b=ncXu2KjcoNLqSPIamF7ZEcT6RlZQKwd6WAwu8YPtk7eCGOOC27YLSVvd
   1OH0+3aHwuxvnlzIr/RUgow1fniIaisoP4u+aJlkiWJI8odH7J5BO6kOw
   Xb72Fc6H27ab3m1pDiQ7hGg2MzBcTXSmK4qiNB+A/n9bJQ1ybadcX4MST
   HSvYUp6j/kv9+CMfoJUl2pwRYafvlh5pdKMellJmNNplEq3nlCYWuF8zr
   imB2WdCzK1plJZzxPVq7ZKYrPJXyfTaP+Tz9LluEJTLcG0k3qAf2b/I/b
   PwKp8IYN5SbAPN0MjPAFVX6qPxDR7QKcxi6fYPahpSLOnpdW9LXwYTR1D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="10118870"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="10118870"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:21:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="812827906"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="812827906"
Received: from ceyeghel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.50.226])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:21:11 -0800
Date: Thu, 28 Dec 2023 17:21:07 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2 1/4] drm/i915/gem: reconcile Excess struct member
 kernel-doc warnings
Message-ID: <ZY2gc0gaR5i1Yct9@ashyti-mobl2.lan>
References: <20231226195432.10891-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226195432.10891-1-rdunlap@infradead.org>

Hi Randy,

On Tue, Dec 26, 2023 at 11:54:29AM -0800, Randy Dunlap wrote:
> Document nested struct members with full names as described in
> Documentation/doc-guide/kernel-doc.rst.
> 
> i915_gem_context_types.h:420: warning: Excess struct member 'lock' description in 'i915_gem_context'
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

