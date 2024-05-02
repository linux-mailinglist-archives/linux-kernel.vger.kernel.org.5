Return-Path: <linux-kernel+bounces-165893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221418B930B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377D6B21F76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00F17997;
	Thu,  2 May 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="O90V67Gd"
Received: from ma-mailsvcp-mx-lapp02.apple.com (ma-mailsvcp-mx-lapp02.apple.com [17.32.222.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78D14AAD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714612273; cv=none; b=KWhoE+O0KCDZ81+Ofy3gUgZIzjUv4nGgGyg9ZBjMwlncP0XOYwPsEB42adfYqvdS3B6F8NtSnCH7fBHT00QmYaPBqP0vndwx/q0EiPq3utpLFuHTcRHWOhhHusCcFrrXyBqselSk0ok8Pd60gsyI+6t44/iRYTCKTLOrBjZpUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714612273; c=relaxed/simple;
	bh=z8MxxiMryaY2KFsttaRStt574gLkrend+EZ69VmURrI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=D7/lvWHjT+iQVbnvNQouBed4dpyQvx6G6sE4jFXxaZPT8MTq+KJuzi9NU7XdkqNBZ7Ma9IxFwvNftpXnv6SoybtU6PwPUsVucyhNXzMOqa9WITjnpIcaiVHOH6E3r8KgyPv0CJ06UdzqEBPq7wMBue7Lv18Uel+bwGk+wqlg5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=O90V67Gd; arc=none smtp.client-ip=17.32.222.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SCU011Z70IERT20@ma-mailsvcp-mx-lapp02.apple.com> for
 linux-kernel@vger.kernel.org; Wed, 01 May 2024 17:11:05 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=20180706;
 bh=/VikyMK82iUyB2IpWp8IUQImq+ZjSWX/dOzZjyjp/FA=;
 b=O90V67GdxdKbpihh2pWmACbVp8kgEwmSH7xlODbZ+WAg4Q4WI+HZIXkHNIeRjEXp3Dq8
 MXGjejpwFIYiAY5RQHBNB5sfdMkYni9P9zdFN4eOMmqFmCxzUD0PDUvFRfTUTIkpHL5R
 ti8VTV6MT1Ba3+nWPh0HghfneO+1EX4IeJ57tEUNswn/3+jGqPbycUB0YcWHJA3TA/Jy
 If4iHpfp2bXHU1Wvw8QmlCnz9tq6jK8IHZlnbmXmE/Awxm519YO2G5U2dvaK0zv1LI7s
 cGJPEcuHds0tLZ49GqM7bdLLpYjPTuLFUjSBNjvMT2f90/GoyDgqPO/0iQUFEmiEnJVT SA==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SCU00ITQ0IDULN0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Wed, 01 May 2024 17:11:02 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SCU00N000GSQI00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 01 May 2024 17:11:01 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 2a7a9b2cb17ba74c1da13bff19a80214
X-Va-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-Va-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-Va-ID: 40ea895e-85fd-4841-92c4-ffb31f808d49
X-Va-CD: 0
X-V-A:
X-V-T-CD: 2a7a9b2cb17ba74c1da13bff19a80214
X-V-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-V-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-V-ID: 93f68664-015a-42c2-81a7-97fbd29e9574
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
Received: from mr41p01nt-relayp01.apple.com ([100.64.99.124])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SCU0039D0ICJA00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 01 May 2024 17:11:00 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Date: Wed, 01 May 2024 17:10:35 -0700
Message-id: <20240502001035.41083-1-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: <87zftoqn7u.wl-maz@kernel.org>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

> On Fri, 19 Apr 2024 17:58:09 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> > > On 2024/04/11 22:28, Will Deacon wrote:
> > > >   * Some binaries in a distribution exhibit instability which goes away
> > > >     in TSO mode, so a taskset-like program is used to run them with TSO
> > > >     enabled.
> > > 
> > > Since the flag is cleared on execve, this third one isn't generally
> > > possible as far as I know.
> > 
> > Ah ok, I'd missed that. Thanks.
> > 
> > > > In all these cases, we end up with native arm64 applications that will
> > > > either fail to load or will crash in subtle ways on CPUs without the TSO
> > > > feature. Assuming that the application cannot be fixed, a better
> > > > approach would be to recompile using stronger instructions (e.g.
> > > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > > > true that some existing CPUs are TSO by design (this is a perfectly
> > > > valid implementation of the arm64 memory model), but I think there's a
> > > > big difference between quietly providing more ordering guarantees than
> > > > software may be relying on and providing a mechanism to discover,
> > > > request and ultimately rely upon the stronger behaviour.
> > > 
> > > The problem is "just" using stronger instructions is much more
> > > expensive, as emulators have demonstrated. If TSO didn't serve a
> > > practical purpose I wouldn't be submitting this, but it does. This is
> > > basically non-negotiable for x86 emulation; if this is rejected
> > > upstream, it will forever live as a downstream patch used by the entire
> > > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> > > explicitly targeting, given our efforts with microVMs for 4K page size
> > > support and the upcoming Vulkan drivers).
> > 
> > These microVMs sound quite interesting. What exactly are they? Are you
> > running them under KVM?
> > 
> > Ignoring the mechanism for the time being, would it solve your problem
> > if you were able to run specific microVMs in TSO mode, or do you *really*
> > need the VM to have finer-grained control than that? If the whole VM is
> > running in TSO mode, then my concerns largely disappear, as that's
> > indistinguishable from running on a hardware implementation that happens
> > to be TSO.
>
> Since KVM has been mentioned a few times, I'll give my take on this.
>
> Since day 1, it was a conscious decision for KVM/arm64 to emulate the
> architecture, and only that -- this is complicated enough. Meaning
> that no implementation-defined features should be explicitly exposed
> to the guest. So I have no plan to expose any such feature for
> userspace to configure TSO or anything else of the sort.

Agreed. We do not intend for TSO mode to be used extensively for EL1, the
intention is for TSO mode to be reserved for userspace applications that
request it.

