Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0F7EA24A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjKMRpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKMRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:45:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7A10EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:45:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56039C433C8;
        Mon, 13 Nov 2023 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699897519;
        bh=CgcFT+veTcKjCyHdvfNFlsBA0HiNgZz8r9E8ALux3BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDSIQ9C8h4TMewndaNKrIC4pIPQktF9e83HNgStjSpPfKs0uBTXF6XNdXUvf5ZfGX
         1yJYxSWRvwZxvSQIbyMv1HrbAG2SYBCU2AUcf08BgviU1l+ix8sHMzMu7SLVAJiN8C
         /CRX9bzk/RHQXO7GNP/gKb+bYjqZ+WXxi4Ov1EY2BtKxfRtwV9MQGT3NwyGDTUDnV+
         IEy0IiUVv178RZHLpZzx/dlQ8zo5fZJM3wPAOMG1O2+Xdy04rK+1crXhUnbiB57kHu
         p9nG8KnqkqmeQP2fP04l/ZG+xir07sUTjwgJbkpLnGf/ahOLRA0AIeBuCvlxIc6RN5
         s8reCReUpVWTg==
Date:   Mon, 13 Nov 2023 12:45:16 -0500
From:   Wolfram Sang <wsa@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: ocores: Move system PM hooks to the NOIRQ phase
Message-ID: <ZVJgrJuCSImHpxY0@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231113023249.1185682-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bDPSe1q/v1JFXA1f"
Content-Disposition: inline
In-Reply-To: <20231113023249.1185682-1-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bDPSe1q/v1JFXA1f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 06:32:45PM -0800, Samuel Holland wrote:
> When an I2C device contains a wake IRQ subordinate to a regmap-irq chip,
> the regmap-irq code must be able to perform I2C transactions during
> suspend_device_irqs() and resume_device_irqs(). Therefore, the bus must
> be suspended/resumed during the NOIRQ phase.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Applied to for-current, thanks!


--bDPSe1q/v1JFXA1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVSYKgACgkQFA3kzBSg
KbYBdRAAow/OUtEPBVFW487SQNrOBs84oOBnrMBPN5YxBoP/ub7dkYu4PCAmJaaz
19jdPmT7JrUdi5f9e0wT9xsopxrJqJj7zrtV+x89Rd2N/7/sOM5kULyOTl6XdEQJ
FSAaImkNkaFYBcslpJ1LoPjQSHahnrzb6MKI+Au82TnN3dwfVwoVuMEpbFfjXtaZ
h8CbOa7VbD1woF9CZBlKbLMRoU0dWr0tRFoyQJJyrdagvTYoTEB2Y62l96X6BeBj
hgCvEaBOuvQoA/dDr4TySYY8Kz1DSLPy5nGF0rnuJZAd91eOHf6pRifU5BUd2sF4
ri8QBzyISLbCzy1C3iO3+Aph8k+3YRe2LRRbotAwI0qN1ehZeJuq56EB0NhOjyQH
Yj5C1/J0mnETm0u6RfPv7ZNGv7L9ynQ4ztqR0NaHoWJGWr6hvbGoT1IvAy4vJlFm
9hpafAI/g1M4KnolhVhsm+mB9rHWcP1AQEZRBZxIC0LnIBSdr1kf9Lj8fSRVB75F
WV3SpptHPwblEvSx8JvcunivPPA6lB5HSXKxyrkuIrAWQxbp8qVtL94ZewYyWSrR
NWVGg4bOyKL2sF4P9AkR8u2Jzvoe43/7k/Mr4000zO01ccQ2hd+EqMV/MyQpPHIz
sAJCx2DtCHz69dzGwHZZo/fnlnBgVT4Bg/43YUjb3mv+LONyiKU=
=T9a0
-----END PGP SIGNATURE-----

--bDPSe1q/v1JFXA1f--
