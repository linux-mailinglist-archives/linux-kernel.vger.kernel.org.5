Return-Path: <linux-kernel+bounces-72182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E417B85B08D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C2CB227C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350A224CB;
	Tue, 20 Feb 2024 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPQwd81Z"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C94224E3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392498; cv=none; b=BlqGZjp4xemOutMDxFBc4gYQKVe2BCH9SZPJiBMft9ansaFEDXt/WgdPEOkQtzsHvAS5H/jAR5bzGVUGgHKUDI9HZ1RiQ7flj7TLdAfZHHuEjxhxDgSy5woaVYmXvhOCslsQv+iYOAT7/otLEaHpBb2Y1DwqVvfzOQDbhWERazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392498; c=relaxed/simple;
	bh=osHX4x61ZN7VgpHKzXYPBh6RSLEqmlpGN9LLP9KCFDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipzz2LATxU3AZey/XnIvDPa/QJvrgnBX7CQe/uUworWzoqV3D+QIQN+PS1BhSQIrNq9kyXKyN4UlqaPBnNz8Rxof/5MDTOSMGA7xpSdYdJ9n4r+DwqgkvR/zpkwuunzc01fOpli7hx4RCeg75IEvXPCMwtW2GUYFzUo+McKCSKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPQwd81Z; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so290127139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708392496; x=1708997296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK31cEr9hehp80gGWlXDH0T921MmH50qjE0kSGVtUsY=;
        b=EPQwd81Z6IGb1M/gWh3k347Jq0ZNQ4DPdTZ9sFJyGr5AEXqGvJqHkzm8Q7zLzDoPy4
         R1zAeESHq8xe1ZZICtBP/pkkXHObeIWunQEsba0ETPs1uvBTqcv4Xb+CyJXbuARvxpiM
         jW4AIl+2hO2HIzKZhkjnzsdxFvV3VZt3/1nXGPGt6QypsI8XkphnPcWUo1laPMG3Crww
         wszeyMNekZAki5OfikD+dbV8BpPrwf7obMlz/rLKcUC442v2yjC1BHiIHrH8zgUuOB0a
         Btl1o06QWvKkvIaFlTW1fN3Iv6ln+f5jTfKO47EtGD7unI9ZrSMKra714g5YOj1Jzywu
         kqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708392496; x=1708997296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK31cEr9hehp80gGWlXDH0T921MmH50qjE0kSGVtUsY=;
        b=LstQdFqfS+OARC8k6c0aqs97b8Nx1vAtPuVgtU8wr4YtF4efNFHoHkd4PYRWICzAWK
         0efUWKZIwR0oVhSuxmnEwvg2jGDzqVRrBOj/9zi59Jp2KLTOQNrJ4v6FR8XWNX9AefWb
         wEv/yYQ+5EhVuGKHamcGgt9KZIWcphd9mr1isRQSREWzWpCM3iS0cB3TbA9FmisD2APq
         7tLuTHu538EAqSCMPg08+0p2GmYuSvmLGf0FXvx4WP8vdf6HZkrG0Twgzj8Wm0ehwpO8
         y8S6Dz3OTs2AyIKcNq6ITrM3YQu9SiLqJRKNOejgxZbcufSD3ZUe/iShrYgJZDJS5gB6
         QG0w==
X-Forwarded-Encrypted: i=1; AJvYcCWNyaphDVC3gIdBiKPA7s/L7+fjCs0V2tjKBTNVttbdkhH3RXJ7F++XmBa5OAaIRkeHgcndOvu0t0KTkc0FaHgIObLFU7CjqwRDMNMx
X-Gm-Message-State: AOJu0Yw8ubCTtLpfAuhEGTracqzV9IZWNSj2pVQ5RKTfgZL70JRdxT2L
	Ku0DNQy/uztBlDy+APu2eBHqr8jkfgwe83wJz86pvw+UTthczr3+NDd17bMQMuswMoVxRBLDoBV
	c7u+ET1n8SZ0VNfCfZQKoXtm0Pak=
X-Google-Smtp-Source: AGHT+IHyD8b3HQhCtghTRL8o4uFCt8wqF/sqZERoOEKliE9fJxFdcS81kappcd+XgV+AA1xEe6/AhLaG/z4/TRq8MTA=
X-Received: by 2002:a6b:c8c4:0:b0:7c3:f3e4:8ed9 with SMTP id
 y187-20020a6bc8c4000000b007c3f3e48ed9mr16741687iof.6.1708392496280; Mon, 19
 Feb 2024 17:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com> <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 19 Feb 2024 17:28:04 -0800
Message-ID: <CAKEwX=Mc3TTL3aW-69SV_G8UhWBhgfNpEQvuz93P+pmpVyAzmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:55=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Dynamic zswap_pool creation may create/reuse to have multiple
> zswap_pools in a list, only the first will be current used.
>
> Each zswap_pool has its own lru and shrinker, which is not
> necessary and has its problem:
>
> 1. When memory has pressure, all shrinker of zswap_pools will
>    try to shrink its own lru, there is no order between them.
>
> 2. When zswap limit hit, only the last zswap_pool's shrink_work
>    will try to shrink its lru list. The rationale here was to
>    try and empty the old pool first so that we can completely
>    drop it. However, since we only support exclusive loads now,
>    the LRU ordering should be entirely decided by the order of
>    stores, so the oldest entries on the LRU will naturally be
>    from the oldest pool.
>
> Anyway, having a global lru and shrinker shared by all zswap_pools
> is better and efficient.
>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 171 ++++++++++++++++++++++++-------------------------------=
------
>  1 file changed, 66 insertions(+), 105 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62fe307521c9..d275eb523fc4 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -176,14 +176,19 @@ struct zswap_pool {
>         struct kref kref;
>         struct list_head list;
>         struct work_struct release_work;
> -       struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> +};
> +
> +static struct {
>         struct list_lru list_lru;
> -       struct mem_cgroup *next_shrink;
> -       struct shrinker *shrinker;
>         atomic_t nr_stored;
> -};
> +       struct shrinker *shrinker;
> +       struct work_struct shrink_work;
> +       struct mem_cgroup *next_shrink;
> +       /* The lock protects next_shrink. */
> +       spinlock_t shrink_lock;
> +} zswap;

nit: Is there a reason why we're putting these in a struct instead of
just a bunch of static variables (perhaps prefixed with zswap?)

