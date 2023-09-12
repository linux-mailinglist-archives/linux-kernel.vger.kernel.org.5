Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B994479D5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjILQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjILQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:03:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C410DE;
        Tue, 12 Sep 2023 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694534590; x=1695139390; i=frank-w@public-files.de;
 bh=ZcIB9zC7fG/dvzv/cz8/piVRYYiQk+7tlRIDWuaJjdM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a18aexxgAqlUtYXYhVG9fHOyfQE4IlVW0nZLbMUI0EEKV/Kx47QKN59+/L2Ia+c5Vd3Ea6Z2f8P
 V6WGVG5SNXb5DfpPaESFEJ3lvH6kO1+07uWyLYjmS/bfe/AcHBL/pFRoliGWNNwCAh8WUcz9KYYmu
 dvNT7clXcR9a+bP1gN5IIO+yYBqURUa0he4MkK5BL/HtWn6a4NrBpZk/wh5Et+km2qt+qhMOxsTgM
 C5m4tPzq1LJoRSrDROphuAS1HM/yqOq7ENzLwfDw5EyzdltwZM4z3rO+rLRwV8+/lQAVGFv71VxaO
 eQwsOnuDEYGTM6JSkkGaDOUujTdvGMmoGJfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.158.105] ([217.61.158.105]) by web-mail.gmx.net
 (3c-app-gmx-bap40.server.lan [172.19.172.110]) (via HTTP); Tue, 12 Sep 2023
 18:03:10 +0200
MIME-Version: 1.0
Message-ID: <trinity-9ab9660a-eddd-442e-8b49-4c642ead30f4-1694534590075@3c-app-gmx-bap40>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Aw: Re: [PATCH v1] arm64: dts: mt7986: add overlay for SATA power
 socket on BPI-R3
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 18:03:10 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com>
References: <20230901072730.13571-1-linux@fw-web.de>
 <CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com>
 <76060BF0-B432-4BB8-A5C8-39EFF3D628EA@public-files.de>
 <CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:GlgV1h1gakT+ne0leX1fKEt0rxfgqIykAja95ryczX69KYtimBCde9rTrpF/iuZZOljFI
 STtdrENzy8rGrsT+U0I0YIoIhbYU6D3C0l7A8rqMtsprdL6fJRmMqOfoeWpqxyLcuybRfG4gdRjU
 DAt8e2Wc9uegsdBNwTBp8yky9K8g/dYbu8wbV2EmNUmStbmnBaPbj+9hGVPhZYRfUJQR14Gl6Kzx
 DcWzJ4LtVTgaJRhUhFy65bCJQBPsW8Ld52JFh2FXeIRHvBLa35OiteKhnzWZTvdbDBao4zTyLwI9
 5I=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qwnF7KTygH8=;Yj6WNNJxsfO+48Wq1Y9AdccLohr
 4ZfUqBL/pWF9TwWP2+VU0tzDhBVi/YjtZUGL1H8nfMyyBRGE+6Q+2FgxCxTWa7x8fx3NilNa4
 1XCTMqKc9OpKtXq+9UXksw9COHzAyCEuvlq8vDsAnUSIc7bgTDVyLy5ENLORQ//Nv/I/d9baS
 KFs2BZrV0oLx7sn7zyWQE3V4CgzocMkYcNExHHXTaLqBhNvigETic83JJvCAvnqR4X4MvzsUK
 rfWbu1COjFrbkavWv8gQ+ryAbYnwTX8N62dEOp2Rwi4dCjs4z1bUeTnIyZp0cAMY51umtxbft
 c/7GJJjX6PZXWCPV7FgBRcXSMTb5xLiOZbgW0i5cw8QmROuzk0DLoWWGiZJzM7F7bENV92AkY
 jOGIzsHVfX64NwIpcBRVjweYk9VJHGzi7JH5NKNWa2om7KkSR0j1Jbkr1QAVF7d/N+hcR+Von
 G2VPCwLQaSa4dhV836NpeTLhVnhBfNsFGpLsqY0XdTSJhyOsh+UQ6H1upy9jrAe4FdSihxtH3
 sS2ieXA/LJYT6GeXvrQTQMPUml7ocS1Nw/q5jp/jVluYtCZ1sqI7rEIlbdxCwxt0YE+FyyaKS
 o6YZrT9YCOeOIboD5F+CNZKZeJM/1UJgrLvnosKbHO3fbzFPS6rQ6dFw9RbA8hV9jf4wvEhMC
 TqqaNG4gHU6IBDIIB5q7o4iq2i1Qe7fyVEHg8nJqvKVUjr8znwNzVpoHucqLTZn1xh9WDQTja
 VhCP/VySe2yZO6dHr2JvA99c1kvtKDNNkb5ycFwLisN7bzDH7jxpB1omwbtbxHArZVz96o81+
 4p2C2YhQrNWUg+89I4uYm+T2ZWhxMlgfSKkjyUKpgB0gc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 11=2E September 2023 um 23:06 Uhr
> Von: "Rob Herring" <robh+dt@kernel=2Eorg>
> An: frank-w@public-files=2Ede
> Cc: "Frank Wunderlich" <linux@fw-web=2Ede>, linux-mediatek@lists=2Einfra=
dead=2Eorg, "Matthias Brugger" <matthias=2Ebgg@gmail=2Ecom>, "AngeloGioacch=
ino Del Regno" <angelogioacchino=2Edelregno@collabora=2Ecom>, "Krzysztof Ko=
zlowski" <krzysztof=2Ekozlowski+dt@linaro=2Eorg>, "Conor Dooley" <conor+dt@=
kernel=2Eorg>, linux-kernel@vger=2Ekernel=2Eorg, linux-arm-kernel@lists=2Ei=
nfradead=2Eorg, devicetree@vger=2Ekernel=2Eorg
> Betreff: Re: [PATCH v1] arm64: dts: mt7986: add overlay for SATA power s=
ocket on BPI-R3
>
> On Mon, Sep 11, 2023 at 3:11=E2=80=AFPM Frank Wunderlich
> <frank-w@public-files=2Ede> wrote:
> >
> > Am 11=2E September 2023 21:51:42 MESZ schrieb Rob Herring <robh+dt@ker=
nel=2Eorg>:
> > >On Fri, Sep 1, 2023 at 2:27=E2=80=AFAM Frank Wunderlich <linux@fw-web=
=2Ede> wrote:
> > >>
> > >> From: Frank Wunderlich <frank-w@public-files=2Ede>
> > >>
> > >> Bananapi R3 has a Power socket entended for using external SATA dri=
ves=2E
> > >> This Socket is off by default but can be switched with gpio 8=2E
> > >>
> > >> Add an overlay to activate it=2E
> > >>
> > >> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
> > >> ---
> > >>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> > >>  =2E=2E=2E/mt7986a-bananapi-bpi-r3-sata=2Edtso         | 39 +++++++=
++++++++++++
> > >>  2 files changed, 40 insertions(+)
> > >>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-b=
pi-r3-sata=2Edtso
> > >>
> > >> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boo=
t/dts/mediatek/Makefile
> > >> index c99c3372a4b5=2E=2E822d3e36d3df 100644
> > >> --- a/arch/arm64/boot/dts/mediatek/Makefile
> > >> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > >> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi=
-bpi-r3-emmc=2Edtbo
> > >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand=2Edt=
bo
> > >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor=2Edtb=
o
> > >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd=2Edtbo
> > >> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sata=2Edt=
bo
> > >
> > >The requirement for overlays is they have a target base dt in tree an=
d
> > >that you apply the overlay to it=2E All these existing overlays have =
the
> > >same problem which I pointed out when you submitted them=2E Please fi=
x
> > >the existing ones before adding more=2E
> > >
> > >
> > >Rob
> >
> > Hi Rob,
> >
> > i do not understand the problem as there is a target base dt=2E=2E=2Em=
t7986a-bananapi-bpi-r3=2Edtb=2E
> >
> > Do you mean that overlays should be merged with basedt at compiletime?
>=20
> Yes, because we want to know an overlay can actually apply to what's ups=
tream=2E

so you want this only as compile-time-check or to provide dtbs for users i=
n all possible combinations?

for compiletime-check i would add only these 4 lines:

mt7986a-bananapi-bpi-r3-sd-nand-dtbs :=3D mt7986a-bananapi-bpi-r3=2Edtb mt=
7986a-bananapi-bpi-r3-sd=2Edtbo mt7986a-bananapi-bpi-r3-nand=2Edtbo
dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nand=2Edtb
mt7986a-bananapi-bpi-r3-emmc-nor-dtbs :=3D mt7986a-bananapi-bpi-r3=2Edtb m=
t7986a-bananapi-bpi-r3-emmc=2Edtbo mt7986a-bananapi-bpi-r3-nor=2Edtbo
dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nor=2Edtb

for all possible situations we need 8 lines as i wrote in the thread you'v=
e linked (sd-nand, sd-nor, emmc-nand, emmc-nor)
and this will double the lines in makefile with each additional overlay (e=
=2Eg=2E the sata one here resulting in 16 lines total)=2E

if the basic syntax is ok (maybe naming the dtbs differently?) and i know =
compiletest vs=2E all possibilities i can send patch
for correcting this=2E

> > We pack the base-dt and all overlays into one fit image and let uboot =
dynamically select the combination to apply=2E E=2Eg=2E check if emmc is av=
ailable, if yes apply emmc overlay else the sd one,same for nand/nor=2E
>=20
> That's irrelevant=2E
>=20
> Though do you really want to wait until that point to find out you
> made some mistake in your overlay that it doesn't apply when you could
> find out much sooner?
>=20
> > Else i do not know *how* to fix as i don't see it as broken=2E
>=20
> You need what I pointed out last time[1]=2E
>=20
> Rob
>=20
> [1] https://lore=2Ekernel=2Eorg/all/CAL_JsqK_3xxD0DFwipXO85P=3Dq=3DEYjUd=
jE1_8g1MKtvw3vVzx5A@mail=2Egmail=2Ecom/
>
