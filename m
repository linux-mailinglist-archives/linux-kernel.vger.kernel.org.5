Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7480237C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjLCLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCLvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6747CB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:51:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5714C433CD;
        Sun,  3 Dec 2023 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701604298;
        bh=j+MWyvG7dYrNIh8G6k9NK5UM+dH6jsdU5B4UsxoT+ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZBv5tVLF2NI8QfgBY/8Ji3ma0UtpBOAg4ZA0uEFcL8QLOHa6Vj3kH2Wz0SpY2P+Q
         JY/emv7qYlZbHwn0xIDwBObeEF1jos2kj8dM3or2URoeh+07CQD2lya7bZrzIDu72W
         HQUoQtCDK1g1880UKXKabHh6v2u1dS68efrHT3s2OWuEe8eL67uAiGpg/2YrbsZG7c
         1bHbDSrY0Xu/IA36Y1MMH7mVCpfSxR/a410cHV+fsK08eWTvbReMdXuYJBw5TyOE8A
         B7+m+/hpKcq+tCtWTTboUkLg6stP7KBkMOLz5yBqz1kVbI4VwuavmOphozufGN1gmd
         61v8Xby1WsQkQ==
Date:   Sun, 3 Dec 2023 11:51:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Message-ID: <20231203-parabola-deploy-105940119261@spud>
References: <20231201-strung-mandarin-110a322468c9@wendy>
 <IA1PR20MB49539E82E5C0B5CBFD889F39BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231201-nutshell-uptake-48161193c6e7@spud>
 <MA0P287MB033290A6C8B15202E31E43CCFE80A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FS9zK2k9fGsYJ11f"
Content-Disposition: inline
In-Reply-To: <MA0P287MB033290A6C8B15202E31E43CCFE80A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FS9zK2k9fGsYJ11f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 09:11:38AM +0800, Chen Wang wrote:
> As far as I know, sophgo's SoC product names all start with "sg", while
> products starting with "cv" come from CVITEK (another chip company). CVIT=
EK
> was acquired by sophgo a year ago, so now many SOC product names that
> originally started with "cv" are being repackaged and changed to start wi=
th
> "sg".
>=20
> For the cv1800b adopted by Duo, Sophgo has made it clear that it will not
> change its codename.
>=20
> But I heard that for other products, such as the cv1812h used by Huashanp=
i,
> sophgo may change their names in the future, but sophgo has not officially
> confirmed it yet. Looks like sophgo themselves are still in the process of
> digesting cv's products, ;)
>=20
> Since we have just started to support cv1812h and have not done much work
> yet, I suggest not to merge this patch into the mainline, and wait until
> there is clear news before doing this to avoid introducing unnecessary
> modifications later.

If there are people who have the boards, I'd be inclined to make the
mainline kernel usable for them. Doing some renames or adding
compatibles down the road, if the SoC is actually rebranded, is not a big
deal. I'll leave it up to you guys as to what to do - it's only -rc4
today, so there's no impending doom.

Cheers,
Conor.

--FS9zK2k9fGsYJ11f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxrxAAKCRB4tDGHoIJi
0t0zAP49o75PXGwjkXR55YAqI5SOHIrBtYKQz46TH7DfrJMqaQD/UUMH5SNrat4p
8sFmOMNmT3Ueh4ph6xACjsgSGLQQRQI=
=irXv
-----END PGP SIGNATURE-----

--FS9zK2k9fGsYJ11f--
