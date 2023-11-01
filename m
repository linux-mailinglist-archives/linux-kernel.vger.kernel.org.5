Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB07DDAFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjKAC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjKAC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:27:21 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A8F4;
        Tue, 31 Oct 2023 19:27:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CF695C012D;
        Tue, 31 Oct 2023 22:27:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 31 Oct 2023 22:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698805631; x=1698892031; bh=nX
        qzmyDRymWSWIB/FPPzvbqvNMGKNPwkFJcqUXs4xgE=; b=G7/7rSr6QXQxRX5S5l
        oSgh/UaX4New7qGsYERQ6Us5tc2ay2LLzNUIKeo8Brp8Tv4lmnoqU9VoIG/Hi9vy
        UCM3C7IC2Zj4ClY5a5SN1ARKvQt/0iaG2uy9nFvHXo5L9l15rXAnmVaAYRO1N1+N
        cRMLynLaUhj2YPnD8wy2tEQ+p8nSsNbPcXQ/kkWn/e//hl7fJ2D10b0PjKcsdQ+Z
        mXI5GNrKrNA+EjPfXL4Q3deKN5cVpEq5ec9N+aFNmodWXvyA8Z/967cnVxbxo2PV
        FX4tAQwcspEW2BlWz+7kJV8eg8uynZwhprjJNAl1/0x5SXfUJdYnt6wOU6E6Y6hF
        CiZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698805631; x=1698892031; bh=nXqzmyDRymWSW
        IB/FPPzvbqvNMGKNPwkFJcqUXs4xgE=; b=A9dxdxPi1J8/696P57XgFuyBSRx8Z
        b2WRBjiprfcZLhe4cIa7jJYfdewkB9iIeCjMlHLdUAcjUIFc1vTClBh6j5g+vEwr
        7i5dpZgRqOLptAWqyOQnUDQXGKYXSebfoSNeMR08tRWBSFp1Y5nXUZOTlXjtMhvi
        q0qaS1NUmpCro10P7pzagu2Jh9r7Lb+HlUm/qqUpkTCi9ZdRF1FxxemrYds13x5y
        xErfC70TeVRQtd53OZjFbHIEPihB8l94oEWt5qkLZx3wzqqBeyny6IomADRnyoJN
        sVL2AqsJgKbj7JYCUSKh5/0b8Op3N66sN/6vzrhPADnKJ5bVee/QlX+wg==
X-ME-Sender: <xms:frdBZRRbh2sfPG2QKnEpSB1oF7NT7TxmcFFdNuk-bHq_hOjpdbArQQ>
    <xme:frdBZazb2_payjNXtvi_4IuBEqyutsl8IXQBbA1yOpoaJpq4g_y2qJfZqbnlsDR_W
    HuoI9a8I9G7-RGDgvE>
X-ME-Received: <xmr:frdBZW1o6fhXB4j-DjF0aHFyOpQ7uJTkoGlNxBQvIYE1zC2fvB3n72Y0hukXgqJYfQZAzlXRMwSvcmKFbAV3x1EJUAfnJeerFiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtfedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:frdBZZDQkr4x7yfnWhLQldsniK8f6dv90HqyL3_1dHKSIp2GsNsXzg>
    <xmx:frdBZajx52x416siNQ6PtU7-BJIZi-DL0LrHZ9PuFFd9XdfP18PtgA>
    <xmx:frdBZdpwpbnRjdsK8IRylboCx7Iv9ewxqZewGOi2etO6-QMjAgJeag>
    <xmx:f7dBZbtXlUqNh1P1vEKZbG3utTRn0RiGaHh1ELvy0Y-r1xy9uc1wvQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 22:27:10 -0400 (EDT)
Date:   Tue, 31 Oct 2023 21:27:08 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Message-ID: <ZUG3fOnw8RE7JHsh@heinlein.vulture-banana.ts.net>
References: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
 <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1WgzJp/BygG6uQK0"
Content-Disposition: inline
In-Reply-To: <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1WgzJp/BygG6uQK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 04:01:10PM -0700, Guenter Roeck wrote:
> On Tue, Oct 31, 2023 at 04:58:06PM +0800, Delphine CC Chiu wrote:
> > Add support for EMC1442 which is compatible with EMC1403.
> >=20
>=20
> Unfortunately, almost no information is available about this chip
> except that it ships in an 8-pin package. Are you sure the chip
> supports two external temperature sensors like EMC1403 ?
> The chip numbering and the number of pins would suggest that
> it only supports a single external temperature sensor,
> which would make it compatible to emc1402/emc1422.
>=20
> Guenter

The datasheet I've seen says:

>> The EMC1442 monitors two temperature channels (one
>> external and one internal).

Based on this, I agree that emc1403 seems wrong.  The datasheet also
says:

>> Pin compatible with EMC1412

>=20
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  	{ "emc1422", emc1402 },
> >  	{ "emc1423", emc1403 },
> >  	{ "emc1424", emc1404 },
> > +	{ "emc1442", emc1403 },

So, emc1402?

> >  	{ }

--=20
Patrick Williams

--1WgzJp/BygG6uQK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmVBt3kACgkQqwNHzC0A
wRk+jw//VVmJXshZwt3N+ypEYxo6K6shKaloSoiCAbe+07PIgfmI8kfqWjqPfeYf
fZZ80rh7NgtX1qrKXVtFxZgRI3wgpKxDYXqlzkUcGRVdrlMtKg/c7kHXUMgHzGoO
infqGsQbodYk13nxIEKwD1Wl1d6c+nP1yIESK+PKsNFthctucFNgTNpPJS/EgEdv
g03fucNe6uU2tt2nxb5UHqgLJidRCzSRdQiKdnTmcpEbKjwtHHS4CKmXQcxmj0pg
Z9zbzm2uZgyKGPgUxpRUS5T1HEF82ut4hSzRYkAD7Cc4dCiUohJMdjKnz5mm6ua4
c9Gq1SKpImk7uNLMaDkZYJITdNvb+Cg3T4QtGtNfasBgKLO731nfXo4fZMRgYmaw
Lyyr/gEuXw+2iFXin47tl4Ig32yy3r9rcoDyfjMcWsWQn5RVi0Tb4b6jVpfHxulK
qPbKHQcTyB5al+fyG1FpjDetAfJDGcBqZcPwalwCYilQFrbUa9NEB3hS4+y+vssX
NI8c5mz5/knsXF1QOVOPID+Suh+zu1EGTdBMrnZdfAlu/bvfHNcOPEU8zBSbtGCy
OVSXsO3PHiXwehg9pmImfwJ7Fwlnvd4ZaoeKH+NWfG6/Xx8qbWe1qLJqoIt3DV1D
ffRCDGH5ffLWzw/2Le2779CHyyS8HaodHi/CmdxRcGyCDR5bKE8=
=okqw
-----END PGP SIGNATURE-----

--1WgzJp/BygG6uQK0--
