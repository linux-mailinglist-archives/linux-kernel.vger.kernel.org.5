Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910E7F0662
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKSNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:25:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427EBB7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:25:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07EFC433C8;
        Sun, 19 Nov 2023 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700400309;
        bh=XxhddzwNIgG+bk+3II44/LNd5CBnAQSGnu4afaRF7wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEyBk9xHjQgzNe3JUfRMRpC8nhwfSpFiGj7o1bqgDr3/201wAk4mJNJ+NI1jiPF4B
         sTEgj9wSfJBDjfOiVuQERo63Nu7u9qgegsXriMdy6uh5++oHykdn1Y0M15OpMauJ+o
         rEsGnzT1Zh8c6zgHc066j5/E/hxgFXvOm88vRD/xOkCCR9llw1AaJ1WQ1zE54oT5QR
         0bABp9htnT1BfNnaapquepVc0CwKx9S4CRiVAxF/bd6QvNCQ3b3JvVVBaUM4+5rrQR
         cG2zlMZwPZZoTlAYidA6RidFgcwWlN8htCWsH+4f164o0pb6yl9drfODminYieHr5k
         ODVeVFGUHwfEQ==
Date:   Sun, 19 Nov 2023 13:25:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Garmin Chang <garmin.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: mediatek: Remove compatible
 for MT8188 VPPSYS
Message-ID: <20231119-zestfully-riveting-fe9793281903@spud>
References: <20231117053934.10571-1-yu-chang.lee@mediatek.com>
 <20231117053934.10571-2-yu-chang.lee@mediatek.com>
 <20231119-gem-plus-3217ffee6278@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="52bn6chajiCX+Q3f"
Content-Disposition: inline
In-Reply-To: <20231119-gem-plus-3217ffee6278@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52bn6chajiCX+Q3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 01:13:47PM +0000, Conor Dooley wrote:
> On Fri, Nov 17, 2023 at 01:39:33PM +0800, yu-chang.lee wrote:
> > MT8188 VPPSYS 0/1 should be probed from mtk-mmsys driver to
> > populate device by platform_device_register_data then start
> > its own clock driver.
>=20
> How does one operating system's driver probing model render these
> compatibles invalid?

I see there are 2 patches in the series. Merging them into one would
likely make it easier to explain the hardware-related reason for this
change.

--52bn6chajiCX+Q3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoMsAAKCRB4tDGHoIJi
0ihkAQDJXXL1MR0xmgwkXWBGLU44bL7kUV19Z5GlMv86zlEa/gEA2ghoULkl2Soy
4Yog79X3xremp0NR4VN2JldFYg58TgA=
=gEqL
-----END PGP SIGNATURE-----

--52bn6chajiCX+Q3f--
