Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD58C7DE9A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjKBAog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjKBAoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:44:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2EDB;
        Wed,  1 Nov 2023 17:44:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc2fc281cdso3156495ad.0;
        Wed, 01 Nov 2023 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698885868; x=1699490668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seBFQ0Xl2FFi4ZCFH7eeqfsh3gca8oZxDWO/3FOsFOE=;
        b=mnTD4L4SJshwKCXQxufSRHwCq6Lrx9/xJAOBJGo1pEpIvxw8R2MH3Ze2OIcBzICdSj
         gnTo6kJP3Q4D6FrkOZK8SuBh5EJNP5OxQOLqSX1R2HBVpDatM4HkMBMvEFDmD/YEpryP
         JalAA3kbKWGNUVvK+MSKMmuky9cKH58kggJtGQ5QBbP2l6t/TJrVw9ImHUj9X7Uo4StV
         /uX1p6d/b12XOE2b2H+rYL6V7yfa6AAdyZXrcwEzTNumuSVFKTk967ici9+vVa92EEIL
         vqh3f7C5wt3RPcZEN4l51yMcX9ZfceMQDHrypMuXhPVc2zq5hTKtErHPHb0VS5sb0wxq
         cS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698885868; x=1699490668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seBFQ0Xl2FFi4ZCFH7eeqfsh3gca8oZxDWO/3FOsFOE=;
        b=jGTWSEZt9J2PzjkXHGtkQd04Rp5TfORLA+ceHO3U7J51dulrVg/fZwWXWtxQz6kF9D
         MKhmMlcwXI6U/FNQ11ZwqezaT7gCF1LeSjye3PxSJfx50tVJa282hpwRCREhsaqFzjul
         2yAYe9ZdXqwjfVTmnDkEr0ys3N69T1U8T4+AWkaavTMQARtyCf5erqrVocDiEQOaPfTp
         ev9P1n0oYpE2BvzxPZljN5VTJmSjtMLtwJKyLwDGUKuZtNgKG+cQxvPzaUo2hoiHKzLs
         nkZH33VQQt4INtnecXiAlMRROAplgbHbhlg10Bwk2GPQe1wrRu2acHe5GqH5LcFulqUu
         BnYA==
X-Gm-Message-State: AOJu0YxlCcoKqhusa+mFtayfN2D97qf428HyvoD024tRBkt1IG+PnzA1
        1n5FbVPPiQAj5ReqSfVq0wOQ3obRUa0=
X-Google-Smtp-Source: AGHT+IHAQYJfgzPpoY+n5ml6qcBK09ayc4zFRGBOp7MF/Oo0752z6Lk7NUXYU20g7DzP9loSa5PELQ==
X-Received: by 2002:a17:902:e494:b0:1c9:d948:33d5 with SMTP id i20-20020a170902e49400b001c9d94833d5mr10681928ple.64.1698885867926;
        Wed, 01 Nov 2023 17:44:27 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902bd4600b001cc2a6196b3sm1830196plx.197.2023.11.01.17.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:44:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 56C6C93F72A8; Thu,  2 Nov 2023 07:44:24 +0700 (WIB)
Date:   Thu, 2 Nov 2023 07:44:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiri Kosina <jkosina@suse.cz>,
        David Revoy <davidrevoy@protonmail.com>
Cc:     "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "ilya.ostapyshyn@gmail.com" <ilya.ostapyshyn@gmail.com>,
        Nils Fuhler <nils@nilsfuhler.de>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Requesting your attention and expertise regarding a
 Tablet/Kernel issue
Message-ID: <ZULw6AcBaD6z2UZA@debian.me>
References: <kRKTNDYigUSblpNgSuZ2H4dX03Of1yD4j_L9GgbyKXcDqZ67yh5HOQfcd7_83U3jZuQzxpKT3L6FXcRkkZIGdl_-PQF14oIB0QmRSfvpc2k=@protonmail.com>
 <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9o0Xepcqt2gKLUfm"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9o0Xepcqt2gKLUfm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 08:37:40PM +0100, Jiri Kosina wrote:
> On Wed, 1 Nov 2023, David Revoy wrote:
>=20
> > Hi Jason Gerecke, Jos=C3=A9 Exp=C3=B3sito, Jiri Kosina and Illia Ostapy=
shyn,
> >=20
> > I am emailing to draw your attention and expertise to a problem I had=
=20
> > earlier this week with my Xp-Pen Artist 24 Pro display tablet under=20
> > Fedora Linux 38 KDE after a kernel update.
> >=20
> > The second button on my stylus changed from a right-click (which I coul=
d=20
> > customise with xsetwacom or any GUI like kcm-tablet) to a button that=
=20
> > feels 'hardcoded' and now switches the whole device to an eraser mode.=
=20
> > This makes my main tool unusable.
> >=20
> > I don't have the skills to write a proper kernel bug report, workaround=
=20
> > or even identify the exact source of the issue. I have written a blog=
=20
> > post about this with more details here:=20
> > https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-styl=
us-need-help=20
> > , contacting you was something suggested by the comments.
> >=20
> > Thank you very much if you can help me.
>=20
> CCing a couple more people involved both in 276e14e6c3 and 87562fcd1342,=
=20
> and mailinglists.
>=20
> This is almost certainly the behavior introduced by 276e14e6c3, where=20
> previously the button was mapped to BTN_TOUCH, but now it's mapped to=20
> BTN_TOOL_RUBBER, causing user-visible change in behavior.
>=20

Thanks for the report.

David, can you resend the regression report as plain text email (preferably
with 276e14e6c3 people and regressions@lists.linux.dev Cc'ed)? You may need=
 to
see kernel documentation [1] for how to configure your email client to send
plain text emails. Also, include in your report details from your blog post.

Thanks.

[1]: https://docs.kernel.org/process/email-clients.html

--=20
An old man doll... just what I always wanted! - Clara

--9o0Xepcqt2gKLUfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZULw4gAKCRD2uYlJVVFO
o86rAP0W2BDBLg9e3Lkm88CSq8pcy8WkJ1Y4HS6bDeKTlqYRvwD/U0tzcKJNLcoa
LsAndetDQD2noUF/v9fjupmto76y1AQ=
=MVKr
-----END PGP SIGNATURE-----

--9o0Xepcqt2gKLUfm--
