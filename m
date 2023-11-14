Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602477EB58B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjKNRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:31:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17991123
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:31:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA62C433C8;
        Tue, 14 Nov 2023 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699983066;
        bh=jkdZ5mB8QhSCTtNuc3Z7qON1sLEsZWx5t6SxsjDMGrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/nqQqQETcc6iJBWzf7IQ80EGqqzYiyeoUkgDRfthRxuXU/cN0o8EA4tLfr/gCvu0
         cxnOX3lXlWEaTok3f1T3B9mAFu0NV8pmCAxpqmX879b/Z/z69cOxJYFO9pSUFs/l80
         c7CXKBucLPv8JA/x+y4unWR/JWxJADBLx0OmvyuC7sh4riivdIulLOkC4qvoePnA0i
         yUO5/HgZxbAKEstTwaIPQ9UkcZbVWzRnABpFz8mTMZkmTzrHMKNOFn6ZQCFbqce+AW
         OayixMJOiZRrapUAeARwyohnaCxTNgoLzBsh/+k+2RRJta8q2DjtEbpKCqtnPUE4iT
         9Iul1XOM/goDg==
Date:   Tue, 14 Nov 2023 17:31:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Message-ID: <20231114-grumble-capably-d8f7a8eb6a8d@squawk>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <25fcbab4c04bcbbdc4577dc58822540829f91dc9.1699879741.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BObCPPDlTCtpWM3f"
Content-Disposition: inline
In-Reply-To: <25fcbab4c04bcbbdc4577dc58822540829f91dc9.1699879741.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BObCPPDlTCtpWM3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:20:11PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add clock generator node to device tree for SG2042, and enable clock for
> uart0.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi | 76 ++++++++++++++++++++

There's no need to create an entirely new file for this.

>  arch/riscv/boot/dts/sophgo/sg2042.dtsi       | 10 +++
>  2 files changed, 86 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi b/arch/riscv/bo=
ot/dts/sophgo/sg2042-clock.dtsi
> new file mode 100644
> index 000000000000..66d2723fab35
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +/ {
> +	cgi: oscillator {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <25000000>;
> +		clock-output-names =3D "cgi";
> +		#clock-cells =3D <0>;
> +	};

What actually is this oscillator?
Is it provided by another clock controller on the SoC, or is it provided
by an oscillator on the board?

> +
> +	clkgen: clock-controller {
> +		compatible =3D "sophgo,sg2042-clkgen";
> +		#clock-cells =3D <1>;
> +		system-ctrl =3D <&sys_ctrl>;

Why is this node not a child of the system controller?

Cheers,
Conor.

--BObCPPDlTCtpWM3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVOu0wAKCRB4tDGHoIJi
0uT6AQD3FJYKLUrrVpL4tzEV3YskeSlnVP66eWfgWIZ+3O5aagD/b5dttSrtKFIt
S80P7AKBwUKY+5II2CtmlSZ4eep63Q0=
=4vEb
-----END PGP SIGNATURE-----

--BObCPPDlTCtpWM3f--
