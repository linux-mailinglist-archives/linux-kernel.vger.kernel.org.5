Return-Path: <linux-kernel+bounces-6224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A681961E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF11F25054
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F1101CB;
	Wed, 20 Dec 2023 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKp8Or+n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F25E547;
	Wed, 20 Dec 2023 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7d2c1ff0so21580741fa.3;
        Tue, 19 Dec 2023 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703034907; x=1703639707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTHm0I4P2zQ/TFgdn8ZGMyjYnErvDS5xEoA7hWb25I0=;
        b=AKp8Or+nEvLY1ZCPsE9BUF+lMW054iLsYMsGD2tSirN0ZGD6crRlQkEZRtW2vpAerF
         rUiBIm0ovlWbiJuruOFonoAVeJyNOIFpyGGjCFpWvK5Sq1jDaoHDSiJA2G1tKCtn0Fyq
         hX2M8aGlc6vcCIKbnTu3EZnKnuyF+emf3zIXXJa6YqWYiNQ2KlFwjAZpj3Kh5oZmyoGF
         7bTSc1BEEHA4KQvHtByXhk6nMx7AM5LT+pqLx4/e9aXuDpzNgLVM6Jqn6rKNUd47ZE6N
         QeResZQQRysnC1SigH4QZoaRhkX5bv55V/oOs+2yGVyyX/G/aET6/6P8nD44pnyEc1h9
         KG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703034907; x=1703639707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTHm0I4P2zQ/TFgdn8ZGMyjYnErvDS5xEoA7hWb25I0=;
        b=HMY941rz658pOjQftrDtCSKfyUTXRW/PGaUrcQcnK9v65bQdcspiNuU3UnJ6Oa435c
         dIcvoipDNaWbtSmOQwpDni534bvSzaKC9xcUSlyU2eC2MGbczRhuDHX+XniubIoBsOzT
         tWQS65vTo3Flc9dxINodnPH3AoAFoIRWFlZ1jRtmwV8Yub62qr501dr27fgJh2x06XkE
         +nZX67GAM6HDzqAeTZ1FdxyrILiCwj64FQXHyYZwjUSeZTYsxpgVjcK+9S+MYfscn1So
         L6gMKw2+Yf9tva4BXZED30iKy06mAyn8slj5RH6O2Sdm3hlu7z5gBvdf0HS8ESFjdcTH
         dFMg==
X-Gm-Message-State: AOJu0YyaBW8u5zvM1gzT8x1ymvwF5b3TLLxSvf7InkWWk73Vz8lQr8KK
	/gI3GY81Z55juIUTuaw1OGjogoguU5/U2lktOI4=
X-Google-Smtp-Source: AGHT+IGT7FXmqN/LnGJ0bcuN3sr1aOtcttmmFmmkV3+z/Jn7fTUjMU1lAgsSYdDBcvrfflr1p5M9x18SekA1JHyJ7ag=
X-Received: by 2002:a2e:b054:0:b0:2cc:56a9:32d7 with SMTP id
 d20-20020a2eb054000000b002cc56a932d7mr3631186ljl.85.1703034906688; Tue, 19
 Dec 2023 17:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com> <20231218012746.24442-5-hongyu.jin.cn@gmail.com>
 <20231219224821.GC38652@quark.localdomain>
In-Reply-To: <20231219224821.GC38652@quark.localdomain>
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
Date: Wed, 20 Dec 2023 09:14:56 +0800
Message-ID: <CAMQnb4N=5jf5Hsq1Qtb-9dsPzB29-xEV3Wj_Fi1WgCuW_pv2pg@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 4/5] dm verity: Fix I/O priority lost when read
 FEC and hash
To: Eric Biggers <ebiggers@kernel.org>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, axboe@kernel.dk, 
	zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com, 
	hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 06:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 18, 2023 at 09:27:45AM +0800, Hongyu Jin wrote:
> > From: Hongyu Jin <hongyu.jin@unisoc.com>
> >
> > To fix this problem, when read FEC and hash from disk, I/O priority are
> > inconsistent with data block and blocked by other I/O with low I/O
> > priority.
> >
> > Make I/O for FEC and hash has same I/O priority with original data I/O.
>
> "To fix this problem" is supposed to be in the second paragraph, not the =
first,
> right?
Yes, The verification and error correction process takes effect after
obtaining the data.
>
> > @@ -728,6 +730,7 @@ static void verity_submit_prefetch(struct dm_verity=
 *v, struct dm_verity_io *io)
> >       sector_t block =3D io->block;
> >       unsigned int n_blocks =3D io->n_blocks;
> >       struct dm_verity_prefetch_work *pw;
> > +     struct bio *bio =3D dm_bio_from_per_bio_data(io, v->ti->per_io_da=
ta_size);
> >
> >       if (v->validated_blocks) {
> >               while (n_blocks && test_bit(block, v->validated_blocks)) =
{
>
> The caller has the bio pointer already, so maybe just add it as a paramet=
er to
> verity_submit_prefetch()?
>
> - Eric
ok, I will change it.

