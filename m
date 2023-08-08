Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13824773C96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjHHQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHHQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6A7298;
        Tue,  8 Aug 2023 08:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4F862418;
        Tue,  8 Aug 2023 07:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95548C433C8;
        Tue,  8 Aug 2023 07:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691479702;
        bh=RdAScwYlQbKFjCynaCzGyIqpOLXi5HTfM61jXRC5qNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCaX5vfTNteeYwn0mRM/82W4iAZTVE0CK0WPc2s4D0/jQVxYDhjAXdCc9hlJ/Q1K/
         tTw9BwQ8fdS9SXQFjmL17IjhfNatxVIZ4STGwRiV6PZ6ccDfkMmFBaMewlLaBnJUeb
         QH/WiBN6a779Q6E2Dtsuao3G9JkMGPoIeojf9TPHx6qOjwcP/76JvCR79In2hbGAw1
         pltGnW0Mz2Y7Y8g41j1d/F2xrh5OKceWpuu2++vp0Wun9d0NA3f2IQ3pDptmCBACLT
         jMevdDnVSNqzO+RsmsQF2JNxrV9UyagzP6cDzvfUjwZI4n2IacakOdnIpCKLUfNy1I
         nDA7flO6HOVlA==
Date:   Tue, 8 Aug 2023 08:28:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: snps,dwmac: add
 safety irq support
Message-ID: <20230808-guidance-propose-407154f8bff4@spud>
References: <20230807164151.1130-1-jszhang@kernel.org>
 <20230807164151.1130-8-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CcVArbuGnTOxANs0"
Content-Disposition: inline
In-Reply-To: <20230807164151.1130-8-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CcVArbuGnTOxANs0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 12:41:48AM +0800, Jisheng Zhang wrote:
> The snps dwmac IP support safety features, and those Safety Feature
> Correctible Error and Uncorrectible Error irqs may be separate irqs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..5d81042f5634 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -107,6 +107,8 @@ properties:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt to manage the remote wake-up packet d=
etection
>        - description: The interrupt that occurs when Rx exits the LPI sta=
te
> +      - description: The interrupt that occurs when Safety Feature Corre=
ctible Errors happen
> +      - description: The interrupt that occurs when Safety Feature Uncor=
rectible Errors happen
> =20
>    interrupt-names:
>      minItems: 1
> @@ -114,6 +116,8 @@ properties:
>        - const: macirq
>        - enum: [eth_wake_irq, eth_lpi]
>        - const: eth_lpi
> +      - const: sfty_ce
> +      - const: sfty_ue

Did I not already ack this?

--CcVArbuGnTOxANs0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHukQAKCRB4tDGHoIJi
0q8sAQDdMaiGwRgtoaOMOSoYM8rEhQWRBaqsZ9Sqog8hWbs5CAEAyV2Y7L7++Dz6
xHP/9iGKo8Kh8UMNTMtcAUByYyRAXA0=
=0Pro
-----END PGP SIGNATURE-----

--CcVArbuGnTOxANs0--
