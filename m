Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B77AB8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjIVR5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjIVR5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:57:15 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20DE99
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=Mg2A
        AnBs+prhkh2fk1Nlp3ajuJgPByOE0d0i3KeOkV0=; b=QHbiAQioaRK0OoiLUGt/
        4QE7q6HgEadfjVQbNEMZ7LYUvcnKFHWh+3jivr4h3RMf+tJJP1q5FlzahYH3Z1Si
        abfr2nlp9vmNzIMNQFpRKQv4MhPGRlEYrFqHMtboVsfhHn3I9wVC8zGpXXFjPKnh
        Pv7JVqH3GC5CRZ/DuTOd65zMZzNga4XBh9DOgX0LF7ScKbulllPrxCIcZn032XTw
        d5lzdU6txXo7glxm4DSq3k8+3pNflky8LvYxDosO9zu/bjOpFEBVQNtDbeNPb3Vg
        I0G6AA5uS+Tm5HfKKsrIZkkWhcu4xEdaVjYnIwYO8jdEY5b7dxJeF+83lpv+LphF
        vg==
Received: (qmail 1457883 invoked from network); 22 Sep 2023 19:55:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 19:55:16 +0200
X-UD-Smtp-Session: l3s3148p1@52CbT/YFGL0ujntX
Date:   Fri, 22 Sep 2023 19:55:15 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/6] mtd: parsers: ar7: remove support
Message-ID: <ZQ3VA/2pAC3Do1Xd@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
 <20230922163903.3f49ea2a@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CN+XZjYK9gPYPfl3"
Content-Disposition: inline
In-Reply-To: <20230922163903.3f49ea2a@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CN+XZjYK9gPYPfl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I'm not sure it is wise to merge defconfig changes through mtd. Would
> you mind sending this change aside to avoid potential conflicts? Each
> patch can live on their own anyway.

Yup, I can send a seperate patch for it.

> >  drivers/mtd/parsers/Kconfig    |   5 --
> >  drivers/mtd/parsers/Makefile   |   1 -
> >  drivers/mtd/parsers/ar7part.c  | 129 ---------------------------------
>=20
> Do you have other changes related to this file in your tree? It failed
> to apply on my side.

No change. Plain v6.6-rc2. I used "--irreversible-delete", though. Maybe
this is causing issues? As I stated in the cover-letter, I wonder if all
this should go via MIPS. But there hasn't been any discussion about it
yet.


--CN+XZjYK9gPYPfl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUN1QAACgkQFA3kzBSg
KbZzCQ//TX27sNa/UiZIFCSjrAOOgSLQI0+z9odUjS9rOBLtm+a4sP6VuQ+BRhtR
oIPlyJLa38QdDr35LNQz/LY4WOiayV54t6djG0/MNJ63qs9J3RmyxiND3k54qAH1
eGH/zKhVYb4KfSkKF3svjKsAp6eMxVcBopzx2cE0/SBkKwSjmRoOjIaQboVsOrn+
9BLuKCGYc0PktzaUzRB5icMFC/qVquafZIcS2J7G9BbOf+BJ56XwxvIbX/9QhXMU
NXhStndkoVEQlV+Um/uojiFwT37aChkDuhjqZXaSn5IN2ILGFsqcVxRaX/TSrQOP
5QE6UbqmzOi95oQmPxDtPDL1KOy4nvKD+KQVQE6A27dFu9o6QWCF4WDrH5Umz4hH
OPhUg/ipYgoUXk8+B1YqafwXVdjlFf+h+5CGT8BA1pEvOGmFiIdqJy4Ly73JtsiA
Dba3cHm1FwDzs/egxuhWEzKE3IOeTRhEaMryRi3kHXgAmA109vnIYht/dvKcWXPL
t8NDtnvtHdRSeffihZXLwenSsat1zykrGWg9D2cv7+ID/GvUXXFFf5Ypz6MfCp0C
yIczQ0YqQ85CiJFPMEUOQ0YyrDWXKb6GmsawzmZWLQV+pMTLLjcwnxcqp+LOEZA9
VNr7z+4ueA1bfcf/umTJuytOx4Y8ihy/4pSRlPkyV4n14K3407E=
=Toah
-----END PGP SIGNATURE-----

--CN+XZjYK9gPYPfl3--
