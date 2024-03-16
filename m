Return-Path: <linux-kernel+bounces-105186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FE87DA49
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8978C1C20B62
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF018C1A;
	Sat, 16 Mar 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IN5x/Cb3"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352C18AED
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710595993; cv=none; b=SGfK4lM7y/Z8HiETb8kxGB1L468QDV6hLQQwOlHZbWGM20+Lr201oimqhB5uXtggWZ9MEYqljW1vF2hziIe+pvSnM2ytVrGVPiE5ipd1sHKx0wyRRumaY9pjuhQB7v4FZkPyrQSZEKtuKwtDIH/0Xg6t4R9rF4sjT9yWCVJjt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710595993; c=relaxed/simple;
	bh=jWasRBS7uYYZTIESYrGdx2CCsrKtFL2TJGC/9IMUElI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPqUS7eQYkWqD3CrYMBuWIn/6/NTh1sXv9wl4mufeM/O0EGEtR1un52O+8C4jWd2WCDvBF/5IEvYErBwapOEImqIwjK9YbNIucRxbHvLe107v4kpr2zMKUobsjp253Ejl6Rq0rV7XbD6lpv2Y6MGd50KXZSOHVUsNh0UJ1b3Rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IN5x/Cb3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e622b46f45so2314093b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710595989; x=1711200789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0atnVohOpgRx9cMpkzV7i4jL/M6ojDIx6wxbLSFf78=;
        b=IN5x/Cb38qIEkaORaVgfXmVtFG6oSSC/92c4Jdvf1MRy15rgokGAG39LsWHy9u9w4m
         0i1mBOeoGOn+IZ/xOR/jo0NjXeuM+Peq+tU5oHcRiTZgDl/rxlaryrjTpGMcrtd9iuI1
         FbjnFx74DYY+jOY7WQuG/hGS1AdEVhn97u/uGkKmZJzGEYKNQK6cLiWB5EGmvEKjs6Ud
         MFY2kE1EaxkHuCy0xsE8Il/ap/LZb48QV1tWGAFgbX7di9Q5ctusWmERwExth9rw+2VZ
         Hc4mGfzqkLPUbP0R6avYQSdnFgbj7ffG5UdNO+j9v28NmgDbHUWivndvDm/Ut5sa9avE
         sKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710595989; x=1711200789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0atnVohOpgRx9cMpkzV7i4jL/M6ojDIx6wxbLSFf78=;
        b=Aa+TPOQ01kx82vFamXL1KLWwGuZZVmJ1HSfxi08YEIkY1oCD19+hPEw7eyXF1V+eAQ
         JmMlZDJ6RiyTfdCJfnlFuZHk/2RoCK89IdD1QsebyroEf0EOP5h/VaFL6zuICOiz9c9V
         BAehYGeWgv3SvIoDM2ZmcUHd07oRObJOqTx5rkhyQxKcCoxPRcis/pr4XHxgqDcQoO5E
         m8H+xDmPct0W6tlgTPZJaPwvaPaOBpdemBX/f19KL/ZFguV9yJy3houSbO6yRdR/CO9s
         LFU/I+Oj+avlpgp/CEocwpq0dlW8gab/fuuXzrwsD+2eewVOkDVi4iADeanXC9A0luZ8
         ALXw==
X-Forwarded-Encrypted: i=1; AJvYcCWLURhWuB7pebX9tfg5bvCFaIhejHOJ6LKj6iYQ0f9KWvXOKmAKuqlTb6NomYc0WKrrPQzPRUZSVhIEgy/iscAQQBLLTJwfGQmRt2nm
X-Gm-Message-State: AOJu0YxLhP3kh7t5Rix6GZ3OB6xBskdkyRSiNnsNds6f6nKyERYGZ1vj
	zQ83FDZf2l9MjgNkNi1H1RED3/rmMWCvhkQej5/ZHLc7BNtCNjCH0iTOQ+T0E44=
X-Google-Smtp-Source: AGHT+IFDED0rPeVrrktx5cE7FyttQSxpxrMVZIivfj60Ggu2ysrt+2qHIrQn5CUkM8a6O4ihBsOgEA==
X-Received: by 2002:a05:6a21:3995:b0:1a3:5c60:112a with SMTP id ad21-20020a056a21399500b001a35c60112amr188068pzc.36.1710595988767;
        Sat, 16 Mar 2024 06:33:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id sg3-20020a17090b520300b0029f746c8789sm996009pjb.1.2024.03.16.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 06:33:08 -0700 (PDT)
Date: Sat, 16 Mar 2024 09:33:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>, Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
Message-ID: <20240316133302.GB372017@cmpxchg.org>
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
 <CAJD7tkZH-mU_7NMMBAS4nyfyWKKK3tSdQisVQ5iRqckqHouoJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZH-mU_7NMMBAS4nyfyWKKK3tSdQisVQ5iRqckqHouoJQ@mail.gmail.com>

On Fri, Mar 15, 2024 at 06:30:37PM -0700, Yosry Ahmed wrote:
> [..]
> >
> > @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
> >  insert_entry:
> >         entry->swpentry = swp;
> >         entry->objcg = objcg;
> > -       if (objcg) {
> > -               obj_cgroup_charge_zswap(objcg, entry->length);
> > -               /* Account before objcg ref is moved to tree */
> 
> 
> I do not understand this comment, but it seems to care about the
> charging happening before the entry is added to the tree. This patch
> will move it after the tree insertion.
> 
> Johannes, do you mind elaborating what this comment is referring to?
> It should be clarified, updated, or removed as part of this movement.

Wait, I wrote that? ^_^

The thinking was this: the objcg reference acquired in this context is
passed on to the tree. Once the entry is in the tree and the
tree->lock released, the entry is public and the current context
doesn't have its own pin on objcg anymore. Ergo, objcg is no longer
safe to access from this context.

This is a conservative take, though, considering the wider context:
the swapcache itself, through folio lock, prevents invalidation; and
reclaim/writeback cannot happen before the entry is on the LRU.

After Chris's patch, the tree is no longer a serialization point for
stores. The swapcache and the LRU are. I had asked Chris upthread to
add an explicit comment about that. I think once he does that, the
objcg situation should be self-evident as well.

So in the next version, please just remove this now stale one-liner.

