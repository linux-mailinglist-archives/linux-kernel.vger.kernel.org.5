Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1729E7D74B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjJYTs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJYTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:48:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520493;
        Wed, 25 Oct 2023 12:48:53 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A76D66607331;
        Wed, 25 Oct 2023 20:48:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698263331;
        bh=4C0knIOWZSCqz/j853cFCQSGyZP8bkVC+6liKLv+oVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0dTNgmUY1CMPIH0+Dt8SUXHELGlSctli8R80RvqsaGhDMVMMWOzUM1L6F6I8mzoN
         E8Z7ZZ1itNj0j0VKV203EA2p7LcdTmiPA2vZQgokyOfPnoRKMOjDhUmddTYSLuYsqn
         ADzrAb9j8ACihiX5dCdAIm5Ccp/bOZ3dBWaw31v1N4dED8dHGe8NxtQ+tshcJO/QS5
         Y49iA4cp+Km7CBQA4LKjgVNlE7HdZcflH3x2/o7tfODgdtGZ3sghAuDoZCoqteL3nZ
         hIk871DhA3ySDmONlW9Rf9j2fPVi/DYw6KpM6haJlN5ihzF4x/vqcCzafhIA20iYA4
         BDf0GGY4hGLeg==
Received: by mercury (Postfix, from userid 1000)
        id 23927106057B; Wed, 25 Oct 2023 21:48:49 +0200 (CEST)
Date:   Wed, 25 Oct 2023 21:48:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     conor+dt@kernel.org, heiko@sntech.de, kever.yang@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: Re: [PATCH v4 0/4] rockchip: add GATE_LINK
Message-ID: <20231025194849.4esjw4w2trgalp55@mercury.elektranox.org>
References: <20231018070144.8512-1-zhangqing@rock-chips.com>
 <b0af9e04bafb07e8a73e8f242a4ff556.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tqfdiz36ofh6j432"
Content-Disposition: inline
In-Reply-To: <b0af9e04bafb07e8a73e8f242a4ff556.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tqfdiz36ofh6j432
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Mon, Oct 23, 2023 at 06:47:17PM -0700, Stephen Boyd wrote:
> Quoting Elaine Zhang (2023-10-18 00:01:40)
> > Recent Rockchip SoCs have a new hardware block called Native Interface
> > Unit (NIU), which gates clocks to devices behind them. These effectively
> > need two parent clocks.
> > Use GATE_LINK to handle this.
>=20
> Why can't pm clks be used here? The qcom clk driver has been doing that
> for some time now.=20
>=20
>  $ git grep pm_clk_add -- drivers/clk/qcom/

Maybe I'm mistaken, but as far as I can tell this is adding the
dependency on controller level and only works because Qualcomm
has multiple separate clock controllers. In the Rockchip design
there is only one platform device.

Note, that the original downstream code from Rockchip actually used
pm_clk infrastructure by moving these clocks to separate platform
devices. I changed this when upstreaming the code, since that leaks
into DT and from DT point of view there should be only one clock
controller.

Greetings,

-- Sebastian

--tqfdiz36ofh6j432
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmU5cR0ACgkQ2O7X88g7
+poZyA/+KGnTXYS/rnZLCMXb/+17hHTvzcgSIdn/BeQmRnEBHE9sjPFzD1KQ8Wy3
304qrkQt4azButXo31zUjB0creBEH1ZvhDV6tX8s7Gy+8mT2LmvvArVIWinZFnDj
YskCNEgiDFFDitOEh19nofsINcZO3YaHiVU1qUksXmvj9l350AD4vxsX6L+3f/lj
tF9RS81EzPZjyHci6j1LRttHnr8N8UBxGMZiSctcehrCcZPAYlrIfZh9NX1W5zRg
Rz2lhpPw22eh8Y07NHmiaDYvSWQTLQhBf4cAvBvNf/flzQ1V4U/Epaz3PJ7dob8h
xNZqNDn1/gEFUJeUtgsyXsZdnMnU3gnauiHlMU6jvAWo2fmh0MUJckysF/clUfBm
o05It58JOT1pjpHfIo7QRfK+NtW9z0Oi/YcsbxxzF0E9i7fuWd+tXgYK7ct0tGT2
dZo6eMm/RWQ7iUGgqvFoWhznuibG3vTyyJJ0n8hRySNtcrdUT6xsC7dnk7uzGyJn
U2afY2D+URGaEVX5h0xIL5dbPn0T2gnUmQoKeSdQgJHlCjoDUcOCkM7RTFr63x/6
k7ehuFax9yDUFfa83vK9TL1VsTPsiJoj9CFAjZEIL2HXlR2Iq2XbBCpweWIaA3Zz
gecnzHef2NW/Pi5znStuOQEcy0/HZAZq25N58364hewLcxFtrDE=
=xiVS
-----END PGP SIGNATURE-----

--tqfdiz36ofh6j432--
