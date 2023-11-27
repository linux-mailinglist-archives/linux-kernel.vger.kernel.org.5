Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564F7F9AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjK0H36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0H3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:29:55 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0612D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:29:56 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231127072952epoutp028d9d40ce986b6b3c552040a7d1406e86~balO39QTq1671016710epoutp02P
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231127072952epoutp028d9d40ce986b6b3c552040a7d1406e86~balO39QTq1671016710epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701070192;
        bh=I9q0UlKpMR+zO9daXEjApbAIHAYHpVFOqzvi19A9Sl4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=TNUAkx5rklmLWgyh4Q4zM44ZLgngf4SFWCwDXvwVtk8oM0FEWWa0/P4RJz1R3Ygqh
         ku2Rjbn1ZGH2bczYzG+cMEnIm98uxDovBvKDZiTt5MmJOj1lLQuYiAjDxmqPlUFc6i
         +IyRachRCEEGd6XSPrrlBgiC9Lan/qL0RMlf30fQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231127072951epcas5p3120f310bcdadcb3f5197d0a7f1d4feec~balOJYuw71521015210epcas5p3o;
        Mon, 27 Nov 2023 07:29:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sdy0F4ZVPz4x9Q7; Mon, 27 Nov
        2023 07:29:49 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.61.09672.D6544656; Mon, 27 Nov 2023 16:29:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231127064442epcas5p3aac23c015ca0b4b9fb7b8bc79c1dbee3~bZ9y_-0_x3127031270epcas5p3q;
        Mon, 27 Nov 2023 06:44:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231127064442epsmtrp1a88747682aba9d9c2be1463bdd715d7c~bZ9y93a0o2678226782epsmtrp18;
        Mon, 27 Nov 2023 06:44:42 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-af-6564456dba83
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.98.08817.9DA34656; Mon, 27 Nov 2023 15:44:41 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231127064438epsmtip2eebe4a8d40343d832ec6029d13e8094e~bZ9vdxcOD1822318223epsmtip2o;
        Mon, 27 Nov 2023 06:44:38 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Hans Verkuil'" <hverkuil-cisco@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <andi@etezian.org>, <gost.dev@samsung.com>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <ajaykumar.rs@samsung.com>,
        <linux-fsd@tesla.com>,
        "'Smitha T Murthy'" <smithatmurthy@gmail.com>
In-Reply-To: <d7aa0485-2f67-497d-bca4-8111fa68d27d@xs4all.nl>
Subject: RE: [Patch v4 03/11] media: s5p-mfc: Add initial support for MFCv12
Date:   Mon, 27 Nov 2023 12:14:36 +0530
Message-ID: <0fe301da20fd$32f8ecc0$98eac640$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQIIuTk5ALqF0vYBYW6Pna5TDfLA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTOe+9te2HWXQHHK36RS7YMGdBCwbcbuC1Td7PiwhRmxkywtjeA
        QCm9ReeWTGXCAkPUDZgQQKB8LFhAyocI1ECBMLtMRyQ6DMhXjQPm+NpIFSErXNj495xznuc9
        5zlvDom7XBJ5kHEaPavTKBNooTPR3OX9pm/iATUrGbbtRh3TnQQaKW4WIoP9KYaGDfMEsjQ0
        iZDRfBdDVb0dAnSt+64A3ewcI9BAxy0M9eUPESj7j1EcmcYfCNDo5FF0v7VQiLJuNAnQ1Xu3
        MVTTPSRCFQ/7MFRpeomhsqa/RSjN3C1CF86XC95zZ4zFRsA8LJ/DmVsFQyLG0D6BMabqDCEz
        +KBdyDSUn2XSel4QTHZjNWCWU4tEzLxpF2P9Z14UvikqPiSWVapZnSerUSWp4zQxobTiSPQH
        0UHBEqmvVI720p4aZSIbSu8PC/c9GJfg8E17nlImpDhS4UqOo/33heiSUvSsZ2wSpw+lWa06
        QSvT+nHKRC5FE+OnYfVvSyWSgCAH8Xh87MJPQ5jWWgm+qLIsYufAo3SQCZxISMlgQ6FZmAmc
        SReqDcC+y0acD+YAbJ4dXQsWAJxNNQrXJfkDZgFfMAPYXWMl+OApgIMZ57EVlpDyh8PWrFWW
        G9UCYOnor6sFnPqOgIXpASvYiQqFwxn3HJOQpCsVBp/d8FpJE9TrsOjihdVuYkoOl+80Ah5v
        gXfybQT/jA+sLJ3C+Yk84fMnlYIV7EYdhFP2XBHPcYc9z7NWLUCqywmW/p5B8IL90NqTs7YB
        VzjZ2yjisQecuJS+hlVwvGxirUECrGvPWdO+Czv6C4mVmXHKG9a1+vPpnTDXWrtmcTO8uGjD
        +LwYthSv4zdg4aBdwOMdsOt6BbgM6IIN1go2WCvYYKHg/24lgKgG21gtlxjDckHaQA17+r8/
        VyUlmsDqZexRtICxkRk/C8BIYAGQxGk3sd+sinURq5VnvmR1SdG6lASWs4Agx76v4B5bVUmO
        09Loo6UyuUQWHBwskwcGS2l38VRakdqFilHq2XiW1bK6dR1GOnmcw/quRrrhJ+0/lJNo5+Nc
        s9diYLXXiZ//8qrNizw8mbX3DPf45Wfx1ya9au1EXb2hZcJ1vu1jSdd9SYmNvD21NbcsLGKp
        Luot9nCJQfN9RMTR4/pXbH4D271fDRnz35UnXjZY31EMpWT1y1788mnr9JEdi4fa+s2v1Wf7
        dNbbk/0/Ol21e2ZuOMemNbkUjo74cOCYfixquHraddOHg0+2J+dFVH2j+DqEO5aqfYT/eGIp
        3iKr+wrbZqwJSl46tflZZtHclYmehm+Jmn1353w048YtZGQnzfWGnK2u6AhgpxUnP79+SF1m
        m/iTyexqcc6gFb9132yfIz6R62cWVH5y+fthPTTBxSqle3Adp/wX/nzPGaIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCSvO5Nq5RUg1vHzC0OvD/IYvFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZr9p5jslh+/ACrxfwj51gtth98xGJx88BOJouLM++yWPS9eMhs
        senxNVaLh6/CLS7vmsNm0bNhK6vFjPP7mCzWHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8RdouW
        xiWsDuIea+atYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sqRo9/
        TXPZPT5vkvM49fUzewBPFJdNSmpOZllqkb5dAlfGts67bAWvFzBWbDrwgrmBsbORsYuRk0NC
        wERi5s29rF2MXBxCArsZJb5v7mKCSMhI/G87xg5hC0us/PecHaLoKaPE7xXbWEESbAL6EvdP
        9YB1iwjsYZQ4unsNWBWzwFwWiX9HZrNAtHxilGhYPJcNpIVTwFbifud5oOUcHMICPhJvNyiD
        hFkEVCXm9raAlfAKWEr8O7mFEcIWlDg58wkLiM0soC3x9OZTOHvZwtfMEOcpSPx8ugzsIhEB
        N4nXP6ayQ9SISxz92cM8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfm
        Fpfmpesl5+duYgQnDi2tHYx7Vn3QO8TIxMF4iFGCg1lJhFfvY3KqEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUw9axOlsw7rHHu1fluNiaJhlfM0xbId
        UtEpF+8efjB5VoBqXvbv/V123AX9K6sYD+xr19L+oSHOMaU/8tePh7vCly3RXnD8z0NdDqEz
        K1IivXo8A9QWeHvMsfwX5CNZVPLE4qrDxwVHYp7Mf7BzweW3jy+EHHY5+ZLl43Fb5gZd694L
        6xk0BcoFN9VIn/6+/EnnpojQ6Dz2nvUvvwo9nGu7UPXNm6ezDmnpc17Vb1bwnSTZlaw05TaL
        xgFB1vz2OzWsCfWf32xNeHPswLs6laWPX1/89/DmEo7uCdJnG/033cqY05vJkNIqlNYUbfSj
        UVFZb2b578LwxdHTX7mp3vzzm/tyT7DHje3r+MXlGPYpsRRnJBpqMRcVJwIAl1E0AYsDAAA=
X-CMS-MailID: 20231127064442epcas5p3aac23c015ca0b4b9fb7b8bc79c1dbee3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4@epcas5p1.samsung.com>
        <20231025102216.50480-4-aakarsh.jain@samsung.com>
        <d7aa0485-2f67-497d-bca4-8111fa68d27d@xs4all.nl>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

> -----Original Message-----
> From: Hans Verkuil <hverkuil-cisco=40xs4all.nl>
> Sent: 22 November 2023 21:04
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; conor+dt=40kernel.org; linu=
x-
> samsung-soc=40vger.kernel.org; andi=40etezian.org; gost.dev=40samsung.com=
;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; ajaykumar.rs=40samsung.com; linux-
> fsd=40tesla.com; Smitha T Murthy <smithatmurthy=40gmail.com>
> Subject: Re: =5BPatch v4 03/11=5D media: s5p-mfc: Add initial support for=
 MFCv12
>=20
> On 25/10/2023 12:22, Aakarsh Jain wrote:
> > Add support for MFCv12, with a new register file and necessary hw
> > control, decoder, encoder and structural changes. Add luma dbp, chroma
> > dpb and mv sizes for each codec as per the UM for MFCv12, along with
> > appropriate alignment.
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smithatmurthy=40gmail.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   =7C 50 +++++++++++
> >  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  =7C 30 +++++++
> > .../platform/samsung/s5p-mfc/s5p_mfc_common.h =7C 15 +++-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   =7C  2 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    =7C  6 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    =7C  5 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    =7C  8 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c =7C 83
> > ++++++++++++++++---  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> =7C
> > 6 +-
> >  9 files changed, 175 insertions(+), 30 deletions(-)  create mode
> > 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> >
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > new file mode 100644
> > index 000000000000..6c68a45082d0
> > --- /dev/null
> > +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > =40=40 -0,0 +1,50 =40=40
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Register definition file for Samsung MFC V12.x Interface (FIMV)
> > +driver
> > + *
> > + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> > + *     http://www.samsung.com/
> > + */
> > +
> > +=23ifndef _REGS_MFC_V12_H
> > +=23define _REGS_MFC_V12_H
> > +
> > +=23include <linux/sizes.h>
> > +=23include =22regs-mfc-v10.h=22
> > +
> > +/* MFCv12 Context buffer sizes */
> > +=23define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
> > +=23define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
> > +=23define MFC_OTHER_DEC_CTX_BUF_SIZE_V12	(30 * SZ_1K)
> > +=23define MFC_H264_ENC_CTX_BUF_SIZE_V12	(100 * SZ_1K)
> > +=23define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
> > +=23define MFC_OTHER_ENC_CTX_BUF_SIZE_V12	(25 * SZ_1K)
> > +
> > +/* MFCv12 variant defines */
> > +=23define MAX_FW_SIZE_V12			(SZ_1M)
> > +=23define MAX_CPB_SIZE_V12		(7 * SZ_1M)
> > +=23define MFC_VERSION_V12			0xC0
> > +=23define MFC_NUM_PORTS_V12		1
> > +=23define S5P_FIMV_CODEC_VP9_ENC		27
> > +
> > +/* Encoder buffer size for MFCv12 */
> > +=23define ENC_V120_BASE_SIZE(x, y) =5C
> > +	(((x + 3) * (y + 3) * 8) =5C
> > +	+ (((y * 64) + 2304) * (x + 7) / 8))
> > +
> > +=23define ENC_V120_H264_ME_SIZE(x, y) =5C
> > +	ALIGN((ENC_V120_BASE_SIZE(x, y) =5C
> > +	+ (DIV_ROUND_UP(x * y, 64) * 32)), 256)
> > +
> > +=23define ENC_V120_MPEG4_ME_SIZE(x, y) =5C
> > +	ALIGN((ENC_V120_BASE_SIZE(x, y) =5C
> > +	+ (DIV_ROUND_UP(x * y, 128) * 16)), 256)
> > +
> > +=23define ENC_V120_VP8_ME_SIZE(x, y) =5C
> > +	ALIGN(ENC_V120_BASE_SIZE(x, y), 256)
> > +
> > +=23define ENC_V120_HEVC_ME_SIZE(x, y)     =5C
> > +	ALIGN((((x + 3) * (y + 3) * 32)       =5C
> > +	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
> > +
> > +=23endif /*_REGS_MFC_V12_H*/
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> > index e30e54935d79..dee9ef017997 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> > =40=40 -790,6 +790,8 =40=40 static int s5p_mfc_open(struct file *file)
> >  	INIT_LIST_HEAD(&ctx->dst_queue);
> >  	ctx->src_queue_cnt =3D 0;
> >  	ctx->dst_queue_cnt =3D 0;
> > +	ctx->is_422 =3D 0;
> > +	ctx->is_10bit =3D 0;
> >  	/* Get context number */
> >  	ctx->num =3D 0;
> >  	while (dev->ctx=5Bctx->num=5D) =7B
> > =40=40 -1660,6 +1662,31 =40=40 static struct s5p_mfc_variant mfc_drvdat=
a_v10 =3D
> =7B
> >  	.fw_name=5B0=5D     =3D =22s5p-mfc-v10.fw=22,
> >  =7D;
> >
> > +static struct s5p_mfc_buf_size_v6 mfc_buf_size_v12 =3D =7B
> > +	.dev_ctx        =3D MFC_CTX_BUF_SIZE_V12,
> > +	.h264_dec_ctx   =3D MFC_H264_DEC_CTX_BUF_SIZE_V12,
> > +	.other_dec_ctx  =3D MFC_OTHER_DEC_CTX_BUF_SIZE_V12,
> > +	.h264_enc_ctx   =3D MFC_H264_ENC_CTX_BUF_SIZE_V12,
> > +	.hevc_enc_ctx   =3D MFC_HEVC_ENC_CTX_BUF_SIZE_V12,
> > +	.other_enc_ctx  =3D MFC_OTHER_ENC_CTX_BUF_SIZE_V12, =7D;
> > +
> > +static struct s5p_mfc_buf_size buf_size_v12 =3D =7B
> > +	.fw     =3D MAX_FW_SIZE_V12,
> > +	.cpb    =3D MAX_CPB_SIZE_V12,
> > +	.priv   =3D &mfc_buf_size_v12,
> > +=7D;
> > +
> > +static struct s5p_mfc_variant mfc_drvdata_v12 =3D =7B
> > +	.version        =3D MFC_VERSION_V12,
> > +	.version_bit    =3D MFC_V12_BIT,
> > +	.port_num       =3D MFC_NUM_PORTS_V12,
> > +	.buf_size       =3D &buf_size_v12,
> > +	.fw_name=5B0=5D     =3D =22s5p-mfc-v12.fw=22,
>=20
> Is this fw in the process of being added to linux-firmware? (Or perhaps i=
t is
> already there).
>=20
> Regards,
>=20
> 	Hans
>=20
Yes, we are in a process of upstreaming MFC v12 firmware bin to linux-firmw=
are.

Thanks for the review.

> > +	.clk_names	=3D =7B=22mfc=22=7D,
> > +	.num_clocks	=3D 1,
> > +=7D;
> > +
> >  static const struct of_device_id exynos_mfc_match=5B=5D =3D =7B
> >  	=7B
> >  		.compatible =3D =22samsung,mfc-v5=22,
> > =40=40 -1682,6 +1709,9 =40=40 static const struct of_device_id
> exynos_mfc_match=5B=5D =3D =7B
> >  	=7D, =7B
> >  		.compatible =3D =22samsung,mfc-v10=22,
> >  		.data =3D &mfc_drvdata_v10,
> > +	=7D, =7B
> > +		.compatible =3D =22tesla,fsd-mfc=22,
> > +		.data =3D &mfc_drvdata_v12,
> >  	=7D,
> >  	=7B=7D,
> >  =7D;
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > index e6ec4a43b290..dd2e9f7704ab 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > =40=40 -19,7 +19,7 =40=40
> >  =23include <media/v4l2-ioctl.h>
> >  =23include <media/videobuf2-v4l2.h>
> >  =23include =22regs-mfc.h=22
> > -=23include =22regs-mfc-v10.h=22
> > +=23include =22regs-mfc-v12.h=22
> >
> >  =23define S5P_MFC_NAME		=22s5p-mfc=22
> >
> > =40=40 -720,6 +720,8 =40=40 struct s5p_mfc_ctx =7B
> >  	struct v4l2_ctrl *ctrls=5BMFC_MAX_CTRLS=5D;
> >  	struct v4l2_ctrl_handler ctrl_handler;
> >  	size_t scratch_buf_size;
> > +	int is_10bit;
> > +	int is_422;
> >  =7D;
> >
> >  /*
> > =40=40 -775,6 +777,7 =40=40 void s5p_mfc_cleanup_queue(struct list_head=
 *lh,
> struct vb2_queue *vq);
> >  =23define IS_MFCV7_PLUS(dev)	(dev->variant->version >=3D 0x70)
> >  =23define IS_MFCV8_PLUS(dev)	(dev->variant->version >=3D 0x80)
> >  =23define IS_MFCV10_PLUS(dev)	(dev->variant->version >=3D 0xA0)
> > +=23define IS_MFCV12(dev)		(dev->variant->version >=3D 0xC0)
> >  =23define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
> >
> >  =23define MFC_V5_BIT	BIT(0)
> > =40=40 -782,11 +785,15 =40=40 void s5p_mfc_cleanup_queue(struct list_he=
ad
> *lh, struct vb2_queue *vq);
> >  =23define MFC_V7_BIT	BIT(2)
> >  =23define MFC_V8_BIT	BIT(3)
> >  =23define MFC_V10_BIT	BIT(5)
> > +=23define MFC_V12_BIT	BIT(7)
> >
> >  =23define MFC_V5PLUS_BITS		(MFC_V5_BIT =7C MFC_V6_BIT =7C
> MFC_V7_BIT =7C =5C
> > -					MFC_V8_BIT =7C MFC_V10_BIT)
> > +					MFC_V8_BIT =7C MFC_V10_BIT =7C
> MFC_V12_BIT)
> >  =23define MFC_V6PLUS_BITS		(MFC_V6_BIT =7C MFC_V7_BIT =7C
> MFC_V8_BIT =7C =5C
> > -					MFC_V10_BIT)
> > -=23define MFC_V7PLUS_BITS		(MFC_V7_BIT =7C MFC_V8_BIT =7C
> MFC_V10_BIT)
> > +					MFC_V10_BIT =7C MFC_V12_BIT)
> > +=23define MFC_V7PLUS_BITS		(MFC_V7_BIT =7C MFC_V8_BIT =7C
> MFC_V10_BIT =7C =5C
> > +					MFC_V12_BIT)
> > +
> > +=23define MFC_V10PLUS_BITS	(MFC_V10_BIT =7C MFC_V12_BIT)
> >
> >  =23endif /* S5P_MFC_COMMON_H_ */
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > index 54b54b2fa9b1..b49159142c53 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > =40=40 -130,7 +130,7 =40=40 int s5p_mfc_reset(struct s5p_mfc_dev *dev)
> >  			mfc_write(dev, 0, S5P_FIMV_REG_CLEAR_BEGIN_V6
> + (i*4));
> >
> >  		/* check bus reset control before reset */
> > -		if (dev->risc_on)
> > +		if (dev->risc_on && =21IS_MFCV12(dev))
> >  			if (s5p_mfc_bus_reset(dev))
> >  				return -EIO;
> >  		/* Reset
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > index 268ffe4da53c..e219cbcd86d5 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > =40=40 -146,7 +146,7 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D=
 =7B
> >  		.codec_mode	=3D S5P_FIMV_CODEC_HEVC_DEC,
> >  		.type		=3D MFC_FMT_DEC,
> >  		.num_planes	=3D 1,
> > -		.versions	=3D MFC_V10_BIT,
> > +		.versions	=3D MFC_V10PLUS_BITS,
> >  		.flags		=3D V4L2_FMT_FLAG_DYN_RESOLUTION =7C
> >
> V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM,
> >  	=7D,
> > =40=40 -155,7 +155,7 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D=
 =7B
> >  		.codec_mode	=3D S5P_FIMV_CODEC_VP9_DEC,
> >  		.type		=3D MFC_FMT_DEC,
> >  		.num_planes	=3D 1,
> > -		.versions	=3D MFC_V10_BIT,
> > +		.versions	=3D MFC_V10PLUS_BITS,
> >  		.flags		=3D V4L2_FMT_FLAG_DYN_RESOLUTION,
> >  	=7D,
> >  =7D;
> > =40=40 -355,7 +355,7 =40=40 static int vidioc_g_fmt(struct file *file, =
void *priv,
> struct v4l2_format *f)
> >  		pix_mp->width =3D ctx->buf_width;
> >  		pix_mp->height =3D ctx->buf_height;
> >  		pix_mp->field =3D V4L2_FIELD_NONE;
> > -		pix_mp->num_planes =3D 2;
> > +		pix_mp->num_planes =3D ctx->dst_fmt->num_planes;
> >  		/* Set pixelformat to the format in which MFC
> >  		   outputs the decoded frame */
> >  		pix_mp->pixelformat =3D ctx->dst_fmt->fourcc; diff --git
> > a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > index f62703cebb77..e4d6e7c117b5 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > =40=40 -92,7 +92,7 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D =
=7B
> >  		.codec_mode	=3D S5P_FIMV_CODEC_HEVC_ENC,
> >  		.type		=3D MFC_FMT_ENC,
> >  		.num_planes	=3D 1,
> > -		.versions	=3D MFC_V10_BIT,
> > +		.versions	=3D MFC_V10PLUS_BITS,
> >  	=7D,
> >  =7D;
> >
> > =40=40 -1179,7 +1179,8 =40=40 static int enc_post_seq_start(struct s5p_=
mfc_ctx
> *ctx)
> >  		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) =7B
> >  			ctx->scratch_buf_size =3D s5p_mfc_hw_call(dev-
> >mfc_ops,
> >  					get_e_min_scratch_buf_size, dev);
> > -			ctx->bank1.size +=3D ctx->scratch_buf_size;
> > +			if (=21IS_MFCV12(dev))
> > +				ctx->bank1.size +=3D ctx->scratch_buf_size;
> >  		=7D
> >  		ctx->state =3D MFCINST_HEAD_PRODUCED;
> >  	=7D
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > index b9831275f3ab..87ac56756a16 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > =40=40 -166,9 +166,9 =40=40 struct s5p_mfc_regs =7B
> >  	void __iomem *d_decoded_third_addr;/* only v7 */
> >  	void __iomem *d_used_dpb_flag_upper;/* v7 and v8 */
> >  	void __iomem *d_used_dpb_flag_lower;/* v7 and v8 */
> > -	void __iomem *d_min_scratch_buffer_size; /* v10 */
> > -	void __iomem *d_static_buffer_addr; /* v10 */
> > -	void __iomem *d_static_buffer_size; /* v10 */
> > +	void __iomem *d_min_scratch_buffer_size; /* v10 and v12 */
> > +	void __iomem *d_static_buffer_addr; /* v10 and v12 */
> > +	void __iomem *d_static_buffer_size; /* v10 and v12 */
> >
> >  	/* encoder registers */
> >  	void __iomem *e_frame_width;
> > =40=40 -268,7 +268,7 =40=40 struct s5p_mfc_regs =7B
> >  	void __iomem *e_vp8_hierarchical_qp_layer0;/* v7 and v8 */
> >  	void __iomem *e_vp8_hierarchical_qp_layer1;/* v7 and v8 */
> >  	void __iomem *e_vp8_hierarchical_qp_layer2;/* v7 and v8 */
> > -	void __iomem *e_min_scratch_buffer_size; /* v10 */
> > +	void __iomem *e_min_scratch_buffer_size; /* v10 and v12 */
> >  	void __iomem *e_num_t_layer; /* v10 */
> >  	void __iomem *e_hier_qp_layer0; /* v10 */
> >  	void __iomem *e_hier_bit_rate_layer0; /* v10 */ diff --git
> > a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > index 882166e4ac50..fb3f0718821d 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > =40=40 -60,12 +60,14 =40=40 static void
> > s5p_mfc_release_dec_desc_buffer_v6(struct s5p_mfc_ctx *ctx)  static
> > int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)  =7B
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> > -	unsigned int mb_width, mb_height;
> > +	unsigned int mb_width, mb_height, width64, height32;
> >  	unsigned int lcu_width =3D 0, lcu_height =3D 0;
> >  	int ret;
> >
> >  	mb_width =3D MB_WIDTH(ctx->img_width);
> >  	mb_height =3D MB_HEIGHT(ctx->img_height);
> > +	width64 =3D ALIGN(ctx->img_width, 64);
> > +	height32 =3D ALIGN(ctx->img_height, 32);
> >
> >  	if (ctx->type =3D=3D MFCINST_DECODER) =7B
> >  		mfc_debug(2, =22Luma size:%d Chroma size:%d MV
> size:%d=5Cn=22, =40=40 -82,7
> > +84,44 =40=40 static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_=
ctx
> *ctx)
> >  			ctx->tmv_buffer_size =3D
> S5P_FIMV_NUM_TMV_BUFFERS_V6 *
> >
> 	ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
> >  			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> > -		if (IS_MFCV10_PLUS(dev)) =7B
> > +		if (IS_MFCV12(dev)) =7B
> > +			lcu_width =3D S5P_MFC_LCU_WIDTH(ctx->img_width);
> > +			lcu_height =3D S5P_MFC_LCU_HEIGHT(ctx-
> >img_height);
> > +			if (ctx->codec_mode =3D=3D
> S5P_FIMV_CODEC_HEVC_ENC &&
> > +								ctx->is_10bit)
> =7B
> > +				ctx->luma_dpb_size =3D
> > +					width64 * height32 +
> > +					ALIGN(DIV_ROUND_UP(lcu_width *
> 32, 4),
> > +							16) * height32 + 128;
> > +				if (ctx->is_422)
> > +					ctx->chroma_dpb_size =3D
> > +						ctx->luma_dpb_size;
> > +				else
> > +					ctx->chroma_dpb_size =3D
> > +						width64 * height32 / 2 +
> > +
> 	ALIGN(DIV_ROUND_UP(lcu_width *
> > +						32, 4), 16) * height32 / 2 +
> 128;
> > +			=7D else if (ctx->codec_mode =3D=3D
> S5P_FIMV_CODEC_VP9_ENC &&
> > +					ctx->is_10bit) =7B
> > +				ctx->luma_dpb_size =3D
> > +					ALIGN(ctx->img_width * 2, 128) *
> > +					height32 + 64;
> > +				ctx->chroma_dpb_size =3D
> > +					ALIGN(ctx->img_width * 2, 128) *
> > +					height32 / 2 + 64;
> > +			=7D else =7B
> > +				ctx->luma_dpb_size =3D
> > +					width64 * height32 + 64;
> > +				if (ctx->is_422)
> > +					ctx->chroma_dpb_size =3D
> > +						ctx->luma_dpb_size;
> > +				else
> > +					ctx->chroma_dpb_size =3D
> > +						width64 * height32 / 2 + 64;
> > +			=7D
> > +			ctx->luma_dpb_size =3D ALIGN(ctx->luma_dpb_size +
> 256, SZ_2K);
> > +			ctx->chroma_dpb_size =3D ALIGN(ctx-
> >chroma_dpb_size + 256, SZ_2K);
> > +		=7D else if (IS_MFCV10_PLUS(dev)) =7B
> >  			lcu_width =3D S5P_MFC_LCU_WIDTH(ctx->img_width);
> >  			lcu_height =3D S5P_MFC_LCU_HEIGHT(ctx-
> >img_height);
> >  			if (ctx->codec_mode =21=3D
> S5P_FIMV_CODEC_HEVC_ENC) =7B =40=40 -230,7
> > +269,11 =40=40 static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
> >  			DEC_VP9_STATIC_BUFFER_SIZE;
> >  		break;
> >  	case S5P_MFC_CODEC_H264_ENC:
> > -		if (IS_MFCV10_PLUS(dev)) =7B
> > +		if (IS_MFCV12(dev)) =7B
> > +			mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> > +			ctx->me_buffer_size =3D
> > +				ENC_V120_H264_ME_SIZE(mb_width,
> mb_height);
> > +		=7D else if (IS_MFCV10_PLUS(dev)) =7B
> >  			mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> >  			ctx->me_buffer_size =3D
> >  			ALIGN(ENC_V100_H264_ME_SIZE(mb_width,
> mb_height), 16); =40=40 -254,7
> > +297,11 =40=40 static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
> >  		break;
> >  	case S5P_MFC_CODEC_MPEG4_ENC:
> >  	case S5P_MFC_CODEC_H263_ENC:
> > -		if (IS_MFCV10_PLUS(dev)) =7B
> > +		if (IS_MFCV12(dev)) =7B
> > +			mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> > +			ctx->me_buffer_size =3D
> > +				ENC_V120_MPEG4_ME_SIZE(mb_width,
> mb_height);
> > +		=7D else if (IS_MFCV10_PLUS(dev)) =7B
> >  			mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> >  			ctx->me_buffer_size =3D
> >
> 	ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
> > =40=40 -273,7 +320,11 =40=40 static int s5p_mfc_alloc_codec_buffers_v6(=
struct
> s5p_mfc_ctx *ctx)
> >  		ctx->bank2.size =3D 0;
> >  		break;
> >  	case S5P_MFC_CODEC_VP8_ENC:
> > -		if (IS_MFCV10_PLUS(dev)) =7B
> > +		if (IS_MFCV12(dev)) =7B
> > +			mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> > +			ctx->me_buffer_size =3D
> > +				ENC_V120_VP8_ME_SIZE(mb_width,
> mb_height);
> > +		=7D else if (IS_MFCV10_PLUS(dev)) =7B
> >  			mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> >  			ctx->me_buffer_size =3D
> >  				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width,
> mb_height), =40=40 -297,9
> > +348,14 =40=40 static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
> >  		ctx->bank2.size =3D 0;
> >  		break;
> >  	case S5P_MFC_CODEC_HEVC_ENC:
> > +		if (IS_MFCV12(dev))
> > +			ctx->me_buffer_size =3D
> > +				ENC_V120_HEVC_ME_SIZE(lcu_width,
> lcu_height);
> > +		else
> > +			ctx->me_buffer_size =3D
> > +				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
> > +							lcu_height), 16);
> >  		mfc_debug(2, =22Use min scratch buffer size=5Cn=22);
> > -		ctx->me_buffer_size =3D
> > -			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
> lcu_height), 16);
> >  		ctx->scratch_buf_size =3D ALIGN(ctx->scratch_buf_size, 256);
> >  		ctx->bank1.size =3D
> >  			ctx->scratch_buf_size + ctx->tmv_buffer_size + =40=40
> -452,12 +508,15
> > =40=40 static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx=
)
> >
> >  	if (ctx->codec_mode =3D=3D S5P_MFC_CODEC_H264_DEC =7C=7C
> >  			ctx->codec_mode =3D=3D
> S5P_MFC_CODEC_H264_MVC_DEC) =7B
> > -		if (IS_MFCV10_PLUS(dev)) =7B
> > -			ctx->mv_size =3D S5P_MFC_DEC_MV_SIZE_V10(ctx-
> >img_width,
> > -					ctx->img_height);
> > +		if (IS_MFCV12(dev)) =7B
> > +			ctx->mv_size =3D S5P_MFC_DEC_MV_SIZE(ctx-
> >img_width,
> > +					ctx->img_height, 1024);
> > +		=7D else if (IS_MFCV10_PLUS(dev)) =7B
> > +			ctx->mv_size =3D S5P_MFC_DEC_MV_SIZE(ctx-
> >img_width,
> > +					ctx->img_height, 512);
> >  		=7D else =7B
> > -			ctx->mv_size =3D S5P_MFC_DEC_MV_SIZE_V6(ctx-
> >img_width,
> > -					ctx->img_height);
> > +			ctx->mv_size =3D S5P_MFC_DEC_MV_SIZE(ctx-
> >img_width,
> > +					ctx->img_height, 128);
> >  		=7D
> >  	=7D else if (ctx->codec_mode =3D=3D S5P_MFC_CODEC_HEVC_DEC) =7B
> >  		ctx->mv_size =3D s5p_mfc_dec_hevc_mv_size(ctx-
> >img_width,
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> > index e4dd03c5454c..30269f3e68e8 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> > =40=40 -19,10 +19,8 =40=40
> >
> >  =23define MB_WIDTH(x_size)		DIV_ROUND_UP(x_size, 16)
> >  =23define MB_HEIGHT(y_size)		DIV_ROUND_UP(y_size, 16)
> > -=23define S5P_MFC_DEC_MV_SIZE_V6(x, y)	(MB_WIDTH(x) * =5C
> > -					(((MB_HEIGHT(y)+1)/2)*2) * 64 +
> 128)
> > -=23define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * =5C
> > -					(((MB_HEIGHT(y)+1)/2)*2) * 64 +
> 512)
> > +=23define S5P_MFC_DEC_MV_SIZE(x, y, offset)	(MB_WIDTH(x) * =5C
> > +					(((MB_HEIGHT(y)+1)/2)*2) * 64 +
> offset)
> >  =23define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
> >  =23define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
> >


