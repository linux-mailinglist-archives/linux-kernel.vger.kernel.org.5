Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20267915D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350859AbjIDKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIDKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:47:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E77ACA;
        Mon,  4 Sep 2023 03:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 756DCCE0E27;
        Mon,  4 Sep 2023 10:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C477C433C7;
        Mon,  4 Sep 2023 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693824452;
        bh=99ke3kNeYjTAZdMP/LVioYQzIJUaAhAvjKPEJvsnYY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/obh9f7+KqDlFRDD20tK+jtjDGWKkpk8SIdPPe9ilucb9enhLkWUCkJeJfqAE/ER
         wx4USLCM3pJ78k5WxiztrhYACOFcL2DI/jX4XpYuldU5GJPBYSRcWejNtyJguu/po7
         BHq4upzGpYgSvw5QeHG3douofpfj35qQK2iNgejVXD1tRGMmzwGtbo8YcvA/mTC3CK
         LOdi4eazbAyA40LXGRANmQ0hRCA26ZLQcn+K0PF87BvjzIN50clcy5+dAjY45FGxsc
         bYVM7Z+Knj3A3brhWNO8qZafUMUc0UrcfBzVoDek//jTypnEo6lgOHpsg040lNzPzN
         qspXiIitAnq0A==
Date:   Mon, 4 Sep 2023 12:47:27 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC
 config option dependant on ARCH_RENESAS
Message-ID: <ZPW1v0yFscV+aKxF@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dj06BT165bXeKWNl"
Content-Disposition: inline
In-Reply-To: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dj06BT165bXeKWNl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 01:27:01PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> MMC_SDHI_INTERNAL_DMAC config option has dependency on ARM64 and
> R7S9210/R8A77470 this dependency will keep growing for future SoCs for
> varying architectures. So to simplify this configuration make
> MMC_SDHI_INTERNAL_DMAC solely depend on ARCH_RENESAS, as all Renesas
> SoCs inherently depend on the ARCH_RENESAS config option.
>=20
> This allows selecting MMC_SDHI_INTERNAL_DMAC config option for RZ/Five SoC
> which is based on RISC-V architecture.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I like this a lot!

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--dj06BT165bXeKWNl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmT1tbsACgkQFA3kzBSg
KbboLBAAlxR3NduDSCV1FbQqRS6dLQx7qXohCCXArcpHtzJb2/7cf9oE1eAL3kpv
dYPYfjMDTEBkVUqEJu1GR043TileiivKR4tURvCYLFCQ9DzFvHkHLmys33H01ZBx
amgm9J5ymHipUWX3ZVxGx7RiUfj23+gkz0Zw1ocoiZOdPO5v9us1P4JIqdMoocNz
yR4llziiL+wbbuRJn5rDajFwN/6Fijr9vjEzHrxMx8hbee2RsSCIswKfTUOGMGVI
1kOtAGVbsvpSLobI6gz6cwk6dew9wDKk+aoaZjeK9UNXkvo9FtJqa1fwVI7yG1+Y
/kmDIat42cPfyiiK624ffJxFyAR/BG9fihs3zz1caQrNiz8kqKM+V4lCnEVQ4cA5
PtL3quJq/tNo0V1LQYWic5GT0a7yFI4DdoDWNd7/dY9ikZAT5igEbJuUuB2rnCuI
ojf7tiDgei0Zmsy8LynpABUEr46XrTj7VcdT3lfoGl8NhDBJopUF+yCURL7KUmLc
q65mJ3ffzS+lCY+3Ok9mq9ujeupr+eXBrmoRVunycqulYkt2I72D12fuxerSD3n7
74FdJAmPm+bY0a+kQ83VN5Mv2hzEVGapAuWUXAzlSRsUBpduZKdw1uRrx8WCGjlE
7cywP+1BpTcdNTsU2r3GMO9RZhks2AiYjSNmDVrpVlrjGF/HCuI=
=1KUH
-----END PGP SIGNATURE-----

--dj06BT165bXeKWNl--
