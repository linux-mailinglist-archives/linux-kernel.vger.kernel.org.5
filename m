Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF327DE345
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjKAOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjKAOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:39:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B200B123;
        Wed,  1 Nov 2023 07:39:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 82DE35C021C;
        Wed,  1 Nov 2023 10:39:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 01 Nov 2023 10:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698849554; x=1698935954; bh=GC
        fQSQe/NDedoWCe3ZTnSrztcnxqfQkjP8igwv3X3dc=; b=m34ARN/RcFD7+DHPQI
        KA18R6oqt6cuF/Hz0O11oK09mTheK/6KqKErfK1rmOI2TeV1/bzMN9wr6FX702tf
        BnxomD6krGUrojFrpQkMrYDmTAEx9S5W7Qwlgv6ecr61buQG8rxnObcIDOBDGNA1
        c+wuhJCP8K1tNN7/S3gh2uSiLIBgsENkM7F25yGQN3ooQmaDYNBSs+USmswqsfY1
        sl3y+6ZaeT4z/5Zw0ZAmEdadcWw6Z+LnG994F73BMa+r63PET/t59JyGtefmLHCB
        dewZbUrox7D0OvBo0j6CqA4Qs8OuDKi0n9vA/OxWiDgwqIEcD6sAhnowHPk4J3kI
        Imgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698849554; x=1698935954; bh=GCfQSQe/NDedo
        WCe3ZTnSrztcnxqfQkjP8igwv3X3dc=; b=gnWyyS4z86jNUC+RE3L3h3WfXZIs5
        n2Bkb+z5yT7wj+AKjst/pn2axhtWJnOBxihR6nwpk5OjwiXhCLglyWdBpRGgioHY
        64an628fQL+B0H7uHwk5eP3hhGfuVCFnwCanqr8m9JbupbhC8+Vs1bz2gwfHpszj
        +8x77Euzv9qe7xAcsU05B3GB7U1cfgSy2t0oY+2YST/unocdrI4cvz5ACKrudwz5
        f458gWnCfNhPrw5OrxUjSnY1HKchwacGd8Ug5fJoVLoDUoY9M0zPy4JnBX3y+2qH
        1Ok4yCiyRVm+JjgkfTXSdqZscENlCw/QNP9H213l1ECWSTJSqhEtHpZag==
X-ME-Sender: <xms:EmNCZZLFh551x0-JJRVcDqRm8HxLVEqeVKXpEdWFPPKNF1LDPJFvpg>
    <xme:EmNCZVJn3oFZ6hI96B_VcovzeUULp4qYkBGKSlHwuElaPkUlLCtfQFSibxVqxh1cI
    nVZYZRPTHbhgI0B_b0>
X-ME-Received: <xmr:EmNCZRsCfm8RzGgB2-A4_IW4Ae5qQmxncvB9NSuQwZmTdIMH1SOaaSFnGQfD3Mg7LNSm4mbeGifdTy9O6jsjAK3_xCtgMAFJ2g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeetveeugfevteettdefvedufeeh
    heetfeekuefgudfgtdefvddufeevveethffhffenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:EmNCZaaTUk7MbRk_d6zgo5g75_a3SGIsZRtMytuaVGuwiOOGb54BVA>
    <xmx:EmNCZQbGG9fWF8GJZfQ2DgpIIHpc6pq0uoQ6Z4G7_dnE51ysm4HZcw>
    <xmx:EmNCZeBQK80YbiUPMkBN9QOfJ0AVq1_Pkuzz1UXY0vjsXdxYvodFPg>
    <xmx:EmNCZYHy2A9XNmYYZMyYdJCgDHrS_rxLPzqA43bvqOM3OiG_B3KtGA>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 10:39:13 -0400 (EDT)
Date:   Wed, 1 Nov 2023 09:39:12 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Message-ID: <ZUJjELqcTvxpWPTv@heinlein.vulture-banana.ts.net>
References: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
 <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
 <ZUG3fOnw8RE7JHsh@heinlein.vulture-banana.ts.net>
 <aa00e20a-03ee-4092-a477-6d952cdacf4e@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HroXlXLET+L/VPjq"
Content-Disposition: inline
In-Reply-To: <aa00e20a-03ee-4092-a477-6d952cdacf4e@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HroXlXLET+L/VPjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 09:57:28PM -0700, Guenter Roeck wrote:
> On 10/31/23 19:27, Patrick Williams wrote:
> > On Tue, Oct 31, 2023 at 04:01:10PM -0700, Guenter Roeck wrote:
> >> On Tue, Oct 31, 2023 at 04:58:06PM +0800, Delphine CC Chiu wrote:
> >>> Add support for EMC1442 which is compatible with EMC1403.
> >>>
> >>
> >> Unfortunately, almost no information is available about this chip
> >> except that it ships in an 8-pin package. Are you sure the chip
> >> supports two external temperature sensors like EMC1403 ?
> >> The chip numbering and the number of pins would suggest that
> >> it only supports a single external temperature sensor,
> >> which would make it compatible to emc1402/emc1422.
> >>
> >> Guenter
> >=20
> > The datasheet I've seen says:
> >=20
> >>> The EMC1442 monitors two temperature channels (one
> >>> external and one internal).
> >=20
> > Based on this, I agree that emc1403 seems wrong.  The datasheet also
> > says:
> >=20
> >>> Pin compatible with EMC1412
> >=20
> >>
> >>> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> >>> ---
> >>>   	{ "emc1422", emc1402 },
> >>>   	{ "emc1423", emc1403 },
> >>>   	{ "emc1424", emc1404 },
> >>> +	{ "emc1442", emc1403 },
> >=20
> > So, emc1402?
> >=20
>=20
> At the very least, if you are willing to confirm that formally
> if/when v2 is submitted.

Yes, I will confirm from the copy of the datasheet I have available
when v2 comes up.

> I previously rejected a similar patch adding emc1444 because it was
> impossible to get a datasheet to confirm that the chips are really
> register compatible. No idea why that has to be so secretive. It is a
> temperature sensor, for heaven's sake :-(

Delphine, could you reach out to the chip vendor and find out if they
are willing to publish a datasheet for this chip?  They might not have
updated their website yet because EMC1442 shows up on Microchip's site
but it has almost no information.

--=20
Patrick Williams

--HroXlXLET+L/VPjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmVCYxAACgkQqwNHzC0A
wRnwxA//c1cgRSdg6+/1HaDucJgsB05Ch0p01yyU69ruVo+N4FAEPdvZrz+7a2GR
fKicNqe4hu8/OYeVEpV3X1gWbbLnfPAnZCW7RbgwvnfO5Epzz2enQcfQMEpq/ig/
+upC2NnDOd/xkBnCQoBFUZHUuUm9rwWFbQjke/0YIj3Rnshj1Ui1KCCYbTF5JZo/
R5nT1XM+1awglcgrDYwmGACIavHDikAszfJSjn66XZoCUFkY2668A2W3QQynDD2a
k1Udhh//ZC3OyNNyJJp+WsmhoX6zYm5hjzzR5QpEugEk4cKqDaSdjn0QOjF4Cfea
47fFti3njKU7yNYU24FMB7+MMz4tcsMi5z+QX8lywJSWQFRasdHtUoSmljQcK4e5
cW+F1HZTj5G7RpjNYD0+o225Asuo0Brjl0Y10K+YbiixMXHRKSZuWOghOSFxN9lq
7GZhZXA2mfxBET5SZK9g/32e1dTnMLVt7n4+h+fz0o49gV4mWi8amvY+eWbQ4ZXx
W9IwTTSqWwOcPaO2ZlGnR72pHT/kUIKsKNjCSFcMdrUyDk64V3MYw3ngrgbfSvif
6YvB1O7rFTb144m0XolZTomNX9I+VCYp667vxAjVNkUTz0qK2Is3/Bgyjjqz1e7z
xx+cQZY7cStG27kZbcXUiOrRNaLbpXlpRCDzkXBJyhwjO5ZrRRk=
=5cjJ
-----END PGP SIGNATURE-----

--HroXlXLET+L/VPjq--
