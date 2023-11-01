Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4937DDEA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjKAJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjKAJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:43:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D1DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:43:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc330e8f58so28899055ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698831797; x=1699436597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2A7Y/11whjGsMhAiEp81xRL7zeK5hRlJmAi1MKSmNLM=;
        b=SyLvHpiCoT+tsK8m3wa7ww/LIfV/5OpOAtBCxYHfHK2i/0HlIRHcYhcvbKBVa5uBqj
         YhP33ItGe0LrEaL7uWfFGMuoMvf6SeBmmiXOOLOmdiZ6QJ7/6q978DlgcfLnliIgJ+mu
         GQ2DhONTFgUd2HpcUOZnT9EI69cOTPQxIW0uw3mLTJ0vj5RDo6gEEWy7UZrw5tHF9FcO
         UDc4gUaNTCaUPEvDV6NoUNhAzc825acdO0eNr22p5PT5kns/qzBqneFmSYdD/HNjGQ7X
         eRW0q8W0vrFCBxPlg/tfC1e+KpelzdPHL2dg7GnWXd5TOpuII17KidOEOstJedmovhRw
         /niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698831797; x=1699436597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A7Y/11whjGsMhAiEp81xRL7zeK5hRlJmAi1MKSmNLM=;
        b=CAS4lb0wjlwKZrs2lOKh/4Rokx2an4yWVsb/A89NaKjFWrTkhfM9ZVVx+Jb7A554je
         Mu6FVQGzHcIQ7IdxT3O/feucgMxtGKrFKdEaIjVxYdeHrEd1ASdCG3zrK8jK+G4ewJ3d
         cuvi9C57v2VYRdVxr+TecJ/y6Kw9RQTTBe+bQ1O6jS0WjLSlcDEV5nxO9823gV2bCrgD
         9j4pZe0JdJOOskIIEBps8L4XxV/96XrVRwzfalOYpgZQ33tWBo4iin6sJoeFgl4N3tT0
         8OJX8Cg6v8Co9m8RrI7qiODz2lDQeupg75bM12sdcKIdyVGn4DvJESl0+CoUVfBlnLOe
         YpZQ==
X-Gm-Message-State: AOJu0Yy2cJck9WWHgSKh2OAuAXkircHbhEly9MJvzYx5lGgzjgfGmjo+
        oqrflr3mMHaVf+corRzHSAM=
X-Google-Smtp-Source: AGHT+IGT4O+L81nSAQ1uLW6groCXyS4JSYmHYensOGSr/USkULHyEEJ53PQy564JiPHsQnCSCV9Ktg==
X-Received: by 2002:a17:902:d4c2:b0:1cc:5aef:f2cf with SMTP id o2-20020a170902d4c200b001cc5aeff2cfmr6986814plg.9.1698831797023;
        Wed, 01 Nov 2023 02:43:17 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902eed200b001b3bf8001a9sm990713plb.48.2023.11.01.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:43:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A3A8997EF4A3; Wed,  1 Nov 2023 16:43:13 +0700 (WIB)
Date:   Wed, 1 Nov 2023 16:43:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Message-ID: <ZUIdsK5LGmRww9ER@debian.me>
References: <20231031220534.37730-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/kDkZH0oq/bEChkj"
Content-Disposition: inline
In-Reply-To: <20231031220534.37730-1-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/kDkZH0oq/bEChkj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 03:05:34PM -0700, Tony Luck wrote:
> In a "W=3D1" build gcc throws a warning:
>=20
> arch/x86/kernel/cpu/resctrl/core.c: In function =E2=80=98cache_alloc_hsw_=
probe=E2=80=99:
> arch/x86/kernel/cpu/resctrl/core.c:139:16: warning: variable =E2=80=98h=
=E2=80=99 set but not used
>=20
> Fix by switching from rdmsr() to rdmsrl() using a single u64 argument
> for the MSR value instead of the pair of u32 for the high and low
> halves.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> This has been annoying me for a while as the only warning from the
> resctrl code when building with W=3D1.
>=20
> N.B. compile tested only. I don't have a Haswell system to check this wor=
ks.
>=20
>  arch/x86/kernel/cpu/resctrl/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/res=
ctrl/core.c
> index 19e0681f0435..4084131d391d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -136,15 +136,16 @@ static inline void cache_alloc_hsw_probe(void)
>  {
>  	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[RDT_RESOURCE_L3];
>  	struct rdt_resource *r  =3D &hw_res->r_resctrl;
> -	u32 l, h, max_cbm =3D BIT_MASK(20) - 1;
> +	u32 max_cbm =3D BIT_MASK(20) - 1;
> +	u64 l3_cbm_0;
> =20
>  	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
>  		return;
> =20
> -	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
> +	rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
> =20
>  	/* If all the bits were set in MSR, return success */
> -	if (l !=3D max_cbm)
> +	if (l3_cbm_0 !=3D max_cbm)
>  		return;
> =20
>  	hw_res->num_closid =3D 4;

No noticeable regressions on my Acer Aspire E15 (the laptop uses Intel Core
i3 Haswell), thanks!

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--/kDkZH0oq/bEChkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUIdqgAKCRD2uYlJVVFO
o7upAQChP7LAJsVZ5cqzDRXlqbqiXTpUB/Z1skpOBG/2zdp9JQEArZ7+m7m+fKJv
+QWUOzcotSAdWID8x86Qxj8mNM+kuQc=
=nlab
-----END PGP SIGNATURE-----

--/kDkZH0oq/bEChkj--
