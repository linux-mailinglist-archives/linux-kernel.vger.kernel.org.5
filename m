Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573137AFFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjI0JPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjI0JPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:15:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE5A3;
        Wed, 27 Sep 2023 02:15:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE51AC433C9;
        Wed, 27 Sep 2023 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695806132;
        bh=8igskYP9DAYLL5BkUN44/CdlHV/Mw6iIVgqVj3quSNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIr6kxnXH3pNiI03CWn0VRQusJvmXnl05H0S/6tJttkoPRIBzM6b0HAKACG7eUt7L
         0A45Y8WSDoETfTvJFhAi87L2x3wGvoBEpRlDJhU0J5ljJ3ZXjw/9BBm7XD8dkoGMys
         sQgWnlYpBTnNldge90gMmkQ3P4zen8WAZrFEuLldDHEjgdxkhwrfa1Tw9yGr0o3Gup
         ZJl/77HJO87YX33GMlAKc9iICxyQLaXfi1+ZdIv0W74UPuWFcAjqJBlkhBaxMKwKjf
         7h8s2kvUOX/lwmd0J4mNr0hocvq8FtB1ybKObQjpkjImMm/NjO4C5G/VG3YS/FaItD
         YKFdpkGjpHTyA==
Date:   Wed, 27 Sep 2023 11:15:29 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
Message-ID: <ZRPysQnvSDXgI1ee@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
 <ZRPvikYWgbeDdz4X@finisterre.sirena.org.uk>
 <CAMuHMdUroPd17ynUtXpEpUfp_g352ukG-Fc+ySrrsVTJhMgONw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7Q6HPrYwTOa6SDxa"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUroPd17ynUtXpEpUfp_g352ukG-Fc+ySrrsVTJhMgONw@mail.gmail.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7Q6HPrYwTOa6SDxa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 11:12:49AM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 27, 2023 at 11:02=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:

> > Prefer controller and device.

> You mean host and target?
> (oops, got the latter wrong in my previous email, too ;-)

Those also work, yes and there's less chance of confusion for the
controller bit.

--7Q6HPrYwTOa6SDxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT8rAACgkQJNaLcl1U
h9CQ2gf/RVrcGhvqI82qepeGvwQ3rWMv7YVd+nNKRuoXW8c3z0/YjQLtXxQm9UQU
S+L3NUh0Yor97P8Vw0StvndksOpMio1Fdv/nJpF9Y1BbZVXvKO/zCeADCQpQmt7/
s41FUaTIuUgv3qxOPl4AfbKbmQYX2WJjT1hgG/7kaVcJOrJ0MMG6oA6KsV0mzSSd
V5+whuPMULcWyS0RLitUxIfS+kS4WEQ/ZPuLOVy7W3cvQheu3RNXYNTTG7LAbX/T
/kNFB8lFqXAxiSoM6m4KKhQ67sX5XZf6EkLd+mOgYQ/O2oFJjfRiz0ncKVnaLQB1
2vw9j/u2vUmemF0eCGaeq7JbixMXBw==
=rweW
-----END PGP SIGNATURE-----

--7Q6HPrYwTOa6SDxa--
