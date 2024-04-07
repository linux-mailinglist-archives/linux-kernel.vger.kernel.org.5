Return-Path: <linux-kernel+bounces-134595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4487189B35A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BF8B22181
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD33BBE5;
	Sun,  7 Apr 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcFI3LPO"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D426AE3;
	Sun,  7 Apr 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712511746; cv=none; b=OXa7CInY3bjLZO2VJZtlKlz8xt6Sjv6ynG7KMihs3FZaZWm+g92v8NmgzFn+LCGgYJfSolf80SXe+VA1p5Z87XHkzArGqZGUw3kWO+smPo6i+TEe0NGtfJzZPuS0xOfGPxbnOm3EbSViF+zZa7dIxwo0qhOwGn/PVXORnY4nhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712511746; c=relaxed/simple;
	bh=etAp7UXfJ/WJy4+nHdOhLIJ6jju/rYBGIvpVABAbLBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDRXzyRteDUfWdQOHZUi6dIJcjy46XwyKp2XzjT3gJTOjRC4mUXADXv3q5RBMuJ0Ed5HJb7i9smGIrtgxPExIJz1hjNTuUvKunCjp3vuhHgO+zbWywx4cdEQPA/2XJpUC4dqNlT5ijksTV9uBNh/jMVHumIM2hLf1WaTon/+OL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcFI3LPO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed32341906so70598b3a.1;
        Sun, 07 Apr 2024 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712511744; x=1713116544; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmJXrKQQ8NYLGkWMPvSbi6f9GIaPx/v82cnS8xblnmU=;
        b=LcFI3LPOas/lUuhq9sMvIAk71Kav6viCqL9DnHvpM9w1qpMgQAN52BoOk/gqd6Ypan
         inUA+Rfgfid/6Rf5Qy1VlSKzrS6n2njyXU1b92p1DBYB5196P43wxJkbGVbSijiWDVhX
         AiEuqtMNzumP1jfm67/V1mi+vWb0IZaUBnAtMgrZ+RQRVgXKSLCI/eHoHLWhBAk70HNC
         GPoPZXBY6eHs2Ru8v98mjFYU9v/uG+4RIerkVKbsxvg0nCia2rUdNkA5SturvbmeaMTf
         Pt2eQOenVNqLfLxSW5zzG7Yb6HazwPx7nFu3/W3y9o14Hu091tLNp+4JHf7e7WdSmKUJ
         Wm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712511744; x=1713116544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmJXrKQQ8NYLGkWMPvSbi6f9GIaPx/v82cnS8xblnmU=;
        b=CV39Kf/ck86rmbAMVO5jz9OEXON7aTw8m42nzJ/2Ugr6XMvhpWxXeDKtMAgktf9Pbr
         dttBx4ZDV62sRTmTBce+Evml+kDdxejFi9TpAdhxiL7Kpjv2UFpMeL6lFPdOz9wM+ERv
         0lxtQObsekreYTpaoJUGZbpM881FOkv+2Iagbl4X25xMi/uWrNLPmCmaZAQuECv5EkHO
         g7A0aPswk8e9kEGF5maF+ShlzTb2dRhhiB5uAc5F8I8ozhuH30bPZDnSn4gJRZxw8j8m
         KUJ8/4OCIxOg9yKwaNsFC2ohFCAKOBqMgcizPLA/uO4lt5w9SOsHUgfL2cj9msTr2OPh
         PHUw==
X-Forwarded-Encrypted: i=1; AJvYcCXVHl9ao48exBSHutfWcR3LZY8u6BQHHswSYnuL068hAMNndxsqEmHDkE59Y6Fv2HBugugAo96mQDw3hGET21ybcQZbd3nFQg0Ma+k8
X-Gm-Message-State: AOJu0Yy2iXnTjjZVIrqKviNML6yF06QmmdTBY3BCW6fmVpJ998QsUgG4
	QDJ4Fywf7PC453+BuKl50rxhz0lp7NhvXJcB7g8H6ZUXaSSmQQCx
X-Google-Smtp-Source: AGHT+IGmD7uuv7daOdFGh7EVoXMeD8DUhS3yBr0tHuJyG+U1xgkotgOsXcTORKS876xd2wFGkcWeGA==
X-Received: by 2002:a05:6a00:6908:b0:6eb:1ea:52ed with SMTP id hs8-20020a056a00690800b006eb01ea52edmr4889908pfb.1.1712511743899;
        Sun, 07 Apr 2024 10:42:23 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id g24-20020a63dd58000000b005d66caee3d0sm4902477pgj.22.2024.04.07.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:42:23 -0700 (PDT)
Message-ID: <30a6635dedf305e23e623c501e614e55bca1ab41.camel@gmail.com>
Subject: Re: [PATCH net-next v1 01/12] mm: Move the page fragment allocator
 from page_alloc into its own file
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells
	 <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org
Date: Sun, 07 Apr 2024 10:42:22 -0700
In-Reply-To: <20240407130850.19625-2-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
	 <20240407130850.19625-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
> Inspired by [1], but use free_unref_page() to replace free_the_page()
> instead of __free_pages(), use VM_BUG_ON() to catch that we can use
> free_unref_page() directly, also add its own header file.

Instead of doing this all as one patch it would be better to split this
into 2. Make the refactor first, and then move the code. Don't do it
all in one patch.

Adding a refactor that changes out functions called in addition to
moving the functions makes it very difficult to provide useful feedback
and review.

One of the big things with free_unref_page vx free_the_page is a check
to see how costly it is to free the page. Right now the page frags are
on the verge of crossing that threshold with defaulting to order 3
pages.

> As the API is only used by the networking, it may make sense to
> move it to the networking directory like the page_pool does in the
> future if we can make the free_unref_page() callable outside of the
> mm subsystem. And we can utilize that to decouple the 'struct page'
> in the networking subsystem in the future.
>=20
> 1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.c=
om/

The problem with moving this out to networking is the fact that this is
memory allocation. In my opinion it would better for it to live there.

> CC: David Howells <dhowells@redhat.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/gfp.h             |  22 -----
>  include/linux/mm_types.h        |  18 ----
>  include/linux/page_frag_cache.h |  47 ++++++++++
>  include/linux/skbuff.h          |   1 +
>  mm/Makefile                     |   1 +
>  mm/page_alloc.c                 | 136 -----------------------------
>  mm/page_frag_cache.c            | 149 ++++++++++++++++++++++++++++++++
>  7 files changed, 198 insertions(+), 176 deletions(-)
>  create mode 100644 include/linux/page_frag_cache.h
>  create mode 100644 mm/page_frag_cache.c

I would add comments inline below about the changes you made but it is
hard to keep them in any sort of context since what is contained in the
"-" block is well spaced out from the "+" block.

