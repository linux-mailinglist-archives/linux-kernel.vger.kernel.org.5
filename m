Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6D759542
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGSMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGSMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D8E0;
        Wed, 19 Jul 2023 05:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8207060B5E;
        Wed, 19 Jul 2023 12:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99007C433C8;
        Wed, 19 Jul 2023 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689770291;
        bh=gvZa221y3UmB7cz/txdTcrjUjmH7am2Q6n4mOrqLDRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKcYFz3vZYv6BrMmp5ReO7LOAJFlSsoc0yjf719zcrkzJCTYdsEh5THW6g7JPuXvH
         9oQsXw1KLW+6OZ7f9IefuL5KkxiqSedPYOz18yJb6L7LYvlvD/9iFoLJSVABZVoWUY
         MVKjKxdfPS+jMz7sAinL40qm76Kob9CNyKs+oxAw6SduM1NEXxmzCYkTkvVpGIZdLu
         HzEB5XKtqwqn0jJl89nhpDnsZa7ta87JaM1EJYUUdLEROB2JMppSms9B4HjOei3C9S
         CKgWtdjtgRoEp55w1OkLn8lGcXibfXL4tqiAwzXHQm4JmzFtjpqJ6YYgeOswLiFGQi
         PN2Srf2L1XEcw==
Date:   Wed, 19 Jul 2023 13:38:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] spi: Use dev_err_probe instead of dev_err
Message-ID: <a7f2c3b2-2caa-4e96-b7ec-02f8566797c6@sirena.org.uk>
References: <20230719053649.4632-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I/YfuZGE6VAmfNI1"
Content-Disposition: inline
In-Reply-To: <20230719053649.4632-1-machel@vivo.com>
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


--I/YfuZGE6VAmfNI1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 05:37:02AM +0000, =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=
=BB=B6=E5=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:

> +		ret =3D dev_err_probe(dev, PTR_ERR(ctlr->dma_tx),
> +							"no tx-dma configuration found - not using dma mode\n");

The indentation on the second line here is badly messed up, it's
indented far too much.  Same for the rx channel.

--I/YfuZGE6VAmfNI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS32S0ACgkQJNaLcl1U
h9CQrQf+MxLygsZm5IlNLDBkcrnKVXcq4xQZez4UK3eV+O8uw1hxUexw9fMFSxwY
Pb2kmmuuyQdSOkGVaUoHzKpjHMkS6WsnnvJzVeluzUZUxPRF5rudPhFzwSJz/IpX
cpRXeVfku+W3LhODKSkZMeFZu6xBxVxdFa/QIMh9SILLahbUtT0ELwK99KAoq57w
oWp3gCPW/OTuhT7b8e5tcsm5D8jKoFnDblvk1Y0RuPD7u5Z077LZt6ZgPE4/Maee
/gQjjWA5/3pStelNVfGkH/Hn8pCmvZrruAUBPlt5CXotqTvyu5dpIRgQjhDBK2It
qU2I3ohxLQIDn4ulB8xOa8hkRJzj4A==
=9g0p
-----END PGP SIGNATURE-----

--I/YfuZGE6VAmfNI1--
