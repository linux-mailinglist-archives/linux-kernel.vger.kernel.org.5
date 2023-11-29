Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAD7FCFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjK2HMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2HMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:12:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3610F4;
        Tue, 28 Nov 2023 23:12:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-285f46e1cd4so1860513a91.1;
        Tue, 28 Nov 2023 23:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701241968; x=1701846768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khXPSRzgdB+P5qMW7Yfo8kR2yxCphSgvlS03QencHrE=;
        b=I9S1XxuXbsorlk7b4vYciu5DD243AiH6oYbUTFRn2RLBdcbqRdJUPZB4+qdteBT/0y
         esISKmymL8ROikLAqb6Q7bVRY1riTE8Wfo/kKLKA6idWNfB3Iw5Lc60Vxg04r0KjJXoV
         2nx0O6c1qXLHl13UmPkpW8sMonxXFM2yc24aS5SJrJF9O2La/Sv95YgPNGLJFtrIU8va
         dmVkhtCEg89c421KMaqwOqPIqN8KGRwDHk8JN6COmWi5lXRm/bu43LNOnv90ZNheKtkt
         nu1QbxevyHTGW56fRqd7cm0TkMU99YbUHfCtA/u0CkK/MkodSGorAxPlP7fc5OXhWjsJ
         cLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701241968; x=1701846768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khXPSRzgdB+P5qMW7Yfo8kR2yxCphSgvlS03QencHrE=;
        b=V6/zNfrBmP5dFa17AYXsuZw2u+Cp9FKetOx81EGSBIVDF2WpO9p0xsFsVFXJJw9SQc
         WIz+i9GDvM3Y5dIDe3+xWnc43nVlGFmQ45V73h2ux5qgDunsf3gCZqF9/63UNjl5PT6r
         uEsaA5aYGKwaiBo/iqPwIadR1cTdtdYq8wIw8ji/fBRFnIhE6nxNGDH3wijnaosjdW4m
         vP8uMqgGh3CnPrjZd0lwDnnolI82R5yIBcO7oO1OQs04hcl5rcQHyr6REeVfdg/lezPO
         f9y3bUFSW51jf6cve/myzYieNnXT/0j4taC7uomTfx49CziTO6eZXwhxDWBIaSCQH7KQ
         ZjAw==
X-Gm-Message-State: AOJu0Yzb8zvmQT+UMpu5uWWRIS9RziFjXmTN3imrBkCf8kCce6Er4JGO
        XrADk622DYZQkl6kzKK0MYg=
X-Google-Smtp-Source: AGHT+IGYU+vcCLHGBjNmaSMH5vBeDivx8zWA+1KdLMs90vDtsTKrTOAMfB0N8kYmF4HoGyMC3TCikA==
X-Received: by 2002:a17:90b:388d:b0:285:da91:69d9 with SMTP id mu13-20020a17090b388d00b00285da9169d9mr9002378pjb.9.1701241968369;
        Tue, 28 Nov 2023 23:12:48 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001cf83962743sm9864131plq.250.2023.11.28.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:12:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id AF4A610205C74; Wed, 29 Nov 2023 14:12:45 +0700 (WIB)
Date:   Wed, 29 Nov 2023 14:12:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH RESEND v2] Documentation: xfs: consolidate XFS docs into
 its own subdirectory
Message-ID: <ZWbkbfjyDJS7jxDg@archie.me>
References: <20231128124522.28499-1-bagasdotme@gmail.com>
 <20231128163255.GV2766956@frogsfrogsfrogs>
 <20231129052400.GS4167244@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/eNx4OrSdA7OOxOK"
Content-Disposition: inline
In-Reply-To: <20231129052400.GS4167244@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/eNx4OrSdA7OOxOK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 09:24:00PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 28, 2023 at 08:32:55AM -0800, Darrick J. Wong wrote:
> > On Tue, Nov 28, 2023 at 07:45:22PM +0700, Bagas Sanjaya wrote:
> > > XFS docs are currently in upper-level Documentation/filesystems.
> > > Although these are currently 4 docs, they are already outstanding as
> > > a group and can be moved to its own subdirectory.
> > >=20
> > > Consolidate them into Documentation/filesystems/xfs/.
> > >=20
> > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > ---
> > > Changes since v1 [1]:
> > >=20
> > >   * Also update references to old doc path to address kernel test rob=
ot
> > >     warnings [2].
> > >=20
> > > [1]: https://lore.kernel.org/linux-doc/20231121095658.28254-1-bagasdo=
tme@gmail.com/
> > > [2]: https://lore.kernel.org/linux-doc/a9abc5ec-f3cd-4a1a-81b9-a69001=
24d38b@gmail.com/
> > >=20
> > >  Documentation/filesystems/index.rst                |  5 +----
> > >  Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++=
++
> > >  .../{ =3D> xfs}/xfs-delayed-logging-design.rst       |  0
> > >  .../{ =3D> xfs}/xfs-maintainer-entry-profile.rst     |  0
> > >  .../{ =3D> xfs}/xfs-online-fsck-design.rst           |  2 +-
> > >  .../{ =3D> xfs}/xfs-self-describing-metadata.rst     |  0
> > >  .../maintainer/maintainer-entry-profile.rst        |  2 +-
> > >  MAINTAINERS                                        |  4 ++--
> > >  8 files changed, 19 insertions(+), 8 deletions(-)
> > >  create mode 100644 Documentation/filesystems/xfs/index.rst
> > >  rename Documentation/filesystems/{ =3D> xfs}/xfs-delayed-logging-des=
ign.rst (100%)
> > >  rename Documentation/filesystems/{ =3D> xfs}/xfs-maintainer-entry-pr=
ofile.rst (100%)
> > >  rename Documentation/filesystems/{ =3D> xfs}/xfs-online-fsck-design.=
rst (99%)
> > >  rename Documentation/filesystems/{ =3D> xfs}/xfs-self-describing-met=
adata.rst (100%)
> >=20
> > I think the rst filename should drop the 'xfs-' prefix, e.g.
> >=20
> > 	Documentation/filesystems/xfs/delayed-logging-design.rst
> >=20
> > since that seems to be what most filesystems do:
>=20
> Actually, ignore this suggestion.  I forgot that I have vim paths
> trained on the Documentation/filesystems/ directory, which means I'll
> lose the ability to
>=20
> :f xfs-online-fsck-design.rst
>=20
> and pop it open.  Not that I expect many more filesystems to grow online
> fsck capabilities, but you get the point...

So is it OK to just move the the docs and keeping their basename intact (as=
 I
did here)?

> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ea790149af7951..fd288ac57e19fb 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -23893,10 +23893,10 @@ S:	Supported
> > >  W:	http://xfs.org/
> > >  C:	irc://irc.oftc.net/xfs
> > >  T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > > -P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
> > > +P:	Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
> > >  F:	Documentation/ABI/testing/sysfs-fs-xfs
> > >  F:	Documentation/admin-guide/xfs.rst
> > > -F:	Documentation/filesystems/xfs-*
> > > +F:	Documentation/filesystems/xfs/xfs-*
> >=20
> > Shouldn't this be "Documentation/filesystems/xfs/*" ?
>=20
> ...though this suggestion remains standing.

OK, will fix it up in v3.

--=20
An old man doll... just what I always wanted! - Clara

--/eNx4OrSdA7OOxOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWbkbQAKCRD2uYlJVVFO
o757AQD9Ejtcv8+azDThzWPWiwdN8rQV3SamIEbhm6K4/76GngD/fxUlqtAWi9rD
XNZI+P3xF/P1UWcrtV0NE0VOBuZzhgU=
=Fq99
-----END PGP SIGNATURE-----

--/eNx4OrSdA7OOxOK--
