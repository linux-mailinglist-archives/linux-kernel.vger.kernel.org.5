Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37F075B53F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGTRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGTRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA77AA;
        Thu, 20 Jul 2023 10:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8786F61B8E;
        Thu, 20 Jul 2023 17:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1115C433C7;
        Thu, 20 Jul 2023 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873056;
        bh=+axwopYxss32R/v91aEDYuikl4wHxlkypTqI8kD6aso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCqSFh7cyVmHDASsdStKBK/jH7esg7iLSu6bLcPd91ldXFqCSEsYMXMx0aC9kwDWp
         sITE99JryYqoKSZYx++BRhsOwJ5wezc4UPhubd1g+sil3QUmCfCPlJH/yuA38WHeQ2
         lczEfsclUrTRRGS7+IKJyza/pVPRM3yC7SKnSR5soJ1T5Sq0PpmVrq7mhrHIBErTAI
         asmw06YlY9p1uAAH17JIKZnsJ+iNgqilbvYbWAgfpt42Bfe3fHCl4JBZ1w2BI+CaUW
         WfhGAhm6/iUJPCrOM+O1wZQTv9cNTtvG+WBEGhK5HgYpFgnumgNq3rFWp/NuR+quqD
         vNL2WCOxpDkUQ==
Date:   Thu, 20 Jul 2023 18:10:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        peterz@infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Nick Hu <nick.hu@sifive.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230720-slept-guru-216e2803061e@spud>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DXW+N7LgbdadIzwt"
Content-Disposition: inline
In-Reply-To: <20230720135125.21240-2-eric.lin@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXW+N7LgbdadIzwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Eric,

On Thu, Jul 20, 2023 at 09:51:19PM +0800, Eric Lin wrote:
> This add YAML DT binding documentation for SiFive Private L2
> cache controller
>=20
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> ---
>  .../bindings/cache/sifive,pl2cache.yaml       | 62 +++++++++++++++++++

btw, your $subject should be "dt-bindings: cache: ...." rather than
"riscv: sifive".

>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2cac=
he.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml=
 b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> new file mode 100644
> index 000000000000..ee8356c5eeee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2023 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Private L2 Cache Controller
> +
> +maintainers:
> +  - Greentime Hu  <greentime.hu@sifive.com>
> +  - Eric Lin  <eric.lin@sifive.com>

There's extra spaces in these lines for some reason.

> +
> +description:
> +  The SiFive Private L2 Cache Controller is per core and
> +  communicates with both the upstream L1 caches and
> +  downstream L3 cache or memory, enabling a high-performance
> +  cache subsystem.
> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +

I'm pretty sure that I pointed out last time around that you need to add
something like in the ccache driver:

select:
  properties:
    compatible:
      contains:
        enum:
          - sifive,ccache0
          - sifive,fu540-c000-ccache
          - sifive,fu740-c000-ccache

otherwise this binding will be used for anything containing "cache" in
the dt-binding.
For this binding, I think that the following is sufficient:

select:
  properties:
    compatible:
      contains:
          const: sifive,pl2cache1

> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,pl2cache1
> +      - const: cache

You omitted the pl2cache0 from here, that needs to come back! You'll end
up with 2 items entries.
Either way, I can't take this binding without a soc-specific compatible,
per sifive-blocks-ip-versioning.txt..

Thanks,
Conor.

--DXW+N7LgbdadIzwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlqmwAKCRB4tDGHoIJi
0tcuAP92m51JnHz7NPdeF4+NU14NEqDIZzYAshCe+QYlXCRcRQD+NRNK1FrLyftL
6Ff62D6y4p7pPTuYG+5nJ0phZ28ntwA=
=QjrL
-----END PGP SIGNATURE-----

--DXW+N7LgbdadIzwt--
