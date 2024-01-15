Return-Path: <linux-kernel+bounces-25761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAF82D566
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F341F21BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780121E53A;
	Mon, 15 Jan 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="eSo9RdXW";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="pFlSZHjw"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC50C8EA;
	Mon, 15 Jan 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1705308912; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qjzfTZXIn8ULyATbJ8kYws4bzV++on2FpfW1SqbtHT2ZnlgpuuvjMFc9zWdYkSUb1P
    pflMhVIuUbCfLuoxbfOdW/zf8sM4TwYDjmW3ythMRZUO8lnVMlOM+QZSMHstRbG8VtiX
    5pwr2BiVJ8tdtG3poAmvrV+xsIuYkRT1GgmC8BDbXpdWsN0ctXi7pD4TNEpj/lq2pZtL
    k5pdszBql0UT/kPieggXIZvTKJN+RftG6PAfZYMvuyDyo1qhrOsV6EbbV3/PajMnlMUp
    1YUs2dJHnFqWnbil9Jo1DCF5ZxyOlev+0ttwdR9LtJTWIkOeqAavF9AGa1aW9v9FJ8+r
    UYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705308912;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yHFJRaGiqBFJv2kzsrvLiyk/a/j3+Epn1Hl4IwAPpOQ=;
    b=FczWUnwFJvS7KFS7oNsI/m5tBh2F7SkhYobWhH96170UEzMMHAY7/a2uyfmRbvRKow
    XxzFEyTyBSOpP3cF9pfgWkeza1nyq9zf9oi94YsTKyXshRdfn0d2e1F+xcLv8awnUM+t
    23KGqjcyo8asdDAHzV7uXyl/kvjTh+b7fZuuWlVKtZu1rjuGlDcrRzDinWOIgoWMA5Wj
    BjA/4lR6aUUN4OyCAwPXkzDxTN3a2Q2m2k5Q1wNMeAa9JuH9RN0wdEAwdz/qZhjKuvPI
    3BU/3b5PpiRq+EPUwQ3qjVOGVG+kh3rXnC5BHkVFSwaAoihtAP+/XoV4p90kDDcSAdoh
    GEiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705308912;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yHFJRaGiqBFJv2kzsrvLiyk/a/j3+Epn1Hl4IwAPpOQ=;
    b=eSo9RdXWhAdoaMENfvhNPTzvKpEwOCUl0YycnoU2xzRMAOQMB9qGX0yeiCQFmhzBUq
    wtqDF7H9q9nFpN3AhXoAtzXmn353mljOaUrGVy5EQHo30O7NtvmPjMuX37RJgZbC6sND
    fRtz6wn5n3MdFHaakYwZD88U4bjAkBC5emYMKMDFoqqzbgcrbDVGevUornxZP935h3Cu
    tv41U+52zsH5KQm3PgvBNVFAjwQ7rqiUTmOaI152R9JDBW8y9aOthnrXVhPSOrkEfVnn
    LjPFWcJGYSWQ9UEoWZWcV1FktKs5lSlXM1XvdZO0b1hLY5YrsGsr5UvkO108hZlxyai4
    634A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705308912;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yHFJRaGiqBFJv2kzsrvLiyk/a/j3+Epn1Hl4IwAPpOQ=;
    b=pFlSZHjwt8Te0l07++VZwoZT0mvrVr31djwxtUJKVo9l8cKGGgl9Ds9Oo6Q5eOqrsf
    5kYGQb7B3DxK7iUUj3Bw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZhzY="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.10.2 DYNA|AUTH)
    with ESMTPSA id dbe64400F8tBUDl
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 15 Jan 2024 09:55:11 +0100 (CET)
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
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <vpcgccul53oibwoqb3barj3rjxoyskoldjyfvjdzmytic3tonm@wq4aqsenk7rp>
Date: Mon, 15 Jan 2024 09:55:00 +0100
Cc: Andrew Davis <afd@ti.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Adam Ford <aford173@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-Id: <7BC64F03-A4DF-411F-9B6F-6BCA436D9B50@goldelico.com>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-5-afd@ti.com>
 <122DC5ED-2AA7-46A0-845F-083922458385@goldelico.com>
 <vpcgccul53oibwoqb3barj3rjxoyskoldjyfvjdzmytic3tonm@wq4aqsenk7rp>
To: Maxime Ripard <mripard@kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi,

> Am 15.01.2024 um 09:25 schrieb Maxime Ripard <mripard@kernel.org>:
>=20
> Hi,
>=20
> On Fri, Jan 12, 2024 at 06:33:58PM +0100, H. Nikolaus Schaller wrote:
>>> Am 08.01.2024 um 19:32 schrieb Andrew Davis <afd@ti.com>:
>>>=20
>>> Add SGX GPU device entry to base OMAP4 dtsi file.
>>>=20
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>> arch/arm/boot/dts/ti/omap/omap4.dtsi | 9 +++++----
>>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/arch/arm/boot/dts/ti/omap/omap4.dtsi =
b/arch/arm/boot/dts/ti/omap/omap4.dtsi
>>> index 2bbff9032be3e..559b2bfe4ca7c 100644
>>> --- a/arch/arm/boot/dts/ti/omap/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/ti/omap/omap4.dtsi
>>> @@ -501,10 +501,11 @@ sgx_module: target-module@56000000 {
>>> #size-cells =3D <1>;
>>> ranges =3D <0 0x56000000 0x2000000>;
>>>=20
>>> - /*
>>> - * Closed source PowerVR driver, no child device
>>> - * binding or driver in mainline
>>> - */
>>> + gpu@0 {
>>=20
>> I wonder why we don't add a "gpu:" label here.
>>=20
>> Almost all other subsystem nodes have one (e.g. emif:, aes:, dss:, =
dsi:, hdmi:, etc.),
>> obviously for convenience when using a .dtsi file.
>>=20
>> It would allow a board-specific DTS to easily add status =3D =
"disabled" to avoid driver
>> probing or disabling the GPU (e.g. if there is no display).
>=20
> There's no reason to disable it in the DT: the hardware block would
> still be there and it's rendering to memory so it still could be =
useful.

Well, if you know that the board does not have a dm3730 but a dm3725 =
without
GPU it is better to disable the GPU completely instead of loading the =
driver
and make it detect by some internal bits that it has no GPU on the SoC.

> If there's no display on the board and you really don't want the GPU
> driver, then you can disable the driver or block the module loading, =
but
> it should be a distro / package / user decision, not a DT / kernel one
> still.

The same holds for aes: dss: dsi: hdmi: etc. If they are not used by =
some
board file, they don't change a single bit of the DTB [1] which IMHO =
would
be of reasonable concern to question additional labels.

BR and thanks,
Nikolaus

[1] =
https://devicetree-specification.readthedocs.io/en/stable/source-language.=
html
"Labels are only used in the devicetree source format and are not =
encoded into the
DTB binary."


