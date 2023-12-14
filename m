Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723AB81353C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573906AbjLNPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573889AbjLNPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:51:23 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9410F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=SWD5
        0egKwLc0Rybwi1RAvz7QScMU5f/Ur7h95KrgliU=; b=j2tM1WaStkNaKN+yr1RR
        s50Kn/z2eapPW+OrIq8j0AnGUlzSEezIVhXFoiijiVysPGSsQ3DQ+QeiWkyHwy72
        yPkF3Jiky+QwoC02lGZK7uB+jzALuEzaeEBP08NxUDS5YipV+mdFt2uIZMY2rqkj
        zThG5pSGjdVjzbF+xocSH5wrWyevC+AEP+T7IUa/Lwx4o8r2tOFuXupLJYFd8F/d
        32x9jiaVL2vKgbye2+0Bz3zYs33WXQtsaSQlHpxcTiS6dh3OU7H2hE72NurAs7mX
        m1chOTFGgbI5DIpPNY+ilgzX/WVfXfucLH/pZhM83uXL8kGLah425UFOc4T1pV2/
        Vw==
Received: (qmail 972578 invoked from network); 14 Dec 2023 16:51:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Dec 2023 16:51:24 +0100
X-UD-Smtp-Session: l3s3148p1@+qV/QXoMAMIujnuR
Date:   Thu, 14 Dec 2023 16:51:23 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 RESEND 0/2] PCI: rcar: support regulators for PCIe
Message-ID: <ZXske3k8CkMcGjr5@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iYf0e0WBJmy2fgy7"
Content-Disposition: inline
In-Reply-To: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iYf0e0WBJmy2fgy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2023 at 10:29:06AM +0100, Wolfram Sang wrote:
> Here are the patches to make PCIe cards work in slot CN15 on a Renesas
> KingFisher board. Please apply.
>=20
> Changes since v4:
> * rebased to 6.6
> * added ack from Mani (Thanks!)
>=20
> Wolfram Sang (2):
>   dt-bindings: PCI: rcar-pci-host: add optional regulators
>   PCI: rcar-host: add support for optional regulators
>=20
>  .../devicetree/bindings/pci/rcar-pci-host.yaml   | 11 +++++++++++
>  drivers/pci/controller/pcie-rcar-host.c          | 16 +++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)

Can we have this series in 6.8, pretty please?


--iYf0e0WBJmy2fgy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmV7JHgACgkQFA3kzBSg
KbY3KhAAn1LjgCchuymBK5WOFv1iQU8JHdrudMbyioMalewF7lH/NVT6vA2FPeNN
X5X0FZ6JmGyrnOj8qbkakl0iB1ZYf1lKOoGjiAVzS3qj2lxsP5NpBXX3yQuF2m2A
Ajc8wp0P6z2q11gWkVHjYnDAW1SawtLSJtHhsFdfDL9WzTOXO01CDYU87Rshckno
Ckyjo9Mc69R8XNdsubdYzIipRBQGnFuz6lTjYXlJvWk/siwTPc95pB9fmF398eJn
DIoqYPBccsb4484o9oJ5LUlG/pov1ud7kPsKu197A1SaxUwS3j+C/ghIhTl3Rq7W
jpK2eZp/tGyfPnkr72niLCJvd+mkwg6EB4Xy9tocBMgUsK0JG7dBzuD5AJopbOVu
fm94Wc2/mKaUXVdMY4REG9u4kLMl3v9RZxlbtqvv4aSHobnIGWX2jkMmrnm5ztQf
HbK+X809vP3owl++JmD0K+CjxLNusiYqVHZmfbXgR5IzlnLCgShsROPquuVT1bvG
EJti4TXSAxUU8zbDDEoBF7xcaxiynRlsg9NROsQ3hs60rz6JYAG/oxdnv050juSV
bIwnZLSAdaYbx8UxevSSX+TXxMjzUmBHvyj96w09U0ckVTcz4AEm4gH2lXppL3qi
8bwbzUJ2CV3ZlsYOgBTdgWpPFQIqm8XVgnB9TyFX4FpPmBtP8UE=
=8XDE
-----END PGP SIGNATURE-----

--iYf0e0WBJmy2fgy7--
