Return-Path: <linux-kernel+bounces-10918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B08D81DEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089B61C21282
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0242DDB0;
	Mon, 25 Dec 2023 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAZkkzEE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84681D275
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so35162881fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 23:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703487735; x=1704092535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZUnhHuaOo0JGLLaQ+h3vJJc1TC7Ws8y4G2gxGHbkKc=;
        b=NAZkkzEEZqyvZ+sbWI50g1FL/QuGTT7YO+iNhA3q7Y1EDjkWWbxlTrC6RkEEmfPZ9U
         wL+IxK6AvwKnj0KRUI/n44OaH1PxPqELrJgwzc7trOSYDLzFVoi1ByXfeBofcA46/PZS
         e01xWfFeXYYSOmvcSyEaJGGAs2oIclbQ1+K1YWT31gHbj/2v1XLsjLqaRrPMrmsP6BfW
         WocK+feahmzArjWJUeK86AXh7NdSB+O8j8IBq7LE4dHovGEgakGN7wQydeYPJc4XFXLz
         Iv/Ro+58/StEFBraSmiqkn7T9WyzgKRIyoOJHSq0nY7aweby2J4hAj+J4PTK+19t/4vb
         1v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703487735; x=1704092535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZUnhHuaOo0JGLLaQ+h3vJJc1TC7Ws8y4G2gxGHbkKc=;
        b=IXaGQLCNQlCMO5gdODMtB7rUd5KJ3RpbKlwfQQx68I0m+zWrKW6wwPavBkeyMbK+C3
         MSI2ywCja7lWhgQpJCpRr6b17hjT1HxE+TD4DBI+wiAEQ5mqF9m7HqlLrq0UuTM8rnMJ
         jfgrtlmKP91MGFa1SIYJfGI8zhjS7IUMGw3oE5cl3tfDvO9YU+Rcwg6HF6v3WGM0bHfx
         1o2pW7zSzdIFUTEmwZI/1hyeUzDKmQGCV1NcVwjOlK74fmpZNuO2Mi7aasimSy5/DPrP
         ZOIk3oOgetIUff8HsdabNFxUZv+KdJkXB7NSKs8ty0M2r1tF/fiYNn7CFjGOPexcx9sa
         Ufbg==
X-Gm-Message-State: AOJu0YwnNxOd7WtbvAURyvth2xwXxOyYv9XR7xRSPETWGuO/9fE4VpeA
	YVtOsFn4zRYmpfog1uk1EyDAPBUhdBck75eTzAm88f9uPKtB7/Dc
X-Google-Smtp-Source: AGHT+IG0YTzceKLqiZZo43S76ZhfHngJL8Qyc+pA0ueaBmTIw3Si5AGxlQq+s/168KI8FIkvgEXAiWCAYwoG+zEOOdI=
X-Received: by 2002:a2e:9d16:0:b0:2cc:9817:6388 with SMTP id
 t22-20020a2e9d16000000b002cc98176388mr1732880lji.64.1703487735136; Sun, 24
 Dec 2023 23:02:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-3-ryncsn@gmail.com>
 <CAOUHufYOA-_MtFL-GoQouH0-KwQOLkh1RZKJ+90ADrhBfFeQsg@mail.gmail.com>
In-Reply-To: <CAOUHufYOA-_MtFL-GoQouH0-KwQOLkh1RZKJ+90ADrhBfFeQsg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 25 Dec 2023 15:01:57 +0800
Message-ID: <CAMgjq7CGYPNDL0W-1YGOkAs2BURhSKW=JhuMpC08je7RDOg6Dg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, lru_gen: move pages in bulk when aging
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8825=E6=97=A5=E5=
=91=A8=E4=B8=80 14:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Another overhead of aging is page moving. Actually, in most cases,
> > pages are being moved to the same gen after folio_inc_gen is called,
> > especially the protected pages.  So it's better to move them in bulk.
> >
> > This also has a good effect on LRU ordering. Currently when MGLRU
> > ages, it walks the LRU backward, and the protected pages are moved to
> > the tail of newer gen one by one, which reverses the order of pages in
> > LRU. Moving them in batches can help keep their order, only in a small
> > scope though due to the scan limit of MAX_LRU_BATCH pages.
> >
> > After this commit, we can see a performance gain:
> >
> > Tested in a 4G memcg on a EPYC 7K62 with:
> >
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
> >     -a 0766 -t 16 -B binary &
> >
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys \
> >     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
> >     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
> >
> > Average result of 18 test runs:
> >
> > Before:           44017.78 Ops/sec
> > After patch 1-2:  44810.01 Ops/sec (+1.8%)
>
> Was it tested with CONFIG_DEBUG_LIST=3Dy?
>

Hi, CONFIG_DEBUG_LIST is disabled here.

> Also, the (44810.01-44687.08)/44687.08=3D0.0027 improvement also sounded
> like a noise to me.
>

