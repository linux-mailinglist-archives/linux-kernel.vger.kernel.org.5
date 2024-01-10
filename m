Return-Path: <linux-kernel+bounces-22411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D805829D53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161941C21D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4C4BAAB;
	Wed, 10 Jan 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYjCyrI2"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A664BA81
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704899899; x=1736435899;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dJ5jpQk1QiaoPMF49QRCarI6rfbPtIjbuYVnb9lfisc=;
  b=kYjCyrI2FcA9+83egXPc/aqFxyv8Y7mWjEuwQy9ZlatibNlc2BCWOgDO
   QzQBGXnI+fYRlOuy84DkOBVymp/IqgCjsKhUtndXUXrK6KGT4xfsrsPdp
   Y4/Q6xczkvR6eqpxpYeYVSyLrRp4O5deAnTBVyYeptqZF9wm9ALiOEzbd
   D2y95a81GjuiYY+Nz4+zGwcbszc6sThkbAdx0eItneYMXkRWyj3INZRZb
   XlGNvzshSNPKid3TDbHJ7/INY37oMu/sNSisIlYBYkEKoMIQYreoYZmib
   i5DMONw0fxE3NzvJ0divvlzLjucu1Y6p1Wq+c2AQ86VoyKuFaC8JSbC4Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="484732066"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="484732066"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="731883180"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="731883180"
Received: from fpallare-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.36.240])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:18:14 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [BUG] allmodconfig build error in next-20240108
In-Reply-To: <6r2zjqbs2g3hkt3uhnglwpboalwck5ye34b6gxzmhe4gae77g7@3bzqt4s7i2qb>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
 <20240109095757.1313b2d9@canb.auug.org.au>
 <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
 <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
 <20240110081155.48bb0cbd@oak>
 <d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
 <20240110095822.3ba3d979@canb.auug.org.au>
 <3d14049c-d44c-4b33-9933-0f96055b8a70@paulmck-laptop>
 <20240110160335.2bad7d54@oak>
 <3a10ef2b-acbe-4d80-805a-e947e15e5db3@paulmck-laptop>
 <6r2zjqbs2g3hkt3uhnglwpboalwck5ye34b6gxzmhe4gae77g7@3bzqt4s7i2qb>
Date: Wed, 10 Jan 2024 17:18:11 +0200
Message-ID: <87o7dtusi4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 10 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> [ This particular warning is broken on GCC11. In future changes it will
>    be moved to the normal C flags in the top level Makefile (out of
>    Makefile.extrawarn), but accounting for the compiler support. Just
>    remove it out of xe's forced extra warnings for now ]
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>
> would you mind if I extend it to drivers/gpu/drm/i915/Makefile
> in the same commit or would you prefer a separate one?

I think I'd prefer separate patches for i915 and xe. And just remove the
line instead of subdir-ccflags-$(call gcc-min-version, 120000) as
linux-next handles it properly in the top level Makefile.

BR,
Jani.



-- 
Jani Nikula, Intel

