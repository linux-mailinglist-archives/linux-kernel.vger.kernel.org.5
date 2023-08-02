Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B289B76DB07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHBWyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjHBWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:54:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C61127;
        Wed,  2 Aug 2023 15:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408AF61B76;
        Wed,  2 Aug 2023 22:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579A0C433C7;
        Wed,  2 Aug 2023 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691016843;
        bh=YiU0aA6053zZBxMpkzJTUPwbuvPZtBeKnaf2p7gJrCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yu5QJm5y8zR+pdtBL5JD45JWGYCMTAwCcZDs7Lxa2dB+oLx8+HOEyqkGXNVrtxqbq
         gM+Jh4P+J/c188mzyOBe85KvyQrq/Ya05rvkkRKVsurPSjzhB1Mt5BglDmGCmujESD
         01AhZS5AYxCwTVf/aqRcz8+JwCPxDsTw3s5rJ341pd4oFMyKg+uwWX2/yYqav6e2Nc
         I/KUWCfPHRNoOPB1adF9l4mgdJUPXTRyH0UWSVqW/6P8LN99rTc2+Do5G2STJl4ZYk
         IsnjxdbWUw14ur8OMgPoP9NAv1NWpyyMlORuJBjahGLJO8sImwM8E12kanDseDloZx
         2bDEyhpFMUROw==
Date:   Wed, 2 Aug 2023 23:53:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: make
 interrupt optional
Message-ID: <20230802-risk-getting-e6005e86be81@spud>
References: <20230802150545.3742-1-jszhang@kernel.org>
 <20230802150545.3742-2-jszhang@kernel.org>
 <20230802-halogen-bungee-63273b2c456c@spud>
 <ZMrRWP5mK+nksn4M@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TyQVymKmfkVhVy64"
Content-Disposition: inline
In-Reply-To: <ZMrRWP5mK+nksn4M@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TyQVymKmfkVhVy64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 12:57:44AM +0300, Andy Shevchenko wrote:
> On Wed, Aug 02, 2023 at 04:43:48PM +0100, Conor Dooley wrote:
> > On Wed, Aug 02, 2023 at 11:05:44PM +0800, Jisheng Zhang wrote:
> > > The driver fall back to poll style when there's no irq. "poll" still
> > > looks better than no support.
> >=20
> > What is the user for this where the interrupt is not actually wired up
> > in the hardware?
>=20
> FYI: kernel console doesn't use interrupts, so for example it might be
> the debug port. Note, I have no idea of the Zhang's case, just my assumpt=
ion.

I'm less interested in what the software is doing, it's what the device=20
that has not connected the interrupt is that I am curious about.

--TyQVymKmfkVhVy64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMrehgAKCRB4tDGHoIJi
0pFVAQCP1wynCbszotBg7z6E5V2mul7jaRGS0Hn3LNZOBaczogD+JXolWFJnyohA
2deDAf/0fHAyq1Uzh0NT1FfEQYKGAgs=
=yvLF
-----END PGP SIGNATURE-----

--TyQVymKmfkVhVy64--
