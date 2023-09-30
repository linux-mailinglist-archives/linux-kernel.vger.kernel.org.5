Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910527B400E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 13:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjI3LIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 07:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjI3LIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:08:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB5CA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 04:08:16 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1dce0c05171so6748550fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696072094; x=1696676894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0I0W5qW0c11Sb8x+pl/ECGExDC46VWx32XMabXW6vc=;
        b=OEMN52853lYEssK2p8k65vQbUf6EavVt2WxVpN9jYZz8vJ99npIUojqBJsnstlcgil
         yKJAljdYEg9KZ9vyOuvgkn15mTSOtSO0tTLFEo1U+S7RAouuT4qG52+bEipjF4g0zNp8
         Hml670YyhnfdFcnW5FWtWF6di69Y7xhTqPUvfHKtBNxOMCnfJgQ+AKjx0IkwBEiUNEp7
         Au/lqoR9Go6YQ8QukfzKWvM0XtvdDOD9JlKddL+wY3/F3lAXjB5zg/yU9h/b0zqu0w9I
         g5rmMXbtELaAdsJCDQXR7uRtA8mH8JIlpegFTSURzQFYGQ/Q56WX0LL12+5D4ex+m7eM
         FI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696072094; x=1696676894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0I0W5qW0c11Sb8x+pl/ECGExDC46VWx32XMabXW6vc=;
        b=YpNzOf+fhaVKa5BYPM1U8Ihw1oS54AYALJzlxZXlSHETma7kIC/+ILWgIZW27rAKwp
         77Km+ro5sy+n7h7shVQm7B9KiBiF8VoW2ba8HbbGE3Z7h5qYQaf1SesweN/+lDtAuEr1
         wUiFLVvvtvkKqN7cZH2aHZpoFys237KhWudW9Ev7ehPFiovVr/0C7OT4kreLFpbyHjG8
         FhAUQ3h613TZFsGB/f4VfUAM4Le/T1yOr9gCCHWipU4AgWR0cY0dQtvl3OX7+ew1IhOB
         gpfASCniEykH0y5xFZsPvp1P6IhAHbee3OYztG8H41NOaVBk+KWKUwoXAisKo8XlORf1
         /mfA==
X-Gm-Message-State: AOJu0YwGfejoG7Zo38k+pbZTXAJWm9uVopr3cPBoYtxCITMkh/WJK9jA
        1VUuRxLfJl1HvttLXp3nL6sUHqFYZhI=
X-Google-Smtp-Source: AGHT+IGQVpBys6fdWBt2peWQLH3tbAZdvAEk9mTeBAKp8n0KuxVdZdkhEzgnF91GmfYw3hVmQfhSUA==
X-Received: by 2002:a05:6870:9711:b0:1bf:61d1:a4d4 with SMTP id n17-20020a056870971100b001bf61d1a4d4mr7996201oaq.6.1696072093764;
        Sat, 30 Sep 2023 04:08:13 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w16-20020a637b10000000b0057c44503835sm14318409pgc.65.2023.09.30.04.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 04:08:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 85D63835CB24; Sat, 30 Sep 2023 18:08:08 +0700 (WIB)
Date:   Sat, 30 Sep 2023 18:08:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Adrian =?utf-8?B?V8O8dGhyaWNo?= <adrian.wuethrich@tu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Publication on communication structures
Message-ID: <ZRgBmEzNZyK1dxdt@debian.me>
References: <bc1fe3c5-d2bd-4071-af1e-28ca4b3a697c@tu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmBjhTEI1YaTwe+O"
Content-Disposition: inline
In-Reply-To: <bc1fe3c5-d2bd-4071-af1e-28ca4b3a697c@tu-berlin.de>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rmBjhTEI1YaTwe+O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 09:16:27PM +0200, Adrian W=C3=BCthrich wrote:
> Dear Linux Kernel Developers,
>=20
> I am a researcher in history and philosophy of science at Technische
> Universit=C3=A4t Berlin.
>=20
> I would like to inform you about an upcoming publication in which I
> include a very short, anonymized network analysis of messages from this
> list. The main topic of the publication, however, is the communication
> structure of the ATLAS collaboration at CERN, the particle physics
> laboratory. A draft of the paper is available at
> https://tubcloud.tu-berlin.de/s/N9noYEfHqBLDtQq
>=20
> For the short analysis of the linux kernel mailing list, I used the
> messages sent during the year 2012 as archived on https://lkml.org/.

Use lore archive instead [1].
>=20
> In the publication, I mention some global characteristics of the network
> of messages and replies sent to the list =E2=80=93 its density, for insta=
nce
> (see p.=C2=A017). No email-addresses, nor names of persons, nor any conte=
nt
> of the messages will be published.
>=20
> The paper will be published in "Synthese", a leading journal in the
> philosophy of science, in the topical collection "Digital Studies of
> Digital Science" [1].
>=20
> If you have questions or comments concerning the publication, please
> contact me at adrian.wuethrich@tu-berlin.de.
>=20

Please follow the guidelines in
Documentation/process/researcher-guidelines.rst.

Thanks.

[1]: https://lore.kernel.org/lkml

--=20
An old man doll... just what I always wanted! - Clara

--rmBjhTEI1YaTwe+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRgBjwAKCRD2uYlJVVFO
o9eoAP9cFmolcWFoGb+CTdjnjhbDnYhQl2RZ/w4eAv3ymGZTFAEAumR47k4xdPID
7fszkIGSS5a/g2gm7yLtYGZ7Mdfnhw8=
=Bwj2
-----END PGP SIGNATURE-----

--rmBjhTEI1YaTwe+O--
