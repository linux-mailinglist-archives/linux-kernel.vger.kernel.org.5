Return-Path: <linux-kernel+bounces-47049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E08844877
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AE7B2687B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA2D3FB1B;
	Wed, 31 Jan 2024 20:10:48 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D03EA8F;
	Wed, 31 Jan 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731848; cv=none; b=nQSPZo9gZxs1/FmOMw3uU0GbfwmbNZsT1hG+goxHXoUsOOgleXkDON/3v78BQwLLKGzNE0hjRSZJjUSp1M+gSpU9Hgwq5ZB/IDyg5Uh39sMTy+w9e7blqkPJy2CIMbe2q8LQ82xzg3hENpN3S+/droOWCzdYbpf+BU19jJfDvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731848; c=relaxed/simple;
	bh=yvIIoyXGudofLdak54lnAl5F/PO/NPHcmWDmLeNKAkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkezZN/ybu/+ykOZm6gdoiBQGdQPiVnzQfBnZ8jv6tlYnSF/IgvqsgV9bDvtvufZTlJTfTnnJtFgIrezqFQ9zFIPbUtSTRmyyJY1s9IAP2ehYJFSS3+Fq2pjpgtrM7nYgHNHrqxKmN0UO4QjDpYp5XHFSH1rRFmLWtDNO0xBxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59a47232667so31024eaf.0;
        Wed, 31 Jan 2024 12:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731846; x=1707336646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1uAoancuJa/9IhiVCyHhohsMalnFxe6NBsvAk35fzc=;
        b=OeVzegZCRHxdSZRNpuJU/oo/gYYC+vvSfsqMWhjxRSEtjbSTCSM2vQcKU3kETNen2q
         /afsTxiVM0BC6EX8PSGBE/33JKl62zj3BujNU5xxmCjyxWlJocoZVNz+Uye7NOWeB7Gq
         q4oNtjuX8FEToyMDbuii4UrCjIVDExX/9UJaS7CEgX9AQ5HDIIL4eaJCnDCV7liT9o3D
         l8lYFA1MOZxAL6jnoBoarrdgnsvpCiwc9mYnucBcNFxHvBeLzxdDQy9R/uKpsCZYg5fx
         xxtxVasU+D6743/sZwASntpYgBZ4CQoviu2IPwo2a0qnNxEMt637vA6+5XGxw/d4PMgY
         918Q==
X-Forwarded-Encrypted: i=0; AJvYcCUdv+2Jb/kB+d0BPDE4ATkXXruFoMxB4kn+vaKzhJ2l693H7Qk6/tSnApn9UrH5waTgCGnmDhUCSNNIQ8zlu0iVhcFnbJtkW6GUVgIRvBI6RslQStC8VwcP96djnuXxNujVU4uu2Rk=
X-Gm-Message-State: AOJu0Yy0O9JcHL/A7ZXMpzSZ3JiC8vGaWKA/MT2S9ZcW0c7vFSY22qW1
	XmtogEXVnaEvubqSvl6SfjB8NDxMZvujg7dqpKjLjKXzqEDpi1gbyg0Tr7lGTvDTUYn69hHshGV
	C7jvM/L5z4tjFE7Ow2Gj508kU3t4=
X-Google-Smtp-Source: AGHT+IHCfXG4/CSj8TyapJXTTLADTLQBjh+rB92N5CLM2HXN4qaRRlGGqGVP2j2UOEnHouTJINBGd8IoEZqiLa79tq8=
X-Received: by 2002:a4a:a787:0:b0:59c:7c63:928f with SMTP id
 l7-20020a4aa787000000b0059c7c63928fmr851678oom.0.1706731845812; Wed, 31 Jan
 2024 12:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131191317.2191421-1-pranavpp@google.com>
In-Reply-To: <20240131191317.2191421-1-pranavpp@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 21:10:34 +0100
Message-ID: <CAJZ5v0gXsCuVvqynDeuf_NZtyAJ07umx1NUqfFZb25vjNABAfw@mail.gmail.com>
Subject: Re: [PATCH] alarmtimer, PM: suspend: Expose a function from
To: Pranav Prasad <pranavpp@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krossmo@google.com, jstultz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:13=E2=80=AFPM Pranav Prasad <pranavpp@google.com>=
 wrote:
>
> Hi!
>
> I am proposing a patch in which I want to return the errno code ETIME
> instead of EBUSY in enter_state() in the kernel suspend flow. Currently,
> EBUSY is returned  when an imminent alarm is pending which is checked in
> alarmtimer_suspend() in alarmtimer.c. The proposed patch series moves the
> check to enter_state() in suspend.c to catch a potential suspend failure
> early in the suspend flow. I want to replace EBUSY with ETIME to make it
> more diagnosable in userspace, and may be more appropriate considering a
> timer is about to expire.
>
> I am reaching out to get an opinion from the
> suspend maintainers if this would act as any potential risk in the suspen=
d
> flow which only has EBUSY, EAGAIN, and EINVAL as return error codes
> currently. This has been developed as part of a patch series, and only th=
e
> patch of interest is below this message. Any feedback or insights would b=
e
> greatly appreciated.
>
> Thank you,
> Pranav Prasad
>
> The alarmtimer driver currently fails suspend attempts when there is an
> alarm pending within the next suspend_check_duration_ns nanoseconds, sinc=
e
> the   system is expected to wake up soon anyway. The entire suspend proce=
ss
> is initiated even though the system will immediately awaken. This process
> includes substantial work before the suspend fails and additional work
> afterwards to undo the failed suspend that was attempted. Therefore on
> battery-powered devices that initiate suspend attempts from userspace, it
> may be advantageous to be able to fail the suspend earlier in the suspend
> flow to avoid power consumption instead of unnecessarily doing extra work=
.
> As one data point, an analysis of a subset of Android devices showed that
> imminent alarms account for roughly 40% of all suspend failures on averag=
e
> leading to unnecessary power wastage.
>
> To facilitate this, expose
> function time_check_suspend_fail() from alarmtimer to be used by the powe=
r
> subsystem to perform the check earlier in the suspend flow. Perform the
> check in enter_state() and return early if an alarm is to be fired in the
> next suspend_check_duration_ns nanoseconds, failing suspend.
>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
> ---
>  include/linux/time.h     |   1 +
>  kernel/power/suspend.c   |   3 ++
>  kernel/time/alarmtimer.c | 113 ++++++++++++++++++++++++++++-----------
>  3 files changed, 87 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/time.h b/include/linux/time.h
> index 16cf4522d6f3..aab7c4e51e11 100644
> --- a/include/linux/time.h
> +++ b/include/linux/time.h
> @@ -56,6 +56,7 @@ struct tm {
>  };
>
>  void time64_to_tm(time64_t totalsecs, int offset, struct tm *result);
> +int time_check_suspend_fail(void);
>
>  # include <linux/time32.h>
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index fa3bf161d13f..7a0175dae0d9 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -26,6 +26,7 @@
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/swait.h>
> +#include <linux/time.h>
>  #include <linux/ftrace.h>
>  #include <trace/events/power.h>
>  #include <linux/compiler.h>
> @@ -564,6 +565,8 @@ static int enter_state(suspend_state_t state)
>  #endif
>         } else if (!valid_state(state)) {
>                 return -EINVAL;
> +       } else if (time_check_suspend_fail()) {
> +               return -ETIME;

This causes a function defined in modular code to be called from
non-modular code which is an obvious mistake.

It also makes the generic suspend code call a function defined in a
random driver, which is a total no-go as far as I am concerned.

Why don't you instead define a PM notifier in the alarmtimer driver
and check if it is going to trigger shortly from there?  PM notifiers
run before the tasks freezer, so there would be a little difference
timing-wise and you can return whatever error code you like from
there.  As an additional benefit, you'd be able to handle hibernation
in the same way.

Thanks!

