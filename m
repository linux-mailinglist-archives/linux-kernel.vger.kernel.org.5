Return-Path: <linux-kernel+bounces-45497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91584318D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAADB21A82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6C7995C;
	Tue, 30 Jan 2024 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAVaID/O"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E97EEFD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658458; cv=none; b=uypekYPh+ZiVjgWHoC/B9aQWN9cN+Vm+OY4SGo+sVqyHregqDuCrrQkwSpYDmpoPI3xMa7YUCd7aaUosu5YiY4VTzQUguN3Wf9mHHheRQ4l3snkk5RreX2Nwk1lBcYhMC1p5/kGJLwW4qkyiK+jbGtXdBmm4MOOa8299yk1fJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658458; c=relaxed/simple;
	bh=36F5OSWGdGpcbeWMrVpgMFIMpDrjq93r6a5tnWunntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNwdoqPVs/s/mJGVmuZVKHq8JPgesjiikPrPskURVGc680VybhQC/ZAMH1LBMwKIo7C7ejba9fceMUPXjIdl+ZpzkF8eSRP51NMK7GdxJlhcxq+6LPYtQk92xJJ/jyIBkN+AoAP5saJIe/erX8iHfoXU9Tah+Bejujqm/6N3xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAVaID/O; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso183586639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706658456; x=1707263256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P926dzBusyOMI+nwQKA18OR1CDveRDAGUvH0omnrkLM=;
        b=PAVaID/OJnWIJx5QALwznyg26oHJftCnx2ypIv6n0PDfX1pmRaRvVzzlmtf+VVJVWM
         jDU4s04trqVaF1sQQlW22d2cuILsAs8fjnbG/F+Aw5wx1TT3hhpzIehVE0kAHvyCCvGf
         nOKOi6tuGTrv7hEmuLnC4KS4Mlpoqds+D+Ryct23ttznnqCscPf0mn5hvpzXCj9llC4j
         +X9lZCAjFkUvktd7LRWHSp7v3r9Whml0AqC0eLoogV9hWVPaNvnS98aP9JtHl9gHXnz7
         oXkC1o8Ss93x+4gz6Wck8fQuVzQBOCXMJGCPOsJBzjcvztLAlK/j6H8RbOs2cunS+/78
         kGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706658456; x=1707263256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P926dzBusyOMI+nwQKA18OR1CDveRDAGUvH0omnrkLM=;
        b=TnDnZ+DpdZWzec9/0Vu2V7Rj0mRHYwDeAxUuN6GtiXGPk5pc5+0ErNodj1A/2uiZ2M
         I6Lot5M+ZOY31Pj1qm9pBF713bYwvPc6Lh7X+OzrSGm5gZ68XchEWev9SjWD6WDbeeYM
         yEpf93u0Khr99uEwQKpeWMcxulGercb6HNv80eGCNk9d3KI9u0yvfLQMCQ5798MCAMTM
         TpvSSX0eHAxxlSOYyKWI70/J+iEWfnrNdONgAf5oDWsLK1aQy428a4ElUEgW8mG+mgOU
         +yazD8/mru212u4mGGENUsdySp68wtBI8DfWhjaaqj/zRJJW1nSdandW04k9pbjpVd2b
         x6ZQ==
X-Gm-Message-State: AOJu0YxcUieTBobYLeXdRyZEjq1CayZaRN6h1piuMXHycaxV8Qntw46z
	g8ddoPfBGRLss/0D1S+GOtrtG9ZPrf3QdzaVfeFCq1Nm3svQW1kdwcguHDIsAqQhKQQ2+1PphgK
	zNiMKlLMnfU23bed6TJ7csMFOI/w=
X-Google-Smtp-Source: AGHT+IE6hhL0p8l721bL0HMuyYbB4TNqYvZn9RxTxhaspcjukhJECaYqtic9Xj2gjVCyuLyrZLK5kAvKlUdiEl8bOEU=
X-Received: by 2002:a6b:5f01:0:b0:7be:e863:483f with SMTP id
 t1-20020a6b5f01000000b007bee863483fmr132859iob.11.1706658456452; Tue, 30 Jan
 2024 15:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-15-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-15-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 15:47:25 -0800
Message-ID: <CAKEwX=NMbVcGO4WPi7hyFPQFFec1OveGzS0AJDN+SctNNvOxAw@mail.gmail.com>
Subject: Re: [PATCH 14/20] mm: zswap: function ordering: public lru api
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The zswap entry section sits awkwardly in the middle of LRU-related
> functions. Group the external LRU API functions first.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index e650fc587116..511bfafc1456 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -746,6 +746,10 @@ static int zswap_enabled_param_set(const char *val,
>         return ret;
>  }
>
> +/*********************************
> +* lru functions
> +**********************************/
> +

nit: looks like there are 2 "lru functions" headers after this patch?
You remove the "lruvec functions" header, then add another "lru
functions" header it seems. The next patch removes one of them, so end
result is fine I guess - just seems a bit odd.

That asides:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


>  /* should be called under RCU */
>  #ifdef CONFIG_MEMCG
>  static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entr=
y *entry)
> @@ -764,6 +768,21 @@ static inline int entry_to_nid(struct zswap_entry *e=
ntry)
>         return page_to_nid(virt_to_page(entry));
>  }
>
> +void zswap_lruvec_state_init(struct lruvec *lruvec)
> +{
> +       atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0=
);
> +}
> +
> +void zswap_folio_swapin(struct folio *folio)
> +{
> +       struct lruvec *lruvec;
> +
> +       if (folio) {
> +               lruvec =3D folio_lruvec(folio);
> +               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> +       }
> +}
> +
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  {
>         struct zswap_pool *pool;
> @@ -798,24 +817,6 @@ static void zswap_entry_cache_free(struct zswap_entr=
y *entry)
>         kmem_cache_free(zswap_entry_cache, entry);
>  }
>
> -/*********************************
> -* zswap lruvec functions
> -**********************************/

Here's the removed zswap lruvec functions header.

> -void zswap_lruvec_state_init(struct lruvec *lruvec)
> -{
> -       atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0=
);
> -}
> -
> -void zswap_folio_swapin(struct folio *folio)
> -{
> -       struct lruvec *lruvec;
> -
> -       if (folio) {
> -               lruvec =3D folio_lruvec(folio);
> -               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> -       }
> -}
> -
>  /*********************************
>  * lru functions
>  **********************************/
> --

Here's the second (original) lru functions header.

> 2.43.0
>

