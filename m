Return-Path: <linux-kernel+bounces-12382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53C81F3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7B283F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A81FDD;
	Thu, 28 Dec 2023 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQLuvpSL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7031FAB;
	Thu, 28 Dec 2023 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dc035ee106so690368a34.3;
        Wed, 27 Dec 2023 17:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703727811; x=1704332611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hei+GXxJvlu+ildb09sPXB38GuVEshb4LRHlphEdS3A=;
        b=OQLuvpSLeJD3aZDZpzSrTkqvqjap1ppdnykdrvWgXYEGO68S2tqVXRpJ6QEYStR9S0
         0ZBDTmSBhS6FQCansePX/4Adwpb6jEUf3xKKrnJ5SIu4n7dNpjt2/e7VqY7WmOhpm8Nj
         PY6iKHrVG8yioKgR9Mi6lDWAYfqGJ6JRciNsbbmMalFSM8iMrOrz3oozD+EMt8T/i0UW
         NJWPCucZt/wbAXyBOZB1+DT9ovTAzFVkWVJ/UTv2aXH3NlPqa1QUpl/YBgnU2a7kaaTs
         MQvbZmxS27imq+65yM9Mz1PV0ylL9bOc+JJIg+7EutDWQk979u+O0WUxFTqFHD/+SgGf
         0uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727811; x=1704332611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hei+GXxJvlu+ildb09sPXB38GuVEshb4LRHlphEdS3A=;
        b=HVwGN4QapjRiH7NX82V83TkXo7eV8c+6m1duhok/OudPNniIUB3V8Z1fN+ULWVFHkQ
         Ko7ZrfZbdPzq3AUbFrpdFfVFDV+qlemHqbxSyhk6PF/KCsit7z31T8D34EyscEu3QBHq
         tpMB7Rdpgdoyz0NO4RWfmFabkFihBwG5lNkDHfKReX8viC/oRxhAy3pXxzCBrL1pa49z
         mFUt+741gNqjYR4dLf+62qOPDCxDeJp65ShK52h2KVx6xa7EzS+fR7cPHeZ8j6CKV96y
         Xv6LBd/eiRMj9F46OdnYhyWDBi35UNRid9Ip7n8LXoCPgtKOb2UEa+gR0ljxGSSqAhn6
         re7A==
X-Gm-Message-State: AOJu0Yw5szWkkPHg7jJO1ov2/af5YTrUW4PkDKR4S1+lWHarA0iGDJnF
	uU8DuQGpGjFu9/P4qp4HAaD7kDoYCwKdL99h3x4=
X-Google-Smtp-Source: AGHT+IHIrXuNoTOyf0vXQVoAlS/l/sO0BnOi0DktVh57CVIVcCugwqoJuiS/IL0wQTtUGbgSoAC13R+Zf82CkmB3nlY=
X-Received: by 2002:a05:6830:4b:b0:6db:ff88:80b0 with SMTP id
 d11-20020a056830004b00b006dbff8880b0mr2005999otp.61.1703727810688; Wed, 27
 Dec 2023 17:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
 <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
 <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
 <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
 <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com> <CAGsJ_4x31mT8TXt4c7ejJoDW1yJhyNqDmJmLZrf2LxMt7Zwg2A@mail.gmail.com>
 <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com> <CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com>
 <e464c55e-d03a-4df9-abef-5ece182d7a2b@bytedance.com> <CAGsJ_4xknGt5Q6vTKHdnqvXi7fKMORwXywurdN09G2uOUJzCSg@mail.gmail.com>
 <CAKEwX=PYK3hUzgm+qfs2sNU686RaE+_M3W4Zo_Q4mTMAgKaB2A@mail.gmail.com>
In-Reply-To: <CAKEwX=PYK3hUzgm+qfs2sNU686RaE+_M3W4Zo_Q4mTMAgKaB2A@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 28 Dec 2023 09:43:19 +0800
Message-ID: <CAGsJ_4zwd71VmDsErFG-2=V8aqP9dc2qO_hRNcHPj51=CfTJww@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 7:26=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 3:10=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Wed, Dec 27, 2023 at 5:16=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> > >
> > > Thanks for your explanation! Maybe it's best for us to return to 2 pa=
ges
> > > if no other people's comments. And this really need more documentatio=
n :-)
>
> Fine by me. Hmm we're basically wasting one extra page per CPU (since
> these buffers are per-CPU), correct? That's not ideal, but not *too*
> bad for now I suppose...
>
> >
> > I agree. we need some doc.
> >
> > besides, i actually think we can skip zswap frontend if
> > over-compression is really
> > happening.
>
> IIUC, zsmalloc already checked that - and most people are (or should
> be) using zsmalloc for zswap anyway. I wouldn't be opposed to adding
> an added layer of protection on the zswap side, but not super high
> priority I'd say.

Thanks for this info. I guess you mean the below ?
unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
{
        ...

        if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
                return (unsigned long)ERR_PTR(-EINVAL);

}

i find zbud also has similar code:
static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
                        unsigned long *handle)
{
        int chunks, i, freechunks;
        struct zbud_header *zhdr =3D NULL;
        enum buddy bud;
        struct page *page;

        if (!size || (gfp & __GFP_HIGHMEM))
                return -EINVAL;
        if (size > PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE)
                return -ENOSPC;

and z3fold,

static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
                        unsigned long *handle)
{
        int chunks =3D size_to_chunks(size);
        struct z3fold_header *zhdr =3D NULL;
        struct page *page =3D NULL;
        enum buddy bud;
        bool can_sleep =3D gfpflags_allow_blocking(gfp);

        if (!size || (gfp & __GFP_HIGHMEM))
                return -EINVAL;

        if (size > PAGE_SIZE)
                return -ENOSPC;


Thus, I agree that another layer to check size in zswap isn't necessary now=
.


Thanks
Barry

