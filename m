Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0487F2200
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjKUANB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:12:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F4AB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:12:51 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231121001249epoutp012c3aa902b691c359d1969be2f80d730d~Zev7H90Ma2309823098epoutp017
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:12:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231121001249epoutp012c3aa902b691c359d1969be2f80d730d~Zev7H90Ma2309823098epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700525569;
        bh=hwUN0LBGQgjYoxdZvX6WbWTi3VzgrIyo9gsyz23f3ks=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VZ9RcCwUFJlPbdNQI1Ko+NwksJ6gNqWqDSYvNlvhSGT5Yt1LKQwPC+t5+TRFyQk1F
         +6nrLxvWcJh1Mh+nNE05RIQ4bebu7idVVAdvvjdKfCxxbHHf0j+6utnbu1u4r7tCMk
         aCqvmtekmpxysDiWd9hSS4wFwYl8YmZPmnpFc3vs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231121001248epcas5p21cf892e62fc91f46ac8d19c7f032a811~Zev6YDvi-0911109111epcas5p2o;
        Tue, 21 Nov 2023 00:12:48 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SZ4Zk2sMyz4x9Q6; Tue, 21 Nov
        2023 00:12:46 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.A3.08567.EF5FB556; Tue, 21 Nov 2023 09:12:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231120124855epcas5p3021f603b22f90087efab7d38d66a6bbd~ZVaza0hYA2182521825epcas5p3r;
        Mon, 20 Nov 2023 12:48:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120124855epsmtrp2d6be864406cc6c0c53d7bda315f71e79~ZVazZk4550658906589epsmtrp2j;
        Mon, 20 Nov 2023 12:48:55 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-c2-655bf5fe3ed5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.1B.08755.6B55B556; Mon, 20 Nov 2023 21:48:55 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231120124851epsmtip22de3b57739fb9ac52f5f5b48d186fb17~ZVawU94QG0195801958epsmtip2a;
        Mon, 20 Nov 2023 12:48:51 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     <linux-arm-kernel@lists.infradead.org>,
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
        <ajaykumar.rs@samsung.com>
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
Subject: RE: [Patch v4 00/11] Add MFC V12 support
Date:   Mon, 20 Nov 2023 18:18:50 +0530
Message-ID: <0a6801da1baf$ebb47570$c31d6050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHi/4TObS/wQJ2DhVZhuaoGqj3O6QLm4twfsFon1FA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzHe54927OBk4cJ+ZWUWztHKAEbsPXAgXiB+qSdcnVh2Q96bnuO
        cYxtbYOEf8JgKQaeQnA6YciPQUcoOH4j83BgBAphGAiOyMCMPIFzuiAMGtso/nt9ft37+/58
        78OkcbJRP2aKQkupFaScx/BAWnt2BQavPP+QEpzr3Yx3z99A8F8NrQy8avERjE9V2RDc0tSC
        4vXmIRiv7eum4+W9Q3S87cZvCD7e3QHjdy5MIviZPx7QcNP0KB0f6Sxl4PmNLXT8/I/XYfxy
        7ySKG8fuwHiN6QWMV7Y8Q3GduRfd60vUG+ohYqz6KY3o0E+iRFXXLEyY6vIYhHW0i0E0VX9B
        6G7+jRBnmusgwmbyJwae29AEz2Op0TKKlFJqLqWQKKUpiuQY3qF3k+KSRGKBMFgYib/B4yrI
        NCqGF/92QvD+FLnDKY+bQcrTHakEUqPhhe6JVivTtRRXptRoY3iUSipXRahCNGSaJl2RHKKg
        tFFCgSBM5Gj8NFV2vuoFpBrcebzz1hA9Gxr2Pw2xmACLAMXf56BrzMGuQeB6TsZpyMPBTyEw
        p7sCuQI7BJanB5D1iSet7e6CGQIjI5cRV/AIAvMzuc4uBhYKpgby6WsFHywPAnm1bc4uGvaA
        BhaKZp2KLGwPuGT/0slbMCGwtFUw1hjB+KDplyUns7FI0P9Vn5u9Qf+FGacCDQsCNRWPaa43
        ccHSwxr6GvtgUaBgcZDm6tkKbi7l09aEAVbFArfLbahrIB4szK3SXbwF/NnX7M77AducmeFi
        CZiunHULyEFD1zfuBcSC7rulDmY6BHaBhs5QV3oHKB64Art0N4OC5RnYlWeDdsM6B4BS66Jb
        djvo+c4InYV4+g3W9Bus6TdY0P+vdglC6qBtlEqTlkxJRCqhgvr8vy+XKNNMkPMUdse3Q/fK
        V0IsEMyELBBg0ng+bDvnfYrDlpKZWZRamaROl1MaCyRy7Psczc9XonTckkKbJIyIFESIxeKI
        yHCxkLeV/VhXJuVgyaSWSqUoFaVen4OZLL9sWK8ICuOHosvTB4xoYGLipsOe0JsrHx3O6T3C
        fC2gYbPdyteyibeas/GERMkh37Gy0Czj1P3XM7vC+h8SyMvR9sKh5vlT+ykLP8PrxKw3/8S3
        oxOC++Fg2P5K0YExloc699nHjaOFTUb+veGCudmd/3xtqBbH3mKj48tJOt+9KQcbZYWZT37f
        ton7jrVYvmzwXrLG/dXVxvKMLysyXM0dl3VaUZFXMPUSYjLmBPx0t8RgBtsP9szFXbwqGuv/
        wCs/a8dgyQ/7Kj47VllxMt323lHdUU386knpUsFEB/vn2GtBC/p91sBizu1w39rjq6cuWvyb
        VVLzBBn5yatkVGl3yREeopGRwt00tYb8F7Oa+NqTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c4525mKcZozv8xuS40stUWXr5sUBZ3ALARJGpSjnbxNG1vZ
        hSIzlBravXAr73kbSrY1l+liHmdm1jRXhnnrZmWWmaa5Eg23Cv/7wfM8P94/Xh7O7yO8ebGJ
        hxhFokQm5LoSlXXC+YHGCDGz/Gc9hszfagn0OruSiwrGPmKop2CYQKzeQKIykxVDxQ1mDsqx
        WDnIWPuWQO3mKgw9U3cR6PynNzjSvWvjINv9m1yUXmHgoMzmBxgqt3SRqPDlMwwV6cYxlG/4
        QaJUk4Xc5EmXZZcB+uWtIZyu0nSRdEFNH0brtOe4dGdbDZfW3zpFp9b/Iujzd7WAHtbNox+P
        DJO73Pa4bpAystgkRhEcEuUa06Gt4spTfY8WtoyBZJA8TwVceJBaCb9W3gMq4MrjU9UAPh00
        487AB06mPSSd7AFLJz6SzlIvgHXsCHcq4FLBsOdxOmcqEFAZAPYMZTlUOPUdhx9KRgjn5AKA
        Kku+w+VChcDc0RQHe1AiyBrzHCqC8oP6bruD3am1sDGt4S/PhI3q98QU49RS2Nve+5+L8vr/
        3roA2nuLOFMsoNbBjLGnuLPjBevt6fhF4KGZptJMU2mmqTTTJrmA0ILZjFyZEJ2gFMlFicyR
        IKUkQXk4MTpo/8EEHXB8Q8CSe8CoHQxiAcYDLIA8XChwH+VHMnx3qeTYcUZxcJ/isIxRsmAO
        jxB6uXt9ypDyqWjJISaeYeSM4l+K8Vy8kzGrX+5w+E75paX5ItHgO2/saFh9pn73jWtRy3bV
        nIh4dfdza2jYmjf2izkv4ovtkQtl4gm1xsSWxLaftm1/khtS3qr5ou6Xepo26wTl2+JHQ2Oy
        BmYN7JdXXL8yfjZstWaCkOGPVM9nmPIiAtrutGS//70eaxyftLUmxfq22dJ2Tnb7xPmLR/vc
        toqMbD+hfpiypio8oGnbKtnn8WBB19wDUf4thSvJMzt8G/iZblb9GcYgK5ojxtnAJtsK2pZF
        +qu6r8qrfbQzci7NNNxOah64/I1o3hLqOTuyNE6W4rd3MSOxVB/pEHvNLTt3crt1km0fMocG
        vpBu1ocv2ujt3ykklDESUQCuUEr+AMNx3kR8AwAA
X-CMS-MailID: 20231120124855epcas5p3021f603b22f90087efab7d38d66a6bbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102230epcas5p1558641a18fbf4f841c82b0ef4cf5a91f
References: <CGME20231025102230epcas5p1558641a18fbf4f841c82b0ef4cf5a91f@epcas5p1.samsung.com>
        <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Aakarsh Jain <aakarsh.jain=40samsung.com>
> Sent: 25 October 2023 15:52
> To: linux-arm-kernel=40lists.infradead.org; linux-media=40vger.kernel.org=
;
> linux-kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> krzysztof.kozlowski+dt=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; conor+dt=40kernel.org; linux-samsung-
> soc=40vger.kernel.org; andi=40etezian.org; gost.dev=40samsung.com;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; ajaykumar.rs=40samsung.com;
> aakarsh.jain=40samsung.com
> Subject: =5BPatch v4 00/11=5D Add MFC V12 support
>=20
> This patch series adds MFC v12 support. MFC v12 is used in Tesla FSD SoC.
>=20
> This adds support for following:
>=20
> -Add support for YV12 and I420 format (3-plane) -Add support for Rate
> Control, UHD and DMABUF for encoder -Add support for DPB buffers
> allocation based on MFC requirement
>=20
> Changes since v3:
> -Removed vp9 codec support for now and just keeping MFC v12 base
> patches with necessary hardware controls, decoder, encoder and structural
> changes. Also covers luma dbp, chroma dpb and mv sizes for each codec as
> per the UM for MFCv12, along with appropriate alignment.
> v3 link: https://patchwork.kernel.org/project/linux-
> media/cover/20221011122516.32135-1-aakarsh.jain=40samsung.com/
>=20
> Changes since v2:
> -Addressed review comments by Rob Herring.
> This was regarding the errors found by Rob bot in yaml file. File
> 'samsung,s5p-mfc.yaml' is already converted into json schema and is
> merged.
>=20
> -Addressed review comments by Krzysztof Kozlowski.
> This was regarding depricated properties mentioned in s5p-mfc.txt file.
> Review comment was addressed and 'samsung,s5p-mfc.yaml' is already
> merged now.
>=20
> -Addressed review comments by Andi Shyti.
> This was regarding addition of 'MFC_V10PLUS_BITS' macro in
> 's5p_mfc_common.h file.
> v2 link: https://patchwork.kernel.org/project/linux-
> media/cover/20220907064715.55778-1-smitha.t=40samsung.com/
>=20
> Changes since v1:
> -Addressed review comments by Krzysztof Kozlowski.
> Separated bug fixes patches, resent again with fix tag and those are merg=
ed
> now.
> -Added SoC based compatible string.
>=20
> -Addressed review comments by Andrzej Hajda Assigned width64 and
> height32 variable with ALIGN(ctx->img_..) used in the code in
> 's5p_mfc_opr_v6.c' file.
> v1 link: https://patchwork.kernel.org/project/linux-
> media/patch/20220517125548.14746-2-smitha.t=40samsung.com/
>=20
> Aakarsh Jain (11):
>   dt-bindings: media: s5p-mfc: Add mfcv12 variant
>   media: s5p-mfc: Rename IS_MFCV10 macro
>   media: s5p-mfc: Add initial support for MFCv12
>   media: s5p-mfc: Add YV12 and I420 multiplanar format support
>   media: s5p-mfc: Add support for rate controls in MFCv12
>   media: s5p-mfc: Add support for UHD encoding.
>   media: s5p-mfc: Add support for DMABUF for encoder
>   media: s5p-mfc: Set context for valid case before calling try_run
>   media: s5p-mfc: Load firmware for each run in MFCv12.
>   media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
>   arm64: dts: fsd: Add MFC related DT enteries
>=20
>  .../bindings/media/samsung,s5p-mfc.yaml       =7C  16 +
>  arch/arm64/boot/dts/tesla/fsd.dtsi            =7C  21 ++
>  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   =7C  52 +++
>  .../platform/samsung/s5p-mfc/regs-mfc-v7.h    =7C   1 +
>  .../platform/samsung/s5p-mfc/regs-mfc-v8.h    =7C   3 +
>  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  =7C  36 +-
> .../platform/samsung/s5p-mfc/s5p_mfc_common.h =7C  29 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   =7C   9 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    =7C  51 ++-
>  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    =7C 138 +++++---
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    =7C  14 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c =7C  12 +-
> .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c =7C 312 +++++++++++++++-
> --
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h =7C   7 +-
>  14 files changed, 574 insertions(+), 127 deletions(-)  create mode 10064=
4
> drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
>=20
> --
> 2.17.1


Gentle reminder to review MFC v12 patches.
I see Krzysztof have some comments on dt-schema patch. Waiting for reviewer=
s to review driver changes as well. Post which I can send v5 changes.

Thanks


