Return-Path: <linux-kernel+bounces-140641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1998A171C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77666280BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC614EC40;
	Thu, 11 Apr 2024 14:26:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8614E2DE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845598; cv=none; b=Df/AmOynunrvhbazAknlbCTJv0qybZhW7gCMp4w915VGwNnCUiQRTGMovXAty3mL9pYjNngQPApsjaCeL+9s8xqRlAbXhkBrpNnnUKWvlPF45CLf8b8p0XT0Q2z11+aXNRTZursdqEorzlA35EIuG1f2YHdsf6Rv6E8VPjEKru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845598; c=relaxed/simple;
	bh=vXcj9FIhldT33DZgqnk2KkFdu+VNhPskgkJZsxZ47rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU3kgstxpOL0hRN6L5m88WC/VH2ikKsbnCdNYRUEQu5bBBfG13Qtb8gr7AiGFEcpgqO7ii4eUGoOIpr4GJt1Zu8lNCZrV611UvncIzjsgDL118VYQxlK95v3r/C4UPGTwiRddYpoHyQQzvsNl+NyyFwp+yj2lQNfHLDm446BVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B362339;
	Thu, 11 Apr 2024 07:27:06 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0888E3F64C;
	Thu, 11 Apr 2024 07:26:33 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:26:31 +0100
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
Subject: Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted
 symbols
Message-ID: <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>

On Mon, Apr 08, 2024 at 08:32:36PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:51 AM, James Morse wrote:
> > Because ARM's MPAM controls are probed using MMIO, resctrl can't be
> > initialised until enough CPUs are online to have determined the
> > system-wide supported num_closid. Arm64 also supports 'late onlined
> > secondaries', where only a subset of CPUs are online during boot.
> > 
> > These two combine to mean the MPAM driver may not be able to initialise
> > resctrl until user-space has brought 'enough' CPUs online.
> > 
> > To allow MPAM to initialise resctrl after __init text has been free'd,
> > remove all the __init markings from resctrl.
> > 
> > The existing __exit markings cause these functions to be removed by the
> > linker as it has never been possible to build resctrl as a module. MPAM
> > has an error interrupt which causes the driver to reset and disable
> > itself. Remove the __exit markings to allow the MPAM driver to tear down
> > resctrl when an error occurs.
> 
> Obviously for the reasons you state this code has never been exercised.
> Were you able to test this error interrupt flow yet?
> 
> Reinette
> 

I think this will have to wait for James to respond.

There is code to tear down resctrl in response to an MPAM error interrupt,
but I don't know how it has been exercised so far (if at all).

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.7-rc2#n1940


Cheers
---Dave

