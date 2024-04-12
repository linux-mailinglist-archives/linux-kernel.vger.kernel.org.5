Return-Path: <linux-kernel+bounces-143414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0108A389F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CEE281CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209A61482FA;
	Fri, 12 Apr 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV+iXxVu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D7199B0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712961763; cv=none; b=QommUNmgMKkMS8MwpYkZ++MUhZavY5UJuNjnsTKt2BQ/YwrYiiB2+R1aWpwbMBA83DB8IJNIpVu3oEAmzUR+Dt/oZS7ilthdBouu+TEvtr+/UuP4QtTjj7HxGtLmrLo2zYeDaM/aGLWd5D+yrI08Vsj63+dIyz67KbQNjxf+gU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712961763; c=relaxed/simple;
	bh=1SbohQdK3WicmGP5UHDUXuCg8kjTQqR+HuWubdPfhAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmxH9xSOCyoxjETG1yUnzmQ+Q+1DukztXJwd0F3YztHeWNJ9jKCCYTHnkPufYUS65MwvGBUiCx1nNy58tUSQTzTSpC+/i/8CLwMTtEz+EXKq0zNAQVL/Y4awHl1NMJLbcy7iVU1ZHQfc/aX5ahSeO6JCx8pmTl6JRe4RJVoigUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HV+iXxVu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712961762; x=1744497762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1SbohQdK3WicmGP5UHDUXuCg8kjTQqR+HuWubdPfhAg=;
  b=HV+iXxVuCu0c9hnCw9MCtvpkEaMrmvrSMYvgAhuEQbC6uJXcexese7nO
   LdpXad8KhTfTCsxT8dOZoO1Q1JBnFD+6kaJJ0D4n+lJg5B+CuoawSfwEz
   eFeVyn2v8js0aUnIPGEFybqWYHhqUetdGHfhnzQOsHP9D7BED3T+ay9UF
   wz29/dgvxppoeWT4nbR0TV2jIwcThmJnpUzmi1OnqatNfvto1emykEsVp
   UHhJGFTmlqNUvQaSkmUcudwswglGSFMCPrct4G7iroYIwfEs/ht6gQ6ek
   vgyw6ZKw49OnsoZ7I7e14UajdynKstuRQBlS29CsKfpe6KxSOW2aOnFqN
   A==;
X-CSE-ConnectionGUID: 9VWmvUm0R3a3+03TKgDbAw==
X-CSE-MsgGUID: pbatoZ5fRxec8YdESRCHFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12217633"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="12217633"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:42:41 -0700
X-CSE-ConnectionGUID: tk+3c19OQx2wruTrlGbHFA==
X-CSE-MsgGUID: Wl3rdLLOT1qkbrvyIPUSmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21855066"
Received: from ttmartin-mobl1.amr.corp.intel.com (HELO desk) ([10.209.4.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:42:40 -0700
Date: Fri, 12 Apr 2024 15:42:32 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/bugs: Only harden syscalls when needed
Message-ID: <20240412224232.uiaht6yx2ghtx3gg@desk>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>

On Fri, Apr 12, 2024 at 11:10:32AM -0700, Josh Poimboeuf wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661..7c87fe80c696 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -470,6 +470,7 @@
>  #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
> +#define X86_FEATURE_INDIRECT_SAFE	(21*32+ 4) /* "" Indirect branches aren't vulnerable to Spectre v2 */

This should be (21*32+ 5).

Other than that:

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

