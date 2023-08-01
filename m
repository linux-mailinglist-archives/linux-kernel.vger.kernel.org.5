Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278F76B2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHALUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHALT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:19:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CF4EE2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:16:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230801111648euoutp02e6999cf93122ddc02937e0083d1ce526~3PjsfNnYd1000210002euoutp02k;
        Tue,  1 Aug 2023 11:16:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230801111648euoutp02e6999cf93122ddc02937e0083d1ce526~3PjsfNnYd1000210002euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690888608;
        bh=3AVsp4hmnXH9m3E6YREMBsTFIMTCdmAHJl4kZVdzA/4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=j8P3y1uXyAR7Ke7HgHrrEGtp7EYZmjwIFV+3DFyNoPiz9SS096Gh5Ay84/iKphZRA
         3C++vJv1SUT4tBf8d4fshkb6FSBMR8tDNDYntwtTOfEjmb3IkYcpagm43rgF0JCk3g
         VK9Sp6B4A5e0opoux02w4/A5t0B3AQue2RMR8dAY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230801111648eucas1p1c5750ce0e0b32a914068d8e5c1e209d1~3PjsS8U2M3065030650eucas1p17;
        Tue,  1 Aug 2023 11:16:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.2B.42423.0A9E8C46; Tue,  1
        Aug 2023 12:16:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230801111648eucas1p1ed0ae759c5f4471ffff404fb4da66e28~3Pjr6NgaK0753907539eucas1p1S;
        Tue,  1 Aug 2023 11:16:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230801111648eusmtrp2feb0a05c52a399170986908f74982577~3Pjr5mYlc1834818348eusmtrp2f;
        Tue,  1 Aug 2023 11:16:48 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-3e-64c8e9a055dd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 49.02.14344.F99E8C46; Tue,  1
        Aug 2023 12:16:47 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230801111647eusmtip24307508dd4ec273953f7c3e40cd9af72~3Pjrq4y-R0033900339eusmtip2A;
        Tue,  1 Aug 2023 11:16:47 +0000 (GMT)
Received: from localhost (106.210.248.165) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 1 Aug 2023 12:16:47 +0100
Date:   Tue, 1 Aug 2023 13:16:46 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Steve Wahl <steve.wahl@hpe.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Robin Holt <robinmholt@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] MAINTAINERS: Some SGI-related cleanup
Message-ID: <20230801111646.pw2rndtbmwilutg7@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="zm3oqxvgovdihrgq"
Content-Disposition: inline
In-Reply-To: <20201019203533.GA1203217@swahl-home.5wahls.com>
X-Originating-IP: [106.210.248.165]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7djPc7oLXp5IMTiyUMZi0oz/zBYHml8y
        WXQtNLC4vGsOm8Wbp6tZLC4dWMBkseLNXGaL/a/XA4kpa5gtNm+aymzxY8NjVgduj52z7rJ7
        7NrVyO6xeYWWx6ZVnWwe786dY/d4v+8qm8fnTXIB7FFcNimpOZllqUX6dglcGQ8n/2EvmCVZ
        se7tBJYGxh2iXYycHBICJhKfF81g62Lk4hASWMEoseJ+F5TzhVHi47ID7BDOZ0aJc1s3ssK0
        LLw1kRkisRyoZdF6JriqBxNnQ2W2APV3b2IDaWERUJGY+nIZC4jNJqAjcf7NHWYQW0RAWaLv
        6VVWkAZmgbdMEscufgUrEhawkvg5dSkTiM0rYC5x6/pFFghbUOLkzCdgNrNAhUTXuTVACziA
        bGmJ5f84QMKcArYSh/vvskCcqiyxpPUQlF0rcWrLLbBLJQT2c0rsXAmTcJFY2vqOHcIWlnh1
        fAuULSPxf+d8qIbJjBL7/31gh3BWM0osa/zKBFFlLdFy5Qk7yBUSAo4S81p8IEw+iRtvBSHu
        5JOYtG06M0SYV6KjTQiiUU1i9b03LBMYlWch+WwWks9mIXwGEdaRWLD7E6awtsSyha+ZIWxb
        iXXr3rMsYGRfxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZgGT/87/mkH49xXH/UOMTJx
        MB5iVAFqfrRh9QVGKZa8/LxUJRFe6d/HU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzatueTBYS
        SE8sSc1OTS1ILYLJMnFwSjUwVVurBE55KjKJ4bVw8CTmVyfb/kRfNe/5xfEzfmfBiuKD/UKJ
        xh/mnfcOZdWJEBMSDw5LnPz0b601+7rl3dwFZtOmX7c/WvVa9n/2xA8TrykFMmfz7LZoCj/i
        UN8fFhtdtNXI8Zlnz8M9q5ru3rx5xEG+uUvgg2JYyANO6w2nAkRyfcLXbf5lcWneb/ezK2Xu
        74675rz8oOXMgNVzL/mapf+duKY6sPHJ1dX3lZ/zLc+t6csRkhL3/194Wlr0w/0nk/YF+CYu
        Wj5DZH+nfAGf2xMe29ivSz41qioFzQ16EqzTnZHnxXpoxlpHHpeXJZ/bzrHE7Q9rd9Wt7172
        +2iSlLZwYvD+pMu7XzjFiOYqsRRnJBpqMRcVJwIAzFIy0v4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Pd35L0+kGOxbYWMxacZ/ZosDzS+Z
        LLoWGlhc3jWHzeLN09UsFpcOLGCyWPFmLrPF/tfrgcSUNcwWmzdNZbb4seExqwO3x85Zd9k9
        du1qZPfYvELLY9OqTjaPd+fOsXu833eVzePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sL
        PSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jEfPP7MWzJCsuPR1JXMD4zbRLkZODgkBE4mF
        tyYydzFycQgJLGWUePZiKhtEQkZi45errBC2sMSfa11sEEUfGSW622azQDhbGCU27N/NDlLF
        IqAiMfXlMhYQm01AR+L8mzvMILaIgLJE31OQSVwczAJvmSQO3lgD1iAsYCXxc+pSJhCbV8Bc
        4tb1i2DNQgI2Eq9e/2GGiAtKnJz5BCjOAdRcJvHkAD+EKS2x/B8HSAWngK3E4f67LBCHKkss
        aT0EZddKfP77jHECo/AsJINmIQyahTAIpIJZQEvixr+XTBjC2hLLFr5mhrBtJdate8+ygJF9
        FaNIamlxbnpusZFecWJucWleul5yfu4mRmAa2Hbs55YdjCtffdQ7xMjEwXiIUQWo89GG1RcY
        pVjy8vNSlUR4pX8fTxHiTUmsrEotyo8vKs1JLT7EaAoMw4nMUqLJ+cAElVcSb2hmYGpoYmZp
        YGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwJSzwSnt86MC6wkaqRviI4OnzO162iHz
        bcMGoSjf1vMVsYcinac0r8mSyFzW7FZ3bM28l2ekM2tuLjLd7D1pat66yenz3UIFpaIUrjFu
        9+tTWnXnTueJsj/B0jLeSWJ32qum5+Ufv/Yv0I7d6emrw1NWvuX1DC2R7bA6ppX5bJ3f7HO3
        6s/WWyo7C82Pdak6O3HrbduOjgjpI3Esgrkhs4VPqgq5ratddOnpBIa3vOkrOw5euxa1U3f/
        GW7LyFnH1y+z23aSrbt+oooht/XZv7p2IXf+Rtdrle5vvhi29oHPTYlapU5N9rwJDi87Sxlf
        PjU8vGSLqJtP3dHHvEJMZ3X9TXPaNlw7vsHg5JrOg0osxRmJhlrMRcWJAP7aOMGYAwAA
X-CMS-MailID: 20230801111648eucas1p1ed0ae759c5f4471ffff404fb4da66e28
X-Msg-Generator: CA
X-RootMTR: 20230801111648eucas1p1ed0ae759c5f4471ffff404fb4da66e28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230801111648eucas1p1ed0ae759c5f4471ffff404fb4da66e28
References: <20201019203533.GA1203217@swahl-home.5wahls.com>
        <CGME20230801111648eucas1p1ed0ae759c5f4471ffff404fb4da66e28@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zm3oqxvgovdihrgq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

I recently got an error while sending a mail to Mike Travis. Does he
have a new mail?=20

Best

On Mon, Oct 19, 2020 at 03:35:33PM -0500, Steve Wahl wrote:
> UV platforms are the only ones who currently use the XP/XPC/XPNET
> Driver, so it seems fair HPE should take some responsibility as
> maintainers of it; so add Mike Travis and Steve Wahl.  Cliff
> Whickman's email address is no longer valid, so remove it. Robin Holt
> was contacted and wishes to remain as a maintainer.
>=20
> Update Dimitri Sivanich's email address for the SGI GRU driver.
>=20
> Add Mike Travis to HPE Superdome Flex (UV) platform.
>=20
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Acked-By: Robin Holt <robinmholt@gmail.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> ---
>=20
> Third sending: increase distribution list.  Someday I may get this
> right the first time.  (My appologies if you've seen this thrice.)
>=20
> Second sending was due to a Return-Path: problem with my email config. My
> apologies if you've seen this twice.
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9350506a1127..3a18b48a5221 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15671,13 +15671,14 @@ F:	include/linux/sfp.h
>  K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clea=
r|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|sto=
p|test|validate)
> =20
>  SGI GRU DRIVER
> -M:	Dimitri Sivanich <sivanich@sgi.com>
> +M:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
>  S:	Maintained
>  F:	drivers/misc/sgi-gru/
> =20
>  SGI XP/XPC/XPNET DRIVER
> -M:	Cliff Whickman <cpw@sgi.com>
>  M:	Robin Holt <robinmholt@gmail.com>
> +M:	Steve Wahl <steve.wahl@hpe.com>
> +R:	Mike Travis <mike.travis@hpe.com>
>  S:	Maintained
>  F:	drivers/misc/sgi-xp/
> =20
> @@ -18905,6 +18906,7 @@ F:	arch/x86/platform
> =20
>  X86 PLATFORM UV HPE SUPERDOME FLEX
>  M:	Steve Wahl <steve.wahl@hpe.com>
> +R:	Mike Travis <mike.travis@hpe.com>
>  R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
>  R:	Russ Anderson <russ.anderson@hpe.com>
>  S:	Supported
> --=20
> 2.26.2
>=20

--=20

Joel Granados

--zm3oqxvgovdihrgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI6Z0ACgkQupfNUreW
QU+m8Qv/RBf5IVwpMsTxn4ztdWOuSdQqiT1WjjEjGtIdHYMCN/LgrAaP9bsJNk9x
5ofy4aXDFrNmBp47+hbdnWyykq9JZ3C1EtNRnJ/U8s+reTw6mjG1nybOid4/PVdK
T4p8FDjDfBrAuKQm43IKv45LgRn5pezNSKiUk9IGDvERX5sTu3t7yAHsdAL00cMz
CSLowUON9XQDDq2XiSBd3PP+3BUZcT18XREF+29P562tjht8VQBCW5w+Fa9QndCE
DIa1oGW07OFb2ZmT90DgzbbDaaQ6FM5B3vVkTPa7nnvnxgHpBejTeFIbcBQfFgNt
KrZCq4tan+va6KIOH+GYYFa52CfAzVz1dPA5jvs4k7vTDhxhUcs2jVDtCTuLRK1K
9Yl/VS2TmJHc8LZgQunhc2prX0fbr1PdwndH03J/ylho6viHCDpRamFymbJf86U6
OwyPtWuweUv0q1IdCS+pVonxD+i6AwtB+v301K4xYPsjYLtDTD5jvYfay+HueH8j
yAQrs4iS
=avlL
-----END PGP SIGNATURE-----

--zm3oqxvgovdihrgq--
