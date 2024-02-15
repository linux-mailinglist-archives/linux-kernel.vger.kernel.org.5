Return-Path: <linux-kernel+bounces-67839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F048571AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9763B1C211B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57F145B07;
	Thu, 15 Feb 2024 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMoXUmQj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F38833
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040308; cv=none; b=d6w1wgwtFRB1nSYNvR7kn5skomBKQp9044L4u2LXKpPXfTi+vaMNSNe6k+NVp3WrSGEkREgdSouRcx3lC+6nf/XQV6ocpXTr88waezJDIrSE97+DVdhJyz2AdJJ0d9ktmSgMVjc0rV11EpNsmw4i80CMOmhihxh3bmysU0ruukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040308; c=relaxed/simple;
	bh=qJ9nNgDvIKpntaNeODaWrVsz5G8be1mc0vKMlvPIWbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muI6qzPu7S3lB/m6r33lL3QlMw/LiD1qkWyLol+vgmKSufixLCzFPxqY+1wpbXisy/ccfB7mPRF2mGM7nv7JEe5oi8qYj3f3wI/1bX36ft1/B/Tvhe7EFkVPufGM943QVLoPHsrtigvsY++n3E4ZFVSZZ4JIQ+5g496+y+JT7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMoXUmQj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d00a999b4so606699f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040305; x=1708645105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn0sQTAwhEvIBiXDzaG6iULDQCmeFqcNJO1N7EmRs4g=;
        b=PMoXUmQjisRH5lvkm+LhKYIapXkxIRAtvBaPvOBWYUoeJXa8Vs5e8dvbpP0DkV3owp
         4YB1yM8oRGGcE0FZCYz0NTGuzoW7aZmkupIUIGac4M8bREa1XsMpeKt10Ak7u414smYI
         NCcLT07S3mIYtgH1TBVfiVgGsuqwa2xYiVdVy5aZtVwLaMJ1RSRfVCy7/dstqDxKJBkj
         b5BvjzZm99tgqhiPFWwH/oeARBgX0CgTtBEHd2L9vUDtHhYdoSfwu/4uGFkNcmaMI7y1
         Xl3rF4SX8c2OsOqdWX5wByipXlweEVDUsPNxYzsWx27lglCYDAIuvMT9/avZtm1Il+Ca
         KJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040305; x=1708645105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn0sQTAwhEvIBiXDzaG6iULDQCmeFqcNJO1N7EmRs4g=;
        b=D04a91ISDcfRnsP8XsJ5CmGQ7RG2+NbnN/vlrKv6WJXHSGEBRc78MHYBk2ec5kvjuN
         y7mOLO9kn6yjy+1p/qR6Z/ueLXx6ME1cS0ytKVkym61yunT3wqYLwPo2wiZEIbHcz+uj
         i6OO7CBZLjSZBepHHw7Ld0X+pICGWl0Vff4YtBTTCqZBQJ+tyyTj0SewF2cwWLA9hG63
         sZwWYePdv9ImrdQ6xeejdX2IxUGQPI3IP47I4lpA6YOYwGgW72Ntyr1B8J9feHIHl1su
         XjU2P0k2c7rB16DleX4Ey1eI8+4qdUCFT+bxke3ZmIpyDkh2thRjXYIEAq7WIV53skK5
         fGdA==
X-Forwarded-Encrypted: i=1; AJvYcCUBhNhh6AcXxy6ht9p6OpyhBNG+dr/5iQzrMBpx/VxK/OYLyYloWJ93SjfBY/TvRgL6OE/2nhl1whYuBs3AW8OfdZHE421KFogJ6+6E
X-Gm-Message-State: AOJu0Ywzexmwl61iRE7lNpijc91OlFwmi6TgwqpQCotu2PWR911qgCSr
	Hi4QWbSpZmD6ENxizGwRzEznKwxv0nI/As5R3piGNL6UucnDe0AvoKkmO2K6yeCoJi1GU3i8Auc
	3pVTOb0X1Uy8Ks/pHegt//3orxBc=
X-Google-Smtp-Source: AGHT+IGIiVNXedOguEZBF0GODW3XI1skmz6d9iA0LyDWVH2pPb1XYu7+9mg/uy3R1yv6L6XiAK2M+wxThACPvSx96Ps=
X-Received: by 2002:adf:f0d0:0:b0:33d:174e:4813 with SMTP id
 x16-20020adff0d0000000b0033d174e4813mr453648wro.23.1708040305196; Thu, 15 Feb
 2024 15:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58481629F2F28CE007412139994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58481629F2F28CE007412139994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 16 Feb 2024 00:38:14 +0100
Message-ID: <CA+fCnZc4huzB4e1vdmxYa-3fFQadO6j7ZTCAvcRV52LPNWbYow@mail.gmail.com>
Subject: Re: [PATCH] kasan: Increase the number of bits to shift when
 recording extra timestamps
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:41=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Fix the mistake before, I thought printk only display 99999 seconds
> at max, but actually printk can display larger number of seconds.
>
> So increase the number of bits to shift when recording the extra
> timestamp (44 bits), without affecting the precision, shift it right by
> 9 bits, discarding all bits that do not affect the microsecond part
> (nanoseconds will not be shown).
>
> Currently the maximum time that can be displayed is 9007199.254740s,
> because
>
> 11111111111111111111111111111111111111111111 (44 bits) << 9
> =3D 11111111111111111111111111111111111111111111000000000
> =3D 9007199.254740
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  mm/kasan/common.c | 2 +-
>  mm/kasan/report.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6ca63e8dda74..e7c9a4dc89f8 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -55,7 +55,7 @@ void kasan_set_track(struct kasan_track *track, depot_s=
tack_handle_t stack)
>         u64 ts_nsec =3D local_clock();
>
>         track->cpu =3D cpu;
> -       track->timestamp =3D ts_nsec >> 3;
> +       track->timestamp =3D ts_nsec >> 9;
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
>         track->pid =3D current->pid;
>         track->stack =3D stack;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 7afa4feb03e1..b48c768acc84 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -267,7 +267,7 @@ static void print_track(struct kasan_track *track, co=
nst char *prefix)
>         u64 ts_nsec =3D track->timestamp;
>         unsigned long rem_usec;
>
> -       ts_nsec <<=3D 3;
> +       ts_nsec <<=3D 9;
>         rem_usec =3D do_div(ts_nsec, NSEC_PER_SEC) / 1000;
>
>         pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
> --
> 2.39.2
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

