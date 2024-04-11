Return-Path: <linux-kernel+bounces-140629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13C8A16FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C041F20419
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A614E2CD;
	Thu, 11 Apr 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="ykhUHKJb"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF914E2D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845166; cv=none; b=GFHgxqQFo8RYWDj0RlG4P8oyPq1ljrMQ3qEO9iuN+ZiVbQ3p11Ab2645H5OWD4a2J44myAKmyFv14+1L7OyWm9AMWQrNyoGc4O+UXArKKuqKM336nkf0RPXJcaZzgsLNp0Y21bZrOkX3JyVnNYfWD0Gp1LIT50NMkfCaGdilsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845166; c=relaxed/simple;
	bh=3brrNQwZailVS9okgETwHXltzD+Ym9JA7txTXw14+rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0ChZPiZWRvaQRzvD2fxPV2IcfeEmJRi9HuteRGAe3P0cfmYNYnfPDx93GHZQ6xDXgDzLk5vVT7gGJPuABUyh66PV7rcH/Ijv2jfRolQC7Gh6ngmN3RO0d3QAlXD5Pco/syBLbFGTr9VJrP4uzWbmQ1J5nYAt4S6H2vGHWi0Wzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=ykhUHKJb; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 340FA4264F;
	Thu, 11 Apr 2024 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712845160; bh=3brrNQwZailVS9okgETwHXltzD+Ym9JA7txTXw14+rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ykhUHKJbI38YQHT6kBcV0JRXY1bg4TNCVCImzo2W1TLIQveExFLitZvv5bDVxfBR3
	 fyEl9wY0h/Flc8T1voUDFymB5mrxuEApYzpstMvmV9ovencAcdMStckiz3sux9amy/
	 NyqJ9bjHQ9YqKtz6PB0NlL5eoPMMCjR1jot7ZHGmJvy3pc8GqizWaSfKKvJ+yXu/KU
	 tNkEMfIyyWgECw6IL72Z5kB/AxJTyT3shLoH06ONOTHmMySpJQEK9ZQ9zR4vvyf3gv
	 cgYmQr6MHAsKOi6inrIJpWuw74lPwK5VJN2V2Z68h6LRDGw4XdjrEyDrEGLUeXE+2p
	 Bp9XbJlmawm/w==
Message-ID: <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
Date: Thu, 11 Apr 2024 23:19:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>,
 Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Asahi Linux <asahi@lists.linux.dev>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
 <20240411132853.GA26481@willie-the-truck>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <20240411132853.GA26481@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/11 22:28, Will Deacon wrote:
> Hi Hector,
> 
> On Thu, Apr 11, 2024 at 09:51:19AM +0900, Hector Martin wrote:
>> x86 CPUs implement a stricter memory modern than ARM64 (TSO). For this
>> reason, x86 emulation on baseline ARM64 systems requires very expensive
>> memory model emulation. Having hardware that supports this natively is
>> therefore very attractive. Such hardware, in fact, exists. This series
>> adds support for userspace to identify when TSO is available and
>> toggle it on, if supported.
> 
> I'm probably going to make myself hugely unpopular here, but I have a
> strong objection to this patch series as it stands. I firmly believe
> that providing a prctl() to query and toggle the memory model to/from
> TSO is going to lead to subtle fragmentation of arm64 Linux userspace.

I honestly doubt this should be a significant concern right now, given
that only a subset of implementations actually support this. Yes,
developers can do stupid stuff, but we already have gone through this
kind of story with other situations (e.g. 16K and 64K page support on
ARM64 breaking 4K assumptions) and things have been fixed over time.

In particular, I highly suspect Asahi Linux and Apple Silicon have done
a lot more good for the ARM64 ecosystem by getting developers to fix
their page size mess than they will do bad by somehow encouraging TSO
abuse. We've even found new memory model issues thanks to the
architecture's deep out-of-order character (remember that mess with
Linux atomics? :-)). So far, in the year+ we've had this patchset
downstream, not a single developer has proposed abusing it for something
that isn't an x86 emulator.

There's a pragmatic argument here: since we need this, and it absolutely
will continue to ship downstream if rejected, it doesn't make much
difference for fragmentation risk does it? The vast majority of
Linux-on-Mac users are likely to continue running downstream kernels for
the foreseeable future anyway to get newer features and hardware support
faster than they can be upstreamed. So not allowing this upstream
doesn't really change the landscape vis-a-vis being able to abuse this
or not, it just makes our life harder by forcing us to carry more
patches forever.

> It's not difficult to envisage this TSO switch being abused for native
> arm64 applications:
> 
>   * A program no longer crashes when TSO is enabled, so the developer
>     just toggles TSO to meet a deadline.
> 
>   * Some legacy x86 sources are being ported to arm64 but concurrency
>     is hard so the developer just enables TSO to (mostly) avoid thinking
>     about it.

Both of these rely on the developer *knowing* what TSO is and why it
fixes this. I posit that a developer who knows what that is also likely
to know why this is a stupid hack and they shouldn't be doing this and
that it won't work on all machines.

> 
>   * Some binaries in a distribution exhibit instability which goes away
>     in TSO mode, so a taskset-like program is used to run them with TSO
>     enabled.

Since the flag is cleared on execve, this third one isn't generally
possible as far as I know.

> In all these cases, we end up with native arm64 applications that will
> either fail to load or will crash in subtle ways on CPUs without the TSO
> feature. Assuming that the application cannot be fixed, a better
> approach would be to recompile using stronger instructions (e.g.
> LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> true that some existing CPUs are TSO by design (this is a perfectly
> valid implementation of the arm64 memory model), but I think there's a
> big difference between quietly providing more ordering guarantees than
> software may be relying on and providing a mechanism to discover,
> request and ultimately rely upon the stronger behaviour.

The problem is "just" using stronger instructions is much more
expensive, as emulators have demonstrated. If TSO didn't serve a
practical purpose I wouldn't be submitting this, but it does. This is
basically non-negotiable for x86 emulation; if this is rejected
upstream, it will forever live as a downstream patch used by the entire
gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
explicitly targeting, given our efforts with microVMs for 4K page size
support and the upcoming Vulkan drivers).

That said, I have a pragmatic proposal here. The "fixed TSO" part of the
implementation should be harmless, since those CPUs would correctly run
poorly-written applications anyway so the API is moot. That leaves Apple
Silicon. Our native kernels are and likely always will be 16K page size,
due to a bunch of pain around 16K-only IOMMUs (4K kernels do boot
natively but with very broken functionality including no GPU
acceleration) plus performance differences that favor 16K. How about we
gate the TSO functionality to only be supported on 4K kernel builds?
This would make them only work in 4K VMs on Asahi Linux. We are very
explicitly discouraging people from trying to use the microVMs to work
around page size problems (which they can already do, another
fragmentation problem, anyway); any application which requires the 4K VM
to run that isn't an emulator is already clearly broken and advertising
that fact openly. So, adding TSO to this should be only a marginal risk
of further fragmentation, and it wouldn't allow apps to "sneakily" "just
work" on Apple machines by abusing TSO.

> 
> An alternative option is to go down the SPARC RMO route and just enable
> TSO statically (although presumably in the firmware) for Apple silicon.
> I'm assuming that has a performance impact for native code?

Correct. We already have this as a bootloader option, but it is not
desirable. Plus, userspace code still needs a way to *discover* that TSO
is enabled for correctness, so it can automatically decide whether to
use stronger or weaker instructions.

> 
> Will
> 
> P.S. I briefly pondered the idea of the kernel toggling the bit in the
> ELF loader when e.g. it sees an x86 machine type but I suspect that
> doesn't really help with existing emulators and you'd still need a way
> to tell the emulator whether or not it was enabled.
> 

- Hector

