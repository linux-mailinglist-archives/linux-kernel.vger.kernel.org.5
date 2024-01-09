Return-Path: <linux-kernel+bounces-20330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203D827D68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392301C21A54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC74698;
	Tue,  9 Jan 2024 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UudJMDjh"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB1259D;
	Tue,  9 Jan 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7cdef012c0eso689578241.2;
        Mon, 08 Jan 2024 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704771538; x=1705376338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKRSbrKS67RNdW5xwmhX/Uca0R/IdmheRC0aGIx8H7k=;
        b=UudJMDjhz+TqGReuU6W9dzmT9E0AQw6t6IdLnkIhD7w4FMB9jhdUBObQNWQCyBlflv
         XZjga2unC2xV7sD0E+LRYOWU4p/fXBiWEBGDzmDWkUMmU2UIJqM/wAEWxo7FST9I4oCm
         eOQ1ACR1CFkTaL+zRigUzLU6QQN1jrulBx2h6Qh/p4TbavnWWTI8AGEco30eS1Q4jcE7
         Q9OQMYbAuKelJMn0tKW/7x00JZanWWKxLHdwpsgkbHPuvvoc8kNEc1rQ2Kb7HtJ94bUA
         1xm2T5vbGRVeRLobqklOddLLbn7D6Yxg1VNu9n44Me18omcs6l3EqiImb0Q4lnhqH4hE
         zVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704771538; x=1705376338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKRSbrKS67RNdW5xwmhX/Uca0R/IdmheRC0aGIx8H7k=;
        b=Rw2NOTdVy6Oycs9WbFavREQVZeaTkGbnZc3UQSyvNwf5NoUxrhE+24yrF9MBfdCHdL
         yNW8E8cgISWJHqTUII63EmDO68w2b2s897b9o3MpfyLkTj20rAW7F0p9nTjgs0b+9hpi
         sr00EmpbOwTKwL6uiXmULM/Q0p1Jqc9/t5mg/1V4mhHzWNV0kc2hwL1VADCwoajVRp8K
         WROBM1MsjfBw4iHri6W/2/8NPUssJlkqdGeN+/is87S7Jun20kYj0gt/YYE5AfVXbpVH
         QoJZApLyy9geGXE3GXEbVbJFjDMSK+YpvxYZIP2Qb4i6WpABdiXt/8w6MsvHuTP7AwrF
         WIfg==
X-Gm-Message-State: AOJu0YzVOqErw5XODAn4kqc2UCmUfo0e2Sj3lvuIfUo2Emzw+6TQQ2XM
	KNMzoJRvkXrh07+WYT5fOnrXrV09sJLwQisOGSU=
X-Google-Smtp-Source: AGHT+IH79Oshez2nIujyNrM/TrmLpogKjgIG7d+6qcN40iC37fKrEcCZqcR6H3d2Kw8+DHLOHynmOHX7tGAn3zBbrYc=
X-Received: by 2002:a67:e715:0:b0:467:b016:61c5 with SMTP id
 hw21-20020a67e715000000b00467b01661c5mr3360285vsb.6.1704771538189; Mon, 08
 Jan 2024 19:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095006.608744-1-21cnbao@gmail.com> <20240103095006.608744-2-21cnbao@gmail.com>
 <CAJD7tkbB2Tni-xo5orxw-uDHzAcKocc7WeV2536LLbE=PC8=QA@mail.gmail.com>
In-Reply-To: <CAJD7tkbB2Tni-xo5orxw-uDHzAcKocc7WeV2536LLbE=PC8=QA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Jan 2024 11:38:46 +0800
Message-ID: <CAGsJ_4yk=yrpBWvYukoDbq8288yqLLyox4ozg82GiUyaU+ntWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: introduce acomp_is_async to expose if a acomp
 has a scomp backend
To: Yosry Ahmed <yosryahmed@google.com>, herbert@gondor.apana.org.au
Cc: davem@davemloft.net, akpm@linux-foundation.org, ddstreet@ieee.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, linux-crypto@vger.kernel.org, 
	chriscli@google.com, chrisl@kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	zhouchengming@bytedance.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Wed, Jan 3, 2024 at 1:50=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Almost all CPU-based compressors/decompressors are actually synchronous
> > though they support acomp APIs. While some hardware has hardware-based
> > accelerators to offload CPU's work such as hisilicon and intel/qat/,
> > their drivers are working in async mode.
> > Letting acomp's users know exactly if the acomp is really async will
> > help users know if the compression and decompression procedure can
> > sleep.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  crypto/acompress.c         | 8 ++++++++
> >  include/crypto/acompress.h | 9 +++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/crypto/acompress.c b/crypto/acompress.c
> > index 1c682810a484..99118e879a4a 100644
> > --- a/crypto/acompress.c
> > +++ b/crypto/acompress.c
> > @@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(const=
 char *alg_name, u32 type,
> >  }
> >  EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
> >
> > +bool acomp_is_async(struct crypto_acomp *acomp)
>
> Is synchronous semantically the same as sleepable? IIUC synchronous
> code may still sleep, at least generally. The purpose of this change
> is to know whether we will sleep or not in the zswap code, so I
> suggest the code should be explicit about sleep-ability instead (e.g.
> acomp_is_sleepable or acomp_may_sleep).

Thanks, Tosry. sounds reasonable.

I'd like to ask for Herbert's comment, do we have a better way to know
if an acomp can sleep other than checking the below?

return tfm->__crt_alg->cra_type =3D=3D &crypto_acomp_type;

Thanks
Barry

