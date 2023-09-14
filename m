Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2407A0DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbjINTR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjINTR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:17:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E931FFA;
        Thu, 14 Sep 2023 12:17:22 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 199C0660734C;
        Thu, 14 Sep 2023 20:17:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694719040;
        bh=+8h83Wl1ZJ9FOA73iw7dxoMzoNJHRKLssqoGddVcv6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNlMcofM1bz7EHdxr2v5+5T3W+PNpjVfPilbWQjzJ0AcIYWvb3nkl9qHPzNruXA9y
         a2qifrWI2xN/M+2q2yI1nOIVLIJyMGXhbg3agzxik9IXZ2u1JINzQ5cMIpLZ8f+OCp
         mMDTO+4UvlnXDuUpezi0BoS/dzhkKl5VjDqn/4O3YDvlQTH8OPoz4NYfEcaBrhu0PC
         bipQLjIbIPxz2aOPhCow+cno6JqoXq9Uw0nIdVfV2reNcJZFS+LSV8+i+gxbSYANgn
         MEEJuqnpq3HJNgGZKE1SDIO2UYTZSyaO4s1oNblGZqH1hsoqKinRtojZGEE3qjI6Tg
         4HYMQe64FLO6w==
Received: by mercury (Postfix, from userid 1000)
        id 4BD3E106098B; Thu, 14 Sep 2023 21:17:17 +0200 (CEST)
Date:   Thu, 14 Sep 2023 21:17:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/3] power: supply: Introduce MM8013 fuel gauge
 driver
Message-ID: <20230914191717.u7jcxkfgrvpcb6hp@mercury.elektranox.org>
References: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
 <20230621-topic-mm8013-v2-3-9f1b41f4bc06@linaro.org>
 <20230913154552.okinfq6gdxf2d7ab@mercury.elektranox.org>
 <36287e2f-ddff-4323-bbc2-e7a07a9283e7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqk2z42bayjsqcyl"
Content-Disposition: inline
In-Reply-To: <36287e2f-ddff-4323-bbc2-e7a07a9283e7@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nqk2z42bayjsqcyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 14, 2023 at 08:46:21PM +0200, Konrad Dybcio wrote:
> On 13.09.2023 17:45, Sebastian Reichel wrote:
> > On Wed, Aug 23, 2023 at 04:36:15PM +0200, Konrad Dybcio wrote:
> >> Add a driver for the Mitsumi MM8013 fuel gauge. The driver is a vastly
> >> cleaned up and improved version of the one that shipped in some obscure
> >> Lenovo downstream kernel [1], with some register definitions borrowed =
=66rom
> >> ChromeOS EC platform code [2].
> >>
> >> [1] https://github.com/adazem009/kernel_lenovo_bengal/commit/b6b346427=
a871715709bd22aae449b9383f3b66b
> >> [2] https://chromium.googlesource.com/chromiumos/platform/ec/+/master/=
driver/battery/mm8013.h
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> [...]

[...]

> >> +	switch (psp) {
> >> +	case POWER_SUPPLY_PROP_CAPACITY:
> >=20
> > this is in %, while the next two are in uAh. So the fuel gauge does
> > not provide the current capacity in uAh
> > (POWER_SUPPLY_PROP_CHARGE_NOW)?
> Yes. Doesn't seem like raw values are supported.

Ok. (It's quite unusual for a chip to provide design and full
capacity separatly, but not providing the current capacity.)

[...]

> > With the next submission please include a dump of the uevent
> > in sysfs in the cover letter or below the fold, so that its
> > easy to validty check if the reported values look sensible.
> State of what-will-be-sent in v(n+1), with additional fixups:
>=20
> POWER_SUPPLY_NAME=3Dmm8013
> POWER_SUPPLY_TYPE=3DBattery
> POWER_SUPPLY_CAPACITY=3D100
> POWER_SUPPLY_CHARGE_FULL=3D7124
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D7500

The unit for the above two are uAh. So that would be 7.5 mAh. With
4.4V I expect you have something bigger than a coin cell, so that's
probably wrong :)

> POWER_SUPPLY_CURRENT_NOW=3D-122000
> POWER_SUPPLY_CYCLE_COUNT=3D27
> POWER_SUPPLY_HEALTH=3DGood
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_STATUS=3DFull
> POWER_SUPPLY_TEMP=3D324
> POWER_SUPPLY_VOLTAGE_NOW=3D4407000

Otherwise looks sensible.

Greetings,

-- Sebastian

--nqk2z42bayjsqcyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDXDIACgkQ2O7X88g7
+ppTRBAAj0xdui/gDf4QyvEwTygEOVRRAVoV2GsAtph8nsHv5lQTxkvHvzz0DC0z
XU/GH6ejrwF4CpU6zPp4CxbDHNi8rnVWvf6OK8QARYKAxUqpja8h2Amz6j8Ilf/D
i2mXRR+FQenY/pfoAPnaHav6Pn/9EeaZ9cr8GhGennOvJ+AtSGow6RwGhNnJYXOK
BdEAG3c6O2g64eo64TE9PdbkGRDPI0bIpuCzKXsnQoNcobAlQK/DoKyvQZeof0Rb
NWz1o7H+tBt9huncbUEmpdujgXUdsMsuE5lUrB/Y5Js++JBGwzNin06uss9B7pDw
wPebE/e1BiGRfPhy1az6gotdubRhmK1wjC68DY9LVfqX5KXjIyTn1YEb6+0Sqhlo
AAwWxe9HhFgJvVM9Zj8fA30egKQHl3H/kVFHqW3XSckte5PqBbeHKH28Zi+iT8NE
9b3jfkfeM3E0ifAv1HlOL6lYSkF59Hq365tGKjFhdLzS7xVGxLshwm7o1CoRJr2R
OD/Y23KSyQf4PWqh6QPlksrmTGo863aP0oLo1P5p6WF5aXnWRuIHqIaSQJB/xVRh
J5SzAkjPbEF40Vc4Cn4CDaO/nseB/pTyiO3H7vEtnpWZAKdwrQIdJ/QEgXw3DTsi
ZI+VNYanv9/F95hD4aV+NTyEIHLz+k6/XF7tTj80wPVc0wdqBCg=
=vZJU
-----END PGP SIGNATURE-----

--nqk2z42bayjsqcyl--
