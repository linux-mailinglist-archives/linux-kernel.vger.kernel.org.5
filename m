Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF217752145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjGMM2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjGMM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5119B;
        Thu, 13 Jul 2023 05:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85B66610E7;
        Thu, 13 Jul 2023 12:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4401C433C7;
        Thu, 13 Jul 2023 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689251305;
        bh=8f8B420S2iez6Nmhlz8hkDDgDQ2+6nOB0mFrfGPMq6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GX1xK+lkiknPcbIVSTtjKp7sNrQf8Bk5hqaCJYa3bnt+geSrHWjFnoHsrBUKh6ZbC
         /TK94u7I3SMgGYHawfX9CIMUscmzybc4kBak3nkM102nS9BIQ/o2ey/gBZtnXF1LoY
         JjlbHjAJZpPuaFOwzopcXiZ7Pf9KLbm8KveUMJlwxbc8p3NdgKu+sIfo6to+qhRBnX
         UBALvHEtr7eAjNnFUhufEZZsinz2y0SQGaxD+GAts1UQwW5YlI+zdF49VQ5qeR1NMe
         wNpAzDb/2wkq2gu37qQbiEnzyF3B9u1OSRVN+SUhqFRLfbp1sMaNOiPbVxD5GzuIP3
         PNcRlVksAXw1A==
Date:   Thu, 13 Jul 2023 13:28:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: constrain minItems of clocks
 and clock-names
Message-ID: <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NdTpCj8USvWVeToK"
Content-Disposition: inline
In-Reply-To: <20230713090015.127541-3-william.qiu@starfivetech.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NdTpCj8USvWVeToK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 05:00:14PM +0800, William Qiu wrote:

> The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
> so there add minItems whose value is equal to 1. Other platforms do not
> have this constraint.

Presumably this means that this is some variant of the usual pl022 IP,
or that the clock is in fact present but is not modelled in your DT?

--NdTpCj8USvWVeToK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSv7eMACgkQJNaLcl1U
h9A7eAf/USoycBJ8F/DS9P8f6DPSfiP5R4ajKsnjatuVuVfv7CtwU6QvKsBs+HXu
sAfE7Ig2/LZNZJcmQohmMe5Iu3lcHZLQpbjhLVD25aDsWojcsz2KCg8/wXKoi8xG
jdpYPYlfeS8nwDOKyyOCUti0aTx8wWRB42AFcnv4FQ0E/wTYjI23wyreGcjZDbwb
+2i4KkIBIAfJmes1pBxZ9VTUgbj/1NFeeotZCK1kfMog5dffc5bNCwna2ZmwlVUd
Zn3M2C7p2SlSytkklg4UBSaKF/hLj9FxVSwMEj3zNW3ueQ0go69khO3NdsFRPGV+
81J//IT4oLSxCrgbu0t5913MDarLIQ==
=fvSe
-----END PGP SIGNATURE-----

--NdTpCj8USvWVeToK--
