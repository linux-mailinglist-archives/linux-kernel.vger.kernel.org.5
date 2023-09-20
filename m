Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714647A8234
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjITM6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjITM6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:58:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569AE4;
        Wed, 20 Sep 2023 05:58:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833C0C43395;
        Wed, 20 Sep 2023 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695214707;
        bh=JEcE762TPALh3A2MTMmeFILTtcz7SC6kjuHzb4W9xBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWIIorXFUwbp4n1PIUTjm8jETvlYxVQNNtidWIl9OCuFKTnimuDLKXetpPjVxyyL/
         1os2BKYSTsRnAgAxiFH4rfWxZ3gDKKRVjvVw2lhzMV4s4bdfoU05XBIEMaip91LbNr
         J7iNPzDxU6FXqQAYeun6sjlWZGXCz/WjE+vRqsj1tgBCR4xq/ZrMgsoIgXGkH+zBam
         2D/hPRhENvAtkAiyy1VCfh+8Z4BFqG1GB41T13I7UUtcsX6+r6XTYQ6jFqKSiSPTqH
         SrEJun/lBf+9ylKUR9jcfBfRfeXs1GfNMo6pG4yICwc8NtGX9jqjj1J9rcddaam51h
         ZXQLqdwP+24Tw==
Date:   Wed, 20 Sep 2023 13:58:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230920-8503c6365655d3ef3dadfd53@fedora>
References: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
 <IA1PR20MB49536BFE1254ADEE0E795A26BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwbkuouaUi9cdxhL"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49536BFE1254ADEE0E795A26BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwbkuouaUi9cdxhL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 08:40:07PM +0800, Inochi Amaoto wrote:
> >On 20/09/2023 14:15, Inochi Amaoto wrote:
> >>> On 20/09/2023 08:39, Chen Wang wrote:
> >>>> From: Inochi Amaoto <inochiama@outlook.com>
> >>>>
> >>>> Add two new compatible string formatted like `C9xx-clint-xxx` to ide=
ntify
> >>>> the timer and ipi device separately, and do not allow c900-clint as =
the
> >>>
> >>> Why?
> >>>
> >>
> >> If use the same compatible, SBI will process this twice in both ipi and
> >> timer, use different compatible will allow SBI to treat these as diffe=
rent.
> >> AFAIK, the aclint in SBI use the same concepts, which make hard to use=
 the
> >> second register range. I have explained in another response.
> >
> >What is a SBI? Linux driver? If so, why some intermediate Linux driver
> >choice should affect bindings?
> >Best regards,
> >Krzysztof
> >
>=20
> SBI (Supervisor Binary Interface) is defined by riscv, which is an interf=
ace
> between the Supervisor Execution Environment (SEE) and the supervisor. The
> detailed documentation can be found in [1].
>=20
> The implement of SBI needs fdt info of the platform, which is provided by
> kernel. So we need a dt-bindings for these devices, and these will be
> processed by SBI.
>=20
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc

Yeah, this is the unfortunate problem of half-baked bindings (IMO)
ending up in OpenSBI (which likely means they also ended up in QEMU).
This T-Head stuff is coming across our (metaphorical) desks, so we are
obviously going to try to do things correctly. I may end up speaking to
Anup later today, if I do I will point him at this thread (if he hasn't
seen it already).

--uwbkuouaUi9cdxhL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQrsaQAKCRB4tDGHoIJi
0gYFAP4j2wdTtFTv0vOJOXuZqtSvyvpNj8FZ4JrRTM69BgGsVQD+J4NLAm5BLqkT
GTQ6s+Dy7mcY2pMniUqr/VphB228SwA=
=fsWb
-----END PGP SIGNATURE-----

--uwbkuouaUi9cdxhL--
