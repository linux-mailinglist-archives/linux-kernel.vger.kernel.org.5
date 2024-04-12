Return-Path: <linux-kernel+bounces-143043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E333E8A3387
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DC0B279E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A614A0BD;
	Fri, 12 Apr 2024 16:17:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37414A083
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938638; cv=none; b=MIl8k9oLJ1pLHzKLDuvt64sMfEk6WkWZm0CAScq2AhwWbyoMe7Ds33HgvaKvQ/2I9cNXElUok4r9kIiLwDOVBEdj0Xk1LcUDRL1X80ubRyPAdDSm5WVoOQYH2mt0Zvc6A8TGdUhKDtB0yQFJdv/Bvlr56u7Tr2uy6E1tGbS/7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938638; c=relaxed/simple;
	bh=5A0yCY9TJQnvNmIaTJIw1VuTL6w7WpbzHiipymvdeQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdKG/i6X4vqgvoTYEgJ09F3WpM0OLa0FJIvvuyD2aTWPY0S9/F4HvfIUpD/kd7w0CWmFLnjozFLrxaETzNn8fXSuyhAPp0VH45U8cZLJSN+KXIQmseyAHOf/CAW+Fny8oISapd+5T5wY3Jtk9y+aYo6Srstj6LDn8tTGA+BGneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FB2339;
	Fri, 12 Apr 2024 09:17:39 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A37D3F64C;
	Fri, 12 Apr 2024 09:17:07 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:17:04 +0100
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
Subject: Re: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate
 header
Message-ID: <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
 <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>

On Mon, Apr 08, 2024 at 08:18:00PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > To avoid sticky problems in the mpam glue code, move the resctrl
> > enums into a separate header.
> 
> Could you please elaborate so that "sticky problems in the mpam glue code" is
> specific about what problems are avoided?

Maybe just delete the the sticky clause, and leave:

	Move the resctrl enums into a separate header.

..since the next paragraph explains the rationale?

> > 
> > This lets the arch code declare prototypes that use these enums without
> > creating a loop via asm<->linux resctrl.h The same logic applies to the
> > monitor-configuration defines, move these too.
> > 
> > The maintainers entry for these headers was missed when resctrl.h
> > was created. Add a wildcard entry to match both resctrl.h and
> > resctrl_types.h.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> 
> ..
> 
> > diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> > new file mode 100644
> > index 000000000000..4788bd95dac6
> > --- /dev/null
> > +++ b/include/linux/resctrl_types.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2024 Arm Ltd.
> > + * Based on arch/x86/kernel/cpu/resctrl/internal.h
> > + */
> 
> Could this header please explain how this file is intended to be used?
> What is it intended to contain?
> 
> Reinette

Maybe something like the following?

 * Resctrl types and constants needed for inline function definitions in
 * the arch-specific <asm/resctrl.h> headers.

(James might have had other things in mind, but this is what it looks
like to me...)

Cheers
---Dave

