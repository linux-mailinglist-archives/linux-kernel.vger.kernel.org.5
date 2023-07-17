Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56297561BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGQLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGQLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:41:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04CC1BE;
        Mon, 17 Jul 2023 04:41:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230717114106epoutp0394faa81bafb89fbaa69b954db878644f~ypNnse1-Q0231802318epoutp03a;
        Mon, 17 Jul 2023 11:41:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230717114106epoutp0394faa81bafb89fbaa69b954db878644f~ypNnse1-Q0231802318epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689594066;
        bh=9d2CVEnFtKsWlmnw7DSta8S04nv1hR77bbdJgc7E+sY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mW1t69FFMk5F/9J89d19d/8rk0/I8ktc6qrWr0W1W9k2SfMmo+k4RNbKruuH0W4KO
         IeYcvhE3TLwNdfZkhycTxo2BCzEJL1Qxulukn9qEdjd67XiYZejbBWMTHA6KwHGkN1
         3HT9/rmgtDkGOQic6z6pI4sNH8QB46ERVZcNV7wM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230717114105epcas5p232f17f7af068900e59acb3169588739a~ypNnZqC2R3249032490epcas5p2x;
        Mon, 17 Jul 2023 11:41:05 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R4KsX02hDz4x9Px; Mon, 17 Jul
        2023 11:41:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.2B.55173.FC825B46; Mon, 17 Jul 2023 20:41:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230717114103epcas5p4c391f54c67e0d321cb3b7fc06b34c2ad~ypNlEEvrO0130501305epcas5p4A;
        Mon, 17 Jul 2023 11:41:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230717114103epsmtrp129ef557e90bfd79ce257e03a12c53348~ypNlChCqi2668426684epsmtrp1J;
        Mon, 17 Jul 2023 11:41:03 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-88-64b528cf61c6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.02.30535.EC825B46; Mon, 17 Jul 2023 20:41:03 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230717114057epsmtip1b70a8f0a4a28865be9e0c43df95b54a4~ypNflraVL0999709997epsmtip1w;
        Mon, 17 Jul 2023 11:40:57 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>,
        =?UTF-8?Q?'Marek_Beh=C3=BAn'?= <kabel@kernel.org>,
        "'Wim Van Sebroeck'" <wim@linux-watchdog.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>,
        "'Nicolas Ferre'" <nicolas.ferre@microchip.com>,
        "'Alexandre Belloni'" <alexandre.belloni@bootlin.com>,
        "'Claudiu Beznea'" <claudiu.beznea@microchip.com>,
        "'Shawn Guo'" <shawnguo@kernel.org>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        "'Pengutronix Kernel Team'" <kernel@pengutronix.de>,
        "'Fabio Estevam'" <festevam@gmail.com>,
        "'NXP Linux Team'" <linux-imx@nxp.com>,
        "'Neil Armstrong'" <neil.armstrong@linaro.org>,
        "'Kevin Hilman'" <khilman@baylibre.com>,
        "'Jerome Brunet'" <jbrunet@baylibre.com>,
        "'Martin Blumenstingl'" <martin.blumenstingl@googlemail.com>,
        "'Matthias Brugger'" <matthias.bgg@gmail.com>,
        "'AngeloGioacchino Del Regno'" 
        <angelogioacchino.delregno@collabora.com>,
        "'Srinivas Neeli'" <srinivas.neeli@amd.com>,
        "'Shubhrajyoti Datta'" <shubhrajyoti.datta@amd.com>,
        "'Michal Simek'" <michal.simek@amd.com>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Xingyu Wu'" <xingyu.wu@starfivetech.com>,
        "'Samin Guo'" <samin.guo@starfivetech.com>,
        "'Maxime Coquelin'" <mcoquelin.stm32@gmail.com>,
        "'Alexandre Torgue'" <alexandre.torgue@foss.st.com>,
        "'Chen-Yu Tsai'" <wens@csie.org>,
        "'Jernej Skrabec'" <jernej.skrabec@gmail.com>,
        "'Samuel Holland'" <samuel@sholland.org>
Cc:     <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-sunxi@lists.linux.dev>
In-Reply-To: <20230714175040.4065660-1-robh@kernel.org>
Subject: RE: [PATCH] watchdog: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 17:10:56 +0530
Message-ID: <001e01d9b8a3$9078dbc0$b16a9340$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGrqzeGs+cr2wOBWxiBR/YgqcC1ewG7rZ0wsAwSvYA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1RTZRg+3713uxNc54aaX8tszEzBwA0BPwzMkvRqdeLEKX90BHfYPYCM
        bW5DzIo0YiIGilrhJH6lGD8S2PgxcM5CUAmRhOCgghqwxlRGhRAIo8YG6X/v877Pc573fb7z
        cXCPSZLHiZWpGaVMLBWw3YjqS17LfFqXV0mE2i4/dL1vgkAHbYUkGrd+A1B1ajBqK4Ko1TRJ
        otyG6yz0e8d76GFvA44suecAGu4pwFHx17UEGj9YiaHU4zUEuvCgikR5p9yRrq+ThTIvtpAo
        7XERjtrrstmoPfkGQFmtJgyldfaz0AlTHRt1nTORqD//GoYuFzQR6IsvV6Ec+48sdOHKDRYa
        qr0FUI0+H0f/Gg0kstfoCHS2bYqNLL2H2GigciGy3S5hIVNhs2Pl+lYM9VmncJSf1YKt86ZT
        2uxseqgrhaRzSj+hDT2nAV3eW8KizUeqSLpW20PS5qPHSVpXfIhNd3ca2XRRaSmL1p/+nB7Q
        nwR099gZQFfYDBh9xC4MW7A9LjiGEUsYJZ+RRcklsbLoEMHb4ZHrIwMChSIfURBaLeDLxPFM
        iCD0nTCfDbFSR8gC/h6xNMHRChOrVIKVa4OV8gQ1w4+Rq9QhAkYhkSr8Fb4qcbwqQRbtK2PU
        a0RCoV+Ag7gzLuZUaTlL8XMl2NtoOQX2g5tlIA3M4UDKH44+THfUbhwPygigduAM5gJ/A7h/
        sJntAqMAFthHiVlJ78WamcEFACd0IzPACqA1909smsWmfKDhe41zMJ9Kngstl6qJaYBTNgym
        38xgT7PmUKthY8Ogc5V51FswP7vFqSaopVB3x+zsc6kgOKZvIl31s7DpZL9zD5xaAQvzH+Cu
        nfhw3FzIcvUXQmtjg4PPcTivgUUVsdO+kGpxg49z8tgufijUXP6L5arnwftXKklXzYPWIxqn
        FlI0LJjkudoxcPDsbGKvw59+yyamKTjlBcvqVrpcn4HpE/2YS8mFqRoPF3spTLZ1zAT3Asw8
        fHjGlIaPtHfwo8BT+9Rd2qfu0j51i/aJWR4gigGPUajio5moAIXIR8Yk/v/mUfJ4HXB+Q+8w
        Aygpt/vWA4wD6gHk4IL53H+KdRIPrkT88T5GKY9UJkgZVT0IcKSdifMWRMkd/1imjhT5Bwn9
        AwMD/YNWBYoEC7kPUr6TeFDRYjUTxzAKRjmrwzhzePuxtcT5iYjzpNJPXlX3rbR60pj14tLO
        7dd/nXcP7+67X2YaTtxr7v/A/TN8p2ZdxatbXotIWvlcz5KOrGXgzq4DGWdtWzMS75qbj/H3
        fHWXMaQ+fyKBc3sLf6LAsjczaa5nUUao/qq7ZqKdm23ctsYz0esk94+IDRuTd3e9e2w84iP1
        pxXlsgqh+xu8AfnUNf9ai1XpMX/o1uCHDW6CMTBSHhwejtknl1y9e2B3k/LA0fXLhjhb3//h
        2mZQ2hoKLw42LnJLMsaFJ+Vve7TLNKIt3rdpSLj5lRUv7dix5eq6NxfrT+u6X85s3uReLUa8
        Rbg0zfeK1/3H1PByP2vexuCSxYEltnu/SAWEKkYs8saVKvF/ock35w8FAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0ybVRjHc947OPBdmXIKClgvmcWWsU33bBmLc5K9JlOYMd5iIp19QxEo
        Tbs5t8WICIORIEwmlw6Bjg1CudkyoDAuE5mKyEiBIVFwDtoURIFkBKhbO4FmCd9+ef6X8/9w
        OFIyTYdwSdrjol6rSpEx/lTrD7IwxdD2FvWOsnECbk7foyB7vpoF92wRgtac/TBci2Go+z4L
        FX03abhzKw7+meojwVXRiODu5CUSzN+0U+DOvkpATmEbBV1zLSxUXnwErNNjNJzvGWQh979a
        EkY6yhgY+dKOoGSom4DcMQcNF7o7GBhv7GbBYfqVgB8v9VOQkbkLyj0NNHT9ZKdhof13BG3N
        JhIedNpY8LRZKagZ9jLgmjrHwMzVYJj/o46G7uqBtcm9QwRMz3pJMJUMEi/LhaxhDyMsjGex
        Qnn9GcE2eRkJ303V0YIzv4UV2o2TrOAsKGQFq/kcI0yMdTJCbX09LTRf/lyYaS5FwsTqFSRY
        5m2EkO/ZEf/Y+/771WJK0ieiPupAgr+mpGiF0eVmoE8d3ho6HfVrc5Efh/ndeKqnjclF/pyE
        v4bw8kQj4xNC8W+WAtbHQbjW62J9JhfCZV81UesCwyuwrersRmAbX7gF/5VJr5tIfpXAbaN2
        5EvkIHw3fYJed/nxe/CNvn/ROgfxsdhUNkisM8U/i61/OjfuAfxevNrcz/p4K+4vdWy8RvKR
        OO9OFnrI1aY50jcvArud1bTvHoxnb/StZbm1RftwrSWpAAUZNzUZNzUZNzUZN6UrEWVGUlFn
        SE1MNUTrdmrFk0qDKtVwQpuo/Cgt1Yo2/qFcbkOd5kVlLyI41IswR8q2BayYrWpJgFp16rSo
        T/tQfyJFNPSiUI6SBQcsz+WpJXyi6riYLIo6Uf9QJTi/kHRil87CxeTNiJr56+GHYi9eQUkD
        rVz2Uk1MjLTK/t7tw4NdsRZFwgtNDXn6qtCGpzIH36Q/aD26J93c88Z4/PXbr7UoBqLmAmdD
        uM/qgkJoNVt0IND+CpPMFL7YXvnL848mTuTvDK+QlodGOYsDpfcejEUePkk7Yj/et1jeFxG6
        WxZ1beG50r/DTr09WnEwI/JV2960ycWlt5aPZbjvk3n9ix1KrzX5jMwKR99xPmO+IDWJ737N
        Fz8dl+3Yul0p0YZpyHgd/f2hI9FjxVmjZ79tfmLJKBl1Hxy59aTnmCI8sOn0S3VfRLkej7Xn
        VMRtUbusP7vCjrxeXdkrj/BoqITxlfo6GWXQqKLlpN6g+h8RaAC+9gMAAA==
X-CMS-MailID: 20230717114103epcas5p4c391f54c67e0d321cb3b7fc06b34c2ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714175126epcas5p3167cd472115aa6032085393cc801b2d6
References: <CGME20230714175126epcas5p3167cd472115aa6032085393cc801b2d6@epcas5p3.samsung.com>
        <20230714175040.4065660-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh=40kernel.org>
> Sent: Friday, July 14, 2023 11:21 PM
> To: Marek Beh=C3=BAn=20<kabel=40kernel.org>;=20Wim=20Van=20Sebroeck=20<wi=
m=40linux-=0D=0A>=20watchdog.org>;=20Guenter=20Roeck=20<linux=40roeck-us.ne=
t>;=20Nicolas=20Ferre=0D=0A>=20<nicolas.ferre=40microchip.com>;=20Alexandre=
=20Belloni=0D=0A>=20<alexandre.belloni=40bootlin.com>;=20Claudiu=20Beznea=
=0D=0A>=20<claudiu.beznea=40microchip.com>;=20Shawn=20Guo=20<shawnguo=40ker=
nel.org>;=0D=0A>=20Sascha=20Hauer=20<s.hauer=40pengutronix.de>;=20Pengutron=
ix=20Kernel=20Team=0D=0A>=20<kernel=40pengutronix.de>;=20Fabio=20Estevam=20=
<festevam=40gmail.com>;=20NXP=20Linux=0D=0A>=20Team=20<linux-imx=40nxp.com>=
;=20Neil=20Armstrong=20<neil.armstrong=40linaro.org>;=0D=0A>=20Kevin=20Hilm=
an=20<khilman=40baylibre.com>;=20Jerome=20Brunet=0D=0A>=20<jbrunet=40baylib=
re.com>;=20Martin=20Blumenstingl=0D=0A>=20<martin.blumenstingl=40googlemail=
.com>;=20Matthias=20Brugger=0D=0A>=20<matthias.bgg=40gmail.com>;=20AngeloGi=
oacchino=20Del=20Regno=0D=0A>=20<angelogioacchino.delregno=40collabora.com>=
;=20Srinivas=20Neeli=0D=0A>=20<srinivas.neeli=40amd.com>;=20Shubhrajyoti=20=
Datta=20<shubhrajyoti.datta=40amd.com>;=0D=0A>=20Michal=20Simek=20<michal.s=
imek=40amd.com>;=20Andy=20Gross=20<agross=40kernel.org>;=0D=0A>=20Bjorn=20A=
ndersson=20<andersson=40kernel.org>;=20Konrad=20Dybcio=0D=0A>=20<konrad.dyb=
cio=40linaro.org>;=20Krzysztof=20Kozlowski=0D=0A>=20<krzysztof.kozlowski=40=
linaro.org>;=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>;=0D=0A>=20Xingyu=
=20Wu=20<xingyu.wu=40starfivetech.com>;=20Samin=20Guo=0D=0A>=20<samin.guo=
=40starfivetech.com>;=20Maxime=20Coquelin=0D=0A>=20<mcoquelin.stm32=40gmail=
.com>;=20Alexandre=20Torgue=0D=0A>=20<alexandre.torgue=40foss.st.com>;=20Ch=
en-Yu=20Tsai=20<wens=40csie.org>;=20Jernej=0D=0A>=20Skrabec=20<jernej.skrab=
ec=40gmail.com>;=20Samuel=20Holland=20<samuel=40sholland.org>=0D=0A>=20Cc:=
=20devicetree=40vger.kernel.org;=20linux-watchdog=40vger.kernel.org;=20linu=
x-=0D=0A>=20kernel=40vger.kernel.org;=20linux-arm-kernel=40lists.infradead.=
org;=20linux-=0D=0A>=20amlogic=40lists.infradead.org;=20linux-mediatek=40li=
sts.infradead.org;=20linux-arm-=0D=0A>=20msm=40vger.kernel.org;=20linux-sam=
sung-soc=40vger.kernel.org;=20linux-stm32=40st-=0D=0A>=20md-mailman.stormre=
ply.com;=20linux-sunxi=40lists.linux.dev=0D=0A>=20Subject:=20=5BPATCH=5D=20=
watchdog:=20Explicitly=20include=20correct=20DT=20includes=0D=0A>=20=0D=0A>=
=20The=20DT=20of_device.h=20and=20of_platform.h=20date=20back=20to=20the=20=
separate=0D=0A>=20of_platform_bus_type=20before=20it=20as=20merged=20into=
=20the=20regular=20platform=20bus.=0D=0A>=20As=20part=20of=20that=20merge=
=20prepping=20Arm=20DT=20support=2013=20years=20ago,=20they=20=22temporaril=
y=22=0D=0A>=20include=20each=20other.=20They=20also=20include=20platform_de=
vice.h=20and=20of.h.=20As=20a=20result,=0D=0A>=20there's=20a=20pretty=20muc=
h=20random=20mix=20of=20those=20include=20files=20used=20throughout=20the=
=0D=0A>=20tree.=20In=20order=20to=20detangle=20these=20headers=20and=20repl=
ace=20the=20implicit=20includes=20with=0D=0A>=20struct=20declarations,=20us=
ers=20need=20to=20explicitly=20include=20the=20correct=20includes.=0D=0A>=
=20=0D=0A>=20Signed-off-by:=20Rob=20Herring=20<robh=40kernel.org>=0D=0A>=20=
---=0D=0A>=20=20drivers/watchdog/armada_37xx_wdt.c=20=7C=201=20-=0D=0A>=20d=
rivers/watchdog/at91rm9200_wdt.c=20=20=7C=203=20+--=0D=0A>=20=20drivers/wat=
chdog/cpwd.c=20=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20dr=
ivers/watchdog/ftwdt010_wdt.c=20=20=20=20=7C=206=20++----=0D=0A>=20=20drive=
rs/watchdog/imx2_wdt.c=20=20=20=20=20=20=20=20=7C=203=20+--=0D=0A>=20=20dri=
vers/watchdog/imx7ulp_wdt.c=20=20=20=20=20=7C=201=20-=0D=0A>=20=20drivers/w=
atchdog/meson_wdt.c=20=20=20=20=20=20=20=7C=204=20++--=0D=0A>=20=20drivers/=
watchdog/mtk_wdt.c=20=20=20=20=20=20=20=20=20=7C=201=20-=0D=0A>=20=20driver=
s/watchdog/of_xilinx_wdt.c=20=20=20=7C=203=20+--=0D=0A>=20=20drivers/watchd=
og/pic32-dmt.c=20=20=20=20=20=20=20=7C=203=20+--=0D=0A>=20=20drivers/watchd=
og/pic32-wdt.c=20=20=20=20=20=20=20=7C=203=20+--=0D=0A>=20=20drivers/watchd=
og/pika_wdt.c=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/watch=
dog/qcom-wdt.c=20=20=20=20=20=20=20=20=7C=201=20-=0D=0A>=20=20drivers/watch=
dog/rave-sp-wdt.c=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/watchdog/r=
iowd.c=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/wat=
chdog/rza_wdt.c=20=20=20=20=20=20=20=20=20=7C=204=20++--=0D=0A>=20=20driver=
s/watchdog/rzg2l_wdt.c=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers=
/watchdog/s3c2410_wdt.c=20=20=20=20=20=7C=201=20-=0D=0A=0D=0AFor=20Samsung=
=20WDT=0D=0AAcked-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=
=0D=0A>=20=20drivers/watchdog/sama5d4_wdt.c=20=20=20=20=20=7C=201=20-=0D=0A=
>=20=20drivers/watchdog/sbsa_gwdt.c=20=20=20=20=20=20=20=7C=203=20+--=0D=0A=
>=20=20drivers/watchdog/starfive-wdt.c=20=20=20=20=7C=203=20++-=0D=0A>=20=
=20drivers/watchdog/stm32_iwdg.c=20=20=20=20=20=20=7C=201=20-=0D=0A>=20=20d=
rivers/watchdog/sunxi_wdt.c=20=20=20=20=20=20=20=7C=201=20-=0D=0A>=20=20dri=
vers/watchdog/xilinx_wwdt.c=20=20=20=20=20=7C=204=20++--=0D=0A>=20=2024=20f=
iles=20changed,=2021=20insertions(+),=2036=20deletions(-)=0D=0A>=20=0D=0A>=
=20diff=20--git=20a/drivers/watchdog/armada_37xx_wdt.c=0D=0A>=20b/drivers/w=
atchdog/armada_37xx_wdt.c=0D=0A>=20index=20e58652939f8a..8133a5d05647=20100=
644=0D=0A>=20---=20a/drivers/watchdog/armada_37xx_wdt.c=0D=0A>=20+++=20b/dr=
ivers/watchdog/armada_37xx_wdt.c=0D=0A>=20=40=40=20-14,7=20+14,6=20=40=40=
=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/=
moduleparam.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=
=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=
=0D=0A>=20=20=23include=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/=
types.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/at91rm9200_wdt.c=0D=0A>=
=20b/drivers/watchdog/at91rm9200_wdt.c=0D=0A>=20index=20d20ec27ba354..55801=
5f08c7a=20100644=0D=0A>=20---=20a/drivers/watchdog/at91rm9200_wdt.c=0D=0A>=
=20+++=20b/drivers/watchdog/at91rm9200_wdt.c=0D=0A>=20=40=40=20-18,6=20+18,=
7=20=40=40=0D=0A>=20=20=23include=20<linux/mfd/syscon.h>=0D=0A>=20=20=23inc=
lude=20<linux/mfd/syscon/atmel-st.h>=0D=0A>=20=20=23include=20<linux/miscde=
vice.h>=0D=0A>=20+=23include=20<linux/mod_devicetable.h>=0D=0A>=20=20=23inc=
lude=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/moduleparam.h>=0D=
=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=40=40=20-26,8=20=
+27,6=20=40=40=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20=20=23incl=
ude=20<linux/watchdog.h>=0D=0A>=20=20=23include=20<linux/uaccess.h>=0D=0A>=
=20-=23include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=
=0A>=20=0D=0A>=20=20=23define=20WDT_DEFAULT_TIME=095=09/*=20seconds=20*/=0D=
=0A>=20=20=23define=20WDT_MAX_TIME=09=09256=09/*=20seconds=20*/=0D=0A>=20di=
ff=20--git=20a/drivers/watchdog/cpwd.c=20b/drivers/watchdog/cpwd.c=20index=
=0D=0A>=2047250f9b68c7..901b94d456db=20100644=0D=0A>=20---=20a/drivers/watc=
hdog/cpwd.c=0D=0A>=20+++=20b/drivers/watchdog/cpwd.c=0D=0A>=20=40=40=20-31,=
7=20+31,7=20=40=40=0D=0A>=20=20=23include=20<linux/mutex.h>=0D=0A>=20=20=23=
include=20<linux/io.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23i=
nclude=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/platform_device.=
h>=0D=0A>=20=20=23include=20<linux/uaccess.h>=0D=0A>=20=0D=0A>=20=20=23incl=
ude=20<asm/irq.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/ftwdt010_wdt.c=
=0D=0A>=20b/drivers/watchdog/ftwdt010_wdt.c=20index=20442c5bf63ff4..28f5af7=
52c10=20100644=0D=0A>=20---=20a/drivers/watchdog/ftwdt010_wdt.c=0D=0A>=20++=
+=20b/drivers/watchdog/ftwdt010_wdt.c=0D=0A>=20=40=40=20-14,7=20+14,7=20=40=
=40=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20=20=23include=20<linux/k=
ernel.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23include=20<=
linux/of_device.h>=0D=0A>=20+=23include=20<linux/mod_devicetable.h>=0D=0A>=
=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linu=
x/slab.h>=0D=0A>=20=20=23include=20<linux/watchdog.h>=0D=0A>=20=40=40=20-22=
1,20=20+221,18=20=40=40=20static=20const=20struct=20dev_pm_ops=0D=0A>=20ftw=
dt010_wdt_dev_pm_ops=20=3D=20=7B=0D=0A>=20=20=09=09=09=09ftwdt010_wdt_resum=
e)=0D=0A>=20=20=7D;=0D=0A>=20=0D=0A>=20-=23ifdef=20CONFIG_OF=0D=0A>=20=20st=
atic=20const=20struct=20of_device_id=20ftwdt010_wdt_match=5B=5D=20=3D=20=7B=
=0D=0A>=20=20=09=7B=20.compatible=20=3D=20=22faraday,ftwdt010=22=20=7D,=0D=
=0A>=20=20=09=7B=20.compatible=20=3D=20=22cortina,gemini-watchdog=22=20=7D,=
=0D=0A>=20=20=09=7B=7D,=0D=0A>=20=20=7D;=0D=0A>=20=20MODULE_DEVICE_TABLE(of=
,=20ftwdt010_wdt_match);=20-=23endif=0D=0A>=20=0D=0A>=20=20static=20struct=
=20platform_driver=20ftwdt010_wdt_driver=20=3D=20=7B=0D=0A>=20=20=09.probe=
=09=09=3D=20ftwdt010_wdt_probe,=0D=0A>=20=20=09.driver=09=09=3D=20=7B=0D=0A=
>=20=20=09=09.name=09=3D=20=22ftwdt010-wdt=22,=0D=0A>=20-=09=09.of_match_ta=
ble=20=3D=20of_match_ptr(ftwdt010_wdt_match),=0D=0A>=20+=09=09.of_match_tab=
le=20=3D=20ftwdt010_wdt_match,=0D=0A>=20=20=09=09.pm=20=3D=20&ftwdt010_wdt_=
dev_pm_ops,=0D=0A>=20=20=09=7D,=0D=0A>=20=20=7D;=0D=0A>=20diff=20--git=20a/=
drivers/watchdog/imx2_wdt.c=20b/drivers/watchdog/imx2_wdt.c=20index=0D=0A>=
=206fcc3596103c..1a27665a2f53=20100644=0D=0A>=20---=20a/drivers/watchdog/im=
x2_wdt.c=0D=0A>=20+++=20b/drivers/watchdog/imx2_wdt.c=0D=0A>=20=40=40=20-26=
,8=20+26,7=20=40=40=0D=0A>=20=20=23include=20<linux/kernel.h>=0D=0A>=20=20=
=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/moduleparam.h=
>=0D=0A>=20-=23include=20<linux/of_address.h>=0D=0A>=20-=23include=20<linux=
/of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=20=23include=20=
<linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/regmap.h>=0D=0A>=
=20=20=23include=20<linux/watchdog.h>=0D=0A>=20diff=20--git=20a/drivers/wat=
chdog/imx7ulp_wdt.c=20b/drivers/watchdog/imx7ulp_wdt.c=0D=0A>=20index=207ca=
486794ba7..c703586c6e5f=20100644=0D=0A>=20---=20a/drivers/watchdog/imx7ulp_=
wdt.c=0D=0A>=20+++=20b/drivers/watchdog/imx7ulp_wdt.c=0D=0A>=20=40=40=20-9,=
7=20+9,6=20=40=40=0D=0A>=20=20=23include=20<linux/kernel.h>=0D=0A>=20=20=23=
include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=
=23include=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_d=
evice.h>=0D=0A>=20=20=23include=20<linux/reboot.h>=0D=0A>=20=20=23include=
=20<linux/watchdog.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/meson_wdt.=
c=20b/drivers/watchdog/meson_wdt.c=0D=0A>=20index=20539feaa1f904..497496f64=
f55=20100644=0D=0A>=20---=20a/drivers/watchdog/meson_wdt.c=0D=0A>=20+++=20b=
/drivers/watchdog/meson_wdt.c=0D=0A>=20=40=40=20-11,11=20+11,11=20=40=40=0D=
=0A>=20=20=23include=20<linux/init.h>=0D=0A>=20=20=23include=20<linux/io.h>=
=0D=0A>=20=20=23include=20<linux/kernel.h>=0D=0A>=20+=23include=20<linux/mo=
d_devicetable.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=23i=
nclude=20<linux/moduleparam.h>=0D=0A>=20-=23include=20<linux/of.h>=0D=0A>=
=20-=23include=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platfo=
rm_device.h>=0D=0A>=20+=23include=20<linux/property.h>=0D=0A>=20=20=23inclu=
de=20<linux/types.h>=0D=0A>=20=20=23include=20<linux/watchdog.h>=0D=0A>=20=
=0D=0A>=20diff=20--git=20a/drivers/watchdog/mtk_wdt.c=20b/drivers/watchdog/=
mtk_wdt.c=20index=0D=0A>=20a9c437598e7e..b2330b16b497=20100644=0D=0A>=20---=
=20a/drivers/watchdog/mtk_wdt.c=0D=0A>=20+++=20b/drivers/watchdog/mtk_wdt.c=
=0D=0A>=20=40=40=20-25,7=20+25,6=20=40=40=0D=0A>=20=20=23include=20<linux/m=
odule.h>=0D=0A>=20=20=23include=20<linux/moduleparam.h>=0D=0A>=20=20=23incl=
ude=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20=20=
=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/rese=
t-controller.h>=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20diff=20--=
git=20a/drivers/watchdog/of_xilinx_wdt.c=0D=0A>=20b/drivers/watchdog/of_xil=
inx_wdt.c=0D=0A>=20index=202a079ca04aa3..05657dc1d36a=20100644=0D=0A>=20---=
=20a/drivers/watchdog/of_xilinx_wdt.c=0D=0A>=20+++=20b/drivers/watchdog/of_=
xilinx_wdt.c=0D=0A>=20=40=40=20-10,14=20+10,13=20=40=40=0D=0A>=20=20=23incl=
ude=20<linux/clk.h>=0D=0A>=20=20=23include=20<linux/err.h>=0D=0A>=20=20=23i=
nclude=20<linux/module.h>=0D=0A>=20+=23include=20<linux/platform_device.h>=
=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20=20=23include=20<linux/k=
ernel.h>=0D=0A>=20=20=23include=20<linux/ioport.h>=0D=0A>=20=20=23include=
=20<linux/watchdog.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20=20=23=
include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20=
-=23include=20<linux/of_address.h>=0D=0A>=20=0D=0A>=20=20/*=20Register=20of=
fsets=20for=20the=20Wdt=20device=20*/=0D=0A>=20=20=23define=20XWT_TWCSR0_OF=
FSET=20=20=200x0=20/*=20Control/Status=20Register0=20*/=0D=0A>=20diff=20--g=
it=20a/drivers/watchdog/pic32-dmt.c=20b/drivers/watchdog/pic32-dmt.c=0D=0A>=
=20index=20bc4ccddc75a3..466b4a41411f=20100644=0D=0A>=20---=20a/drivers/wat=
chdog/pic32-dmt.c=0D=0A>=20+++=20b/drivers/watchdog/pic32-dmt.c=0D=0A>=20=
=40=40=20-10,9=20+10,8=20=40=40=0D=0A>=20=20=23include=20<linux/err.h>=0D=
=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20=20=23include=20<linux/kernel.=
h>=0D=0A>=20+=23include=20<linux/mod_devicetable.h>=0D=0A>=20=20=23include=
=20<linux/module.h>=0D=0A>=20-=23include=20<linux/of.h>=0D=0A>=20-=23includ=
e=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=
=0D=0A>=20=20=23include=20<linux/pm.h>=0D=0A>=20=20=23include=20<linux/watc=
hdog.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/pic32-wdt.c=20b/drivers/=
watchdog/pic32-wdt.c=20index=0D=0A>=206d1a00222991..4d7eaf290e1c=20100644=
=0D=0A>=20---=20a/drivers/watchdog/pic32-wdt.c=0D=0A>=20+++=20b/drivers/wat=
chdog/pic32-wdt.c=0D=0A>=20=40=40=20-10,9=20+10,8=20=40=40=0D=0A>=20=20=23i=
nclude=20<linux/err.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20=20=
=23include=20<linux/kernel.h>=0D=0A>=20+=23include=20<linux/mod_devicetable=
.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23include=20<linux=
/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20=20=23include=20=
<linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/pm.h>=0D=0A>=20=
=20=23include=20<linux/watchdog.h>=0D=0A>=20diff=20--git=20a/drivers/watchd=
og/pika_wdt.c=20b/drivers/watchdog/pika_wdt.c=20index=0D=0A>=20a98abd0d3146=
..782b8c23d99c=20100644=0D=0A>=20---=20a/drivers/watchdog/pika_wdt.c=0D=0A>=
=20+++=20b/drivers/watchdog/pika_wdt.c=0D=0A>=20=40=40=20-23,8=20+23,8=20=
=40=40=0D=0A>=20=20=23include=20<linux/bitops.h>=0D=0A>=20=20=23include=20<=
linux/uaccess.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20+=23include=
=20<linux/of.h>=0D=0A>=20=20=23include=20<linux/of_address.h>=0D=0A>=20-=23=
include=20<linux/of_platform.h>=0D=0A>=20=0D=0A>=20=20=23define=20DRV_NAME=
=20=22PIKA-WDT=22=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/watchdog/qcom=
-wdt.c=20b/drivers/watchdog/qcom-wdt.c=0D=0A>=20index=20d776474dcdf3..9e790=
f0c2096=20100644=0D=0A>=20---=20a/drivers/watchdog/qcom-wdt.c=0D=0A>=20+++=
=20b/drivers/watchdog/qcom-wdt.c=0D=0A>=20=40=40=20-11,7=20+11,6=20=40=40=
=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20=20=23include=20<linux/plat=
form_device.h>=0D=0A>=20=20=23include=20<linux/watchdog.h>=0D=0A>=20-=23inc=
lude=20<linux/of_device.h>=0D=0A>=20=0D=0A>=20=20enum=20wdt_reg=20=7B=0D=0A=
>=20=20=09WDT_RST,=0D=0A>=20diff=20--git=20a/drivers/watchdog/rave-sp-wdt.c=
=20b/drivers/watchdog/rave-sp-wdt.c=0D=0A>=20index=202c95615b6354..5d1c2176=
d445=20100644=0D=0A>=20---=20a/drivers/watchdog/rave-sp-wdt.c=0D=0A>=20+++=
=20b/drivers/watchdog/rave-sp-wdt.c=0D=0A>=20=40=40=20-13,7=20+13,7=20=40=
=40=0D=0A>=20=20=23include=20<linux/mfd/rave-sp.h>=0D=0A>=20=20=23include=
=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/nvmem-consumer.h>=0D=0A=
>=20-=23include=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=
=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=
=20<linux/reboot.h>=0D=0A>=20=20=23include=20<linux/slab.h>=0D=0A>=20diff=
=20--git=20a/drivers/watchdog/riowd.c=20b/drivers/watchdog/riowd.c=20index=
=0D=0A>=20c04b383e1712..b293792a292a=20100644=0D=0A>=20---=20a/drivers/watc=
hdog/riowd.c=0D=0A>=20+++=20b/drivers/watchdog/riowd.c=0D=0A>=20=40=40=20-1=
4,7=20+14,7=20=40=40=0D=0A>=20=20=23include=20<linux/miscdevice.h>=0D=0A>=
=20=20=23include=20<linux/watchdog.h>=0D=0A>=20=20=23include=20<linux/of.h>=
=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/p=
latform_device.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20=20=23incl=
ude=20<linux/uaccess.h>=0D=0A>=20=20=23include=20<linux/slab.h>=0D=0A>=20di=
ff=20--git=20a/drivers/watchdog/rza_wdt.c=20b/drivers/watchdog/rza_wdt.c=20=
index=0D=0A>=20fe6c2ed35e04..cb4901b3f777=20100644=0D=0A>=20---=20a/drivers=
/watchdog/rza_wdt.c=0D=0A>=20+++=20b/drivers/watchdog/rza_wdt.c=0D=0A>=20=
=40=40=20-9,9=20+9,9=20=40=40=0D=0A>=20=20=23include=20<linux/bitops.h>=0D=
=0A>=20=20=23include=20<linux/clk.h>=0D=0A>=20=20=23include=20<linux/delay.=
h>=0D=0A>=20+=23include=20<linux/io.h>=0D=0A>=20=20=23include=20<linux/modu=
le.h>=0D=0A>=20-=23include=20<linux/of_address.h>=0D=0A>=20-=23include=20<l=
inux/of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=20=23includ=
e=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/watchdog.h>=
=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/watchdog/rzg2l_wdt.c=20b/drive=
rs/watchdog/rzg2l_wdt.c=20index=0D=0A>=20d404953d0e0f..1741f98ca67c=2010064=
4=0D=0A>=20---=20a/drivers/watchdog/rzg2l_wdt.c=0D=0A>=20+++=20b/drivers/wa=
tchdog/rzg2l_wdt.c=0D=0A>=20=40=40=20-11,7=20+11,7=20=40=40=0D=0A>=20=20=23=
include=20<linux/iopoll.h>=0D=0A>=20=20=23include=20<linux/kernel.h>=0D=0A>=
=20=20=23include=20<linux/module.h>=0D=0A>=20-=23include=20<linux/of_device=
.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=20=23include=20<linux/pla=
tform_device.h>=0D=0A>=20=20=23include=20<linux/pm_runtime.h>=0D=0A>=20=20=
=23include=20<linux/reset.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/s3c=
2410_wdt.c=0D=0A>=20b/drivers/watchdog/s3c2410_wdt.c=20index=2095416a9bdd4b=
..2bcc8faa7fa5=20100644=0D=0A>=20---=20a/drivers/watchdog/s3c2410_wdt.c=0D=
=0A>=20+++=20b/drivers/watchdog/s3c2410_wdt.c=0D=0A>=20=40=40=20-23,7=20+23=
,6=20=40=40=0D=0A>=20=20=23include=20<linux/slab.h>=0D=0A>=20=20=23include=
=20<linux/err.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=
=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/mfd/syscon.h>=0D=0A>=
=20=20=23include=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/delay.h=
>=0D=0A>=20diff=20--git=20a/drivers/watchdog/sama5d4_wdt.c=0D=0A>=20b/drive=
rs/watchdog/sama5d4_wdt.c=20index=20aeee934ca51b..71e8b5fbf51f=0D=0A>=20100=
644=0D=0A>=20---=20a/drivers/watchdog/sama5d4_wdt.c=0D=0A>=20+++=20b/driver=
s/watchdog/sama5d4_wdt.c=0D=0A>=20=40=40=20-11,7=20+11,6=20=40=40=0D=0A>=20=
=20=23include=20<linux/kernel.h>=0D=0A>=20=20=23include=20<linux/module.h>=
=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_dev=
ice.h>=0D=0A>=20=20=23include=20<linux/of_irq.h>=0D=0A>=20=20=23include=20<=
linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/reboot.h>=0D=0A>=
=20diff=20--git=20a/drivers/watchdog/sbsa_gwdt.c=20b/drivers/watchdog/sbsa_=
gwdt.c=0D=0A>=20index=20fd3cfdda4949..421ebcda62e6=20100644=0D=0A>=20---=20=
a/drivers/watchdog/sbsa_gwdt.c=0D=0A>=20+++=20b/drivers/watchdog/sbsa_gwdt.=
c=0D=0A>=20=40=40=20-43,10=20+43,9=20=40=40=0D=0A>=20=20=23include=20<linux=
/io.h>=0D=0A>=20=20=23include=20<linux/io-64-nonatomic-lo-hi.h>=20=20=23inc=
lude=20<linux/interrupt.h>=0D=0A>=20+=23include=20<linux/mod_devicetable.h>=
=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/=
moduleparam.h>=0D=0A>=20-=23include=20<linux/of.h>=0D=0A>=20-=23include=20<=
linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A=
>=20=20=23include=20<linux/uaccess.h>=0D=0A>=20=20=23include=20<linux/watch=
dog.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/starfive-wdt.c=20b/driver=
s/watchdog/starfive-wdt.c=0D=0A>=20index=208058fca4d05d..9e6db8e0164f=20100=
644=0D=0A>=20---=20a/drivers/watchdog/starfive-wdt.c=0D=0A>=20+++=20b/drive=
rs/watchdog/starfive-wdt.c=0D=0A>=20=40=40=20-8,7=20+8,8=20=40=40=0D=0A>=20=
=20=23include=20<linux/clk.h>=0D=0A>=20=20=23include=20<linux/iopoll.h>=0D=
=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23include=20<linux/of_de=
vice.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20+=23include=20<linux/p=
latform_device.h>=0D=0A>=20=20=23include=20<linux/pm_runtime.h>=0D=0A>=20=
=20=23include=20<linux/reset.h>=0D=0A>=20=20=23include=20<linux/watchdog.h>=
=0D=0A>=20diff=20--git=20a/drivers/watchdog/stm32_iwdg.c=20b/drivers/watchd=
og/stm32_iwdg.c=0D=0A>=20index=20570a71509d2a..fa5e70c4b93a=20100644=0D=0A>=
=20---=20a/drivers/watchdog/stm32_iwdg.c=0D=0A>=20+++=20b/drivers/watchdog/=
stm32_iwdg.c=0D=0A>=20=40=40=20-17,7=20+17,6=20=40=40=0D=0A>=20=20=23includ=
e=20<linux/kernel.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=
=23include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=
=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linu=
x/watchdog.h>=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/watchdog/sunxi_wd=
t.c=20b/drivers/watchdog/sunxi_wdt.c=0D=0A>=20index=206cf82922d3fb..b85354a=
99582=20100644=0D=0A>=20---=20a/drivers/watchdog/sunxi_wdt.c=0D=0A>=20+++=
=20b/drivers/watchdog/sunxi_wdt.c=0D=0A>=20=40=40=20-18,7=20+18,6=20=40=40=
=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/=
moduleparam.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=
=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=
=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20=20=23include=20<linux/w=
atchdog.h>=0D=0A>=20diff=20--git=20a/drivers/watchdog/xilinx_wwdt.c=20b/dri=
vers/watchdog/xilinx_wwdt.c=0D=0A>=20index=202585038d5575..1d998db41533=201=
00644=0D=0A>=20---=20a/drivers/watchdog/xilinx_wwdt.c=0D=0A>=20+++=20b/driv=
ers/watchdog/xilinx_wwdt.c=0D=0A>=20=40=40=20-9,9=20+9,9=20=40=40=0D=0A>=20=
=20=23include=20<linux/interrupt.h>=0D=0A>=20=20=23include=20<linux/io.h>=
=0D=0A>=20=20=23include=20<linux/ioport.h>=0D=0A>=20+=23include=20<linux/mo=
d_devicetable.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23inc=
lude=20<linux/of_device.h>=0D=0A>=20-=23include=20<linux/of_address.h>=0D=
=0A>=20+=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<li=
nux/watchdog.h>=0D=0A>=20=0D=0A>=20=20/*=20Max=20timeout=20is=20calculated=
=20at=20100MHz=20source=20clock=20*/=0D=0A>=20--=0D=0A>=202.40.1=0D=0A=0D=
=0A=0D=0A
