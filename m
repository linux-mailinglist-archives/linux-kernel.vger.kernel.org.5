Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AFA762248
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGYTa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGYTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ED412D;
        Tue, 25 Jul 2023 12:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB92461883;
        Tue, 25 Jul 2023 19:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C09EC433C7;
        Tue, 25 Jul 2023 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690313456;
        bh=cSoVzaXL/Fs6an9grHNYTptMHglao78l58IxAdtohxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z49gSj/rgKrKHNHcyT8AXzy91LhjCBNazZP3ccVSQWYcYsCRyBjM95CjWyI7QSImR
         SJvbWYGC2kVybNd4Rjtnu3ETf7wX4hdI5aoHz49GnoEKwKncQJhp203nIIbrjpXO9l
         W+RaTaG7zTPh5YAcA9nZOz/UqzXXIzOUDoUDacM1UmcU499q4LxY9QQP5xYCNrKCK5
         w4/FKaP1Bqi6AB2iB0rZAB08I33uaLdp8i6ASsDxIjDhlNklVXftRcbfV3w7A2BWY4
         GCILZP2CnhdRu87A9CIC0HvsHCRvppQ6WOLvs2loEiSIfRFLLNj3NpdUgVovBVfDC4
         amjI4bdkFDFZQ==
Date:   Tue, 25 Jul 2023 20:30:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Eugen Hristev <eugen.hristev@collabora.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay
 defaults in schema
Message-ID: <20230725-sulphuric-syndrome-3eaace57ef43@spud>
References: <20230725155254.664361-1-eugen.hristev@collabora.com>
 <20230725161156.22uscijrot7gbnvj@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hNlqjw351EVDd4gT"
Content-Disposition: inline
In-Reply-To: <20230725161156.22uscijrot7gbnvj@mercury.elektranox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hNlqjw351EVDd4gT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:11:56PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jul 25, 2023 at 06:52:54PM +0300, Eugen Hristev wrote:
> > The defaults are specified in the description instead of being specified
> > in the schema.
> > Fix it by adding the default value in the `default` field.
> >=20
> > Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-=
schema")
> > Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> > ---
>=20
> Maybe also fix the allowed range while at it? I.e.
>=20
> minimum: 0x00
> maximum: 0x7F

Beat me to it! Please do.

--hNlqjw351EVDd4gT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAi6wAKCRB4tDGHoIJi
0vL5AQD8BuidIynoyj33cY6xqSwkDbogVJO15KjdNiTQNkRSVQEA74iQMUfeoN34
jQtR5vFXPxgj7VEzcVIMqN35ErvrCQI=
=ORDo
-----END PGP SIGNATURE-----

--hNlqjw351EVDd4gT--
