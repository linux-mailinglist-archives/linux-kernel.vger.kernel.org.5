Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C27EB894
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjKNVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjKNVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:25:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8DC9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:25:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D90C433C8;
        Tue, 14 Nov 2023 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699997145;
        bh=YP5kQ+OLq20lWVTIEgwGNCp7TX3MfqMKAJQPKo0uv4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiJLQGDmNl0LmFgP52njoysTZoYMcrSPUM5+6omnQS79QJ5hJZ6F/NultCjouljb0
         DKqWxaQCSwNRynmUSCZISxGLqXVHDowtsGnf7mlJzLqr7aiwzYAxmaCT6fHqVpx07y
         mPMuDdMD6UMg9my1wuQ/A2Rll0mOBkWhW7PqlCCnc6O+g+KwKKlf9MPrh7CbPDZ+Ut
         nzD+LkJtXG67eBIku9zd88hyWWItlqufWwKgmnTpVFKW4aoPhC54S0/YLSGaDob5a/
         gFKYezUBwWk7ZE/IqnsI30k09b2X+9dLQRX0dLQVw0CSjLAHySNcFSys5/qmtlhD7M
         OWpvyHYh8x6bw==
Date:   Tue, 14 Nov 2023 21:25:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
Message-ID: <20231114-unsterile-waffle-dca2696aa551@squawk>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-7-3273c661a571@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ca5HlNeiXV0eml1X"
Content-Disposition: inline
In-Reply-To: <20231114-th1520-mmc-v6-7-3273c661a571@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ca5HlNeiXV0eml1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2023 at 04:08:01PM -0500, Drew Fustini wrote:
> +&mmc0 {
> +	bus-width = <8>;
> +	max-frequency = <198000000>;

> +&mmc1 {
> +	max-frequency = <198000000>;
> +	bus-width = <4>;

Same nit applies here.

--Ca5HlNeiXV0eml1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVPl0gAKCRB4tDGHoIJi
0uODAQDCOj3IIM9ip5YRSOjAlTX71NZyKmVbuSDoS4Ga2+P0KQD8DAsV1YJ7XtAZ
xJ55DxwLnJ2876cNTRc/6SQBHbzl2wE=
=53XV
-----END PGP SIGNATURE-----

--Ca5HlNeiXV0eml1X--
