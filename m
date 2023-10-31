Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF297DCD57
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbjJaMxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjJaMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:53:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93D9B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B7DC433C7;
        Tue, 31 Oct 2023 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698756802;
        bh=0t3IKrPFgiqf2EohJYkK9JIarq/qoo7KRj3/Wzm+8r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFqNwfKF3IvXgzpRWY/GGCo1g7N5HTZ4LVSlnYhInGA7stwDSsM3V24XNeD3lTe72
         1n7XO1hmSbOVc3ejmJvKDmJM5Amf8faDt7HqqKfEmTE7w5sTBcvc8cS2OF1dL/qZWO
         4Y3sOpFac/CYli0FSwf75gpvtnHPV5FxxNhNTN+YbPGQy1u6/WIUcaywa9QFSW2s1n
         chE0YogbYmI8ocDJ6acvZIqXVjxQhnYam3gRfTmirZic7F6B6gzTzeUW9IZe8e9BCm
         Ziv8cwwvn7kYWH8E86eed8Rg+LW7ZVlzGT6SNO5wevpp1sLqR1tGv292WGHnmBIScl
         TmWXUykuYiDKA==
Date:   Tue, 31 Oct 2023 12:53:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] regulator: bcm590xx: Add proper handling for
 PMMODE registers
Message-ID: <63356933-3da7-4068-ad77-0f0e8d8915be@sirena.org.uk>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
 <20231030-bcm59054-v2-6-5fa4011aa5ba@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JwakjBWjo5Y6WgSv"
Content-Disposition: inline
In-Reply-To: <20231030-bcm59054-v2-6-5fa4011aa5ba@gmail.com>
X-Cookie: Is it clean in other dimensions?
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JwakjBWjo5Y6WgSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2023 at 08:41:48PM +0100, Artur Weber wrote:

> +	for (i = 0; i < pmctrl_count; i++) {
> +		ret = regmap_write(regmap, pmctrl_addr + i, mode_mask);
> +		if (ret)
> +			return ret;
> +	}

Why not a bulk write?  What happens when the new values are partially
written, both if there's an error and just transiently?

--JwakjBWjo5Y6WgSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVA+LkACgkQJNaLcl1U
h9Cn4Af/avvAKVxZeTeXLPlGXQMqtb8I4zu45eiTGPiemTnzPESQOjREO+R8XzqM
jw6zhgziB7wn+dWLfhlZ+rgKu2NPzOiclg8qtHn9iG2IMTWdvxxqD5T1BAWR07yJ
gSEKdMu3eMa1G+3BHCVVh50OtZcIw00ZjsJmtMQddwv9PJH39gy59vHnRPlju8VR
Fi1HECtOyj0YY6sH+qH0QlsJjWwGO2uCDRKHUNke9HKMn+qCKWsZ5INdY3+c61yC
ybW8Z0EGWsVewY53n5XNnGEJoAUSoMjyBlHO62/4vd8j/Tsy8ZsCxq/01JCkofL1
MDTD84p/0r379datrbXKRu6c1RCKjg==
=ph1+
-----END PGP SIGNATURE-----

--JwakjBWjo5Y6WgSv--
