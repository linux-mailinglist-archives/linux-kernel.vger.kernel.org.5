Return-Path: <linux-kernel+bounces-23989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0E82B4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB80C28AFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C354BD8;
	Thu, 11 Jan 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp+bC01x"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8654BC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso64989271fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998292; x=1705603092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpRmx63Tx70yMmTO0ohECxAXID3B0DpOULNfXZ9JjIc=;
        b=Jp+bC01xGSGRPTD9OAIxwQwxtmLbXsk43RfgEV25if/OKh13PhrWdfKVkehLatTOh6
         K/7oGnVa6FMBHiTnJlxwJzxE7fdcEIPBQLhtowzcGQAqExXWn/nkvE5fSQnmG+tXnBBI
         Jibuipqx4r+dQwDMyeOuz07pisT3TnAYMBxUAMHkFxxrILRurFbVNvlyKcW6v+dGXu42
         dEI2VyXpnDwQiTlcFVrtbPdMqkc3+HORfgvwY401d/6+3oNNDpggXR7M52bfudcHcjaG
         DgWQYD1imXr6xkw5qJvtJzbqxYgQbF0a8KR23vwGqKepvbgeQ5+OzUh5E3vJSFcqHuNj
         c+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998292; x=1705603092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpRmx63Tx70yMmTO0ohECxAXID3B0DpOULNfXZ9JjIc=;
        b=iBCtWy4KIKKJnOyljdgN4jMw1UmGRNXS4ym5dy65JqinNOWHpjHZye0osZLsb0s/pa
         7FZECB3OATCbfgmVtI2M194nOeUvCW6MON1f4nlu51OPIrPp9pSrcGssuFq0Ca5Wu31k
         2lsZmEOgQ4kS+ylX3NExPjsUv/YL9icni3bu5lEijiiNS1/KD2sg5pjY1Rg7OTdLWxA9
         UnsuEHpdTGAKnOVrPtLUaUlkvDLYKYhMPxbdu2uSGmCxkY9p/kZEnDXtMJeze+9rpl5c
         /qUCntliJzXX+BouQahDkzr0KTLFk9Tw60Xt0m/EaKuDOErTosWQOfB3gXtTetnDsstt
         hy7g==
X-Gm-Message-State: AOJu0YzCT0Zaju+J0U05g2e12VtW+nhmI3zfJ2QNVpTxOE9SF3q0fUVm
	bJ69F84XxOM0XFwBYPhoYKq6GejR7YpDxAWU29M=
X-Google-Smtp-Source: AGHT+IHqUACxW29ZUmHzFGFxIwCBk1AqgQMU+RNqcJK2yt5N1JiDTuV3H///Je5ormr2cnbs+tUE641xuN/eqewIFco=
X-Received: by 2002:a2e:7312:0:b0:2cc:8c52:df91 with SMTP id
 o18-20020a2e7312000000b002cc8c52df91mr89716ljc.85.1704998291614; Thu, 11 Jan
 2024 10:38:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111183321.19984-1-ryncsn@gmail.com> <20240111183321.19984-2-ryncsn@gmail.com>
In-Reply-To: <20240111183321.19984-2-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 12 Jan 2024 02:37:54 +0800
Message-ID: <CAMgjq7CSDJHf=BWLThPbaRRW104swbGwwis1mJkTj+xbhAn5nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, lru_gen: batch update counters on againg
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Chris Li <chrisl@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=94 02:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Kairui Song <kasong@tencent.com>
>
> When lru_gen is aging, it will update mm counters page by page,
> which causes a higher overhead if age happens frequently or there
> are a lot of pages in one generation getting moved.
> Optimize this by doing the counter update in batch.
>
> Although most __mod_*_state has its own caches the overhead
> is still observable.
>
> Tested in a 4G memcg on a EPYC 7K62 with:
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
>     -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys \
>     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
>     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
>
> Average result of 18 test runs:
>
> Before: 44017.78 Ops/sec
> After:  44687.08 Ops/sec (+1.5%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 9 deletions(-)
>

My apology for being careless again here... the title here should be:
mm, lru_gen: batch update counters on aging

