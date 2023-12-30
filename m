Return-Path: <linux-kernel+bounces-13308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D482034B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A26A1F23080
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE115B7;
	Sat, 30 Dec 2023 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaDiNJT2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE81367
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so342934239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703902158; x=1704506958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8XkI2HPUOqTFI/0Hxh9G2qsgJP20uZIE0REz4LTieY=;
        b=TaDiNJT2Yuh0k91ITq28Pl4DcG7xhn25BXc/WIoiVNLD4SNHWQK3g05GnQhzKgzAjQ
         TfgQFBa0CHFGMmTSCzBkBAvzavkFriOFqO+MsDhBSCm57O9Gb3s+/B2g64TtBUF+DUWs
         PflyqR8sFXrn2SnIKqzZ0Y75fjBRlJP/r9wmvaWaTYVHvlY/ETWbhgicH+Eg2N+d4qj0
         TqzLvdOo9YESveog8YT5ZPMwF6b1wLaif6sPQjED5xkYBXRRfJ65NrX/lvOnORa+bp39
         gk9LBy2PML0zZ2ndslpkQXAjdzmvaSISjiGIhIlzOTxc1Zr8t2Gw4L0pID3pmbSlgSuh
         yhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703902158; x=1704506958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8XkI2HPUOqTFI/0Hxh9G2qsgJP20uZIE0REz4LTieY=;
        b=bY2hHVse3//VvmsutIcoHK6drs3Z9DDapWclB2TNXNK8JiwNBNLnw1HZx9Jm/QINnh
         0LYkc/H4z8YLQWiPjx2r7AnapLy/oy2z2I/TEdfirVuIAvwBhHsgoSTO5b1PzA3vRZG5
         fdsybPoHBGFjNAA9RqHlQINX2ma7s55ogutHmcjcX4WYVszj8CQKn4umE1mj1K/PQCvI
         ydlszQJmJ1M6dwvtZUayf18ENXyS19fWwtNBW8kaJYCuJVTTIkP9xQhmFNBJhKLfK8qi
         geEY8l9sG0cyDB4lWm7OvA/SZCHe7JIMQGRGH7oBurNi64W64U6OnZRqwyHkiVTvT2r0
         74Zw==
X-Gm-Message-State: AOJu0Yzw8av88PpvyT9JBGX8RViy6mxxKXzVaUz2AKSLcG68Tu7WrwDn
	IbLlKKsnGUUsIiyQjZVICkswDvHOT6zptLU9FQs=
X-Google-Smtp-Source: AGHT+IF5IILgrO00XL7bX7RKZqUK08UZl0cQpfTyJEyxfIfytN2lx3xH2ltYaLpdzjT1STmA5+mEtcGkgeGA+jOTFpE=
X-Received: by 2002:a05:6602:1242:b0:7ba:eb91:982c with SMTP id
 o2-20020a056602124200b007baeb91982cmr8180824iou.26.1703902158276; Fri, 29 Dec
 2023 18:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 Dec 2023 18:09:07 -0800
Message-ID: <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix the lack of page lru flag in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 7:27=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>

My apologies for the delayed response. I have a couple of questions.

> The zswap_writeback_entry() will add a page to the swap cache, decompress
> the entry data into the page, and issue a bio write to write the page bac=
k
> to the swap device. Move the page to the tail of lru list  through
> SetPageReclaim(page) and folio_rotate_reclaimable().
>
> Currently, about half of the pages will fail to move to the tail of lru

May I ask what's the downstream effect of this? i.e so what if it
fails? And yes, as Andrew pointed out, it'd be nice if the patch
changelog spells out any observable or measurable change from the
user's POV.

> list because there is no LRU flag in page which is not in the LRU list bu=
t
> the cpu_fbatches. So fix it.

This sentence is a bit confusing to me. Does this mean the page
currently being processed for writeback is not in the LRU list
(!PageLRU(page)), but IN one of the cpu folio batches? Which makes
folio_rotate_reclaimable() fails on this page later on in the
_swap_writepage() path? (hence the necessity of lru_add_drain()?)

Let me know if I'm misunderstanding the intention of this patch. I
know it's a bit pedantic, but spelling things out (ideally in the
changelog itself) will help the reviewers, as well as future
contributors who want to study the codebase and make changes to it.

>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

Thanks and look forward to your response,
Nhat

P/S: Have a nice holiday season and happy new year!

