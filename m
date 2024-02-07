Return-Path: <linux-kernel+bounces-56390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B75E84C994
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115BD28677C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C281B297;
	Wed,  7 Feb 2024 11:26:00 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD569182A7;
	Wed,  7 Feb 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305160; cv=none; b=roBBLbWIeRfgpyh3CpWsP3kyqngu3Uu+3QrlTgjpA5GdUbduIldbRoTJCoxkTYaLzj6VbK1Xu4i6Cnx/PtNCED+jmIBxApbtJDjfbxZQho5xStADPTU01fH/gC+KrmZCgUx3FHwWWGjyfRP5yggldonCmjPJC2Qv4LLXwiDzgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305160; c=relaxed/simple;
	bh=DEqwGMp8n98ZhsW4wwr7QH/Pkj0zYA0yYxgzS+mhMXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE4ghiY1YpiR3RPxIr5szUaLTpcqLkXNYt0me4krs02qby9V24s2wDOs4OXrGZP0e4ZjnA//oRmN/HhQIFN2csrFLAjgObBTdMNgFaO3C2uc/1oIcGyxCPbhsUVIOfsdnwWXgHlQsHxG+UkOU4OoJ9tyCuulWtra6sQFc3UaylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59a134e29d2so82342eaf.0;
        Wed, 07 Feb 2024 03:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305158; x=1707909958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xF7A8Ou4hLvdrXlxlvRR6oVHQoHgxTK0xBDoHtLPjsE=;
        b=grhE64AEwHh9sqP7PjDceIYc0Buzpyg9zsc/gKlzo6ZG7eVI2kcanvwSiV7MZojkSL
         nTSPPwHLrmWp7VqYEwEVNWSpAPisM8x8IrUyfrn3ruNWjDFlJ/srIW4buiDUwQhs5Dna
         3gCCKckpVxWR1VYTo4psLyn2XtyylWKvr+cnYgeXPg3kEJPcwUE4rpcAzFhqKNZfMSPR
         oBcB3szqomQt2Mf4hJr9Jy6I+mI9i/Y2PAtJcs3cTKsUOzDu/2EaA6+RNT/gDzmbdddJ
         8IiuRdMqWYxAJyQamnm03GEC7n8hA0MmpJ8H3KsaCtdVFMsVsbwRnTULB8mQse8Tghns
         J05A==
X-Gm-Message-State: AOJu0Yzjp55/jU0iyp/TcCejCICPrUmAx7vsJTmixAp1Vpva4YGbumu6
	SXXlT0dVMFhh/W3GP7mANkgv1NnIsaKvsBF0phGq50SFWBpltwY23W7HyRLzxRG3NryfLFjF5YO
	76w45zB3fe29koKcUZGl+0Y7myH0=
X-Google-Smtp-Source: AGHT+IEDDn9W+5izm2ttSOZ/C/FhVUXLZIt0B9qRcxRbpr+Ckhn3ZjH2ObSmgN6ODIkt97iDorlOyHwbO+HrwwU3oO4=
X-Received: by 2002:a4a:e3d5:0:b0:599:fbcc:1c75 with SMTP id
 m21-20020a4ae3d5000000b00599fbcc1c75mr5667681oov.0.1707305157791; Wed, 07 Feb
 2024 03:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher> <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com> <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
In-Reply-To: <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2024 12:25:46 +0100
Message-ID: <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:16=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 07.02.2024 11:38, Rafael J. Wysocki wrote:
> > On Wed, Feb 7, 2024 at 11:31=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com>  wrote:
> >> On 09.01.2024 17:59, Rafael J. Wysocki wrote:
> >>>    From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> >>>
> >>> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in cor=
e
> >>> system-wide PM code"), the resume of devices that were allowed to res=
ume
> >>> asynchronously was scheduled before starting the resume of the other
> >>> devices, so the former did not have to wait for the latter unless
> >>> functional dependencies were present.
> >>>
> >>> Commit 7839d0078e0d removed that optimization in order to address a
> >>> correctness issue, but it can be restored with the help of a new devi=
ce
> >>> power management flag, so do that now.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> >>> ---
> >> This patch finally landed in linux-next some time ago as 3e999770ac1c
> >> ("PM: sleep: Restore asynchronous device resume optimization"). Recent=
ly
> >> I found that it causes a non-trivial interaction with commit
> >> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement
> >> for unbound workqueues"). Since merge commit 954350a5f8db in linux-nex=
t
> >> system suspend/resume fails (board doesn't wake up) on my old Samsung
> >> Exynos4412-based Odroid-U3 board (ARM 32bit based), which was rock
> >> stable for last years.
> >>
> >> My further investigations confirmed that the mentioned commits are
> >> responsible for this issue. Each of them separately (3e999770ac1c and
> >> 5797b1c18919) doesn't trigger any problems. Reverting any of them on t=
op
> >> of linux-next (with some additional commit due to code dependencies)
> >> also fixes/hides the problem.
> >>
> >> Let me know if You need more information or tests on the hardware. I'm
> >> open to help debugging this issue.
> > If you echo 0 to /sys/power/pm_async before suspending the system,
> > does it still fail?
>
> In such case it works fine.

Thanks for the confirmation.

 It doesn't rely on unbound workqueues then, so that's expected.

Now, I think that there are two possibilities.

One is that commit 3e999770ac1c is generally overoptimistic for your
board and there is a dependency between devices which is not
represented by a device link, and it causes things to go south when
they are not done in a specific order.  If that is the case and commit
5797b1c18919 changes that order, breakage ensues.

The other one is that what happens during async resume does not meet
the assumptions of commit 5797b1c18919 (for example, it can easily
produce a chain of interdependent work items longer than 8) and so it
breaks things.

I would still try to use a non-unbound workqueue for the async thing,
because if it works reliably then, the second possibility will be more
likely.

