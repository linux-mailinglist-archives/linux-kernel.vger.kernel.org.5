Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9D7A032F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbjINMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjINMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:00:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1CCF3;
        Thu, 14 Sep 2023 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694692807; x=1726228807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uG+F151bn68ScYDGWITqHNnwQWlUdsnNin/8aUVHZQI=;
  b=GimvMVz2wD0+XgspDfRNe1NJxUCCAEnGKtzBYLmPlSL8eWJlTM9Fzue2
   V94SE2gGua5R4qj/pjl7J8KVCJvl5lGSv1a853u28l8c+3Fe1atz1gle5
   PO7kM0sXFxCy091NB4wCbwT4a3O3tiIkHt9huYyzQdLwQryHzcQ1DafZK
   f/eExfbUQ2+PLzFc9U/YkyNS5npaWlX6tQtqVgx0kjQiolOOlvfwIcONn
   mLD5oc/EArOcKoo07udJNU7v0zzOb4fLxb/6/EiKgOVP9TWG2Zq8ewFlY
   3gAGJMxiISXuhl0PpEbSq0ZkTGiquujlS2Z5YGCPXxPws5LOSVWHyIA1e
   g==;
X-CSE-ConnectionGUID: ws0ewmwgSamnGX1tUsKhPQ==
X-CSE-MsgGUID: /eszNVWGQ2CCv9ifskaUFA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="asc'?scan'208";a="4651647"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 05:00:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 04:59:56 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 04:59:54 -0700
Date:   Thu, 14 Sep 2023 12:59:38 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH 13/17] pmdomain: starfive: Move Kconfig file to the
 pmdomain subsystem
Message-ID: <20230914-delegator-dimple-51b9414caa28@wendy>
References: <20230914111904.586744-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2kgF3gAKLh1ZoVxp"
Content-Disposition: inline
In-Reply-To: <20230914111904.586744-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2kgF3gAKLh1ZoVxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,


On Thu, Sep 14, 2023 at 01:19:04PM +0200, Ulf Hansson wrote:
> The Kconfig belongs closer to the corresponding implementation, hence let=
's
> move it from the soc subsystem to the pmdomain subsystem.
>=20
> Cc: Walker Chen <walker.chen@starfivetech.com>
> Cc: Conor Dooley <conor@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for doing this, saved me having to!
The series appears to have broken threading though, which can be seen
pretty easily on lore:
https://lore.kernel.org/all/20230914111904.586744-1-ulf.hansson@linaro.org/
Dunno if something is borked with your process while sending patches to
only a subset of the total recipient list.

> ---
>  MAINTAINERS                                | 2 +-
>  drivers/pmdomain/Kconfig                   | 1 +
>  drivers/{soc =3D> pmdomain}/starfive/Kconfig | 0
>  drivers/soc/Kconfig                        | 1 -
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/{soc =3D> pmdomain}/starfive/Kconfig (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b491ebcf790..b8eae18f0fb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20523,7 +20523,7 @@ M:	Conor Dooley <conor@kernel.org>
>  S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>  F:	Documentation/devicetree/bindings/soc/starfive/
> -F:	drivers/soc/starfive/
> +F:	drivers/pmdomain/starfive/

This isn't the correct change, just remove the drivers/soc/starfive
bit entirely from this entry.=20
I've just been doing some review & sending PRs to Arnd for this stuff
(or failing to send the PRs as you saw), I don't have particular
interest in this driver other than helping out the starfive people with
actually getting the code merged.
Instead I think you should generalise the existing entry for the driver
to cover the whole directory, so that it includes the Kconfig bits too:

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7487b7729b..22c1a5e5b130 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20564,7 +20564,7 @@ M:      Walker Chen <walker.chen@starfivetech.com>
 M:     Changhuang Liang <changhuang.liang@starfivetech.com>
 S:     Supported
 F:     Documentation/devicetree/bindings/power/starfive*
-F:     drivers/pmdomain/starfive/jh71xx-pmu.c
+F:     drivers/pmdomain/starfive/
 F:     include/dt-bindings/power/starfive,jh7110-pmu.h
=20
 STARFIVE SOC DRIVERS

Thanks,
Conor.

> =20
>  STARFIVE TRNG DRIVER
>  M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index cfe9ea754062..67049ebf7265 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -12,5 +12,6 @@ source "drivers/pmdomain/renesas/Kconfig"
>  source "drivers/pmdomain/rockchip/Kconfig"
>  source "drivers/pmdomain/samsung/Kconfig"
>  source "drivers/pmdomain/st/Kconfig"
> +source "drivers/pmdomain/starfive/Kconfig"
> =20
>  endmenu
> diff --git a/drivers/soc/starfive/Kconfig b/drivers/pmdomain/starfive/Kco=
nfig
> similarity index 100%
> rename from drivers/soc/starfive/Kconfig
> rename to drivers/pmdomain/starfive/Kconfig
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 8b46da40f107..10a9ff84ff41 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -23,7 +23,6 @@ source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
>  source "drivers/soc/sifive/Kconfig"
> -source "drivers/soc/starfive/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
> --=20
> 2.34.1
>=20

--2kgF3gAKLh1ZoVxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQL1qgAKCRB4tDGHoIJi
0rVzAP9FY/ohd7on51vpfRecEpZAePbMsVUzl1EtVecCPOByggD/QiEkAxaXSUc9
B0yAQH4pjtfwzPASaPXW/nVoCDWDSQk=
=22dE
-----END PGP SIGNATURE-----

--2kgF3gAKLh1ZoVxp--
