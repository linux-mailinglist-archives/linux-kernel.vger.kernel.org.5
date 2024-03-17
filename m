Return-Path: <linux-kernel+bounces-105337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5E87DC66
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921EE1C20C86
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C010417753;
	Sun, 17 Mar 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bjik4FoE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BD171A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710655974; cv=none; b=rbne6U1ZNI/PW8papV4C6QsXfkYJdich4Ezp2iXqYcXb4NPsk1XgKx2t9NyjlGhHLidIk37UzgGETUi17+DiB/mf/ZDk0aK8YWMU4tkfqYqboEyUT/wJQwQQPZm33MjFyKaoj/+54MbW0qK3MsxCaiAqcccZQHse1LlW1l4htqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710655974; c=relaxed/simple;
	bh=nSvcpxIehmX6l6cyameIDwqMlQP0wKA3hl900RFWGe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdfvG/bB1+P4GvVo9QxC01Zi/wM1TBFeQ2jq1ZvF8d9o6CzRHPwT+euyvhhzdr5fEW2S0ryGiYY5c/6EeLq62aPSAfbO5Q40BJHE8ACitkRQs20DOw2jAI19igo/bhFTL9f1F+OwLR1E8hTMcfNPaG1nnNvM92jhTCQ+m0c/rwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bjik4FoE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46ba1a05e0so4399466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710655971; x=1711260771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1/EUrAw0DouFxLVGsQPEl2eEcK2Kdi+7MtyL3HOCTg=;
        b=Bjik4FoE9t+VuELwMhQ1qPYBRFAQ9mRidR+fDQfqw1QJWIANyZQVS0D8Dq+CReCwPa
         NOAC3Z2fBkpg3byqrMQEsWai1nd7uNsKD0uxrqiJVxeqczw0fra1xRrZ91UGLppctdvN
         rLsH2MYut9bfHYfOz4kTZIxTdBHJ6hIFM5n+SZXkCPv2TaRkjRnxUJ41zMnxh9Kl5j06
         G40Sr+gJiZAgZ6Zmor56AAug1qb+7Ie7zpChrtAy0hhnjn3jJKc2qDFXZvKAkpbrJ4rq
         rtptpHr2yIoCOmN4/yR3DhepGlt5rDcuieHXKI828OPDCXmGnGUE/t9GdRtBwCzePG9d
         SSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710655971; x=1711260771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1/EUrAw0DouFxLVGsQPEl2eEcK2Kdi+7MtyL3HOCTg=;
        b=Lftr/Dfa2IiKncqz7nq63iVd6bf/oEK+VZxTugassQxMVwe7m6MT/BnWj/phN3Pwx2
         tOhxAvXW8N10oELGzXbrRZQkYtQP10aC4VR+SDsIxtHuhDkcGBx7IrU9gii7j3BUscCP
         9vXpmBHm0y3nv3AgZDNH4sc/3Hqk6XudlHPjZCbsWaLLhTH+tL0dMOcCF1K9488I8yfr
         FPLBStNH1TxlEeeCxL5Ou/tkHg/ts6mR03v+TAOc3te7UzVko3T0zGzDZQuCISUWmYyX
         WonpX7HEZffIeMf2iNTzkKUr3ctVzkw/L7YeHmO8wVdZ1oWlV0mcotYRC/CNJ4AmnJgS
         lZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXIXpGlzj6wZNjJwJiWdRM1q1uXYNyyURdqCMzCMFQA2H0qtL1CwvsXLNY9J9YVYxYWEtTAfaFsknuHecrz9QWkdvZS/MnwjoUObPcj
X-Gm-Message-State: AOJu0YwYXv0GwpwaH68QL/1xH+ddHTIL4/1Q2jDOWErGFhNXJvTZFcVn
	Q5ex5pUdIxijXUnmjSuixvHnEU/LahC9fiQ7W4i93orjzsyl3qDa84Dg1Hd9dhs2e7IOWOxqqBx
	g3Tx8u5S8sJhiQGRnr2d6SDy77Dy1RG8lt2+6ixy+kuz0sIQHngPn
X-Google-Smtp-Source: AGHT+IGRePtBL60zVIJk36iKwEufwRgi6VaTp5KLz2bpTexL+aRZxvhL0SaG3Ljf5ChlRghwPUywlFW4sZ7o203biU4=
X-Received: by 2002:a17:906:6d46:b0:a46:b8a8:98e9 with SMTP id
 a6-20020a1709066d4600b00a46b8a898e9mr192482ejt.25.1710655970494; Sat, 16 Mar
 2024 23:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
 <CAJD7tkZH-mU_7NMMBAS4nyfyWKKK3tSdQisVQ5iRqckqHouoJQ@mail.gmail.com> <20240316133302.GB372017@cmpxchg.org>
In-Reply-To: <20240316133302.GB372017@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 16 Mar 2024 23:12:13 -0700
Message-ID: <CAJD7tka4Cemq-1gkfB5fZ0cmKZFX76ZYjAsFQC_Pu_XqzhsL3A@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
To: Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Barry Song <v-songbaohua@oppo.com>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 6:33=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Mar 15, 2024 at 06:30:37PM -0700, Yosry Ahmed wrote:
> > [..]
> > >
> > > @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
> > >  insert_entry:
> > >         entry->swpentry =3D swp;
> > >         entry->objcg =3D objcg;
> > > -       if (objcg) {
> > > -               obj_cgroup_charge_zswap(objcg, entry->length);
> > > -               /* Account before objcg ref is moved to tree */
> >
> >
> > I do not understand this comment, but it seems to care about the
> > charging happening before the entry is added to the tree. This patch
> > will move it after the tree insertion.
> >
> > Johannes, do you mind elaborating what this comment is referring to?
> > It should be clarified, updated, or removed as part of this movement.
>
> Wait, I wrote that? ^_^

Well, past Johannes did :)

>
> The thinking was this: the objcg reference acquired in this context is
> passed on to the tree. Once the entry is in the tree and the
> tree->lock released, the entry is public and the current context
> doesn't have its own pin on objcg anymore. Ergo, objcg is no longer
> safe to access from this context.
>
> This is a conservative take, though, considering the wider context:
> the swapcache itself, through folio lock, prevents invalidation; and
> reclaim/writeback cannot happen before the entry is on the LRU.

Actually, I think just the folio being locked in the swapcache is
enough protection. Even if the entry is added to the LRU, the
writeback code will find it in the swapcache and abort.

>
> After Chris's patch, the tree is no longer a serialization point for
> stores. The swapcache and the LRU are. I had asked Chris upthread to
> add an explicit comment about that. I think once he does that, the
> objcg situation should be self-evident as well.

Perhaps it should be clarified that the swapcache on its own is enough
protection against both invalidation and reclaim/writeback, and the
entry not being on the LRU is *additional* protection on top of that
against reclaim/writeback. Right?

>
> So in the next version, please just remove this now stale one-liner.

Thanks for confirming. Chris, please remove this comment and update
the comment Johannes asked you to add as mentioned above. Thanks!

