Return-Path: <linux-kernel+bounces-60626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E29850797
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7821AB227DC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CB441B;
	Sun, 11 Feb 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=delyan.me header.i=@delyan.me header.b="ai5Eo1rC"
Received: from chi120.greengeeks.net (chi120.greengeeks.net [173.236.97.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F634401
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.236.97.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707616068; cv=none; b=srwHtCC1Mrc7S5yybzH1pOnUhHhrY2ey+8X+z1qEXS48kvpFnSpe/UiWaMU89+AsJJNs3TYj4hhM/93ON/0ODC7j/pQ4lozgRoOKuxKOoqEG3CaJk9bXd5qV4aYTP7B7ajLybZUyfyYkld6hW0lpQMUTZGoff2kT7eHU3Mz5AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707616068; c=relaxed/simple;
	bh=mZ4VNATanHjYlWLMAajusqRRHhOZiCvO+SF+xW0XM0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DNfE/NHIx7d1CXiOe1+zYxrlMRZE9NR8RfcCxPxts2g8yHav5v43hxC66MJW3pOQV2vQjcmsWv0b1vXGMSZoP7d13Rflt5XXH9jYjuy8IVEjIfwn8dl9THKic9DgcLosVIit37LFoeQwdaegAS55UjO01ooXkgxjiMI8+uTCpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delyan.me; spf=pass smtp.mailfrom=delyan.me; dkim=pass (2048-bit key) header.d=delyan.me header.i=@delyan.me header.b=ai5Eo1rC; arc=none smtp.client-ip=173.236.97.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delyan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delyan.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=delyan.me;
	s=default; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Yd59A0zE/B79AlkL3rIg03ugfqRUV8fXYUq26F5oDtk=; b=ai5Eo1rCdzTT3DzcBF5XKEybJY
	vOqhjvC6/xes+hxyl+tnPJqsJSQEpHAnAq7uClVeZFIX++KqF/R6G8lHhze25SVOnkRiLgjGVbFXL
	qFM2eE79s0RVe2X8Z+PkSmruKl8gNp+y3Ocs9eWI7XIjhUtKkyD2WPoAgNr/nyWSzD4tT/B+BjriT
	ZPpIJYfUDko+srG4Kdyne9O6150qIqDdlResRyh+zG6YrceJGyDngg4/mLuw7HFMhJmEJz+VpKteL
	s9SiuWFKnVB0V7ovY6qUwHa6jr5mtZq+lAeT/mvTlgSrX/4PGbSviplyqL3dOsknkY2Sz3z/5lhj7
	jyIko5Aw==;
Received: from c-98-47-236-196.hsd1.ca.comcast.net ([98.47.236.196]:46232 helo=discovery.localnet)
	by chi120.greengeeks.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <delyan@delyan.me>)
	id 1rYygz-0001CS-34;
	Sat, 10 Feb 2024 19:31:35 -0600
From: Delyan Kratunov <delyan@delyan.me>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de
Subject: Posix process cpu timer inaccuracies
Date: Sat, 10 Feb 2024 17:30:46 -0800
Message-ID: <2635838.Lt9SDvczpP@discovery>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chi120.greengeeks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - delyan.me
X-Get-Message-Sender-Via: chi120.greengeeks.net: authenticated_id: delyan@delyan.me
X-Authenticated-Sender: chi120.greengeeks.net: delyan@delyan.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi folks,

I've heard about issues with process cpu timers for a while (~years) but only 
recently found the time to look into them. I'm starting this thread in an 
attempt to get directional opinions on how to resolve them (I'm happy to do 
the work itself).

Let's take setitimer(2). The man page says that "Under very heavy loading, an 
ITIMER_REAL timer may expire before the signal from a previous expiration has 
been delivered." This is true but incomplete - the same issue plagues 
ITIMER_PROF and ITIMER_VIRTUAL as well. I'll call this property "completeness" 
i.e. that all accrued process CPU time should be accounted by the signals 
delivered to the process.

A second issue is proportionality. Specifically for setitimer, there appears to 
be an expectation in userspace that the number of signals received per thread 
is proportional to that thread's CPU time. I'm not sure where this belief is 
coming from but my guess is that people assumed multi-threadedness preserved 
the "sample a stack trace on every SIGPROF" methodology from single-threaded 
setitimer usage. I don't know if it was ever possible but you cannot currently 
implement this strategy and get good data out of it. Yet, there's software 
like gperftools that assumes you can. (Did this ever work well?)

1. Completeness

The crux of the completeness issue is that process CPU time can easily be 
accrued faster than signals on a shared queue can be dequeued. Relatively 
large time intervals like 10ms can trivially drop signals on 12-core 24-thread 
system but in my tests, 2-core 4-thread systems behave just as poorly under 
enough load.

There's a few possible improvements to alleviate or fix this.

a. Instead of delivering the signal to the shared queue, we can deliver it to 
the task that won the "process cpu timers" race. This improves the situation 
by effectively sharding the collision space by the number of runnable threads. 

b. An alternative solution would be to search through the threads for one that 
doesn't have the signal queued and deliver to it. This leads to more overhead 
but better signal delivery guarantees. However, it also has worse behavior 
w.r.t. waking up idle threads.

c. A third solution may be to treat SIGPROF and SIGVTALRM as rt-signals when 
delivered due to an itimer expiring. I'm not convinced this is necessary but 
it's the most complete solution.

2. Proportionally

The issue of proportionality is really the issue of "can you use signals for 
multi-threaded profiling at all." As it stands, there's no mechanism that's 
ensuring proportionality, so the distribution across threads is meaningless. 

The only way I can think of to actually enforce this property is to keep 
snapshots of per-thread cpu time and diff them from one SIGPROF to the next to 
determine the target thread (by doing a weighted random choice). It's not _a 
lot_ of work but it's certainly a little more overhead and a fair bit of 
complexity. With POSIX_CPU_TIMERS_TASK_WORK=y, this extra overhead shouldn't 
impact things too much.

Note that proportionality is orthogonal to completeness - while you can 
configure posix timers to use rt-signals with timer_create (which fixes 
completeness), they still have the same distribution issues.

Overall, I'd love to hear opinions on 1) whether either or both of these 
concerns are worth fixing (I can expand on why I think they are) and 2) the 
direction the work should take.

Thanks for reading all this,
-- Delyan



