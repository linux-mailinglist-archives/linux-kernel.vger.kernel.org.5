Return-Path: <linux-kernel+bounces-24925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F76F82C4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266C91C22279
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5F17BDD;
	Fri, 12 Jan 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jL32j5Fw";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="pHXvjyM6"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6822637;
	Fri, 12 Jan 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1705080852; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W3GWy0FmIaj8bnyQOLBzXX83ySwtjGcplbG/RlF6oXx9qygnBd9EMgXtiadN4VCuYL
    Vzb9K/1Q4zEh0B7XcKv8F2Sx4FijwnMPXysHfKJDCuQG0VCoTY5bqyISD5X10Sklu//B
    6VkzB1eAyWBDr/bYsxdCjCk7edGU3pgaP2hEzvpyZbAxOha7gyG3pLDtiV5WNhRfEYbL
    TDD/pLVM6nJvYv+XcCrZwcaohlv+M2+F2XzRIFeiekgqkBmiLXVXMh3jQ6/CCRVmglED
    VgmepBQlqLq+ZF6ebJlWo7K1uGUcBpy8sQQyJjroV+U5685/yWLccmDVI8r77ioDgMW0
    JoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705080852;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=x1r68xA9wRZ4ANIBi9hA9+/f2i2/5reMcctFU/rKIWM=;
    b=VDcJUmHB6n+dNWMqrBgIeSm07uZuiZ3Lo4YHM+4lHTEf/fShWCuTsnhOvGLLQPDnuX
    DVAPLYAUhm05iR1fke6fvyGt2yjAOY9M0JpWsM0G7ZDb7NOVtKdS5okSvg27EKDAjxe4
    EZA65KUjsuxqrlxq3A4GvhvmCzWHoRqtwrIEFgzCZ+5/k2+oHOIrVt8PoLSJaD5ZuoIt
    SkIGnPo+f/Kh0VfwAACyGqpv0UWlsRVd0cuYtQVx3MTV8cVZA1NPKmpaCAhndTK188ip
    jcc0l/OXnhCOTjIjugpKHKxL3l3jO3UA4Ps7c/ux8panbv6FBehkIg3hmwU9B0kTY7rX
    EJQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705080852;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=x1r68xA9wRZ4ANIBi9hA9+/f2i2/5reMcctFU/rKIWM=;
    b=jL32j5FwaeApRttmOhW1Gu7gSfqOtYGFDHV/dfmiVwk6lv/rGq6WkiuBz82beG8UnO
    swrsv0PhvQYaN21JZmxO2+xU2OKEIDHGCNxj9juFGzg+Ldkd0mhSBo97APtDJ6U+LRqu
    7blY6TeqlvdGLoENvx22BbsH/dahwDdBTiZ9BLCKDH+ergN8Y0RIkiA25I65IuRw4QpB
    qzlOiNthWw+WTgSS1LzxBVQAwVwPewl9NQf1D7CfvSzknu8aEGQJDyWjtSAjV3d/ogkE
    eT3drVtVQwHCoz/BHuQVEe8SLaX+rax4SpDu49ZC3/DEwQeCoUx/w0zBh8zzKKg1e7bO
    eWKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705080852;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=x1r68xA9wRZ4ANIBi9hA9+/f2i2/5reMcctFU/rKIWM=;
    b=pHXvjyM6SXoq2JN88aS5Df7FeZdKXhVFedn7SwZ4nyqUqIMi1EYmq65gduamPGp39D
    E3e2r+2FnzciMSGM/LCQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZjDY="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.10.2 DYNA|AUTH)
    with ESMTPSA id dbe64400CHY9PpN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 12 Jan 2024 18:34:09 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH RFC v2 04/11] ARM: dts: omap4: Add device tree entry for
 SGX GPU
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <20240108183302.255055-5-afd@ti.com>
Date: Fri, 12 Jan 2024 18:33:58 +0100
Cc: Frank Binns <frank.binns@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Adam Ford <aford173@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 linux-omap@vger.kernel.org,
 linux-mips@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <122DC5ED-2AA7-46A0-845F-083922458385@goldelico.com>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-5-afd@ti.com>
To: Andrew Davis <afd@ti.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi,
I just comment on this example, but it applies almost the same for all =
other .dtsi changes.

> Am 08.01.2024 um 19:32 schrieb Andrew Davis <afd@ti.com>:
>=20
> Add SGX GPU device entry to base OMAP4 dtsi file.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> arch/arm/boot/dts/ti/omap/omap4.dtsi | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/ti/omap/omap4.dtsi =
b/arch/arm/boot/dts/ti/omap/omap4.dtsi
> index 2bbff9032be3e..559b2bfe4ca7c 100644
> --- a/arch/arm/boot/dts/ti/omap/omap4.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap4.dtsi
> @@ -501,10 +501,11 @@ sgx_module: target-module@56000000 {
> #size-cells =3D <1>;
> ranges =3D <0 0x56000000 0x2000000>;
>=20
> - /*
> - * Closed source PowerVR driver, no child device
> - * binding or driver in mainline
> - */
> + gpu@0 {

I wonder why we don't add a "gpu:" label here.

Almost all other subsystem nodes have one (e.g. emif:, aes:, dss:, dsi:, =
hdmi:, etc.),
obviously for convenience when using a .dtsi file.

It would allow a board-specific DTS to easily add status =3D "disabled" =
to avoid driver
probing or disabling the GPU (e.g. if there is no display).

> + compatible =3D "ti,omap4430-gpu", "img,powervr-sgx540";

It still appears to me that the "img,powervr-sgx540" (or similar) entry =
is redundant
information.

I have experimentally updated our openpvrsgx driver and we do not have =
any use for
this information (at least in the kernel driver):

=
https://github.com/goldelico/letux-kernel/commit/f2f7cb3b858ef255f52f2b82a=
8bb34c047337afe

It shows how easy it is to derive the sgx version and revision number if =
we ever
need it inside the driver.

So if you want to keep a reference to powervr, it would suffice to have

> + compatible =3D "ti,omap4430-gpu", "img,powervr-sgx";

Otherwise your device tree entries compile fine and seem to work (at =
least in
a cursory test on PandaBoard ES).

> + reg =3D <0x0 0x2000000>; /* 32MB */
> + interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> + };
> };

BR and thanks,
Nikolaus=

