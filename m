Return-Path: <linux-kernel+bounces-138901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AEC89FBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DB31F210BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360716F0F2;
	Wed, 10 Apr 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AWPKY0/q"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2116F0D4;
	Wed, 10 Apr 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763453; cv=none; b=AxER4UfM0GECVaA6ma7SQp3Lx62TVn1ATXBN0iBUMbjlBnoFkmDHmOR7lGnSEZtR7LCKFRma7UcPcVjTCeEUiTTb/NwpUBAeR4lI6LQzwkNEx2xYYVBi4n4/t4K8jiEl/7GK05rPamxjxOV52ZwXnGsM6S9K5Gda25NQMJXi8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763453; c=relaxed/simple;
	bh=8MAka/LYIjyG7gLOmSy11T9R7hH3xuYTkVyo9gOgqo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLO0AuLPWDA56M0TkjU+s714sEejhk9DPpBXM0nOLzuzB1n9Xr59ZpGqf+vd7slcIb4Awa8cv5TOiFt1YjiJ1naM69uf4ZR8c8kvIU/QxINBjQcPNYKREkP0ydagEmTx5k4sGSJOdvNJfQJqC2xb+fjrjt/TrDo8OBW1GkU01+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AWPKY0/q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6697420EB20C;
	Wed, 10 Apr 2024 08:37:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6697420EB20C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712763451;
	bh=geyAi3uUB0sbsHH1fP/wxsnE7xOfhQ8VrT/4yiMvieA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWPKY0/qSM9y5s8Edur4yFrZ5HbkWP7zRqMcx2j2aZpQf8dNFsy6z8czwXZEXoQx2
	 0i5a6SZctujeHK1Mbz1BFc0/Ro77VXLjYsl5S+p7Tgj15SaIo6nLJQmqF0a3RF0uOQ
	 0kIuCTWmCZytxV8PX5XqBJlKyhoy7qCaYSi67+bs=
Date: Wed, 10 Apr 2024 08:37:29 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Copying TLS/user register data per perf-sample?
Message-ID: <20240410153729.GB460-beaub@linux.microsoft.com>
References: <20240404192641.GA2628-beaub@linux.microsoft.com>
 <CAM9d7cjm94EXoGY1BfTMU-n7vHkr+urxMhOTvjyMkL0f=GVxMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjm94EXoGY1BfTMU-n7vHkr+urxMhOTvjyMkL0f=GVxMQ@mail.gmail.com>

On Tue, Apr 09, 2024 at 04:32:46PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Apr 4, 2024 at 12:26 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >
> > Hello,
> >
> > I'm looking into the possibility of capturing user data that is pointed
> > to by a user register (IE: fs/gs for TLS on x86/64) for each sample via
> > perf_events.
> >
> > I was hoping to find a way to do this similar to PERF_SAMPLE_STACK_USER.
> > I think it could even use roughly the same ABI in the perf ring buffer.
> > Or it may be possible by some kprobe linked to the perf sample function.
> >
> > This would allow a profiler to collect TLS (or other values) on x64. In
> > the Open Telemetry profiling SIG [1], we are trying to find a fast way
> > to grab a tracing association quickly on a per-thread basis. The team
> > at Elastic has a bespoke way to do this [2], however, I'd like to see a
> > more general way to achieve this. The folks I've been talking with seem
> > open to the idea of just having a TLS value for this we could capture
> > upon each sample. We could then just state, Open Telemetry SDKs should
> > have a TLS value for span correlation. However, we need a way to sample
> > the TLS value(s) when a sampling event is generated.
> >
> > Is this already possible via some other means? It'd be great to be able
> > to do this directly at the perf_event sample via the ABI or a probe.
> 
> I don't think the current perf ABI allows capturing %fs/%gs + offset.
> IIRC kprobes/uprobes don't have that too but I could be wrong.
> 

Yeah, I didn't see it either. I have some patches that I will submit in
a bit as RFC that enable this functionality. I was hoping there was
already an easy way to do this.

Thanks,
-Beau

> Thanks,
> Namhyung
> 
> >
> > 1. https://opentelemetry.io/blog/2024/profiling/
> > 2. https://www.elastic.co/blog/continuous-profiling-distributed-tracing-correlation

