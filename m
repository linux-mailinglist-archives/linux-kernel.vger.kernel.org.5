Return-Path: <linux-kernel+bounces-130003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF389730F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C49928DFEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EB149C47;
	Wed,  3 Apr 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8OZTXtX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283458AA1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155867; cv=none; b=nDlF30Sl2SXBcV/cJ4ufOMGr57KwbyurRnJcRgQx85ey/FjVThwracvozoMKbT5Mk551dGlYO3yK7G8McRWV1Ei1E80S4afUjswxjj+Vj8d3Zwr9jJEALl3sHMgr6zidgfrdwCgQ5I0Q3sqYvtxJlxYZefpv6czI0WMvV7Db2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155867; c=relaxed/simple;
	bh=ZkRnyB/YnuaaTK+xWc7oWNIUrU8WkJW9xQUUiAZbCB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj4GV2590h0G2qTOc5qqpyBkOasxxRKmi5R9ed17rZZdkA4YYnyKLrz5q4wr4Nhm9m0mJvUBKKxwVkUtQUcrhBqjO/GsLBMhODp5SsK5ar0l+KkmbE65hG2Dyowr4wjO+EhL0/aEiATfdvBONaGt3K5wCtAoYYUc/mLIugcsLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8OZTXtX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712155865; x=1743691865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZkRnyB/YnuaaTK+xWc7oWNIUrU8WkJW9xQUUiAZbCB4=;
  b=e8OZTXtX7LvtFzM91PK/1MdPDpQ/8nAyuAJxb/cQ4M15ymOdhNGRl9Fe
   27DtOfIoaT4givWXtV/CBTh+FrIqWoJ8vkk+DIbqqFRFMlkBe698KO+BN
   Ioc0mIT5OnH7uSEsbtZrvuCoJ+SQI6BczhBZ1kEl5sixotz/tU9eu0X5H
   FnojAN2Y8/rnch1PshNGzCNrdoh7UMR5QkAVGPt9eA0Hlc/oJMvBJWxIC
   rKs5bZXKf0YaAjFOJGMnW9gXjH5qY4bGELP8LpVfP4Mr+bWZymXaDDy6p
   4Y2PyVnLapaLfAzAg9b0zvqB4BjitDfu2C9ZvXjS+3a1pYdS21hQBzjob
   w==;
X-CSE-ConnectionGUID: nvIWfhsuTzKC9MYSQl6nAg==
X-CSE-MsgGUID: qR97bOtRSiygFpYZHpjLqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7312775"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7312775"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:51:04 -0700
X-CSE-ConnectionGUID: iXyKyI6tQWCtmJOLwTuhnA==
X-CSE-MsgGUID: moX61vCdR9augfl/WRglXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="49431593"
Received: from chintaku-mobl.amr.corp.intel.com (HELO desk) ([10.209.34.133])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:51:04 -0700
Date: Wed, 3 Apr 2024 07:50:49 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>, stable@kernel.org
Subject: Re: [PATCH v3] x86/bugs: Default retbleed to =stuff when retpoline
 is enabled
Message-ID: <20240403145049.ab7v436ntlw7xtty@desk>
References: <20240402-retbleed-auto-stuff-v3-1-e65f275a8ec8@linux.intel.com>
 <6ffcc9bd-039a-4ab4-a84d-eeedbc6fa1cc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ffcc9bd-039a-4ab4-a84d-eeedbc6fa1cc@suse.com>

On Wed, Apr 03, 2024 at 05:32:40PM +0300, Nikolay Borisov wrote:
> 
> 
> On 3.04.24 г. 8:54 ч., Pawan Gupta wrote:
> > On Intel systems when retpoline mitigation is enabled for spectre-v2,
> > retbleed=auto does not enable RSB stuffing. This may make the system
> > vulnerable to retbleed. Retpoline is not the default mitigation when
> > IBRS is present, but in virtualized cases a VMM can hide IBRS from
> > guests, resulting in guest deploying retpoline by default. Even if IBRS
> > is enumerated, a user can still select spectre_v2=retpoline.
> > 
> > As with other mitigations, mitigate retbleed by default. On Intel
> > systems when retpoline is enabled, and retbleed mitigation is set to
> > auto, enable Call Depth Tracking and RSB stuffing i.e. retbleed=stuff
> > mitigation. For AMD/Hygon auto mode already selects the appropriate
> > mitigation.
> > 
> > Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
> > Cc: stable@kernel.org
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thanks.

