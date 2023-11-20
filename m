Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C07F1525
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjKTODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjKTOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:02:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CAD6C;
        Mon, 20 Nov 2023 06:02:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6534FC433C7;
        Mon, 20 Nov 2023 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488960;
        bh=6aSa52+i1oys/ode+5jaVFsNLiPy8c/knuAgK5eUilM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PecvQReB8EC0t4GDgV5A4OUDf7be4jwPihyMoCPHW4Uh6hGjsvr4p5yBYdOzhaVIT
         oNlewumX6fs/FbSZOKns16tQBSsGhenb65XKwaqOIJGXe27O4pFIy0twZdmZvaYSaf
         w4v1TpT3rEGoUDe4sLIpYvuHposrJoAX9cbhTdtSOsrWftqX3iWcPuBMB4glqUyUC+
         uCCSO5nJzMO12r436rZ2HsJdku7+LAYBkxcKe6hiAuf946T2qMsVpTZaFCKjfIRWJA
         5jXJvEQMMMJ0ScjO5X0gcPQ9R53GqA3h+7K6BA9u+CAgR4/TMw4ioQ7XElABDPGG5z
         VHSlIZ1LcEeAA==
Date:   Mon, 20 Nov 2023 14:02:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sbinding@opensource.cirrus.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
        michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
        git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
Message-ID: <281c9708-f965-4bb1-821e-3e6cfe26ba5d@sirena.org.uk>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
 <20231118135446.52783-2-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m2cq6RiF6dDmRuer"
Content-Disposition: inline
In-Reply-To: <20231118135446.52783-2-amit.kumar-mahapatra@amd.com>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m2cq6RiF6dDmRuer
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 07:24:39PM +0530, Amit Kumar Mahapatra wrote:
> AMD-Xilinx GQSPI controller has two advanced mode that allows the
> controller to consider two flashes as one single device.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/pci/hda/cs35l56_hda_spi.c: In function =E2=80=98cs=
35l56_hda_spi
_probe=E2=80=99:
/build/stage/linux/sound/pci/hda/cs35l56_hda_spi.c:32:52: error: passing ar=
gumen
t 2 of =E2=80=98cs35l56_hda_common_probe=E2=80=99 makes integer from pointe=
r without a cast [-We
rror=3Dint-conversion]
   32 |         ret =3D cs35l56_hda_common_probe(cs35l56, spi->chip_select);
      |                                                 ~~~^~~~~~~~~~~~~
      |                                                    |
      |                                                    u8 * {aka unsign=
ed ch
ar *}
In file included from /build/stage/linux/sound/pci/hda/cs35l56_hda_spi.c:12:
/build/stage/linux/sound/pci/hda/cs35l56_hda.h:45:63: note: expected =E2=80=
=98int=E2=80=99 but a
rgument is of type =E2=80=98u8 *=E2=80=99 {aka =E2=80=98unsigned char *=E2=
=80=99}
   45 | int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id);
      |                                                           ~~~~^~

--m2cq6RiF6dDmRuer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbZvUACgkQJNaLcl1U
h9C7+wf/Y66EoAefhFbBRGn/F667fF8eGVlw/njem/yf50HB8iNFULY3b1FDiQN2
tkohmbFFMPuwef2VX7ughOqk3b6vFTY6YRNVjvQvItlKJL85m8zuPVmetJ35s42O
+5htT9J+WhIbBIvaeL7gRms/hltTunTTSE0maVCT2sA8UTFFOXHLZ8SrYfRGMcHE
7h9rnmV7eJR/BttTqDtVyQg3n/MiRWvWZb+nhVQAE7ytHZVyydUYIWd8Cl4o941d
t0MJ4sTVXUwh4k1V2Km6CwTbfAFHmyQlv0Kgzmwb+F5xevmaymXutZqVlWYv5cR6
UZerV5/EA6GdypcQYNSC5y91TI9xUw==
=9H0Y
-----END PGP SIGNATURE-----

--m2cq6RiF6dDmRuer--
