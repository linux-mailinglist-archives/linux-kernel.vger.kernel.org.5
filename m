Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63CF7F9AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjK0HbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0HbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:31:08 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1334E1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:31:11 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231127073110epoutp03871ae00ca313dd183d4b4b1f6fc597b1~bamXl3_zc0419604196epoutp03Z
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:31:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231127073110epoutp03871ae00ca313dd183d4b4b1f6fc597b1~bamXl3_zc0419604196epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701070270;
        bh=/O7GxW4+OPp3iltiCjpDj2tV+gbFG4XP70pxdSz2jC0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=D9qSeFpqYh+2Xs5HD14tiNbi2vGyXLvG2QX8pi574ndpQKmjlYa6dV1euWLN0Cy4k
         hRk5N5YXnWh+dKU1Lr8nQm3IZG2DyPLXtpTUgkuI43m7CAeRdS7Ox5vWpbmslOOAnv
         eCs9xUt/O0MDKcQa6LZQe8TG5MuBYEcTU+UTgW6s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231127073109epcas5p23dfbea83edaed63d60886d785aeadc5c~bamW-KVrZ0286702867epcas5p2R;
        Mon, 27 Nov 2023 07:31:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sdy1l5Jrfz4x9QQ; Mon, 27 Nov
        2023 07:31:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.95.10009.BB544656; Mon, 27 Nov 2023 16:31:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231127070013epcas5p4e967991cccb1908ddf010ec13e758d27~baLWtSliN3195231952epcas5p4j;
        Mon, 27 Nov 2023 07:00:13 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231127070013epsmtrp223d6e8de69b418d4a77ab914f7b707f4~baLWr9ppJ0136401364epsmtrp2N;
        Mon, 27 Nov 2023 07:00:13 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-f8-656445bbd991
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.9B.07368.D7E34656; Mon, 27 Nov 2023 16:00:13 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231127070009epsmtip2ee6eb1275ef80b60cbb58bcc79c204e8~baLTMJN6S2484424844epsmtip2u;
        Mon, 27 Nov 2023 07:00:09 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Nicolas Dufresne'" <nicolas@ndufresne.ca>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <krzysztof.kozlowski+dt@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <andi@etezian.org>,
        <gost.dev@samsung.com>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <ajaykumar.rs@samsung.com>, <linux-fsd@tesla.com>,
        "'Smitha T Murthy'" <smithatmurthy@gmail.com>
In-Reply-To: <c49c871d2fecd82b73d255cea575d231827245ba.camel@ndufresne.ca>
Subject: RE: [Patch v4 04/11] media: s5p-mfc: Add YV12 and I420 multiplanar
 format support
Date:   Mon, 27 Nov 2023 12:30:08 +0530
Message-ID: <0fe401da20ff$5e47e410$1ad7ac30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQIF15oBArq90LwDAvliPK42GgUg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzmPtpbWAt3WMOBMYd3aoYGaBW6wwbOB+qNkkC2bDhHUpv2Dgil
        bdrilG2BqUzF4kYCQZpSmSBjWIYrlneXymMNjQ/wgeB4iwHF6KDo0Mm20paN/77f73zf+X7f
        7+RwsMAyIoSTodAyaoVETrH98MbO8Hci2nbJGEHv6Q3Q9vQKDseMjWxYuTCFwtFKJw47GiwE
        NFmvo/BHu40Fz3VdZ8GmKxM4HLS1oLCvbBiHZ6bHMWi+38+C449S4K1WAxvqLllY8OyNX1FY
        1zVMwAt3+1BYbX6FwjlHCwbPW+YJmG/tIuDxb6pY2wBtMpoQ+m7VHEa36IcJurL9IUqba0+x
        6aH+djbdUJVLN0yfxuj87pc4feZyLUL/fbScoJ3mNbTjmZNI5h3IjEtnJDJGHcYopEpZhiIt
        ntr3kXinOEYkEEYIY+G7VJhCksXEUwmJyRG7M+SuDVBhhyTybFcrWaLRUFFb49TKbC0Tlq7U
        aOMpRiWTq6JVkRpJliZbkRapYLTvCQWCzTEu4sHM9NmJNpaq+xJ22GbZn4cMVWEFiC8HkNGg
        rsFBFCB+nECyDQEj1lHMU8whYKZmhO0pniPAftzMWpaMdZayPAdWBPT9ZvfqpxDQ/7wFWWKx
        ySgw6tC5WXyyGQHONoubhZE/4aCpy8ReYvmSe8Girtx97yoyFeRN33RjnFwPnBajaxIOh0fG
        gt4C8VKbR74Oesom8SWMkZtA9Q8z3hRh4MWDareUT+4GJ0pfsjycIND9QucOBMibvqD12gLq
        ESSAorkpwoNXgUf2y14cApxPrGwPloL75x96DeSgvr0Y9+APgO22AV+aDSPDQX1rlKf9Jihx
        /Ix6fP1B4V+TXiseaDYu4w3AMLTgXWMo6Lx4AfkeofQroulXRNOviKD/360CwWuRYEalyUpj
        NDGqzQrmi//eXKrMMiPuP7JxbzMyPvZHZAeCcpAOBHAwis+LnJUygTyZ5EgOo1aK1dlyRtOB
        xLjWXYSFrJYqXZ9MoRULo2MF0SKRKDp2i0hIBfFm8stlgWSaRMtkMoyKUS/rUI5vSB7KjzNK
        J6b25X7un3XQkBv8OMhQ3zApqFFBwXzkfu7tq5u+OnVCln9uC78ixqcwY/CVLjfY8uXItDF/
        +56TtSMVXEoKkmdFGfNzg70V/HULobeuHr3z9cSaUGFeglNZ7HibE7SjYNTZNHHD5v+dL5MU
        f2/2NYPVssd/e89TxdpSbriP/1rQ09f4ccm3o5/dW59YpyldrU/ZZbUXGwYuvp+nj9HxdazC
        nHb7QNOxfxLqD+ew7swPl9T3c00B204uEqaBx6k48mHAofnf3wjX2X2Qs/RbkwF+z8R/Di0+
        +IUbl3ikhtj6adGapHVPnOMHUnk8urB3ljy2s98ylZRyzVHG/YTCNekS4UZMrZH8C1vk5n2s
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZdlhJXrfWLiXVYPEpVYsD7w+yWDyYt43N
        YvGP50wW9xd/ZrE4tHkru8WaveeYLJYfP8BqMf/IOVaL7QcfsVjcPLCTyeLizLssFn0vHjJb
        bHp8jdXi4atwi8u75rBZ9GzYymox4/w+Jou1R+6yWyy9fpHJYtmmP0wWn07tZLZYtPULu0Xr
        3iPsFi2NS1gdJDzWzFvD6HF9ySdmj52z7rJ7LN7zkslj06pONo871/aweWxeUu+x+UU3s0fr
        0V8sHn1bVjF6/Guay+7xeZOcx6mvn9kDeKO4bFJSczLLUov07RK4Mu5sWsBWMHM5U8XJqVPZ
        Ghg3vWPsYuTkkBAwkXhweDprFyMXh5DAbkaJXfdusEAkZCT+tx1jh7CFJVb+e84OUfSUUeLX
        qylg3WwC+hL3T/WAdYsI7GGUWL59FxtIgllgN4vEgbuSEB3/GSW2zvgENpZTwEvib89cVhBb
        WCBK4sTFF2BxFgFVic9b5zF3MXJw8ApYSlzoigcJ8woISpyc+YQFYqa2xNObT+HsZQtfM0Nc
        pyDx8+kysJEiAm4S7dN/sULUiEsc/dnDPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucm
        GxYY5qWW6xUn5haX5qXrJefnbmIEpxItjR2M9+b/0zvEyMTBeIhRgoNZSYRX72NyqhBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE0hNLUrNTUwtSi2CyTBycUg1MR95eiJe98l5d1nbO
        nQ7eLfPU/px4VCK/KbdX0dghJbFtdbdF/MaL+ROns2w20tqTcuS3K7fdTIX6dcePb/t9PWf9
        0T+KX3Juihk5rEq1cb7N/NIn8pH7v2nntuxLsmZQztrnHFBr/5mdX2L+bJHjMbpbz+1n3rZ2
        p1RC2cyUO+tFpqorzjLIMz9Q5LjTXvbIr+nH54cLPBHVTYsveOM0dylX3craW6x625SMpov4
        N5wOXSvl4vMnWO2HtOSRD87ezl96Wr+zC0xseV527Fp/zkev5bFGbH8Df/dYHvhh0hyV5Wpy
        8LfLFh6uhuCsmeFCLz5Jhc6x8NH4u156z0+HuBT3jUsrFPZ3PQms9rVWYinOSDTUYi4qTgQA
        SQo3qpQDAAA=
X-CMS-MailID: 20231127070013epcas5p4e967991cccb1908ddf010ec13e758d27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102243epcas5p1cdd0eb385d2381943d6d194eec3a569d
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102243epcas5p1cdd0eb385d2381943d6d194eec3a569d@epcas5p1.samsung.com>
        <20231025102216.50480-5-aakarsh.jain@samsung.com>
        <c49c871d2fecd82b73d255cea575d231827245ba.camel@ndufresne.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> -----Original Message-----
> From: Nicolas Dufresne <nicolas=40ndufresne.ca>
> Sent: 23 November 2023 22:56
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> krzysztof.kozlowski+dt=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; conor+dt=40kernel.org; linux-samsung-
> soc=40vger.kernel.org; andi=40etezian.org; gost.dev=40samsung.com;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; ajaykumar.rs=40samsung.com; linux-
> fsd=40tesla.com; Smitha T Murthy <smithatmurthy=40gmail.com>
> Subject: Re: =5BPatch v4 04/11=5D media: s5p-mfc: Add YV12 and I420 multi=
planar
> format support
>=20
> Le mercredi 25 octobre 2023 =C3=A0=2015:52=20+0530,=20Aakarsh=20Jain=20a=
=20=C3=A9crit=20:=0D=0A>=20>=20YV12=20and=20I420=20format=20(3-plane)=20sup=
port=20is=20added.=20Stride=20information=20is=0D=0A>=20>=20added=20to=20al=
l=20formats=20and=20planes=20since=20it=20is=20necessary=20for=20YV12/I420=
=0D=0A>=20>=20which=20are=20different=20from=20width.=0D=0A>=20>=0D=0A>=20>=
=20Cc:=20linux-fsd=40tesla.com=0D=0A>=20>=20Signed-off-by:=20Smitha=20T=20M=
urthy=20<smithatmurthy=40gmail.com>=0D=0A>=20>=20Signed-off-by:=20Aakarsh=
=20Jain=20<aakarsh.jain=40samsung.com>=0D=0A>=20>=20---=0D=0A>=20>=20=20...=
/platform/samsung/s5p-mfc/regs-mfc-v12.h=20=20=20=7C=20=20=202=20+=0D=0A>=
=20>=20=20.../platform/samsung/s5p-mfc/regs-mfc-v7.h=20=20=20=20=7C=20=20=
=201=20+=0D=0A>=20>=20=20.../platform/samsung/s5p-mfc/regs-mfc-v8.h=20=20=
=20=20=7C=20=20=203=20+=0D=0A>=20>=20=20.../platform/samsung/s5p-mfc/s5p_mf=
c_common.h=20=7C=20=20=204=20+=0D=0A>=20>=20=20.../platform/samsung/s5p-mfc=
/s5p_mfc_dec.c=20=20=20=20=7C=20=2045=20++++-=0D=0A>=20>=20=20.../platform/=
samsung/s5p-mfc/s5p_mfc_enc.c=20=20=20=20=7C=20=2086=20+++++++--=0D=0A>=20>=
=20=20.../platform/samsung/s5p-mfc/s5p_mfc_opr.h=20=20=20=20=7C=20=20=206=
=20+-=0D=0A>=20>=20=20.../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c=20=7C=
=20=2012=20+-=0D=0A>=20>=20.../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c=20=
=7C=20168=0D=0A>=20+++++++++++++++---=0D=0A>=20>=20=209=20files=20changed,=
=20281=20insertions(+),=2046=20deletions(-)=0D=0A>=20>=0D=0A>=20>=20diff=20=
--git=20a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h=0D=0A>=20>=
=20b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h=0D=0A>=20>=20ind=
ex=206c68a45082d0..70464f47c1f9=20100644=0D=0A>=20>=20---=20a/drivers/media=
/platform/samsung/s5p-mfc/regs-mfc-v12.h=0D=0A>=20>=20+++=20b/drivers/media=
/platform/samsung/s5p-mfc/regs-mfc-v12.h=0D=0A>=20>=20=40=40=20-26,6=20+26,=
8=20=40=40=0D=0A>=20>=20=20=23define=20MFC_VERSION_V12=09=09=090xC0=0D=0A>=
=20>=20=20=23define=20MFC_NUM_PORTS_V12=09=091=0D=0A>=20>=20=20=23define=20=
S5P_FIMV_CODEC_VP9_ENC=09=0927=0D=0A>=20>=20+=23define=20MFC_CHROMA_PAD_BYT=
ES_V12=20=20=20=20=20=20=20=20256=0D=0A>=20>=20+=23define=20S5P_FIMV_D_ALIG=
N_PLANE_SIZE_V12=20256=0D=0A>=20>=0D=0A>=20>=20=20/*=20Encoder=20buffer=20s=
ize=20for=20MFCv12=20*/=0D=0A>=20>=20=20=23define=20ENC_V120_BASE_SIZE(x,=
=20y)=20=5C=0D=0A>=20>=20diff=20--git=20a/drivers/media/platform/samsung/s5=
p-mfc/regs-mfc-v7.h=0D=0A>=20>=20b/drivers/media/platform/samsung/s5p-mfc/r=
egs-mfc-v7.h=0D=0A>=20>=20index=204a7adfdaa359..50f9bf0603c1=20100644=0D=0A=
>=20>=20---=20a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h=0D=0A>=
=20>=20+++=20b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h=0D=0A>=
=20>=20=40=40=20-24,6=20+24,7=20=40=40=0D=0A>=20>=0D=0A>=20>=20=20=23define=
=20S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7=0D=0A>=20=090xfa70=0D=0A>=20>=20=
=20=23define=20S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7=0D=0A>=20=090xfa74=
=0D=0A>=20>=20+=23define=20S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7=0D=0A>=
=20=090xfa78=0D=0A>=20>=0D=0A>=20>=20=20=23define=20S5P_FIMV_E_VP8_OPTIONS_=
V7=09=09=090xfdb0=0D=0A>=20>=20=20=23define=20S5P_FIMV_E_VP8_FILTER_OPTIONS=
_V7=09=090xfdb4=0D=0A>=20>=20diff=20--git=20a/drivers/media/platform/samsun=
g/s5p-mfc/regs-mfc-v8.h=0D=0A>=20>=20b/drivers/media/platform/samsung/s5p-m=
fc/regs-mfc-v8.h=0D=0A>=20>=20index=20162e3c7e920f..0ef9eb2dff22=20100644=
=0D=0A>=20>=20---=20a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h=
=0D=0A>=20>=20+++=20b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h=
=0D=0A>=20>=20=40=40=20-17,13=20+17,16=20=40=40=0D=0A>=20>=20=20=23define=
=20S5P_FIMV_D_MIN_SCRATCH_BUFFER_SIZE_V8=090xf108=0D=0A>=20>=20=20=23define=
=20S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8=090xf144=0D=0A>=20>=20=20=23define=20=
S5P_FIMV_D_SECOND_PLANE_DPB_SIZE_V8=090xf148=0D=0A>=20>=20+=23define=20S5P_=
FIMV_D_THIRD_PLANE_DPB_SIZE_V8=090xf14C=0D=0A>=20>=20=20=23define=20S5P_FIM=
V_D_MV_BUFFER_SIZE_V8=09=090xf150=0D=0A>=20>=0D=0A>=20>=20=20=23define=20S5=
P_FIMV_D_FIRST_PLANE_DPB_STRIDE_SIZE_V8=090xf138=0D=0A>=20>=20=20=23define=
=20S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8=0D=0A>=20=090xf13c=0D=0A>=20>=
=20+=23define=20S5P_FIMV_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8=0D=0A>=20=090xf14=
0=0D=0A>=20>=0D=0A>=20>=20=20=23define=20S5P_FIMV_D_FIRST_PLANE_DPB_V8=09=
=090xf160=0D=0A>=20>=20=20=23define=20S5P_FIMV_D_SECOND_PLANE_DPB_V8=09=090=
xf260=0D=0A>=20>=20+=23define=20S5P_FIMV_D_THIRD_PLANE_DPB_V8=09=090xf360=
=0D=0A>=20>=20=20=23define=20S5P_FIMV_D_MV_BUFFER_V8=09=09=090xf460=0D=0A>=
=20>=0D=0A>=20>=20=20=23define=20S5P_FIMV_D_NUM_MV_V8=09=09=090xf134=0D=0A>=
=20>=20diff=20--git=20a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_comm=
on.h=0D=0A>=20>=20b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h=
=0D=0A>=20>=20index=20dd2e9f7704ab..9a39cccfe002=20100644=0D=0A>=20>=20---=
=20a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h=0D=0A>=20>=20+=
++=20b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h=0D=0A>=20>=
=20=40=40=20-56,6=20+56,7=20=40=40=0D=0A>=20>=20=20=23define=20MFC_NO_INSTA=
NCE_SET=09-1=0D=0A>=20>=20=20=23define=20MFC_ENC_CAP_PLANE_COUNT=091=0D=0A>=
=20>=20=20=23define=20MFC_ENC_OUT_PLANE_COUNT=092=0D=0A>=20>=20+=23define=
=20VB2_MAX_PLANE_COUNT=093=0D=0A>=20>=20=20=23define=20STUFF_BYTE=09=094=0D=
=0A>=20>=20=20=23define=20MFC_MAX_CTRLS=09=09128=0D=0A>=20>=0D=0A>=20>=20=
=40=40=20-181,6=20+182,7=20=40=40=20struct=20s5p_mfc_buf=20=7B=0D=0A>=20>=
=20=20=09=09struct=20=7B=0D=0A>=20>=20=20=09=09=09size_t=20luma;=0D=0A>=20>=
=20=20=09=09=09size_t=20chroma;=0D=0A>=20>=20+=09=09=09size_t=20chroma_1;=
=0D=0A>=20>=20=20=09=09=7D=20raw;=0D=0A>=20>=20=20=09=09size_t=20stream;=0D=
=0A>=20>=20=20=09=7D=20cookie;=0D=0A>=20>=20=40=40=20-657,6=20+659,7=20=40=
=40=20struct=20s5p_mfc_ctx=20=7B=0D=0A>=20>=0D=0A>=20>=20=20=09int=20luma_s=
ize;=0D=0A>=20>=20=20=09int=20chroma_size;=0D=0A>=20>=20+=09int=20chroma_si=
ze_1;=0D=0A>=20>=20=20=09int=20mv_size;=0D=0A>=20>=0D=0A>=20>=20=20=09unsig=
ned=20long=20consumed_stream;=0D=0A>=20>=20=40=40=20-722,6=20+725,7=20=40=
=40=20struct=20s5p_mfc_ctx=20=7B=0D=0A>=20>=20=20=09size_t=20scratch_buf_si=
ze;=0D=0A>=20>=20=20=09int=20is_10bit;=0D=0A>=20>=20=20=09int=20is_422;=0D=
=0A>=20>=20+=09int=20stride=5BVB2_MAX_PLANE_COUNT=5D;=0D=0A>=20>=20=20=7D;=
=0D=0A>=20>=0D=0A>=20>=20=20/*=0D=0A>=20>=20diff=20--git=20a/drivers/media/=
platform/samsung/s5p-mfc/s5p_mfc_dec.c=0D=0A>=20>=20b/drivers/media/platfor=
m/samsung/s5p-mfc/s5p_mfc_dec.c=0D=0A>=20>=20index=20e219cbcd86d5..317f796f=
ffa1=20100644=0D=0A>=20>=20---=20a/drivers/media/platform/samsung/s5p-mfc/s=
5p_mfc_dec.c=0D=0A>=20>=20+++=20b/drivers/media/platform/samsung/s5p-mfc/s5=
p_mfc_dec.c=0D=0A>=20>=20=40=40=20-56,6=20+56,20=20=40=40=20static=20struct=
=20s5p_mfc_fmt=20formats=5B=5D=20=3D=20=7B=0D=0A>=20>=20=20=09=09.num_plane=
s=09=3D=202,=0D=0A>=20>=20=20=09=09.versions=09=3D=20MFC_V6PLUS_BITS,=0D=0A=
>=20>=20=20=09=7D,=0D=0A>=20>=20+=09=7B=0D=0A>=20>=20+=09=09.fourcc=20=20=
=20=20=20=20=20=20=20=3D=20V4L2_PIX_FMT_YUV420M,=0D=0A>=20>=20+=09=09.codec=
_mode=20=20=20=20=20=3D=20S5P_MFC_CODEC_NONE,=0D=0A>=20>=20+=09=09.type=20=
=20=20=20=20=20=20=20=20=20=20=3D=20MFC_FMT_RAW,=0D=0A>=20>=20+=09=09.num_p=
lanes=20=20=20=20=20=3D=203,=0D=0A>=20>=20+=09=09.versions=20=20=20=20=20=
=20=20=3D=20MFC_V12_BIT,=0D=0A>=20>=20+=09=7D,=0D=0A>=20>=20+=09=7B=0D=0A>=
=20>=20+=09=09.fourcc=20=20=20=20=20=20=20=20=20=3D=20V4L2_PIX_FMT_YVU420M,=
=0D=0A>=20>=20+=09=09.codec_mode=20=20=20=20=20=3D=20S5P_MFC_CODEC_NONE,=0D=
=0A>=20>=20+=09=09.type=20=20=20=20=20=20=20=20=20=20=20=3D=20MFC_FMT_RAW,=
=0D=0A>=20>=20+=09=09.num_planes=20=20=20=20=20=3D=203,=0D=0A>=20>=20+=09=
=09.versions=20=20=20=20=20=20=20=3D=20MFC_V12_BIT=0D=0A>=20>=20+=09=7D,=0D=
=0A>=20>=20=20=09=7B=0D=0A>=20>=20=20=09=09.fourcc=09=09=3D=20V4L2_PIX_FMT_=
H264,=0D=0A>=20>=20=20=09=09.codec_mode=09=3D=20S5P_MFC_CODEC_H264_DEC,=0D=
=0A>=20>=20=40=40=20-359,10=20+373,15=20=40=40=20static=20int=20vidioc_g_fm=
t(struct=20file=20*file,=20void=20*priv,=0D=0A>=20struct=20v4l2_format=20*f=
)=0D=0A>=20>=20=20=09=09/*=20Set=20pixelformat=20to=20the=20format=20in=20w=
hich=20MFC=0D=0A>=20>=20=20=09=09=20=20=20outputs=20the=20decoded=20frame=
=20*/=0D=0A>=20>=20=20=09=09pix_mp->pixelformat=20=3D=20ctx->dst_fmt->fourc=
c;=0D=0A>=20>=20-=09=09pix_mp->plane_fmt=5B0=5D.bytesperline=20=3D=20ctx->b=
uf_width;=0D=0A>=20>=20+=09=09pix_mp->plane_fmt=5B0=5D.bytesperline=20=3D=
=20ctx->stride=5B0=5D;=0D=0A>=20>=20=20=09=09pix_mp->plane_fmt=5B0=5D.sizei=
mage=20=3D=20ctx->luma_size;=0D=0A>=20>=20-=09=09pix_mp->plane_fmt=5B1=5D.b=
ytesperline=20=3D=20ctx->buf_width;=0D=0A>=20>=20+=09=09pix_mp->plane_fmt=
=5B1=5D.bytesperline=20=3D=20ctx->stride=5B1=5D;=0D=0A>=20>=20=20=09=09pix_=
mp->plane_fmt=5B1=5D.sizeimage=20=3D=20ctx->chroma_size;=0D=0A>=20>=20+=09=
=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=
=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT=
_YVU420M)=20=7B=0D=0A>=20>=20+=09=09=09pix_mp->plane_fmt=5B2=5D.bytesperlin=
e=20=3D=20ctx->stride=5B2=5D;=0D=0A>=20>=20+=09=09=09pix_mp->plane_fmt=5B2=
=5D.sizeimage=20=3D=20ctx-=0D=0A>=20>chroma_size_1;=0D=0A>=20>=20+=09=09=7D=
=0D=0A>=20>=20=20=09=7D=20else=20if=20(f->type=20=3D=3D=20V4L2_BUF_TYPE_VID=
EO_OUTPUT_MPLANE)=20=7B=0D=0A>=20>=20=20=09=09/*=20This=20is=20run=20on=20O=
UTPUT=0D=0A>=20>=20=20=09=09=20=20=20The=20buffer=20contains=20compressed=
=20image=20=40=40=20-937,6=20+956,9=0D=0A>=20=40=40=20static=0D=0A>=20>=20i=
nt=20s5p_mfc_queue_setup(struct=20vb2_queue=20*vq,=0D=0A>=20>=20=20=09=09=
=20=20=20vq->type=20=3D=3D=20V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)=20=7B=0D=
=0A>=20>=20=20=09=09/*=20Output=20plane=20count=20is=202=20-=20one=20for=20=
Y=20and=20one=20for=20CbCr=20*/=0D=0A>=20>=20=20=09=09*plane_count=20=3D=20=
2;=0D=0A>=20>=20+=09=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_Y=
UV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=
=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=09*plane_count=20=3D=203;=
=0D=0A>=20=0D=0A>=20I=20don't=20usually=20interfere,=20this=20is=20your=20d=
river=20to=20maintain,=20but=20this=20becomes=0D=0A>=20horribly=20messy.=20=
Have=20you=20consider=20de-hardcoding=20a=20little=20and=20encapsulate=20pe=
r=0D=0A>=20HW=20format=20details=20into=20a=20C=20structure=20?=20Drivers=
=20these=20days=20try=20to=20make=20sure=20of=0D=0A>=20v4l2-=20common=20lib=
rary,=20which=20as=20a=20matter=20of=20fact=20knows=20that=20YUV420M=20and=
=0D=0A>=20YVU420M=20have=203=20places,=20so=20that=20you=20don't=20have=20t=
o=20duplicate=20it=20in=20your=20driver.=0D=0A>=20=0D=0A>=20regards,=0D=0A>=
=20Nicolas=0D=0A=0D=0AThanks=20for=20pointing=20out.=0D=0AWe=20could=20have=
=20done=20it=20in=20this=20way=20'=20*plane_count=20=3D=20ctx->dst_fmt->num=
_planes'=20also.=0D=0AAnyway,=20will=20make=20use=20of=20'=20v4l2-=20common=
=20library=20'=20for=20getting=20the=20planes=20count=20here=20in=20next=20=
series.=0D=0A=0D=0AThanks=20for=20the=20review.=0D=0A>=20=0D=0A>=20>=20=20=
=09=09/*=20Setup=20buffer=20count=20*/=0D=0A>=20>=20=20=09=09if=20(*buf_cou=
nt=20<=20ctx->pb_count)=0D=0A>=20>=20=20=09=09=09*buf_count=20=3D=20ctx->pb=
_count;=0D=0A>=20>=20=40=40=20-955,12=20+977,17=20=40=40=20static=20int=20s=
5p_mfc_queue_setup(struct=0D=0A>=20vb2_queue=20*vq,=0D=0A>=20>=20=20=09=20=
=20=20=20vq->type=20=3D=3D=20V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)=20=7B=0D=
=0A>=20>=20=20=09=09psize=5B0=5D=20=3D=20ctx->luma_size;=0D=0A>=20>=20=20=
=09=09psize=5B1=5D=20=3D=20ctx->chroma_size;=0D=0A>=20>=20-=0D=0A>=20>=20+=
=09=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=
=0D=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_=
FMT_YVU420M)=0D=0A>=20>=20+=09=09=09psize=5B2=5D=20=3D=20ctx->chroma_size_1=
;=0D=0A>=20>=20=20=09=09if=20(IS_MFCV6_PLUS(dev))=0D=0A>=20>=20=20=09=09=09=
alloc_devs=5B0=5D=20=3D=20ctx->dev->mem_dev=5BBANK_L_CTX=5D;=0D=0A>=20>=20=
=20=09=09else=0D=0A>=20>=20=20=09=09=09alloc_devs=5B0=5D=20=3D=20ctx->dev->=
mem_dev=5BBANK_R_CTX=5D;=0D=0A>=20>=20=20=09=09alloc_devs=5B1=5D=20=3D=20ct=
x->dev->mem_dev=5BBANK_L_CTX=5D;=0D=0A>=20>=20+=09=09if=20(ctx->dst_fmt->fo=
urcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx=
->dst_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=
=09=09alloc_devs=5B2=5D=20=3D=20ctx->dev->mem_dev=5BBANK_L_CTX=5D;=0D=0A>=
=20>=20=20=09=7D=20else=20if=20(vq->type=20=3D=3D=20V4L2_BUF_TYPE_VIDEO_OUT=
PUT_MPLANE=20&&=0D=0A>=20>=20=20=09=09=20=20=20ctx->state=20=3D=3D=20MFCINS=
T_INIT)=20=7B=0D=0A>=20>=20=20=09=09psize=5B0=5D=20=3D=20ctx->dec_src_buf_s=
ize;=0D=0A>=20>=20=40=40=20-994,12=20+1021,24=20=40=40=20static=20int=20s5p=
_mfc_buf_init(struct=20vb2_buffer=0D=0A>=20*vb)=0D=0A>=20>=20=20=09=09=09mf=
c_err(=22Plane=20buffer=20(CAPTURE)=20is=20too=20small=5Cn=22);=0D=0A>=20>=
=20=20=09=09=09return=20-EINVAL;=0D=0A>=20>=20=20=09=09=7D=0D=0A>=20>=20+=
=09=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=
=0D=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_=
FMT_YVU420M)=20=7B=0D=0A>=20>=20+=09=09=09if=20(vb2_plane_size(vb,=202)=20<=
=20ctx->chroma_size_1)=20=7B=0D=0A>=20>=20+=09=09=09=09mfc_err(=22Plane=20b=
uffer=20(CAPTURE)=20is=20too=0D=0A>=20small=5Cn=22);=0D=0A>=20>=20+=09=09=
=09=09return=20-EINVAL;=0D=0A>=20>=20+=09=09=09=7D=0D=0A>=20>=20+=09=09=7D=
=0D=0A>=20>=20=20=09=09i=20=3D=20vb->index;=0D=0A>=20>=20=20=09=09ctx->dst_=
bufs=5Bi=5D.b=20=3D=20vbuf;=0D=0A>=20>=20=20=09=09ctx->dst_bufs=5Bi=5D.cook=
ie.raw.luma=20=3D=0D=0A>=20>=0D=0A>=20=09vb2_dma_contig_plane_dma_addr(vb,=
=200);=0D=0A>=20>=20=20=09=09ctx->dst_bufs=5Bi=5D.cookie.raw.chroma=20=3D=
=0D=0A>=20>=0D=0A>=20=09vb2_dma_contig_plane_dma_addr(vb,=201);=0D=0A>=20>=
=20+=09=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=
=7C=0D=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_P=
IX_FMT_YVU420M)=20=7B=0D=0A>=20>=20+=09=09=09ctx->dst_bufs=5Bi=5D.cookie.ra=
w.chroma_1=20=3D=0D=0A>=20>=20+=0D=0A>=20=09vb2_dma_contig_plane_dma_addr(v=
b,=202);=0D=0A>=20>=20+=09=09=7D=0D=0A>=20>=20=20=09=09ctx->dst_bufs_cnt++;=
=0D=0A>=20>=20=20=09=7D=20else=20if=20(vq->type=20=3D=3D=20V4L2_BUF_TYPE_VI=
DEO_OUTPUT_MPLANE)=20=7B=0D=0A>=20>=20=20=09=09if=20(IS_ERR_OR_NULL(ERR_PTR=
(=0D=0A>=20>=20diff=20--git=20a/drivers/media/platform/samsung/s5p-mfc/s5p_=
mfc_enc.c=0D=0A>=20>=20b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc=
.c=0D=0A>=20>=20index=20e4d6e7c117b5..0eec04eb3ef3=20100644=0D=0A>=20>=20--=
-=20a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c=0D=0A>=20>=20+++=
=20b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c=0D=0A>=20>=20=40=
=40=20-59,6=20+59,20=20=40=40=20static=20struct=20s5p_mfc_fmt=20formats=5B=
=5D=20=3D=20=7B=0D=0A>=20>=20=20=09=09.num_planes=09=3D=202,=0D=0A>=20>=20=
=20=09=09.versions=09=3D=20MFC_V6PLUS_BITS,=0D=0A>=20>=20=20=09=7D,=0D=0A>=
=20>=20+=09=7B=0D=0A>=20>=20+=09=09.fourcc=20=20=20=20=20=20=20=20=20=3D=20=
V4L2_PIX_FMT_YUV420M,=0D=0A>=20>=20+=09=09.codec_mode=20=20=20=20=20=3D=20S=
5P_MFC_CODEC_NONE,=0D=0A>=20>=20+=09=09.type=20=20=20=20=20=20=20=20=20=20=
=20=3D=20MFC_FMT_RAW,=0D=0A>=20>=20+=09=09.num_planes=20=20=20=20=20=3D=203=
,=0D=0A>=20>=20+=09=09.versions=20=20=20=20=20=20=20=3D=20MFC_V12_BIT,=0D=
=0A>=20>=20+=09=7D,=0D=0A>=20>=20+=09=7B=0D=0A>=20>=20+=09=09.fourcc=20=20=
=20=20=20=20=20=20=20=3D=20V4L2_PIX_FMT_YVU420M,=0D=0A>=20>=20+=09=09.codec=
_mode=20=20=20=20=20=3D=20S5P_MFC_CODEC_NONE,=0D=0A>=20>=20+=09=09.type=20=
=20=20=20=20=20=20=20=20=20=20=3D=20MFC_FMT_RAW,=0D=0A>=20>=20+=09=09.num_p=
lanes=20=20=20=20=20=3D=203,=0D=0A>=20>=20+=09=09.versions=20=20=20=20=20=
=20=20=3D=20MFC_V12_BIT,=0D=0A>=20>=20+=09=7D,=0D=0A>=20>=20=20=09=7B=0D=0A=
>=20>=20=20=09=09.fourcc=09=09=3D=20V4L2_PIX_FMT_H264,=0D=0A>=20>=20=20=09=
=09.codec_mode=09=3D=20S5P_MFC_CODEC_H264_ENC,=0D=0A>=20>=20=40=40=20-1193,=
14=20+1207,20=20=40=40=20static=20int=20enc_pre_frame_start(struct=0D=0A>=
=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09struct=20s5p_mfc_dev=20*dev=20=3D=
=20ctx->dev;=0D=0A>=20>=20=20=09struct=20s5p_mfc_buf=20*dst_mb;=0D=0A>=20>=
=20=20=09struct=20s5p_mfc_buf=20*src_mb;=0D=0A>=20>=20-=09unsigned=20long=
=20src_y_addr,=20src_c_addr,=20dst_addr;=0D=0A>=20>=20+=09unsigned=20long=
=20src_y_addr,=20src_c_addr,=20src_c_1_addr,=20dst_addr;=0D=0A>=20>=20=20=
=09unsigned=20int=20dst_size;=0D=0A>=20>=0D=0A>=20>=20=20=09src_mb=20=3D=20=
list_entry(ctx->src_queue.next,=20struct=20s5p_mfc_buf,=20list);=0D=0A>=20>=
=20=20=09src_y_addr=20=3D=20vb2_dma_contig_plane_dma_addr(&src_mb->b-=0D=0A=
>=20>vb2_buf,=200);=0D=0A>=20>=20=20=09src_c_addr=20=3D=20vb2_dma_contig_pl=
ane_dma_addr(&src_mb->b-=0D=0A>=20>vb2_buf,=201);=0D=0A>=20>=20+=09if=20(ct=
x->src_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=
=09=09=09ctx->src_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=
=20+=09=09src_c_1_addr=20=3D=0D=0A>=20>=20+=09=09=09vb2_dma_contig_plane_dm=
a_addr(&src_mb->b-=0D=0A>=20>vb2_buf,=202);=0D=0A>=20>=20+=09else=0D=0A>=20=
>=20+=09=09src_c_1_addr=20=3D=200;=0D=0A>=20>=20=20=09s5p_mfc_hw_call(dev->=
mfc_ops,=20set_enc_frame_buffer,=20ctx,=0D=0A>=20>=20-=09=09=09=09=09=09=09=
src_y_addr,=0D=0A>=20src_c_addr);=0D=0A>=20>=20+=09=09=09=09=09src_y_addr,=
=20src_c_addr,=0D=0A>=20src_c_1_addr);=0D=0A>=20>=0D=0A>=20>=20=20=09dst_mb=
=20=3D=20list_entry(ctx->dst_queue.next,=20struct=20s5p_mfc_buf,=20list);=
=0D=0A>=20>=20=20=09dst_addr=20=3D=20vb2_dma_contig_plane_dma_addr(&dst_mb-=
>b-=0D=0A>=20>vb2_buf,=200);=20=40=40=0D=0A>=20>=20-1215,8=20+1235,8=20=40=
=40=20static=20int=20enc_post_frame_start(struct=20s5p_mfc_ctx=0D=0A>=20>=
=20*ctx)=20=20=7B=0D=0A>=20>=20=20=09struct=20s5p_mfc_dev=20*dev=20=3D=20ct=
x->dev;=0D=0A>=20>=20=20=09struct=20s5p_mfc_buf=20*mb_entry;=0D=0A>=20>=20-=
=09unsigned=20long=20enc_y_addr=20=3D=200,=20enc_c_addr=20=3D=200;=0D=0A>=
=20>=20-=09unsigned=20long=20mb_y_addr,=20mb_c_addr;=0D=0A>=20>=20+=09unsig=
ned=20long=20enc_y_addr=20=3D=200,=20enc_c_addr=20=3D=200,=20enc_c_1_addr=
=20=3D=200;=0D=0A>=20>=20+=09unsigned=20long=20mb_y_addr,=20mb_c_addr,=20mb=
_c_1_addr;=0D=0A>=20>=20=20=09int=20slice_type;=0D=0A>=20>=20=20=09unsigned=
=20int=20strm_size;=0D=0A>=20>=20=20=09bool=20src_ready;=0D=0A>=20>=20=40=
=40=20-1229,14=20+1249,21=20=40=40=20static=20int=20enc_post_frame_start(st=
ruct=0D=0A>=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09=09=20=20mfc_read(dev,=
=20S5P_FIMV_ENC_SI_PIC_CNT));=0D=0A>=20>=20=20=09if=20(slice_type=20>=3D=20=
0)=20=7B=0D=0A>=20>=20=20=09=09s5p_mfc_hw_call(dev->mfc_ops,=20get_enc_fram=
e_buffer,=0D=0A>=20ctx,=0D=0A>=20>=20-=09=09=09=09&enc_y_addr,=20&enc_c_add=
r);=0D=0A>=20>=20+=09=09=09=09&enc_y_addr,=20&enc_c_addr,=0D=0A>=20&enc_c_1=
_addr);=0D=0A>=20>=20=20=09=09list_for_each_entry(mb_entry,=20&ctx->src_que=
ue,=20list)=20=7B=0D=0A>=20>=20=20=09=09=09mb_y_addr=20=3D=20vb2_dma_contig=
_plane_dma_addr(=0D=0A>=20>=20=20=09=09=09=09=09&mb_entry->b->vb2_buf,=200)=
;=0D=0A>=20>=20=20=09=09=09mb_c_addr=20=3D=20vb2_dma_contig_plane_dma_addr(=
=0D=0A>=20>=20=20=09=09=09=09=09&mb_entry->b->vb2_buf,=201);=0D=0A>=20>=20-=
=09=09=09if=20((enc_y_addr=20=3D=3D=20mb_y_addr)=20&&=0D=0A>=20>=20-=09=09=
=09=09=09=09(enc_c_addr=20=3D=3D=20mb_c_addr))=0D=0A>=20=7B=0D=0A>=20>=20+=
=09=09=09if=20(ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YUV420M=
=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20=
V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=09=09mb_c_1_addr=20=3D=0D=0A>=20=
vb2_dma_contig_plane_dma_addr=0D=0A>=20>=20+=09=09=09=09=09=09(&mb_entry->b=
->vb2_buf,=0D=0A>=202);=0D=0A>=20>=20+=09=09=09else=0D=0A>=20>=20+=09=09=09=
=09mb_c_1_addr=20=3D=200;=0D=0A>=20>=20+=09=09=09if=20((enc_y_addr=20=3D=3D=
=20mb_y_addr)=0D=0A>=20>=20+=09=09=09=09=09&&=20(enc_c_addr=20=3D=3D=20mb_c=
_addr)=0D=0A>=20>=20+=09=09=09=09=09&&=20(enc_c_1_addr=20=3D=3D=0D=0A>=20mb=
_c_1_addr))=20=7B=0D=0A>=20>=20=20=09=09=09=09list_del(&mb_entry->list);=0D=
=0A>=20>=20=20=09=09=09=09ctx->src_queue_cnt--;=0D=0A>=20>=20=20=09=09=09=
=09vb2_buffer_done(&mb_entry->b->vb2_buf,=0D=0A>=20>=20=40=40=20-1249,8=20+=
1276,15=20=40=40=20static=20int=20enc_post_frame_start(struct=0D=0A>=20s5p_=
mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09=09=09=09=09&mb_entry->b->vb2_buf,=200);=
=0D=0A>=20>=20=20=09=09=09mb_c_addr=20=3D=20vb2_dma_contig_plane_dma_addr(=
=0D=0A>=20>=20=20=09=09=09=09=09&mb_entry->b->vb2_buf,=201);=0D=0A>=20>=20-=
=09=09=09if=20((enc_y_addr=20=3D=3D=20mb_y_addr)=20&&=0D=0A>=20>=20-=09=09=
=09=09=09=09(enc_c_addr=20=3D=3D=20mb_c_addr))=0D=0A>=20=7B=0D=0A>=20>=20+=
=09=09=09if=20(ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YUV420M=
=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20=
V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=09=09mb_c_1_addr=20=3D=0D=0A>=20=
vb2_dma_contig_plane_dma_addr(=0D=0A>=20>=20+=09=09=09=09=09=09&mb_entry->b=
->vb2_buf,=202);=0D=0A>=20>=20+=09=09=09else=0D=0A>=20>=20+=09=09=09=09mb_c=
_1_addr=20=3D=200;=0D=0A>=20>=20+=09=09=09if=20((enc_y_addr=20=3D=3D=20mb_y=
_addr)=0D=0A>=20>=20+=09=09=09=09=09&&=20(enc_c_addr=20=3D=3D=20mb_c_addr)=
=0D=0A>=20>=20+=09=09=09=09=09&&=20(enc_c_1_addr=20=3D=3D=0D=0A>=20mb_c_1_a=
ddr))=20=7B=0D=0A>=20>=20=20=09=09=09=09list_del(&mb_entry->list);=0D=0A>=
=20>=20=20=09=09=09=09ctx->ref_queue_cnt--;=0D=0A>=20>=20=20=09=09=09=09vb2=
_buffer_done(&mb_entry->b->vb2_buf,=0D=0A>=20>=20=40=40=20-1381,10=20+1415,=
15=20=40=40=20static=20int=20vidioc_g_fmt(struct=20file=20*file,=20void=0D=
=0A>=20*priv,=20struct=20v4l2_format=20*f)=0D=0A>=20>=20=20=09=09pix_fmt_mp=
->pixelformat=20=3D=20ctx->src_fmt->fourcc;=0D=0A>=20>=20=20=09=09pix_fmt_m=
p->num_planes=20=3D=20ctx->src_fmt->num_planes;=0D=0A>=20>=0D=0A>=20>=20-=
=09=09pix_fmt_mp->plane_fmt=5B0=5D.bytesperline=20=3D=20ctx->buf_width;=0D=
=0A>=20>=20+=09=09pix_fmt_mp->plane_fmt=5B0=5D.bytesperline=20=3D=20ctx->st=
ride=5B0=5D;=0D=0A>=20>=20=20=09=09pix_fmt_mp->plane_fmt=5B0=5D.sizeimage=
=20=3D=20ctx->luma_size;=0D=0A>=20>=20-=09=09pix_fmt_mp->plane_fmt=5B1=5D.b=
ytesperline=20=3D=20ctx->buf_width;=0D=0A>=20>=20+=09=09pix_fmt_mp->plane_f=
mt=5B1=5D.bytesperline=20=3D=20ctx->stride=5B1=5D;=0D=0A>=20>=20=20=09=09pi=
x_fmt_mp->plane_fmt=5B1=5D.sizeimage=20=3D=20ctx->chroma_size;=0D=0A>=20>=
=20+=09=09if=20(ctx->src_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=
=7C=0D=0A>=20>=20+=09=09=09=09ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_P=
IX_FMT_YVU420M)=20=7B=0D=0A>=20>=20+=09=09=09pix_fmt_mp->plane_fmt=5B2=5D.b=
ytesperline=20=3D=20ctx-=0D=0A>=20>stride=5B2=5D;=0D=0A>=20>=20+=09=09=09pi=
x_fmt_mp->plane_fmt=5B2=5D.sizeimage=20=3D=20ctx-=0D=0A>=20>chroma_size_1;=
=0D=0A>=20>=20+=09=09=7D=0D=0A>=20>=20=20=09=7D=20else=20=7B=0D=0A>=20>=20=
=20=09=09mfc_err(=22invalid=20buf=20type=5Cn=22);=0D=0A>=20>=20=20=09=09ret=
urn=20-EINVAL;=0D=0A>=20>=20=40=40=20-1468,9=20+1507,14=20=40=40=20static=
=20int=20vidioc_s_fmt(struct=20file=20*file,=20void=0D=0A>=20>=20*priv,=20s=
truct=20v4l2_format=20*f)=0D=0A>=20>=0D=0A>=20>=20=20=09=09s5p_mfc_hw_call(=
dev->mfc_ops,=20enc_calc_src_size,=20ctx);=0D=0A>=20>=20=20=09=09pix_fmt_mp=
->plane_fmt=5B0=5D.sizeimage=20=3D=20ctx->luma_size;=0D=0A>=20>=20-=09=09pi=
x_fmt_mp->plane_fmt=5B0=5D.bytesperline=20=3D=20ctx->buf_width;=0D=0A>=20>=
=20+=09=09pix_fmt_mp->plane_fmt=5B0=5D.bytesperline=20=3D=20ctx->stride=5B0=
=5D;=0D=0A>=20>=20=20=09=09pix_fmt_mp->plane_fmt=5B1=5D.sizeimage=20=3D=20c=
tx->chroma_size;=0D=0A>=20>=20-=09=09pix_fmt_mp->plane_fmt=5B1=5D.bytesperl=
ine=20=3D=20ctx->buf_width;=0D=0A>=20>=20+=09=09pix_fmt_mp->plane_fmt=5B1=
=5D.bytesperline=20=3D=20ctx->stride=5B1=5D;=0D=0A>=20>=20+=09=09if=20(ctx-=
>src_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=
=09=09=09ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YVU420M)=20=7B=
=0D=0A>=20>=20+=09=09=09pix_fmt_mp->plane_fmt=5B2=5D.bytesperline=20=3D=20c=
tx-=0D=0A>=20>stride=5B2=5D;=0D=0A>=20>=20+=09=09=09pix_fmt_mp->plane_fmt=
=5B2=5D.sizeimage=20=3D=20ctx-=0D=0A>=20>chroma_size_1;=0D=0A>=20>=20+=09=
=09=7D=0D=0A>=20>=0D=0A>=20>=20=20=09=09ctx->src_bufs_cnt=20=3D=200;=0D=0A>=
=20>=20=20=09=09ctx->output_state=20=3D=20QUEUE_FREE;=0D=0A>=20>=20=40=40=
=20-2414,10=20+2458,16=20=40=40=20static=20int=20s5p_mfc_queue_setup(struct=
=0D=0A>=20>=20vb2_queue=20*vq,=0D=0A>=20>=0D=0A>=20>=20=20=09=09psize=5B0=
=5D=20=3D=20ctx->luma_size;=0D=0A>=20>=20=20=09=09psize=5B1=5D=20=3D=20ctx-=
>chroma_size;=0D=0A>=20>=20+=09=09if=20(ctx->src_fmt->fourcc=20=3D=3D=20V4L=
2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->src_fmt->fourcc=
=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=09psize=5B2=
=5D=20=3D=20ctx->chroma_size_1;=0D=0A>=20>=0D=0A>=20>=20=20=09=09if=20(IS_M=
FCV6_PLUS(dev))=20=7B=0D=0A>=20>=20=20=09=09=09alloc_devs=5B0=5D=20=3D=20ct=
x->dev->mem_dev=5BBANK_L_CTX=5D;=0D=0A>=20>=20=20=09=09=09alloc_devs=5B1=5D=
=20=3D=20ctx->dev->mem_dev=5BBANK_L_CTX=5D;=0D=0A>=20>=20+=09=09=09if=20(ct=
x->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=
=20>=20+=09=09=09=09ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YVU=
420M)=0D=0A>=20>=20+=09=09=09=09alloc_devs=5B2=5D=20=3D=20ctx->dev-=0D=0A>=
=20>mem_dev=5BBANK_L_CTX=5D;=0D=0A>=20>=20=20=09=09=7D=20else=20=7B=0D=0A>=
=20>=20=20=09=09=09alloc_devs=5B0=5D=20=3D=20ctx->dev->mem_dev=5BBANK_R_CTX=
=5D;=0D=0A>=20>=20=20=09=09=09alloc_devs=5B1=5D=20=3D=20ctx->dev->mem_dev=
=5BBANK_R_CTX=5D;=0D=0A>=20=40=40=20-2456,6=20+2506,10=0D=0A>=20>=20=40=40=
=20static=20int=20s5p_mfc_buf_init(struct=20vb2_buffer=20*vb)=0D=0A>=20>=0D=
=0A>=20=09vb2_dma_contig_plane_dma_addr(vb,=200);=0D=0A>=20>=20=20=09=09ctx=
->src_bufs=5Bi=5D.cookie.raw.chroma=20=3D=0D=0A>=20>=0D=0A>=20=09vb2_dma_co=
ntig_plane_dma_addr(vb,=201);=0D=0A>=20>=20+=09=09if=20(ctx->src_fmt->fourc=
c=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->s=
rc_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=
=09ctx->src_bufs=5Bi=5D.cookie.raw.chroma_1=20=3D=0D=0A>=20>=20+=0D=0A>=20=
=09vb2_dma_contig_plane_dma_addr(vb,=202);=0D=0A>=20>=20=20=09=09ctx->src_b=
ufs_cnt++;=0D=0A>=20>=20=20=09=7D=20else=20=7B=0D=0A>=20>=20=20=09=09mfc_er=
r(=22invalid=20queue=20type:=20%d=5Cn=22,=20vq->type);=20=40=40=20-2493,6=
=0D=0A>=20+2547,12=0D=0A>=20>=20=40=40=20static=20int=20s5p_mfc_buf_prepare=
(struct=20vb2_buffer=20*vb)=0D=0A>=20>=20=20=09=09=09mfc_err(=22plane=20siz=
e=20is=20too=20small=20for=20output=5Cn=22);=0D=0A>=20>=20=20=09=09=09retur=
n=20-EINVAL;=0D=0A>=20>=20=20=09=09=7D=0D=0A>=20>=20+=09=09if=20((ctx->src_=
fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=
=20=20=20=20=20ctx->src_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YVU420M)=20&&=
=0D=0A>=20>=20+=09=09=20=20=20=20(vb2_plane_size(vb,=202)=20<=20ctx->chroma=
_size_1))=20=7B=0D=0A>=20>=20+=09=09=09mfc_err(=22plane=20size=20is=20too=
=20small=20for=20output=5Cn=22);=0D=0A>=20>=20+=09=09=09return=20-EINVAL;=
=0D=0A>=20>=20+=09=09=7D=0D=0A>=20>=20=20=09=7D=20else=20=7B=0D=0A>=20>=20=
=20=09=09mfc_err(=22invalid=20queue=20type:=20%d=5Cn=22,=20vq->type);=0D=0A=
>=20>=20=20=09=09return=20-EINVAL;=0D=0A>=20>=20diff=20--git=20a/drivers/me=
dia/platform/samsung/s5p-mfc/s5p_mfc_opr.h=0D=0A>=20>=20b/drivers/media/pla=
tform/samsung/s5p-mfc/s5p_mfc_opr.h=0D=0A>=20>=20index=2087ac56756a16..7c5e=
851c8191=20100644=0D=0A>=20>=20---=20a/drivers/media/platform/samsung/s5p-m=
fc/s5p_mfc_opr.h=0D=0A>=20>=20+++=20b/drivers/media/platform/samsung/s5p-mf=
c/s5p_mfc_opr.h=0D=0A>=20>=20=40=40=20-293,9=20+293,11=20=40=40=20struct=20=
s5p_mfc_hw_ops=20=7B=0D=0A>=20>=20=20=09int=20(*set_enc_stream_buffer)(stru=
ct=20s5p_mfc_ctx=20*ctx,=0D=0A>=20>=20=20=09=09=09unsigned=20long=20addr,=
=20unsigned=20int=20size);=0D=0A>=20>=20=20=09void=20(*set_enc_frame_buffer=
)(struct=20s5p_mfc_ctx=20*ctx,=0D=0A>=20>=20-=09=09=09unsigned=20long=20y_a=
ddr,=20unsigned=20long=20c_addr);=0D=0A>=20>=20+=09=09=09unsigned=20long=20=
y_addr,=20unsigned=20long=20c_addr,=0D=0A>=20>=20+=09=09=09unsigned=20long=
=20c_1_addr);=0D=0A>=20>=20=20=09void=20(*get_enc_frame_buffer)(struct=20s5=
p_mfc_ctx=20*ctx,=0D=0A>=20>=20-=09=09=09unsigned=20long=20*y_addr,=20unsig=
ned=20long=20*c_addr);=0D=0A>=20>=20+=09=09=09unsigned=20long=20*y_addr,=20=
unsigned=20long=20*c_addr,=0D=0A>=20>=20+=09=09=09unsigned=20long=20*c_1_ad=
dr);=0D=0A>=20>=20=20=09void=20(*try_run)(struct=20s5p_mfc_dev=20*dev);=0D=
=0A>=20>=20=20=09void=20(*clear_int_flags)(struct=20s5p_mfc_dev=20*dev);=0D=
=0A>=20>=20=20=09int=20(*get_dspl_y_adr)(struct=20s5p_mfc_dev=20*dev);=20di=
ff=20--git=0D=0A>=20>=20a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_op=
r_v5.c=0D=0A>=20>=20b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5=
.c=0D=0A>=20>=20index=2028a06dc343fd..fcfaf125a5a1=20100644=0D=0A>=20>=20--=
-=20a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c=0D=0A>=20>=20=
+++=20b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c=0D=0A>=20>=
=20=40=40=20-516,7=20+516,8=20=40=40=20static=20int=0D=0A>=20s5p_mfc_set_en=
c_stream_buffer_v5(struct=0D=0A>=20>=20s5p_mfc_ctx=20*ctx,=20=20=7D=0D=0A>=
=20>=0D=0A>=20>=20=20static=20void=20s5p_mfc_set_enc_frame_buffer_v5(struct=
=20s5p_mfc_ctx=20*ctx,=0D=0A>=20>=20-=09=09unsigned=20long=20y_addr,=20unsi=
gned=20long=20c_addr)=0D=0A>=20>=20+=09=09unsigned=20long=20y_addr,=20unsig=
ned=20long=20c_addr,=0D=0A>=20>=20+=09=09unsigned=20long=20c_1_addr)=0D=0A>=
=20>=20=20=7B=0D=0A>=20>=20=20=09struct=20s5p_mfc_dev=20*dev=20=3D=20ctx->d=
ev;=0D=0A>=20>=0D=0A>=20>=20=40=40=20-525,7=20+526,8=20=40=40=20static=20vo=
id=0D=0A>=20s5p_mfc_set_enc_frame_buffer_v5(struct=0D=0A>=20>=20s5p_mfc_ctx=
=20*ctx,=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=20static=20void=20s5p_mfc_get_en=
c_frame_buffer_v5(struct=20s5p_mfc_ctx=20*ctx,=0D=0A>=20>=20-=09=09unsigned=
=20long=20*y_addr,=20unsigned=20long=20*c_addr)=0D=0A>=20>=20+=09=09unsigne=
d=20long=20*y_addr,=20unsigned=20long=20*c_addr,=0D=0A>=20>=20+=09=09unsign=
ed=20long=20*c_1_addr)=0D=0A>=20>=20=20=7B=0D=0A>=20>=20=20=09struct=20s5p_=
mfc_dev=20*dev=20=3D=20ctx->dev;=0D=0A>=20>=0D=0A>=20>=20=40=40=20-1210,7=
=20+1212,7=20=40=40=20static=20int=20s5p_mfc_run_enc_frame(struct=0D=0A>=20=
s5p_mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09if=20(list_empty(&ctx->src_queue))=
=20=7B=0D=0A>=20>=20=20=09=09/*=20send=20null=20frame=20*/=0D=0A>=20>=20=20=
=09=09s5p_mfc_set_enc_frame_buffer_v5(ctx,=20dev-=0D=0A>=20>dma_base=5BBANK=
_R_CTX=5D,=0D=0A>=20>=20-=09=09=09=09=09=09dev-=0D=0A>=20>dma_base=5BBANK_R=
_CTX=5D);=0D=0A>=20>=20+=09=09=09=09=09=09dev-=0D=0A>=20>dma_base=5BBANK_R_=
CTX=5D,=200);=0D=0A>=20>=20=20=09=09src_mb=20=3D=20NULL;=0D=0A>=20>=20=20=
=09=7D=20else=20=7B=0D=0A>=20>=20=20=09=09src_mb=20=3D=20list_entry(ctx->sr=
c_queue.next,=20struct=0D=0A>=20s5p_mfc_buf,=20=40=40=0D=0A>=20>=20-1220,7=
=20+1222,7=20=40=40=20static=20int=20s5p_mfc_run_enc_frame(struct=20s5p_mfc=
_ctx=0D=0A>=20*ctx)=0D=0A>=20>=20=20=09=09=09/*=20send=20null=20frame=20*/=
=0D=0A>=20>=20=20=09=09=09s5p_mfc_set_enc_frame_buffer_v5(ctx,=0D=0A>=20>=
=20=20=09=09=09=09=09=09dev-=0D=0A>=20>dma_base=5BBANK_R_CTX=5D,=0D=0A>=20>=
=20-=09=09=09=09=09=09dev-=0D=0A>=20>dma_base=5BBANK_R_CTX=5D);=0D=0A>=20>=
=20+=09=09=09=09=09=09dev-=0D=0A>=20>dma_base=5BBANK_R_CTX=5D,=200);=0D=0A>=
=20>=20=20=09=09=09ctx->state=20=3D=20MFCINST_FINISHING;=0D=0A>=20>=20=20=
=09=09=7D=20else=20=7B=0D=0A>=20>=20=20=09=09=09src_y_addr=20=3D=20vb2_dma_=
contig_plane_dma_addr(=0D=0A>=20=40=40=20-1228,7=20+1230,7=20=40=40=0D=0A>=
=20>=20static=20int=20s5p_mfc_run_enc_frame(struct=20s5p_mfc_ctx=20*ctx)=0D=
=0A>=20>=20=20=09=09=09src_c_addr=20=3D=20vb2_dma_contig_plane_dma_addr(=0D=
=0A>=20>=20=20=09=09=09=09=09&src_mb->b->vb2_buf,=201);=0D=0A>=20>=20=20=09=
=09=09s5p_mfc_set_enc_frame_buffer_v5(ctx,=20src_y_addr,=0D=0A>=20>=20-=09=
=09=09=09=09=09=09=09src_c_addr);=0D=0A>=20>=20+=09=09=09=09=09=09=09=09src=
_c_addr,=0D=0A>=200);=0D=0A>=20>=20=20=09=09=09if=20(src_mb->flags=20&=20MF=
C_BUF_FLAG_EOS)=0D=0A>=20>=20=20=09=09=09=09ctx->state=20=3D=20MFCINST_FINI=
SHING;=0D=0A>=20>=20=20=09=09=7D=0D=0A>=20>=20diff=20--git=20a/drivers/medi=
a/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c=0D=0A>=20>=20b/drivers/media/pl=
atform/samsung/s5p-mfc/s5p_mfc_opr_v6.c=0D=0A>=20>=20index=20fb3f0718821d..=
e579c765e902=20100644=0D=0A>=20>=20---=20a/drivers/media/platform/samsung/s=
5p-mfc/s5p_mfc_opr_v6.c=0D=0A>=20>=20+++=20b/drivers/media/platform/samsung=
/s5p-mfc/s5p_mfc_opr_v6.c=0D=0A>=20>=20=40=40=20-494,16=20+494,43=20=40=40=
=20static=20void=20s5p_mfc_dec_calc_dpb_size_v6(struct=0D=0A>=20s5p_mfc_ctx=
=20*ctx)=0D=0A>=20>=20=20=09struct=20s5p_mfc_dev=20*dev=20=3D=20ctx->dev;=
=0D=0A>=20>=20=20=09ctx->buf_width=20=3D=20ALIGN(ctx->img_width,=0D=0A>=20S=
5P_FIMV_NV12MT_HALIGN_V6);=0D=0A>=20>=20=20=09ctx->buf_height=20=3D=20ALIGN=
(ctx->img_height,=0D=0A>=20S5P_FIMV_NV12MT_VALIGN_V6);=0D=0A>=20>=20+=09ctx=
->chroma_size_1=20=3D=200;=0D=0A>=20>=20=20=09mfc_debug(2,=20=22SEQ=20Done:=
=20Movie=20dimensions=20%dx%d,=5Cn=22=0D=0A>=20>=20=20=09=09=09=22buffer=20=
dimensions:=20%dx%d=5Cn=22,=20ctx->img_width,=0D=0A>=20>=20=20=09=09=09ctx-=
>img_height,=20ctx->buf_width,=20ctx->buf_height);=0D=0A>=20>=0D=0A>=20>=20=
-=09ctx->luma_size=20=3D=20calc_plane(ctx->img_width,=20ctx->img_height);=
=0D=0A>=20>=20-=09ctx->chroma_size=20=3D=20calc_plane(ctx->img_width,=20(ct=
x->img_height=20>>=0D=0A>=201));=0D=0A>=20>=20+=09switch=20(ctx->dst_fmt->f=
ourcc)=20=7B=0D=0A>=20>=20+=09case=20V4L2_PIX_FMT_NV12M:=0D=0A>=20>=20+=09c=
ase=20V4L2_PIX_FMT_NV21M:=0D=0A>=20>=20+=09=09ctx->stride=5B0=5D=20=3D=20AL=
IGN(ctx->img_width,=0D=0A>=20>=20+=09=09=09=09=09S5P_FIMV_NV12MT_HALIGN_V6)=
;=0D=0A>=20>=20+=09=09ctx->stride=5B1=5D=20=3D=20ALIGN(ctx->img_width,=0D=
=0A>=20>=20+=09=09=09=09=09S5P_FIMV_NV12MT_HALIGN_V6);=0D=0A>=20>=20+=09=09=
ctx->luma_size=20=3D=20calc_plane(ctx->stride=5B0=5D,=20ctx->img_height);=
=0D=0A>=20>=20+=09=09ctx->chroma_size=20=3D=20calc_plane(ctx->stride=5B1=5D=
,=0D=0A>=20>=20+=09=09=09=09=09(ctx->img_height=20/=202));=0D=0A>=20>=20+=
=09=09break;=0D=0A>=20>=20+=09case=20V4L2_PIX_FMT_YUV420M:=0D=0A>=20>=20+=
=09case=20V4L2_PIX_FMT_YVU420M:=0D=0A>=20>=20+=09=09ctx->stride=5B0=5D=20=
=3D=20ALIGN(ctx->img_width,=0D=0A>=20>=20+=09=09=09=09=09S5P_FIMV_NV12MT_HA=
LIGN_V6);=0D=0A>=20>=20+=09=09ctx->stride=5B1=5D=20=3D=20ALIGN(ctx->img_wid=
th=20/=202,=0D=0A>=20>=20+=09=09=09=09=09S5P_FIMV_NV12MT_HALIGN_V6);=0D=0A>=
=20>=20+=09=09ctx->stride=5B2=5D=20=3D=20ALIGN(ctx->img_width=20/=202,=0D=
=0A>=20>=20+=09=09=09=09=09S5P_FIMV_NV12MT_HALIGN_V6);=0D=0A>=20>=20+=09=09=
ctx->luma_size=20=3D=20calc_plane(ctx->stride=5B0=5D,=20ctx->img_height);=
=0D=0A>=20>=20+=09=09ctx->chroma_size=20=3D=20calc_plane(ctx->stride=5B1=5D=
,=0D=0A>=20>=20+=09=09=09=09=09(ctx->img_height=20/=202));=0D=0A>=20>=20+=
=09=09ctx->chroma_size_1=20=3D=20calc_plane(ctx->stride=5B2=5D,=0D=0A>=20>=
=20+=09=09=09=09=09(ctx->img_height=20/=202));=0D=0A>=20>=20+=09=09break;=
=0D=0A>=20>=20+=09=7D=0D=0A>=20>=20+=0D=0A>=20>=20=20=09if=20(IS_MFCV8_PLUS=
(ctx->dev))=20=7B=0D=0A>=20>=20=20=09=09/*=20MFCv8=20needs=20additional=206=
4=20bytes=20for=20luma,chroma=20dpb*/=0D=0A>=20>=20=20=09=09ctx->luma_size=
=20+=3D=20S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;=0D=0A>=20>=20=20=09=09ctx->chroma=
_size=20+=3D=20S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;=0D=0A>=20>=20+=09=09ctx->chr=
oma_size_1=20+=3D=0D=0A>=20S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;=0D=0A>=20>=20=20=
=09=7D=0D=0A>=20>=0D=0A>=20>=20=20=09if=20(ctx->codec_mode=20=3D=3D=20S5P_M=
FC_CODEC_H264_DEC=20=7C=7C=20=40=40=20-534,15=0D=0A>=20+561,53=0D=0A>=20>=
=20=40=40=20static=20void=20s5p_mfc_enc_calc_src_size_v6(struct=20s5p_mfc_c=
tx=20*ctx)=0D=0A>=20>=20=20=09mb_width=20=3D=20MB_WIDTH(ctx->img_width);=0D=
=0A>=20>=20=20=09mb_height=20=3D=20MB_HEIGHT(ctx->img_height);=0D=0A>=20>=
=0D=0A>=20>=20-=09ctx->buf_width=20=3D=20ALIGN(ctx->img_width,=0D=0A>=20S5P=
_FIMV_NV12M_HALIGN_V6);=0D=0A>=20>=20-=09ctx->luma_size=20=3D=20ALIGN((mb_w=
idth=20*=20mb_height)=20*=20256,=20256);=0D=0A>=20>=20-=09ctx->chroma_size=
=20=3D=20ALIGN((mb_width=20*=20mb_height)=20*=20128,=20256);=0D=0A>=20>=20-=
=0D=0A>=20>=20-=09/*=20MFCv7=20needs=20pad=20bytes=20for=20Luma=20and=20Chr=
oma=20*/=0D=0A>=20>=20-=09if=20(IS_MFCV7_PLUS(ctx->dev))=20=7B=0D=0A>=20>=
=20+=09if=20(IS_MFCV12(ctx->dev))=20=7B=0D=0A>=20>=20+=09=09switch=20(ctx->=
src_fmt->fourcc)=20=7B=0D=0A>=20>=20+=09=09case=20V4L2_PIX_FMT_NV12M:=0D=0A=
>=20>=20+=09=09case=20V4L2_PIX_FMT_NV21M:=0D=0A>=20>=20+=09=09=09ctx->strid=
e=5B0=5D=20=3D=20ALIGN(ctx->img_width,=0D=0A>=20>=20+=0D=0A>=20=09S5P_FIMV_=
NV12M_HALIGN_V6);=0D=0A>=20>=20+=09=09=09ctx->stride=5B1=5D=20=3D=20ALIGN(c=
tx->img_width,=0D=0A>=20>=20+=0D=0A>=20=09S5P_FIMV_NV12M_HALIGN_V6);=0D=0A>=
=20>=20+=09=09=09ctx->luma_size=20=3D=20ctx->stride=5B0=5D=20*=0D=0A>=20>=
=20+=09=09=09=09=09=09ALIGN(ctx->img_height,=2016);=0D=0A>=20>=20+=09=09=09=
ctx->chroma_size=20=3D=20=20ctx->stride=5B0=5D=20*=0D=0A>=20>=20+=09=09=09=
=09=09=09ALIGN(ctx->img_height=20/=202,=0D=0A>=2016);=0D=0A>=20>=20+=09=09=
=09break;=0D=0A>=20>=20+=09=09case=20V4L2_PIX_FMT_YUV420M:=0D=0A>=20>=20+=
=09=09case=20V4L2_PIX_FMT_YVU420M:=0D=0A>=20>=20+=09=09=09ctx->stride=5B0=
=5D=20=3D=20ALIGN(ctx->img_width,=0D=0A>=20>=20+=0D=0A>=20=09S5P_FIMV_NV12M=
_HALIGN_V6);=0D=0A>=20>=20+=09=09=09ctx->stride=5B1=5D=20=3D=20ALIGN(ctx->i=
mg_width=20/=202,=0D=0A>=20>=20+=0D=0A>=20=09S5P_FIMV_NV12M_HALIGN_V6);=0D=
=0A>=20>=20+=09=09=09ctx->stride=5B2=5D=20=3D=20ALIGN(ctx->img_width=20/=20=
2,=0D=0A>=20>=20+=0D=0A>=20=09S5P_FIMV_NV12M_HALIGN_V6);=0D=0A>=20>=20+=09=
=09=09ctx->luma_size=20=3D=20ctx->stride=5B0=5D=20*=0D=0A>=20>=20+=09=09=09=
=09=09=09ALIGN(ctx->img_height,=2016);=0D=0A>=20>=20+=09=09=09ctx->chroma_s=
ize=20=3D=20=20ctx->stride=5B1=5D=20*=0D=0A>=20>=20+=09=09=09=09=09=09ALIGN=
(ctx->img_height=20/=202,=0D=0A>=2016);=0D=0A>=20>=20+=09=09=09ctx->chroma_=
size_1=20=3D=20=20ctx->stride=5B2=5D=20*=0D=0A>=20>=20+=09=09=09=09=09=09AL=
IGN(ctx->img_height=20/=202,=0D=0A>=2016);=0D=0A>=20>=20+=09=09=09break;=0D=
=0A>=20>=20+=09=09=7D=0D=0A>=20>=20=20=09=09ctx->luma_size=20+=3D=20MFC_LUM=
A_PAD_BYTES_V7;=0D=0A>=20>=20-=09=09ctx->chroma_size=20+=3D=20MFC_CHROMA_PA=
D_BYTES_V7;=0D=0A>=20>=20+=09=09ctx->chroma_size=20+=3D=20MFC_CHROMA_PAD_BY=
TES_V12;=0D=0A>=20>=20+=09=09ctx->chroma_size_1=20+=3D=20MFC_CHROMA_PAD_BYT=
ES_V12;=0D=0A>=20>=20+=09=7D=20else=20=7B=0D=0A>=20>=20+=09=09ctx->buf_widt=
h=20=3D=20ALIGN(ctx->img_width,=0D=0A>=20>=20+=09=09=09=09=09S5P_FIMV_NV12M=
_HALIGN_V6);=0D=0A>=20>=20+=09=09ctx->stride=5B0=5D=20=3D=20ctx->buf_width;=
=0D=0A>=20>=20+=09=09ctx->stride=5B1=5D=20=3D=20ctx->buf_width;=0D=0A>=20>=
=20+=09=09ctx->luma_size=20=3D=20ALIGN((mb_width=20*=20mb_height)=20*=20256=
,=0D=0A>=20256);=0D=0A>=20>=20+=09=09ctx->chroma_size=20=3D=20ALIGN((mb_wid=
th=20*=20mb_height)=20*=20128,=0D=0A>=20256);=0D=0A>=20>=20+=09=09ctx->chro=
ma_size_1=20=3D=200;=0D=0A>=20>=20+=09=09/*=20MFCv7=20needs=20pad=20bytes=
=20for=20Luma=20and=20Chroma=20*/=0D=0A>=20>=20+=09=09if=20(IS_MFCV7_PLUS(c=
tx->dev))=20=7B=0D=0A>=20>=20+=09=09=09ctx->luma_size=20+=3D=20MFC_LUMA_PAD=
_BYTES_V7;=0D=0A>=20>=20+=09=09=09ctx->chroma_size=20+=3D=20MFC_LUMA_PAD_BY=
TES_V7;=0D=0A>=20>=20+=09=09=7D=0D=0A>=20>=20=20=09=7D=0D=0A>=20>=20+=0D=0A=
>=20>=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=20/*=20Set=20registers=20for=20deco=
ding=20stream=20buffer=20*/=20=40=40=20-588,15=20+653,21=20=40=40=0D=0A>=20=
>=20static=20int=20s5p_mfc_set_dec_frame_buffer_v6(struct=20s5p_mfc_ctx=20*=
ctx)=0D=0A>=20>=20=20=09writel(ctx->total_dpb_count,=20mfc_regs->d_num_dpb)=
;=0D=0A>=20>=20=20=09writel(ctx->luma_size,=20mfc_regs->d_first_plane_dpb_s=
ize);=0D=0A>=20>=20=20=09writel(ctx->chroma_size,=20mfc_regs->d_second_plan=
e_dpb_size);=0D=0A>=20>=20-=0D=0A>=20>=20+=09if=20(ctx->dst_fmt->fourcc=20=
=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09ctx->dst_fmt-=
>fourcc=20=3D=3D=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09writel(ctx->ch=
roma_size_1,=20mfc_regs-=0D=0A>=20>d_third_plane_dpb_size);=0D=0A>=20>=20=
=20=09writel(buf_addr1,=20mfc_regs->d_scratch_buffer_addr);=0D=0A>=20>=20=
=20=09writel(ctx->scratch_buf_size,=20mfc_regs->d_scratch_buffer_size);=0D=
=0A>=20>=0D=0A>=20>=20=20=09if=20(IS_MFCV8_PLUS(dev))=20=7B=0D=0A>=20>=20-=
=09=09writel(ctx->img_width,=0D=0A>=20>=20+=09=09writel(ctx->stride=5B0=5D,=
=0D=0A>=20>=20=20=09=09=09mfc_regs->d_first_plane_dpb_stride_size);=0D=0A>=
=20>=20-=09=09writel(ctx->img_width,=0D=0A>=20>=20+=09=09writel(ctx->stride=
=5B1=5D,=0D=0A>=20>=20=20=09=09=09mfc_regs->d_second_plane_dpb_stride_size)=
;=0D=0A>=20>=20+=09=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YU=
V420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=
=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=09writel(ctx->stride=5B2=
=5D,=0D=0A>=20>=20+=09=09=09=09mfc_regs->d_third_plane_dpb_stride_size);=0D=
=0A>=20>=20=20=09=7D=0D=0A>=20>=0D=0A>=20>=20=20=09buf_addr1=20+=3D=20ctx->=
scratch_buf_size;=0D=0A>=20>=20=40=40=20-625,6=20+696,13=20=40=40=20static=
=20int=0D=0A>=20s5p_mfc_set_dec_frame_buffer_v6(struct=20s5p_mfc_ctx=20*ctx=
)=0D=0A>=20>=20=20=09=09=09=09=09ctx->dst_bufs=5Bi=5D.cookie.raw.chroma);=
=0D=0A>=20>=20=20=09=09writel(ctx->dst_bufs=5Bi=5D.cookie.raw.chroma,=0D=0A=
>=20>=20=20=09=09=09=09mfc_regs->d_second_plane_dpb=20+=20i=20*=204);=0D=0A=
>=20>=20+=09=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=
=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->dst_fmt->fourcc=20=3D=3D=0D=0A>=20=
V4L2_PIX_FMT_YVU420M)=20=7B=0D=0A>=20>=20+=09=09=09mfc_debug(2,=20=22=5CtCh=
roma_1=20%d:=20%zx=5Cn=22,=20i,=0D=0A>=20>=20+=09=09=09=09=09ctx-=0D=0A>=20=
>dst_bufs=5Bi=5D.cookie.raw.chroma_1);=0D=0A>=20>=20+=09=09=09writel(ctx->d=
st_bufs=5Bi=5D.cookie.raw.chroma_1,=0D=0A>=20>=20+=09=09=09=09=09mfc_regs->=
d_third_plane_dpb=20+=20i=20*=0D=0A>=204);=0D=0A>=20>=20+=09=09=7D=0D=0A>=
=20>=20=20=09=7D=0D=0A>=20>=20=20=09if=20(ctx->codec_mode=20=3D=3D=20S5P_MF=
C_CODEC_H264_DEC=20=7C=7C=0D=0A>=20>=20=20=09=09=09ctx->codec_mode=20=3D=3D=
=0D=0A>=20S5P_MFC_CODEC_H264_MVC_DEC=20=7C=7C=20=40=40=20-683,20=0D=0A>=20>=
=20+761,24=20=40=40=20static=20int=20s5p_mfc_set_enc_stream_buffer_v6(struc=
t=0D=0A>=20>=20s5p_mfc_ctx=20*ctx,=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=20stat=
ic=20void=20s5p_mfc_set_enc_frame_buffer_v6(struct=20s5p_mfc_ctx=20*ctx,=0D=
=0A>=20>=20-=09=09unsigned=20long=20y_addr,=20unsigned=20long=20c_addr)=0D=
=0A>=20>=20+=09=09unsigned=20long=20y_addr,=20unsigned=20long=20c_addr,=0D=
=0A>=20>=20+=09=09unsigned=20long=20c_1_addr)=0D=0A>=20>=20=20=7B=0D=0A>=20=
>=20=20=09struct=20s5p_mfc_dev=20*dev=20=3D=20ctx->dev;=0D=0A>=20>=20=20=09=
const=20struct=20s5p_mfc_regs=20*mfc_regs=20=3D=20dev->mfc_regs;=0D=0A>=20>=
=0D=0A>=20>=20=20=09writel(y_addr,=20mfc_regs->e_source_first_plane_addr);=
=0D=0A>=20>=20=20=09writel(c_addr,=20mfc_regs->e_source_second_plane_addr);=
=0D=0A>=20>=20+=09writel(c_1_addr,=20mfc_regs->e_source_third_plane_addr);=
=0D=0A>=20>=0D=0A>=20>=20=20=09mfc_debug(2,=20=22enc=20src=20y=20buf=20addr=
:=200x%08lx=5Cn=22,=20y_addr);=0D=0A>=20>=20=20=09mfc_debug(2,=20=22enc=20s=
rc=20c=20buf=20addr:=200x%08lx=5Cn=22,=20c_addr);=0D=0A>=20>=20+=09mfc_debu=
g(2,=20=22enc=20src=20cr=20buf=20addr:=200x%08lx=5Cn=22,=20c_1_addr);=0D=0A=
>=20>=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=20static=20void=20s5p_mfc_get_enc_f=
rame_buffer_v6(struct=20s5p_mfc_ctx=20*ctx,=0D=0A>=20>=20-=09=09unsigned=20=
long=20*y_addr,=20unsigned=20long=20*c_addr)=0D=0A>=20>=20+=09=09unsigned=
=20long=20*y_addr,=20unsigned=20long=20*c_addr,=0D=0A>=20>=20+=09=09unsigne=
d=20long=20*c_1_addr)=0D=0A>=20>=20=20=7B=0D=0A>=20>=20=20=09struct=20s5p_m=
fc_dev=20*dev=20=3D=20ctx->dev;=0D=0A>=20>=20=20=09const=20struct=20s5p_mfc=
_regs=20*mfc_regs=20=3D=20dev->mfc_regs;=20=40=40=20-704,12=0D=0A>=20>=20+7=
86,17=20=40=40=20static=20void=20s5p_mfc_get_enc_frame_buffer_v6(struct=0D=
=0A>=20>=20s5p_mfc_ctx=20*ctx,=0D=0A>=20>=0D=0A>=20>=20=20=09*y_addr=20=3D=
=20readl(mfc_regs->e_encoded_source_first_plane_addr);=0D=0A>=20>=20=20=09*=
c_addr=20=3D=20readl(mfc_regs-=0D=0A>=20>e_encoded_source_second_plane_addr=
);=0D=0A>=20>=20+=09if=20(ctx->src_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV4=
20M=20=7C=7C=0D=0A>=20>=20+=09=09=09ctx->src_fmt->fourcc=20=3D=3D=20V4L2_PI=
X_FMT_YVU420M)=0D=0A>=20>=20+=09=09*c_1_addr=20=3D=20readl(mfc_regs-=0D=0A>=
=20>e_encoded_source_third_plane_addr);=0D=0A>=20>=20+=09else=0D=0A>=20>=20=
+=09=09*c_1_addr=20=3D=200;=0D=0A>=20>=0D=0A>=20>=20=20=09enc_recon_y_addr=
=20=3D=20readl(mfc_regs->e_recon_luma_dpb_addr);=0D=0A>=20>=20=20=09enc_rec=
on_c_addr=20=3D=20readl(mfc_regs->e_recon_chroma_dpb_addr);=0D=0A>=20>=0D=
=0A>=20>=20=20=09mfc_debug(2,=20=22recon=20y=20addr:=200x%08lx=20y_addr:=20=
0x%08lx=5Cn=22,=0D=0A>=20enc_recon_y_addr,=20*y_addr);=0D=0A>=20>=20-=09mfc=
_debug(2,=20=22recon=20c=20addr:=200x%08lx=5Cn=22,=20enc_recon_c_addr);=0D=
=0A>=20>=20+=09mfc_debug(2,=20=22recon=20c=20addr:=200x%08lx=20c_addr:=200x=
%08lx=5Cn=22,=0D=0A>=20>=20+enc_recon_c_addr,=20*c_addr);=0D=0A>=20>=20=20=
=7D=0D=0A>=20>=0D=0A>=20>=20=20/*=20Set=20encoding=20ref=20&=20codec=20buff=
er=20*/=20=40=40=20-886,6=20+973,20=20=40=40=20static=20int=0D=0A>=20>=20s5=
p_mfc_set_enc_params(struct=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09=09wri=
tel(reg,=20mfc_regs->e_enc_options);=0D=0A>=20>=20=20=09=09/*=200:=20NV12(C=
bCr),=201:=20NV21(CrCb)=20*/=0D=0A>=20>=20=20=09=09writel(0x0,=20mfc_regs->=
pixel_format);=0D=0A>=20>=20+=09=7D=20else=20if=20(ctx->src_fmt->fourcc=20=
=3D=3D=20V4L2_PIX_FMT_YVU420M)=20=7B=0D=0A>=20>=20+=09=09/*=200:=20Linear,=
=201:=202D=20tiled*/=0D=0A>=20>=20+=09=09reg=20=3D=20readl(mfc_regs->e_enc_=
options);=0D=0A>=20>=20+=09=09reg=20&=3D=20=7E(0x1=20<<=207);=0D=0A>=20>=20=
+=09=09writel(reg,=20mfc_regs->e_enc_options);=0D=0A>=20>=20+=09=09/*=202:=
=20YV12(CrCb),=203:=20I420(CrCb)=20*/=0D=0A>=20>=20+=09=09writel(0x2,=20mfc=
_regs->pixel_format);=0D=0A>=20>=20+=09=7D=20else=20if=20(ctx->src_fmt->fou=
rcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M)=20=7B=0D=0A>=20>=20+=09=09/*=200:=20Li=
near,=201:=202D=20tiled*/=0D=0A>=20>=20+=09=09reg=20=3D=20readl(mfc_regs->e=
_enc_options);=0D=0A>=20>=20+=09=09reg=20&=3D=20=7E(0x1=20<<=207);=0D=0A>=
=20>=20+=09=09writel(reg,=20mfc_regs->e_enc_options);=0D=0A>=20>=20+=09=09/=
*=202:=20YV12(CrCb),=203:=20I420(CrCb)=20*/=0D=0A>=20>=20+=09=09writel(0x3,=
=20mfc_regs->pixel_format);=0D=0A>=20>=20=20=09=7D=0D=0A>=20>=0D=0A>=20>=20=
=20=09/*=20memory=20structure=20recon.=20frame=20*/=0D=0A>=20>=20=40=40=20-=
1696,8=20+1797,12=20=40=40=20static=20int=20s5p_mfc_init_decode_v6(struct=
=0D=0A>=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09else=0D=0A>=20>=20=20=09=
=09writel(reg,=20mfc_regs->d_dec_options);=0D=0A>=20>=0D=0A>=20>=20-=09/*=
=200:=20NV12(CbCr),=201:=20NV21(CrCb)=20*/=0D=0A>=20>=20-=09if=20(ctx->dst_=
fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_NV21M)=0D=0A>=20>=20+=09/*=200:=20NV12(=
CbCr),=201:=20NV21(CrCb),=202:=20YV12(CrCb),=203:=20I420(CbCr)=20*/=0D=0A>=
=20>=20+=09if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M)=0D=
=0A>=20>=20+=09=09writel(0x3,=20mfc_regs->pixel_format);=0D=0A>=20>=20+=09e=
lse=20if=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20=
>=20+=09=09writel(0x2,=20mfc_regs->pixel_format);=0D=0A>=20>=20+=09else=20i=
f=20(ctx->dst_fmt->fourcc=20=3D=3D=20V4L2_PIX_FMT_NV21M)=0D=0A>=20>=20=20=
=09=09writel(0x1,=20mfc_regs->pixel_format);=0D=0A>=20>=20=20=09else=0D=0A>=
=20>=20=20=09=09writel(0x0,=20mfc_regs->pixel_format);=20=40=40=20-1781,8=
=20+1886,12=0D=0A>=20=40=40=20static=0D=0A>=20>=20int=20s5p_mfc_init_encode=
_v6(struct=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=0D=0A>=20>=20=20=09/*=20Set=20s=
tride=20lengths=20for=20v7=20&=20above=20*/=0D=0A>=20>=20=20=09if=20(IS_MFC=
V7_PLUS(dev))=20=7B=0D=0A>=20>=20-=09=09writel(ctx->img_width,=20mfc_regs-=
=0D=0A>=20>e_source_first_plane_stride);=0D=0A>=20>=20-=09=09writel(ctx->im=
g_width,=20mfc_regs-=0D=0A>=20>e_source_second_plane_stride);=0D=0A>=20>=20=
+=09=09writel(ctx->stride=5B0=5D,=20mfc_regs-=0D=0A>=20>e_source_first_plan=
e_stride);=0D=0A>=20>=20+=09=09writel(ctx->stride=5B1=5D,=20mfc_regs-=0D=0A=
>=20>e_source_second_plane_stride);=0D=0A>=20>=20+=09=09if=20(ctx->src_fmt-=
>fourcc=20=3D=3D=20V4L2_PIX_FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09=
ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=
=09=09=09writel(ctx->stride=5B2=5D,=0D=0A>=20>=20+=09=09=09=09=09mfc_regs-=
=0D=0A>=20>e_source_third_plane_stride);=0D=0A>=20>=20=20=09=7D=0D=0A>=20>=
=0D=0A>=20>=20=20=09writel(ctx->inst_no,=20mfc_regs->instance_id);=20=40=40=
=20-1891,7=20+2000,7=0D=0A>=20=40=40=0D=0A>=20>=20static=20inline=20int=20s=
5p_mfc_run_enc_frame(struct=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=20=20=09struct=
=20s5p_mfc_dev=20*dev=20=3D=20ctx->dev;=0D=0A>=20>=20=20=09struct=20s5p_mfc=
_buf=20*dst_mb;=0D=0A>=20>=20=20=09struct=20s5p_mfc_buf=20*src_mb;=0D=0A>=
=20>=20-=09unsigned=20long=20src_y_addr,=20src_c_addr,=20dst_addr;=0D=0A>=
=20>=20+=09unsigned=20long=20src_y_addr,=20src_c_addr,=20src_c_1_addr,=20ds=
t_addr;=0D=0A>=20>=20=20=09/*=0D=0A>=20>=20=20=09unsigned=20int=20src_y_siz=
e,=20src_c_size;=0D=0A>=20>=20=20=09*/=0D=0A>=20>=20=40=40=20-1909,22=20+20=
18,29=20=40=40=20static=20inline=20int=20s5p_mfc_run_enc_frame(struct=0D=0A=
>=20>=20s5p_mfc_ctx=20*ctx)=0D=0A>=20>=0D=0A>=20>=20=20=09if=20(list_empty(=
&ctx->src_queue))=20=7B=0D=0A>=20>=20=20=09=09/*=20send=20null=20frame=20*/=
=0D=0A>=20>=20-=09=09s5p_mfc_set_enc_frame_buffer_v6(ctx,=200,=200);=0D=0A>=
=20>=20+=09=09s5p_mfc_set_enc_frame_buffer_v6(ctx,=200,=200,=200);=0D=0A>=
=20>=20=20=09=09src_mb=20=3D=20NULL;=0D=0A>=20>=20=20=09=7D=20else=20=7B=0D=
=0A>=20>=20=20=09=09src_mb=20=3D=20list_entry(ctx->src_queue.next,=20struct=
=0D=0A>=20s5p_mfc_buf,=20list);=0D=0A>=20>=20=20=09=09src_mb->flags=20=7C=
=3D=20MFC_BUF_FLAG_USED;=0D=0A>=20>=20=20=09=09if=20(src_mb->b->vb2_buf.pla=
nes=5B0=5D.bytesused=20=3D=3D=200)=20=7B=0D=0A>=20>=20-=09=09=09s5p_mfc_set=
_enc_frame_buffer_v6(ctx,=200,=200);=0D=0A>=20>=20+=09=09=09s5p_mfc_set_enc=
_frame_buffer_v6(ctx,=200,=200,=200);=0D=0A>=20>=20=20=09=09=09ctx->state=
=20=3D=20MFCINST_FINISHING;=0D=0A>=20>=20=20=09=09=7D=20else=20=7B=0D=0A>=
=20>=20=20=09=09=09src_y_addr=20=3D=0D=0A>=20vb2_dma_contig_plane_dma_addr(=
&src_mb->b->vb2_buf,=200);=0D=0A>=20>=20=20=09=09=09src_c_addr=20=3D=0D=0A>=
=20vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf,=0D=0A>=20>=201);=0D=
=0A>=20>=20+=09=09=09if=20(ctx->src_fmt->fourcc=20=3D=3D=0D=0A>=20V4L2_PIX_=
FMT_YUV420M=20=7C=7C=0D=0A>=20>=20+=09=09=09=09ctx->src_fmt->fourcc=20=3D=
=3D=0D=0A>=20V4L2_PIX_FMT_YVU420M)=0D=0A>=20>=20+=09=09=09=09src_c_1_addr=
=20=3D=0D=0A>=20vb2_dma_contig_plane_dma_addr=0D=0A>=20>=20+=09=09=09=09=09=
=09(&src_mb->b->vb2_buf,=202);=0D=0A>=20>=20+=09=09=09else=0D=0A>=20>=20+=
=09=09=09=09src_c_1_addr=20=3D=200;=0D=0A>=20>=0D=0A>=20>=20=20=09=09=09mfc=
_debug(2,=20=22enc=20src=20y=20addr:=200x%08lx=5Cn=22,=0D=0A>=20src_y_addr)=
;=0D=0A>=20>=20=20=09=09=09mfc_debug(2,=20=22enc=20src=20c=20addr:=200x%08l=
x=5Cn=22,=0D=0A>=20src_c_addr);=0D=0A>=20>=0D=0A>=20>=20-=09=09=09s5p_mfc_s=
et_enc_frame_buffer_v6(ctx,=20src_y_addr,=0D=0A>=20src_c_addr);=0D=0A>=20>=
=20+=09=09=09s5p_mfc_set_enc_frame_buffer_v6(ctx,=20src_y_addr,=0D=0A>=20>=
=20+=09=09=09=09=09=09src_c_addr,=20src_c_1_addr);=0D=0A>=20>=20=20=09=09=
=09if=20(src_mb->flags=20&=20MFC_BUF_FLAG_EOS)=0D=0A>=20>=20=20=09=09=09=09=
ctx->state=20=3D=20MFCINST_FINISHING;=0D=0A>=20>=20=20=09=09=7D=0D=0A>=20>=
=20=40=40=20-2450,6=20+2566,8=20=40=40=20const=20struct=20s5p_mfc_regs=0D=
=0A>=20*s5p_mfc_init_regs_v6_plus(struct=20s5p_mfc_dev=20*dev)=0D=0A>=20>=
=20=20=09=09=09S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7);=0D=0A>=20>=20=20=
=09R(e_encoded_source_second_plane_addr,=0D=0A>=20>=0D=0A>=20=09S5P_FIMV_E_=
ENCODED_SOURCE_SECOND_ADDR_V7);=0D=0A>=20>=20+=09R(e_encoded_source_third_p=
lane_addr,=0D=0A>=20>=20+=09=09=09S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7);=
=0D=0A>=20>=20=20=09R(e_vp8_options,=20S5P_FIMV_E_VP8_OPTIONS_V7);=0D=0A>=
=20>=0D=0A>=20>=20=20=09if=20(=21IS_MFCV8_PLUS(dev))=0D=0A>=20>=20=40=40=20=
-2464,16=20+2582,20=20=40=40=20const=20struct=20s5p_mfc_regs=0D=0A>=20*s5p_=
mfc_init_regs_v6_plus(struct=20s5p_mfc_dev=20*dev)=0D=0A>=20>=20=20=09R(d_c=
pb_buffer_offset,=20S5P_FIMV_D_CPB_BUFFER_OFFSET_V8);=0D=0A>=20>=20=20=09R(=
d_first_plane_dpb_size,=0D=0A>=20S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8);=0D=0A=
>=20>=20=20=09R(d_second_plane_dpb_size,=0D=0A>=20S5P_FIMV_D_SECOND_PLANE_D=
PB_SIZE_V8);=0D=0A>=20>=20+=09R(d_third_plane_dpb_size,=0D=0A>=20S5P_FIMV_D=
_THIRD_PLANE_DPB_SIZE_V8);=0D=0A>=20>=20=20=09R(d_scratch_buffer_addr,=0D=
=0A>=20S5P_FIMV_D_SCRATCH_BUFFER_ADDR_V8);=0D=0A>=20>=20=20=09R(d_scratch_b=
uffer_size,=20S5P_FIMV_D_SCRATCH_BUFFER_SIZE_V8);=0D=0A>=20>=20=20=09R(d_fi=
rst_plane_dpb_stride_size,=0D=0A>=20>=20=20=09=09=09S5P_FIMV_D_FIRST_PLANE_=
DPB_STRIDE_SIZE_V8);=0D=0A>=20>=20=20=09R(d_second_plane_dpb_stride_size,=
=0D=0A>=20>=0D=0A>=20=09S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8);=0D=0A>=
=20>=20+=09R(d_third_plane_dpb_stride_size,=0D=0A>=20>=20+=09=09=09S5P_FIMV=
_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8);=0D=0A>=20>=20=20=09R(d_mv_buffer_size,=
=20S5P_FIMV_D_MV_BUFFER_SIZE_V8);=0D=0A>=20>=20=20=09R(d_num_mv,=20S5P_FIMV=
_D_NUM_MV_V8);=0D=0A>=20>=20=20=09R(d_first_plane_dpb,=20S5P_FIMV_D_FIRST_P=
LANE_DPB_V8);=0D=0A>=20>=20=20=09R(d_second_plane_dpb,=20S5P_FIMV_D_SECOND_=
PLANE_DPB_V8);=0D=0A>=20>=20+=09R(d_third_plane_dpb,=20S5P_FIMV_D_THIRD_PLA=
NE_DPB_V8);=0D=0A>=20>=20=20=09R(d_mv_buffer,=20S5P_FIMV_D_MV_BUFFER_V8);=
=0D=0A>=20>=20=20=09R(d_init_buffer_options,=20S5P_FIMV_D_INIT_BUFFER_OPTIO=
NS_V8);=0D=0A>=20>=20=20=09R(d_available_dpb_flag_lower,=0D=0A>=20>=20S5P_F=
IMV_D_AVAILABLE_DPB_FLAG_LOWER_V8);=0D=0A=0D=0A=0D=0A
