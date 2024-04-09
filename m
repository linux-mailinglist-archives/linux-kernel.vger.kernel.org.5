Return-Path: <linux-kernel+bounces-136352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF18D89D301
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F91C20C35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C97CF1A;
	Tue,  9 Apr 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKatHfYU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240887605D;
	Tue,  9 Apr 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647619; cv=none; b=d+dWdpfJuZZseBXPNjN7MtrO375pGNH2aqv88FYHfNLwlxgfYh/f6ZRaNGIMJGcjKxSWpOib6hXBI+JcJw7ImjHQ23FBClETSC7LmE05Tm5eHmq3Zwvb/5MIK9anLog16j3dkHpuPaGxDnurlGDRrB+G+8CZpS2YGnw3pJM6RCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647619; c=relaxed/simple;
	bh=daUzE7PdhRD4SgLG9zKOOsfMuWRE0I6EtRMVENqc/98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U5Z5lZB7uIMTxiS7XIEd4lPCZn+to6wIJV9GCCYtPlQGNyAadGM3If8Dzs4aQlsI4Gk48HscTBZebidISts7DASWq4ru7yqaV7lXXEqwvMyzwYiXLEAYyuyfTZqMcKQwlkdk76fixzg8A4x29wEdCjrIZ23oWp+AUkFXqG/hBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKatHfYU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712647617; x=1744183617;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=daUzE7PdhRD4SgLG9zKOOsfMuWRE0I6EtRMVENqc/98=;
  b=AKatHfYU/obN7UwyWBS5rrPZKzKxFxQqUJZzIuCDScDgn6IZUZ/ZK6Pi
   PLnubkzcTUMLxqylJKEBRRkQU5cwYstO30drVBfxfNCFYAGfS9SpJPCqN
   8SZRiBbSJLHdLSGTvjB0HEkoX4WMidaV9PFZrlwnfzLlECnaBdBRa5uhf
   p/Z/Mrn5180om0TTru7XpE7G096TSm30QQBCZ3Y7mD3fxTDFvMjwRfc+s
   qV9dr3qVZwQhTDfa9JK30baTUcbzGSbFbvUcqCtrz7AYehdesHzd01i+F
   arjuXoJonughtgClA0wt6omzcTaBGz2mRRylZrx7qWteubWSUZA2J9WbG
   Q==;
X-CSE-ConnectionGUID: naIUizQGRcSULX0MVwzUtg==
X-CSE-MsgGUID: sfY7LiksT5upKG2hIqsDqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8110431"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8110431"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:26:56 -0700
X-CSE-ConnectionGUID: Vh6Zj9t+TO+fDY1xnrUssw==
X-CSE-MsgGUID: 63XeEpTzQf2JrlksYXceig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="24925457"
Received: from mserban-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.59.228])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:26:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
 <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/9] tools/include: Sync uapi/drm/i915_drm.h with the
 kernel sources
In-Reply-To: <20240408185520.1550865-2-namhyung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <20240408185520.1550865-2-namhyung@kernel.org>
Date: Tue, 09 Apr 2024 10:26:47 +0300
Message-ID: <874jcb9etk.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 08 Apr 2024, Namhyung Kim <namhyung@kernel.org> wrote:
> To pick up changes from:
>
>    b112364867499 ("drm/i915: Add GuC submission interface version query")
>    5cf0fbf763741 ("drm/i915: Add some boring kerneldoc")
>
> This should be used to beautify DRM syscall arguments and it addresses
> these tools/perf build warnings:
>
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

All these years and I never realized there are header copies
there. But... why copies?

BR,
Jani.


-- 
Jani Nikula, Intel

