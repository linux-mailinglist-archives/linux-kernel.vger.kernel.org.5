Return-Path: <linux-kernel+bounces-29294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA3830C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B28285D67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B77322EF5;
	Wed, 17 Jan 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2TtbWGw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C022618
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514062; cv=none; b=qixQNam+1+zSIVS24e15BxQaOwTiGLtb/F2VGgiZ+EYHJuo6hA3UOTpkOIYon2Ef0BxiNzSq8d7aaXV8EfDwoUGrRQaQkFkVvPtv+SDWYyp3p4/eCUbCUQl3ETIzwEoVAVfWi9HBo7EtZ072ywk5w+Ma0kdOHeLKxiPHmJ0XHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514062; c=relaxed/simple;
	bh=A0F3r7n/g83EA1H/XZmI+Nc8UIvkJ4IJdIeOlCXrn+Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=QO5Jo8efgnUZifIckYjdyErXyDSV5WeIUQzKs8NmAcwiwRyMYCczYIKt6EEeXKU6TWl/E98VNiftb6AzHMthGUgCdLOiLKNOehVmCtXDpNxLsGpT80e7Eo7Gro/kLVWqYyy6hWHmLwyfWV4EZjJX5RWwwCODuNaFYWo4JD2dMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2TtbWGw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2d6ded84fcso344631666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705514059; x=1706118859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6lyJQcXNI4nwRqnHEy+x5gALQye4rU+3fOlOl+RxMc=;
        b=l2TtbWGwnONYtVBMTbBuUGV9/1YQUKMPRrpFRsSSEaZZNm6zD5y6a6jru9v0gclXPs
         HjrI82ipuQn1S/7Xc/9tWVzCedXbnxdEj2uOlBLPfUDJX6vvHD4ZNwvi1hfTUPbzoOs7
         g6qnSg2gAGmfQMqmdTapfGgp8TLdU7XU9/S1qw35xzGrorpBOQtp9pcRCBfvgcHGzMWk
         pHIgDu3hvW7bICOK5HicdQ+MrNC1lx4P/ACh+EC1yIsROzvtbz3Foy2N8mvXeAtndpqz
         MD9vwb7tLrHANy+BXt/ztFCDEm9QWCAe7SV0KgSNgcFro3FdKJk9zzT+lUnDHm+F3HKr
         Lcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514059; x=1706118859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6lyJQcXNI4nwRqnHEy+x5gALQye4rU+3fOlOl+RxMc=;
        b=Z155aV4rL6GLlyAf47vCCObeMsBQoep+wWOT10hRVq6YuaawQy7seMGbEk5FsiQqu0
         RKlcsqgVuCMeXx91ekqhXwkKn+IPxHS+KRigy/6M2w1CGxseRYub940+F2OjD3fW+R2r
         zqdRFwQiV52A5OXA+svBw5/DDe5AP636Nt81KZ4eDsrB52+tuh6Bdwtjeoghl0Sl1h/Y
         wy7XpuwsXSx7Wxm/Ekd4yCYHWGoI1o/cNWutnQ+3n7JC2LCenD/8WjYgozGyBe6KyYjh
         DIjGKueXg3NCPNpr0E+g6q55J7azwc0TJnDs+GSB00jqG/F0oTP0jQTS1ttV8psyNS/w
         pFvA==
X-Gm-Message-State: AOJu0YywvX2g1bxbvtCB+DGgn7OoVo8Yn2hr0iKgL74Gf0nNwkizr5Jv
	mkxko8wwsIrYnv8pR+2msotKYQb+Ra4Y7U20kGJzTOM5lvYr
X-Google-Smtp-Source: AGHT+IG7YjwVaeNRNZlLo1B3GMHbNDmE1p4VHy4Rz7ww31DbvMy3c5rfFeDIzdxrih6Evy9y0PQ5f7cCdS85l8HSaRo=
X-Received: by 2002:a17:907:c307:b0:a2d:e3aa:48e3 with SMTP id
 tl7-20020a170907c30700b00a2de3aa48e3mr3730280ejc.95.1705514058955; Wed, 17
 Jan 2024 09:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
 <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
 <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>
 <CAJD7tkbfe5duVhN7kJhkQZLCbK48giVZ8LBx=RQDmp80oa2FDA@mail.gmail.com> <CACSyD1PERLG_68OXwzuGH-cqOuS1k8N_fE5Xu-KACZ34UYephw@mail.gmail.com>
In-Reply-To: <CACSyD1PERLG_68OXwzuGH-cqOuS1k8N_fE5Xu-KACZ34UYephw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 09:53:41 -0800
Message-ID: <CAJD7tkYu5Nm4DETjE1DvwuhAq=C6V=Pv9dx9W_oBw=ihwwTuQg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:53=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> > >
> > > Please forgive me for adding additional information about this patch.
> > >
> > > I have finished the opt for introducing a folio_add_lru_tail(), but
> > > there are many
> > > questions:
> > > 1) A new page can be move to LRU only by lru_add_fn, so
> > >     folio_add_lru_tail could not add pages to LRU for the following c=
ode
> > >     in folio_batch_move_lru(),which is added by Alex Shi for
> > >     serializing memcg changes in pagevec_lru_move_fn[1].
> > >
> > > /* block memcg migration while the folio moves between lru */
> > >         if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(folio))
> > >             continue;
> > > To achieve the goal, we need to add a new function like  lru_add_fn
> > > which does not have the lru flag and folio_add_lru_tail()
> > > +               if (move_fn !=3D lru_add_fn && move_fn !=3D lru_move_=
tail_fn_new &&
> > > +                       !folio_test_clear_lru(folio))
> > >
> > > 2)  __read_swap_cache_async has six parameters, so there is no space =
to
> > > add a new one, add_to_lru_head.
> > >
> > > So it seems a bit hacky just for a special case for the reasons above=
.
> >
> > It's a lot of plumbing for sure. Adding a flag to current task_struct
> > is a less-noisy yet-still-hacky solution. I am not saying we should do
> > it, but it's an option. I am not sure how much task flags we have to
> > spare.
>
> Got it.

Actually this won't really work. Writebak can be asynchronous, so
there would be no logical place to unset the flag.

