Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F37DE08F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjKALxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKALxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:53:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895E109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:53:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D7AC433CB;
        Wed,  1 Nov 2023 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698839579;
        bh=kT+HA+zDzpFBdPHZSCST/qs7bSjbi8b7+JQSnoifHqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7gYke/CXiKI6sE+NGcUo/Cwih/+kR9UBpPGsQRyJhEHFrzHVo/pEga4OQS2k7Z9W
         gb6E/qb91m4td9dXkgvTLNvBpW1F5s6/8rBQOv1xvhkkVigbCFKkYXqODI4kYLCZ+6
         UY7DQS9VWZNIXh4xddKkC1SPAnvYitevBwIzdf8/1NvHX6/hR4O3rVOV3viWUVl+3b
         i9G5PD5idJJCpWRgmgNcke14CStmZJnuUO4uzPB2u9URSo/aSeTknCQXWl3a3lhkqW
         4j+ZmWN/fQfpCyI6h8cFTphp+vlopUGOaWVowCKMjy914W+Owp5H3ZGtveaHnX1l2C
         +c3neLnzUa79w==
Date:   Wed, 1 Nov 2023 11:52:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2 0/2] soc: sifive: ccache: Add StarFive JH7100 support
Message-ID: <20231101-random-overlord-1315a03183fc@spud>
References: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOUMIggm0qSyhk5k"
Content-Disposition: inline
In-Reply-To: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOUMIggm0qSyhk5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 03:14:42PM +0100, Emil Renner Berthing wrote:
> This series adds support for the StarFive JH7100 SoC to the SiFive cache
> controller driver. The JH7100 was a "development version" of the JH7110
> used on the BeagleV Starlight and VisionFive V1 boards. It has
> non-coherent peripheral DMAs but was designed before the standard RISC-V
> Zicbom extension, so it neeeds support in this driver for non-standard
> cache management.
>=20
> Since v1:
> - Fix email threading, hopefully.
> - Drop sifive,ccache-ops device tree property and just match on the
>   compatible. (Conor)

I'll grab these after the mw, presuming nothing comes up in the interim.

--XOUMIggm0qSyhk5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUI8FwAKCRB4tDGHoIJi
0rPZAP923JPVEAE08sFKAd03mK5oK6G8QtIf3DWmwCgjl6rJgQD/beuiko2z//i2
B35OMBkkNMjeAunNJpSTmY/KXCQbxA4=
=l5J+
-----END PGP SIGNATURE-----

--XOUMIggm0qSyhk5k--
