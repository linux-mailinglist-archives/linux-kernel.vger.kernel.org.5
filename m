Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3576BFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHAV6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjHAV57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE60212A;
        Tue,  1 Aug 2023 14:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA7B61741;
        Tue,  1 Aug 2023 21:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5174C433C7;
        Tue,  1 Aug 2023 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690927078;
        bh=snm5QbsTw0Y2GRvaDzxRn/9vRq5/uytxCShgtBBi4YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXWC55U27QoycOfJabrmTQ9NhP3LYnV3OaQqP3xu6ILWhF75FHh98BvZVb/3qLSoz
         MgJrQ7vJmoyW997UbmdsIdnR0gEtDQUFhsHyuwBcrG1YeSWddGKtmsXZ1VaHOHshm9
         PJDkmlCUI9WLQHNpPtsJhIrfdQk5jSZKvVBU7S5a2P9Yx5cgJLp8n5O8z2Y0jfNthk
         LiXB54NKfVM/UQe7wgQ1hDyDn0dgg9DIcD+K0X6WGCQB8ee8mGjF+J4bqlqk3KXhXx
         AoXxBSNwDUasMDCYVzIQBtlDaZtNgsFpfwrF0nkZ4kBzJ+vHE8h1bXX+DX6xbEcxno
         PwdYSdRihboJg==
Date:   Tue, 1 Aug 2023 22:57:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
Message-ID: <20230801-reconcile-preamble-8713b6b09ef5@spud>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
 <20230801-dividers-chooser-bd0df9b72d91@spud>
 <f9ab7525f048f3ce814d89f106947c34@denx.de>
 <20230801-selective-strife-b595804cdb27@spud>
 <deb6a4e60f37e9764d24e25b8a6d1d97@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qkunuk7GoHQFqtuh"
Content-Disposition: inline
In-Reply-To: <deb6a4e60f37e9764d24e25b8a6d1d97@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qkunuk7GoHQFqtuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:43:58PM -0300, Fabio Estevam wrote:
> Hi Conor,
>=20
> On 01/08/2023 18:28, Conor Dooley wrote:
>=20
> > I never said it was chief. Please re-read the quoted text.
>=20
> trivial-devices.yaml throws the following warning:
>=20
> imx6q-sabrelite.dtb: camera@42: 'clock-names', 'clocks', 'gp-gpios', 'por=
t',
> 'powerdown-gpios', 'reset-gpios' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>=20
> Would it make sense to remove ovti,ov5642 from the trivial-devices bindin=
gs
> as well as from the
> following devicetrees?

I would rather that you documented it, rather than removed it, please.

--qkunuk7GoHQFqtuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMl/4gAKCRB4tDGHoIJi
0tQUAQDRYUSIv3MMaL9eDBUovmubABz6C6LbU82pfzERKSPrJAD+OzF0Yswm/a5d
Sq1uOoR8IoqteIM596VWEyOuuTlM6gM=
=UkMR
-----END PGP SIGNATURE-----

--qkunuk7GoHQFqtuh--
