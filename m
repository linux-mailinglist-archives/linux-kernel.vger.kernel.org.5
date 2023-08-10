Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E7777C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjHJPji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjHJPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6326B9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2F866078
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE9C433C7;
        Thu, 10 Aug 2023 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681975;
        bh=+RqZA0cX8VIY0s3e11+0Z9i6zfMLI9V7lSoagiXzHiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HjxbKhdZqC5p2SHPbNZsipblSdM/awSjA5WKv4TzP1/gOuM327LgmV4K1MyB2FGm1
         VwnxudQD81C4kPg9N1ZwuUQWnjnwhQM3uTknXSUuk3Y+YvY97Gec4bb2j+GM+mkSMc
         N6n5rtiqcoF9F5nfCF85qQBT34ip9ySg1Yt2YUYJyUQATX6G89y1//KgxR+Yx1WI+y
         LcV0w6CfzfiHlGjioxkW3EOAZtHbKmUIEqidUNu01UYNdEAsebCtWfYnKo/XAqNYAo
         LDHGTKGwc/Hi9mwU9r4gTl0h4SGzWcMoZMEeVarCKWcwqAz76GbNZD+nb5MH5dqpv1
         CiKiOa2yuI1aQ==
Date:   Thu, 10 Aug 2023 16:39:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <20230810-avid-perplexed-0c25013617c9@spud>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230810150328.19704-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MuZ3wrqm02dw4gEw"
Content-Disposition: inline
In-Reply-To: <20230810150328.19704-2-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MuZ3wrqm02dw4gEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:03:27PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for few initial tx queues, starting
> from tx queue 0.
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..ad26a32e0557 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -313,6 +313,9 @@ properties:
>        snps,tx-queues-to-use:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: number of TX queues to be used in the driver
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues support TX checksum offloading

Either you omitted a "ing" or a whole word from this description.

>        snps,tx-sched-wrr:
>          type: boolean
>          description: Weighted Round Robin
> --=20
> 2.26.2
>=20

--MuZ3wrqm02dw4gEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUEsQAKCRB4tDGHoIJi
0iOmAQDn/yAcD1JLuhTNKcQin6nvPE+5IS9OqAUHFX4TkbFa9gEAgTyktV5zdQHm
uELPRWXyRAJCvDqDi2+ETRiC7hBXRAg=
=3asX
-----END PGP SIGNATURE-----

--MuZ3wrqm02dw4gEw--
