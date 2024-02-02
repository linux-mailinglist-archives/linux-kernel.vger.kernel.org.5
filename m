Return-Path: <linux-kernel+bounces-50670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F61847C58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445261F247AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BBC126F04;
	Fri,  2 Feb 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAjvO5rv"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90983A14
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913104; cv=none; b=T5XJJ0235nDp2H5MjbPnc4Enh8eeFmQAd3Mho0CkJtyIlr0BC8QVR6NP1MwU6kAT49fUvwm//6zNviC2AuEoZ0MI80CiVP7+hSF5Oif3ZialGvVaiuD4GoEOFcBIVcAPW6xCfpOtK08AQVDl+oyuwt/leutC5hpwbS7Vlmb1M94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913104; c=relaxed/simple;
	bh=AuuhRZrQoUZEAGcO7niM2y/shUGQ3o6EvhrXWSsOm9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db5l2L0jQ5BK+6wYta8upCedlFpwA5vyPNt6p26cHQg2YdVGxYKNsve2FhCNq9wgW2ewmGvDOqnEHAcayxngqEjub2+WehqRwPQY5roqW51e09EOYatuNtjXlyNktX8Q+Hc0kMBC6nCZQhFKxeIpETWMdfbpJxGUXiCgEJhLlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAjvO5rv; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bffface817so111285539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706913102; x=1707517902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIG1a/joWmOzqMF2AOTCZUCUHJV5S4v0T7lXHSi+5hw=;
        b=YAjvO5rvaGeOX29qEUUx1R9I87s5YXdXXd1aNRRMvryPyRob8DW5V6t64khTlX3v8l
         cTa+/FxlCDhT8MfVgNcjtPdJKaajBr3Av4vN8rPNLfUX79QnlyXZD/XST5Fez7LzS2J3
         0S4TvQgt+xbQfzX161/02cLkOXBXRb4+25zX0S1RrIRVWFMyGTNv4CN8M429HA2rlAry
         r1zwJyH4scTs4xcEl311LLFvfRUtwmPG/R2MEtkcIQXid1pA8ipEVuX5TcloVodFessz
         YYrmk3aHno/K7+XVnn40hU/zpDN3XiXKXqEGb/F7wFK+4nQt0b4/b3T2ItwkoF0Vn0pb
         FbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913102; x=1707517902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIG1a/joWmOzqMF2AOTCZUCUHJV5S4v0T7lXHSi+5hw=;
        b=eoWs10uYaSIZW8zLfU4R3jIK+NpdlUpLxrFcIwZBkV8ELMsJyM6f210yXYcRS8/uVg
         JbvC1fkQf8/qT+Df8c/J3ng2WdFbVAbk4+o3JFGIDRe3Lm9BXx394UL76tmVeYt9nvj7
         0EsKAb5Tjc20uScZSZQV8iyv2pzKruK7fqBmcfVF0JRO9vUDecbOq4CP+rqVLZH8lQwR
         cSphOLWGdbme6t0bpebjD9YqdHtZcC1EvY6K3CtZGbP4UPYe4sqp/Sw/6UrObuLOIy7f
         aPJQ3TtBUYjywASkx+xe7S1ZDmFF99HAFNZ1dK1aKYUbtG6VaX4AkRp4WPkkH6COXfp8
         s3sQ==
X-Gm-Message-State: AOJu0YzqhUv/T39S1HOVjh8xF5amgCGBf/fX10Hj/4rhIvlP98/86gej
	4c0RlaBbVREbgFkf4c4mHWh4icilP3/2f086kyUu/fSB3oHzG4zcf3QxsdxRtDK5yyFYZYaPy0z
	m1a7Ja5PW5y9mdeFk5G6ShjyL1lg=
X-Google-Smtp-Source: AGHT+IHvT5NUDHpd8oCLZ/al8SEZ5XnhRxs3msvI799Rlu1Ndk2dQd2H1kH0r2JL/ZFf/WgVJt4nbg6f7xIzwvgaosY=
X-Received: by 2002:a5e:da0a:0:b0:7c0:a42:9ce2 with SMTP id
 x10-20020a5eda0a000000b007c00a429ce2mr4003612ioj.8.1706913102094; Fri, 02 Feb
 2024 14:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>
 <20240201181240.GE321148@cmpxchg.org> <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
In-Reply-To: <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Feb 2024 14:31:31 -0800
Message-ID: <CAKEwX=ODvtTq1gs3KFzinCfssGeD4f0qWdPC9Ci1LBGwW6hSag@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:57=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/2/2 02:12, Johannes Weiner wrote:
> > On Thu, Feb 01, 2024 at 03:49:05PM +0000, Chengming Zhou wrote:
> >> The !zswap_exclusive_loads_enabled mode will leave compressed copy in
> >> the zswap tree and lru list after the folio swapin.
> >>
> >> There are some disadvantages in this mode:
> >> 1. It's a waste of memory since there are two copies of data, one is
> >>    folio, the other one is compressed data in zswap. And it's unlikely
> >>    the compressed data is useful in the near future.
> >>
> >> 2. If that folio is dirtied, the compressed data must be not useful,
> >>    but we don't know and don't invalidate the trashy memory in zswap.
> >>
> >> 3. It's not reclaimable from zswap shrinker since zswap_writeback_entr=
y()
> >>    will always return -EEXIST and terminate the shrinking process.
> >>
> >> On the other hand, the only downside of zswap_exclusive_loads_enabled
> >> is a little more cpu usage/latency when compression, and the same if
> >> the folio is removed from swapcache or dirtied.
> >>
> >> Not sure if we should accept the above disadvantages in the case of
> >> !zswap_exclusive_loads_enabled, so send this out for disscusion.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >
> > This is interesting.
> >
> > First, I will say that I never liked this config option, because it's
> > nearly impossible for a user to answer this question. Much better to
> > just pick a reasonable default.
>
> Agree.
>
> >
> > What should the default be?
> >
> > Caching "swapout work" is helpful when the system is thrashing. Then
> > recently swapped in pages might get swapped out again very soon. It
> > certainly makes sense with conventional swap, because keeping a clean
> > copy on the disk saves IO work and doesn't cost any additional memory.
> >
> > But with zswap, it's different. It saves some compression work on a
> > thrashing page. But the act of keeping compressed memory contributes
> > to a higher rate of thrashing. And that can cause IO in other places
> > like zswap writeback and file memory.
> >
> > It would be useful to have an A/B test to confirm that not caching is
> > better. Can you run your test with and without keeping the cache, and
> > in addition to the timings also compare the deltas for pgscan_anon,
> > pgscan_file, workingset_refault_anon, workingset_refault_file?
>
> I just A/B test kernel building in tmpfs directory, memory.max=3D2GB.
> (zswap writeback enabled and shrinker_enabled, one 50GB swapfile)
>
> From the below results, exclusive mode has fewer scan and refault.
>
>                               zswap-invalidate-entry        zswap-invalid=
ate-entry-exclusive
> real                          63.80                         63.01
> user                          1063.83                       1061.32
> sys                           290.31                        266.15
>                               zswap-invalidate-entry        zswap-invalid=
ate-entry-exclusive

This is one of those cases where something might make sense
conceptually, but does not pan out in practice. Removing
non-invalidate seems to simplify the code a bit, and that's one less
thing to worry about for users, so I like this :)

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> workingset_refault_anon       2383084.40                    1976397.40
> workingset_refault_file       44134.00                      45689.40
> workingset_activate_anon      837878.00                     728441.20
> workingset_activate_file      4710.00                       4085.20
> workingset_restore_anon       732622.60                     639428.40
> workingset_restore_file       1007.00                       926.80
> workingset_nodereclaim        0.00                          0.00
> pgscan                        14343003.40                   12409570.20
> pgscan_kswapd                 0.00                          0.00
> pgscan_direct                 14343003.40                   12409570.20
> pgscan_khugepaged             0.00                          0.00

