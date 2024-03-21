Return-Path: <linux-kernel+bounces-110800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B703188641B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC7283EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAFA1E539;
	Thu, 21 Mar 2024 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVsAM9By"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586F1DFCF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065023; cv=none; b=qWoaB9Ff5AHvVtg4oTxpnh6qWPPDK+ikGDFUc79+aBqbW6Y8Gq3YTi797tL49KvuW3KjUKtlKvCQ+a30uI6nQ0fNqpg+ihfdnes7PW/CLQBIwP3OtGZHY31Q7SOfhh4aj6avULwsQ5afGdD2wZi9lG88mIgA9SsZ9Rlxn8sei3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065023; c=relaxed/simple;
	bh=TZO4+cozYPSKDbCtI28YTEVD/Esl0MisAiIACAehqUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBG+dp/gF0PfXSNBOx7XKZ6fdq/AgiKwPCtXzHwM88kxcEZweGk5utvSbPNb39dpy5D8ENt/1Ch4bGnQ7p4vK3ByxKniAkOSQ3Mc+QjyOosvWTvsDUyMbZwjkAHTa6Tx+TsMRDC7gjxrUuzEXWa150gwbkro4a9J/wFO965xvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVsAM9By; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7dac7cfbea0so270032241.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711065021; x=1711669821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AInUnOXLyp8jyRpi/mQ+Hq2H5NzsN1cFn4pjjPB7jgI=;
        b=bVsAM9ByqmMj/6Ao1ptzSk+hju033u+p4iVfmQshdPsds9qAR/3GV6y5auXZLBcjCQ
         fV/w0d9K7wNfhnxWt7Qw7dpimrQoA+YC3bb4yRjtuz+D3SnKfWs2wwI8xWRnbMXorqrR
         6L7M8v1ej7pRX8eA+E/CiBxFD87joQkrxOVbJYnXrdohSbZSZ+dYRA61W1CmXnj10j5C
         mD6nFDaQDdSPUaUg3S1kdRmt9eskoBbBMjfC6FWMi00rxy2nIn0JQ8gmdDsTnHyrE88a
         PykIC7i4gLC5g/lQ4HGLuNfzrmWYnqhtnfaoe/et8yhCR0p82ce0W9TbTDlYS7vgLbhj
         Zipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065021; x=1711669821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AInUnOXLyp8jyRpi/mQ+Hq2H5NzsN1cFn4pjjPB7jgI=;
        b=kjVkpQ6yOaWe3kAH9dfkhXDwmSB6CxqV9Bogoqk6cIbPnh41dxneHRdR1/j7dUYyOJ
         XNcP8bcDU00/tfXFQIezlNTFtthrlIJ5p0l1SKANMtB0UgdaeiU6AXr7aa7t4cFaxdPM
         DnQzKh8P+zQcs0jCDsG4HCwkpnEAIymesWkM0zyk6GOEx5gAN75Py2Zge4V2I2o3x6ix
         N+pwzbyjzLWNvF/JJ4zlIL9FPkqOVlf8TdtHP3RuMokAzi7dz5rHpZAIxiTaICdb0LJQ
         hTVDMmmGa1N/GVn5VqHNA9sd7KGzXlos3id653lnTPUAuUflTW+iJee7CrvlYqe51DnQ
         4inw==
X-Forwarded-Encrypted: i=1; AJvYcCX3UThLurPZG0DxsKhXJkDXG9gBXDTXYDkeD21w5N9g8xN6oNPL1ehvaeIxeXwQPHYrjh/r+ldsgw3QAZjmUDF9z12fNo7yumSrDVFx
X-Gm-Message-State: AOJu0YxIOp+IX2HCUKvebhJfoJNw5QsFw1xuZ7xjWaHKEaxHF42Glb5H
	TF6P0QAqunsFV0PxIqdpgwfC98no2oYNd0vhY2qHquhvJP/5bOa3W0mL6sdt91/hkMessWOZUgC
	SJ2LpZE//ungmKbrhRC1bEWKXaYFDsUai7AThNA==
X-Google-Smtp-Source: AGHT+IEjHxE3NhMhC7z5tyeF+/EQhg1vliYvm3aSpXESl3bBnRXS4LG+lUGnQCqX0ViAtOaFedIBQQjXFVcbk0K3RWA=
X-Received: by 2002:a05:6102:dd4:b0:476:bf60:9556 with SMTP id
 e20-20020a0561020dd400b00476bf609556mr1467512vst.26.1711065020670; Thu, 21
 Mar 2024 16:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com>
 <20240320020823.337644-2-yosryahmed@google.com> <CAJD7tkYb-=Ho85e2AJbkfe-FmT6KXpJpUgPRaXQb5-+sY5j4Hg@mail.gmail.com>
In-Reply-To: <CAJD7tkYb-=Ho85e2AJbkfe-FmT6KXpJpUgPRaXQb5-+sY5j4Hg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 21 Mar 2024 16:50:07 -0700
Message-ID: <CAKEwX=PjpJCewYEMp+=g+92=R-Wr2y+7pwJ81xb9-pogohFC4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove nr_zswap_stored atomic
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:09=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Mar 19, 2024 at 7:08=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > zswap_nr_stored is used to maintain the number of stored pages in zswap
> > that are not same-filled pages. It is used in zswap_shrinker_count() to
> > scale the number of freeable compressed pages by the compression ratio.
> > That is, to reduce the amount of writeback from zswap with higher
> > compression ratios as the ROI from IO diminishes.
> >
> > However, the need for this counter is questionable due to two reasons:
> > - It is redundant. The value can be inferred from (zswap_stored_pages -
> >   zswap_same_filled_pages).

Ah, I forgot about this. For context, nr_stored was originally a
zswap_pool-specific stat, but I think Chengming has pulled it out and
converted it into a global pool stat in an earlier patch - yet,
globally, we already have zswap_stored_pages that is (mostly) the same
counter.

Might as well use existing counters (zswap_stored_pages) then, rather
than a newly introduced counter. Probably will shave off a couple
cycles here and there for the atomic increment/decrement :)

> > - When memcgs are enabled, we use memcg_page_state(memcg,
> >   MEMCG_ZSWAPPED), which includes same-filled pages anyway (i.e.
> >   equivalent to zswap_stored_pages).

This is fine I suppose. I was aware of this weird inaccuracy. However,
for the CONFIG_MEMCG case, it was kinda silly to introduce the counter
for per-cgroup same filled zswap pages, just for this one purpose, so
I decided to accept the inaccuracy.

> >
> > Use zswap_stored_pages instead in zswap_shrinker_count() to keep things
> > consistent whether memcgs are enabled or not, and add a comment about
> > the number of freeable pages possibly being scaled down more than it
> > should if we have lots of same-filled pages (i.e. inflated compression
> > ratio).
> >
> > Remove nr_zswap_stored and one atomic operation in the store and free
> > paths.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Any thoughts on this patch? Should I resend it separately?

Might be worth resending it separately, but up to you and Andrew!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

