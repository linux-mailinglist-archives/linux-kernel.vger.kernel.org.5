Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2327D35FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjJWMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjJWMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:00:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC4E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1698062394; x=1698667194; i=frank-w@public-files.de;
        bh=9tf9yUBAw1RrYP73ChYZVdHhJmA6Uy3gxpVQOLcaZ80=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=THpH/2K9KFPneL6+xiW6xf9JIji6PBQppXE2mjcOzmKWHKKdj8jo2JJ4dYif+Kdn
         zekdAxuGBQXb9yD2Fx13dd8IgwBg0oR21gFXwAvfsw63vsrTYIad4GyV/zTallkb5
         a3T4rq+XLurFfOa6vnRb3lYKCHjN6XM+1BWMfIfA7mWG4doQ5CIKFkUfhMbtWV/Vr
         vjqO84ZTvkICYxHVNzOzZDyl7lPgBFcIl7HfFcD8boyiGw+h3VvoCQQ6A6PWwQos5
         LFTrR/xPpPhGNOXgEDBNRn8s/HQ1+FBZTC6hgHbK0n3zVRQQbyCU6ub1rzd+s4cdy
         8ViD/cAfcSYTh0h4zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.145] ([217.61.159.145]) by web-mail.gmx.net
 (3c-app-gmx-bs46.server.lan [172.19.170.98]) (via HTTP); Mon, 23 Oct 2023
 13:59:54 +0200
MIME-Version: 1.0
Message-ID: <trinity-13c822b5-7d6f-4bd0-863f-8f98b1a8689b-1698062394687@3c-app-gmx-bs46>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Aw: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays
 for bpi-r3
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 23 Oct 2023 13:59:54 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36>
References: <20230916083214.7059-1-linux@fw-web.de>
 <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:r6ExRbF/JLdsWjPuur+DS42SPW2DYgSKWa/uSg0Ctu0Zev6L4avEPsFE6dVKH/AAERKHK
 ksgUYC3Kcl7PWsXMh9BD7Wr6ReiGEYpq6cTJjFR39aSMqConRzMFaC3BxbBA+S+5BD5TJYQGgMzV
 jtbHo7K8t+L3jOjHe14cVGrREGwGNqi8kfUiGe7XxOuSvyGY+buDXMhvJL2i/W5EnoZ1xCiEpqJj
 OILUC9C3RwuNaVxdPbqwfVOwwdAUoW9Y0VwtNs3TfWsp2r2KjuW1VRJnSTzRNpMdqmKgIgYlO267
 TU=
UI-OutboundReport: notjunk:1;M01:P0:ruT04VEN+rI=;nSyYT8Jpxuz3ABbhVTC2LENumO2
 eUzqGw+7TxpcXB6SrEAQPajsKXryfht3dqM3NUIsg5xgPEfdiKN9cCAIswMVZiy3loq6U0keM
 J3l9jJ++6wLuWsKPcsG1/XgQZHoys/Jk9bAziYkVgaT0gK/REWrpNrOPnw1VCKH4QqfoFXDzt
 NU2sT/OoV7EEdhtCsdLvkjSZrehgPzgrRbOB6usAS/ossWFOa01krjpQgOj9W/hUlHiRwRf1m
 kJ9gkenfLn/HSNYUJub0hZgwNONYSGDN2HzxCud8BdsgSnZqoailG+Rkm9n6e3UkV8rbMcrl5
 FYYgDvAarKy8M44C+P86qeI9Z5nzLJdkA3NCG6NnPrc+y8xO5PstW9yP7SuhzVsSicXPVr7RY
 pr38LoV8Sk0oZ1NPnRp9KNF5e3C/G6JbH+LMXu+FqQ3mDLOxp8TwE1k+Y4nu32bbTobf6cd6Y
 Lr3GqPekdxDapaMx6sPbimn6rmn9tP9sFhixZUK2N4PcL3yHcwWMmgJlS7TBDYy+wNxR2OzzB
 dm8Xzm54JeEcS8cNl85Zlb+rA+c+/j0yBvWsDzLWYGnSXxfvp4nIQETzkakh/6Hj6iS6SZTFP
 3eIeiv1QURsydCTdT4xFcThVYQlPmhLzhSHixiG1Iiq4F+aOsFdG4UB8FwdFqr35JlbRqDUDx
 79Jxe4IJQskRX9jaKxRN2PYUJWHDNX95vhW7UEMnmWp2DOuNgPf5TLNu4MTLDE7s1s82In/xr
 SldNtomuNhheJp3CewyXqgZBLOiiCEpjDkphJ3ZTSwslyWFhOwhVlc9Iz3PnhOf2m00qoA8nM
 hZDXRJH4z5xfY+6Kblzx+S3g==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob/Krzysztof

can you please give an Ack or tell me if something is wrong?

regards Frank


> Gesendet: Samstag, 30. September 2023 um 14:57 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
> An: "Rob Herring" <robh+dt@kernel.org>
> Cc: linux-mediatek@lists.infradead.org, "Matthias Brugger" <matthias.bgg=
@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delregno@colla=
bora.com>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Con=
or Dooley" <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-=
kernel@lists.infradead.org, "Frank Wunderlich" <linux@fw-web.de>
> Betreff: Aw: [RFC v1] arm64: dts: mediatek: add dtbs with applied overla=
ys for bpi-r3
>
> Hi,
>
> just a friendly reminder...is this the right way to go?
>
> regards Frank
>
>
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
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nor.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-rfb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986b-rfb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8167-pumpkin.dtb
> > --
> > 2.34.1
> >
> >
