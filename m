Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF9757F05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjGROHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjGROHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82C1720;
        Tue, 18 Jul 2023 07:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F9C7615D4;
        Tue, 18 Jul 2023 14:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844BAC433C8;
        Tue, 18 Jul 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689689250;
        bh=zdvmDJMdEm8WfkZrLoyzdPxOO3h3hbh7c/bASlq5Y0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ECdEFnsdpYuqfFYfyDj13RVp1fS9AiFX+NJ+aKviNzYKxgZsfaJ/f8uYzbNsswrFi
         qfIMWA+zocXwtruNYUrPCMRMIyOu2qCufekSXXC5AcpRsIu7XiNHQ6RsKi7ZOxYByi
         fAt7la3qt5ZuBWI85cNZTzpSFW47N4BrxhB+7L1J+a2EoDY6Kj7UVFv30jf+yO6Tb+
         YPHgqoyzw9IvdjCf1tWcuf6KFvUtXiJ4gLABRsNmH5VEx66jJBZ/EkWARD3umnPezs
         YHRKPF0mbxAm6kCm9H8nYKu/APzu2cVnlD2e5157RtfBZF2fphFiNzeGYfpAPwfk8J
         z3j+L/YfECIJA==
Date:   Tue, 18 Jul 2023 15:07:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: constrain minItems of clocks
 and clock-names
Message-ID: <c53a6193-0417-4e01-9226-9c0557a497d6@sirena.org.uk>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-3-william.qiu@starfivetech.com>
 <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
 <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
 <20230713145724.GA3975811-robh@kernel.org>
 <df9de3d8-09da-2b80-b2b4-626cd92fe971@starfivetech.com>
 <9891a7e3-0fce-4d05-8ead-3c0ed155d725@sirena.org.uk>
 <6c53310c-1dc0-6623-369b-1a73fc8f63a5@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fiXkAa88DxIXZCAv"
Content-Disposition: inline
In-Reply-To: <6c53310c-1dc0-6623-369b-1a73fc8f63a5@starfivetech.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fiXkAa88DxIXZCAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 02:06:01PM +0800, William Qiu wrote:
> On 2023/7/14 19:52, Mark Brown wrote:
> > On Fri, Jul 14, 2023 at 03:14:59PM +0800, William Qiu wrote:

> >> After communicating with colleagues in SoC FE, I learned that PCLK and
> >> SSPCLK were homologous on JH7110. He said that SSPCLK would divide the
> >> frequency internally anyway, and there was no need for external part frequency,
> >> so he directly gave them together.

> >> So, should I call this clock ssp_apb or keep it SSPCLK?

> > I'd expect this to be handled in the DTS for the SoC - connect both
> > clocks the binding requires to whatever the upstream clock is, it's not
> > clear to me that any binding change is required.

> You mean binding two clocks, with the same clock source? Then there is no
> need to modify YAML.

Yes, exactly.

--fiXkAa88DxIXZCAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2nJwACgkQJNaLcl1U
h9CWiAf/bC0fx/Sgnty2fRf6b2sm8C4OURlZf4h7LOlPJeWfWc6+jOhKAfeYMInw
oA/ZlTHv1V5S/rfmU9JoCFJIGwrX/wAXQ9s6jvpqMNtzDoHQi14kny4rUg6GDfjM
CTf19IbvX1ff+Q2DfvoHmtZNt/wn3oLbfIDujesSqVhvKSR5qrsVRbiraZmmgXOK
vb2Jt0rFL30Sy8ICP0PomsbMFkVLvPOx808QsBOWSzd/Jvow/EHNv1HbE+GOXRSL
FhlcXHO9OrJs3YPKRGnS8FfblaO1zTNCdS9pKZXJRidvjEhlFyDUOEDtbR0D3jJ9
APJkPHVoQfR/eAstxEx64ohiOnY5yQ==
=RmWn
-----END PGP SIGNATURE-----

--fiXkAa88DxIXZCAv--
