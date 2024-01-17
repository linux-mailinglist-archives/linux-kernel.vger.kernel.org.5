Return-Path: <linux-kernel+bounces-29560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1990831035
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56420287CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D451286B4;
	Wed, 17 Jan 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgJsL126"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB92561F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535540; cv=none; b=XMDzg9hN7chX7CqBIbOBBB57EgxqYVbha8KQ5r5/3VZYpATtB4uuhEiKdnbnXvgfhI5VhYbyuRJlbba/V5U3+IlvQQwu7Bvh1HxWcAl1iHujuwmAEDO2qfEP+lnxvdV2ArxwcLL+9yoHFgerk4CDP4FGaamN01DxbsY8y1nva1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535540; c=relaxed/simple;
	bh=ZDU13mwuLihNjeN96H7NkxU9PtW0yNhYdEB/vSRJVlc=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=WNBwV/K7I7KosuG3hj/OPOz6mcJF5jzEBNWqg9wZy7rbo9DWvE9mAxd9gpGqnZyw9BoXcnzcJEeCYqGyZjiIGk5YIZbQnUNFHW6ZXzZfF4FaOCwnoUHxyPaR4WYskhbNIpSWAd3LQwbn0/soRdQVGrP0OLWjmeifPVEHGg81ATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgJsL126; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705535538; x=1737071538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZDU13mwuLihNjeN96H7NkxU9PtW0yNhYdEB/vSRJVlc=;
  b=jgJsL1261F4twkFFKb35cl40G2dbn5oUIpKx6rQvZEN3vIZIPsZnW+Y8
   2C8BC15ahNEBMhVZFXX0xM8wknXbpH6IghFN4aqQzXWPTNX1S0jvg8kQ4
   VrI0Jc1Lm57atK0d8PGzfikPSQ70I+fjeziiS6DT9axWilEs3K0iPVy3k
   MYiIaLPO0Hxrb/KjcVbJaP69N2tXK/6bi1k7neDfjq5TH7vdb3wWWeS9s
   tENuq1Dij1qlYGvdBXdNQFicnqf24OOOsXxQMWgn7hrwZH800WWnYG5yq
   Y2sEMN3xIL5mpaqJiQRi69oWXpaMMfC30K4OyC8SqfrRSQALVVXeSFh3r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404070282"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="404070282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 15:52:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="818647782"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="818647782"
Received: from mmccollu-mobl1.amr.corp.intel.com (HELO [10.209.20.138]) ([10.209.20.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 15:52:17 -0800
Message-ID: <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
Date: Wed, 17 Jan 2024 15:52:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
Content-Language: en-US
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240116234901.3238852-1-avagin@google.com>
 <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/17/24 14:30, Andrei Vagin wrote:
> On Wed, Jan 17, 2024 at 11:34 AM Dave Hansen <dave.hansen@intel.com> wrote:
>> Seems like the real problem here is that the fault_in_readable() doesn't
>> match the XRSTOR.  It's going to continue to be a problem as long as we
>> don't know what memory XRSTOR tried to access.  We can try all day long
>> to precalculate what XRSTOR _will_ do, but that seems a bit silly
> 
> I don't understand this part. The behavior of XRSTOR is well-defined
> by CPU specifications, allowing us to easily precalculate the memory it
> will attempt to access. What does it mean "we don't know what memory
> XRSTOR tried to access"?
> 
> xrstor restores only features that are set in fx_sw->xfeatures.

XSAVE is a big old pile of fun.  Someone is confused here and that
someone might be me.  Let me walk through my logic a bit.  Maybe you can
point out where I've gone wrong. :)

Take a look at the "Legacy Region of an XSAVE Area" in the SDM.

	The x87 state component comprises bytes 23:0 and bytes 159:32.
	The SSE state component comprises bytes 31:24 and bytes 415:160.
	The XSAVE feature set does not use bytes 511:416; bytes 463:416
	are reserved.

and the next section:

	The XSAVE header of an XSAVE area comprises the 64 bytes
	starting at offset 512 from the area’s base address:
	...
	Bytes 7:0 of the XSAVE header is a state-component bitmap (see
	Section 13.1) called XSTATE_BV.

XRSTOR accesses memory based on XSTATE_BV (and XCOMP_BV which should be
irrelevant here).  So we're looking for something at 512 bytes up in the
XSAVE buffer.

Let's have gdb help us out a bit.  Where is sw_reserved?

(gdb) print/d &((struct fxregs_state *)0)->sw_reserved
$4 = 464

Where does XRSTOR itself look?

(gdb) print/d &((union fpregs_state *)0)->xsave->header.xfeatures
$5 = 512

(xfeatures aka. XSTATE_BV)

There _was_ a reason once upon a time that the kernel started sticking a
copy of XSTATE_BV in 'sw_reserved'.  I just forget what it is at the
moment.  It's horribly confusing to it laid out like this, but the SDM
is pretty clear: "the XSAVE feature set does not use bytes 511:416".

"fx_sw" is actually a software-defined and software-only-consumed area
of the XSAVE buffer, thus the '_sw'.  Nothing in the '_sw' section tells
us how the hardware will behave.

>> because the CPU knows where the fault happened.  It told us in CR2 and
>> all we have to do is plumb that back to fault_in_readable().
> 
> I considered this option as well, but then I decided that this approach
> is better. The most important aspect is that it always rejects bad
> buffers, allowing a user space to detect an issue even when a fault
> isn't triggered. I believe proper handling of xrstor page faults could
> be a valuable additional improvement to this change. If we detect a
> fault outside of a provided buffer, we can print a warning to signal
> that check_xstate_in_sigframe is incomplete.

I'm not really following the logic there.  What's the downside of taking
the fault?

