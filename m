Return-Path: <linux-kernel+bounces-133853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DB89A9BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C2228151C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2B23765;
	Sat,  6 Apr 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jrEZuNYN"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BF22F0F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712391227; cv=none; b=JuymwQ6IPX2RtwoIITY8OjS39ldaE8sYLVz9ubi6p7pfldn4yXeXd/4t/018B6gS6SpgGprC8lB9AqdrPt0uTGkmUNUO+HO90F+1oZ/Q/Pq36UXxdkqu+c1Cy4ALH4lA3e6UpjnT0VSfQFuVKeYPB4DqY/BQtLr2tgJ+WIdjIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712391227; c=relaxed/simple;
	bh=Ok3cHEbOCqoXYq6UqpsUBQYpX66UX3Wh8EvM3EaWyqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTGzpz6gv3JkZfxi4N6DYbmm1ioIrNEpLZBlIXLEzXQjdUrICoTWQ/8xpqpoY3eC762pi8sslnKoP+coKtW41HuiVEFufSgDvCvK2nrmAHupB0yfrlbgxXjkhPeKA6SNqnL0HEv54gJTBtPTdNMyu24dMdsIQ1YlLDfEAApj5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jrEZuNYN; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D9AEA3FB6E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 08:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712391221;
	bh=4w5lg7DeOe3LCRsqgZwV7U/9sNfG7JcNUgXKCyuVpSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jrEZuNYN4kZNi1/c6+Uw+ENUGn0yEvKbcsKcP+drPKoYJT1fZCEqPtMcWeo/ZM214
	 2P6o/QpUxZLSTrxrTt9xKyvWtE5/nQIAwwEKT2P1iyXnrxjQgsnrmfvFvBBxubQmvg
	 ysy318+Dsn5nptHQrZLV0RLBgrCclqoTH4FcLQwLUIti6m3kloR+fe7KQ48cOjyzuf
	 uT0hCx1XVuHM13tG+6ew5okUnElGJfim04HVxFlNMZs7VJ43pGRw2Ej8BWkXxLOdh1
	 xv5WlrkBfQFubygJMRzkp89VSOYDZ9s1fb0D4Xyr3i0+aMmQ0NvTrWoSaGCGcfngwR
	 QMZIjSmulFTPA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343cfa7a9ebso1289794f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 01:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712391221; x=1712996021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5lg7DeOe3LCRsqgZwV7U/9sNfG7JcNUgXKCyuVpSs=;
        b=UYCYerKlRumemtftofFGY6LAelhCdoii/pXY7e+8K2qQTnFuIlwhkV+KfAL5XKk2eZ
         H2o8FLW5wUU+Rrn7DcK2wWDRc0llkzAZUPYEaLO5NSjPek1tZkaTjXEaF4F2zvWKNYHs
         d1/rEIRnK/yI/gg8YN6EzNazd/ztzUcf/g5GlwsAmlBuCcrd2pd2cwI6uKGRtCv5ZQha
         GmP1gzK6Dh8N6aKu+BF2bSMeMpMEsWS/7NNndZP8FXhc4tV1CujnJvamOcsvb99GCz4K
         NBBrCvgCJCIO4oGdrW9KGE3B256Z8UcoEWJ9GHmPtDud8FinqlwirSFRIU/VDsiGeJVi
         svKg==
X-Forwarded-Encrypted: i=1; AJvYcCX42d6SXxwnnAKy0kb4Qqg4/UBrz2IJ/Uf0TNFCGYnOTap+UpCdmMdjaWm0NcNQNaf1qBc5GNuSWGTJxMKRVIVZLhs6DBEoUoFg9PhT
X-Gm-Message-State: AOJu0YwERpeOzB8GT9msDrWPdM2idAVuxWJso9qhhl5yI9ouBHeC9NXn
	99t0EFxQ8UzYIdSaC39W3ya7N/oWnUK/s6LNpE8NpkCLrnIvM0rIzlg4KbVremN2QtGtwVCy9Dq
	aKkCc+EU0w7IJqsreui67JP+H21GfmOBmlEo4gH/CWX4t2OFN+riwQrCdwDfzPVqxPFg5ND1CPU
	s/fw==
X-Received: by 2002:adf:fccb:0:b0:343:bd44:b8bb with SMTP id f11-20020adffccb000000b00343bd44b8bbmr2556619wrs.12.1712391220859;
        Sat, 06 Apr 2024 01:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT0iyPV+c5mEtz/7mmX5nHiU4zAbRw6sQgj0CzMiZl4lXnM6HwckvfVU2cBGk8aUQQoY5uEg==
X-Received: by 2002:adf:fccb:0:b0:343:bd44:b8bb with SMTP id f11-20020adffccb000000b00343bd44b8bbmr2556586wrs.12.1712391219960;
        Sat, 06 Apr 2024 01:13:39 -0700 (PDT)
Received: from localhost (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id q13-20020a056000136d00b00343e3023fbasm3634187wrz.34.2024.04.06.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 01:13:39 -0700 (PDT)
Date: Sat, 6 Apr 2024 10:13:37 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] libbpf: API to partially consume items from
 ringbuffer
Message-ID: <ZhEEMU_M2qSISfxB@gpd>
References: <20240405223556.11142-1-andrea.righi@canonical.com>
 <CAEf4BzZyd2T_S+46NcKsM-Vv0mMnsgGd_Hzaq7tn4DFkD+GOGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZyd2T_S+46NcKsM-Vv0mMnsgGd_Hzaq7tn4DFkD+GOGw@mail.gmail.com>

On Fri, Apr 05, 2024 at 04:16:34PM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 5, 2024 at 3:36 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Introduce ring__consume_n() and ring_buffer__consume_n() API to
> > partially consume items from one (or more) ringbuffer(s).
> >
> > This can be useful, for example, to consume just a single item or when
> > we need to copy multiple items to a limited user-space buffer from the
> > ringbuffer callback.
> >
> > Practical example (where this API can be used):
> > https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217
> >
> > See also:
> > https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u
> >
> > [ Note: I haven't implemented the special case of n == 0 as "no limit",
> > because we still need to add a bunch of extra checks for INT_MAX, making
> > the code less readable and, from a performance perspective, it seems
> > that we may get more downsides than benefits, but I can try to look more
> > at this if you think it's worth it ]
> >
> > v3:
> >  - rename ring__consume_max() -> ring__consume_n() and
> >    ring_buffer__consume_max() -> ring_buffer__consume_n()
> >  - add new API to a new 1.5.0 cycle
> 
> You also need to update Makefile, CI is failing right now ([0]).

Yep, I wasn't sure if should have bumped up the version as well
(in libbpf_version.h). I'll add that.

> 
> Please also add a simple test to BPF selftests using the new API.
> Other than that the changes look good.

Ok, will add a selftest.

Thanks,
-Andrea

> 
>   [0] https://github.com/kernel-patches/bpf/actions/runs/8576515495/job/23507610313#step:11:73
> 
> pw-bot: cr
> 
> >  - fixed minor nits / comments
> >
> > v2:
> >  - introduce a new API instead of changing the callback's retcode
> >    behavior
> >
> > Andrea Righi (2):
> >       libbpf: ringbuf: allow to consume up to a certain amount of items
> >       libbpf: Add ring__consume_n / ring_buffer__consume_n
> >
> >  tools/lib/bpf/libbpf.h   | 12 ++++++++++
> >  tools/lib/bpf/libbpf.map |  6 +++++
> >  tools/lib/bpf/ringbuf.c  | 59 ++++++++++++++++++++++++++++++++++++++++--------
> >  3 files changed, 67 insertions(+), 10 deletions(-)

