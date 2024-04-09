Return-Path: <linux-kernel+bounces-137428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43D89E1E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692891C21C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257C156870;
	Tue,  9 Apr 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9+PZ5Wn"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8488156861
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685176; cv=none; b=JY/TgaJMIA5iVHz5nT4EsCnTw+/xk4wZCQ86yWKqZMUbfjH27ycjTBgaL3h5rOvj9jMPDjaidP41oEzmlFFEgk3xFffbsuH537UNn1Q+9wfMnlDnnak53TBtBlIIgqOrAyE6Z51RwcQW48nnqsmCfyn4TaT1Fgd981Uh/q/5SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685176; c=relaxed/simple;
	bh=ZsyYig0PaMc8HcrxjeZOEp/0JhWbVPIWnJIvpcmLMl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/t2rCIpx8+6VvRmhWaRhcvBcNQKbET72tz/NIaff+MEhHeqHDQuzSTOJ1jASheFSYYfH1n512EoD74JciA3ZugRhCu0lH5g2BTN+pOR9RVp4O7c7yuahgSK5h+5tvRE1IaIPZ9OGPVtSAfpXrGm1W+nfWccQ66urMczAdWoFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9+PZ5Wn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-696609f5cf2so35021756d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712685174; x=1713289974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0UtiPwH4SFRIAuAC2vMy9rB9n5VoLufAj1o9dzRWAs=;
        b=L9+PZ5WnwrxA2c36LeKU0S1YBYLo1Mc0qXulrFFFtd3jb0K2efaWa65ZmXSD+AGeoo
         uONpvB6KC121xKDO6VuaQKz052JI8DF6uym5+q73A7dcuYnut8HQkYx8pBuBjpJ8dJ3M
         SyBWkVlh2SwmQREJvwTgQj4V1sozf8+uveyVPaLKmc5Vx7+B3KxcFZdB8uyterYd3lFk
         2iwLi5kg9S1C+D9amTXaBHm7T+kuDn4/Z9GRyrcOFqpL9iLrhPZMQ8qFQibeA5Pxsc0H
         KjlZxEdZGSeWz355o2fclcT5kn6qvaDzLb9ncmv3GWH8XAxmPNIXOoLqZuK9l8rsLA6v
         fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712685174; x=1713289974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0UtiPwH4SFRIAuAC2vMy9rB9n5VoLufAj1o9dzRWAs=;
        b=rJRCnSsRBKOZLf6yFWmejcf57c5/Ab7ApEWIJ7H6hkkDELITB2p+Usx+t/2BZUdEac
         DEQtJJdTW5h6nkafwKelLblsPxaxzW+3YmYxm5ew2WEu6WzA2Zn0sqfm8g7Lm+fWj0p/
         SaIWljLsc96McB1lx8/VbRQv6RYD41GTbKngUY6bBLso1zQJeaX/q8cXW1oiI23/DX18
         3bJuoD3uNXa4D8M5GaMQw7qaq21nv2qjvLIZvPUlciCAWaZPARfY+AMT62oZ7uO7lpZj
         CKGVWI3BBMixwzy1ZzLwo1Z2lQiEeXTHY1Bi7VSZWAQ2sarNeFpK8M+/xxScbCdiIp9L
         0m2w==
X-Forwarded-Encrypted: i=1; AJvYcCUZOBx6sx3zZCdsI4zrNeovXdG9rXKdCZe7M+zz3YCbRYBqJV8UG584soEJKCE2HgRpU2wyYYLgdXObuCFJFm1GEhI7kZ2uAzLnRXfb
X-Gm-Message-State: AOJu0YyDngxiye8vsMLtiUOG39cR01wbaVHkG/by8jQIAREQEBJeRF4o
	Rxt6M65ePRdIozBaRrZ9EMSNJC0Lb0DwmYOZpc1/4II0rb5CvuB7eb6WB7PGZfeiFBJzAkINz3D
	K3g6iN+pKNGjiJIqjGphTHQw3ot4=
X-Google-Smtp-Source: AGHT+IGFs6yv191iHz8RHo2VsrFlPtqJhQu+dOoGF/nUI4+kzFnOm73MMsuoSQdS9Ksd4j2lP8tfif1Pf1RhzwxGTfU=
X-Received: by 2002:a05:6214:da1:b0:69b:2aa8:dc66 with SMTP id
 h1-20020a0562140da100b0069b2aa8dc66mr335535qvh.28.1712685173688; Tue, 09 Apr
 2024 10:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408121439.GA252652@bytedance> <20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
 <87edbf8hta.fsf@yhuang6-desk2.ccr.corp.intel.com> <20240409145740.GA543696@bytedance>
In-Reply-To: <20240409145740.GA543696@bytedance>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 9 Apr 2024 10:52:40 -0700
Message-ID: <CAKEwX=MBts2mGgTE__VP-ZVMrMFTzQnbTAkMPTJs3KNRQ2QDjg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page allocation
To: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, ryncsn@gmail.com, 
	songmuchun@bytedance.com, david@redhat.com, chrisl@kernel.org, 
	guo.ziliang@zte.com.cn, yosryahmed@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:57=E2=80=AFAM Zhaoyu Liu
<liuzhaoyu.zackary@bytedance.com> wrote:
>
> On Tue, Apr 09, 2024 at 09:07:29AM +0800, Huang, Ying wrote:
> > Andrew Morton <akpm@linux-foundation.org> writes:
> >
> > > On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@byted=
ance.com> wrote:
> > >
> > >> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
> > >> Create 1G anon mmap and set it to shared, and has two processes
> > >> randomly access the shared memory. When they are racing on swap cach=
e,
> > >> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
> > >> took about 1475 us.
> > >
> > > And what effect does this patch have upon the measured time?  ANd upo=
n
> > > overall runtime?
> >
> > And the patch will cause increased lock contention, please test with
> > more processes and perhaps HDD swap device too.
>
> Hi Ying,
>
> Thank you for your suggestion.
> It may indeed cause some lock contention, as mentioned by Kairui before.
>
> If so, is it recommended?
> ---
>   unsigned char swap_map, mapcount, hascache;
>   ...
>   /* Return raw data of the si->swap_map[offset] */
>   swap_map =3D __swap_map(si, entry);
>   mapcount =3D swap_map & ~SWAP_HAS_CACHE;
>   if (!mapcount && swap_slot_cache_enabled)
>   ...
>   hascache =3D swap_map & SWAP_HAS_CACHE;
>   /* Could judge that it's being added to swap cache with high probabilit=
y */
>   if (mapcount && hascache)
>     goto skip_alloc;
>   ...
> ---
> In doing so, there is no additional use of locks.
>

Hmm so is this a lockless check now? Ummmm... Could someone with more
expertise in the Linux kernel memory model double check that this is
even a valid state we're observing here? Looks like we're performing
an unguarded, unsynchronized, non-atomic read with the possibility of
concurrent write - is there a chance we might see partial/invalid
results?

Could you also test with zswap enabled (and perhaps with zswap
shrinker enabled)?

