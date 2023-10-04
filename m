Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A07B7E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbjJDLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjJDLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:39:23 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0790;
        Wed,  4 Oct 2023 04:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696419551; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j+O3bDxqqubuSX8IZWojmQfXP98+sl61ky772HyLaxMUkLuFeA1QuUhsy0MqJHyKgy
    Dx04ce3tqCWSGx/+9/MlscF+wiUxI5UOWq3srB72bbrHP5lGZDQtkk8jdU2Rs7/Zm6Yp
    0iKbE3pzSd7NchBP1NX1bqPjHQeABETu/s+mfQLlKl4xN5LT+v9vmdZ3y+swepcle8mt
    GVoTN/vUbuXVTARa6PtG0HBpovaPhanzLJxXaRW4jvOo2kaYsFJD9V/jqPz1g0O5Qzw1
    toSx1paQC9/ZH9YWa/TU269CV1ZYA5Do/kSZwDSDmzyGXRNdicvSIVVcdwrJtaHPtrjX
    KHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696419551;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8fPgPQfC7xx+Xege4zFWlqYVGz6Z0gFDpp14XzSlcvA=;
    b=tyXf6S+IUb+OKd1BmUNUfjZ+GHZ9pzUas802iD92esJbihdXSYtoYWjg0xoiRgz3t9
    WELurFL7HWjZstQqZrF+oOZGZg9NnDEMtQSks8aYK1pgzmjczYT7rI1QkhvfwR1Mrziu
    /z5Z2eAHaZWtpsrMcA1yv3M6RMdmqwVsg+Aah1qxo/EbY64aKYRETzgcgLguEHQ8vKfE
    gsewop26gyJSTOLcr0djJ7nDptXG5TAkNReOSZKIy/haMdS/weW/Jpzcin9wgDraCxVh
    9NBJSjVasCU0UoQZf5REhEfS8ZB3BrdtmsaoDWEoI3WME05UCcYZXB1WpBGL9/WibMex
    QSXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696419551;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8fPgPQfC7xx+Xege4zFWlqYVGz6Z0gFDpp14XzSlcvA=;
    b=nmVfVhfHVXOfWQaIFp6HJdLLrjYUPmG4gUW3E41chNIEpfss6dG+BqSliGWTc/xbxi
    gWNYK2qEknIxkcGwSQzGo18gPQqniMr48KQiXJtoR2QnpoUxaeY+F7rzG4lo6m3QybAT
    3d4gMv23HRHMBeqYsGegOxL2uzbq04TBZda/S0WRVIWXDguU5hOmF7ejdQluqh3FMg0W
    R1Qq3GQzMwEIupUfQOqBfE1X/daRPM0v0xx5TJHBpTAsiRoVz4YIDMiEz6WbRkIIBGHM
    oRNFa12WRikNMHLaa6bQl7omrosldKrIqGAl1ZWOsETH/h8ApJIUQ6sW1DW2/rvBuR3f
    3tkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696419544;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8fPgPQfC7xx+Xege4zFWlqYVGz6Z0gFDpp14XzSlcvA=;
    b=A3GeA2DPQcGy7p2e5ceJPbn1DvS/rPfq0taJylVusJLgoPuqrZQ+00zfljJ4uDr/WI
    2RAlxTC8bHX90uPYzlCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeo3Q="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id Y04dd7z94Bd3j4h
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 4 Oct 2023 13:39:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Drop superfluous omap36xx
 compatible
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20231004130353.01228376@aktux>
Date:   Wed, 4 Oct 2023 13:39:03 +0200
Cc:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
References: <20231004065323.2408615-1-andreas@kemnade.info>
 <12323F42-3611-4685-8981-F6A18C4A5862@goldelico.com>
 <20231004130353.01228376@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 04.10.2023 um 13:03 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Wed, 4 Oct 2023 12:50:16 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi Andreas,
>>=20
>>> Am 04.10.2023 um 08:53 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>=20
>>> Drop omap36xx compatible as done in other omap3630 devices.
>>> This has apparently fallen through the lattice.
>>>=20
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi =
b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>> index b6b27e93857f..3661340009e7 100644
>>> --- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>> +++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>> @@ -11,7 +11,7 @@
>>>=20
>>> / {
>>> 	model =3D "OMAP3 GTA04";
>>> -	compatible =3D "goldelico,gta04", "ti,omap3630", "ti,omap36xx", =
"ti,omap3"; =20
>>=20
>> there seem to be some more references to ti,omap36xx:
>>=20
>> arch/arm/boot/dts/ti/omap/omap3-lilly-a83x.dtsi:	compatible =3D =
"incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", =
"ti,omap3";
>=20
> apperently all the dtsi are fallen through the lattice when handling =
the dts.
>=20
>=20
>> arch/arm/mach-omap2/board-generic.c:	"ti,omap36xx",
>> drivers/clk/ti/dpll.c:	     =
of_machine_is_compatible("ti,omap36xx")) &&
>> drivers/cpufreq/ti-cpufreq.c:	{ .compatible =3D "ti,omap36xx", =
.data =3D &omap36xx_soc_data, },
>>=20
>> So are you sure that we can remove it without replacement or code =
fixes in dpll and cpufreq (board-generic is probably no issue)?
>>=20
> see discussion of:
>=20
> commit e341f338180c84cd98af3016cf5bcfde45a041fb
> Author: Andrew Davis <afd@ti.com>
> Date:   Thu Feb 16 09:33:38 2023 -0600
>=20
>    ARM: dts: omap: Drop ti,omap36xx compatible

Ah, I wasn't aware of this.

>=20
> all the places also basically check for omap36xx || omap3630.


Yes, I have checked but drivers/cpufreq/ti-cpufreq.c seems to be an
exception (unless I am missing some other patch).

Generally it could be good to remove the double checks
for omap36xx || omap3630 in code? Is this planned as well?

BR,
Nikolaus

