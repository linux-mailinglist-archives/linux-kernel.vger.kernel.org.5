Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D797622C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGYT5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGYT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA319BF;
        Tue, 25 Jul 2023 12:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F02261151;
        Tue, 25 Jul 2023 19:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A2C433C8;
        Tue, 25 Jul 2023 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690315057;
        bh=J6eD1DQsFlp469zAqqrd4H6lmF51FIudZCZ9aP0HQUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NT6AcGEPrY1WDQRNb1h9OKzPAVKq3GMlv8zwefn8NpHt4X6zChjMwL8zYy3gakNgX
         bpIbVZBG8AaVWR2YcNDdKTwzhmPzCUROigP/iiUIwGBeek2bk9+ILXM2UV94ckLcg9
         tk4EZV+vPNEWQ/DaRN4M2dCM0saUJlG/rjLFykNKKlJMGuRtYl4d/FfBM2PVvMfzOe
         uDmcWaxMHPLd2mxS0boTU4RymIubVbVLJWb24APEET1+UC0ok6dvCNqBsryEYlINZ0
         j6wYvu0Cx3v72h6HKiVdyql99KckqywuSirK2aA82WzhVqHsiLHSBfbTnyBghACUJF
         vrmYEF59k36yQ==
Date:   Tue, 25 Jul 2023 20:57:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: dt-bindings: active-semi,act8846: correct
 supplies
Message-ID: <20230725-handiness-anyone-19af308254f8@spud>
References: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
 <20230725124629.150113-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iJymcqGfrN7u5Pd8"
Content-Disposition: inline
In-Reply-To: <20230725124629.150113-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJymcqGfrN7u5Pd8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 02:46:29PM +0200, Krzysztof Kozlowski wrote:
> Regulator supplies are per-device, not per regulator, so they are
> expected to be present in device node.  Moving them to proper place
> allows to simplify a lot, because now none of the regulators differ.
>=20
> This also fixes dtbs_check warnings like:
>=20
>   rk3368-evb-act8846.dtb: act8846@5a: 'inl1-supply', 'inl2-supply', 'inl3=
-supply', 'vp1-supply',
>     'vp2-supply', 'vp3-supply', 'vp4-supply' do not match any of the rege=
xes: 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--iJymcqGfrN7u5Pd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMApLAAKCRB4tDGHoIJi
0mk6AP4maaYAoYDHYAxUsS81QOcs65RzGJhK4NRV7kltV3rG2wEAg1JNLisoHypA
SAjZ5v3e0Qh+eS+GF3UIGmBskLrrywU=
=u9wa
-----END PGP SIGNATURE-----

--iJymcqGfrN7u5Pd8--
