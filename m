Return-Path: <linux-kernel+bounces-141247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACE8A1CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B5EB347BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2C79DD4;
	Thu, 11 Apr 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DQYh+KCS"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BF79B8E;
	Thu, 11 Apr 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851150; cv=none; b=aFVyLzOu67pqCFFqm//MCIPBlBsDM9ms224SmMfU/n26eXQGeQtVQ8r45+5RoMY8CranyffVmnjjRUyTOwevk3C0PPQtaRagwH6R5e7xCwkRYKf/bedfkhstyPYYQg1sUdZluZVUnHSebUYKgOlGtoqxeufkwkXcWLiHlZodP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851150; c=relaxed/simple;
	bh=1cxH4Uf9JTRKo/wgayt4O34eDNtZBOzBmCb5Kc5mcNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBUaeA0fzNc1t+F1pwJOanbSyCAsMpXXo/nnqJwqRg++TvOTOVDs6PRY/TCPwdjFUES6v2qWOWyxVtNixmqiyQXFnKjOelCb8aL5mj5GuEm/0rV1QytS7dlgcrkfwMJjNOWzmRl7DtCa5EiG5ZB653TzGjrXCJ5yLyHunZo5ltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DQYh+KCS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4233720EB6E9;
	Thu, 11 Apr 2024 08:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4233720EB6E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712851143;
	bh=PV+e+azs9UB18fleivcFVR2+EgH1ys27iJCSFmbhMV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQYh+KCScm5LH79cKmU6VK0GpxFKMMOCVkEz0xOU31E0GX3CUgqYhED9dRIO7LnTw
	 ZO+DchNbeF+qd6Eor07hhGx17Fm7Sz3cMpXDbiDSxg+orssHXez80nMZLl+leMWGzY
	 /fAQWr/7GjCeH+dV/O92Xj5kNTPgZOAcElXGUX7Y=
Date: Thu, 11 Apr 2024 08:58:58 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Copying TLS/user register data per perf-sample?
Message-ID: <20240411155858.GA452-beaub@linux.microsoft.com>
References: <20240404192641.GA2628-beaub@linux.microsoft.com>
 <20240410220628.609188857f8c93e33e48d12a@kernel.org>
 <20240410153542.GA460-beaub@linux.microsoft.com>
 <20240412005519.e7b664950ac776993da348bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412005519.e7b664950ac776993da348bd@kernel.org>

On Fri, Apr 12, 2024 at 12:55:19AM +0900, Masami Hiramatsu wrote:
> On Wed, 10 Apr 2024 08:35:42 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Wed, Apr 10, 2024 at 10:06:28PM +0900, Masami Hiramatsu wrote:
> > > On Thu, 4 Apr 2024 12:26:41 -0700
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > I'm looking into the possibility of capturing user data that is pointed
> > > > to by a user register (IE: fs/gs for TLS on x86/64) for each sample via
> > > > perf_events.
> > > > 
> > > > I was hoping to find a way to do this similar to PERF_SAMPLE_STACK_USER.
> > > > I think it could even use roughly the same ABI in the perf ring buffer.
> > > > Or it may be possible by some kprobe linked to the perf sample function.
> > > > 
> > > > This would allow a profiler to collect TLS (or other values) on x64. In
> > > > the Open Telemetry profiling SIG [1], we are trying to find a fast way
> > > > to grab a tracing association quickly on a per-thread basis. The team
> > > > at Elastic has a bespoke way to do this [2], however, I'd like to see a
> > > > more general way to achieve this. The folks I've been talking with seem
> > > > open to the idea of just having a TLS value for this we could capture
> > > > upon each sample. We could then just state, Open Telemetry SDKs should
> > > > have a TLS value for span correlation. However, we need a way to sample
> > > > the TLS value(s) when a sampling event is generated.
> > > > 
> > > > Is this already possible via some other means? It'd be great to be able
> > > > to do this directly at the perf_event sample via the ABI or a probe.
> > > > 
> > > 
> > > Have you tried to use uprobes? It should be able to access user-space
> > > registers including fs/gs.
> > > 
> > 
> > We need to get fs/gs during a sample interrupt from perf. If the sample
> > interrupt lands during kernel code (IE: syscall) we would also like to
> > get these TLS values when in process context.
> 
> OK, those are not directly accessible from pt_regs.
> 

Yeah, it's a per-arch thread attribute.

> > 
> > I have some patches into the kernel to make this possible via
> > perf_events that works well, however, I don't want to reinvent the wheel
> > if there is some way to get these via perf samples already.
> 
> I would like to see it. I think it is possible to introduce a helper
> to get a base address of user TLS for probe events, and start supporting
> from x86.
> 

For sure, I'm hoping the patches start the right conversations.

> > 
> > In OTel, we are trying to attribute samples to transactions that are
> > occurring. So the TLS fetch has to be aligned exactly with the sample.
> > You can do this via eBPF when it's available, however, we have
> > environments where eBPF is not available.
> > 
> > It's sounding like to do this properly without eBPF a new feature would
> > be required. If so, I do have some patches I can share in a bit as an
> > RFC.
> 
> It is better to be shared in RFC stage, so that we can discuss it from
> the direction level.
> 

Agree, it could be that having the ability to run a probe on sample may
be a better option. Not sure.

Thanks,
-Beau

> Thank you,
> 
> > 
> > Thanks,
> > -Beau
> > 
> > > Thank you,
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

