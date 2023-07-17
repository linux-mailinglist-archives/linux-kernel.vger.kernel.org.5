Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AD7561E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGQLql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGQLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:46:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED20D1725;
        Mon, 17 Jul 2023 04:46:06 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230717114604epoutp03d9cf6f0cde030e9bb0de6b88c3067832~ypR9V8bxA0525205252epoutp03b;
        Mon, 17 Jul 2023 11:46:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230717114604epoutp03d9cf6f0cde030e9bb0de6b88c3067832~ypR9V8bxA0525205252epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689594364;
        bh=oViY/xWe0rmX6jPt2PJcruz0P2J8Wy/FDnduI3D2vU0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Muh2o5dcUl7oHJb40yFjjaRpGMb8m4WZ/DjeIt8G/jDiVVYpgL8v6O9I2Ri5jSEAU
         +1rOosqoLwA1RRixficAuZfsdx5YOiJa3yt/7UsFaiE0SCpW3mI9LWnsQpRBV9VnUJ
         uYOOXDFp01wT4/nfHCq3sOHwLUL48vHjdPcH0HLA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230717114603epcas5p12dedf9be634dc7264aebcbf18d51b74b~ypR9Dgkfk0923909239epcas5p1-;
        Mon, 17 Jul 2023 11:46:03 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4KzG0QKgz4x9Pv; Mon, 17 Jul
        2023 11:46:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.63.55522.9F925B46; Mon, 17 Jul 2023 20:46:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230717114601epcas5p297034d2bf4f5d0ebe191739407be0309~ypR6w15-_0840708407epcas5p2r;
        Mon, 17 Jul 2023 11:46:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230717114601epsmtrp2991a931224e0153b65397b7f3758cae1~ypR6uyy2U2747727477epsmtrp2N;
        Mon, 17 Jul 2023 11:46:01 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-1e-64b529f9b5dd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.22.30535.9F925B46; Mon, 17 Jul 2023 20:46:01 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230717114554epsmtip1f5713d9fc208811d64ffa4ab30ad45f7~ypR0XStdz0999809998epsmtip1T;
        Mon, 17 Jul 2023 11:45:54 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>,
        "'Guillaume La Roque'" <glaroque@baylibre.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Amit Kucheria'" <amitk@kernel.org>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'Florian Fainelli'" <florian.fainelli@broadcom.com>,
        "'Broadcom internal kernel review list'" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "'Markus Mayer'" <mmayer@broadcom.com>,
        "'Shawn Guo'" <shawnguo@kernel.org>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        "'Pengutronix Kernel Team'" <kernel@pengutronix.de>,
        "'Fabio Estevam'" <festevam@gmail.com>,
        "'NXP Linux Team'" <linux-imx@nxp.com>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Thara Gopinath'" <thara.gopinath@gmail.com>,
        =?UTF-8?Q?'Niklas_S=C3=B6derlund'?= <niklas.soderlund@ragnatech.se>,
        "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Orson Zhai'" <orsonzhai@gmail.com>,
        "'Baolin Wang'" <baolin.wang@linux.alibaba.com>,
        "'Chunyan Zhang'" <zhang.lyra@gmail.com>,
        "'Maxime Coquelin'" <mcoquelin.stm32@gmail.com>,
        "'Alexandre Torgue'" <alexandre.torgue@foss.st.com>,
        "'Vasily Khoruzhick'" <anarsoul@gmail.com>,
        "'Yangtao Li'" <tiny.windzz@gmail.com>,
        "'Chen-Yu Tsai'" <wens@csie.org>,
        "'Jernej Skrabec'" <jernej.skrabec@gmail.com>,
        "'Samuel Holland'" <samuel@sholland.org>,
        "'Thierry Reding'" <thierry.reding@gmail.com>,
        "'Jonathan Hunter'" <jonathanh@nvidia.com>,
        "'Kunihiko Hayashi'" <hayashi.kunihiko@socionext.com>,
        "'Masami Hiramatsu'" <mhiramat@kernel.org>,
        "'Matthias Brugger'" <matthias.bgg@gmail.com>,
        "'AngeloGioacchino Del Regno'" 
        <angelogioacchino.delregno@collabora.com>
Cc:     <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
In-Reply-To: <20230714175008.4064592-1-robh@kernel.org>
Subject: RE: [PATCH] thermal: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 17:15:53 +0530
Message-ID: <001f01d9b8a4$422a3530$c67e9f90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFJ8/MHuIcdR0+KCwgF77BaMZezKwGouk0XsNAaiCA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH9+u9vbc6Wa6VhZ8YM+yiEwWkUurB8TAZyHVz080tWdSNdfaO
        mpa2aYtTs0TGS4FVQJTp5eELRSuoK6ClgHMVJRrfQGVBNkEeFifik6Agaylu/vc5J99zvuf8
        fjkiQlwq8het15o4g1ahkVCTyVPnAj8IHg6sUYYW3pDB1bsvSRh2FSI4t3cjZFzoRXBqWyTc
        PIphrOECgkrzeRKGqm8JoPTJTNjbeFUIna0r4PipvwjYX1BCwbm2VAR9e48jSOcPkGDZVUvC
        toLTJDTcr6FhX9HbYL3rFEL+71doyH5xlIBmezEFzWk3EDwxNyKocQ0IIL/9JA27r50RQLaz
        Wwg7z9gpyHrKU5CaHgalo5VCOFg+B4oH2mloKtwuhF8HixCUPN1FwFi9jYbuzu0UjJ62ktDX
        lUXBvWo/aKnYTcGwvZSEkpd5bnJcE0D5HTu9ZCH7sC2DZvm/r1CsraMMsSe7jgnZntwamq3l
        O2j2YL1LwFotWRR721lPsbWdEWxV2Rb2XtUexJrTBij2twGbgM0dDWX7moeolb6r1ZEqTqHk
        DAGcdp1OuV6bGCX5ZFXCRwnh8lBpsDQCFkkCtIokLkoSu3xl8NL1GvdPSAI2KDTJ7tRKhdEo
        WRAdadAlm7gAlc5oipJweqVGL9OHGBVJxmRtYoiWMy2WhoYuDHcLv1OrzKW8UP+0HG0se9VC
        p6BHB1A2miTCjAw38RYqG00WiZk6hAtarhPe4DHCw3/mTgTPEb54ZCfxuqS8skbgYTHTgLDF
        Mt/LLoSzuzZ6mGKCse1g5nhbX2bUB/fXnUCegGDaCOwc42mPahKzCB/7o3qcpzGx2Ny9b9yB
        ZGbj/tr2cfZhIrCtN4fy8lR8cU836WGCmY8P778/MVEAHu45LPTm/bDrfKO7p8jtvBiX5og8
        vpgZmYwvOfKEXn0s7rMNkl6ehvubvDNgxh8/GWigPLWYYfGBEX9vWoUflJ+YeK8YfLalmPRI
        CCYQn7Av8Lq+g80vuwXeSh+8LVPsVc/GaQOtE0YzcH5OzsQALL7zopfOQ7P4N/bi39iLf2MX
        /n+zfYi0oOmc3piUyBnD9VIt9+N/H75Ol2RF44c6b5kNddwZDHEggQg5EBYREl+fIYtVKfZR
        KjZt5gy6BEOyhjM6ULj7sfMJ/3fX6dyXrjUlSGURoTK5XC6LCJNLJX4+9zNKlGImUWHi1Byn
        5wyv6wSiSf4pgvcil1VUdM1VP3BubS0qmB47n4blFbHxMbyKTYuO6br0Q9nMD28ecRWt6bVq
        pc5FPTXpG9aOfdWijOtcEjJDfqtoh+kSm55gadoUvSYuTrgje/nuxxrDF5vTBd8b/AL7qGdr
        dV8HpeRSh966zn+8fzT17NTG2tym7qHVr1rDf5paabjMFj9/NBJULbbHVAXm16esSPo2aMTW
        8TBTFTXNaOVXxRd/+s+X5s8dDrWsp73ufd/hi/VVFZlB0WtuJWo0CxSq1C23pwQPqrouqNu+
        +ays+bJSKcvaauiUnkyJdyX8XFcYLE7OaYwLy4gJOxQvL26x/zKHLtg8ZZbz2RH19P57c0mb
        hDSqFNJ5hMGo+BfB0HTdMQUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yUdRzH+z7Pc8/zAB0+3rH4KhOVHW1goFCzD0nEFtkza4mz1cpNvOQZ
        sOC43YlRTSEEgnMHmGFwwN0pAgHxm4ODDjBAWksPEjuYgAgCB5IXU4sRIgE3N/577fN+f177
        /PFhScm39HY2TnFKUCnk8T60K9XS4+MdsORnit6XZXUH6/1lCpbmLiHoMSRDRt8MgpasULhV
        iWG1ow9BjfY6BYvNQwToH+8AQ69VBBN/HobalrskXL5YQkPPcBoCu6EWQbruCgVV+W0UZF1s
        paBj3sSAscgNGu/bRHCh6yYDmv8qSRhsL6Zh8NwfCB5rexGY5hwEXBipZ6Cgv5MAjW1KBN93
        ttOQ/URHQ1r6q6BfqRFBacXLUOwYYeDXSzki+GGhCEHJk3wSVi1mBqYmcmhYaW2kwD6ZTcNs
        syfc/qmAhqV2PQUly3lr1N1PQMW9diY8mP97OIPhdeM3ad48dhXx9ZPVIn4618Twbboxhi+1
        zBF8Y1U2zY/aLDTfNhHCN11N4WebChGvPeeg+QaHmeBzV/bx9sFFOtLjU9fQaCE+7rSg2ht2
        wjU2c0KsrPs6udXeRKei/jgNcmEx9xquqDERGuTKSrifEX40bCWcgRceashjnCzFlc/sjLNk
        R9jRdwWtBzQXgM2lmfR64MHlu2P9j5aNFslNkXgm75bIuZKFsOlZyYbXhXsdV//SvOGVchFY
        O2Uk15nifPGDtpENFnMh2DxznnbyVvxb4RS1ziS3B2snMtBzLr88Tzrv24WXpstFzrknnrve
        u+Zn1056A+vPs3lIqttk0m0y6TaZdJu2jYiqQtsEpTohJkEdpAxWCF8EquUJ6iRFTODJxIRG
        tPGr/v5mZKlaCOxGBIu6EWZJHw/xYlVjtEQcLf/yK0GVGKVKihfU3ciLpXw8xf/Oa6MlXIz8
        lPC5ICgF1fOUYF22pxJBdYYjhx7uskm2bY0qmt4d8MFBz7yczrQC66Nvgs6kJK6mfFaR9o96
        dIA61uc9VL1wfOHFlNLxe7aPZ7XL4sDg5Hr3aqIjt5Yq8lqW+b61/8RqkctDv9uW+HdZg0G2
        szC0VdY5s/OV3W/L9ncVvFAadvodb+UnBaqQB5T8zZdmjpYj6Uj6yN2IA4rC7wIjwrWT4602
        ss4kO3Yn7PjoXiVH+63ozbWx781Kwiutv0ddK9YwN9L182fveESmfOT+dPSgUdU1MB8uHHp/
        RXKUHMjdYjsrNZ6xlD21X/sr3zPJzS1N0kBvKXPkVh7YkbqnKVLqNujwdVV0jC3f+PBkWKZx
        qMzoQ6lj5UH+pEot/x/GmIHyGgQAAA==
X-CMS-MailID: 20230717114601epcas5p297034d2bf4f5d0ebe191739407be0309
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714175102epcas5p1e1cee0ae2ceb0475e65c73029d4c386c
References: <CGME20230714175102epcas5p1e1cee0ae2ceb0475e65c73029d4c386c@epcas5p1.samsung.com>
        <20230714175008.4064592-1-robh@kernel.org>
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
> Sent: Friday, July 14, 2023 11:20 PM
> To: Guillaume La Roque <glaroque=40baylibre.com>; Rafael J. Wysocki
> <rafael=40kernel.org>; Daniel Lezcano <daniel.lezcano=40linaro.org>; Amit
> Kucheria <amitk=40kernel.org>; Zhang Rui <rui.zhang=40intel.com>; Florian=
 Fainelli
> <florian.fainelli=40broadcom.com>; Broadcom internal kernel review list <=
bcm-
> kernel-feedback-list=40broadcom.com>; Markus Mayer
> <mmayer=40broadcom.com>; Shawn Guo <shawnguo=40kernel.org>; Sascha
> Hauer <s.hauer=40pengutronix.de>; Pengutronix Kernel Team
> <kernel=40pengutronix.de>; Fabio Estevam <festevam=40gmail.com>; NXP Linu=
x
> Team <linux-imx=40nxp.com>; Andy Gross <agross=40kernel.org>; Bjorn Ander=
sson
> <andersson=40kernel.org>; Konrad Dybcio <konrad.dybcio=40linaro.org>; Tha=
ra
> Gopinath <thara.gopinath=40gmail.com>; Niklas S=C3=B6derlund=0D=0A>=20<ni=
klas.soderlund=40ragnatech.se>;=20Bartlomiej=20Zolnierkiewicz=0D=0A>=20<bzo=
lnier=40gmail.com>;=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro=
.org>;=0D=0A>=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>;=20Orson=20Zhai=
=20<orsonzhai=40gmail.com>;=0D=0A>=20Baolin=20Wang=20<baolin.wang=40linux.a=
libaba.com>;=20Chunyan=20Zhang=0D=0A>=20<zhang.lyra=40gmail.com>;=20Maxime=
=20Coquelin=20<mcoquelin.stm32=40gmail.com>;=0D=0A>=20Alexandre=20Torgue=20=
<alexandre.torgue=40foss.st.com>;=20Vasily=20Khoruzhick=0D=0A>=20<anarsoul=
=40gmail.com>;=20Yangtao=20Li=20<tiny.windzz=40gmail.com>;=20Chen-Yu=20Tsai=
=0D=0A>=20<wens=40csie.org>;=20Jernej=20Skrabec=20<jernej.skrabec=40gmail.c=
om>;=20Samuel=20Holland=0D=0A>=20<samuel=40sholland.org>;=20Thierry=20Redin=
g=20<thierry.reding=40gmail.com>;=20Jonathan=0D=0A>=20Hunter=20<jonathanh=
=40nvidia.com>;=20Kunihiko=20Hayashi=0D=0A>=20<hayashi.kunihiko=40socionext=
.com>;=20Masami=20Hiramatsu=0D=0A>=20<mhiramat=40kernel.org>;=20Matthias=20=
Brugger=20<matthias.bgg=40gmail.com>;=0D=0A>=20AngeloGioacchino=20Del=20Reg=
no=20<angelogioacchino.delregno=40collabora.com>=0D=0A>=20Cc:=20devicetree=
=40vger.kernel.org;=20linux-pm=40vger.kernel.org;=20linux-=0D=0A>=20amlogic=
=40lists.infradead.org;=20linux-kernel=40vger.kernel.org;=20linux-rpi-=0D=
=0A>=20kernel=40lists.infradead.org;=20linux-arm-kernel=40lists.infradead.o=
rg;=20linux-arm-=0D=0A>=20msm=40vger.kernel.org;=20linux-renesas-soc=40vger=
.kernel.org;=20linux-samsung-=0D=0A>=20soc=40vger.kernel.org;=20linux-stm32=
=40st-md-mailman.stormreply.com;=20linux-=0D=0A>=20sunxi=40lists.linux.dev;=
=20linux-tegra=40vger.kernel.org;=20linux-=0D=0A>=20mediatek=40lists.infrad=
ead.org=0D=0A>=20Subject:=20=5BPATCH=5D=20thermal:=20Explicitly=20include=
=20correct=20DT=20includes=0D=0A>=20=0D=0A>=20The=20DT=20of_device.h=20and=
=20of_platform.h=20date=20back=20to=20the=20separate=0D=0A>=20of_platform_b=
us_type=20before=20it=20as=20merged=20into=20the=20regular=20platform=20bus=
.=0D=0A>=20As=20part=20of=20that=20merge=20prepping=20Arm=20DT=20support=20=
13=20years=20ago,=20they=20=22temporarily=22=0D=0A>=20include=20each=20othe=
r.=20They=20also=20include=20platform_device.h=20and=20of.h.=20As=20a=20res=
ult,=0D=0A>=20there's=20a=20pretty=20much=20random=20mix=20of=20those=20inc=
lude=20files=20used=20throughout=20the=0D=0A>=20tree.=20In=20order=20to=20d=
etangle=20these=20headers=20and=20replace=20the=20implicit=20includes=20wit=
h=0D=0A>=20struct=20declarations,=20users=20need=20to=20explicitly=20includ=
e=20the=20correct=20includes.=0D=0A>=20=0D=0A>=20Signed-off-by:=20Rob=20Her=
ring=20<robh=40kernel.org>=0D=0A>=20---=0D=0A>=20=20drivers/thermal/amlogic=
_thermal.c=20=20=20=20=20=20=20=20=20=20=20=7C=202=20--=0D=0A>=20=20drivers=
/thermal/broadcom/bcm2711_thermal.c=20=20=7C=202=20+-=0D=0A>=20drivers/ther=
mal/broadcom/brcmstb_thermal.c=20=20=7C=202=20+-=0D=0A>=20=20drivers/therma=
l/hisi_thermal.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=
=0A>=20=20drivers/thermal/imx8mm_thermal.c=20=20=20=20=20=20=20=20=20=20=20=
=20=7C=201=20-=0D=0A>=20=20drivers/thermal/imx_sc_thermal.c=20=20=20=20=20=
=20=20=20=20=20=20=20=7C=201=20-=0D=0A>=20=20drivers/thermal/imx_thermal.c=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drive=
rs/thermal/k3_bandgap.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=202=20+-=0D=0A>=20=20drivers/thermal/k3_j72xx_bandgap.c=20=20=20=20=20=20=
=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/thermal/mediatek/auxadc_therma=
l.c=20=20=20=7C=201=20-=0D=0A>=20=20drivers/thermal/mediatek/lvts_thermal.c=
=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/thermal/qcom/qcom-spmi-adc-=
tm5.c=20=20=20=20=7C=201=20-=0D=0A>=20=20drivers/thermal/qcom/qcom-spmi-tem=
p-alarm.c=20=7C=201=20-=0D=0A>=20=20drivers/thermal/rcar_gen3_thermal.c=20=
=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/thermal/rcar_therm=
al.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20driv=
ers/thermal/rzg2l_thermal.c=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=202=
=20+-=0D=0A>=20=20drivers/thermal/samsung/exynos_tmu.c=20=20=20=20=20=20=20=
=20=7C=202=20+-=0D=0A=0D=0AFor=20Samsung/=20Exynos=0D=0A=0D=0AReviewed-by:=
=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20=20drivers/th=
ermal/sprd_thermal.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=
=0D=0A>=20=20drivers/thermal/st/stm_thermal.c=20=20=20=20=20=20=20=20=20=20=
=20=20=7C=202=20--=0D=0A>=20=20drivers/thermal/sun8i_thermal.c=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/thermal/tegra/t=
egra30-tsensor.c=20=20=20=20=20=7C=202=20+-=0D=0A>=20=20drivers/thermal/the=
rmal_of.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=203=20+--=0D=
=0A>=20=20drivers/thermal/uniphier_thermal.c=20=20=20=20=20=20=20=20=20=20=
=7C=201=20-=0D=0A>=20=2023=20files=20changed,=2015=20insertions(+),=2026=20=
deletions(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/thermal/amlogic_th=
ermal.c=0D=0A>=20b/drivers/thermal/amlogic_thermal.c=0D=0A>=20index=20756b2=
18880a7..81ebbf6de0de=20100644=0D=0A>=20---=20a/drivers/thermal/amlogic_the=
rmal.c=0D=0A>=20+++=20b/drivers/thermal/amlogic_thermal.c=0D=0A>=20=40=40=
=20-22,8=20+22,6=20=40=40=0D=0A>=20=20=23include=20<linux/mfd/syscon.h>=0D=
=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/of.=
h>=0D=0A>=20-=23include=20<linux/of_address.h>=0D=0A>=20-=23include=20<linu=
x/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=
=20=23include=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=
=0D=0A>=20diff=20--git=20a/drivers/thermal/broadcom/bcm2711_thermal.c=0D=0A=
>=20b/drivers/thermal/broadcom/bcm2711_thermal.c=0D=0A>=20index=20c243a76a3=
471..03ac2d02e9d4=20100644=0D=0A>=20---=20a/drivers/thermal/broadcom/bcm271=
1_thermal.c=0D=0A>=20+++=20b/drivers/thermal/broadcom/bcm2711_thermal.c=0D=
=0A>=20=40=40=20-15,8=20+15,8=20=40=40=0D=0A>=20=20=23include=20<linux/kern=
el.h>=0D=0A>=20=20=23include=20<linux/mfd/syscon.h>=0D=0A>=20=20=23include=
=20<linux/module.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=20=23incl=
ude=20<linux/platform_device.h>=0D=0A>=20-=23include=20<linux/of_device.h>=
=0D=0A>=20=20=23include=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/=
thermal.h>=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/thermal/broadcom/brc=
mstb_thermal.c=0D=0A>=20b/drivers/thermal/broadcom/brcmstb_thermal.c=0D=0A>=
=20index=2072d1dbe60b8f..0b73abdaa792=20100644=0D=0A>=20---=20a/drivers/the=
rmal/broadcom/brcmstb_thermal.c=0D=0A>=20+++=20b/drivers/thermal/broadcom/b=
rcmstb_thermal.c=0D=0A>=20=40=40=20-17,8=20+17,8=20=40=40=0D=0A>=20=20=23in=
clude=20<linux/interrupt.h>=0D=0A>=20=20=23include=20<linux/kernel.h>=0D=0A=
>=20=20=23include=20<linux/module.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=
=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20-=23include=20<li=
nux/of_device.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=20=0D=0A=
>=20=20=23define=20AVS_TMON_STATUS=09=09=090x00=0D=0A>=20diff=20--git=20a/d=
rivers/thermal/hisi_thermal.c=20b/drivers/thermal/hisi_thermal.c=0D=0A>=20i=
ndex=203f09ef8be41a..fb54ed4bf6f0=20100644=0D=0A>=20---=20a/drivers/thermal=
/hisi_thermal.c=0D=0A>=20+++=20b/drivers/thermal/hisi_thermal.c=0D=0A>=20=
=40=40=20-13,9=20+13,9=20=40=40=0D=0A>=20=20=23include=20<linux/delay.h>=0D=
=0A>=20=20=23include=20<linux/interrupt.h>=0D=0A>=20=20=23include=20<linux/=
module.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=20=23include=20<lin=
ux/platform_device.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20-=23in=
clude=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=0D=
=0A>=20=0D=0A>=20=20=23define=20HI6220_TEMP0_LAG=09=09=09(0x0)=0D=0A>=20dif=
f=20--git=20a/drivers/thermal/imx8mm_thermal.c=0D=0A>=20b/drivers/thermal/i=
mx8mm_thermal.c=0D=0A>=20index=20d4b40869c7d7..e89b11b3f2b9=20100644=0D=0A>=
=20---=20a/drivers/thermal/imx8mm_thermal.c=0D=0A>=20+++=20b/drivers/therma=
l/imx8mm_thermal.c=0D=0A>=20=40=40=20-12,7=20+12,6=20=40=40=0D=0A>=20=20=23=
include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/nvmem-consumer.h=
>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_de=
vice.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23i=
nclude=20<linux/slab.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=
=20diff=20--git=20a/drivers/thermal/imx_sc_thermal.c=0D=0A>=20b/drivers/the=
rmal/imx_sc_thermal.c=0D=0A>=20index=208d6b4ef23746..7224f8d21db9=20100644=
=0D=0A>=20---=20a/drivers/thermal/imx_sc_thermal.c=0D=0A>=20+++=20b/drivers=
/thermal/imx_sc_thermal.c=0D=0A>=20=40=40=20-8,7=20+8,6=20=40=40=0D=0A>=20=
=20=23include=20<linux/firmware/imx/sci.h>=0D=0A>=20=20=23include=20<linux/=
module.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=20<lin=
ux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=
=20=20=23include=20<linux/slab.h>=0D=0A>=20=20=23include=20<linux/thermal.h=
>=0D=0A>=20diff=20--git=20a/drivers/thermal/imx_thermal.c=20b/drivers/therm=
al/imx_thermal.c=0D=0A>=20index=20a94ec0a0c9dd..826358cbe810=20100644=0D=0A=
>=20---=20a/drivers/thermal/imx_thermal.c=0D=0A>=20+++=20b/drivers/thermal/=
imx_thermal.c=0D=0A>=20=40=40=20-11,7=20+11,7=20=40=40=0D=0A>=20=20=23inclu=
de=20<linux/mfd/syscon.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=
=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=
=0D=0A>=20+=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20=
<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=20=20=23=
include=20<linux/nvmem-consumer.h>=0D=0A>=20diff=20--git=20a/drivers/therma=
l/k3_bandgap.c=20b/drivers/thermal/k3_bandgap.c=20index=0D=0A>=201c3e590157=
ec..68f59b3735d3=20100644=0D=0A>=20---=20a/drivers/thermal/k3_bandgap.c=0D=
=0A>=20+++=20b/drivers/thermal/k3_bandgap.c=0D=0A>=20=40=40=20-11,7=20+11,7=
=20=40=40=0D=0A>=20=20=23include=20<linux/kernel.h>=0D=0A>=20=20=23include=
=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23incl=
ude=20<linux/of_platform.h>=0D=0A>=20+=23include=20<linux/platform_device.h=
>=0D=0A>=20=20=23include=20<linux/pm_runtime.h>=0D=0A>=20=20=23include=20<l=
inux/thermal.h>=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20diff=20--=
git=20a/drivers/thermal/k3_j72xx_bandgap.c=0D=0A>=20b/drivers/thermal/k3_j7=
2xx_bandgap.c=0D=0A>=20index=205be1f09eeb2c..a5a0fc9b9356=20100644=0D=0A>=
=20---=20a/drivers/thermal/k3_j72xx_bandgap.c=0D=0A>=20+++=20b/drivers/ther=
mal/k3_j72xx_bandgap.c=0D=0A>=20=40=40=20-10,10=20+10,10=20=40=40=0D=0A>=20=
=20=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/init.h>=0D=
=0A>=20=20=23include=20<linux/kernel.h>=0D=0A>=20+=23include=20<linux/platf=
orm_device.h>=0D=0A>=20=20=23include=20<linux/pm_runtime.h>=0D=0A>=20=20=23=
include=20<linux/err.h>=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20-=
=23include=20<linux/of_platform.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=
=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=20=20=23include=20<linux/of=
.h>=0D=0A>=20diff=20--git=20a/drivers/thermal/mediatek/auxadc_thermal.c=0D=
=0A>=20b/drivers/thermal/mediatek/auxadc_thermal.c=0D=0A>=20index=20f59d36d=
e20a0..c537aed71017=20100644=0D=0A>=20---=20a/drivers/thermal/mediatek/auxa=
dc_thermal.c=0D=0A>=20+++=20b/drivers/thermal/mediatek/auxadc_thermal.c=0D=
=0A>=20=40=40=20-15,7=20+15,6=20=40=40=0D=0A>=20=20=23include=20<linux/nvme=
m-consumer.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20=20=23include=
=20<linux/of_address.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=
=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linu=
x/slab.h>=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20diff=20--git=20a/d=
rivers/thermal/mediatek/lvts_thermal.c=0D=0A>=20b/drivers/thermal/mediatek/=
lvts_thermal.c=0D=0A>=20index=20b693fac2d677..054c965ae5e1=20100644=0D=0A>=
=20---=20a/drivers/thermal/mediatek/lvts_thermal.c=0D=0A>=20+++=20b/drivers=
/thermal/mediatek/lvts_thermal.c=0D=0A>=20=40=40=20-13,7=20+13,7=20=40=40=
=0D=0A>=20=20=23include=20<linux/iopoll.h>=0D=0A>=20=20=23include=20<linux/=
kernel.h>=0D=0A>=20=20=23include=20<linux/nvmem-consumer.h>=0D=0A>=20-=23in=
clude=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=
=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/r=
eset.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=20diff=20--git=20=
a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c=0D=0A>=20b/drivers/thermal/qcom/=
qcom-spmi-adc-tm5.c=0D=0A>=20index=205ddc39b2be32..756ac6842ff9=20100644=0D=
=0A>=20---=20a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c=0D=0A>=20+++=20b/dr=
ivers/thermal/qcom/qcom-spmi-adc-tm5.c=0D=0A>=20=40=40=20-14,7=20+14,6=20=
=40=40=0D=0A>=20=20=23include=20<linux/interrupt.h>=0D=0A>=20=20=23include=
=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23incl=
ude=20<linux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h=
>=0D=0A>=20=20=23include=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux=
/thermal.h>=0D=0A>=20diff=20--git=20a/drivers/thermal/qcom/qcom-spmi-temp-a=
larm.c=0D=0A>=20b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c=0D=0A>=20inde=
x=200e8ebfcd84c5..78c5cfe6a0c0=20100644=0D=0A>=20---=20a/drivers/thermal/qc=
om/qcom-spmi-temp-alarm.c=0D=0A>=20+++=20b/drivers/thermal/qcom/qcom-spmi-t=
emp-alarm.c=0D=0A>=20=40=40=20-10,7=20+10,6=20=40=40=0D=0A>=20=20=23include=
=20<linux/interrupt.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=
=20=23include=20<linux/of.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=
=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<=
linux/regmap.h>=0D=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=20diff=20=
--git=20a/drivers/thermal/rcar_gen3_thermal.c=0D=0A>=20b/drivers/thermal/rc=
ar_gen3_thermal.c=0D=0A>=20index=209029d01e029b..bd2fb8c2e968=20100644=0D=
=0A>=20---=20a/drivers/thermal/rcar_gen3_thermal.c=0D=0A>=20+++=20b/drivers=
/thermal/rcar_gen3_thermal.c=0D=0A>=20=40=40=20-11,7=20+11,7=20=40=40=0D=0A=
>=20=20=23include=20<linux/interrupt.h>=0D=0A>=20=20=23include=20<linux/io.=
h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23include=20<linux/=
of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=20=23include=20<=
linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/pm_runtime.h>=0D=
=0A>=20=20=23include=20<linux/thermal.h>=0D=0A>=20diff=20--git=20a/drivers/=
thermal/rcar_thermal.c=20b/drivers/thermal/rcar_thermal.c=0D=0A>=20index=20=
b8571f7090aa..293f8dd9fe0a=20100644=0D=0A>=20---=20a/drivers/thermal/rcar_t=
hermal.c=0D=0A>=20+++=20b/drivers/thermal/rcar_thermal.c=0D=0A>=20=40=40=20=
-11,7=20+11,7=20=40=40=0D=0A>=20=20=23include=20<linux/interrupt.h>=0D=0A>=
=20=20=23include=20<linux/io.h>=0D=0A>=20=20=23include=20<linux/module.h>=
=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/o=
f.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23incl=
ude=20<linux/pm_runtime.h>=0D=0A>=20=20=23include=20<linux/reboot.h>=0D=0A>=
=20diff=20--git=20a/drivers/thermal/rzg2l_thermal.c=20b/drivers/thermal/rzg=
2l_thermal.c=0D=0A>=20index=20b56981f85306..6b2bf3426f52=20100644=0D=0A>=20=
---=20a/drivers/thermal/rzg2l_thermal.c=0D=0A>=20+++=20b/drivers/thermal/rz=
g2l_thermal.c=0D=0A>=20=40=40=20-9,8=20+9,8=20=40=40=0D=0A>=20=20=23include=
=20<linux/io.h>=0D=0A>=20=20=23include=20<linux/iopoll.h>=0D=0A>=20=20=23in=
clude=20<linux/math.h>=0D=0A>=20+=23include=20<linux/mod_devicetable.h>=0D=
=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23include=20<linux/of_de=
vice.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23i=
nclude=20<linux/pm_runtime.h>=0D=0A>=20=20=23include=20<linux/reset.h>=0D=
=0A>=20diff=20--git=20a/drivers/thermal/samsung/exynos_tmu.c=0D=0A>=20b/dri=
vers/thermal/samsung/exynos_tmu.c=0D=0A>=20index=2045e5c840d130..58f4d8f7a3=
fd=20100644=0D=0A>=20---=20a/drivers/thermal/samsung/exynos_tmu.c=0D=0A>=20=
+++=20b/drivers/thermal/samsung/exynos_tmu.c=0D=0A>=20=40=40=20-15,7=20+15,=
7=20=40=40=0D=0A>=20=20=23include=20<linux/io.h>=0D=0A>=20=20=23include=20<=
linux/interrupt.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23i=
nclude=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=
=20=23include=20<linux/of_address.h>=0D=0A>=20=20=23include=20<linux/of_irq=
.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20diff=20--gi=
t=20a/drivers/thermal/sprd_thermal.c=20b/drivers/thermal/sprd_thermal.c=0D=
=0A>=20index=202fb90fdad76e..e27c4bdc8912=20100644=0D=0A>=20---=20a/drivers=
/thermal/sprd_thermal.c=0D=0A>=20+++=20b/drivers/thermal/sprd_thermal.c=0D=
=0A>=20=40=40=20-6,7=20+6,7=20=40=40=0D=0A>=20=20=23include=20<linux/iopoll=
.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20=20=23include=20<lin=
ux/nvmem-consumer.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20+=
=23include=20<linux/of.h>=0D=0A>=20=20=23include=20<linux/platform_device.h=
>=0D=0A>=20=20=23include=20<linux/slab.h>=0D=0A>=20=20=23include=20<linux/t=
hermal.h>=0D=0A>=20diff=20--git=20a/drivers/thermal/st/stm_thermal.c=0D=0A>=
=20b/drivers/thermal/st/stm_thermal.c=0D=0A>=20index=20903fcf1763f1..142a7e=
5d12f4=20100644=0D=0A>=20---=20a/drivers/thermal/st/stm_thermal.c=0D=0A>=20=
+++=20b/drivers/thermal/st/stm_thermal.c=0D=0A>=20=40=40=20-14,8=20+14,6=20=
=40=40=0D=0A>=20=20=23include=20<linux/iopoll.h>=0D=0A>=20=20=23include=20<=
linux/module.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=
=20<linux/of_address.h>=0D=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=
=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linu=
x/thermal.h>=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/thermal/sun8i_ther=
mal.c=20b/drivers/thermal/sun8i_thermal.c=0D=0A>=20index=20195f3c5d0b38..cc=
a16d632d9f=20100644=0D=0A>=20---=20a/drivers/thermal/sun8i_thermal.c=0D=0A>=
=20+++=20b/drivers/thermal/sun8i_thermal.c=0D=0A>=20=40=40=20-14,7=20+14,7=
=20=40=40=0D=0A>=20=20=23include=20<linux/interrupt.h>=0D=0A>=20=20=23inclu=
de=20<linux/module.h>=0D=0A>=20=20=23include=20<linux/nvmem-consumer.h>=0D=
=0A>=20-=23include=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/of.h=
>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=
=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/reset.h>=0D=0A>=20diff=
=20--git=20a/drivers/thermal/tegra/tegra30-tsensor.c=0D=0A>=20b/drivers/the=
rmal/tegra/tegra30-tsensor.c=0D=0A>=20index=20c243e9d76d3c..d911fa60f100=20=
100644=0D=0A>=20---=20a/drivers/thermal/tegra/tegra30-tsensor.c=0D=0A>=20++=
+=20b/drivers/thermal/tegra/tegra30-tsensor.c=0D=0A>=20=40=40=20-18,7=20+18=
,7=20=40=40=0D=0A>=20=20=23include=20<linux/iopoll.h>=0D=0A>=20=20=23includ=
e=20<linux/math.h>=0D=0A>=20=20=23include=20<linux/module.h>=0D=0A>=20-=23i=
nclude=20<linux/of_device.h>=0D=0A>=20+=23include=20<linux/of.h>=0D=0A>=20=
=20=23include=20<linux/platform_device.h>=0D=0A>=20=20=23include=20<linux/p=
m.h>=0D=0A>=20=20=23include=20<linux/reset.h>=0D=0A>=20diff=20--git=20a/dri=
vers/thermal/thermal_of.c=20b/drivers/thermal/thermal_of.c=20index=0D=0A>=
=206fb14e521197..c36c7d235cba=20100644=0D=0A>=20---=20a/drivers/thermal/the=
rmal_of.c=0D=0A>=20+++=20b/drivers/thermal/thermal_of.c=0D=0A>=20=40=40=20-=
10,8=20+10,7=20=40=40=0D=0A>=20=0D=0A>=20=20=23include=20<linux/err.h>=0D=
=0A>=20=20=23include=20<linux/export.h>=0D=0A>=20-=23include=20<linux/of_de=
vice.h>=0D=0A>=20-=23include=20<linux/of_platform.h>=0D=0A>=20+=23include=
=20<linux/of.h>=0D=0A>=20=20=23include=20<linux/slab.h>=0D=0A>=20=20=23incl=
ude=20<linux/thermal.h>=0D=0A>=20=20=23include=20<linux/types.h>=0D=0A>=20d=
iff=20--git=20a/drivers/thermal/uniphier_thermal.c=0D=0A>=20b/drivers/therm=
al/uniphier_thermal.c=0D=0A>=20index=20aef6119cc004..6f32ab61d174=20100644=
=0D=0A>=20---=20a/drivers/thermal/uniphier_thermal.c=0D=0A>=20+++=20b/drive=
rs/thermal/uniphier_thermal.c=0D=0A>=20=40=40=20-12,7=20+12,6=20=40=40=0D=
=0A>=20=20=23include=20<linux/mfd/syscon.h>=0D=0A>=20=20=23include=20<linux=
/module.h>=0D=0A>=20=20=23include=20<linux/of.h>=0D=0A>=20-=23include=20<li=
nux/of_device.h>=0D=0A>=20=20=23include=20<linux/platform_device.h>=0D=0A>=
=20=20=23include=20<linux/regmap.h>=0D=0A>=20=20=23include=20<linux/thermal=
.h>=0D=0A>=20--=0D=0A>=202.40.1=0D=0A=0D=0A=0D=0A
