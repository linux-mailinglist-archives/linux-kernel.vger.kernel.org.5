Return-Path: <linux-kernel+bounces-100790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92727879D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9164B21652
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715014372A;
	Tue, 12 Mar 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="N/Ep99ud"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F31428FC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277713; cv=none; b=iymZnIRQhY7CnZBG8Tbk26Pn1YdYx5AyBWYnZJ5A/rfAsjEb3ELrARutw8n1f3Y+woB0P5FYr99Lu/f35PZ368VfnlSKnBhUhuy926Y03Frc/fLSV1UKnZ+avUC+j0R5o46o5QcjvVZTG0IZlIOUA24+eI3yRkGEb4kdhYHZn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277713; c=relaxed/simple;
	bh=00zcQt/80TpZGM72etAGD7MpUJQOLqnFU5tVCMryFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dokZm2zbyXGuEHWbWyPnMllft8eAqAsb9rMQXZ3Gt9PFtYLvGYY3MRn6ke92dKe2gDOmVK2LTNFgdS3AxUL0guv0HTcIW5XKO0aznHWkhnVQCTneYvVKEF24EVVcpFW3jj2+hHQIw8M/0g7Zd1LfNhj3TznD/LCHc/WmPZ6nlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=N/Ep99ud; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690d75c73f4so2182696d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710277708; x=1710882508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gjV4+2wG3wAnoAJEZQQ2UXF6TkgGhJejwn/Dp1Cwfk=;
        b=N/Ep99udCymB8jNSlV5aJFE4zLUw8vexd3TuI94QOMzX6cWsch9lX2/ez7YM5+Sz8n
         Qb+JLzVbknlfIpLBkcytkhJ0RXv13a89WhmPaCK2Y1DsUQuObf8M8AyX34BXg0ka98zX
         dQ1y6lZfBZOSUg/GyeozdvTY13avv9GfjFOLiiiYNolPyN8ZgPDVBlQUSe1z3dZ1rV5Y
         Z3W4sbF4yBH8fxXwRp2TKr4orfqgwzCovxTJ/F7iveMQ1ooMHdEmOYmtyWQhsTfU33bU
         tbEJDAwRNlhU2aBnvGGqojIfsT27hAjrCmnaGz/h+BgseSbOAV5QehAHTIEeB/u0wH7R
         HElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710277708; x=1710882508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gjV4+2wG3wAnoAJEZQQ2UXF6TkgGhJejwn/Dp1Cwfk=;
        b=MMjDrYxjwqby/iWWcdD4SPXY0Ij7sGsTAP6qxwer1ybeYT/hGqZ88f0tVlN+7xgX3S
         ZyebyySu5F3x8zhD0ebcrPSb0rUJxYs7gpUqqK+GJtCB2CUTs41A1FJkFM3EschY/2OT
         JUj2BXT5AlMOq38uGwXxi3xfbOq4pPPamv4B/BFtgOoACiSq5oyENOBv71AttxQ0fKDi
         wr7+1RkftU3BfJ2946tZ2etXY3q1YnYDk+LXL+41bhTDRqr2v+Pdd0ag9DLI3zWRkGwm
         y5yqHKKjwj+1zbF5KEjPZSk7qepcfArftmMDeuCKTRrFrGi/XYhnJEaym01k64Manuph
         d46Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsFvvkvrWcunlRtcJsNKbNvlyVaW/HiLw5KezLutqk4oHuTyW+DDwwEK1UK1pFv5BQSuBJHqZXe7ty0p4DcbbjnaRf1/nvmg6GJhDW
X-Gm-Message-State: AOJu0YyZxnciI+f8UnNzSumtbG7dm0MnPrM2scc/3t8zMzKAFRTh6F1Q
	UPkCJ/i36DZmQVfcjQ8+frPUcLfi/35cIl8rTBehaMKQ2JX7Wy7XK9B/gzVi94I=
X-Google-Smtp-Source: AGHT+IEvoRw+r80Y+4FWVqE81roYQNmgylheTVRxWmPyfauWNZmcjfSSFgQehFXxBosTdWYf8WPH8g==
X-Received: by 2002:a05:6214:2aa2:b0:691:a8a:d35f with SMTP id js2-20020a0562142aa200b006910a8ad35fmr1089671qvb.51.1710277708040;
        Tue, 12 Mar 2024 14:08:28 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d22-20020a0caa16000000b00690baf5cde9sm4073661qvb.118.2024.03.12.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:08:27 -0700 (PDT)
Date: Tue, 12 Mar 2024 17:08:22 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
	kernel-team@fb.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <20240312210822.GB65481@cmpxchg.org>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfC16BikjhupKnVG@google.com>

On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> Yes, these two are among the differences between the active/inactive
> LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> positions of dirty pages. The active/inactive LRU moves dirty pages
> all the way to the end of the line (reclaim happens at the front)
> whereas MGLRU moves them into the middle, during direct reclaim. The
> rationale for MGLRU was that this way those dirty pages would still
> be counted as "inactive" (or cold).

Note that activating the page is not a statement on the page's
hotness. It's simply to park it away from the scanner. We could as
well have moved it to the unevictable list - this is just easier.

folio_end_writeback() will call folio_rotate_reclaimable() and move it
back to the inactive tail, to make it the very next reclaim target as
soon as it's clean.

> This theory can be quickly verified by comparing how much
> nr_vmscan_immediate_reclaim grows, i.e.,
> 
>   Before the copy
>     grep nr_vmscan_immediate_reclaim /proc/vmstat
>   And then after the copy
>     grep nr_vmscan_immediate_reclaim /proc/vmstat
> 
> The growth should be trivial for MGLRU and nontrivial for the
> active/inactive LRU.
>
> If this is indeed the case, I'd appreciate very much if anyone could
> try the following (I'll try it myself too later next week).
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..020f5d98b9a1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
>  	}
>  
>  	/* waiting for writeback */
> -	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> -		gen = folio_inc_gen(lruvec, folio, true);
> -		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> +	if (folio_test_writeback(folio) || (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> +		DEFINE_MAX_SEQ(lruvec);
> +		int old_gen, new_gen = lru_gen_from_seq(max_seq);
> +
> +		old_gen = folio_update_gen(folio, new_gen);
> +		lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +		list_move(&folio->lru, &lrugen->folios[new_gen][type][zone]);
>  		return true;

Right, because MGLRU sorts these pages out before calling the scanner,
so they never get marked for immediate reclaim.

But that also implies they won't get rotated back to the tail when
writeback finishes. Doesn't that mean that you now have pages that

a) came from the oldest generation and were only deferred due to their
   writeback state, and

b) are now clean and should be reclaimed. But since they're
   permanently advanced to the next gen, you'll instead reclaim pages
   that were originally ahead of them, and likely hotter.

Isn't that an age inversion?

Back to the broader question though: if reclaim demand outstrips clean
pages and the only viable candidates are dirty ones (e.g. an
allocation spike in the presence of dirty/writeback pages), there only
seem to be 3 options:

1) sleep-wait for writeback
2) continue scanning, aka busy-wait for writeback + age inversions
3) find nothing and declare OOM

Since you're not doing 1), it must be one of the other two, no? One
way or another it has to either pace-match to IO completions, or OOM.

