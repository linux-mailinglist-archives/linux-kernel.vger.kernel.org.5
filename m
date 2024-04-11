Return-Path: <linux-kernel+bounces-140640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404538A1719
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB3F1C20B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630614EC61;
	Thu, 11 Apr 2024 14:25:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582F14D443
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845556; cv=none; b=uyEzfaQr3syi4Pm3CCjaK/G/ZJN0G6G+vD/vIZty+NxHyTlhMaaMrt7RcBS2nJ29gzgYuOAdzJv3Ee4mimG5lsh35DJLKnfnSgaabVLsKKV9+m0Y4FYBI5dLqsgp1Pso9qLV3l67KxCwmCr0a22Jejz2+ZUAFfsAK/MevFtQiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845556; c=relaxed/simple;
	bh=oIGNAdOBf45NFOhJT9wlJAiOAYhDChao/Fk0R1NHsfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1/cMLRnONtJTuzMDlFBMYEFcSX7F8tVwWeyQqHvnfZ7UwY7aFqWHqnigi5q/kVsCUf2TK1P317WwWUuiCAcVV/T16x8bwP808uVY6KmOCbNF79XS+ctTtIXS+d6V9lj099CjOTU5mFNZHEuYn4bfAGRpyNYjEB479jGB5+ALQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3A41339;
	Thu, 11 Apr 2024 07:26:23 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADA2B3F64C;
	Thu, 11 Apr 2024 07:25:51 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:25:49 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 27/31] x86/resctrl: Rename resctrl_sched_in() to begin
 resctrl_arch_
Message-ID: <Zhfy7dmFBf3yLkiA@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-28-james.morse@arm.com>
 <7acf109f-d25f-4a37-9f97-c515346583a8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7acf109f-d25f-4a37-9f97-c515346583a8@intel.com>

On Mon, Apr 08, 2024 at 08:26:04PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> In subject, did you intend to say "to begin with"?

I'd say the subject is likely to be abbreviated rather than incorrect,
but it certainly does no harm to clarify it.  I'll make a note.

> On 3/21/2024 9:51 AM, James Morse wrote:
> > resctrl_sched_in() loads the architecture specific CPU MSRs with the
> > CLOSID and RMID values. This function was named before resctrl was
> > split to have architecture specific code, and generic filesystem code.
> > 
> > This function is obviously architecture specific, but does not begin
> > with 'resctrl_arch_', making it the odd one out in the functions an
> > architecture needs to support to enable resctrl.
> > 
> > Rename it for concistency. This is purely cosmetic.
> 
> concistency -> consistency

Noted.

Cheers
---Dave

