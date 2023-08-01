Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3176BBA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHARuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjHARuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:50:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B21BF5;
        Tue,  1 Aug 2023 10:50:10 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-079.ewe-ip-backbone.de [91.248.215.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63D1F6606EEE;
        Tue,  1 Aug 2023 18:50:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690912209;
        bh=7Hg0E1etExajNXwd23tOTZp+kdpf7HoQD1TpFyCl8ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYsQyNsQw97XKN6vimxBDDLHXBUprgotAZq6Nbq9F+vr+9zeRfac7xeQ44i54km34
         +FsiZSVlJjvSMBnCYHuVzWuCavLDxbitm+tFNXhMxckTFhQ1Vdt3oE2GCm+AgrQO8A
         57EfGuw/PBdXTXaJ4+bG2D/M5lL6wJJn0RoU5OX2CRE4wmVqptglWUul5Kya9Hmfi0
         voeEnCfn8OCvvU76ofmKlmJ50KR4PJsNbRYjnhKT+EEbNH8YZJjG+iCMHgEcRE5aOK
         7gSk5TFJpfv6nJfPwdgERvJTcT/DvvgCF9TNvIslbkAfdo0YKu/WXhUGE1Iq0Xh2FG
         BvP0HcOsqYflw==
Received: by mercury (Postfix, from userid 1000)
        id 2864C10660D0; Tue,  1 Aug 2023 19:50:07 +0200 (CEST)
Date:   Tue, 1 Aug 2023 19:50:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: Re: [RESEND PATCH v2 0/3] clk: rockchip: add GATE_LINK
Message-ID: <20230801175007.kd5j3c6ygjyn5wh5@mercury.elektranox.org>
References: <20230801074357.10770-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xlamvs4rdr7wg6vz"
Content-Disposition: inline
In-Reply-To: <20230801074357.10770-1-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xlamvs4rdr7wg6vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2023 at 03:43:54PM +0800, Elaine Zhang wrote:
> Recent Rockchip SoCs have a new hardware block called Native Interface
> Unit (NIU), which gates clocks to devices behind them. These effectively
> need two parent clocks.
> Use GATE_LINK to handle this.
>=20
> change in V2:
> [PATCH v2 1/3]: fix reported warnings
> [PATCH v2 2/3]: Bindings submit independent patches
> [PATCH v2 3/3]: fix reported warnings
>=20
> Elaine Zhang (3):
>   clk: rockchip: add support for gate link
>   dt-bindings: clock: rk3588: export PCLK_VO1GRF clk id
>   clk: rockchip: rk3588: Adjust the GATE_LINK parameter
>=20
>  drivers/clk/rockchip/Makefile                 |   1 +
>  drivers/clk/rockchip/clk-gate-link.c          | 189 ++++++++++++++++++
>  drivers/clk/rockchip/clk-rk3588.c             | 110 +++++-----
>  drivers/clk/rockchip/clk.c                    |   7 +
>  drivers/clk/rockchip/clk.h                    |  22 ++
>  .../dt-bindings/clock/rockchip,rk3588-cru.h   |   3 +-
>  6 files changed, 280 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/clk/rockchip/clk-gate-link.c

The series is

Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--xlamvs4rdr7wg6vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTJRc4ACgkQ2O7X88g7
+ppnUg//YPiJxGhC4x6wnm2repGisqmL17AG/28MMxHdEQ0NWJyPMw1gaa0dpAR3
2sA9RYmfGWRE/PqgArXsrdkdByEubVlLkMDoBEjJr6ZVJ5IS8qvPR9GEzIHtjW5D
o9BdjDqsOyRmiQXBlPV+mW7PQU0OI4mYWem2MewzmYs8gXPpP6iYX0IxPR4w0MSo
c4XEqorPXMGmf2+kIR5pOlEbtkWlQ8mdJga5Zlw/t9Z6AQ2gT1Q097ZeocKgmDPN
OiIN+P7YOlJZqqa+nzG9lhKD2c1KozfQR33eDNqqDX0XoiBJ1SzK0Qm2LLCDh3Cq
yRQGJzD5sl7LaqE/vqq9/2udyvHaZOUYP4SWHTzsEGP5dIm+WjgAo/RrTmKQkihi
HThdmDq5kXgWUIX5ywAZmcbCufjTOVcGxQUf60S8FV9lV96QJvEydhd1s6UPEhqZ
ISzRKuzgxQFLIqZjIDvELHR/4nTngukouV2v0TNydMB7UNvwMoFVw3Zt8krLHCwm
yXFjgKLsrWDwqTzjpuCIonbVl5OfCR11wT+ACeOLKStdxpHUzraWv0piw2X0+dzP
VtFH9Y5TdTann0CxeV4mEeCOD2iw5aGYm49sYillNBPLwr1FQqeTH987FKKwQthF
/p2WWpmK56pA2C+HFrPb57QV/3UnAOzj18JmEAQoXXDzKUmGxWE=
=Utsw
-----END PGP SIGNATURE-----

--xlamvs4rdr7wg6vz--
