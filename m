Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017D7F47C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjKVN0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbjKVN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:26:48 -0500
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E95A199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:26:44 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Sb28H56lPzMqNwN;
        Wed, 22 Nov 2023 13:26:39 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Sb28G5pTvz3j;
        Wed, 22 Nov 2023 14:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1700659599;
        bh=RdclPK7WlZdCt5CH1ffkzqGywkNSvU8Jbe2q8RmZWsQ=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=GW+6FvuwtrE67Riej5vbirkqfw8SL4rqFsfK065W6CleBgfEGWeLa8jDbqx9vQHto
         RfWtHTnG5UrTLx9Fg8DHJqSq93dGSyq2XbKaaS2QO8tBzNNJJpw2LC5hlCovnbG8Pz
         yJt2MjbqSQyFfSn9vPROCoqjO/Rh9CPhLg4MQbz8=
Message-ID: <dcf860a796c228920a79b62417f7cf6c@mail.infomaniak.com>
Date:   Wed, 22 Nov 2023 14:26:38 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Francesco Dolcini <francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6Ikozdzh4MnlWY3pzS0ltN1lMemRsd1E9PSIsInZhbHVlIjoiWnQyZ2hUNnpVeGd1V01pZ3R3TElrZz09IiwibWFjIjoiZmQ0ODBiNzg4NTY0OTJhZjFlNjUxODI4M2VmMDE5Y2VjOTQ5YjIwNjg2MGZkNmY0NTZkODY4Y2NhMzA3ZDk3MCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6InJVWGRMdkpxc3dNZ05DdXVobFpMRWc9PSIsInZhbHVlIjoiaHpRaGhUdlp4L2FJWFBVelNYTndIZz09IiwibWFjIjoiYjRhY2FiMzdkNmQwMjJmYzBmZDM5MjQ3NDA5MDc1MjIzNWMxNjk3OTViNDJkOTgyOTI1NmYzZjk5ZDVjYTNjNiIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.598)
References: <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
 <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
 <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>
 <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
 <44e61a3385f84aa417a208ca348e4b8c@mail.infomaniak.com>
In-Reply-To: <44e61a3385f84aa417a208ca348e4b8c@mail.infomaniak.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20

i did now  my test with the latest imx-sdma  firmware 4.6 from NXP
https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.18.bin
There is no improvement.
What is the HW that you use? What type of imx8?

Regards Stefan Bigler

Am 2023-11-21T11:34:26.000+01:00 hat  <linux@bigler.io> geschrieben:
>  Hi
>=20
> At least in my test-case the  commit is NOT introducing this regression, =
because the bits_per_word is 8, so the result is the same
> spi: imx: Take in account bits per word instead of assuming 8-bits
> 5f66db08cbd3ca471c66bacb0282902c79db9274
>=20
> I do not have the latest  mx-sdma firmware can you tell me where I get it=
. On=20
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/tree/imx/sdma
> the latest I found was 4.5
>=20
> I tried to debug the code but it's hard vor me to understand where the pr=
oblem could be.
> I saw then I disable the dma with set
>=20
> imx51_ecspi_devtype_data {
> .has_dmamode =3D false,
> }
> the SPI is working fine.
>=20
> Should I do some more tests, do some loggings..=20
> Please let me know
>=20
> Regards=20
> Stefan Bigler
