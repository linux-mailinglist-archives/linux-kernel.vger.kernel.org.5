Return-Path: <linux-kernel+bounces-18005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5728256DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD551F2434B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946C2E658;
	Fri,  5 Jan 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fECjWpxQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC92E640;
	Fri,  5 Jan 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d40eec5e12so11988325ad.1;
        Fri, 05 Jan 2024 07:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704469330; x=1705074130; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0tdftrGJbQA0lnpxqT4ZNVpdbS5d9YFAgX2xz2KRWA=;
        b=fECjWpxQv12EI7w4N+VGl1gFJ9NQ9Kgp86nz2HPZdE3Md54aCBtwclpxqpSi9gKxzI
         oydwlbImie8exWeaDmpZLnlL3wXO8rah90D9hJtiaJnYffybF+dSx5h34UFzp3YXy/MD
         OqVMXOoD4MkEvT3GWa3wh9r5u4KT/H8/14PkZo0svi4XUPVlDYggFUbqiqt9TlKH8a9l
         cR6Vw6hj7BtpCCvjJDhDAanWrl5O5P0AfX+umF04/DgOjHu0lID8a++T2K4gdyrl5s0E
         /Yd3fHC3JlayjUodpBVvYQSFsXNZqVY3jvU1Gqcv7dvVzkWmplKnXk9RUUdlSaRKYz9d
         LIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469330; x=1705074130;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0tdftrGJbQA0lnpxqT4ZNVpdbS5d9YFAgX2xz2KRWA=;
        b=B0VmEE/x4Sf2P0RElFrbjNXxREjD+gCkUv/wtpmlrovWdJms6iiY218NaAvncZrvIW
         hoqdtEnGFyvarv0o+viDDZzsLZePzN935/c/+ppatIJ2OByZqw18uhrSnjPsljtsyjoK
         AKyMm4ZqtKvGQcw7uqQDcLrbx3zKV7DolPub/1yBK7UESKd/1/SegX4PgACzOPx+XFTU
         mRo2rKhZtvFaQ7LytMjF7fjGLtW/huxRo1kvEJNuV+U+HF/iNQRSk6crMMtFjEgspnlN
         BRr1KQheGpUnjp3ztp2ukYhDnoO4EHRNtYCdLpR3ct7lXVbmuu9yvJ70giaUHMpE3+kV
         XSpg==
X-Gm-Message-State: AOJu0Yy+uJRYFS2kBiiRvFgTAognDpGxvTGCDkghGODMxNzsWSi8R5hf
	qE1IA1oSOinJlYA7UNMJZ/I=
X-Google-Smtp-Source: AGHT+IF7HN0bTcfhahHnVhLxfa5wv0VPOrH2QarAcMVghgtzHLN1ZDN6Ogzg7D+86n/vXlxwTZFmaA==
X-Received: by 2002:a17:902:e84a:b0:1d4:5b0d:7002 with SMTP id t10-20020a170902e84a00b001d45b0d7002mr2672794plg.112.1704469330643;
        Fri, 05 Jan 2024 07:42:10 -0800 (PST)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id c5-20020a170902d90500b001d3ec25614bsm1552423plz.24.2024.01.05.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:42:10 -0800 (PST)
Message-ID: <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for
 page_frag_alloc_align()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Fri, 05 Jan 2024 07:42:08 -0800
In-Reply-To: <20240103095650.25769-4-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
	 <20240103095650.25769-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> The next patch is above to use page_frag_alloc_align() to
> replace vhost_net_page_frag_refill(), the main difference
> between those two frag page implementations is whether we
> use a initial zero offset or not.
>=20
> It seems more nature to use a initial zero offset, as it
> may enable more correct cache prefetching and skb frag
> coalescing in the networking, so change it to use initial
> zero offset.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>

There are several advantages to running the offset as a countdown
rather than count-up value.

1. Specifically for the size of the chunks we are allocating doing it
from the bottom up doesn't add any value as we are jumping in large
enough amounts and are being used for DMA so being sequential doesn't
add any value.

2. By starting at the end and working toward zero we can use built in
functionality of the CPU to only have to check and see if our result
would be signed rather than having to load two registers with the
values and then compare them which saves us a few cycles. In addition
it saves us from having to read both the size and the offset for every
page.

Again this is another code cleanup at the cost of performance. I
realize many of the items you are removing would be considered micro-
optimizations but when we are dealing with millions of packets per
second those optimizations add up.

