Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D47AFF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjI0JA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjI0JAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:00:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF6136;
        Wed, 27 Sep 2023 02:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA96C433C7;
        Wed, 27 Sep 2023 09:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695805215;
        bh=3hwoD84olVZvjou5/kpVm2ZQJLfeUVEZBHvliNaakz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwEW/w7n8LRFF9M0zplL9D8uw/SWwiTSVd0hIYDS9p/5TOw47gAFnttbn9UIvIDWm
         rOZ+yF2krn173lbJYz3yZ91794OuDlI752kcTAZ19MQ83Ps+RaFYW9Do6NDMKeWrO+
         JT1UHT1FnzBnD5aE/Rw5FfRavK0k8+8Gk55yZvTpZAZM52HCp+N7Gps5aDRPpCMnXY
         nDOmw8PX/rbGikM4rN8leN1WFnd4FQr0CaY9vPjM3+XrmOVQojHztPhmZOQQpdzWpt
         /qZOJcF4NONUIAq0sCUqm/T0Jj4oA1LxIgPdQFslxN30bO5k9aD38eQKh2DbsrFi2s
         P+oAfb3y0RTSw==
Date:   Wed, 27 Sep 2023 11:00:12 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Message-ID: <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QiSZLj8ULhE5uAOG"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QiSZLj8ULhE5uAOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 09:59:05AM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 26, 2023 at 11:08=E2=80=AFPM Fabrizio Castro

> > +    type: boolean
> > +    description:
> > +      Use CSI Slave Selection (SS) pin to enable transmission and rece=
ption when
> > +      in slave mode.

> Can't this be done in a more generic way? I had expected that the
> existing SPI_NO_CS flag can be set using a property in the "slave" subnod=
e,
> but apparently there is no "spi-no-cs" property defined yet.

The description is clearly saying there is a chip select, _NO_CS seems
entirely inappropriate.  It's not specified in the device tree because
when there's no chip select for a device it's a fundamental property of
how the device is controlled and we don't need any information beyond
the compatible.

--QiSZLj8ULhE5uAOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT7xsACgkQJNaLcl1U
h9Cv4Qf/XYUHiyb3CeUAVkgA5kzU23PQo4xps4f/9NjXmDxMNXGjd1mJz9drxsHP
orKXtyGMHXzQH+Md2RB4J7NMy+6W9wNCugC9rM11EClpnnSCvbqOMiybxgmW3kwa
nCpefQU+RK6Glv+wL1wNrKEJIWHKjefkFTODIJb2mxQ3QRhTBoOQcT1r0VZHJiTP
x5F44Hjq8apm/HBve10boE2dk+9NeRN7rKvT0HRaCSU0nN4tBtICJbYZjj++2o0b
6GHQCti/Dp+JahGpi4Q1MbUmS4XsZ33+pvXcxuFmkrJy/EkfzRTs0+5mYAcqM5x/
HN+l2oJlUTEqr+jp38Aqxdm9doYEtg==
=VLyd
-----END PGP SIGNATURE-----

--QiSZLj8ULhE5uAOG--
