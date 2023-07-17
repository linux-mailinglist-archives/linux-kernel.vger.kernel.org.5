Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28085756C54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGQSnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGQSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0399;
        Mon, 17 Jul 2023 11:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA958611F3;
        Mon, 17 Jul 2023 18:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED3AC433C8;
        Mon, 17 Jul 2023 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689619375;
        bh=uRn0kuwqYbZ6OTzDmQhgfhwn6ZJ4biCov+g6zanF68o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXAy43LVtPnYp13ZnDTjnJe+cGwkxaFpFhYZfZRC2nzKYXPl2KAUtW77E3KuUAdPk
         QLdoUAgBC0qmWrmGxommYRxaHSd/GK6He//vefvCCcDmepdyZekx85POQUFSjkzMUs
         uJsQC6kqynGoQVIOFRr5I3tT1XRg+1WYMWrYaaeAWsvlNcLx0qA60JYzorKTKje/BL
         4sqHcy+7VuZsbKOaA/e91vpg8K5ZtGx1FX5tPMF7WAYQcZ2i8zozVvmBc0Fx9ZiFbb
         Wv/IRAJv7/rUAIlPMHycR2h0xW+eU5ohAu/qDgC+0D2P3TKM4nP7jtAhQRstEBfZiC
         Zf706cKt9FqSA==
Date:   Mon, 17 Jul 2023 19:42:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dylan Hung <dylan_hung@aspeedtech.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Message-ID: <20230717-euphemism-tiptoeing-87fdeff2f5f1@spud>
References: <20230717065858.1596404-1-dylan_hung@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BMW1/yk8++vhoImP"
Content-Disposition: inline
In-Reply-To: <20230717065858.1596404-1-dylan_hung@aspeedtech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BMW1/yk8++vhoImP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 02:58:58PM +0800, Dylan Hung wrote:
> Add reset definitions of AST2600 I3C and MAC controllers.
>=20
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

What changed compared to v1?
Are there any users of the additional resets (eg, in a dts somewhere)?

Thanks,
Conor.

>=20
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindi=
ngs/clock/ast2600-clock.h
> index e149eee61588..712782177c90 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -90,7 +90,19 @@
>  /* Only list resets here that are not part of a clock gate + reset pair =
*/
>  #define ASPEED_RESET_ADC		55
>  #define ASPEED_RESET_JTAG_MASTER2	54
> +
> +#define ASPEED_RESET_MAC4		53
> +#define ASPEED_RESET_MAC3		52
> +
> +#define ASPEED_RESET_I3C5		45
> +#define ASPEED_RESET_I3C4		44
> +#define ASPEED_RESET_I3C3		43
> +#define ASPEED_RESET_I3C2		42
> +#define ASPEED_RESET_I3C1		41
> +#define ASPEED_RESET_I3C0		40
> +#define ASPEED_RESET_I3C		39
>  #define ASPEED_RESET_I3C_DMA		39
> +
>  #define ASPEED_RESET_PWM		37
>  #define ASPEED_RESET_PECI		36
>  #define ASPEED_RESET_MII		35
> --=20
> 2.25.1
>=20

--BMW1/yk8++vhoImP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLWLqgAKCRB4tDGHoIJi
0i8OAQDraTQRKI7Em5D9cWQAEsknsQRxXbG5WEe8SkR6AqcEBwEA93XaSc4+ifkv
Hobytq9jZUJ+VFOmUeGzeLKR/Obasw4=
=6O+C
-----END PGP SIGNATURE-----

--BMW1/yk8++vhoImP--
