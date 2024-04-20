Return-Path: <linux-kernel+bounces-152275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5944B8ABBB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB71F211D1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC91D680;
	Sat, 20 Apr 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hw0zfWGj"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32A1CAA9
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713619413; cv=none; b=gZ15kynkaePDsi7V+rPTlj6rhLd5cJqk3iDaGt9xhnrLhCQW0PJ1114RHe9tuSQnFrruFczP1QWEN2OVU/JHEFgAvqE9BMzq5AYECwCzcmR6NpJ7xqGv5oer8x6rxcdfCHFPGX7SKPph0kMUTLHHT7tB6nr1cFwACktLhokcAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713619413; c=relaxed/simple;
	bh=o+P0pKvUdXYxGkSPkossj7eoNY//UNjJDR4sSSRBtLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ9/gzbiUmr9JS3xslLbFp5fX/jXDDb/Iiftth0nmGJGAg4VNKC1nYcX9LPF7tTnYrNj/MDckS4sJ4gSXneJOj+WruTZyEcjcv0cVGLQsdbv2EMHAHQ+uUbayARZeCNis5xS63AmrJp/YddaEB5CK4oBM6h2b32bH68WZUEXas4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hw0zfWGj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61af74a010aso31371447b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713619410; x=1714224210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7E/gU/HnTfpLL2KPHG4Owb2FHQL2jemmH65c7TQSroM=;
        b=hw0zfWGjMVOH7FKfT2TQFWo4LbjGUifOOtzfDX5zpj3QJB6/jOCQ1LweJgH6z4eBXi
         O/O55GsnEB/uEoul3OzIMSYLTyvsnNUc/KVuP7Cfg/P77k5NkYpPZMwwwTV2orO9KVwj
         D7vwYifpWDZBBwZ7Pt6C1ConijmOqM/OaVdc4JuuF+XA7YIl91wn0DeScC+3yKAyvv9K
         ywyOeucw7ohGZRuI4PHgh7eM7tNcIUqWsmDIWDgmv+id2APa2ORmGTe4bcYJb2I1xEwY
         oy5j52cO2apoRzoi1DZL8fw7DtdsgNXfDg+zonR4XZUa9b7OA79yISgw8q9ff68atkV3
         8guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713619410; x=1714224210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E/gU/HnTfpLL2KPHG4Owb2FHQL2jemmH65c7TQSroM=;
        b=OlKItsGqo67rVLJplsvCTLmNqEQjgNc8Eq62eO63+cijtFV5IDHnPBtgIFPpgm89aZ
         36UAnu5LoTVTkpomVip4idKsyWjnuanlk18qCqKVnvQkERLaOU4+zA3/ZvJkaZkLjnsW
         4mp7FTNGTPnYa4kryD/YZWWpZJmA6vm59+PyJ+aqI+OUZm5UfmJ9jw1B5Fuwk2tWn07b
         UoSSqYRrK7WxiEfVK3MUm2Oqy93wSLDlMxOxOALu/B/vbf2AiwCQ91hLQE0us1Hs599i
         GJ4VgSOa7xMci3BL2pfec7266g+INDeF2WuEV+Kq5PPyCohhHoiyA47vwudh8WB51pMC
         g7yA==
X-Forwarded-Encrypted: i=1; AJvYcCWbpJvUL2S5U8AvIG5jqJ30BaqsJEZgIdgvtvybqlyB3BjRvZKwpCw5kOFeqsyMYUIJwhvOD0XwUWXuxURVwd95Rs3QdIE5MHs7S/fW
X-Gm-Message-State: AOJu0YxPcTT0lH8GZl0e+599xyu75ozizFn6g2QuYFXFsMq9WbDATLcZ
	lJOp2kUhlCh6XPf57K+Z7pfjldWRjF2p3AvBSiTy4GwsHlVWv0Hg+lBEa9On7MBxOiQowgYUggi
	7
X-Google-Smtp-Source: AGHT+IFF7WdFGx06lubZjnZEDsS7NHLyRc7J6rqOKjkDjjAr8x9U13jv0WnJ7Lmv1HVdrelM9tkBpw==
X-Received: by 2002:a05:690c:6a10:b0:61a:b7c8:ea05 with SMTP id ih16-20020a05690c6a1000b0061ab7c8ea05mr5479226ywb.35.1713619410429;
        Sat, 20 Apr 2024 06:23:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9d5c])
        by smtp.gmail.com with ESMTPSA id o2-20020a0c8c42000000b006a06f044a34sm653868qvb.23.2024.04.20.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 06:23:28 -0700 (PDT)
Date: Sat, 20 Apr 2024 09:23:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: simple cleanup of stats update functions
Message-ID: <20240420132326.GE1055428@cmpxchg.org>
References: <20240419233949.2326100-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419233949.2326100-1-shakeel.butt@linux.dev>

Hi Shakeel,

On Fri, Apr 19, 2024 at 04:39:49PM -0700, Shakeel Butt wrote:
> @@ -2983,10 +2984,6 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  
> -/*
> - * mod_objcg_mlstate() may be called with irq enabled, so
> - * mod_memcg_lruvec_state() should be used.
> - */
>  static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
>  				     struct pglist_data *pgdat,
>  				     enum node_stat_item idx, int nr)
> @@ -2994,10 +2991,12 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  
> +	lockdep_assert_irqs_disabled();
> +
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(lruvec, idx, nr);
> +	__mod_memcg_lruvec_state(lruvec, idx, nr);
>  	rcu_read_unlock();
>  }

Best to rename it to __mod_objcg_mlstate() as well to follow the
naming pattern for whether caller or callee handles IRQ toggling?

Otherwise, looks great to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

