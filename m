Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E88377A5D3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjHMJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726EDE7B;
        Sun, 13 Aug 2023 02:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D709C61952;
        Sun, 13 Aug 2023 09:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466B9C433C7;
        Sun, 13 Aug 2023 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691919935;
        bh=IvMvUg438awBsWmrvnlmQyrc2p9kbydwMSmLPr71LH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJuLxl1MCjxFSShXgYIj1sHOTmT1RIl6wxl9mwadKHXGJnX+Ym7sfsifvxm5+ogQX
         UFTsc8FtEpSOelHMxljzkPsZaGrula8JHIv1JR95a5UmR4hBjYvqHubHsWE9jhAhIV
         yROUaDgFL9eR9Na0JEZT2fmrJx6qVeQnEnWVg7pox2HnClwY5KkMm+NEfToEC1Ym+K
         M/jagQW+Sm4iF9QNVQ7WiAIuwKEvtTgW/bKg0pXflkFxKZqYxB/0A7vc20RlMHvKMb
         XbILVbVDKZUP5aTVzxHDonum1TxZlhq6nUKzeNe6Bit6XZK3oxFYQ7MBGFpT8Hz7uy
         n4qpr3ZffXZYQ==
Date:   Sun, 13 Aug 2023 10:45:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] clk: marvell: Move number of clocks to driver
 source
Message-ID: <20230813-accuracy-constrict-fe6fe41c8b4e@spud>
References: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n0gFG7/B+FgEa/54"
Content-Disposition: inline
In-Reply-To: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n0gFG7/B+FgEa/54
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2023 at 12:02:55PM +0200, Duje Mihanovi=C4=87 wrote:
> Hi,
>=20
> In v4 of my PXA1908 series, Conor suggested that the NR_CLKS variables
> in dt bindings should be moved to the respective driver source files
> because these are not used by the device trees and so are needlessly
> added to the ABI. This series does that for the rest of the Marvell
> PXA/MMP SoCs.
>=20
> Link: https://lore.kernel.org/r/20230808-produce-thievish-3ce1b86a114b@sp=
ud/
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
conor.

> ---
> Changes in v2:
> - Fix clk-audio.c compile error
> - Reword mmp2 commit to match other commits
> - Link to v1: https://lore.kernel.org/r/20230809-mmp-nr-clks-v1-0-5f3cdbb=
b89b8@skole.hr
>=20
> ---
> Duje Mihanovi=C4=87 (4):
>       clk: mmp2: Move number of clocks to driver source
>       clk: pxa168: Move number of clocks to driver source
>       clk: pxa1928: Move number of clocks to driver source
>       clk: pxa910: Move number of clocks to driver source
>=20
>  drivers/clk/mmp/clk-audio.c                    | 6 ++++--
>  drivers/clk/mmp/clk-of-mmp2.c                  | 4 +++-
>  drivers/clk/mmp/clk-of-pxa168.c                | 4 +++-
>  drivers/clk/mmp/clk-of-pxa1928.c               | 7 +++++--
>  drivers/clk/mmp/clk-of-pxa910.c                | 4 +++-
>  include/dt-bindings/clock/marvell,mmp2-audio.h | 1 -
>  include/dt-bindings/clock/marvell,mmp2.h       | 1 -
>  include/dt-bindings/clock/marvell,pxa168.h     | 1 -
>  include/dt-bindings/clock/marvell,pxa1928.h    | 3 ---
>  include/dt-bindings/clock/marvell,pxa910.h     | 1 -
>  10 files changed, 18 insertions(+), 14 deletions(-)
> ---
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> change-id: 20230809-mmp-nr-clks-7c80e416e6bf
>=20
> Best regards,
> --=20
> Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
>=20
>=20

--n0gFG7/B+FgEa/54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNimIQAKCRB4tDGHoIJi
0gkjAQCHftyXsSmqXlJWH4Eg+IdAGbOVoF7KD+NAtBWvwRPqJgD+IiddYy1yVtgY
YJf/wgJ7Ul0/tGdAyl8nh4q5C/3xiwY=
=EmmT
-----END PGP SIGNATURE-----

--n0gFG7/B+FgEa/54--
