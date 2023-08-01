Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D776AAAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjHAIQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHAIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE32A0;
        Tue,  1 Aug 2023 01:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0304E61499;
        Tue,  1 Aug 2023 08:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47780C433C7;
        Tue,  1 Aug 2023 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690877801;
        bh=tigY7no064OHWqJe2mg96ovVkpSGcVq9HrOv1kXCDMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldF6mftrTEL5dXshnZ4HpWKR04fTfx3onp4pX/Hc9Q0wgHqUOAIZZBKQ38BdhS5uP
         zjNr2Zu9yU+u+1B/5c/zGdX0Xu5re2fSsA6iiHPnE8BMfHcKtAu/jDdJRGZgVz/ffz
         by8WGX3bX5OEd+yLoixEjp3LIqOf6D7gCf1yiqtwANitszOMwiQkagxPaMsEXcgGMq
         tptw/Ej3gbMaGy/c60shm8dDDdTrjV8itD+5yv+BzBtLTBE++Tx+riDPuRlf+Ra5lT
         JeaAeYlGLfrTAh11ok5a7pWHo4/KQZhSA2TALDSSomuPGipZcyuPO1RVVBKDTjZF1m
         YFHt09FthS2Tg==
Date:   Tue, 1 Aug 2023 09:16:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Message-ID: <20230801-unlighted-tree-440d6e8eb71f@spud>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728-cornball-preacher-a7e4644fcbef@wendy>
 <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com>
 <20230728-unedited-thank-366462ab471d@wendy>
 <CAAhV-H7jVp2fX5Rosd8YSj_6oFdmsu5iHsBmYH_8iX2qan7r+w@mail.gmail.com>
 <58500dc7-af1b-4edb-bb2b-93be454ec151@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kqt3zn6oDBmFrkPv"
Content-Disposition: inline
In-Reply-To: <58500dc7-af1b-4edb-bb2b-93be454ec151@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kqt3zn6oDBmFrkPv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 09:28:11PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 31, 2023, at 16:13, Huacai Chen wrote:
> > On Fri, Jul 28, 2023 at 6:18=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
>=20
> >>
> >> Perhaps that someone is you, or maybe it is Yinbo, up to you guys to
> >> decide :)
> > I'm a "merge hater" and "rebase lover", so I think it is better that
> > Arnd picks up these patches to the soc tree directly. But if
> > necessary, I can also create a "soc-loongson-next" branch in my tree
> > and then send PR to Arnd.
>=20
> Separate patches are fine for a short series, it doesn't have
> to be a pull request, but do make sure to send it to
> soc@kernel.org after review is complete so I'll be sure to
> take care of it in patchwork, I otherwise skip a lot of
> patches as I expect them to be picked up into a platform
> specific tree first.
>=20
> Also, if this ends up being a genpd driver, then patches
> after 6.6-rc1 need to go through Ulf's tree instead, not
> the soc tree.

Just to get the ball rolling, I've made the maintainers entry for you
Huacai :) Perhaps you can pick up the two patches I mentioned earlier in
the thread, as both appear to be fixes?

Thanks,
Conor.

-- >8 --
=46rom 4423897634c0e54274df90a0a933e05f8f78074f Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 1 Aug 2023 09:08:21 +0100
Subject: [PATCH] MAINTAINERS: add loongson soc driver entry

As a result of there being no entry covering Loongson SoC drivers, some
fixes have fallen through the cracks. Add Huacai Chen as a supporter of
drivers, who will forward patches to the SoC maintainers.

Link: https://lore.kernel.org/all/58500dc7-af1b-4edb-bb2b-93be454ec151@app.=
fastmail.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..0225bf871bab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12250,6 +12250,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
 F:	drivers/i2c/busses/i2c-ls2x.c
=20
+LOONGSON SOC DRIVERS
+M:	Huacai Chen <chenhuacai@kernel.org>
+L:	loongarch@lists.linux.dev
+S:	Supported
+F:	drivers/soc/loongson/
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
--=20
2.39.2



--Kqt3zn6oDBmFrkPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMi/YwAKCRB4tDGHoIJi
0vp4AQDJgsZboWpRMuLKrDENlCYC7UyrNxuo40T4G6pkSuVuGQEArjcNmkZ7xWLg
6+rRsWqMeaalakCF/MmV1L+ZdqaoLgE=
=MTqu
-----END PGP SIGNATURE-----

--Kqt3zn6oDBmFrkPv--
