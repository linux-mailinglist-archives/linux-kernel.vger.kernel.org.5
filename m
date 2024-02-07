Return-Path: <linux-kernel+bounces-56352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B7184C919
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB128325B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F817BD6;
	Wed,  7 Feb 2024 11:00:02 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8E1758F;
	Wed,  7 Feb 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303601; cv=none; b=rfyyQakgZw7dObRThfuLTHOfejoaG+7X5KV1DL5BUHDlkVgvRKklb1PT4apnbXi5qAvJYQ2+GhFRhi6ObAILpi0JldpJEb4GdwpUWYql/Icn45XTHx8NMC6LCWI0FLaotX3oQUBPeHyAJwsga8snUKLitOmvr7amBrUNgCFQJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303601; c=relaxed/simple;
	bh=rhOnNebZoNvqU/zfuWIA00xIYNO+/eVwDUnSGJ/46p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgBCkVO8QXfkT7mP59MusqEUyG/UfRlLHXxLWiRrLxvAg9a2Bz1deSKg8I4qPMm0NMXezY3k5wuVR3+vrRtMfRqXh/zChybBfAzb5Tzm4d/0Oo7sY8ulCEPeKOBnpCxJ/NZ6sWHCwhPDSOZvFD7kqHnxpv0lk5o004+nJb6ncIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2b466d213so110874a34.0;
        Wed, 07 Feb 2024 02:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303599; x=1707908399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sExFoHZdM7tavbQktzWDKNSPGgz/wOkx57VhkxhoRdc=;
        b=m2bs88PzmIc2NTI9uvBlyyr2BJk2n34s3gNNRvxrdqn+YKy1Ny9kq8JKvgHJaxYo0k
         wh/Q55iRuBg1IgllNb7lKmjqjVj1EF1WaJSa+syyN7QaIL5DitS1Ygt1/XOiB2bxHUTb
         ok7Intedjsr3ihpdlScLyzerRnfu6CW+Q4b8RpTWMFjT6FMa1khaSGCGfUfAikCpYW6M
         CNHFTQJR6iHweluvj1CizeeFrqSRG7mEtDBk8WB0MkMa/q744FfwRQrhKw1mdNwZNQAk
         Zv/VJYLvs7utWdtU9P5TzotvnfOAxI3tEsN9nG4COlpTunYnHcR4Tke46iLpAWKEIZeO
         pDAg==
X-Gm-Message-State: AOJu0Yxg/RnyvgwlUCLljgMT/mBIrVY7A5tdTZoxCP/qaCeDb8PxS0j/
	i/7J+TaU+7ZHEKRky/qQ2bz1yH6ZEWc9MclGEB3hnpFrEvvwHRiKhgp/vsNYgCxFF9sdCmhKamd
	y8vQOmKk/TklPWvv5MeWgBD2WmEY=
X-Google-Smtp-Source: AGHT+IFfoD0N7y6pI+AZnLFgIdcJ7w2Xw3xyOLtn7BhKeNVYNqZIxGgiq1bzzJABfjZ3GZrWD+wp/blXyQuoB9a5+jM=
X-Received: by 2002:a05:6820:405:b0:59a:bfb:f556 with SMTP id
 o5-20020a056820040500b0059a0bfbf556mr5297343oou.0.1707303599085; Wed, 07 Feb
 2024 02:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher> <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
In-Reply-To: <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2024 11:59:47 +0100
Message-ID: <CAJZ5v0g7VNdRtYsjAf-X24KtmnLzSXqgroReXAOeOQ+Myi2_Rw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Tejun Heo <tj@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Naohiro.Aota@wdc.com, kernel-team@meta.com, 
	Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:31=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Dear All,
>
> On 09.01.2024 17:59, Rafael J. Wysocki wrote:
> >   From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> > system-wide PM code"), the resume of devices that were allowed to resum=
e
> > asynchronously was scheduled before starting the resume of the other
> > devices, so the former did not have to wait for the latter unless
> > functional dependencies were present.
> >
> > Commit 7839d0078e0d removed that optimization in order to address a
> > correctness issue, but it can be restored with the help of a new device
> > power management flag, so do that now.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> This patch finally landed in linux-next some time ago as 3e999770ac1c
> ("PM: sleep: Restore asynchronous device resume optimization"). Recently
> I found that it causes a non-trivial interaction with commit
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement
> for unbound workqueues"). Since merge commit 954350a5f8db in linux-next
> system suspend/resume fails (board doesn't wake up) on my old Samsung
> Exynos4412-based Odroid-U3 board (ARM 32bit based), which was rock
> stable for last years.
>
> My further investigations confirmed that the mentioned commits are
> responsible for this issue. Each of them separately (3e999770ac1c and
> 5797b1c18919) doesn't trigger any problems. Reverting any of them on top
> of linux-next (with some additional commit due to code dependencies)
> also fixes/hides the problem.
>
> Let me know if You need more information or tests on the hardware. I'm
> open to help debugging this issue.

So I found this report:

https://lore.kernel.org/lkml/b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.or=
g/

which appears to be about the same issue.

Strictly speaking, the regression is introduced by 5797b1c18919,
because it is not a mainline commit yet, but the information regarding
the interaction of it with commit 3e999770ac1c is valuable.

Essentially, what commit 3e999770ac1c does is to schedule the
execution of all of the async resume callbacks in a given phase
upfront, so they can run without waiting for the sync ones to complete
(except when there is a parent-child or supplier-consumer dependency -
the latter represented by a device link).

What seems to be happening after commit 5797b1c18919 is that one (or
more) of the async callbacks get blocked in the workqueue for some
reason.

I would try to replace system_unbound_wq in
__async_schedule_node_domain() with a dedicated workqueue that is not
unbound and see what happens.

