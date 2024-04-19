Return-Path: <linux-kernel+bounces-151851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93338AB4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A611C21F75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110113C3FE;
	Fri, 19 Apr 2024 18:05:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63143130AC4;
	Fri, 19 Apr 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549920; cv=none; b=GEM1zCmLsVhvquHbIKe0tUyaWmeRMyZ3uGIekgdAR72WAFt1+SKJTXmJon5RiiVFWJ3bGBKUe+OFrmU5IuuX14SQQ4VAUJFZ9fnjdHeGZcFnF0o/6EbH33mOtZo1KEQr8bH8ducmxL7gacnevUS3YSHodlKqvGRx1x3dBcmoBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549920; c=relaxed/simple;
	bh=UEVFeS+/tMCw0E76rQZ5tWlTwk4nDLScKXAuUGbS/4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+CmthJMEQITN3wMyFh4o882A2xCXEjXUpivdDlbgnMN4GUoddRnEVmblRXlhXyDJs1hAVuvYLPhKL1JNS3kXPp/0pFQozXITuB4p2XHsFKkHZCKxMjyfRFX9rHNKOcvONBG86fhbhIaA5g+TOqnNgtGM0tvpm6bcXhNJAEAJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC5CC116B1;
	Fri, 19 Apr 2024 18:05:13 +0000 (UTC)
Date: Fri, 19 Apr 2024 19:05:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Zayd Qumsieh <zayd_qumsieh@apple.com>, Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Message-ID: <ZiKyWGKTw6Aqntod@arm.com>
References: <f6484dcd-ebf6-4b6f-be17-69b05539e33b@marcan.st>
 <20240416022242.89623-1-zayd_qumsieh@apple.com>
 <20240419165826.GB4020@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419165826.GB4020@willie-the-truck>

On Fri, Apr 19, 2024 at 05:58:26PM +0100, Will Deacon wrote:
> On Mon, Apr 15, 2024 at 07:22:41PM -0700, Zayd Qumsieh wrote:
> > >I'm probably going to make myself hugely unpopular here, but I have a
> > >strong objection to this patch series as it stands. I firmly believe
> > >that providing a prctl() to query and toggle the memory model to/from
> > >TSO is going to lead to subtle fragmentation of arm64 Linux userspace.
> > 
> > It's definitely not our intent to fragment the ecosystem. The goal
> > of this memory ordering is to simplify emulation layers that benefit
> > from this. If you have suggestions to reduce the risk of it being
> > misused outside of emulators, we'd be happy to look into it.
> 
> Once you have exposed this toggle via prctl(), it doesn't really matter
> what your intentions where. It will get used outside of emulation laters
> and we'll be stuck supporting it.

Just FTR, I fully agree with Will. I'm strongly against this kind of ABI
for a non-architected, implementation defined feature. I can't even tell
exactly what TSO means on the Apple hardware. Is it close to the x86
TSO? Is there a formal memory model for it? Are future Apple (or other
Arm vendor) implementations going to follow exactly the same model to be
able to call it some form of "Apple standard" that deserves an ABI?

So, sorry, I'm going to NAK these approaches proposing imp def features
as generic opt-in mechanisms (the microVMs thing sounds doable though,
to my limited understanding; I guess that would mean running the
emulator in a VM).

-- 
Catalin

