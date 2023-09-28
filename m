Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A77B145C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjI1HOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjI1HN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:13:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DEE527F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=Gz38
        FWoRozMk8ZqhH2Py9rFMLzQbTzA9Bq0tD+78bXY=; b=iSteBfY4PmQYZ/rE9MGE
        Aa7HCszSBZXFnVBkVo1yAovhD+Md4Tww6/SrNRadqqVOku/NKM7Ma5t8Pf0CW3UN
        SlSDE04gl5CDWYyUmRdYDb8fNCMKfsJLMLITu2x7ZukNZP/P4fwC3ygs9NslVZBs
        1kuTKsbf41/pocd09vgLIaII7Vg4/aMuH6i1SXMIinXU/VKI8ucdtCaP+5aCj9Ke
        cRpTBoIa1KDIeGLfeZcgheZGv8UZ8TRk0EO614DOdV4X3MkSryYEbO9uPfSPEYp1
        kTNyZ7SykrGZc/g4Lg3Dw+SSlskYrvydEhWyRDpGDRar5CUDKj9DY5XO5Vj4gMIT
        3w==
Received: (qmail 3367098 invoked from network); 28 Sep 2023 09:10:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2023 09:10:25 +0200
X-UD-Smtp-Session: l3s3148p1@rft/AGYGLOAujntX
Date:   Thu, 28 Sep 2023 09:10:24 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/6] mtd: parsers: ar7: remove support
Message-ID: <ZRUm4DS3qvRfcPox@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
 <20230922163903.3f49ea2a@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vh1lYzYZNvhd1Ak5"
Content-Disposition: inline
In-Reply-To: <20230922163903.3f49ea2a@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vh1lYzYZNvhd1Ak5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'm not sure it is wise to merge defconfig changes through mtd. Would
> you mind sending this change aside to avoid potential conflicts? Each
> patch can live on their own anyway.

I checked pxa_defconfig history. Most commits in the last 7 years were
just removing outdated Kconfig symbols from all kind of subsystems. Like
what we want to do here. I think it is okay to keep it.


--vh1lYzYZNvhd1Ak5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUVJuAACgkQFA3kzBSg
KbYCyBAApP4Bff1yQaLcXDSSDNpNegd4Bl+v8pEZsBfyjf5J2xGfttFWrqWNM2ew
NQ9sR5LIPA38eZEHIxl9UBFaC1npN58b+GU8I1OD/OCYLfSjfYeuUPP7GrnXz2nc
EShRfOA6uELVpAWkf8nlIohp4MBrDvJk5Ut+VfG1xG3HE3Sk0Te6uXF3lgLWEU7r
x2/KT/hRj6uJlk6dDb0JrQqbmCpyP4X7HrGGuVDJ4icTBCAAhBluqoVQXa217vJ3
NAI+Q+/A8FWDJNu/jI+IQR68YxMD2juGlqXVNY+bJ80KtX12IgTDR9NWMYNVtTrf
kwpBLAtYSHnaKD4WdfJcOP/2iARYo/e/WFqG/3f6xtJzmnP9+hqIRCPkHpTo/k9S
GPtpeZnAPLjPHk32zQYV8I5b+XODXIw7C4zBB+XvSnx193A3yPHnMtVfhp7GQItT
BeCBJDnMPIUC33wBpzT7ii7HN07d1Vto1mI90ELU1QK0W/sb/E7hokxEHQNM9/QR
1DLh8m5dZCNRzU25gPnYp7MFbdCzqL8itPi5KwVMvoReFXq5Zl9/XK/VUK/yNTzq
/zpymcbR5+zNZP2wKYdTz6vJBq2mr91isLDleuwccXCLLB2FwZ3/I6E8tAXgiWDq
2rmVDN2m2E6/CFQMPUCYi3edterHoV9t9LESTkiY4zkExhhpQt8=
=Si4u
-----END PGP SIGNATURE-----

--vh1lYzYZNvhd1Ak5--
