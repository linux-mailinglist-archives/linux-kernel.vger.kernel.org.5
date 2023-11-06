Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08D17E2667
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjKFONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjKFONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:13:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4A99;
        Mon,  6 Nov 2023 06:13:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C102C433C7;
        Mon,  6 Nov 2023 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699280032;
        bh=Igyfnd7gKatDLsWMFivF+3reFZuVy396YDB1a4OV+Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ED9ygq3qarkzAUt293YaP55vmkcsDSfqmhINXXvojeAc7aqbwHwBedG5uLzGZ2who
         Tyqk9dgh4e38h0qY/06PDVVFTNdo67xPusjN8076/xtDe0FSYK/dfifrqTiIwqK2gM
         hepRtbKD4ECsApF8YG39efNvaIz2Hx3NCR/F8gomHGzpdIKHHxhQ/EDmM8+APWjOQn
         fRbrAEf2bWXzO+qCbaZzo3cFbss8iu0Em6E2f2uGZd8yKj5q8xlyqHCiiMjujW2XXG
         b41yiFOoJ43t3iiSo7xR8DC7SeOITlTEXwpyExQwjkoLiNHLSvZxvTJx6vF4KqpjUq
         F0p8j/Kz2dhWg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1r00NB-0000KT-2f;
        Mon, 06 Nov 2023 15:14:37 +0100
Date:   Mon, 6 Nov 2023 15:14:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: gnss: u-blox: add "reset-gpios"
 binding
Message-ID: <ZUj0zWeadtdtCHGy@hovoldconsulting.com>
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
 <20230921133202.5828-3-wsa+renesas@sang-engineering.com>
 <ZS0-E_h4I_g7zVIm@hovoldconsulting.com>
 <ZTYYKVTYEa6roCci@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5WuYEJnvvvo97xO2"
Content-Disposition: inline
In-Reply-To: <ZTYYKVTYEa6roCci@ninjato>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5WuYEJnvvvo97xO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:52:25AM +0200, Wolfram Sang wrote:
> > And what GNSS chip/module is this? This should also be included in the
> > commit message.
>=20
> Ok. UBlox Neo-M8.
>=20
> > Do you have a link to a datasheet?
>=20
> https://www.u-blox.com/sites/default/files/NEO-M8-FW3_DataSheet_UBX-15031=
086.pdf
>=20
> > None of the u-blox modules I've seen have a reset line so I'd like to
> > where this came from and how it is intended to be used.
>=20
> I didn't know that old modules did not have the reset pin. I thought
> they were simply not used, so far. This one has. Check pin8 in chapter
> 2.1 in the datasheet.

Indeed. I must have looked at the datasheet of the older neo-6, which
does not have a reset pin, before replying.

Johan

--5WuYEJnvvvo97xO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZUj0ygAKCRALxc3C7H1l
CPcKAQC0U4Up4W8lCsEWnKplr3kztUCxvmhvjq4JrmLEzdpqOwD/dZ5j62BAxT3S
cOb92huGBfWpuqvGNcqG5yObTdhg2gI=
=1QCH
-----END PGP SIGNATURE-----

--5WuYEJnvvvo97xO2--
