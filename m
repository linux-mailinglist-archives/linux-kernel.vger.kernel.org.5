Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905AB7DF3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376494AbjKBN0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKBN0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:26:24 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABE134;
        Thu,  2 Nov 2023 06:26:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 427DA320095A;
        Thu,  2 Nov 2023 09:26:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Nov 2023 09:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698931574; x=1699017974; bh=La
        x5ShiBwLSsLjVsnn7zEY6/n4MOYHPf/N4qU9BqSCU=; b=MAL2ZyvjMEKoGy4Hrw
        ralTkad3wTXel2uRJb7bpxfA4oaJaooNvhFsVNOe/x+gSgPsbIyB/My26LH8fot0
        dzbDW1efm+a0hGKQ7+XXl/ioGaicBvmTNpuOtySQqThhi1vrljHiXikUtGyEDN5L
        purLq5iHjMRIrFbJaFCRyT/3Z1TEAXZ+tmXHhLL5EtBLg9sJL2uuKnbx0IYaUNMu
        Xp2zp6WaJQvXWaUwRQviU7Mfm5GJoppahLqRk1j9JwOJzLhmqf/lcufER47QyjQi
        PtywnXnmedh+E9J6cn26los02k+tBbHUz5vTR5U09A9/FnL8dSwfdR6OXVGqOmBk
        UINQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698931574; x=1699017974; bh=Lax5ShiBwLSsL
        jVsnn7zEY6/n4MOYHPf/N4qU9BqSCU=; b=vy1pV3xS+bb4zC3BiNQ+nfH2/8Sjk
        vTGw4kUOFAQ/ID52Aky6iyKPEEFtQetPugHze/xstw/i6YKvAj618jBvzPNIBAUA
        EYQY4pHw8NsCi0yZXGdpW1bktH9t6zEek/sCrqfcdW9eGPSC3lZaongNVM2gBrT6
        rJpiRKta9pZouiaG1P/MUOnwqmZKaMOED321fBGrxcKVsUCLQ8RzRS3DTZRgowAY
        mf/49gluNDt7ewTqG6mQKiBfaj4iP+2T/GS5OVlQVy9TWcztaCTkUQ5kMTKSUtYw
        KOsMWh8XYGVd5LQcYYanpEXvHLyjERAetTXgD+U25EZWTIRVadqJois4w==
X-ME-Sender: <xms:daNDZbHhPUZ7KeOqnocFXBRnVj3BCgZuKeHg75ZIzy1enntBDME4Sg>
    <xme:daNDZYU6QFaysPJYinbp_vMERXoBzePI8eu8gHVOtkX9xxdB6VF4ADcD-I3-ZNlwX
    mLvKw1BxnRq2PS7tOE>
X-ME-Received: <xmr:daNDZdLA6K3gW-muk9FygHsvPcNcdsu9m7YyJ89VlNhq-TfO7RLgRFG7SJXMfC1G8FZM8chUTQ7utljxglpX8jYWdknXINKZpTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:daNDZZEx0ktavFcXgtP8A95OU3dMXyvR3ZliQjIY2bxKP5A7HXxzJg>
    <xmx:daNDZRUl98wwW1tpxDcR-9ZOxorEFAnOz9LtbBjaeGwbK_5eYhKgNA>
    <xmx:daNDZUNEzjYHw6lR-r7BQ-bKEIiO0e2SOFc6rNlmiaJVdXUU5In5jg>
    <xmx:dqNDZUTPU40AC4QnxAK-4hafGWJoyMdv9CXmrriBgxzWBN7eWD3QAQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 09:26:13 -0400 (EDT)
Date:   Thu, 2 Nov 2023 08:26:12 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: emc1403: Add support for EMC1442
Message-ID: <ZUOjdGPDX06ehrLB@heinlein.vulture-banana.ts.net>
References: <20231102090808.427351-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9y/QB9703V4eDch+"
Content-Disposition: inline
In-Reply-To: <20231102090808.427351-1-Delphine_CC_Chiu@wiwynn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9y/QB9703V4eDch+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 05:08:07PM +0800, Delphine CC Chiu wrote:

I have a datasheet for this chip with a "Revision 1.0 (10-25-10)" in the
footer.  Reviewed the change against the datasheet.

> Add support for EMC1442 which is compatible with EMC1403.
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> change in v2:
> Revised emc1403 to emc1402

> +	case 0x60:
> +		strscpy(info->type, "emc1442", I2C_NAME_SIZE);
> +		break;

Confirmed against datasheet.

Section 2.2 "Register Set Delta" specifies:
    - Product ID | 60h

>  static const unsigned short emc1403_address_list[] =3D {
> -	0x18, 0x1c, 0x29, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
> +	0x18, 0x1c, 0x29, 0x3c, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END

Confirmed against datasheet.

Section 5.1.2 "SMBus Address and RD/WR Bit" has a table indicating that
a 22k pull-up resistor corresponds to `0011_100?` binary.

>  	{ "emc1422", emc1402 },
>  	{ "emc1423", emc1403 },
>  	{ "emc1424", emc1404 },
> +	{ "emc1442", emc1402 },

Datasheet section 2.1 is titled "Functional Delta from EMC1412 to
EMC1442", with minimal differences.  We map "emc1412" to `emc1402`, so
mapping "emc1442" to the same should be appropriate.


Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--9y/QB9703V4eDch+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmVDo3IACgkQqwNHzC0A
wRno2w/9EP6FkMIG1Z66KQ9SB7n41ROCzu00EHnKD4IJ8v1p0crAFeeboxl3/QAU
/gp+M3yyQXRobr0tn3AmCgPHBUpOx6nqVSN/X1XruE0G5eFLRosou+qJQl10LeVJ
qEuyKL4tSgRX1sL5HP9zcNQqwqyDXYwqWDiShgLfuJhMKt9g4mi8EUS3JvU+DWwb
Fa9uZRCkb+eAMjfGZXlZDf+dRAjSnm+euuKcHUaKQy+EX4VMx0B0fvZ2DGuIhXy4
5/DfXi9dXIR1BoDNHXjkeqrycerWdXU73h4puNBgim+c6hCA3iplCYcwx7rsthk3
P8m0pyqCP2sFLE4K32n/j1ZFKwy+b9+SBwmqpLnQuyT1ukdLa1xJEVh2yY5vECNO
M9zHLhUcUlj4NgqN3o9sxrtYAZn4SgEOuV3dPxjNOJyfw3P+CMm2gZ5aDTkGGTM3
1JzGomy20LOvweUWPxnQ7VRS8WedAFWgZPVeyAU+1ThFICRvRKELn3xz9beblAlO
IzUVPsODOPZ7QW5htxYCMUXidN8i8nxUOY+UgLuq8/xLmoM3HkcHKgdaqw8v+QYm
FC7ycXgXQvhfwxWoJaFzQ1QLSF3HOthHounyYsflqKG8dRnfrQVoaS6G6JMu9SbE
iQ+OL3n+B3E1SmRFBqVYYuWSwZlEAqmTQWiK3CFXlMFjkrkWy24=
=Cngv
-----END PGP SIGNATURE-----

--9y/QB9703V4eDch+--
