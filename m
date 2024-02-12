Return-Path: <linux-kernel+bounces-61833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F9851734
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726871F2244F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE63B2A1;
	Mon, 12 Feb 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Xg/VaY9I"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29528389
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748926; cv=none; b=J6N+BdPKDSAcjaDq+2gMIOnYktTScO0oMRAPsx7dUJwDLTf+8IutDoLEUlvhm+EmXH8iO98PV1V8wIBLLRTJMgPIDZ5wX0M5zLxjUjIjmqe4qoVyURe2sUk4wLBg70dC/vXWOs3W401te0hgdh6giSAw2DUfmNsltI429cU28RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748926; c=relaxed/simple;
	bh=Q58jHMbdczr1QNQ9yal7uDFv5eQVAZ5JpemgWEb/poE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQUYQ4Wp51LOATCHRGjtsXD+8qqWwP9CAZWJTdClwIEEXqK3gM0PxEuZpThWn577qJVop8U+XhuqHiQSugc9BzrKB4THrPPFSL72UrXbQ7bJPxhAXwiJsUP4Z2ypypjxatT+WZooQjYzE/fwZ1tAXEjw2gQElQHo6gxqoz/KNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Xg/VaY9I; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so48226771fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707748922; x=1708353722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkVfY0CXlqlMXrOfGdGvvl9MskXVVA29DHFd8SDHqqI=;
        b=Xg/VaY9I4i/QUfSLbW2uPQC1MNfzexii2lN9RoMLP6r5D2y2sh5uDu4FO2u7Naj8za
         u+p7agfyBHQMglksm7HUMA1obfu+JZDcBqv+sUPdtsKkZxNKClG4W7CgozHoBTywKK7u
         PZSeOs6K4Belw5UKZptW738iRP9XUmuWgTnbxiMcZx6f5fJNujplIdLwS9yPNGQDvduz
         eVYyPpzNMZrWDcYmiUOcwnlHsDKSHfWXpXYSAyhGzZmpaNDp8tlkvzdvtRaSkIFsefZb
         CJPR27pUqomr7tAgkTCXYrL0OdiXcAEIZAfCE9RcK/CAg2uFt+UHhfLevKpV5gEs5DSo
         UAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748922; x=1708353722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkVfY0CXlqlMXrOfGdGvvl9MskXVVA29DHFd8SDHqqI=;
        b=qQcC/ExAnSD+g7WJ6an6qIHQSsIJUUwKYhDYQLVCbYn+yugKp2MUIMRs2B4jrbglPH
         fcPGmIRvMOsv/zC0QI14X03MoOddc5YgaN7z+DZ7D9dHbJ+XwU54fTrgb7ffPVDsq/Ah
         JhAhsIe896DlpV4fa0aSs3o2pCIUx7xJo9HdV+v1ylcklfXRpC9LJOsdtG2HNrtv/hw2
         ICHlswdjMU/UI2KD3OxWD9++j6tMY8DPeElVds35BNf4L1TreJSDSIMQOegmHto99s2N
         YVlWLLUYHIYptu+S3ulI+rQXOrykzDddNdZqshmNfmMBLuef/ALWsiV+vnggj2/wObO/
         KK+Q==
X-Gm-Message-State: AOJu0Yx1vCnUVo02I7oVvTt5X08LfJ8Mz9X1spMx/Fx2AFZUCMpIFjqS
	osV8tdsO2+tP57GBtowi/y8oz65hp+KfdhZM7/2SfNpx4clwCk5tOjGoq5l6D/MeOslBxLlSXt0
	fmHbVOPElIVSLo7mB1T4v1Ejyf3lcRn9LZRECeA==
X-Google-Smtp-Source: AGHT+IGnVCqP6wcMH+J4pJYLv7ZctL8BmODl0pCk/Z8LXuOhznjQwbogRAuQXCPUphf723OPAn0uWYetKoTVAR+mZBo=
X-Received: by 2002:a2e:7a07:0:b0:2d0:c19b:ae8d with SMTP id
 v7-20020a2e7a07000000b002d0c19bae8dmr4242120ljc.40.1707748921741; Mon, 12 Feb
 2024 06:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211123000.3359365-1-max.kellermann@ionos.com> <ZcojpuqGNToctwNi@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZcojpuqGNToctwNi@FVFF77S0Q05N.cambridge.arm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 12 Feb 2024 15:41:50 +0100
Message-ID: <CAKPOu+_GXMK=wv=THXqa9knS-vBf4JWd0VaTz93-hxucAS18vg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Fast kernel headers: reduce header dependencies
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:57=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
> * Patch 1 is *gigantic*. 3MiB+ of plain text cannot reasonable be reviewe=
d by a
>   human. This needs to be split into smaller patches, and that needs a mo=
re
>   thorough commit message (e.g. *how* you determined specific headers wer=
e
>   necessary).

I understand that this is a huge patch that's difficult to review; but
really a hell lot of "#include" directives are missing, and I didn't
know how to split this patch in a way that would make review easier.
There would be many small patches all with the same commit message
essentially doing the same, just for different source files or for
different target headers - is that really an improvement?

>   This could probably be a series on its own, or could be split up along =
more
>   logical lines (e.g. have a series cleaning up a *particular* case of in=
direct
>   includes).

I can do that if that's the consensus.
So, let's say one patch that adds "linux/kobject.h" everywhere it's
missing in all sources across the tree - and then one patch that adds
"linux/sprintf.h" across the tree and so on?

I have no real opinion - I just kept refreshing that patch in stgit
with all the includes I found were missing because I had thousands and
thousands of build failures while working on the following patches.

> * There have been three versions of the series in two days. We usually ex=
pect
>   several says (e.g. a week) between versions, and posting multiple versi=
ons so
>   quickly just spams reviewers' inboxes and doesn't give people sufficien=
t time
>   to provide any meaningful review.

Sorry for that. There were so many combinations of architectures and
configurations that kept failing to build in LKP, and I didn't want to
keep them unfixed for too long, so I reposted with all the fixes, and
then more LKP failures arrived... after I ran "randconfig" in a loop
on several architectures for hours. The kernel headers are a fragile
mess, and unfortunately my attempt to clean it up is more messy than I
wanted it to be. I'll avoid to repost with fixes so often.

> IIUC the same is true of kernel.h.

True, and this patch set contains a few patches to address
linux/kernel.h. With my patches, only very few headers depend on
linux/kernel.h, which I achieved by moving very basic macros such as
lower_32_bits() to a separate header.

> How have you analyzed this? Are you using any specific tooling, or has th=
is all
> been manual analysis?

Manual analysis. This started off as a naive attempt to write a kernel
module in C++. As you can imagine, there are lots of problems with C++
compatibility in kernel headers, and because I'm lazy and didn't want
to fix all of those, I tried to reduce the set of headers I had to
include from my C++ module. With each C++ compiler error, I checked
whether including this header was really necessary; many weren't
necessary, but removing them caused build errors in hundreds of other
source files unrelated to my work. This turned out to be a rather deep
rabbit hole.

(Spoiler: I was able to build my C++ kernel module even before I
submitted the first version of this patch series - I have a few dozen
patches on my stgit stack for C++ compatibility which I will publish
when they're ready. But first the header dependency patches should be
merged, as they're a precondition for my C++ patch set.)

Max

