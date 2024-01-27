Return-Path: <linux-kernel+bounces-41105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE283EBF1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D4284B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7E1DA20;
	Sat, 27 Jan 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUhII6x3"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836901DDC9;
	Sat, 27 Jan 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706342621; cv=none; b=OxzeX9R1WbvoisyqPHr00DmLosf8jU9jNOcpiGAlnjl8qLT0PYrz/hM4aKlns7QROGz0WjT0a4Vo1vTXBedWt58qQOVbKqHp1/Rk8Rz+q36zxqzj4ZeHlE3ahe7gCYz5ma21hS+BVwbwHHd9BjUnuXFMVEsRZJQ3rwQysthIX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706342621; c=relaxed/simple;
	bh=oJOghBOhISnNjhnFNuK2EmnH9DA2LqZ2Je0BGaoXHRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuDXF/MN8h6Qps7jnrUS7PqQoPnInJMRll4HNZQ3r9QGIS1MTFvh4XTSSuNDp52VyQpb5JMxJI72xbXfyrXWn38wwQhqXglhtkf9n/OyRxxOZFg0QePPU8u+6XZPJS5d1fVGtsDZJ4mgMDqJ+idJ8yFHNlbQ5GbHz4uJeK/J9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUhII6x3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2134204276.0;
        Sat, 27 Jan 2024 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706342618; x=1706947418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJOghBOhISnNjhnFNuK2EmnH9DA2LqZ2Je0BGaoXHRI=;
        b=ZUhII6x3SmtG6MvTfQWykNtJ7R4z9zuBZn9lPsetuoavX6VPFXFDY7TtmPDd7Wwcv/
         IektjzI+mF6rUVSYWD3+f8oRIhlTD/7cA3QfVSg0MJo/vT+77HkYnQExA3vSEm0XXvqp
         QNyNck6vCKsXFPRgdRDL52NXgIhkYe5uB/WQx/ncnApGYxyPGOPPrrYihKZtpYYriONh
         6Iw0Wcq20REDOqKO/fLF7lkBcKLcnTJKCsKo6ZuOa3RWdk9NiLZdnKB8/o0tomtub2u1
         1UTmunPSC4jhCjaIKmQ5JMPJM5ATe11gOte9IDjqgFdRZ/ZJyJXCc8lXCi7GbUVBYkFo
         XXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706342618; x=1706947418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJOghBOhISnNjhnFNuK2EmnH9DA2LqZ2Je0BGaoXHRI=;
        b=bdQbs8JgzmUVFU8yX5eBcmpalBJ3gpiL1rtMxMuC9O3xCvIy0HMT2yIsiA8MFGlXdZ
         jZoV/on7OTI5Zb3WkGOJoiNnaNHiP6/A5UfCpF4sVeC1GckmXpeqcgCJ5TXLK5rE6fIy
         SvwJW/zYhN+gPBlobMSxfZTIX3ysqUeTJmL50lPYtbIS5ENeDPO4L5aEAB+irl+meEGL
         Mb4ntkTBP712tdwrem4DDKWwSc72XSPIPRaVtn4HAUdDBl4gcOz842G80xaXWQmgolyj
         x2SlqYt3I2lpx94W6b25htmJAFOhoRcpRPVEANxJBxXZwmqrTKhJUfdpo1KbSpLKYKR4
         AWdg==
X-Gm-Message-State: AOJu0YywvY4Eeap0c6rVZnEHu2Oxxl7MiobNOlOQ1GuowQKufYdHpJEb
	FeUHUIwANmLqECiCcb3w4LOQ8KummOjllO40TW/L7sNK4RRNxDTTsWj7LVrh+b9YL4n3KSx0MPA
	kFm69EF1Kv/4ccFC/I2jlIG247Ys=
X-Google-Smtp-Source: AGHT+IGv4FSdj+g79HmeUw1/bUvDs7qmzfXrL/koI/HWaEGHgTpaOzXSsdQn2O3NNGee5xiyVfM+p12nqawJhQz3MWo=
X-Received: by 2002:a25:8886:0:b0:dc2:35c1:f280 with SMTP id
 d6-20020a258886000000b00dc235c1f280mr1637172ybl.43.1706342618198; Sat, 27 Jan
 2024 00:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
 <CAK1f24nS8MEA3wcS4za-uSp7ZBxvd+xqMRf8-u=m5uCvTs8yJQ@mail.gmail.com>
 <CAK1f24kOYDOw26ov5TVpAyNP13hCjm=cDo4rooOTPDuv8L6Pnw@mail.gmail.com>
 <CAK1f24n0152CmPghBLQ7225=rwEuP6mMdBybWZz7heTLzemBqw@mail.gmail.com> <CAAa6QmRZP5pL_5O7BpfjQf5LZ_ADGqYF_xdAYEbKXkqMViAwLw@mail.gmail.com>
In-Reply-To: <CAAa6QmRZP5pL_5O7BpfjQf5LZ_ADGqYF_xdAYEbKXkqMViAwLw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 27 Jan 2024 16:03:27 +0800
Message-ID: <CAK1f24kc9pnOktT9zG68FykViGNnL+B9h+jCkF28YSn0PM7N9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>, 
	Yang Shi <shy828301@gmail.com>, David Hildenbrand <david@redhat.com>, songmuchun@bytedance.com, 
	peterx@redhat.com, mknyszek@google.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zach,

Thanks for taking time to look into this!

On Sat, Jan 27, 2024 at 7:47=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> > I=E2=80=99d like to add another real use case.
> >
> > In our company, we deploy applications using offline-online
> > hybrid deployment. This approach leverages the distinctive
> > resource utilization patterns of online services, utilizing idle
> > resources during various time periods by filling them with
> > offline jobs. This helps reduce the growing cost expenditures
> > for the enterprise.
> >
> > Whether for online services or offline jobs, their requirements
> > for THP can be roughly categorized into three types:
> >
> > * The first type aims to use huge pages as much as possible
> > and tolerates unpredictable stalls caused by direct reclaim
> > and/or compaction.
> > * The second type attempts to use huge pages but is relatively
> > latency-sensitive and cannot tolerate unpredictable stalls.
> > * The third type prefers not to use huge pages at all and is
> > extremely latency-sensitive.
> >
> > After careful consideration, we decided to prioritize the
> > requirements of the first type and modify the THP settings
> > as follows:
> >
> > echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> > echo defer >/sys/kernel/mm/transparent_hugepage/defrag
> >
> > With the introduction of MADV_COLLAPSE into the kernel,
> > it is no longer dependent on any sysfs setting under
> > /sys/kernel/mm/transparent_hugepage. MADV_COLLAPSE
> > offers the potential for fine-grained synchronous control over
> > the huge page allocation mechanism, marking a significant
> > enhancement for THP.
> >
> > If the kernel supports a more relaxed (opportunistic)
> > MADV_COLLAPSE, we will modify the THP settings as follows:
> >
> > echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> > echo madvise >/sys/kernel/mm/transparent_hugepage/defrag
>
> [corrected, via 2 previous mails, to: echo madvise
> >/sys/kernel/mm/transparent_hugepage/enabled
> echo defer+madvise >/sys/kernel/mm/transparent_hugepage/defrag]
>
>
> > Then, we will use process_madvise(MADV_COLLAPSE, xx_relaxed_flag)
> > to address the requirements of the second type.
> >
> > Why don't we favor madvise(MADV_COLLAPSE) for the first type
> > of requirements?
> > The main reason is that these requirements are typically for offline
> > jobs in the Hadoop ecosystem, such as MapReduce and Spark,
> > which run primarily on the JVM. [..]
>
> Hey Lance,
>
> Thanks for proving this context, it's very helpful.
>
> Though, couldn't you use enabled=3Dalways, defrag=3Ddefer+madvise, then
> just use prctl(PR_SET_THP_DISABLE) on type-3 workloads to get the
> behaviour you want? i.e.

prctl(PR_SET_THP_DISABLE) is a good choice that can fully meet
the needs of type-3 workloads.

I might prefer using enabled=3Dmadvise, as this would allow
applications to implement specific calls to madvise to request huge
pages selectively. If we set enabled=3Dalways, some applications
may not be optimized for or may not benefit from huge pages.
In such cases, using huge pages for all allocations could lead
to suboptimal performance.

>
> type 1: apply MADV_HUGEPAGE -> sync defrag to get THP
> type 2: don't apply MADV_HUGEPAGE -> use THP if available, kick
> kswapd+kcompactd otherwise

Sorry, I did not express myself clearly. The type 2 of requirements
should be:
type 2: apply MADV_HUGEPAGE with defrag=3Ddefer, or use a more
relaxed (opportunistic) MADV_COLLAPSE.

> type 3: use prctl(PR_SET_THP_DISABLE) (or MADV_NOHUGEPAGE) -> no THPs
>
> Or am I missing something? It sounds like a confounding issue is that
> these are external workloads, or you don't have ability to modify? But
> that would preclude MADV_COLLAPSE (unless you're using
> process_madvise()).

Sorry, my previous explanation has been unclear. What I meant is
that the requirements of type-1 workloads can be independent of
any sysfs setting and can be addressed using madvise(MADV_COLLAPSE).
In this scenario, why haven't I utilized it? The reason is that I
currently lack the capability to modify the JVM or PyTorch to
make them compatible with madvise(MADV_COLLAPSE).
Therefore, the needs of type-1 workloads still rely on sysfs settings.

>
> Appreciate the help understanding the use case. I'm not opposed to the
> idea in general, but IMO would be great to have a clear need for it

I appreciate your perspective!

Thanks again for your valuable insights and your suggestions!
Lance

> (and right now, we don't currently have alignment with the original
> motivating usecase (Go) in that regard w.r.t their plans).
>
> Thanks,
> Zach

