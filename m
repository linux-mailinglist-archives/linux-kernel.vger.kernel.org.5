Return-Path: <linux-kernel+bounces-18996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4487E826644
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0341C20A9C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBE41173A;
	Sun,  7 Jan 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PShM7kIL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673F11725
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bc32b04d16so61176039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 13:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704664795; x=1705269595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QflLNr8qUPLYDQm1nMipG0gtGejOsDcOedvIO2RscbY=;
        b=PShM7kILkYWuZOSQiEuMe1bXV/eIsw+A/aauUue6+q0Pzl32x8C5aOxEKefiTbSk0e
         4pIdJhsuMiNUP0T9qQaYdf/06xeYFLxXfcB0YJsZ+/MNjQ2cqZI9V7vPYh3Mn8VUZwwR
         Nwrd1AcadE9Qb5u+a3DKAJxH+nK47ZUx+/vFpGwMPJ7Bj3rko3gRKNcKZxtmpr9XsXqO
         CyZz/beezyJJQl0AeWflrpSw6VmTaoSdPQxbwp0ox/XmS4u7n9tgA56ZD271In3c75GL
         9ULB9Hw8dm9Yz9qhDuwMhFFZIG2ukmFFBPJSM5UXbNjuB2vj6auuFqrdNWRoH8Z3Us+L
         zymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704664795; x=1705269595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QflLNr8qUPLYDQm1nMipG0gtGejOsDcOedvIO2RscbY=;
        b=gNvHQNWamlZwkieOoc+q76VcO8mqQBArSwXwOq6o/gBfu9WWgpo6l7UPdyxCGn0v1I
         sEA4G8R4oeqvscVUbyhe58/y6DQ9yx/VOpGQe7o42DeX2a3QemdL7KfTHy/Mgp92MjoO
         S+zul89ZGbrvh4Uxm35EYyfoPxKVQn2umivAkB6Yorw5GrGoe8Ldfsnl7clG3BUkchHT
         a4Q8rJUQ4CwkIRB2m6jhtXHHb27JwLZE2CfxwJ/4SDrkCbr+Mx0CZaDuPPWUAYld52ic
         +Ropwp7h1AAdKQTF9uMsQMEPgW6MNdr+rzsAfazdBvt2KQ2wjW3p8L+MxANLoLxdtGbR
         yPFw==
X-Gm-Message-State: AOJu0YyAi+AvERmiC0QpU/rLVs3BG1yUKhUgyWZ/rUkfCBGyW8hEbHLU
	uFymhltfqS6so00rANtDGhod+7OGpl96phYftA8=
X-Google-Smtp-Source: AGHT+IHCrw2oJmFjlizc6AVJhAHYjxiof3mCqk0Ct0Ac61iZaCu1g+JrHfShy8PJPny/44YsrgKQsg3p+87z1QeI4s0=
X-Received: by 2002:a6b:e312:0:b0:7bc:1bf9:fd83 with SMTP id
 u18-20020a6be312000000b007bc1bf9fd83mr3210179ioc.3.1704664794775; Sun, 07 Jan
 2024 13:59:54 -0800 (PST)
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
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com> <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
In-Reply-To: <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 7 Jan 2024 13:59:43 -0800
Message-ID: <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 1:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Fri, Jan 5, 2024 at 6:10=E2=80=AFAM Zhongkun He <hezhongkun.hzk@byteda=
nce.com> wrote:
> >
> > > > There is another option here, which is not to move the page to the
> > > > tail of the inactive
> > > > list after end_writeback and delete the following code in
> > > > zswap_writeback_entry(),
> > > > which did not work properly. But the pages will not be released fir=
st.
> > > >
> > > > /* move it to the tail of the inactive list after end_writeback */
> > > > SetPageReclaim(page);
>
>
> Ok, so I took a look at the patch that originally introduced this
> piece of logic:
>
> https://github.com/torvalds/linux/commit/b349acc76b7f65400b85abd09a5379dd=
d6fa5a97
>
> Looks like it's not for the sake of correctness, but only as a
> best-effort optimization (reducing page scanning). If it doesn't bring
> any benefit (i.e due to the newly allocated page still on the cpu
> batch), then we can consider removing it. After all, if you're right
> and it's not really doing anything here - why bother. Perhaps we can
> replace this with some other mechanism to avoid it being scanned for
> reclaim.

For instance, we can grab the local lock, look for the folio in the
add batch and take the folio off it, then add it to the rotate batch
instead? Not sure if this is doable within folio_rotate_reclaimable(),
or you'll have to manually perform this yourself (and remove the
PG_reclaim flag set here so that folio_end_writeback() doesn't try to
handle it).

There is still some overhead with this, but at least we don't have to
*drain everything* (which looks like what's lru_add_drain() ->
lru_add_drain_cpu() is doing). The latter sounds expensive and
unnecessary, whereas this is just one element addition and one element
removal - and if IIUC the size of the per-cpu add batch is capped at
15, so lookup + removal (if possible) shouldn't be too expensive?

Just throwing ideas out there :)

>
> I would cc Weijie as well, as he is the original author of this.

