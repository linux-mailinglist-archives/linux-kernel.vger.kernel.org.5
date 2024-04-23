Return-Path: <linux-kernel+bounces-155542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94368AF3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7541F239D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7A13CFA4;
	Tue, 23 Apr 2024 16:17:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80315FB9C;
	Tue, 23 Apr 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889056; cv=none; b=BEU07kUc/qHdIxJ/a1upFIDR5PD/X39XIQxiS4BDbyrZ+I+LU7vCSJcxzPM6U5eoPUPonzkkGgjBVy1J4inHIkhnI4M/dzZR9lV+z3kWblw2tSjXEQuuwAJ68jz0fn9ArmXeHl9a+NySvntFdxzcG4N01nhseGAsmT1F5+k76T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889056; c=relaxed/simple;
	bh=QncCMJcdoGCaS7NTRKcEK2tYaI7OoWFk7uw3k767ghI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef6vYua0pR+TxA63d7Ig2Fgx4dM1GqJmziqpjXnDXUDA+Jz8iIoDbiJd4FHx4+vVgr9/Cm1Jsx40QR6ryTIBLSG4Wz5Eznfg3DTdRwlPDGaWE1NH2N9GcHBnLHC243paKY+/mhPVCj5S76upd3k1Dot/tEEzdLNAsqfLAROlsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 044DA2F;
	Tue, 23 Apr 2024 09:18:02 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDAD43F7BD;
	Tue, 23 Apr 2024 09:17:29 -0700 (PDT)
Date: Tue, 23 Apr 2024 17:17:27 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Peter Newman <peternewman@google.com>, corbet@lwn.net,
	fenghua.yu@intel.com, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	yanjiewtw@gmail.com, kim.phillips@amd.com, lukas.bulwahn@gmail.com,
	seanjc@google.com, jmattson@google.com, leitao@debian.org,
	jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, eranian@google.com,
	james.morse@arm.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Message-ID: <ZiffF93HM8bE3qo7@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <ZiaRXrmDDjc194JI@e133380.arm.com>
 <CALPaoCh5DDmojnkUZPnACkq_ugwKnqCnwLHj2sV69TSTzpAL9g@mail.gmail.com>
 <ZiervIprcwoApAqw@e133380.arm.com>
 <4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com>

Hi Babu,

On Tue, Apr 23, 2024 at 10:43:25AM -0500, Moger, Babu wrote:
> Hi Dave,
> 
> On 4/23/24 07:38, Dave Martin wrote:
> > Hi Peter,
> > 
> > On Mon, Apr 22, 2024 at 11:23:50AM -0700, Peter Newman wrote:
> >> Hi Dave,
> >>
> >> On Mon, Apr 22, 2024 at 9:33 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >>>
> >>> Hi Babu,
> >>>
> >>> On Thu, Mar 28, 2024 at 08:06:33PM -0500, Babu Moger wrote:
> >>>>        Assignment flags can be one of the following:
> >>>>
> >>>>         t  MBM total event is assigned
> >>>
> >>> With my MPAM hat on this looks a bit weird, although I suppose it
> >>> follows on from the way "mbm_total_bytes" and "mbm_local_bytes" are
> >>> already exposed in resctrlfs.
> >>>
> >>> From an abstract point of view, "total" and "local" are just event
> >>> selection criteria, additional to those in mbm_cfg_mask.  The different
> >>> way they are treated in the hardware feels like an x86 implementation
> >>> detail.
> >>>
> >>> For MPAM we don't currently distinguish local from non-local traffic, so
> >>> I guess this just reduces to a simple on-off (i.e., "t" or nothing),
> >>> which I guess is tolerable.
> >>>
> >>> This might want more thought if there is an expectation that more
> >>> categories will be added here, though (?)
> >>
> >> There should be a path forward whenever we start supporting
> >> user-configured counter classes. I assume the letters a-z will be
> >> enough to cover all the counter classes which could be used at once.
> > 
> > Ack, though I'd appreciate a response on the point about "_" below in
> > case people missed it.
> 
> It was based on the dynamic debug interface and also Reinette's suggestion
> as well.
> https://www.kernel.org/doc/html/v4.10/admin-guide/dynamic-debug-howto.html
> (Look for "No flags are set").
> 
> We tried to use that similar interface.

Fair enough; I haven't touched dynamic debug for quite a while and had
forgotten about this convention being used there.

Apologies for the noise on that!

Cheers
---Dave

