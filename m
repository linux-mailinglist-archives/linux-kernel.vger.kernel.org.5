Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287447D6CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjJYNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjJYNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:10:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EED111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1698239426; x=1698844226; i=frank-w@public-files.de;
        bh=7jPZj6qMCgHOu6av6FIRfofY9VKc2ZV6MSDD2uvQnbs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=e2KRo06l685MDTT2IQ866oo13sQoPcQKg1FZDn+0sLUG1Ir8WbVybZpyqh6NAVc/
         qHQekuYk0vyR4lmuAW7UrzYw3v8BfTqB8W3HG3wCW8YxiYbCThlUNVTp+D+m49f6H
         GqOfMe0E6RUFLxKXSxiqu4seHtBHSddXqf3VWNeG6kFEPiBBO4lqQ287BPrsLSCoW
         TW+5Pr6bFAG5u0kJtxjCqcWaSZ1G/2PiHEP33dm/F01Hy+7RO4OnfvIW2gMo1TrHH
         p4aS5invnLjm2dlW0k69g8WJfytOfwlJ9QjDCn+keuzFz4v7UCw9eYu/03G+azAyY
         p+d92eI3QQWt+tka+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.50] ([217.61.159.50]) by web-mail.gmx.net
 (3c-app-gmx-bs29.server.lan [172.19.170.81]) (via HTTP); Wed, 25 Oct 2023
 15:10:26 +0200
MIME-Version: 1.0
Message-ID: <trinity-90f622f9-7087-46fb-bdc8-f835f6953133-1698239425846@3c-app-gmx-bs29>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Aw: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays
 for bpi-r3
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 25 Oct 2023 15:10:26 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36>
References: <20230916083214.7059-1-linux@fw-web.de>
 <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xBaV5gaQxcMH7sF3CwbQqcmcEOYpwqE2HKE6ZjVU3FZAoVImMFMjF0g6KxmeJOlU5mJOm
 WvWaESRS7SVw7/feimx5TLexZIAfMlzIiBc1YAjKxRnqw7vcoApcisc+7KS8k2vJDNSrV3TTwxSJ
 eM1ONTa84gFD0xI/zFlUWH7OA8IQ7GUmbmnnxhRd+pyuoDDVzCaw1bsGaavW2mw6r5On9MmPEVV0
 m1v4htPTZ/lZxuvLtYF3JR2TwD6HpP5bwbaPJGV3KwQjiOWgyRU4GUfz8PCUaMuaF/poIs6M6pWh
 vA=
UI-OutboundReport: notjunk:1;M01:P0:bRVUAUtmxag=;sy/FO8yvWMnVb45XOxGtb8pEu7z
 yTtrDC5R9wzMGtzA8EvwkC4cCIDzCKx9qSAesCRulHpygZqavJOSRSl42Kt3+g7KSLqqROMLS
 +E5bCOCPwjZX/4lMKaxP+AESzVroqADuPqDRobUT7fGbtexeTfp3CELUFXBX+Xp7zyhAvGFSm
 SpdLFTEcitZGzHlrwE/eHDNIb2uqtWmTRjav/e0kckQ/cqOfr2ue+crpfa0DpdNUeqZvfYVdG
 Vi0ihPzzoVfJGuXpmOMeHJaf22wYqwAlsJ0PcWd2rNdNVf0sJH0/Q7Ju7FWL+0/HFCX4OK08C
 8NrrNpDy/w2CgjTsBDcG5+gIdvrxGxPkXKn22GyvgdMqOX+dyBm1odRIRecWnOeVj9qNbWvBx
 d8KVdOmL17cUM61lloyrOYgoi5VYC9qOHFaVk6yyKIoxSgELxbhuqjwaRYiFK1NhzJesPjbOD
 X72DrJiiOMxraH6KSqyq/QpsRBuA2vbg9dOacVYyHy7QZGJNi+MMExMoYwfMmmxEK2Le18MAt
 duGFBI7XN0ylDDMSWYtP25A7j+yBpLZXuSRDzdUK+4WbrdH3JCWudAy7xbz0+ZKlOCmBxDBvN
 2reGIxXpCZEk1W9wgJmNmYpqDo+wxcspXiuPn4Uv/syeUaps/w982Pu2bUlWn8l70dNBmRMvc
 mMi8GgNYwZHN4LIIIpxh2v0LKJ6F/6TnyMBHvv+JKqnXd9tWndoifGDzZGmvDJcJ8aFsC0MPL
 P2WmA7id/lyYfRsR+QLNsfsRu+U+bEM+sa0fyCGfF4aO7WVDmT7XLBO8muAcW0tbIvy6Nq1vV
 dVYc7UAjDTOYv6plGeOQ3+2Q==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

thinked a bit again on this Patch as i try to summarize sent patches
in 1 series to make it easier for maintainer to pick up.

> > Gesendet: Samstag, 16. September 2023 um 10:32 Uhr
> > Von: "Frank Wunderlich" <linux@fw-web.de>
> > An: linux-mediatek@lists.infradead.org
> > Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Matthias Brugger" <=
matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.de=
lregno@collabora.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozl=
owski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kerne=
l.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
> > Betreff: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays=
 for bpi-r3
> >
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Build devicetree binaries for testing overlays and providing users
> > full dtb without using overlays.
> >
> > Suggested-by: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > based on discussion here:
> > https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=3Dq=3DEYjUdjE1_8g=
1MKtvw3vVzx5A@mail.gmail.com/
> > https://lore.kernel.org/all/CAL_JsqJSi=3DkJSix=3Df3787ULZnaCy_Y26Phdhy=
5y9fat_vkDuUw@mail.gmail.com/
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/d=
ts/mediatek/Makefile
> > index c99c3372a4b5..18be027bf6b4 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -13,6 +13,14 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-b=
pi-r3-emmc.dtbo
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtbo
> > +mt7986a-bananapi-bpi-r3-emmc-nand-dtbs :=3D mt7986a-bananapi-bpi-r3.d=
tb mt7986a-bananapi-bpi-r3-emmc.dtbo mt7986a-bananapi-bpi-r3-nand.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nand.dt=
b
> > +mt7986a-bananapi-bpi-r3-emmc-nor-dtbs :=3D mt7986a-bananapi-bpi-r3.dt=
b mt7986a-bananapi-bpi-r3-emmc.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nor.dtb
> > +mt7986a-bananapi-bpi-r3-sd-nand-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb=
 mt7986a-bananapi-bpi-r3-sd.dtbo mt7986a-bananapi-bpi-r3-nand.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nand.dtb
> > +mt7986a-bananapi-bpi-r3-sd-nor-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb =
mt7986a-bananapi-bpi-r3-sd.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo

maybe this is nicer?

mt7986a-bananapi-bpi-r3-emmc-nand-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb \
					  mt7986a-bananapi-bpi-r3-emmc.dtbo \
					  mt7986a-bananapi-bpi-r3-nand.dtbo
dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nand.dtb
mt7986a-bananapi-bpi-r3-emmc-nor-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb \
					 mt7986a-bananapi-bpi-r3-emmc.dtbo \
					 mt7986a-bananapi-bpi-r3-nor.dtbo
dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nor.dtb
mt7986a-bananapi-bpi-r3-sd-nand-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb \
					mt7986a-bananapi-bpi-r3-sd.dtbo \
					mt7986a-bananapi-bpi-r3-nand.dtbo
dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nand.dtb
mt7986a-bananapi-bpi-r3-sd-nor-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb \
				       mt7986a-bananapi-bpi-r3-sd.dtbo \
				       mt7986a-bananapi-bpi-r3-nor.dtbo
dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nor.dtb

here i tried to align the text on first name, but this results in visible =
stairs.
maybe only 1 tab to indent here (or anything else)? what do you think? In =
the end
better readable as 1 long line.

the SATA-Patch [1] will then add a line to each of the 4 blocks here (+5 l=
ines in total except changes by adding the backslash).

> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nor.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-rfb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986b-rfb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8167-pumpkin.dtb
> > --
> > 2.34.1
> >

regards Frank

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/202309010727=
30.13571-1-linux@fw-web.de/
