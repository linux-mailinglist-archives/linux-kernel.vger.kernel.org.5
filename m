Return-Path: <linux-kernel+bounces-82262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95989868155
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3610E1F231BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271512FF86;
	Mon, 26 Feb 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/HAaQFT"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1012FB28
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976697; cv=none; b=S52JXVSZzbQ9hw9qXADeVCW3d9QYw39B9/inhVY8Wo8feg4MHblLZLNohf6KjNbHAd9i99BLFH0xAXmbnPbBkiicuZT/Pu9X8TXfge0SkZgKqd8M59d0LGoamnrD8HxbwWyB7xHDYuCu5JkqGdPUHNRNn94eZQ0rteiIQLIj0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976697; c=relaxed/simple;
	bh=AhxNsCkvwQA9C2X5NTXurrVFywjUJYKpwHGGL9G+E/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bhbfp0kzMUzBU3wPjCYwv3krW5PTUk747pxry+GASLwCSAySf3g+UCSCRlF7KpgiH1BzHPMEgp1plKPRnRID1SQwq+C7kNdkGPOQa0ZGtvnn8cx8883m4y61uuTLX+/zlReazt8uWuirNK2ILR2KglPx3z0pmjgX+H1vpzrijps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/HAaQFT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608d490a64aso23470387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976695; x=1709581495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IjMAUifD0K8aIclGse5kDD6h96+1W53kM3fR1+WoI4=;
        b=P/HAaQFT80btW6J094/b4KuVrFzjuvDFvsUtltGoHdeHUnCs2zTS3HwltPknHCoQJI
         kZiKHYwfpLkVUu9D92LMB2OlxC2BDrvlC95JiVUZRjWI5owfwg591M4xHCzDZxpvNWK8
         G0sGZsw88scKH0fss9tAbiANd6RnGhM0rrzWpl5bNauuOoM4lv+p3Om5DRot1dm4eIqo
         tfSfzMOkxf08hIx00mOjx3GE0n2eKJmD5+z87vCFwX7gQjsPqvrhyVRJVpBXGXHaxjHm
         A0xbZGCB4jYtVPk4FlYe69J1KQl4LuEcAFOm6+xPXjp6C48OQDSKojWAyapmWSZyAj/C
         SyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976695; x=1709581495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IjMAUifD0K8aIclGse5kDD6h96+1W53kM3fR1+WoI4=;
        b=ucOPIjKIJsEP1CEwKLNYBDSHjdMtIG1+Zf+0xuvp4t4cs3iaCmQWzrz00Bh3iADag2
         ssQoMtGgxw15ARCPDkdxAQDW0KTV3Y6Gao/AezhMxalpbzjW6fkIup6DmrlyrZgupQ6M
         T53wF9gAkEQ+Wlv2Nr9mBNb4q9P87E4E7V7aghuUepBwM38Eg7Wu7Iz2C1rLp3XVLHBU
         Jmqw0Uo06clfu7AhyDsvGrBY4ORBFYkWWAPJxTpaBl1+I8TYJyF6TSMig3GtJoQiiCdu
         9eofPd6BX0foa6S7kQ9Qlc2tigsdigOXDZGqc03nGEqYmbfHAC1EXhfImEa/qlzOYxZi
         3VPA==
X-Forwarded-Encrypted: i=1; AJvYcCXbaSHgAYJNR9AYrRQYn61Cu02FnsVmEURgJb1aYEmRs2kb3Z+/nI8QC+B6xQTo627owa6NQSgRBPtMyDg8yWjfal0nA1eC9F7Pg+21
X-Gm-Message-State: AOJu0YxoRIV4SY3HnCd7LmiN+bcbeSZ/pPZLBJII4hT2fQeXQRc4J6Wk
	YL7Pt0DmHXCqxwxF2ULVt7AQ4sVql/ckwV964FZfd0+BxIAMThU1mtfc9J3Hw95M42fZmtBa+Q4
	vvA7opIdXKJOSQW7VWlMMolxzBFjBA8c5vL8=
X-Google-Smtp-Source: AGHT+IHylF+ijSiigZhn1xaCZmadJQwYIVFkZaPIc42DFOKEpXgNS2JWVjqE4kipuCfMcPHpGREAv7pI++pZxQF/Yns=
X-Received: by 2002:a25:6b0d:0:b0:dc6:bbbd:d4f4 with SMTP id
 g13-20020a256b0d000000b00dc6bbbdd4f4mr174043ybc.33.1708976695465; Mon, 26 Feb
 2024 11:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126152556.58791-1-ppbuk5246@gmail.com>
In-Reply-To: <20240126152556.58791-1-ppbuk5246@gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Mon, 26 Feb 2024 19:44:44 +0000
Message-ID: <CAM7-yPS-=NCceH6O7C0b_NvE69Aq9zpMruy+0jnB34HsNo8ZFg@mail.gmail.com>
Subject: Re: [PATCH] kswapd: Replace try_to_freeze to kthread_freezable_should_stop.
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

On Fri, Jan 26, 2024 at 3:26=E2=80=AFPM Levi Yun <ppbuk5246@gmail.com> wrot=
e:
>
> Instead of using try_to_freeze, use kthread_freezable_should_stop in
> kswapd.
> By this, we can avoid unnecessary freezing when kswapd should stop.
>
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  mm/vmscan.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..1f139830b26f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6796,6 +6796,7 @@ static int balance_pgdat(pg_data_t *pgdat, int orde=
r, int highest_zoneidx)
>                 bool raise_priority =3D true;
>                 bool balanced;
>                 bool ret;
> +               bool was_frozen;
>
>                 sc.reclaim_idx =3D highest_zoneidx;
>
> @@ -6894,9 +6895,9 @@ static int balance_pgdat(pg_data_t *pgdat, int orde=
r, int highest_zoneidx)
>
>                 /* Check if kswapd should be suspending */
>                 __fs_reclaim_release(_THIS_IP_);
> -               ret =3D try_to_freeze();
> +               ret =3D kthread_freezable_should_stop(&was_frozen);
>                 __fs_reclaim_acquire(_THIS_IP_);
> -               if (ret || kthread_should_stop())
> +               if (was_frozen || ret)
>                         break;
>
>                 /*
> @@ -7102,7 +7103,7 @@ static int kswapd(void *p)
>         WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
>         atomic_set(&pgdat->nr_writeback_throttled, 0);
>         for ( ; ; ) {
> -               bool ret;
> +               bool was_frozen;
>
>                 alloc_order =3D reclaim_order =3D READ_ONCE(pgdat->kswapd=
_order);
>                 highest_zoneidx =3D kswapd_highest_zoneidx(pgdat,
> @@ -7119,15 +7120,14 @@ static int kswapd(void *p)
>                 WRITE_ONCE(pgdat->kswapd_order, 0);
>                 WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
>
> -               ret =3D try_to_freeze();
> -               if (kthread_should_stop())
> +               if (kthread_freezable_should_stop(&was_frozen))
>                         break;
>
>                 /*
>                  * We can speed up thawing tasks if we don't call balance=
_pgdat
>                  * after returning from the refrigerator
>                  */
> -               if (ret)
> +               if (was_frozen)
>                         continue;
>
>                 /*
> --
> 2.39.2

