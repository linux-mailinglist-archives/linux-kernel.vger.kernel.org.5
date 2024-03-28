Return-Path: <linux-kernel+bounces-122824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8288FDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925E9295434
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823E7E56C;
	Thu, 28 Mar 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8lWsfvT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A47E0F3;
	Thu, 28 Mar 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624906; cv=none; b=Gw6x93wMjxp5Uns5DgEhkyW+VGVyf15+0XYgc95e25HiC/pL0dbb6aOG/2VjORgWZmXeSl62mZeSiQZ9Z50YhQT+6sWmFRB16L+Q+hosm7XHrDXl2IVzZUDNhuyyxkYzxKxzUEPNmWcF86qekz4KgqfHC7XxF3342guJ1oUIuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624906; c=relaxed/simple;
	bh=OkVBNlqqRJaQOrciZsmSQWO8Jis40VXRz3f6fJ+Kzzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCksZdpqUA28sT2CduhnjYK4wX4IKTzNpMOkt5Jfnj7XNNtxwbufyOpjlIRyFIkZ7i6Jcp1eHdLHAmRa83o01ijv1AyVKDZ1bNAqyZHce8GDP7XmolelOK3FSKNESSYXyEWTL2sl6ikzGtzxdQqB3WkVWDfakazJVTOKC3wpdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8lWsfvT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so98923366b.1;
        Thu, 28 Mar 2024 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711624903; x=1712229703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzNo9SYNqd+YL8tBc1QX9fg6NtrH9/MJ3e1E3POnwZs=;
        b=H8lWsfvTTkiS8PAlwwKCncPl1pIMiOJuWtYptvP3stAIzHqX97wL0VVf8+y4Z2Zypp
         Us4exL8j8baTqCm1fxJUtkXUBNUlFN/EnCbqoEmJkToovcKm3jj6/4/Jm0G1WKUE3pnL
         pavwKTt0Sx3xoNHMWeAOLP70el5Sp6fXlSQYOayE/wDblu2KgxbJoNE4dQEeF4xydmOy
         hp+w08pFmvWpmAqic4fRqV4GjsAcmegh1+2sdi+OA8V2ulFNM0Coesy3iV2zDxdkb3aN
         /ehLpeX65KMcuLpx7IOVymum3TiU2cl2N6CKD4N+/BAZ3liUNp+HNgVZPqtYhD908/xk
         MMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624903; x=1712229703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzNo9SYNqd+YL8tBc1QX9fg6NtrH9/MJ3e1E3POnwZs=;
        b=Fz4OQqNInCI/0qirXaH5jcY8ajexLldXOW4sGm+1rBh77EV5LTEBTV6B9b4bxcI7+L
         YlFWI4DdJH+8EeaAqkbJzVJcaeZ8Nan1UYBz3nu+wF4PJowRt1rmaQDbSsiYAzpyQ6N+
         ZhqmY2ThoElb6hmB2gPzCwHJUN5FyE7abJJpVknJ+baVCmC6EIsAlnXL2NgHaV3XfVII
         AKyUrJ71KqcCLGfOS/qEFrBqM7pxExhkF1oIhpG55iy/fDE3xfIMLQVuJTbSpI/0ro7b
         N/ez6kM4gt0xKEDXVBqxzvAlpI1ztg6M9PHpTyLPnM/jhMqF41xx5X7v3ALy2aLg2rqA
         p44w==
X-Forwarded-Encrypted: i=1; AJvYcCUAw1QqbX2mnWMLZNbxPO9XvVCRFuCJ+aVFgBxBqHUzburoq/fnel6E/ZyMCEsKgCXhidgFgEJhxIYVwF4kbjHtsrgAz00hjfKaOSJh
X-Gm-Message-State: AOJu0YyKu2MvDYRHckXUVxNeUCglJJUah6xAj13J6BbiVVKYqrLcswTo
	pcIGS46Fim8V5sfU6GsLILOQP1xIS7lgSti4E1A4s8SI4Cxjwz5F
X-Google-Smtp-Source: AGHT+IEdNYRow9MjFrRcXe50BGyvRxUMxGte91cDtCYe1GZaBPikPjZoZlAcsYwbxd+vxErUybCh6A==
X-Received: by 2002:a17:907:9724:b0:a4e:2777:34a5 with SMTP id jg36-20020a170907972400b00a4e277734a5mr580821ejc.14.1711624902952;
        Thu, 28 Mar 2024 04:21:42 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id ae12-20020a17090725cc00b00a4e238e46edsm477898ejc.223.2024.03.28.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:21:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 28 Mar 2024 12:21:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org
Subject: Re: [PATCH bpf-next] perf, amd: support capturing LBR from software
 events
Message-ID: <ZgVSxPJ4Yi/UPgjb@gmail.com>
References: <20240319224206.1612000-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319224206.1612000-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> from inside BPF program at pretty much any arbitrary point. This is
> extremely useful capability that allows to figure out otherwise
> hard-to-debug problems, because LBR is now available based on some
> application-defined conditions, not just hardware-supported events.
> 
> retsnoop ([1]) is one such tool that takes a huge advantage of this
> functionality and has proved to be an extremely useful tool in
> practice.
> 
> Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> necessary wiring inside the kernel is not yet setup. This patch seeks to
> rectify this and follows a similar approach to the original patch [0]
> for Intel CPUs.
> 
> Given LBR can be set up to capture any indirect jumps, it's critical to
> minimize indirect jumps on the way to requesting LBR from BPF program,
> so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> from BPF subsystem (through perf_snapshot_branch_stack static call).
> 
> Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> point, there is no reason to artificially limit this feature to sampling
> events. So corresponding check is removed. AFAIU, there is no
> correctness implications of doing this (and it was possible to bypass
> this check by just setting perf_event's sample_period to 1 anyways, so
> it doesn't guard all that much).
> 
> This was tested on AMD Bergamo CPU and worked well when utilized from
> the aforementioned retsnoop tool.
> 
>   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving@fb.com/
>   [1] https://github.com/anakryiko/retsnoop
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
>  arch/x86/events/amd/lbr.c    | 11 +----------
>  arch/x86/events/perf_event.h | 11 +++++++++++
>  3 files changed, 40 insertions(+), 11 deletions(-)

Please do not queue these up in the BPF tree, all similar changes to 
perf code should go through the perf tree.

Thanks,

	Ingo

