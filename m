Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BD97695BC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGaMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGaMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB931703;
        Mon, 31 Jul 2023 05:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B78860DF6;
        Mon, 31 Jul 2023 12:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514E0C433C7;
        Mon, 31 Jul 2023 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690805489;
        bh=naFJbgINelM2717nXbRFhss56yWnfCySmFfjHVRWHwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3iL8vOllRKgjSqkNh56bsU6zYgHtsTCCLV7IfOKnA51FJtax59oMDDLBmrZRbw8W
         9xbM9ECDdl8ZicSwC2jCo442D6I1vTontuWZF8w26nh6qwGDlEwTNH/32JHyVKq269
         qcbbGgMJ0W9Ddhs+Z+4k1AcDcOVC/jlQMa9Z9dQuMmVGO6N/ZvYHDdgb+/5JwxwDHk
         XaewpWQ5Q/w7lw7TiG/6MyBJjK6tv8OE6y1L9HoDZa7qvyoqCjUuVMigGeAPAklmD/
         foVuBEJxgF3CX+HqEYQQZ2Upu+6iXeTPb9KLTInzh/rcEgxav4Vfq3dCLsfuJ6ST1N
         1BEc4CdSyBMVg==
Date:   Mon, 31 Jul 2023 14:11:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
Subject: Re: [PATCH v8 00/16] CSI2RX support on J721E and AM62
Message-ID: <zf34tzgluu7x44b7ehpqui4svhcs5kg7hfzurgventninpazam@yullzakyrwxy>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5md2j5cen42xfvab"
Content-Disposition: inline
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5md2j5cen42xfvab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 31, 2023 at 01:59:18PM +0530, Jai Luthra wrote:

> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.
>=20
> This is a V8 of the below V7 series,
> https://lore.kernel.org/all/20230314115516.667-1-vaishnav.a@ti.com/
>=20
> Since Pratyush moved out of TI, Vaishnav & I have been working on
> this driver, and I will be maintaining it upstream.
>=20
> J721E CSI2RX driver can also be extended to support multi-stream
> capture, filtering different CSI Virtual Channels (VC) or Data Types
> (DT) to different DMA channels. A WIP series based on v7 is available
> for reference at https://github.com/jailuthra/linux/commits/csi_multi_wip
>=20
> I will rebase the multi-stream patches on the current series (v8) and
> post them as RFC in the coming weeks.
>=20
> Testing logs: https://gist.github.com/jailuthra/eaeb3af3c65b67e1bc0d5db28=
180131d
>=20
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

For patches 1-14:
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--5md2j5cen42xfvab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMek7gAKCRDj7w1vZxhR
xQJhAP92ui3wC2Fzxysvom9q9py3uK3FF/4avQZJbp5v4JFL9QEAkUk+pBCriUUO
lR24dHTFZ+jKITMFUgp0h8yL2mxtyg0=
=XvwT
-----END PGP SIGNATURE-----

--5md2j5cen42xfvab--
