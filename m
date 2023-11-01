Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED887DE352
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjKAOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:44:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDCB101;
        Wed,  1 Nov 2023 07:43:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D72D85C0045;
        Wed,  1 Nov 2023 10:43:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 10:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698849837; x=1698936237; bh=EG
        UJ4Sg90shlx26w8vQ4HjxBMYB1gqauoSAotCxg8Mo=; b=Oq4ossPSykexO+S+6x
        Sv51vm/VyWBhcUVFy88mgQFewBFZnjr+6D5dIrIuJijTJfTCjg3ql2vMWLeu4Aok
        f/rE8EeLTY0dz9mmrcMBOwu4p5ygPhbebYrwfjaJsU3s3Vvx0/G2cyU5hgejpsmD
        0rcooNerdRI4EMw0OAOkYPvdeGT+oBxeuC6AaZv/MBOzDI65QtVSC5yZOXyEN7QT
        B4FZMr9oaKa7BkuNZlwItkfwCOqBHWBn/vaWcVJ9DPy4/mUsE2z2dY3fOUKnnfFY
        zANd2cnBmMSGNGEX/128I6OtEP468bcJ7oMjYA4KbP6VjhaawquO+zdN6PCPW5Yj
        CUxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698849837; x=1698936237; bh=EGUJ4Sg90shlx
        26w8vQ4HjxBMYB1gqauoSAotCxg8Mo=; b=MLa5JnRj5MBJ1YhGGe598WZttqx/G
        paEDQuAnjpgC1duDJ6ryx1h3ASvXd9df+OXmLe7aJk0t7Ft4cAm6exL8wJ8FEW76
        XtActVFoTYskzRFnHb41c9x9dAep6iKYyShNOjWFYl6DlS19jYCyL51d7kdT3NCS
        KNY/DV+R+Mvkl9fzh2ijYXyBQZKVL0S5xuccoCtHNDJN4nLvpzm44K1DlJ4oSIeW
        KgvRERkCyWGIsm8R7YLMmQisHXUMw+JbN/VZAMGdjzPNVxsAa45CtrlEExSINzjL
        iSG6xodyMgTUjYKophQSEqx9DehI0CBWpbKdZO5mZ794SzSUa2RS1u1tg==
X-ME-Sender: <xms:LWRCZfWW7aEllC4bDCDBihpEpCPrVFkR3D3cLcJrb2CKBtgLIkcByQ>
    <xme:LWRCZXmAm09p9P3i_SEyxQm0kaqz2mCsFqowuuLF3tALXO8637xVmIXMA8iFYxplV
    LEoNVWoIKSE1W0SNys>
X-ME-Received: <xmr:LWRCZbbBju-nUfhAtW3N5vYh4pBqU4XanYbHvzs7N3_1SM0BBlPVBHa9nrEH9oyFROXgzFI2u0nZHBNJZO1EhR62F0RMbma2gtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:LWRCZaVqfe5v4o6EmSyVecYNHtvHqOzawV7n-pvBpuI5mzkrkXh2EA>
    <xmx:LWRCZZlqlts08ORnm30R852VcFmLCV4nxEsv14x0Ao9Rm0sVD1bVxA>
    <xmx:LWRCZXd1wxY3ARmJ52qHNGs9r0WVqyYf_QIBNw-cLHSuKwxzrM7ZcQ>
    <xmx:LWRCZSBjid9ft7OzSh9NfI5NTscjIbWVzryUvVHyTNc5tcUh0XO0Kw>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 10:43:57 -0400 (EDT)
Date:   Wed, 1 Nov 2023 09:43:56 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Krish Skandakumaran <krishskanda@meta.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Message-ID: <ZUJkLJEpwji6czHJ@heinlein.vulture-banana.ts.net>
References: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
 <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
 <ZUG3fOnw8RE7JHsh@heinlein.vulture-banana.ts.net>
 <aa00e20a-03ee-4092-a477-6d952cdacf4e@roeck-us.net>
 <PSAPR04MB459864E8447A97985FA303FAA5A7A@PSAPR04MB4598.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8L9HAZp0EqKU6PIc"
Content-Disposition: inline
In-Reply-To: <PSAPR04MB459864E8447A97985FA303FAA5A7A@PSAPR04MB4598.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8L9HAZp0EqKU6PIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 08:45:15AM +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrot=
e:
> > >>> ---
> > >>>     { "emc1422", emc1402 },
> > >>>     { "emc1423", emc1403 },
> > >>>     { "emc1424", emc1404 },
> > >>> +   { "emc1442", emc1403 },
> > >
> > > So, emc1402?
> > >
> >=20
> > At the very least, if you are willing to confirm that formally if/when =
v2 is
> > submitted.
> >=20
> > I previously rejected a similar patch adding emc1444 because it was imp=
ossible
> > to get a datasheet to confirm that the chips are really register compat=
ible. No
> > idea why that has to be so secretive. It is a temperature sensor, for h=
eaven's
> > sake :-(
> >=20
> > Guenter
>=20
> Hi Krish,
> Would need your confirmation of the device on the NIC.

I don't think we need additional feedback from Krish.  Please change to
emc1402 from emc1403.

The datasheet for EMC1442 even has a section titled "Functional Delta
=66rom EMC1412 to EMC1442", which is effectively all non-software related.
Therefore, the compatibility here should match what was done for
"emc1412" which was `emc1402`.

I will send my Reviewed-by with a v2 using emc1402.

--=20
Patrick Williams

--8L9HAZp0EqKU6PIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmVCZCsACgkQqwNHzC0A
wRnCGQ/5ASfFYBrozj5GVQx8szBklXA/qLO1EMCICOxRx68qEaSrlt1fjzlFnx4G
hfrSA/Er4jbC1Iw8xqVwi4g1drim5XjYZI28F26u+oICnkia2VY/5jbYIhiMjIcc
qI0GaAduP2a76U92bHaxLKKDDdBw3mK/v/2nFzTYibLkyrm/PiK1E+9UC0YStmqB
X5KdlkcVd3rXzPHIQj/4HR0wCb4A8Sfmf/eUgtDPjn4eSZ0lhbWnIF+NQE4X/aNT
8VxT1BhcITkhiJRxLVnhTAiV3tn7WSAZsKA9FF0y6CbvyBwZawc8/ntYw1yTfNr9
lzGTtMhxBMdvWRMD4AlJFMxXWAY0q32cfsMS8eE92KZBCSO6Ea1ZCBxdgovIxWXE
4O7iOF/rRafRPZrrGYYaEuFyZ19qRMl4GaTepO3lOcAKnYyDqRBUHVyNSTECqqB8
QumOscE3aos5z7WNXarWLzkNqYbgAni8+4k6Pvb/oZwtu/lL0Ts4apH1mIc/DzDb
8h/EhdKmjUpmL2teqULpKCb2SBHef8TgkT+NN62dBzsLaeL64g/e0NKHWNgD3dFH
vY27NwK46b955IbgkWok53pxGGGQmhgHWxPO1xL1qk9RqrBxrZWlPzt57Rqfs7B6
L+Jjq9Q8GVKbdQOjophVG+EMyd06VZ9HvnrWSoY0dRjp+30/G1s=
=hAMh
-----END PGP SIGNATURE-----

--8L9HAZp0EqKU6PIc--
