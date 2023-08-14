Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3877BD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjHNQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjHNQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:06:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC18115
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:06:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EG6fsB100334;
        Mon, 14 Aug 2023 11:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692029201;
        bh=uqF9OqR3R8LvOfHh/ymJRQ9sXW7fcIv46wNvEuG77Oc=;
        h=Date:From:To:CC:Subject;
        b=lGBmU/DEHk9qdLFXKYTZyElyDokKuqyaWpCOo6xGJV5GsKWzHqmP71dT8uTGxSXDj
         lEszObQs7OKYxLX7LnEew5+OlU0piyYYP4iL4Acz6PVT8FW8s3MJBsxJ8WzW/WAp5c
         opm4jTEemhS5vfleD6qqP0cdmgCaHCoQGTXh4DsU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EG6f5A016669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 11:06:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 11:06:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 11:06:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EG6f3w107889;
        Mon, 14 Aug 2023 11:06:41 -0500
Date:   Mon, 14 Aug 2023 11:06:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [GIT PULL 2/4] arm64: defconfig: TI K3 updates for v6.6
Message-ID: <20230814160641.p2h42vaeqff4r3br@cyclist>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6wrpdrj42appqr6"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--t6wrpdrj42appqr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

There is a potential merge conflict with imx-ms tree that Stephen caught
during linux-next integration (depending on order of merge).

Please see Stephen's resolution here:
https://lore.kernel.org/linux-next/20230803092245.4c0fc299@canb.auug.org.au/

With that, please pull:

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-c=
onfig-for-v6.6

for you to fetch changes up to d5c988b43746de250bed33c17116e879f032ff12:

  arm64: defconfig: Enable ITE_IT66121 HDMI transmitter (2023-08-11 15:47:1=
5 -0500)

----------------------------------------------------------------
TI K3 defconfig updates for v6.6

- Various configs for K3 boards including ECAP, Thermal,
  RTI watchdog, mailbox, sound, MCAN, UFS.
- Enable PRUSS for am64/am65x boards such as IOT2050.
- Enable IT66121 for BeaglePlay HDMI.

----------------------------------------------------------------
Aradhya Bhatia (1):
      arm64: defconfig: Enable ITE_IT66121 HDMI transmitter

MD Danish Anwar (1):
      arm64: defconfig: Enable TI PRUSS

Udit Kumar (1):
      arm64: defconfig: Enable various configs for TI K3 platforms

 arch/arm64/configs/defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--t6wrpdrj42appqr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmTaUQkACgkQ3bWEnRc2
JJ1BYg/+MYRjNH0zzBI8r+d/GO2w93jq7F41R4DsNf8XKs4sRN+yAmnr7OClw2KX
t8Vv3pwR4ETFmMzdXuQCqcOGejf2xUPxrJ2IjRxizCmgT/H4cmD/HZfLgwKof5SD
XoaK/0xeg8kdrzCDo25a4d+XJGwYSc/vNgzFxrv2I0/QeuLzbniIQ/TRn/U9O9V8
ZODU80HP+Ds/fRd3Tx+FknLRtkb8DmuM+Visczsmcf++rgFi2RSu7sD/h8e+NPvo
dWKlJtqMZk4qGEoZLMR/dGmsTDzoLfOiEZTLobOg6wjkX96Q3AcsNR0XFPGFTZr6
A1nZ+x9TAD7w1Nmo/Y85F1Q9uK24ig8vig3Q2xEZJrU+std0E4KCIi+isEnvzcw/
2f0UhQBmUbcrMNL/yPK5CeMkVATMFMg5ocaJQnGJVBxbKQ8sLuR5l58t2LUu8g8v
6EaqovmgYfKA5cn6g4QpwORfk+RUVfZF56rLGX/PzBODxBTvUgX4jN9hKxP8qdNr
tWBZsaLeW2ps6UTtmmT5E9kjEaQorBOc7N6a0s1SDNNr4uLMKkwJVP7R1yaSVxhf
KhBwwQ/49A+n1dH61sqQ6haiSyrSKW/LTdti56ZC8E2B3NW5Nr9FkPrmytyqOebT
ubpzVWUyHHjw3ilGBBjOa1zFs7qL1hdwsPTOJmESDfw/OcoMDPU=
=4qKa
-----END PGP SIGNATURE-----

--t6wrpdrj42appqr6--
