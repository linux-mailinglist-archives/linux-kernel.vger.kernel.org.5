Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC1753529
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjGNIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGNIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:41:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF111BFA;
        Fri, 14 Jul 2023 01:41:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so2749734e87.3;
        Fri, 14 Jul 2023 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689324066; x=1691916066;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twF/Y7Vm111Vdk9HXu/qA9ex8Z+v4RDuvFO115VvSJI=;
        b=iJzlMCfoclbfcoVMsCj7SNlRZBajmIFdcjjH457xfKYcnXlibJdMmNyjK7Bpj/DtPY
         2sWM+v7lGiWJMOMvIQLOGx4hlNvDKr7296fmmXFxWuM84GBXkaRKBlHqBFEW3rKlpbqX
         xtqy3Gn5MS1x/v6NHWXJDGNgCdyd3VZ9iNr+scoWFeacfxnbIhcxTwwAxmMk5cuiruGZ
         UlJ9iItp0lt+OaUH5O+7s9Xpm1bkA8Aak8bTUcRq8z4FK1e2OvyExA9KhJv7kyA6Taoc
         FAtgIvxL07qylPGPtyPigQZ2zXBAB65JQn9YIXE2tkoo340M4swZ5UIqLZAFp/3bM06Z
         Dmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689324066; x=1691916066;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twF/Y7Vm111Vdk9HXu/qA9ex8Z+v4RDuvFO115VvSJI=;
        b=T8g97RhF73N4rWE+rpPtBOH/K2OSJbg+gvdVMDAWMHMKeHkAAsMX1iIp5mJY40+pSH
         4rpsEsE1mHymyJh7SnTuuIuAwtjTNJTj1RWuPz3tG/5c7Mnv5tFUsW2fezRol+/xOYUf
         sjOA/MZsM7uWNIsfyIIhsp56BAPqe+YBc7CcI6nF5WhNjBKUOuWlCVeK3L7nfbm+At81
         lwNVrE4hPOVuMch6Alob2TeynkYYdjt3jVYXI8uXQVMGHQfUoHe1tgM00hWvm8HFPwju
         Jm8qkJP/iHtxTkQ0ttpPyp8VX1Wp70QoNEs7ptZ1c3+bpQzCv3XbsNkOKgHbZMWe4bAQ
         sIQg==
X-Gm-Message-State: ABy/qLZKMkpFiLb1qOTz+rco5tFdGD6fhnaXMqbk6qbEBXoI6m3/fIEg
        y+ki96HRWoON+VXD9MTSeHU=
X-Google-Smtp-Source: APBJJlFkZ6sXsjf7XXOkr/VpR8s76bV1lGcCGSFUwouDb0eTxaZcqDHqdOXwaEFt4UkmmKmniPGzBw==
X-Received: by 2002:a05:6512:344a:b0:4fb:ca59:42d7 with SMTP id j10-20020a056512344a00b004fbca5942d7mr2994144lfr.33.1689324065877;
        Fri, 14 Jul 2023 01:41:05 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402184f00b0051df6c2bb7asm5455704edy.38.2023.07.14.01.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:41:05 -0700 (PDT)
Date:   Fri, 14 Jul 2023 10:41:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIGlv?=
 =?utf-8?Q?mmu=3A_remov?= =?utf-8?Q?e?= redundant parameter check in
 tegra_smmu_debugfs_init()
Message-ID: <ZLEKH8ixyRH7IzLK@orome>
References: <20230713072825.10348-1-duminjie@vivo.com>
 <362e4343-dcf1-58fc-7ac9-756c65bb0df6@linux.intel.com>
 <SG2PR06MB5288ED578DB3CE7DA2B25AB5AE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sWp9+yLAQfcZfBiY"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB5288ED578DB3CE7DA2B25AB5AE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sWp9+yLAQfcZfBiY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 03:21:47AM +0000, =E6=9D=9C=E6=95=8F=E6=9D=B0 wrote:
> Hi Baolu!
>=20
> It seems that 'smmu->debugfs' check is still needed.
> Then I will modify the patch.
> Thanks!
>=20
> regards,
> Minjie

Don't top-post, please. See Documentation/process/2.Process.rst and
Documentation/process/submitting-patches.rst.

Also, how did you come to the above conclusion? Baolu said that Greg
keeps reminding people that we shouldn't do error handling for debugfs
and gave a Reviewed-by:, so why the 180?

Thierry

> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Baolu Lu <baolu.lu@linux.intel.com>=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 =
10:58
> =E6=94=B6=E4=BB=B6=E4=BA=BA: =E6=9D=9C=E6=95=8F=E6=9D=B0 <duminjie@vivo.c=
om>; Thierry Reding <thierry.reding@gmail.com>; Krishna Reddy <vdumpa@nvidi=
a.com>; Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robi=
n Murphy <robin.murphy@arm.com>; Jonathan Hunter <jonathanh@nvidia.com>; op=
en list:TEGRA IOMMU DRIVERS <linux-tegra@vger.kernel.org>; open list:IOMMU =
SUBSYSTEM <iommu@lists.linux.dev>; open list <linux-kernel@vger.kernel.org>
> =E6=8A=84=E9=80=81: baolu.lu@linux.intel.com; opensource.kernel <opensour=
ce.kernel@vivo.com>; Thierry Reding <treding@nvidia.com>
> =E4=B8=BB=E9=A2=98: Re: [PATCH v4] iommu: remove redundant parameter chec=
k in tegra_smmu_debugfs_init()
>=20
> [Some people who received this message don't often get email from baolu.l=
u@linux.intel.com. Learn why this is important at https://aka.ms/LearnAbout=
SenderIdentification ]
>=20
> On 2023/7/13 15:28, Minjie Du wrote:
> > debugfs_create_file() will return early if smmu->debugfs is an error=20
> > pointer, so an extra error check is not needed.
> >
> > Signed-off-by: Minjie Du<duminjie@vivo.com>
> > Acked-by: Thierry Reding<treding@nvidia.com>
>=20
> Greg keeps reminding that no error branch for debugfs, so
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Best regards,
> baolu

--sWp9+yLAQfcZfBiY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSxCh0ACgkQ3SOs138+
s6FoQxAAqLECF0cZvl6wXvAO8Kz53hrol4zJ2QZiSt+XzufD1uZDKVW/EYFWs90x
0q7zpyohghBoiffKQ3byPHg7NZtLjdfxFEBR9i15/YSCTO6hxjQOUItA4uvS/40p
R2hyTEAdwPa/UvsZbrldAOCq4gy9jaymvtZe3GLSiZmL60rDT+U2uti0WzXhRdQE
drthzwKIdkOE46D4gDtQAT/L2I1KTkyc+b79484vB5rnQ4iFLLvp3FjtS2q9dZtx
ppzSHlUvsxSHf3ujtjTrKEi8cF6p4m5pXhYCSyuClxeqHZmf6i9y06e7AGZaj2J5
3OQLH4l7ppVroDhpM+6HEHUEtJNr9ORk7PmNKvfcMJuc+8AYCr939BXKloPEFTGC
4Wdl6nCRNCPc53EYGbCw0S9ma3re6bwzAwjNwpME1rITQpkTJtPBTUCjX+8LM1HZ
ZOBubBQ+iWCzSZVSsJMlJpb71D+b4ztzC9e0fyDwdLQXc7lQMfawnwHuh0tzvFdo
mNM4baUFrvuuGjL0ItkS3cXRqSmdlrKzRrBhEDBByXAvsgP1Bsit8jTJUpqiAT45
wDxm8AxmdY6uXBQv3Ar5Uov5XQ30OzLLbPtarX3ya7f/oFBcmDbVUitf9woQf0nv
xYVfSXJAJDDvqLQ9UfEl/6TtVMI6VnIyd91ByJrV7mmXOXgTl9A=
=yASD
-----END PGP SIGNATURE-----

--sWp9+yLAQfcZfBiY--
