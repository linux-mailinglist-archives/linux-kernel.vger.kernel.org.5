Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67EE7595CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGSMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGSMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A8173B;
        Wed, 19 Jul 2023 05:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 713436090A;
        Wed, 19 Jul 2023 12:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE4AC433C7;
        Wed, 19 Jul 2023 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689770574;
        bh=HyVoxX8AEi9B94ASA5k8kd4DUFL0wTVKIY1KcFtkfDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+Kws3lxThBlltt/f12GSaRAtAPzhFg7bYb/YuJz81qIKKbGOM8s0gZ93UM2nntD5
         WTdVlTaZ9UpAoV01CmvQTGSWbkfflC6gz7szk9vgcbt2wAzyyXirymJ0HiE7ttgdUL
         YrItBCsCKRLpUeWupKKLHiWcZHkLDvhVbHTjOeGNGyu8qgdUud2B18ijrklNUgxOor
         WG8pU/E6h7bNVbGXA3cJ7bAaDoY616B26mEroXMJzLXzvnixNrRAXWezamCq4SIPa0
         A7sTZ8nQMcfWQ4aGevhi6NChrMr/u7EmXTcVJDRJbFSXBTvo4Hx9UTBVoAYtpCjXuQ
         4vZGjWCIvDUIg==
Date:   Wed, 19 Jul 2023 13:42:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-ID: <dd60d083-6ffe-4d74-8c5b-588a62303b34@sirena.org.uk>
References: <20230719071239.4736-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yplmLVqcDsA0Kwdt"
Content-Disposition: inline
In-Reply-To: <20230719071239.4736-1-duminjie@vivo.com>
X-Cookie: They just buzzed and buzzed...buzzed.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yplmLVqcDsA0Kwdt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 07:13:02AM +0000, =E6=9D=9C=E6=95=8F=E6=9D=B0 wrote:

> -		dev_err(dev, "rx dma channel not available\n");
> -		ret =3D PTR_ERR(dma->chan_rx);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
> +							"rx dma channel not available\n");

The indentation on the second line is messed up here, it's far too
indented.

--yplmLVqcDsA0Kwdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS32kkACgkQJNaLcl1U
h9AsAwf/XRlF/OUeW8KspA4enro+hJVLmo1S1OP2Q+sUoS0nCV2LL3aj++22ZNVb
gB0Jmw0xhhdm9x/mw/oI6SZ1UJnKtRg4af3SF40tzTp5RgjkVOHWq0AethK9kLvr
DN4mrd8DunsuOCSoNOXHVDsHKtVwE7LQ9aNgSpHTdK/XVz20HnRYasSYzYFI81Al
FIzP816JKvW6fDqWSA2UmDGrwSjkonQxJHw4pRW/dhrDVqCdmCmj43JvRcH1XDo5
N2URSskEi/8AfIUYsHAkXdGfptKBFa/3xM2IeQZKCT1T+TzwqlozFcSx5D7YtS+R
phO5DyksBpm4CRd+VgHt9wwsc6zo7w==
=unq7
-----END PGP SIGNATURE-----

--yplmLVqcDsA0Kwdt--
