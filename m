Return-Path: <linux-kernel+bounces-12774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7449E81F9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B461F22447
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE9F50C;
	Thu, 28 Dec 2023 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4wAEZlt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED797F4F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703780767; x=1735316767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cquyNjhYzpwCizk15rHvGi0L/xABUbBm6EGekJs4+08=;
  b=W4wAEZlteqYxn20YJa14AdGnGk8CPc5tkC/SBKukVPbu1wFnQt9s9SNc
   5LTWslu/fYDIGdQLQALI+c29OYepTimQc6ASiFYYqBXR/FTqmGu2LZpS7
   QGw3PIO3qBB7wuZM1QuZIoZCr3E60Tufl0AyMLF0cfyarEvgTjUZkp3+p
   Q9SL5ZY+6T6NvDHC8zStpRcoU++Z+kmpY68PBM79XGjIHTx8/Ki8VOjMe
   xsxtao0NtVF6uZV/9eHc0GZMzJ9/pf4zny/QM4Fehlj9Y4eL8zjFNwHIi
   l4bMrHIH1oSY8LSbxxn+Sc2lOpV5subpJvqDu23gB/EWMoSYta8nq4Lqw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3855075"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="3855075"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="728350199"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="728350199"
Received: from ceyeghel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.50.226])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:26:03 -0800
Date: Thu, 28 Dec 2023 17:25:59 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2 2/4] drm/i915/gt: reconcile Excess struct member
 kernel-doc warnings
Message-ID: <ZY2hl-8-iucCogQP@ashyti-mobl2.lan>
References: <20231226195432.10891-1-rdunlap@infradead.org>
 <20231226195432.10891-2-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226195432.10891-2-rdunlap@infradead.org>

Hi Randy,

...

>  /**
>   * struct intel_gsc - graphics security controller
>   *
> - * @gem_obj: scratch memory GSC operations
> - * @intf : gsc interface
> + * @intf :	gsc interface
> + * @intf.adev :	MEI aux. device for this @intf
> + * @intf.gem_obj : scratch memory GSC operations
> + * @intf.irq :	IRQ for this device (%-1 for no IRQ)
> + * @intf.id :	this interface's id number/index
>   */

I don't really like the tabs here and the space before the ':',
which makes it a bit harder to read. Besides it doesn't look
consistent with the rest of the documentation.

Otherwise, looks good.

Andi

