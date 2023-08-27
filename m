Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC5789DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjH0M02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjH0MZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2410F;
        Sun, 27 Aug 2023 05:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5937261451;
        Sun, 27 Aug 2023 12:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03124C433C8;
        Sun, 27 Aug 2023 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693139154;
        bh=jvTptT0rkJ9XzewXN+Ilc6vx+jgmt3KNLGijCVtCL5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvnT0kXiTyaIeD95H55YeT7Yv3yzR/hf7mOgX0yqLMkuFSMiL6LJgCzJX5Wf5RZMH
         OIYBXU+BYC0Khqeaun68JFwqpiFHvy6OXesHy9T7GlJ4dedbmmfYNLXkx1dxJxlTP1
         1lL4FTP6KUp9ew6Bsko7LXVDBNIbVBxiRevxguaLNkppPTKwWfg8PUT9LHCvyUfH0+
         TYiJxUqHGCbe32Dd4ofKN2k1Dx30DCiOx9YmU3w9s0VvlsHfsPSHvrIQLLUCkG2u2M
         tIUJ91CX71VC0SU1L3CbZl8ibelQ0ZJKt17JOBwu6047taxjbZ5z5uUItlqVAH+1at
         YOtybIUwFGYbQ==
Date:   Sun, 27 Aug 2023 13:25:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add PMU event node
Message-ID: <20230827-frighten-casket-561437347911@spud>
References: <IA1PR20MB49531D5F6612A5FFED734754BBE1A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9O421g421KqLv44b"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49531D5F6612A5FFED734754BBE1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9O421g421KqLv44b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 27, 2023 at 02:45:01PM +0800, Inochi Amaoto wrote:
> D1 has several pmu events supported by opensbi.
> These events can be used by perf for profiling.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
> ---
> changed from v2:
> 1. move pmu node from /soc to / to avoid warnings when cheching.
>=20
> The meaning of T-HEAD events can be found in this pending patch:
> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C2177=
7BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com
>=20
> The patch above also provides a example that shows how to setup
> environment and use perf with T-HEAD events.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--9O421g421KqLv44b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOtAzAAKCRB4tDGHoIJi
0j5BAP91rXPhdIdPwVcemV7Mclmbtusox4Z+awvYVVbHlFkLQgD+OfL9j8jiRM53
NprniGrPxfyWibOeShToODprEvZfAAM=
=0gzT
-----END PGP SIGNATURE-----

--9O421g421KqLv44b--
