Return-Path: <linux-kernel+bounces-150042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5E8A9982
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93497B21A16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40515F3FC;
	Thu, 18 Apr 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWMm4riq"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C915EFD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442172; cv=none; b=jXl/9EK0G5bXlzu/jGHcapLekg5i9G0H7qylMKKXpvEswglc85m+K/nnNT+AaXqCJIIxa7Vi9967lgcBRCWfCZ9/XRyg5F/QWnmqX8MVhnAB1tmiMxAVyCzEklmzo4FUQpk33Rf6VXbN3Kmkz/+peaAbnaVgd4V5DInUiyglK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442172; c=relaxed/simple;
	bh=XXCqubAze/7WPDWGsGwFlxCvznCl8HkJMlTE0+n6qdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxt6GzKeAxYOQ2d7+3+c+pj0NxThynFM5dF+apFI+jabryy076KnkiTE6gVFP3p/Kt8wKbwR5GS/hKhgCmY95wpIVBdRNOyz6mYLsZcg304IJy/McTyl+1LFuGYZMDgbcl7B/zXuyGHNm+a6yj/HJ1zhtHULfh1eA5qJgX9uG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWMm4riq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so700246a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713442169; x=1714046969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5K3W4xG55U9XN1pFNNqQImuxOw6l00UI+Hr/SOLhkU=;
        b=WWMm4riqRSNezkqWp1OQoSQetxkQAqgwV8XKBSRCknta19b9BMQZYjOKwslBQRtpH3
         IoV+NIKqf6KpWtkLJruEo2zDzMvThfFqBjkwkf6AZYHgOlZFfbjdwk+S1vKGRMuYAqCx
         vOjkQXWRkOtuFZQWT8vjhyLbP8gLlATfkBuJVSS800kym5QbWwKLasq/S5Q38a5Qum9z
         TI4XtUi6n3kWOFmguDits5mAkpAt4006Lt1ZPGwPztoPLwSnRWrLKEV3wb9bFElYA89l
         wk9LNj55cmlPfWvHyhDRLufeOdIvEGi0WFcf7wsoYVfB2CYs2rXsVzdKjNe815A7T/j7
         BVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442169; x=1714046969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5K3W4xG55U9XN1pFNNqQImuxOw6l00UI+Hr/SOLhkU=;
        b=pMbXFZtsT8nLcR3ZiKvVpuF/mNvLrnKVSLVhiUjIP6kRiCpUfS7f2K4ziCwUIjomCe
         2fmsewciYgrgZBQvvjojzVCMhsGzVXPE4g/ftRvtSL9n4d0TEDl0jwGdJtqCYHKZf4cd
         qyohoAEMG36Vjo5oaeTplIrkH1A1Gzs24/tCCg+oejvBlOyRuiWCcXW+3pNaeGQXczDD
         VfOSfJVJDQd/1PhOgSnysxrBiOP2L4MB8ood6y7hMXw3Egv0KNYM3oyzfG4Dav1yQMDK
         nIESLxcjeZMLN/8aUc+l6DPeSU7Tm4EtdXBdPRtwi3p16GsB6G7HdD7Hh5E178VIHDol
         kq4g==
X-Forwarded-Encrypted: i=1; AJvYcCV6R2hL9YX7DD9zsQQ9KEBVcSI7gwAwWru8KVJnSK3qyuqgDs311YvLwuMGE6f1DBSUK6mROc0xeep+qCt9wG7lCNKBpoIrhXIhZNZj
X-Gm-Message-State: AOJu0YytJ4V7g/RzG9hmdc5HZswUQZnB5HYBA8EdxgUoolEzCKJyTq1g
	9wEaMvuoAs4fzDwB2dD1Beks1HsYUo2/l9PsJKXE3GjufNsxKn0NPyfvDW9OTXf9+yk3z3+8flm
	UIc+RB5PmoC4h385COtuwqG053+c=
X-Google-Smtp-Source: AGHT+IGViHTeCrergrz3VPH5VQOSjbayGlXq1x3tymtBxOJ652N7TE6Z9MtYTg+mOkfMnAW4LfAcpyShPf4x+ggcTN8=
X-Received: by 2002:a50:d7cb:0:b0:56d:f00c:2b13 with SMTP id
 m11-20020a50d7cb000000b0056df00c2b13mr1503904edj.32.1713442168920; Thu, 18
 Apr 2024 05:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418105750.98866-1-ioworker0@gmail.com> <20240418105750.98866-4-ioworker0@gmail.com>
 <c73423cb-3288-47aa-b389-22566e883db7@redhat.com>
In-Reply-To: <c73423cb-3288-47aa-b389-22566e883db7@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 20:09:17 +0800
Message-ID: <CAK1f24=ZVJ=7Yp5CFzO2kpphexkNuKryWMD-fjhTpLeXSnrETg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] mm/memory: add any_dirty optional pointer to folio_pte_batch()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:00=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.04.24 12:57, Lance Yang wrote:
> > This commit adds the any_dirty pointer as an optional parameter to
> > folio_pte_batch() function. By using both the any_young and any_dirty p=
ointers,
> > madvise_free can make smarter decisions about whether to clear the PTEs=
 when
> > marking large folios as lazyfree.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   mm/internal.h | 12 ++++++++++--
> >   mm/madvise.c  | 19 ++++++++++++++-----
> >   mm/memory.c   |  4 ++--
> >   3 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index c6483f73ec13..daa59cef85d7 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
 pte, fpb_t flags)
> >    *            first one is writable.
> >    * @any_young: Optional pointer to indicate whether any entry except =
the
> >    *            first one is young.
> > + * @any_dirty: Optional pointer to indicate whether any entry except t=
he
> > + *             first one is dirty.
> >    *
>

Hey David,

Thanks for taking time to review!

> I was also wondering if we should make that function return a
> pte+nr_pages, instead of only nr_pages, and then simply have the
> function, based on new flags, merge data into the original PTE.
>

Nice, good idea!

> But let's do that separately.

Yep, let's do that separately :p

>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks again for the review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

