Return-Path: <linux-kernel+bounces-138560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC089F39B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4F9287F98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61715E7F3;
	Wed, 10 Apr 2024 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv0KDQna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834515B54E;
	Wed, 10 Apr 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754392; cv=none; b=ACqfiNHDzj40gQy07hF+H0rCVveFkTW8VBxJ13H6J88y0IelM4fBDikxpdC0viI3smu81FDibO4p95pBHNUiYlY1VwI+h01OYYV3cv0rRegCEA8PYjEuUKJh6xapiS0WYT68uylo1oo1IvPI3kfQBz3FzoprFj3szexwXUQXb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754392; c=relaxed/simple;
	bh=4/Pl4qGq/nqr67B9W1zB2Sz3zHd5X0sgEcljj0I1AIo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YQTvXlgvDpyfbDZS9juZrJ94H2+gDiRtC1uHJStMAr06pXssyum7afk0p2RZB4QlqPnde+zyBAzYN4EoAGKXUCNpnWnT1I0YuObj0W3hbEqPELdlt5tvSKaOvy55QwCbrLYMSPnw6Qm6Gje0miNJ46Z1uy6tpbygaN0gLXh0+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv0KDQna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3667C43390;
	Wed, 10 Apr 2024 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712754392;
	bh=4/Pl4qGq/nqr67B9W1zB2Sz3zHd5X0sgEcljj0I1AIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zv0KDQnawkA8ux4BEqupP83tvPHpN51kK3NEw6cKda6LqNgrGwABy68JmzgDZpZ4h
	 ZAX5yjZWVx8DLIZkY1XWxKm0zv292Ul7LRxWvOfavzlZvnDqooN5jdz56ouolEYgXy
	 ebHUp1w7ME7No+8CFOHadkItFfYh5JYbCxZ5hvkn4vDHuAA1E/tI0qX8XV563VHOvY
	 3MCQXF8raLud9Db+z/3550BpKvDCwLkvYcOyeQwPtAjc6gM94WgDnyLkimKqZQnDRU
	 XjvChsPFa4tTcTT962/X2n7IVyxG/x/giJOWFCbWVrUzd4keBCUXR2Bh9iLSffPpzy
	 4Yl4/yCivjqlQ==
Date: Wed, 10 Apr 2024 22:06:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Copying TLS/user register data per perf-sample?
Message-Id: <20240410220628.609188857f8c93e33e48d12a@kernel.org>
In-Reply-To: <20240404192641.GA2628-beaub@linux.microsoft.com>
References: <20240404192641.GA2628-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 12:26:41 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Hello,
> 
> I'm looking into the possibility of capturing user data that is pointed
> to by a user register (IE: fs/gs for TLS on x86/64) for each sample via
> perf_events.
> 
> I was hoping to find a way to do this similar to PERF_SAMPLE_STACK_USER.
> I think it could even use roughly the same ABI in the perf ring buffer.
> Or it may be possible by some kprobe linked to the perf sample function.
> 
> This would allow a profiler to collect TLS (or other values) on x64. In
> the Open Telemetry profiling SIG [1], we are trying to find a fast way
> to grab a tracing association quickly on a per-thread basis. The team
> at Elastic has a bespoke way to do this [2], however, I'd like to see a
> more general way to achieve this. The folks I've been talking with seem
> open to the idea of just having a TLS value for this we could capture
> upon each sample. We could then just state, Open Telemetry SDKs should
> have a TLS value for span correlation. However, we need a way to sample
> the TLS value(s) when a sampling event is generated.
> 
> Is this already possible via some other means? It'd be great to be able
> to do this directly at the perf_event sample via the ABI or a probe.
> 

Have you tried to use uprobes? It should be able to access user-space
registers including fs/gs.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

