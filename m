Return-Path: <linux-kernel+bounces-6373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07C8197D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27603B2453D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BBD312;
	Wed, 20 Dec 2023 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zc6qVVHq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB441C2C5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2335397e64so439938366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1703046633; x=1703651433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yqdSI79lek9Xt4ev9R4/ZWwKsjGSM8T2MhvlKn0sJA=;
        b=zc6qVVHqK0bNv77kZdAGh4x23Yf0B6jgO/cd35qgtVQ+sz0mP9eADstx5v/acMhiE+
         40WxR4FH5LwlwPJiP4vX0krUjtqQ9V++UR3k/lLGhzDONoPs3f5C/gX58ocL/DGgSUqB
         Ev5w96XZdfKR3LAhSUqEYO3qnAUBW0XuJygzKPs44Qe8dZZN92FhikbhjEteeSd8Wa7E
         ZH0j1B3x1JgkliKzLdPvbFCCLZDvTDVHXZLB4d2KLWae45Z0D4Z8JKEMFtxBz/dJHpmG
         94eHGVop+U5fgqbkUnhw377aZbJ4lAOLblpv2iUNK4bqTyH7OfLNh3jF2SHphllFJNuS
         tz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046633; x=1703651433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yqdSI79lek9Xt4ev9R4/ZWwKsjGSM8T2MhvlKn0sJA=;
        b=tsu4aUby01Ovc+JWZ+WL35k1NKgxdVG7V29J2bjLINK2cES/CDhplRKh/FVzVtCPAQ
         BLpVUqmZEm2szsD/Udfx4uD2MWocxuCXt9J6OJFmsnJx31LtI8rLwNR9qHBpIMOH5+Ns
         GAmsBeO896UIE1CXMZpUoCRB5ayUNrWzmPPIfK6KrfGsTpglf3sNKv42Zxj/IticO2k6
         rsH41yA+lTAiQCpxMZfjDVClUpZkmOML4FVqG06osHNA6YnmQek9PmP5cq38J0OaG4Od
         LmP//2U95z8R7ttSkq3zDvCd3WjgsFeCv0dC6viSjqmNk8mQaZCKQVevxp9alVkaRevI
         dI8w==
X-Gm-Message-State: AOJu0YwSwrvtLdVHj3fvdPJ0U3bwmOPZ9LyEvkL0j/yzs43jucGMRZoh
	BBN9uwtQY4LfTNT3BJaQJT64IQ==
X-Google-Smtp-Source: AGHT+IHCeJxHdnOvKa2IpN1bBLZfG/fAoFND1BjbGT9gjdLzerwqeQpZMfEqKHMbWub40paxmZ1Tsg==
X-Received: by 2002:a17:907:94c9:b0:a11:2ad2:6563 with SMTP id dn9-20020a17090794c900b00a112ad26563mr10841320ejc.26.1703046632692;
        Tue, 19 Dec 2023 20:30:32 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::4:42a4])
        by smtp.gmail.com with ESMTPSA id wn7-20020a170907068700b00a23524df923sm3602794ejb.206.2023.12.19.20.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:30:32 -0800 (PST)
Date: Wed, 20 Dec 2023 05:30:33 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
	Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
Message-ID: <20231220043033.GA23822@cmpxchg.org>
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
 <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
 <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>
 <20231218140313.GA19167@cmpxchg.org>
 <CAJD7tkbdCv7CMy71UOCefR2Y1BXevJ2eMmYwk+=e=GPcCqn3+w@mail.gmail.com>
 <20231218145815.GA21073@cmpxchg.org>
 <CAJD7tkZhC+cniDpFW31Q+7F1AZDkUBNSDNaMvfVT9AG31BNJmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZhC+cniDpFW31Q+7F1AZDkUBNSDNaMvfVT9AG31BNJmg@mail.gmail.com>

On Mon, Dec 18, 2023 at 12:52:40PM -0800, Yosry Ahmed wrote:
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1458,15 +1458,14 @@ static int zswap_writeback_entry(struct
> zswap_entry *entry,
>         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated, true);
>         if (!page) {
> -               /*
> -                * If we get here because the page is already in swapcache, a
> -                * load may be happening concurrently. It is safe and okay to
> -                * not free the entry. It is also okay to return !0.
> -                */
>                 return -ENOMEM;
>         }
> 
> -       /* Found an existing page, we raced with load/swapin */
> +       /*
> +        * Found an existing page, we raced with load/swapin. We generally
> +        * writeback cold pages from zswap, and swapin means the page just
> +        * became hot. Skip this page and let the caller find another one.
> +        */
>         if (!page_was_allocated) {
>                 put_page(page);
>                 return -EEXIST;

ACK, that looks good to me!

Thanks

