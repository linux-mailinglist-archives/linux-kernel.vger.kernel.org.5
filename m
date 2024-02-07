Return-Path: <linux-kernel+bounces-56328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6F84C8C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4EA1F24CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007C14A9F;
	Wed,  7 Feb 2024 10:39:14 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE914281;
	Wed,  7 Feb 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302353; cv=none; b=iVFdxo1d9oPt8aBJnL2ubaPjlkXrJLKXwbeWsDGUGr2u53mK6MZ8zeoK6Hoom8CUOzI0/Ol5vQD+kpIPQQRBeO4Br8QZ+0iNGXXg4o68obLlgjH1yKr0nAGkc6SnAChkexfDLUusOXBwPxYXk76yVWSizPxNogUePR0uBW+ikb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302353; c=relaxed/simple;
	bh=gE6SAJEXxSF8lMihno1P6E66BnJYxILkKvLcrIl4Od8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ht9gKN2qXmws/aw8sqCvjCmUDVl62zx8kyKYkkRIDYcdfq4LsIfHMrPKIAKXK9kwK+Z9TVufhM6WldVB35gnrHs6OJRU+IyULVdQFd6chh0Iw00uFJACIZKs7Llw5iNnVUBzV2lxJZnYgVxjdqlBuOHWhAPGC8oc3Bad8rilNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2b801c5a9so31871a34.1;
        Wed, 07 Feb 2024 02:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302351; x=1707907151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5vsCn4enzggiJdbpvmX5GI9tH3dwN15rhRbQaFF3lY=;
        b=LjozTZed0bXi3Odcy7bnP1Wufk37sie46X1EXWluk7UAkL8DXYmlxTL4dGRsrqUl50
         lNnRyMxxUFkSmabLVIpJWSXq8DHyHEQf9gQgMfzCCN9AV/nbvMY3MrP88v9EmeZ+SJcj
         sSV1HvxSRbjHoAdXnb73rwA9QFfaBArN0zTbt9Z15kxYTI7fI8p6AHeSDaQUVqvufgTB
         80VAZ7h0yUs6EfEu17ExKmDAAv3p507gXMNKp0doOgs9BPKweU4MMEgh323kamEZxSvC
         C0QNqprCrHpdM8NIlMdDXaGtq7iv46Iit27y7gjxomjtIDFkCBTnFc+cL4Y5AAQFzKtm
         YECA==
X-Forwarded-Encrypted: i=1; AJvYcCXIb+h3PhJscuW1hKrs9LDj9KYhdzgljJGoDcMxpWhifW88ybE7ZkjYousQCs4t+h335BQGpVUwFjVX4CzKTopb7Nrfjvwowgyur9a3wMVmT7aMx4koL6iuZtdDRQhgvNVygB4Qjyk=
X-Gm-Message-State: AOJu0YyK883ic22a2i1iBaZEIxUW2FP9yQley3xQwp07T7rJSj6wPxVn
	11vWe0bTqV+WUukJnxJ4tiqYUp7qgBJ5nm7XWrm6/KPzBXdE5FdCcLvbACvZhbMzWZpvESpbJM7
	9VLSFXsPgJ66maedT/c/a2oSO2x4=
X-Google-Smtp-Source: AGHT+IFs7F0FcNFhvjfCMNqzNrKwts/lOSiz1geoDzpOUmz/gw1UtesLLTgfwcWXmLzFHSO3JU3gMbt8dgiw9u8nUWo=
X-Received: by 2002:a4a:eb03:0:b0:59c:7c63:928f with SMTP id
 f3-20020a4aeb03000000b0059c7c63928fmr5772477ooj.0.1707302351226; Wed, 07 Feb
 2024 02:39:11 -0800 (PST)
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
Date: Wed, 7 Feb 2024 11:38:59 +0100
Message-ID: <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Tejun Heo <tj@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Naohiro.Aota@wdc.com, kernel-team@meta.com
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

If you echo 0 to /sys/power/pm_async before suspending the system,
does it still fail?

