Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073B080E2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjLLDaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLDaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:30:10 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A28F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=7j1q
        X8z52KuXraBMzAtOl6IRRhMS8zm7c0md0ogC1JY=; b=Tsm85U0Ihvrghwni3NMn
        6FJXQLRLhowFJi0xEBtulVGh8z30qslr6ON9rRK3zepkNiFLcQmOj493+s8nVLG2
        DvD5wCsR6pI7pCgu4qbp25F1d7hizSvTysGT7k79n7HdxnS362DONDLPHbd65KBB
        eTC3mu1xGCdH3vHXDBAMI5oQzx4ff0UdSnebcrOjve69nUniS3/q4xx87aDY5Vbi
        JClcj5+9ry6F+1ctLfj8EeV6lpgCjyH6Vy5LwRBD/5pGwBzcsbJyXBSxJZEhKDsv
        Lo0MLXIfWSaY4XQOzN+eoNH6+BY6/m2kwsZcA+dtjgTKmSwhLu7nmos3IzDelBNA
        LQ==
Received: (qmail 73350 invoked from network); 12 Dec 2023 04:30:11 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Dec 2023 04:30:11 +0100
X-UD-Smtp-Session: l3s3148p1@YxD8qkcMZoUujnuR
Date:   Tue, 12 Dec 2023 04:30:10 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] gnss: ubx: support the reset pin of the Neo-M8
 variant
Message-ID: <ZXfTwscAltoVY1lV@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hj4t0zCQoMhrc7P"
Content-Disposition: inline
In-Reply-To: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0hj4t0zCQoMhrc7P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:51:48PM -0500, Wolfram Sang wrote:
> The Renesas KingFisher board includes a U-Blox Neo-M8 chip with its
> reset pin wired to a GPIO. To support that, we need "reset-gpio" support
> (patches 2+3). But first, simplify regulator handling with a new helper
> (patch 1).
>=20
> Changes since v4:
>=20
> * don't touch reset during open/close. Only deassert it during probe.
>   [patch 3]

Johan, all good now?

Happy hacking,

   Wolfram

--0hj4t0zCQoMhrc7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmV308IACgkQFA3kzBSg
KbZuZQ/9GAXoJn55ZidUvDeVt3ZjpXMA6CgQUFZ/CkUK15/EPGxfTQgOvve7E8aC
giXtMn8psTKmLDvtuy5z91aILF3yEd7CdCy3RvaVkkj7+5bSue82qKGc+E/zGQWH
6m871dzqG+Gae+xQUM61LkaOUt35yQXosz82fqHO7MP8DQ/3KRowQEhq1MvOioxG
G+NXtpM7rKEdYRih4esPY19chmR1gxbFIeUnCvuWsGIv3Fl8Y8kfrYRZI8iM6mW3
/+ILC6c6Ph8X6iI/2QdBcjYwHjYIQRJEtsuaRLOvFuUqLORLAafieswI8pya677X
tLFpjlkiP2h9TO3RiHhPdbUJ0Qy36Ap+zmKAFk3jagZXLcvUKPG2Wg8OqPGZBWbR
kcqjHwWbZE8mu6kq8YZzjatsDwumKMBnVxsCT8DEKv4lUtvXsP1NcHHthZStsJas
RVgEJwV4pI+X49WT5P90cuwKX0/NAHZRPJukloMU/xwQGpFhl8uSWWYjrzaCmxOY
oL3yWYCftk9y2+MIZvpL5PnLxeugpNWo+AoSAITmsi0Jo+z8kjz8jehTD7m+5c/K
aPye+2wWCnzul0PB2glhEhAhaejIRKvPP55N6KwvRaUGRMYkKmSJ75Jg/XyHCpy/
A3B3O/cz4MrDNkMkKQXI8+LmUtVHm0x/OQ23FCCXlNKQLR7Oxws=
=krY1
-----END PGP SIGNATURE-----

--0hj4t0zCQoMhrc7P--
