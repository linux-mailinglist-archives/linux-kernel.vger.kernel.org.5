Return-Path: <linux-kernel+bounces-103044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC987BA55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D569B1F22CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE06D1A0;
	Thu, 14 Mar 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8JR2Lfe"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01F6CDC0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408306; cv=none; b=KJ9jIWk7IiqICvLEcw4FPjqIFmDVLIioyOjL7XSZcRpWdPUl69mrEt9F8gH60YOU3KsNxlsSAji58Bykmx1igp9a9FUmiEKZNhHAnKFYdtzNJiqqKIijQUY7oyMkVcRJsOYazPVxrO7tCjN3rHV9OFlrqk3zBJc3w4h1x8GbDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408306; c=relaxed/simple;
	bh=6tIt0rGYr3xffVSMMPnAuHzPxCWu+NZvjW36OSif+RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR4h22UmTDobW0lPHR4yzdE/iSdB8nZMMM9GsweBvXy9ZUBx9TavZyNqibT+VdD3uPwUcdTWn9/v7E7ObaO6UPx9ukX3RZq2CICTLPZ7x8K6U3rjoJlgOSXF2KbmXeyWWi2AayyA3PB8qccNN0vXnUz1qpQW75XDXjj3wk8pFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8JR2Lfe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783045e88a6so52184185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710408304; x=1711013104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocCihU80Xv40gzd79kv18kcNVazvWx00n3HGC6M1AO0=;
        b=L8JR2Lfe4xdc1AKMK620t6lsbDvLNgOkiPzYAl1gUjIgjYXifExiq+g1szLpy15JCG
         kQTn33ZhNVEYYBh4NvVkvmdPo/Tr4ShfVV7+jF42wGBl8TKGV0jynGymJeSvrmEgtJUE
         yGTi9dicaChPvPqffJKYcIqHkVBITJqpTT1PiaqOHY1bxw5AwzHhDka/Y/j2CqGfquAX
         OGwPczRIfgOgZGTIKMi8lpXXhOEQ9vnbrKiJH661cvfoCrlfS5/PbxFpynXZJglT3SeQ
         5qNr1YGqgbGoQlgGyQJ03Sb+w3GUvKXOIwYbzpwgt6LVTRjKMELjU+6d5W9EnVAzdDtM
         DpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408304; x=1711013104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocCihU80Xv40gzd79kv18kcNVazvWx00n3HGC6M1AO0=;
        b=wH9JEl1bALFENFKveXAfW2DIHxeJbWWA8l+YtNhDj25wq0utRyiif2Hn0jXGqZBawN
         Q7jOhw9C/hWgo3uC64lEoCtPBbgYI5eGf+vXWdg/9pqemwcYhbl9yR0XGDhw1EH8qn6/
         QQ1U2+nTQN20qlxt0hGGX722sSrrdhizdcwoS5sKOIRy3O3eetzHlMRDI23IeTfdHD/d
         50FoGj7/IC0U1GqYNRC31MmF+5aDSPAaObl49yKPU10QA96t0+57mx33tEHUHYvdTs5h
         tYeis+mCAuGIYbqsj20ZD2XOruJ7oGJ6A5J3kjuHL6pEpTSEtAZsKpH9QVYr74MxA0dH
         4WUw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvkSvK+wzdmQcfo/lnCzx80Yoh/b0ajv134qRcjWhGZQdQ3WLGHipVqZVHcjfYEZ78i2Z8rNd5CEAo0U8rnUwg4+rrPYuQ9t3Zqn5
X-Gm-Message-State: AOJu0YwffB9MqX7H0pX543voWJCbTvEuNsBsy+ia7dPscZcSnOBc9Pdi
	SjXG69q9fmqdPS/DOUG/kwk97/3FvREiJqU+fPsxMIoYkifhx5JPNHbx5DO4SbEt8eBaEMsDuGD
	yJWy1M2Iuud1oSGb21EoDR8U/zwo=
X-Google-Smtp-Source: AGHT+IFwd0hzTsYhw29iN2nwcK1sLtRv9RFdHPdubmJUBwzbzsvkBwHQn/1zikC66NLG0Z9cQD77SclDmWUhTSyctQk=
X-Received: by 2002:ad4:4e70:0:b0:690:b66b:c43c with SMTP id
 ec16-20020ad44e70000000b00690b66bc43cmr126685qvb.24.1710408303975; Thu, 14
 Mar 2024 02:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
In-Reply-To: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 14 Mar 2024 16:24:53 +0700
Message-ID: <CAKEwX=Nd0kAJCbzNtLHbg6Wz53QY8+uA4d-3dvi_PY9xNX-5Tw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>, 
	Barry Song <baohua@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:31=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
>
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
>
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
>
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase and xa_store
> directly. That saves one tree lookup as well.
>
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
>
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
>
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=3D2GB, zswap shrinker and writeback enabled,
> one 50GB swapfile, 24 HT core, 32 jobs)
>
> mm-9a0181a3710eb             xarray v5
> user       3532.385                     3535.658
> sys        536.231                      530.083
> real       200.431                      200.176
>
> ---
>
>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chris Li <chrisl@kernel.org>

Apologies for the delayed review :)

LGTM FWIW. Looks like you're sending a fixlet to address Johannes'
comments, but I assume it won't change too much, so feel free to
include:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

