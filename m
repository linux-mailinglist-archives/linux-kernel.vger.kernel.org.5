Return-Path: <linux-kernel+bounces-126555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBD89396C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C350BB213E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A9710A09;
	Mon,  1 Apr 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9kHskLK"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7769182BE;
	Mon,  1 Apr 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963803; cv=none; b=aKn8uDsXtQUTx9Euc2xyOey7ZxUEL+8v0Jg10/hcMpfcD0vaadHjBIUQzEhNYniG+JrsW5wqFSYmpdvFuLo1+XhSW2PQ977mDh8NCQyCnlFyA41qvKrXKD+3YbdqeoaCZU+GtFh1ASPnSTTotNtIPbq3NRoFonXXumKENfNt12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963803; c=relaxed/simple;
	bh=rkQU0E47V9cQNuNbdmccVzjqdfD0TLNiFYUMgLn8uQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrTJfsECB1mSyKW9PpR/Lqg1X33wQUBs2nym+m0GN95enD05Tud8ubGl7MiGllKDLdze721TG7nWPDlKe0UI+U+Q2hNgzw05c3ZnyA2XeXZK+12/jI0m1OFiZOc06Kg7Ga223QzB+Ek0XRV4S4R030JwYI+dpLw0UGlYuAXt5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9kHskLK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46a7208eedso493327866b.0;
        Mon, 01 Apr 2024 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711963800; x=1712568600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzvXmCSYtRNk7KRlSnum6WriN69z0KpOciEJnQVFIQc=;
        b=V9kHskLKB+yIfmwtu1xAuXiVuYbQ4O8jBu5QfLEmBXEUaTP5PKNZPHDxfYzDZpF2l2
         ywSo4XGax6xTSiTBugiW2ByqI53NoCqsjYTZO4xPkg9EVi3x6fSsg5BG23dHoSwtGhk4
         lV1B/UaHyjIC4nTNJYdom7lt4bQ+D8Fo7CbqSZF0CIev77Pe6rDghQHPft3KfgANucTp
         OJsBsmI07Wjsb5r9gD9UoOVPl1vKXXyh1JflhWXMmBVA8SoMK22dFaBAOr39yEQOhL0T
         Hif45lXdCPYGPqWs4u8Kmkg3dJFBrwgl3NJNBIwCWD7iEsuBKhUYblqoIs7b6jAtWXP6
         lXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711963800; x=1712568600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzvXmCSYtRNk7KRlSnum6WriN69z0KpOciEJnQVFIQc=;
        b=V1XUbIlRBO65Gn704RT+9niqgWUYbnCnOfvAR8kInMenw31alWjMklJvuYUFL1JAYq
         RB674zQQ6E0IUKcmkki4zJXgOwcXzbEVxOdfPI8D4K1K+KlANzJhLRpxnv+h+IaAGkMd
         KocBMP0pf6YSpB9Xjg8joEUvlkuJFpMKccOzrScZvQurW4+I29AVv7rzSkeFBs+/CN15
         mqRXgtSZAvZb90upj++7f4yjRwYCRlS7D+F+v7tO2g4H2XCSvpFVY7RgLCLd35UopxEV
         Vz94xDuhsQDb1czWhZ6QCGnYv2zrAX0pcbpp/VXOxOBqkyP3NSHUctOeBrUQUvdL7P46
         xbgg==
X-Forwarded-Encrypted: i=1; AJvYcCW/vNIMYptcB7mf5PyoOsH0ROx1mZzATen4UG6/5vThKj/BkFq5jPqpDEzWOidEFIkJovVJIz8KtYSR1C26trT4koYbhRPindtPHm08PYrS0kTtE+x6vSMYWV3FB1Or07s0
X-Gm-Message-State: AOJu0YwDrciH8pRYJWQ7pHYTN/LBnl8gIHelgNIFIjjRo+1dDX609K7q
	6J4Yj5VrEv0GkKdX0yXDDpKnltFfEzpiaPA14dY2jSpARXwgy6PmeKK4+TNQ2Z0=
X-Google-Smtp-Source: AGHT+IEumhouyEX9Dvs628YP4tjp8k5N3mf2pCGZ1A0bS8gLInZF+Cl8NLSl3HNnvQhmtD+ULfgCJA==
X-Received: by 2002:a17:906:3755:b0:a4e:4336:5550 with SMTP id e21-20020a170906375500b00a4e43365550mr4292050ejc.27.1711963799700;
        Mon, 01 Apr 2024 02:29:59 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906840700b00a46caa13e67sm5112440ejx.105.2024.04.01.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 02:29:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 1 Apr 2024 11:29:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/4] perf/x86/amd: add LBR capture support outside of
 hardware events
Message-ID: <Zgp+lYLOZU3OkO7w@gmail.com>
References: <20240331041830.2806741-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331041830.2806741-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> Add AMD-specific implementation of perf_snapshot_branch_stack static call that
> allows LBR capture from arbitrary points in the kernel. This is utilized by
> BPF programs. See patch #3 for all the details.
> 
> Patches #1 and #2 are preparatory steps to ensure LBR freezing is completely
> inlined and have no branches, to minimize LBR snapshot contamination.
> 
> Patch #4 removes an artificial restriction on perf events with LBR enabled.
> 
> Andrii Nakryiko (4):
>   perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
>   perf/x86/amd: avoid taking branches before disabling LBR
>   perf/x86/amd: support capturing LBR from software events
>   perf/x86/amd: don't reject non-sampling events with configured LBR
> 
>  arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
>  arch/x86/events/amd/lbr.c    | 11 +----------
>  arch/x86/events/perf_event.h | 11 +++++++++++
>  3 files changed, 48 insertions(+), 11 deletions(-)

So there's a new conflict with patch #2, probably due to interaction 
with this recent fix that is now upstream:

   598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")

I don't think it should change the logic of the snapshot feature 
materially, X86_FEATURE_AMD_LBR_PMC_FREEZE should be orthogonal to it, 
as the LBR snapshot isn't taken from a PMI.

Thanks,

	Ingo

