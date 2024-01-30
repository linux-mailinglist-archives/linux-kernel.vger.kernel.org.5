Return-Path: <linux-kernel+bounces-43701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECD8417F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148FEB21E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71FF2C857;
	Tue, 30 Jan 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFrtjSpt"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8111E89A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576289; cv=none; b=SQnRCjVxAyKiXsSr2v2Lr6BvOZbMsMO6SaRmgNjfNgQwD2n6kukHx55UkSExnganX29t9gphOcD/WM+JRSmcHehw2+A4+098/JEm/2PtsHILYPdCDTGsBIfqoYKrKDWxgBZvwaJm4rGpjlMQuAZtk+ZYx9ggSIFdLnurf/iNsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576289; c=relaxed/simple;
	bh=vehqthCnPjetgrYtj1oh6HOMUQNvBhhq4E/y9/quWI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X9CPHi8tctz+zRQi89DyKIHFbuBUw7Xb7wdps2GfHsmcPxkcAk5kx81niD/DTUH3yHgoCeRhYHfsYifJ/kokkk2K+O846D3C2NZUsGv3y4C55LRKvLJq9kPWzItiCc3yMc5DjiGQLLy81kgEyE50mtVz/JtwL5C54tgQdKJRLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFrtjSpt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso70641737b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706576286; x=1707181086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vehqthCnPjetgrYtj1oh6HOMUQNvBhhq4E/y9/quWI8=;
        b=bFrtjSpt5UamRoEjZMFtgYUlBt3LCN/qxtpegnfoh1T6t58Zon7MA03q4ezavNNwX5
         EeWab4NLbwcYiTLH1D+nAfAbTy3MGOHPf990PGXPzKSK2zvJ8QyOCS3L0KDGwS4kRKY4
         zPjFc14Zt6JkZD9dMdR+jGUjwig+RA1luMfXIhQ1Y32KqCNztdy6MAKDIgU9dEt/Ntmv
         pDsvPJPy9t1kWPu8LULxwR1yqggzrM4gPjzIu0HxtUy7f/f9Wtq8QrIf3RfvoiNtOmnA
         dXbuOvsA+IlOzPgEbq2ZUQMmroU2eingzswY3bAFJixxWj0J370XJdMLinZhqYRovyEX
         +urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576286; x=1707181086;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vehqthCnPjetgrYtj1oh6HOMUQNvBhhq4E/y9/quWI8=;
        b=ENwwh2Ws/uUUoaFh5ASeMityyIebgVhlkWwMhxhYKDw4cVzeLbytJO4vEdWnwpyoQb
         7r/2mv77LLGLMCBqgUsyGve5O/E2E0rXc0uYQ4kL5rmgPpHtAao+OeYmZIZUniyz1G/k
         20lqQiVi6asRmsGhQv7rUy1+32k7U/8xImtzD/0S2tWnWagVOIDN4eVK/35WbNb0CfNJ
         JYX3h4pF52JjFfm3KFOoManD03rfIzXjHZMV1zUVbepyyMGm1HNYcy9LWo6osHBCF7lB
         dTU1lHitK3hWF7Tr4qgJQ7wMghn40RaT6tEdB4JwZuDl2mGrzvH4LsPNCAO+hfY/qJ4L
         A8jQ==
X-Gm-Message-State: AOJu0Yw3+OSgWRvwbYAUjPoWNz/gyl/ZApJZ9/r2j4gdKBEQxMH96L2i
	LO5wAOn2No8DOd3M1bMqc0MgnNcdYGkd5kOrxXobunWJ97Y9s1ZEJouITyN9w6zlBceBmOYPZya
	m0/tVgrs9qp5F5S1OEg==
X-Google-Smtp-Source: AGHT+IGdAli7RtKs+PFrYkjZWruzcPcsuBDP1FgmOuBAndXpnE1k73fgPJtOJy0F2aOVgpwyHlBYZlAUCxWUrWET
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:38a:b0:5de:9c9f:3ee4 with SMTP
 id bh10-20020a05690c038a00b005de9c9f3ee4mr2266697ywb.6.1706576286454; Mon, 29
 Jan 2024 16:58:06 -0800 (PST)
Date: Tue, 30 Jan 2024 00:58:04 +0000
In-Reply-To: <CAKEwX=MxRTupSoYbnr14wTurbBhJ7KipV3YuEofab2JJxsk3cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-1-b10479847099@bytedance.com>
 <Zbg-INqi9oMUqJaW@google.com> <CAKEwX=MxRTupSoYbnr14wTurbBhJ7KipV3YuEofab2JJxsk3cg@mail.gmail.com>
Message-ID: <ZbhJnIQRjTn9ME1k@google.com>
Subject: Re: [PATCH v2 1/3] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 04:12:54PM -0800, Nhat Pham wrote:
> On Mon, Jan 29, 2024 at 4:09=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Sun, Jan 28, 2024 at 01:28:49PM +0000, Chengming Zhou wrote:
> > > LRU_SKIP can only be returned if we don't ever dropped lru lock, or
> > > we need to return LRU_RETRY to restart from the head of lru list.
> > >
> > > Otherwise, the iteration might continue from a cursor position that
> > > was freed while the locks were dropped.
> >
> > Does this warrant a stable backport?
>=20
> IUC, the zswap shrinker was merged in 6.8, and we're still in the RC's
> for 6.8, right? If this patch goes into 6.8 then no need?
> Otherwise, yeah it should go to 6.8 stable IMHO.

For some reason I thought the shrinker went into v6.7, my bad. Then I
guess it should only go into v6.8.

