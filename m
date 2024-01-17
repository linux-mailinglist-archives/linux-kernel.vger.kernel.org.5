Return-Path: <linux-kernel+bounces-29353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A8830D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30977289A97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5392421B;
	Wed, 17 Jan 2024 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly00sBkV"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3124204
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518850; cv=none; b=eTt6RUVa8loebWXviH0M4C8/0x75WuBRSVLwYs2AVOMVbDus6Nv8hwHPHS7sNdytD65LaAtRFcm8cPFrCfRopxPsA1DErll00zuC9w3noTRXMTKM/SjkNkF2DzVc3pEvsfq/UGoKGOSEPl+9pDNL+2PVrW7wQyXXPUYUwG1X57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518850; c=relaxed/simple;
	bh=y6Z6zk1OP3Ztsk3udH9WOkGkEr+SuisPK1CMmIxcg6U=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=k2FgAmYbKlIQIL5HV3LN3soj9wpbvfNCdsMg/4VctJm1n+sTHUaaWBOjvauMFeUdF/c8Q2S8nseT3rWEaGjtMabXaaiEg5LPPWzJvqimnMP8c/8Y1LQLkHm/3rhez2lkGNZyS8DK66aFwSylQkmvb31ZV6eGV8qUQHTY9vavzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly00sBkV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bc3e297bc9so519006039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705518848; x=1706123648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N7+b+9eTmlV+1hqRRxK5amXtgZFPEj9WEU/LCvJugc=;
        b=ly00sBkVIEeq0uj2mCmiAq81dV07z8Gsw/vBnuqBrJ6o9iZt1nEUpdh2SRhFJQe7RA
         +lJLv0gDjX4bMZSFyN96idhf2jhmwXzqvLeUHkBqulTpbMZWaFnho0LyT+mTj27Ei9WQ
         F2mx1Ztx1xhQpNt3RlvNcnQRq/+yOZquJI8mVTxY4g1Fi6+3oiXo6bFTH4uSnGocyxCp
         3I6QB7ATvhCjIhPINJftInCHjSiUsqYbyv/kmImXVn5nXd7fF3Ms3N4eT5brHMPIZVXC
         uRCKLh4ZOx/9AvLIITZ05xh3xYQI8hoYy8CC6h1JrmVwUDI8VKeEjHe+fGhStgUIo60d
         rTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705518848; x=1706123648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N7+b+9eTmlV+1hqRRxK5amXtgZFPEj9WEU/LCvJugc=;
        b=Rn0S+Dsy+/f3WOqRt9V3a7PPGcRPwqnIZTJGtSZXoZ9DK8xhYizwGavBeGuByVAvR8
         ozuPpv1WmNB4GXpwnXslWOxL6OwFOdd5KZcwgMUGIZ7oa+CIWkNz8UgV2w7fcjWlUftT
         uiNW4qAErH295wgMB+GSNR8SRHbiwzTHuCJDFWqlpq1EHks3Wi/vg/y6/Dn6zua2qdwq
         IYycd1aZQX+eIox2dzpRPMOi8f4vg4NpiepOnkP7uyF1XjT69YbaKsQrfK7Zoow6eszX
         D3H69RKBX4qidkVKARsajO/Q2F3rfZsAOyEVZMrwvdolp48xyBefzBPfaXjCsXH4T2hq
         +QFQ==
X-Gm-Message-State: AOJu0YwFQTP1mz56GbUQqUjVb7tnRj9tX68kbv0iPUXFrc32ZcXQkXBd
	ryAZICExcO5GVsgh9sE1W7YJdRpYlJlw1VGgrr8=
X-Google-Smtp-Source: AGHT+IH42lhRoe3RkRSLTvfsn0KxrW3p2bPJECxj5UwhVBlSqrKgaSGyCgEg9EaiGlcaWxr1jc5H8HAdoa/R/FK/kqU=
X-Received: by 2002:a5e:db03:0:b0:7bf:4f07:716b with SMTP id
 q3-20020a5edb03000000b007bf4f07716bmr4908995iop.22.1705518848512; Wed, 17 Jan
 2024 11:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com>
In-Reply-To: <20240116133145.12454-1-debug.penguin32@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jan 2024 11:13:57 -0800
Message-ID: <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:32=E2=80=AFAM Ronald Monthero
<debug.penguin32@gmail.com> wrote:

+ Johannes and Yosry

>
> The core-api create_workqueue is deprecated, this patch replaces
> the create_workqueue with alloc_workqueue. The previous
> implementation workqueue of zswap was a bounded workqueue, this
> patch uses alloc_workqueue() to create an unbounded workqueue.
> The WQ_UNBOUND attribute is desirable making the workqueue
> not localized to a specific cpu so that the scheduler is free
> to exercise improvisations in any demanding scenarios for
> offloading cpu time slices for workqueues.

nit: extra space between paragraph would be nice.

> For example if any other workqueues of the same primary cpu
> had to be served which are WQ_HIGHPRI and WQ_CPU_INTENSIVE.
> Also Unbound workqueue happens to be more efficient
> in a system during memory pressure scenarios in comparison
>  to a bounded workqueue.
>
> shrink_wq =3D alloc_workqueue("zswap-shrink",
>                      WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
>
> Overall the change suggested in this patch should be
> seamless and does not alter the existing behavior,
> other than the improvisation to be an unbounded workqueue.
>
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  mm/zswap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 74411dfdad92..64dbe3e944a2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
>                 zswap_enabled =3D false;
>         }
>
> -       shrink_wq =3D create_workqueue("zswap-shrink");
> +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);

Have you benchmarked this to check if there is any regression, just to
be safe? With an unbounded workqueue, you're gaining scheduling
flexibility at the cost of cache locality. My intuition is that it
doesn't matter too much here, but you should probably double check by
stress testing - run some workload with a relatively small zswap pool
limit (i.e heavy global writeback), and see if there is any difference
in performance.

>         if (!shrink_wq)
>                 goto fallback_fail;
>
> --
> 2.34.1
>

On a different note, I wonder if it would help to perform synchronous
reclaim here instead. With our current design, the zswap store failure
(due to global limit hit) would leave the incoming page going to swap
instead, creating an LRU inversion. Not sure if that's ideal.

