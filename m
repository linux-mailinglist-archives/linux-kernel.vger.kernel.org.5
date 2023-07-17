Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86B9756629
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGQOQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGQOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370819B0;
        Mon, 17 Jul 2023 07:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA8F461070;
        Mon, 17 Jul 2023 14:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2314C433CD;
        Mon, 17 Jul 2023 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689603337;
        bh=n/y7Puy+QLO7pyomnsPv4n3B4YlS/lEyIf8pJI8o1+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gH0DZ6MuZvmlAQAbeQdzOMx+YEA/zD+HrVnXYNGZAzgV+Gi3WVXQtH8P5aq2rLodE
         V2kdJILgioySNYF7FSnPcHeBIKaj2pIFCTaJ2q6WEiwjfiuGJeWacQmBp3WR2UlnRN
         l7xHy6SvbYMet10JIzK5ERHKYuOwy6TxToWZckyJhaN4A9JrDdEQxLIP6GPRyABWhZ
         Wsbfb+yB3bRZCrTK/ril2wc5tCmJNAVrwOW+8qOfS9Z0aLDBXAwFGat3PhqAhI1ONE
         iVOSt+lJVcnCg5gQGSVv+xLMst47+WF/2rS/01Yr+yek3TmLTrgtofByjOC6D4Irbm
         TN1dA3mv/LHRw==
Date:   Mon, 17 Jul 2023 16:15:34 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] clk: sunxi-ng: mux: Support finding closest rate
Message-ID: <upoq33e7zww6pudqvpzyy6o377pusj6inusrxr7gieabi54l6o@v4772ivtzjxe>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-9-04acf1d39765@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hcwomx4vpvydqutl"
Content-Disposition: inline
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-9-04acf1d39765@oltmanns.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hcwomx4vpvydqutl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 03:34:33PM +0200, Frank Oltmanns wrote:
> When finding the best rate for a mux clock, consider rates that are
> higher than the requested rate when CCU_FEATURE_ROUND_CLOSEST is used.
> Furthermore, introduce an initialization macro that sets this flag.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--hcwomx4vpvydqutl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLVNBgAKCRDj7w1vZxhR
xQ7lAPsEVdnYEfOYY2vxBplyTJ9D0tDMU1SNBwRHZd3+AvuYtQD/ckvXeTBux6DW
JbCZpyDA035wglj3uztomr2OYcQXrQM=
=KFSz
-----END PGP SIGNATURE-----

--hcwomx4vpvydqutl--
