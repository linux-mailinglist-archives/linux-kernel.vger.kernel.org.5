Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870157F2C02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjKULrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKULrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:47:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8172110F;
        Tue, 21 Nov 2023 03:47:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so5158598b3a.3;
        Tue, 21 Nov 2023 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567224; x=1701172024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dh0Qezs/2ZRqRfDGUZZwszGFFNv4uXTXsmAQTNvTJ8=;
        b=Oj/wVkQQqn1YGU3a+RXqlKqr3ABt8yZuvW1qxS0H95dTAclQibbgrG8uHr6/W9bj/s
         zDsb9xU75Yk1cCgOXByQNi6cfjl2D8MJenfBHH8GS7oIhNzgTzjPNlR0H8dYWYv1F32a
         l2MBvGNugGYMzRVeXuIeoikkhMz8IW77SZJu49JQCxEcw+ojYM3cqr6Uy89QVstteC3E
         rxuTWwknuhRvW0CWiaCmVJSfqZAit5vfE8YOP0UqkVBu+L1WKWE3WbQy62MJeaxrp3ya
         qoeR8VQ3OF9ZnZRHjPwfQ5VtnBToV6Lf+ys/LpvE/4WteHPX5RI+hzxq6OxsNyjwm35c
         3Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567224; x=1701172024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dh0Qezs/2ZRqRfDGUZZwszGFFNv4uXTXsmAQTNvTJ8=;
        b=dKYRpq4hI7nUy6wET6svhmG9YMCQl3X5362YxqFBzGcZQAStEGm/Qxk+mwiCpdN9eb
         hiIW7m6eQTLG/ZbIJuOOzrFLOQeqBNkBJta+poA++IwiDai1MSxO5tIP+ChMnuckOLua
         9LcptoFA7BvxhaXyKmIjHKmtPV4ZKZs18f5A/Yb9V/SX8p4EO7dvq5Tpo5RBoqrA1+3+
         09cBfYJWDfKy4AyBOc2XvG8B/92Xalbxf9umM0pzrQYlkj751dTd6lcqBI3RSWBfiqr/
         C6UpBbvP6sFWWT3Dv2elbMFTxIm0xyQQnhGlqGVlAr/9vp0rXxd1N9gX42pM2hyS/5N3
         exSA==
X-Gm-Message-State: AOJu0YyNRlMWMCDnev61kDlzC0U9yGchRHRZo37X1mP1Sv+1gAfhdtqk
        EXBDLD0Jhpld8FpC0F+iGRQ=
X-Google-Smtp-Source: AGHT+IEmfo36HWN/pX5H0L9nVyVz7Ausj0X4uQHMXBuvcd8rGMkt4Nlo44xIhzq9d1YRgU2fBl6rKA==
X-Received: by 2002:a05:6a20:7353:b0:18a:da5a:8a62 with SMTP id v19-20020a056a20735300b0018ada5a8a62mr1976876pzc.59.1700567223928;
        Tue, 21 Nov 2023 03:47:03 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fh33-20020a056a00392100b006c06779e593sm7971334pfb.16.2023.11.21.03.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:47:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id E3EDF102106CB; Tue, 21 Nov 2023 18:47:01 +0700 (WIB)
Date:   Tue, 21 Nov 2023 18:47:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH] Documentation: xfs: consolidate XFS docs into its own
 subdirectory
Message-ID: <ZVyYtQ83KwaOtCkL@archie.me>
References: <20231121095658.28254-1-bagasdotme@gmail.com>
 <bbf74f50-c026-4f72-8437-8d15821c0340@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vb95jMlk3ed/EOb6"
Content-Disposition: inline
In-Reply-To: <bbf74f50-c026-4f72-8437-8d15821c0340@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vb95jMlk3ed/EOb6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:16:16AM +0100, Vegard Nossum wrote:
>=20
> On 21/11/2023 10:56, Bagas Sanjaya wrote:
> > XFS docs are currently in upper-level Documentation/filesystems.
> > Although these are currently 4 docs, they are already outstanding as
> > a group and can be moved to its own subdirectory.
> >=20
> > Consolidate them into Documentation/filesystems/xfs/.
> >=20
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >   Documentation/filesystems/index.rst                |  5 +----
> >   Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++++
> >   .../{ =3D> xfs}/xfs-delayed-logging-design.rst       |  0
> >   .../{ =3D> xfs}/xfs-maintainer-entry-profile.rst     |  0
> >   .../{ =3D> xfs}/xfs-online-fsck-design.rst           |  0
> >   .../{ =3D> xfs}/xfs-self-describing-metadata.rst     |  0
> >   .../maintainer/maintainer-entry-profile.rst        |  2 +-
> >   7 files changed, 16 insertions(+), 5 deletions(-)
> >   create mode 100644 Documentation/filesystems/xfs/index.rst
> >   rename Documentation/filesystems/{ =3D> xfs}/xfs-delayed-logging-desi=
gn.rst (100%)
> >   rename Documentation/filesystems/{ =3D> xfs}/xfs-maintainer-entry-pro=
file.rst (100%)
> >   rename Documentation/filesystems/{ =3D> xfs}/xfs-online-fsck-design.r=
st (100%)
> >   rename Documentation/filesystems/{ =3D> xfs}/xfs-self-describing-meta=
data.rst (100%)
>=20
> I think you need to update MAINTAINERS as well.
>=20
> A project-wide git grep for the document names should have turned it up.

OK, will fix in v2.

Thanks for the suggestion.

--=20
An old man doll... just what I always wanted! - Clara

--vb95jMlk3ed/EOb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVyYtQAKCRD2uYlJVVFO
o6FAAQCgHyPhsgH3UuKype/Cd5adL0D6qda0lLt60JZiGqWaGAD9HNtW9qQ3A+Kw
tf8Tfv/syImaeaPMNLMH2ssm9G33Fw4=
=bpQl
-----END PGP SIGNATURE-----

--vb95jMlk3ed/EOb6--
