Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38C7DBC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjJ3Pa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3Pa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:30:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C3DB3;
        Mon, 30 Oct 2023 08:30:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso710123066b.2;
        Mon, 30 Oct 2023 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698679850; x=1699284650; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fucSBr7KI97NI+mfq5QKSGfLCAvmSHTUlbKwSB46i8M=;
        b=FyeD1hi7Q70290DBZmyismC8doWU9c9J9ZCN6nhoBnZ/hAK2onXFD+5AplnoMwZl7C
         5mB9EpjQZgNAW1q0WbXX5+TJkaAW39opDVsp+rKti3wHpgvJOklFMvY1F+w1JvtNoCmW
         4ewguXHNZWDiTF8shw5308BQiYqBc+3RjN5Jxm1qUTsflU4NyjAQmffj1zEg/VDH1OMs
         NyYTsycCjeSAZNrNXuzFZqbPXhe1fv48/Ort4XT+mfQvrMODGIrYx9M5Y6ZAhtNQK3eJ
         Sj+KIqCP1/0Vdb3VySY7WRasiWSYoZGxgOeZ9Q7A72pDMDvLo6aiIsninANKDd5xkKkz
         /cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679850; x=1699284650;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fucSBr7KI97NI+mfq5QKSGfLCAvmSHTUlbKwSB46i8M=;
        b=B12ExwBMXvYYRo8JcWwIe4VjGeUTk4Rsq+sF3nMnDDONRlHMh/cGWkn+c8xzMkkeXm
         coW4cOjWR676Eu9r9dvoRkSJCa46OqTFD8YMPfZUjU/VmFCc+FdxMzdJcS3755jlvTy8
         VtVOtbnP8xnis/7Mqs8YUQ/Ws6I6U6RqFh8VVOkC95oPecf3OxBJ5Wkk3omYe+85bwr2
         8p+T45swtbb49180Fpw4oWmzBpLC5C5fu+ulGJK72BdEN8wmmY9YJz+c6p0Gx8VUGmrq
         MahE8Chqns4WrM8IYwBrtvPVvKEGA27T9zcQ063BpqSCwvekixS4+isI/ulZ4sJjRvx1
         SJGQ==
X-Gm-Message-State: AOJu0YwJLyhtzkvtCpA/bhUkXUB11kM/MAv0Ai4DP50xjqD79sXfrd2o
        yWmX0RGlTAgGQHOnCsYQIgrUVStJvyc=
X-Google-Smtp-Source: AGHT+IHQSz27xYdC8l13VusKgW8ymoWqjteGO/wj2sa3TzwVQ905mfNPeAsWlsqdiV8MCkI5ddpiug==
X-Received: by 2002:a17:907:7f9e:b0:9c6:8190:359f with SMTP id qk30-20020a1709077f9e00b009c68190359fmr9810526ejc.33.1698679850002;
        Mon, 30 Oct 2023 08:30:50 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090622d100b0098921e1b064sm6138533eja.181.2023.10.30.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:30:49 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:30:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: fix error checking for
 debugfs_create_dir()
Message-ID: <ZT_MKDVkqMECiv4I@orome.fritz.box>
References: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
 <1acd75d0-67a7-4a17-99c7-707cca305f37@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tiC6UW8JeMZZZOlp"
Content-Disposition: inline
In-Reply-To: <1acd75d0-67a7-4a17-99c7-707cca305f37@linux.intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tiC6UW8JeMZZZOlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 07:25:50PM +0800, Baolu Lu wrote:
> On 2023/10/25 19:01, Dario Binacchi wrote:
> > The return value of debugfs_create_dir() should be checked using the
> > IS_ERR() function.
> >=20
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >=20
> >   drivers/iommu/tegra-smmu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index e445f80d0226..cd1d80c4c673 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
> >   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
> >   {
> >   	smmu->debugfs =3D debugfs_create_dir("smmu", NULL);
> > -	if (!smmu->debugfs)
> > +	if (IS_ERR(smmu->debugfs))
> >   		return;
>=20
> This check can be removed, as debugfs_create_file() can handle the case
> where @parent is an error pointer.

A patch for this has been in linux-next for a few weeks, see:

commit f7da9c081517daba70f9f9342e09d7a6322ba323
Author: Jinjie Ruan <ruanjinjie@huawei.com>
Date:   Fri Sep 1 15:30:56 2023 +0800

    iommu/tegra-smmu: Drop unnecessary error check for for debugfs_create_d=
ir()
   =20
    The debugfs_create_dir() function returns error pointers.
    It never returns NULL.
   =20
    As Baolu suggested, this patch removes the error checking for
    debugfs_create_dir in tegra-smmu.c. This is because the DebugFS kernel =
API
    is developed in a way that the caller can safely ignore the errors that
    occur during the creation of DebugFS nodes. The debugfs APIs have
    a IS_ERR() judge in start_creating() which can handle it gracefully. So
    these checks are unnecessary.
   =20
    Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
    Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
    Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
    Acked-by: Thierry Reding <treding@nvidia.com>
    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    Link: https://lore.kernel.org/r/20230901073056.1364755-1-ruanjinjie@hua=
wei.com
    Signed-off-by: Joerg Roedel <jroedel@suse.de>

Thierry

--tiC6UW8JeMZZZOlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmU/zCgACgkQ3SOs138+
s6E+Ew//bfW6yOHM4+iM8OVsK+t0vyqrUeQ74ao0+QMKgBje2qbrxeWcV5cIdeaZ
rL39jdMkomI2H3G7JXUrfqigRkRH6y2ObXU5fPX1VbXG9Olom9wqRiN6xCEDKzP1
hI6EbvDYhHB5otD9t9/NUy926QQLrNs2N1g+fHJZjT4H7oZKUg5U/ayO2ZqfBuPI
pG3kb/n+Yr6IGjGtsFaX3xgp8uu0YFe6znrUqIHXgrxga6DmHCSm/TCjb5ykZMKk
s/8fiZKJlAl+emIvzh3h9vyNqjzCTjz5T84KQIFxJFPytmxGqc0kQlmlUOn65Ren
K6XVfcoy0R1XFY+z6uGZwk31qo72afJSvOIG+T299r16mgTfopBpQhXXW1i/FaM2
s8wYy6C33/GbB3pTtbSSuVxbd5ZwPA/eFXZQfn/Zs+J2BgKJ1eG0DULMnGowcNQq
RHox8DQeQpuL52B7ncg1qc4DACuqZPbK+b1BLQ+T9LWILhDnoMVE+l5LfpmVTcXa
Awt5nJnxPQy85qD4fP8Vij+rLwi82NiJRrQzy+P1efAO512SoYAouJ/trug9LkRT
uhzqFB2tUojtdEtxR57uo0EnX6lX7V13yqNJHIkb5PhgKjFOkzFttHB2cj2wDmxD
L/yGOHwED8cXLV4a/WWFStNKeOlCJfUUGfsShh8lsKcpjExog+Y=
=+7dL
-----END PGP SIGNATURE-----

--tiC6UW8JeMZZZOlp--
