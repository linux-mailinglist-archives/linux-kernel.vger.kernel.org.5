Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8D79EB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjIMOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:43:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A85591
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:43:45 -0700 (PDT)
Received: from mercury (dyndsl-091-248-208-175.ewe-ip-backbone.de [91.248.208.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6AAC6607341;
        Wed, 13 Sep 2023 15:43:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694616223;
        bh=45c5gw/f2jBbyJLhmpXqI2WamtRnBzbETao/nifAbys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbNIquAj9HcChNrpbB3TnOOJK8C+DH65aCaaEYo+Cwknu6g9wyUu4UcEPx9pKvrhe
         PZQZkm03AsVscnb5msvheRmMHLaxu813A/+LEWCzsEsDWwaf/JSU6OPiWyiJ0Xc5AE
         FmIWXAK22CVO0g/YX5k1lsaj5YVWen4fZUOAlqrT42gOhcz1ENVowuntOfISNRFTpq
         C+xGan02w+ZdhL9GyTKqqzlR5EDgSCA0zoEzUEM9nZDCChwFhRLeQPCeisTIKbKuon
         mut2P2FJGvF9VidzNYES3J9gQy3+jhGRDNCAE00y+f4J8idGP/WvDf5hJ6w/07FmGx
         6k5TrUUmvoMnQ==
Received: by mercury (Postfix, from userid 1000)
        id D2377106098A; Wed, 13 Sep 2023 16:43:40 +0200 (CEST)
Date:   Wed, 13 Sep 2023 16:43:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <20230913144340.l2vg6wtq56lnzejn@mercury.elektranox.org>
References: <202308280602.nE6xa80J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kg7dkqg6i3kdnmsn"
Content-Disposition: inline
In-Reply-To: <202308280602.nE6xa80J-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kg7dkqg6i3kdnmsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Mon, Aug 28, 2023 at 06:19:22AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   85eb043618bb17124050197d71c453d4a1f556e5
> commit: 29e8142b5623b5949587bcc4f591c4e6595c4aca power: supply: Introduce=
 Qualcomm PMIC GLINK power supply
> date:   7 months ago
> config: i386-randconfig-061-20230828 (https://download.01.org/0day-ci/arc=
hive/20230828/202308280602.nE6xa80J-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230828/202308280602=
=2EnE6xa80J-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308280602.nE6xa80J-lkp=
@intel.com/
>=20
> sparse warnings: (new ones prefixed by >>)
> >> drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse: incorrect =
type in initializer (different base types) @@     expected unsigned int [us=
ertype] battery_id @@     got restricted __le32 [usertype] @@
>    drivers/power/supply/qcom_battmgr.c:357:31: sparse:     expected unsig=
ned int [usertype] battery_id
>    drivers/power/supply/qcom_battmgr.c:357:31: sparse:     got restricted=
 __le32 [usertype]
>    drivers/power/supply/qcom_battmgr.c:369:31: sparse: sparse: incorrect =
type in initializer (different base types) @@     expected unsigned int [us=
ertype] battery_id @@     got restricted __le32 [usertype] @@
>    drivers/power/supply/qcom_battmgr.c:369:31: sparse:     expected unsig=
ned int [usertype] battery_id
>    drivers/power/supply/qcom_battmgr.c:369:31: sparse:     got restricted=
 __le32 [usertype]
> >> drivers/power/supply/qcom_battmgr.c:1286:30: sparse: sparse: incorrect=
 type in initializer (different base types) @@     expected restricted __le=
32 [usertype] owner @@     got int @@
>    drivers/power/supply/qcom_battmgr.c:1286:30: sparse:     expected rest=
ricted __le32 [usertype] owner
>    drivers/power/supply/qcom_battmgr.c:1286:30: sparse:     got int
> >> drivers/power/supply/qcom_battmgr.c:1287:29: sparse: sparse: incorrect=
 type in initializer (different base types) @@     expected restricted __le=
32 [usertype] type @@     got int @@
>    drivers/power/supply/qcom_battmgr.c:1287:29: sparse:     expected rest=
ricted __le32 [usertype] type
>    drivers/power/supply/qcom_battmgr.c:1287:29: sparse:     got int
> >> drivers/power/supply/qcom_battmgr.c:1288:31: sparse: sparse: incorrect=
 type in initializer (different base types) @@     expected restricted __le=
32 [usertype] opcode @@     got int @@
>    drivers/power/supply/qcom_battmgr.c:1288:31: sparse:     expected rest=
ricted __le32 [usertype] opcode
>    drivers/power/supply/qcom_battmgr.c:1288:31: sparse:     got int
>=20
> vim +357 drivers/power/supply/qcom_battmgr.c
>=20
>    350=09
>    351	static int qcom_battmgr_update_status(struct qcom_battmgr *battmgr)
>    352	{
>    353		struct qcom_battmgr_update_request request =3D {
>    354			.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
>    355			.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
>    356			.hdr.opcode =3D cpu_to_le32(BATTMGR_BAT_STATUS),
>  > 357			.battery_id =3D cpu_to_le32(0),
>    358		};
>    359=09
>    360		return qcom_battmgr_request(battmgr, &request, sizeof(request));
>    361	}
>    362=09

It looks like  battery_id should be __le32 in 'struct
qcom_battmgr_update_request', care to send a patch for that?

Greetings,

-- Sebastian

--kg7dkqg6i3kdnmsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUBypYACgkQ2O7X88g7
+pq/rw/3SEKux/ZBackYrIw9y9Z/kn115vH7rfdk3/pfhpgjpVVGENZso9k+tHE5
lj6/Fu6Dbe2e0qQWYEDSxRrMVvSrJsEKYdt9j+s9r+0DseOJQkzXIIq3LNzLrN5F
t3Cntgfn5XZiA0RaIEuRQAZSTcU37bYVc5F/JQ3WmENF39dfFSS7EQJvSZSxJ5RR
6ET1iKroiMbxnFvM1UDDxyMgl0tr66e85es4zm4V2D4F/LwHmsprfgTfLtQs7izT
l8NkyKy2MYbe0TsVT5ombTwsaXcg8A03jgb3m32gI6Z5MUzcVFw9Ke+uWRHgVCF6
7f+hoRjk3bhdgex0g+XjLRO3AeuIoNo9JGhbezTaOJClSu6Ew7vw7Z6N4y5df4e3
XoruytZrG/Ck4cLJ4ypgHcKzLBk2bSF8/h/IBls484pX4XAm1PuPGWQuObNII45S
SEz1/6vSRs4KlCeJMcx7JT0IrTCdK5d78UHLk3T2fdK7afH8blL+PoDLDqLZQOhf
WADrZ6mTE0xR7UtQhp+Q43Ra4eWRSbL1+HzydaPuFjFFtZdpg+PorQYXNA/UcgeH
j8i/fRqqoLfB/GlCI2ihh6W0zX/nXFv9hz1cjReu/Ldma/6Vw4zwn+tHCD/4LEN8
A1FOp6px43ciBsvYSxiUfUBrl9UQAvtkpMPjSbOjiXz4plQbJg==
=xOI2
-----END PGP SIGNATURE-----

--kg7dkqg6i3kdnmsn--
