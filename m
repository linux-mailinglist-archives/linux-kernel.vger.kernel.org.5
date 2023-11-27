Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8863D7F9AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjK0Hbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjK0Hb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:31:29 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19998139
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:31:31 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231127073129epoutp02555130f3b77a16e0d1c55ed8d8996300~bamptGjW01991219912epoutp02N
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:31:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231127073129epoutp02555130f3b77a16e0d1c55ed8d8996300~bamptGjW01991219912epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701070289;
        bh=IKn9AOBsj+zoLKWYbmUXzMVf6Bv49HHHc/KZNn2nOWg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bQQqIXRa3tErCHCP4BSWU37L/yb9pUfjvsvl9g7ikG9krAR2+/ci5ZcvDmexM8N4U
         0qXmugUAQc8569Y9bbRDzwqZawZyToSjhXQswTXcp/KBN8DCsF5zrjWchzA3QPgaVI
         KtX2mzo8WsWvBmRuPWGry3WSJc/tNT2Ugw8NbxkI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231127073128epcas5p11968e8f1928c8e2eba143f84541e5f32~bamogGQ0f0480504805epcas5p1B;
        Mon, 27 Nov 2023 07:31:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sdy261qDSz4x9Q2; Mon, 27 Nov
        2023 07:31:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.38.09634.EC544656; Mon, 27 Nov 2023 16:31:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231127070149epcas5p404894a876a06df2a9e5a42b392b1db60~baMwGzbJo2610926109epcas5p4k;
        Mon, 27 Nov 2023 07:01:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231127070149epsmtrp279ad5aaaecca4eff793ebd2020ea661c~baMwFbP0y0187001870epsmtrp2w;
        Mon, 27 Nov 2023 07:01:49 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-36-656445ce2a4e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.B9.08817.DDE34656; Mon, 27 Nov 2023 16:01:49 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231127070146epsmtip19da1e079c4120e5d2633ebb6880c4061~baMtB7FYl1154111541epsmtip17;
        Mon, 27 Nov 2023 07:01:46 +0000 (GMT)
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
In-Reply-To: <9e6793e3-d824-4117-990d-924f8ad69d4e@xs4all.nl>
Subject: RE: [Patch v4 04/11] media: s5p-mfc: Add YV12 and I420 multiplanar
 format support
Date:   Mon, 27 Nov 2023 12:31:45 +0530
Message-ID: <0fe501da20ff$978c8910$c6a59b30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQIF15oBArq90LwB1jKw7q4/gtwg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc29ve8tc8QoYjmQzrIoElNJubTnVMUlEdh38gTFxxkzhpr0B
        pLS1DwXmMjCCWctgbEygMDaeIhRHYDzGQ95bVgUEChtKA4xtPEaGwhhD2GLLBeW/z+/x/Z3f
        95wcLsstC/fixqn0tFZFKfmcPVhjj59/wMD7ClrYlceBnUtdGJwqauTA0qezKJwsXcFgd30D
        Di3tAyj88WYnG17uHWDDpq67GBzvvI7CoXw7BjPnplmwbmaMDacXjsORlkIOzKhtYMO8wV9Q
        WNNrx2H57SEUVtRtorCk4TEO09p7cfhdahk7xJO0FFkQ8nbZMou8brbjZGnbPErWVZ3hkBNj
        bRyyvuw0mdb3D0ZmXqtCyOffXsLJlbpXSevqCh6599P4w7E0paC13rRKrlbEqWKC+eEfRb0X
        JZEKRQEiGQzie6uoBDqYHxoRGRAWp3T45nt/RSkNjlQkpdPxA48c1qoNeto7Vq3TB/NpjUKp
        EWsEOipBZ1DFCFS0/m2RUHhQ4miMjo8t3zTimt9q0MTBhVY8BRleRYyICxcQYpA6W8kxInu4
        bkQrAhZX7BgTLCMg3TbHZoInCBjcXMR3JCOWjO2udgRUj45v62cR8GttNdvZxSECwaQ1Y0vu
        QTQjoHi6H3UWWIQJA4XpB53sQgSDvEUr5mR34gRImRveEmOED3j26AHLyTxCBtLXLuAMvwRu
        5d/DmDlvgorihyxmJW+wfr9iS+tBhIGO1jscpscT9K1nsJxLAKLJBWRlrToKXEcQCn5oJxit
        O1i4eW3bmhdYedTOYVgOZkrmt+crwdW2HIzhd0GnrRBzjmERfuBqSyCT3g8uWn/etugKzm7c
        Q5k8DzQX7fAboHDiKZvhfaCnuhw5h/DNu5yZdzkz73Jg/v+0KwhWhbxCa3QJMbROohGp6K//
        e3O5OqEO2foZ/h80I/apvwTdCMpFuhHAZfE9eIK/5bQbT0ElJdNadZTWoKR13YjEcd3ZLK+X
        5WrH11Lpo0RimVAslUrFskNSEd+T9zDtksKNiKH0dDxNa2jtjg7luniloPuNa/1/dITmNMiD
        oieqTGLXytdDe/tmtSVn7cMdgXIjoMZ9TKeShsPFexWf3KV8P7b3P6ESQ9YGPHTJNq7nKVm0
        u78tU1TgIzs2tLg0L4nJf+15cZvii/PAcsL3Tn2QX25G7pfSghZUHpQCLu+L+FNhrTXVLN46
        kHruyIvdiUDYWhay1BieaKnsOaO0Ut+PJW/e4AjqNw4NHPP57K3zG7ami9ZlX15c7syaa8Qy
        1/BANXa8ZaH5hulk84FRQ7U0Sfr5lM3nG8S2vrww23q0dK6nOPpKQva4R879OWNB5bikHqf0
        p8NGRj+8YI5KPiowbWQ/fuenk7/bXtA2TlLPXPmYLpYS+bO0OupfEeZwZ6IEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGec9l52y5OE3Lt1kRsz5k6DIC37DCMORAkKOCQroNdzDLmWxm
        9ytpKUs0s3Kly1wrbZkt7bZZXrYuQiuduDJtaa1WizQvldE03Cr89oPneX78P/xpXDRCiOnU
        9ExOlS5Pk/AExO1myazI7mUKbsGbynDU0NdIoLdlt3mo4udHDLkqBgnUdKuOQsZ6O4auPG4g
        kc5qJ9Gdxl4CvWq4h6HWkm4C5Xt6cGR610Gins/rkOP+BR7S1NSR6NzzBxi6bu2m0GVnK4YM
        pt8YulQ3RKHseiuFjh3Rk3GhrLHMCFinfgBn72m7KbbC8gljTVW5PLarw8Jjb+kPsdm2XwSb
        X1sF2NGjpRQ7aJrFtgwPUrKgJMESBZeWmsWppMu2CLa23/xEZegrsN39nefJw8DgBXmAT0Nm
        EXQYNUQeENAixgxgQ7OHCgQz4FjOo78cDCtHP1KBkhvArrPvyfGAx0ihq0VDjgchjAVAm9no
        b+FMKQFHref/egcAzD/V5p/wmaXw3JcWYpyDmST4pNXjZ4KZC31fP+DjLGQWw5wfRVSAp8Cn
        Je/9HZyZD92v3P/ZUO7FA/fNhiNug98fwiTAh+aXvEAnFNpGNHgBCNZOUGknqLQTVNoJk4uA
        qALTuQy1MkWpjs5YmM7tilLLleqd6SlRyTuUJuD/joiIu8BS1R/VBDAaNAFI45IQYdS3ZE4k
        VMj37OVUOzardqZx6iYQRhOSUOF370mFiEmRZ3LbOS6DU/1LMZovPoxps71FLmldn+HZlv2n
        daFzXGuaxUX5qWN2p+LhI8fuE9K14k3JX+KvOmzN/VnYmM/buTx+IHl1jaFl8qBpY5zet6tQ
        ueRaNenJtS7sz0nrlJq/bw86mNBGTHHZJfNEebblhvBhWW+fxxAiPZDoU74eLoy28Pfp9B2x
        9hmy4hW6Amyo82dqeWXpnSz9kDuop+SmOD7RGLNtT2zCtjOZqwpiX0wKj6w54Amyro2Y+bj+
        c/WNQplQaN6rOXG2cYMqbprv6dBU+kjx1JW6N78dw2PliZExvNyYFWG12o7adgFfETYp/tfx
        pKtPInuCe4urnbL1HN3Od3YV/zjatmbyRb2EUG+VR0fgKrX8D8KYMzaMAwAA
X-CMS-MailID: 20231127070149epcas5p404894a876a06df2a9e5a42b392b1db60
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
        <9e6793e3-d824-4117-990d-924f8ad69d4e@xs4all.nl>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

> -----Original Message-----
> From: Hans Verkuil <hverkuil-cisco=40xs4all.nl>
> Sent: 22 November 2023 21:11
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
> Subject: Re: =5BPatch v4 04/11=5D media: s5p-mfc: Add YV12 and I420 multi=
planar
> format support
>=20
> On 25/10/2023 12:22, Aakarsh Jain wrote:
> > YV12 and I420 format (3-plane) support is added. Stride information is
> > added to all formats and planes since it is necessary for YV12/I420
> > which are different from width.
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smithatmurthy=40gmail.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   =7C   2 +
> >  .../platform/samsung/s5p-mfc/regs-mfc-v7.h    =7C   1 +
> >  .../platform/samsung/s5p-mfc/regs-mfc-v8.h    =7C   3 +
> >  .../platform/samsung/s5p-mfc/s5p_mfc_common.h =7C   4 +
> >  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    =7C  45 ++++-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    =7C  86 +++++++--
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    =7C   6 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c =7C  12 +-
> > .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c =7C 168
> +++++++++++++++---
> >  9 files changed, 281 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > index 6c68a45082d0..70464f47c1f9 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> > =40=40 -26,6 +26,8 =40=40
> >  =23define MFC_VERSION_V12			0xC0
> >  =23define MFC_NUM_PORTS_V12		1
> >  =23define S5P_FIMV_CODEC_VP9_ENC		27
> > +=23define MFC_CHROMA_PAD_BYTES_V12        256
> > +=23define S5P_FIMV_D_ALIGN_PLANE_SIZE_V12 256
> >
> >  /* Encoder buffer size for MFCv12 */
> >  =23define ENC_V120_BASE_SIZE(x, y) =5C
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> > b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> > index 4a7adfdaa359..50f9bf0603c1 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> > =40=40 -24,6 +24,7 =40=40
> >
> >  =23define S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7
> 	0xfa70
> >  =23define S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7
> 	0xfa74
> > +=23define S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7
> 	0xfa78
> >
> >  =23define S5P_FIMV_E_VP8_OPTIONS_V7			0xfdb0
> >  =23define S5P_FIMV_E_VP8_FILTER_OPTIONS_V7		0xfdb4
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> > b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> > index 162e3c7e920f..0ef9eb2dff22 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> > =40=40 -17,13 +17,16 =40=40
> >  =23define S5P_FIMV_D_MIN_SCRATCH_BUFFER_SIZE_V8	0xf108
> >  =23define S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8	0xf144
> >  =23define S5P_FIMV_D_SECOND_PLANE_DPB_SIZE_V8	0xf148
> > +=23define S5P_FIMV_D_THIRD_PLANE_DPB_SIZE_V8	0xf14C
> >  =23define S5P_FIMV_D_MV_BUFFER_SIZE_V8		0xf150
> >
> >  =23define S5P_FIMV_D_FIRST_PLANE_DPB_STRIDE_SIZE_V8	0xf138
> >  =23define S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8
> 	0xf13c
> > +=23define S5P_FIMV_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8
> 	0xf140
> >
> >  =23define S5P_FIMV_D_FIRST_PLANE_DPB_V8		0xf160
> >  =23define S5P_FIMV_D_SECOND_PLANE_DPB_V8		0xf260
> > +=23define S5P_FIMV_D_THIRD_PLANE_DPB_V8		0xf360
> >  =23define S5P_FIMV_D_MV_BUFFER_V8			0xf460
> >
> >  =23define S5P_FIMV_D_NUM_MV_V8			0xf134
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > index dd2e9f7704ab..9a39cccfe002 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> > =40=40 -56,6 +56,7 =40=40
> >  =23define MFC_NO_INSTANCE_SET	-1
> >  =23define MFC_ENC_CAP_PLANE_COUNT	1
> >  =23define MFC_ENC_OUT_PLANE_COUNT	2
> > +=23define VB2_MAX_PLANE_COUNT	3
> >  =23define STUFF_BYTE		4
> >  =23define MFC_MAX_CTRLS		128
> >
> > =40=40 -181,6 +182,7 =40=40 struct s5p_mfc_buf =7B
> >  		struct =7B
> >  			size_t luma;
> >  			size_t chroma;
> > +			size_t chroma_1;
> >  		=7D raw;
> >  		size_t stream;
> >  	=7D cookie;
> > =40=40 -657,6 +659,7 =40=40 struct s5p_mfc_ctx =7B
> >
> >  	int luma_size;
> >  	int chroma_size;
> > +	int chroma_size_1;
> >  	int mv_size;
> >
> >  	unsigned long consumed_stream;
> > =40=40 -722,6 +725,7 =40=40 struct s5p_mfc_ctx =7B
> >  	size_t scratch_buf_size;
> >  	int is_10bit;
> >  	int is_422;
> > +	int stride=5BVB2_MAX_PLANE_COUNT=5D;
> >  =7D;
> >
> >  /*
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > index e219cbcd86d5..317f796fffa1 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> > =40=40 -56,6 +56,20 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D =
=7B
> >  		.num_planes	=3D 2,
> >  		.versions	=3D MFC_V6PLUS_BITS,
> >  	=7D,
> > +	=7B
> > +		.fourcc         =3D V4L2_PIX_FMT_YUV420M,
> > +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> > +		.type           =3D MFC_FMT_RAW,
> > +		.num_planes     =3D 3,
> > +		.versions       =3D MFC_V12_BIT,
> > +	=7D,
> > +	=7B
> > +		.fourcc         =3D V4L2_PIX_FMT_YVU420M,
> > +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> > +		.type           =3D MFC_FMT_RAW,
> > +		.num_planes     =3D 3,
> > +		.versions       =3D MFC_V12_BIT
> > +	=7D,
> >  	=7B
> >  		.fourcc		=3D V4L2_PIX_FMT_H264,
> >  		.codec_mode	=3D S5P_MFC_CODEC_H264_DEC,
> > =40=40 -359,10 +373,15 =40=40 static int vidioc_g_fmt(struct file *file=
, void *priv,
> struct v4l2_format *f)
> >  		/* Set pixelformat to the format in which MFC
> >  		   outputs the decoded frame */
> >  		pix_mp->pixelformat =3D ctx->dst_fmt->fourcc;
> > -		pix_mp->plane_fmt=5B0=5D.bytesperline =3D ctx->buf_width;
> > +		pix_mp->plane_fmt=5B0=5D.bytesperline =3D ctx->stride=5B0=5D;
> >  		pix_mp->plane_fmt=5B0=5D.sizeimage =3D ctx->luma_size;
> > -		pix_mp->plane_fmt=5B1=5D.bytesperline =3D ctx->buf_width;
> > +		pix_mp->plane_fmt=5B1=5D.bytesperline =3D ctx->stride=5B1=5D;
> >  		pix_mp->plane_fmt=5B1=5D.sizeimage =3D ctx->chroma_size;
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M) =7B
> > +			pix_mp->plane_fmt=5B2=5D.bytesperline =3D ctx->stride=5B2=5D;
> > +			pix_mp->plane_fmt=5B2=5D.sizeimage =3D ctx-
> >chroma_size_1;
> > +		=7D
> >  	=7D else if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) =7B
> >  		/* This is run on OUTPUT
> >  		   The buffer contains compressed image =40=40 -937,6 +956,9
> =40=40 static
> > int s5p_mfc_queue_setup(struct vb2_queue *vq,
> >  		   vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) =7B
> >  		/* Output plane count is 2 - one for Y and one for CbCr */
> >  		*plane_count =3D 2;
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
>=20
> These misalignments produce a lot of checkpatch warnings.
>=20
> Make sure you run your patch series through 'checkpatch.pl --strict'=21
>=20
> Regards,
>=20
> 	Hans
>=20
Thanks for pointing out. Will fix it in next series.

Thanks for the review.
> > +			*plane_count =3D 3;
> >  		/* Setup buffer count */
> >  		if (*buf_count < ctx->pb_count)
> >  			*buf_count =3D ctx->pb_count;
> > =40=40 -955,12 +977,17 =40=40 static int s5p_mfc_queue_setup(struct
> vb2_queue *vq,
> >  	    vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) =7B
> >  		psize=5B0=5D =3D ctx->luma_size;
> >  		psize=5B1=5D =3D ctx->chroma_size;
> > -
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +			psize=5B2=5D =3D ctx->chroma_size_1;
> >  		if (IS_MFCV6_PLUS(dev))
> >  			alloc_devs=5B0=5D =3D ctx->dev->mem_dev=5BBANK_L_CTX=5D;
> >  		else
> >  			alloc_devs=5B0=5D =3D ctx->dev->mem_dev=5BBANK_R_CTX=5D;
> >  		alloc_devs=5B1=5D =3D ctx->dev->mem_dev=5BBANK_L_CTX=5D;
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +			alloc_devs=5B2=5D =3D ctx->dev->mem_dev=5BBANK_L_CTX=5D;
> >  	=7D else if (vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
> >  		   ctx->state =3D=3D MFCINST_INIT) =7B
> >  		psize=5B0=5D =3D ctx->dec_src_buf_size;
> > =40=40 -994,12 +1021,24 =40=40 static int s5p_mfc_buf_init(struct vb2_b=
uffer
> *vb)
> >  			mfc_err(=22Plane buffer (CAPTURE) is too small=5Cn=22);
> >  			return -EINVAL;
> >  		=7D
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M) =7B
> > +			if (vb2_plane_size(vb, 2) < ctx->chroma_size_1) =7B
> > +				mfc_err(=22Plane buffer (CAPTURE) is too
> small=5Cn=22);
> > +				return -EINVAL;
> > +			=7D
> > +		=7D
> >  		i =3D vb->index;
> >  		ctx->dst_bufs=5Bi=5D.b =3D vbuf;
> >  		ctx->dst_bufs=5Bi=5D.cookie.raw.luma =3D
> >
> 	vb2_dma_contig_plane_dma_addr(vb, 0);
> >  		ctx->dst_bufs=5Bi=5D.cookie.raw.chroma =3D
> >
> 	vb2_dma_contig_plane_dma_addr(vb, 1);
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M) =7B
> > +			ctx->dst_bufs=5Bi=5D.cookie.raw.chroma_1 =3D
> > +
> 	vb2_dma_contig_plane_dma_addr(vb, 2);
> > +		=7D
> >  		ctx->dst_bufs_cnt++;
> >  	=7D else if (vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) =7B
> >  		if (IS_ERR_OR_NULL(ERR_PTR(
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > index e4d6e7c117b5..0eec04eb3ef3 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> > =40=40 -59,6 +59,20 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D =
=7B
> >  		.num_planes	=3D 2,
> >  		.versions	=3D MFC_V6PLUS_BITS,
> >  	=7D,
> > +	=7B
> > +		.fourcc         =3D V4L2_PIX_FMT_YUV420M,
> > +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> > +		.type           =3D MFC_FMT_RAW,
> > +		.num_planes     =3D 3,
> > +		.versions       =3D MFC_V12_BIT,
> > +	=7D,
> > +	=7B
> > +		.fourcc         =3D V4L2_PIX_FMT_YVU420M,
> > +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> > +		.type           =3D MFC_FMT_RAW,
> > +		.num_planes     =3D 3,
> > +		.versions       =3D MFC_V12_BIT,
> > +	=7D,
> >  	=7B
> >  		.fourcc		=3D V4L2_PIX_FMT_H264,
> >  		.codec_mode	=3D S5P_MFC_CODEC_H264_ENC,
> > =40=40 -1193,14 +1207,20 =40=40 static int enc_pre_frame_start(struct
> s5p_mfc_ctx *ctx)
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >  	struct s5p_mfc_buf *dst_mb;
> >  	struct s5p_mfc_buf *src_mb;
> > -	unsigned long src_y_addr, src_c_addr, dst_addr;
> > +	unsigned long src_y_addr, src_c_addr, src_c_1_addr, dst_addr;
> >  	unsigned int dst_size;
> >
> >  	src_mb =3D list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
> >  	src_y_addr =3D vb2_dma_contig_plane_dma_addr(&src_mb->b-
> >vb2_buf, 0);
> >  	src_c_addr =3D vb2_dma_contig_plane_dma_addr(&src_mb->b-
> >vb2_buf, 1);
> > +	if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +			ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> > +		src_c_1_addr =3D
> > +			vb2_dma_contig_plane_dma_addr(&src_mb->b-
> >vb2_buf, 2);
> > +	else
> > +		src_c_1_addr =3D 0;
> >  	s5p_mfc_hw_call(dev->mfc_ops, set_enc_frame_buffer, ctx,
> > -							src_y_addr,
> src_c_addr);
> > +					src_y_addr, src_c_addr,
> src_c_1_addr);
> >
> >  	dst_mb =3D list_entry(ctx->dst_queue.next, struct s5p_mfc_buf, list);
> >  	dst_addr =3D vb2_dma_contig_plane_dma_addr(&dst_mb->b-
> >vb2_buf, 0); =40=40
> > -1215,8 +1235,8 =40=40 static int enc_post_frame_start(struct s5p_mfc_c=
tx
> > *ctx)  =7B
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >  	struct s5p_mfc_buf *mb_entry;
> > -	unsigned long enc_y_addr =3D 0, enc_c_addr =3D 0;
> > -	unsigned long mb_y_addr, mb_c_addr;
> > +	unsigned long enc_y_addr =3D 0, enc_c_addr =3D 0, enc_c_1_addr =3D 0;
> > +	unsigned long mb_y_addr, mb_c_addr, mb_c_1_addr;
> >  	int slice_type;
> >  	unsigned int strm_size;
> >  	bool src_ready;
> > =40=40 -1229,14 +1249,21 =40=40 static int enc_post_frame_start(struct
> s5p_mfc_ctx *ctx)
> >  		  mfc_read(dev, S5P_FIMV_ENC_SI_PIC_CNT));
> >  	if (slice_type >=3D 0) =7B
> >  		s5p_mfc_hw_call(dev->mfc_ops, get_enc_frame_buffer,
> ctx,
> > -				&enc_y_addr, &enc_c_addr);
> > +				&enc_y_addr, &enc_c_addr,
> &enc_c_1_addr);
> >  		list_for_each_entry(mb_entry, &ctx->src_queue, list) =7B
> >  			mb_y_addr =3D vb2_dma_contig_plane_dma_addr(
> >  					&mb_entry->b->vb2_buf, 0);
> >  			mb_c_addr =3D vb2_dma_contig_plane_dma_addr(
> >  					&mb_entry->b->vb2_buf, 1);
> > -			if ((enc_y_addr =3D=3D mb_y_addr) &&
> > -						(enc_c_addr =3D=3D mb_c_addr))
> =7B
> > +			if (ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +				mb_c_1_addr =3D
> vb2_dma_contig_plane_dma_addr
> > +						(&mb_entry->b->vb2_buf,
> 2);
> > +			else
> > +				mb_c_1_addr =3D 0;
> > +			if ((enc_y_addr =3D=3D mb_y_addr)
> > +					&& (enc_c_addr =3D=3D mb_c_addr)
> > +					&& (enc_c_1_addr =3D=3D
> mb_c_1_addr)) =7B
> >  				list_del(&mb_entry->list);
> >  				ctx->src_queue_cnt--;
> >  				vb2_buffer_done(&mb_entry->b->vb2_buf,
> > =40=40 -1249,8 +1276,15 =40=40 static int enc_post_frame_start(struct
> s5p_mfc_ctx *ctx)
> >  					&mb_entry->b->vb2_buf, 0);
> >  			mb_c_addr =3D vb2_dma_contig_plane_dma_addr(
> >  					&mb_entry->b->vb2_buf, 1);
> > -			if ((enc_y_addr =3D=3D mb_y_addr) &&
> > -						(enc_c_addr =3D=3D mb_c_addr))
> =7B
> > +			if (ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +				mb_c_1_addr =3D
> vb2_dma_contig_plane_dma_addr(
> > +						&mb_entry->b->vb2_buf, 2);
> > +			else
> > +				mb_c_1_addr =3D 0;
> > +			if ((enc_y_addr =3D=3D mb_y_addr)
> > +					&& (enc_c_addr =3D=3D mb_c_addr)
> > +					&& (enc_c_1_addr =3D=3D
> mb_c_1_addr)) =7B
> >  				list_del(&mb_entry->list);
> >  				ctx->ref_queue_cnt--;
> >  				vb2_buffer_done(&mb_entry->b->vb2_buf,
> > =40=40 -1381,10 +1415,15 =40=40 static int vidioc_g_fmt(struct file *fi=
le, void
> *priv, struct v4l2_format *f)
> >  		pix_fmt_mp->pixelformat =3D ctx->src_fmt->fourcc;
> >  		pix_fmt_mp->num_planes =3D ctx->src_fmt->num_planes;
> >
> > -		pix_fmt_mp->plane_fmt=5B0=5D.bytesperline =3D ctx->buf_width;
> > +		pix_fmt_mp->plane_fmt=5B0=5D.bytesperline =3D ctx->stride=5B0=5D;
> >  		pix_fmt_mp->plane_fmt=5B0=5D.sizeimage =3D ctx->luma_size;
> > -		pix_fmt_mp->plane_fmt=5B1=5D.bytesperline =3D ctx->buf_width;
> > +		pix_fmt_mp->plane_fmt=5B1=5D.bytesperline =3D ctx->stride=5B1=5D;
> >  		pix_fmt_mp->plane_fmt=5B1=5D.sizeimage =3D ctx->chroma_size;
> > +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M) =7B
> > +			pix_fmt_mp->plane_fmt=5B2=5D.bytesperline =3D ctx-
> >stride=5B2=5D;
> > +			pix_fmt_mp->plane_fmt=5B2=5D.sizeimage =3D ctx-
> >chroma_size_1;
> > +		=7D
> >  	=7D else =7B
> >  		mfc_err(=22invalid buf type=5Cn=22);
> >  		return -EINVAL;
> > =40=40 -1468,9 +1507,14 =40=40 static int vidioc_s_fmt(struct file *fil=
e, void
> > *priv, struct v4l2_format *f)
> >
> >  		s5p_mfc_hw_call(dev->mfc_ops, enc_calc_src_size, ctx);
> >  		pix_fmt_mp->plane_fmt=5B0=5D.sizeimage =3D ctx->luma_size;
> > -		pix_fmt_mp->plane_fmt=5B0=5D.bytesperline =3D ctx->buf_width;
> > +		pix_fmt_mp->plane_fmt=5B0=5D.bytesperline =3D ctx->stride=5B0=5D;
> >  		pix_fmt_mp->plane_fmt=5B1=5D.sizeimage =3D ctx->chroma_size;
> > -		pix_fmt_mp->plane_fmt=5B1=5D.bytesperline =3D ctx->buf_width;
> > +		pix_fmt_mp->plane_fmt=5B1=5D.bytesperline =3D ctx->stride=5B1=5D;
> > +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M) =7B
> > +			pix_fmt_mp->plane_fmt=5B2=5D.bytesperline =3D ctx-
> >stride=5B2=5D;
> > +			pix_fmt_mp->plane_fmt=5B2=5D.sizeimage =3D ctx-
> >chroma_size_1;
> > +		=7D
> >
> >  		ctx->src_bufs_cnt =3D 0;
> >  		ctx->output_state =3D QUEUE_FREE;
> > =40=40 -2414,10 +2458,16 =40=40 static int s5p_mfc_queue_setup(struct
> > vb2_queue *vq,
> >
> >  		psize=5B0=5D =3D ctx->luma_size;
> >  		psize=5B1=5D =3D ctx->chroma_size;
> > +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +			psize=5B2=5D =3D ctx->chroma_size_1;
> >
> >  		if (IS_MFCV6_PLUS(dev)) =7B
> >  			alloc_devs=5B0=5D =3D ctx->dev->mem_dev=5BBANK_L_CTX=5D;
> >  			alloc_devs=5B1=5D =3D ctx->dev->mem_dev=5BBANK_L_CTX=5D;
> > +			if (ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +				alloc_devs=5B2=5D =3D ctx->dev-
> >mem_dev=5BBANK_L_CTX=5D;
> >  		=7D else =7B
> >  			alloc_devs=5B0=5D =3D ctx->dev->mem_dev=5BBANK_R_CTX=5D;
> >  			alloc_devs=5B1=5D =3D ctx->dev->mem_dev=5BBANK_R_CTX=5D;
> =40=40 -2456,6 +2506,10
> > =40=40 static int s5p_mfc_buf_init(struct vb2_buffer *vb)
> >
> 	vb2_dma_contig_plane_dma_addr(vb, 0);
> >  		ctx->src_bufs=5Bi=5D.cookie.raw.chroma =3D
> >
> 	vb2_dma_contig_plane_dma_addr(vb, 1);
> > +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +			ctx->src_bufs=5Bi=5D.cookie.raw.chroma_1 =3D
> > +
> 	vb2_dma_contig_plane_dma_addr(vb, 2);
> >  		ctx->src_bufs_cnt++;
> >  	=7D else =7B
> >  		mfc_err(=22invalid queue type: %d=5Cn=22, vq->type); =40=40 -2493,6
> +2547,12
> > =40=40 static int s5p_mfc_buf_prepare(struct vb2_buffer *vb)
> >  			mfc_err(=22plane size is too small for output=5Cn=22);
> >  			return -EINVAL;
> >  		=7D
> > +		if ((ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +		     ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) &&
> > +		    (vb2_plane_size(vb, 2) < ctx->chroma_size_1)) =7B
> > +			mfc_err(=22plane size is too small for output=5Cn=22);
> > +			return -EINVAL;
> > +		=7D
> >  	=7D else =7B
> >  		mfc_err(=22invalid queue type: %d=5Cn=22, vq->type);
> >  		return -EINVAL;
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > index 87ac56756a16..7c5e851c8191 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> > =40=40 -293,9 +293,11 =40=40 struct s5p_mfc_hw_ops =7B
> >  	int (*set_enc_stream_buffer)(struct s5p_mfc_ctx *ctx,
> >  			unsigned long addr, unsigned int size);
> >  	void (*set_enc_frame_buffer)(struct s5p_mfc_ctx *ctx,
> > -			unsigned long y_addr, unsigned long c_addr);
> > +			unsigned long y_addr, unsigned long c_addr,
> > +			unsigned long c_1_addr);
> >  	void (*get_enc_frame_buffer)(struct s5p_mfc_ctx *ctx,
> > -			unsigned long *y_addr, unsigned long *c_addr);
> > +			unsigned long *y_addr, unsigned long *c_addr,
> > +			unsigned long *c_1_addr);
> >  	void (*try_run)(struct s5p_mfc_dev *dev);
> >  	void (*clear_int_flags)(struct s5p_mfc_dev *dev);
> >  	int (*get_dspl_y_adr)(struct s5p_mfc_dev *dev); diff --git
> > a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> > index 28a06dc343fd..fcfaf125a5a1 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> > =40=40 -516,7 +516,8 =40=40 static int
> s5p_mfc_set_enc_stream_buffer_v5(struct
> > s5p_mfc_ctx *ctx,  =7D
> >
> >  static void s5p_mfc_set_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
> > -		unsigned long y_addr, unsigned long c_addr)
> > +		unsigned long y_addr, unsigned long c_addr,
> > +		unsigned long c_1_addr)
> >  =7B
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >
> > =40=40 -525,7 +526,8 =40=40 static void
> s5p_mfc_set_enc_frame_buffer_v5(struct
> > s5p_mfc_ctx *ctx,  =7D
> >
> >  static void s5p_mfc_get_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
> > -		unsigned long *y_addr, unsigned long *c_addr)
> > +		unsigned long *y_addr, unsigned long *c_addr,
> > +		unsigned long *c_1_addr)
> >  =7B
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >
> > =40=40 -1210,7 +1212,7 =40=40 static int s5p_mfc_run_enc_frame(struct
> s5p_mfc_ctx *ctx)
> >  	if (list_empty(&ctx->src_queue)) =7B
> >  		/* send null frame */
> >  		s5p_mfc_set_enc_frame_buffer_v5(ctx, dev-
> >dma_base=5BBANK_R_CTX=5D,
> > -						dev-
> >dma_base=5BBANK_R_CTX=5D);
> > +						dev-
> >dma_base=5BBANK_R_CTX=5D, 0);
> >  		src_mb =3D NULL;
> >  	=7D else =7B
> >  		src_mb =3D list_entry(ctx->src_queue.next, struct
> s5p_mfc_buf, =40=40
> > -1220,7 +1222,7 =40=40 static int s5p_mfc_run_enc_frame(struct s5p_mfc_=
ctx
> *ctx)
> >  			/* send null frame */
> >  			s5p_mfc_set_enc_frame_buffer_v5(ctx,
> >  						dev-
> >dma_base=5BBANK_R_CTX=5D,
> > -						dev-
> >dma_base=5BBANK_R_CTX=5D);
> > +						dev-
> >dma_base=5BBANK_R_CTX=5D, 0);
> >  			ctx->state =3D MFCINST_FINISHING;
> >  		=7D else =7B
> >  			src_y_addr =3D vb2_dma_contig_plane_dma_addr(
> =40=40 -1228,7 +1230,7 =40=40
> > static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
> >  			src_c_addr =3D vb2_dma_contig_plane_dma_addr(
> >  					&src_mb->b->vb2_buf, 1);
> >  			s5p_mfc_set_enc_frame_buffer_v5(ctx, src_y_addr,
> > -								src_c_addr);
> > +								src_c_addr,
> 0);
> >  			if (src_mb->flags & MFC_BUF_FLAG_EOS)
> >  				ctx->state =3D MFCINST_FINISHING;
> >  		=7D
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > index fb3f0718821d..e579c765e902 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> > =40=40 -494,16 +494,43 =40=40 static void s5p_mfc_dec_calc_dpb_size_v6(=
struct
> s5p_mfc_ctx *ctx)
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >  	ctx->buf_width =3D ALIGN(ctx->img_width,
> S5P_FIMV_NV12MT_HALIGN_V6);
> >  	ctx->buf_height =3D ALIGN(ctx->img_height,
> S5P_FIMV_NV12MT_VALIGN_V6);
> > +	ctx->chroma_size_1 =3D 0;
> >  	mfc_debug(2, =22SEQ Done: Movie dimensions %dx%d,=5Cn=22
> >  			=22buffer dimensions: %dx%d=5Cn=22, ctx->img_width,
> >  			ctx->img_height, ctx->buf_width, ctx->buf_height);
> >
> > -	ctx->luma_size =3D calc_plane(ctx->img_width, ctx->img_height);
> > -	ctx->chroma_size =3D calc_plane(ctx->img_width, (ctx->img_height >>
> 1));
> > +	switch (ctx->dst_fmt->fourcc) =7B
> > +	case V4L2_PIX_FMT_NV12M:
> > +	case V4L2_PIX_FMT_NV21M:
> > +		ctx->stride=5B0=5D =3D ALIGN(ctx->img_width,
> > +					S5P_FIMV_NV12MT_HALIGN_V6);
> > +		ctx->stride=5B1=5D =3D ALIGN(ctx->img_width,
> > +					S5P_FIMV_NV12MT_HALIGN_V6);
> > +		ctx->luma_size =3D calc_plane(ctx->stride=5B0=5D, ctx->img_height);
> > +		ctx->chroma_size =3D calc_plane(ctx->stride=5B1=5D,
> > +					(ctx->img_height / 2));
> > +		break;
> > +	case V4L2_PIX_FMT_YUV420M:
> > +	case V4L2_PIX_FMT_YVU420M:
> > +		ctx->stride=5B0=5D =3D ALIGN(ctx->img_width,
> > +					S5P_FIMV_NV12MT_HALIGN_V6);
> > +		ctx->stride=5B1=5D =3D ALIGN(ctx->img_width / 2,
> > +					S5P_FIMV_NV12MT_HALIGN_V6);
> > +		ctx->stride=5B2=5D =3D ALIGN(ctx->img_width / 2,
> > +					S5P_FIMV_NV12MT_HALIGN_V6);
> > +		ctx->luma_size =3D calc_plane(ctx->stride=5B0=5D, ctx->img_height);
> > +		ctx->chroma_size =3D calc_plane(ctx->stride=5B1=5D,
> > +					(ctx->img_height / 2));
> > +		ctx->chroma_size_1 =3D calc_plane(ctx->stride=5B2=5D,
> > +					(ctx->img_height / 2));
> > +		break;
> > +	=7D
> > +
> >  	if (IS_MFCV8_PLUS(ctx->dev)) =7B
> >  		/* MFCv8 needs additional 64 bytes for luma,chroma dpb*/
> >  		ctx->luma_size +=3D S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
> >  		ctx->chroma_size +=3D S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
> > +		ctx->chroma_size_1 +=3D
> S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
> >  	=7D
> >
> >  	if (ctx->codec_mode =3D=3D S5P_MFC_CODEC_H264_DEC =7C=7C =40=40 -534,=
15
> +561,53
> > =40=40 static void s5p_mfc_enc_calc_src_size_v6(struct s5p_mfc_ctx *ctx=
)
> >  	mb_width =3D MB_WIDTH(ctx->img_width);
> >  	mb_height =3D MB_HEIGHT(ctx->img_height);
> >
> > -	ctx->buf_width =3D ALIGN(ctx->img_width,
> S5P_FIMV_NV12M_HALIGN_V6);
> > -	ctx->luma_size =3D ALIGN((mb_width * mb_height) * 256, 256);
> > -	ctx->chroma_size =3D ALIGN((mb_width * mb_height) * 128, 256);
> > -
> > -	/* MFCv7 needs pad bytes for Luma and Chroma */
> > -	if (IS_MFCV7_PLUS(ctx->dev)) =7B
> > +	if (IS_MFCV12(ctx->dev)) =7B
> > +		switch (ctx->src_fmt->fourcc) =7B
> > +		case V4L2_PIX_FMT_NV12M:
> > +		case V4L2_PIX_FMT_NV21M:
> > +			ctx->stride=5B0=5D =3D ALIGN(ctx->img_width,
> > +
> 	S5P_FIMV_NV12M_HALIGN_V6);
> > +			ctx->stride=5B1=5D =3D ALIGN(ctx->img_width,
> > +
> 	S5P_FIMV_NV12M_HALIGN_V6);
> > +			ctx->luma_size =3D ctx->stride=5B0=5D *
> > +						ALIGN(ctx->img_height, 16);
> > +			ctx->chroma_size =3D  ctx->stride=5B0=5D *
> > +						ALIGN(ctx->img_height / 2,
> 16);
> > +			break;
> > +		case V4L2_PIX_FMT_YUV420M:
> > +		case V4L2_PIX_FMT_YVU420M:
> > +			ctx->stride=5B0=5D =3D ALIGN(ctx->img_width,
> > +
> 	S5P_FIMV_NV12M_HALIGN_V6);
> > +			ctx->stride=5B1=5D =3D ALIGN(ctx->img_width / 2,
> > +
> 	S5P_FIMV_NV12M_HALIGN_V6);
> > +			ctx->stride=5B2=5D =3D ALIGN(ctx->img_width / 2,
> > +
> 	S5P_FIMV_NV12M_HALIGN_V6);
> > +			ctx->luma_size =3D ctx->stride=5B0=5D *
> > +						ALIGN(ctx->img_height, 16);
> > +			ctx->chroma_size =3D  ctx->stride=5B1=5D *
> > +						ALIGN(ctx->img_height / 2,
> 16);
> > +			ctx->chroma_size_1 =3D  ctx->stride=5B2=5D *
> > +						ALIGN(ctx->img_height / 2,
> 16);
> > +			break;
> > +		=7D
> >  		ctx->luma_size +=3D MFC_LUMA_PAD_BYTES_V7;
> > -		ctx->chroma_size +=3D MFC_CHROMA_PAD_BYTES_V7;
> > +		ctx->chroma_size +=3D MFC_CHROMA_PAD_BYTES_V12;
> > +		ctx->chroma_size_1 +=3D MFC_CHROMA_PAD_BYTES_V12;
> > +	=7D else =7B
> > +		ctx->buf_width =3D ALIGN(ctx->img_width,
> > +					S5P_FIMV_NV12M_HALIGN_V6);
> > +		ctx->stride=5B0=5D =3D ctx->buf_width;
> > +		ctx->stride=5B1=5D =3D ctx->buf_width;
> > +		ctx->luma_size =3D ALIGN((mb_width * mb_height) * 256,
> 256);
> > +		ctx->chroma_size =3D ALIGN((mb_width * mb_height) * 128,
> 256);
> > +		ctx->chroma_size_1 =3D 0;
> > +		/* MFCv7 needs pad bytes for Luma and Chroma */
> > +		if (IS_MFCV7_PLUS(ctx->dev)) =7B
> > +			ctx->luma_size +=3D MFC_LUMA_PAD_BYTES_V7;
> > +			ctx->chroma_size +=3D MFC_LUMA_PAD_BYTES_V7;
> > +		=7D
> >  	=7D
> > +
> >  =7D
> >
> >  /* Set registers for decoding stream buffer */ =40=40 -588,15 +653,21 =
=40=40
> > static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
> >  	writel(ctx->total_dpb_count, mfc_regs->d_num_dpb);
> >  	writel(ctx->luma_size, mfc_regs->d_first_plane_dpb_size);
> >  	writel(ctx->chroma_size, mfc_regs->d_second_plane_dpb_size);
> > -
> > +	if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +			ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> > +		writel(ctx->chroma_size_1, mfc_regs-
> >d_third_plane_dpb_size);
> >  	writel(buf_addr1, mfc_regs->d_scratch_buffer_addr);
> >  	writel(ctx->scratch_buf_size, mfc_regs->d_scratch_buffer_size);
> >
> >  	if (IS_MFCV8_PLUS(dev)) =7B
> > -		writel(ctx->img_width,
> > +		writel(ctx->stride=5B0=5D,
> >  			mfc_regs->d_first_plane_dpb_stride_size);
> > -		writel(ctx->img_width,
> > +		writel(ctx->stride=5B1=5D,
> >  			mfc_regs->d_second_plane_dpb_stride_size);
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +			writel(ctx->stride=5B2=5D,
> > +				mfc_regs->d_third_plane_dpb_stride_size);
> >  	=7D
> >
> >  	buf_addr1 +=3D ctx->scratch_buf_size;
> > =40=40 -625,6 +696,13 =40=40 static int
> s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
> >  					ctx->dst_bufs=5Bi=5D.cookie.raw.chroma);
> >  		writel(ctx->dst_bufs=5Bi=5D.cookie.raw.chroma,
> >  				mfc_regs->d_second_plane_dpb + i * 4);
> > +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->dst_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M) =7B
> > +			mfc_debug(2, =22=5CtChroma_1 %d: %zx=5Cn=22, i,
> > +					ctx-
> >dst_bufs=5Bi=5D.cookie.raw.chroma_1);
> > +			writel(ctx->dst_bufs=5Bi=5D.cookie.raw.chroma_1,
> > +					mfc_regs->d_third_plane_dpb + i *
> 4);
> > +		=7D
> >  	=7D
> >  	if (ctx->codec_mode =3D=3D S5P_MFC_CODEC_H264_DEC =7C=7C
> >  			ctx->codec_mode =3D=3D
> S5P_MFC_CODEC_H264_MVC_DEC =7C=7C =40=40 -683,20
> > +761,24 =40=40 static int s5p_mfc_set_enc_stream_buffer_v6(struct
> > s5p_mfc_ctx *ctx,  =7D
> >
> >  static void s5p_mfc_set_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
> > -		unsigned long y_addr, unsigned long c_addr)
> > +		unsigned long y_addr, unsigned long c_addr,
> > +		unsigned long c_1_addr)
> >  =7B
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >  	const struct s5p_mfc_regs *mfc_regs =3D dev->mfc_regs;
> >
> >  	writel(y_addr, mfc_regs->e_source_first_plane_addr);
> >  	writel(c_addr, mfc_regs->e_source_second_plane_addr);
> > +	writel(c_1_addr, mfc_regs->e_source_third_plane_addr);
> >
> >  	mfc_debug(2, =22enc src y buf addr: 0x%08lx=5Cn=22, y_addr);
> >  	mfc_debug(2, =22enc src c buf addr: 0x%08lx=5Cn=22, c_addr);
> > +	mfc_debug(2, =22enc src cr buf addr: 0x%08lx=5Cn=22, c_1_addr);
> >  =7D
> >
> >  static void s5p_mfc_get_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
> > -		unsigned long *y_addr, unsigned long *c_addr)
> > +		unsigned long *y_addr, unsigned long *c_addr,
> > +		unsigned long *c_1_addr)
> >  =7B
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >  	const struct s5p_mfc_regs *mfc_regs =3D dev->mfc_regs; =40=40 -704,12
> > +786,17 =40=40 static void s5p_mfc_get_enc_frame_buffer_v6(struct
> > s5p_mfc_ctx *ctx,
> >
> >  	*y_addr =3D readl(mfc_regs->e_encoded_source_first_plane_addr);
> >  	*c_addr =3D readl(mfc_regs-
> >e_encoded_source_second_plane_addr);
> > +	if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +			ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> > +		*c_1_addr =3D readl(mfc_regs-
> >e_encoded_source_third_plane_addr);
> > +	else
> > +		*c_1_addr =3D 0;
> >
> >  	enc_recon_y_addr =3D readl(mfc_regs->e_recon_luma_dpb_addr);
> >  	enc_recon_c_addr =3D readl(mfc_regs->e_recon_chroma_dpb_addr);
> >
> >  	mfc_debug(2, =22recon y addr: 0x%08lx y_addr: 0x%08lx=5Cn=22,
> enc_recon_y_addr, *y_addr);
> > -	mfc_debug(2, =22recon c addr: 0x%08lx=5Cn=22, enc_recon_c_addr);
> > +	mfc_debug(2, =22recon c addr: 0x%08lx c_addr: 0x%08lx=5Cn=22,
> > +enc_recon_c_addr, *c_addr);
> >  =7D
> >
> >  /* Set encoding ref & codec buffer */ =40=40 -886,6 +973,20 =40=40 sta=
tic int
> > s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
> >  		writel(reg, mfc_regs->e_enc_options);
> >  		/* 0: NV12(CbCr), 1: NV21(CrCb) */
> >  		writel(0x0, mfc_regs->pixel_format);
> > +	=7D else if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) =7B
> > +		/* 0: Linear, 1: 2D tiled*/
> > +		reg =3D readl(mfc_regs->e_enc_options);
> > +		reg &=3D =7E(0x1 << 7);
> > +		writel(reg, mfc_regs->e_enc_options);
> > +		/* 2: YV12(CrCb), 3: I420(CrCb) */
> > +		writel(0x2, mfc_regs->pixel_format);
> > +	=7D else if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M) =7B
> > +		/* 0: Linear, 1: 2D tiled*/
> > +		reg =3D readl(mfc_regs->e_enc_options);
> > +		reg &=3D =7E(0x1 << 7);
> > +		writel(reg, mfc_regs->e_enc_options);
> > +		/* 2: YV12(CrCb), 3: I420(CrCb) */
> > +		writel(0x3, mfc_regs->pixel_format);
> >  	=7D
> >
> >  	/* memory structure recon. frame */
> > =40=40 -1696,8 +1797,12 =40=40 static int s5p_mfc_init_decode_v6(struct
> s5p_mfc_ctx *ctx)
> >  	else
> >  		writel(reg, mfc_regs->d_dec_options);
> >
> > -	/* 0: NV12(CbCr), 1: NV21(CrCb) */
> > -	if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_NV21M)
> > +	/* 0: NV12(CbCr), 1: NV21(CrCb), 2: YV12(CrCb), 3: I420(CbCr) */
> > +	if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M)
> > +		writel(0x3, mfc_regs->pixel_format);
> > +	else if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> > +		writel(0x2, mfc_regs->pixel_format);
> > +	else if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_NV21M)
> >  		writel(0x1, mfc_regs->pixel_format);
> >  	else
> >  		writel(0x0, mfc_regs->pixel_format); =40=40 -1781,8 +1886,12
> =40=40 static
> > int s5p_mfc_init_encode_v6(struct s5p_mfc_ctx *ctx)
> >
> >  	/* Set stride lengths for v7 & above */
> >  	if (IS_MFCV7_PLUS(dev)) =7B
> > -		writel(ctx->img_width, mfc_regs-
> >e_source_first_plane_stride);
> > -		writel(ctx->img_width, mfc_regs-
> >e_source_second_plane_stride);
> > +		writel(ctx->stride=5B0=5D, mfc_regs-
> >e_source_first_plane_stride);
> > +		writel(ctx->stride=5B1=5D, mfc_regs-
> >e_source_second_plane_stride);
> > +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +			writel(ctx->stride=5B2=5D,
> > +					mfc_regs-
> >e_source_third_plane_stride);
> >  	=7D
> >
> >  	writel(ctx->inst_no, mfc_regs->instance_id); =40=40 -1891,7 +2000,7
> =40=40
> > static inline int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
> >  	struct s5p_mfc_dev *dev =3D ctx->dev;
> >  	struct s5p_mfc_buf *dst_mb;
> >  	struct s5p_mfc_buf *src_mb;
> > -	unsigned long src_y_addr, src_c_addr, dst_addr;
> > +	unsigned long src_y_addr, src_c_addr, src_c_1_addr, dst_addr;
> >  	/*
> >  	unsigned int src_y_size, src_c_size;
> >  	*/
> > =40=40 -1909,22 +2018,29 =40=40 static inline int s5p_mfc_run_enc_frame=
(struct
> > s5p_mfc_ctx *ctx)
> >
> >  	if (list_empty(&ctx->src_queue)) =7B
> >  		/* send null frame */
> > -		s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0);
> > +		s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0, 0);
> >  		src_mb =3D NULL;
> >  	=7D else =7B
> >  		src_mb =3D list_entry(ctx->src_queue.next, struct
> s5p_mfc_buf, list);
> >  		src_mb->flags =7C=3D MFC_BUF_FLAG_USED;
> >  		if (src_mb->b->vb2_buf.planes=5B0=5D.bytesused =3D=3D 0) =7B
> > -			s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0);
> > +			s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0, 0);
> >  			ctx->state =3D MFCINST_FINISHING;
> >  		=7D else =7B
> >  			src_y_addr =3D
> vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 0);
> >  			src_c_addr =3D
> vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf,
> > 1);
> > +			if (ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YUV420M =7C=7C
> > +				ctx->src_fmt->fourcc =3D=3D
> V4L2_PIX_FMT_YVU420M)
> > +				src_c_1_addr =3D
> vb2_dma_contig_plane_dma_addr
> > +						(&src_mb->b->vb2_buf, 2);
> > +			else
> > +				src_c_1_addr =3D 0;
> >
> >  			mfc_debug(2, =22enc src y addr: 0x%08lx=5Cn=22,
> src_y_addr);
> >  			mfc_debug(2, =22enc src c addr: 0x%08lx=5Cn=22,
> src_c_addr);
> >
> > -			s5p_mfc_set_enc_frame_buffer_v6(ctx, src_y_addr,
> src_c_addr);
> > +			s5p_mfc_set_enc_frame_buffer_v6(ctx, src_y_addr,
> > +						src_c_addr, src_c_1_addr);
> >  			if (src_mb->flags & MFC_BUF_FLAG_EOS)
> >  				ctx->state =3D MFCINST_FINISHING;
> >  		=7D
> > =40=40 -2450,6 +2566,8 =40=40 const struct s5p_mfc_regs
> *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
> >  			S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7);
> >  	R(e_encoded_source_second_plane_addr,
> >
> 	S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7);
> > +	R(e_encoded_source_third_plane_addr,
> > +			S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7);
> >  	R(e_vp8_options, S5P_FIMV_E_VP8_OPTIONS_V7);
> >
> >  	if (=21IS_MFCV8_PLUS(dev))
> > =40=40 -2464,16 +2582,20 =40=40 const struct s5p_mfc_regs
> *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
> >  	R(d_cpb_buffer_offset, S5P_FIMV_D_CPB_BUFFER_OFFSET_V8);
> >  	R(d_first_plane_dpb_size,
> S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8);
> >  	R(d_second_plane_dpb_size,
> S5P_FIMV_D_SECOND_PLANE_DPB_SIZE_V8);
> > +	R(d_third_plane_dpb_size,
> S5P_FIMV_D_THIRD_PLANE_DPB_SIZE_V8);
> >  	R(d_scratch_buffer_addr,
> S5P_FIMV_D_SCRATCH_BUFFER_ADDR_V8);
> >  	R(d_scratch_buffer_size, S5P_FIMV_D_SCRATCH_BUFFER_SIZE_V8);
> >  	R(d_first_plane_dpb_stride_size,
> >  			S5P_FIMV_D_FIRST_PLANE_DPB_STRIDE_SIZE_V8);
> >  	R(d_second_plane_dpb_stride_size,
> >
> 	S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8);
> > +	R(d_third_plane_dpb_stride_size,
> > +			S5P_FIMV_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8);
> >  	R(d_mv_buffer_size, S5P_FIMV_D_MV_BUFFER_SIZE_V8);
> >  	R(d_num_mv, S5P_FIMV_D_NUM_MV_V8);
> >  	R(d_first_plane_dpb, S5P_FIMV_D_FIRST_PLANE_DPB_V8);
> >  	R(d_second_plane_dpb, S5P_FIMV_D_SECOND_PLANE_DPB_V8);
> > +	R(d_third_plane_dpb, S5P_FIMV_D_THIRD_PLANE_DPB_V8);
> >  	R(d_mv_buffer, S5P_FIMV_D_MV_BUFFER_V8);
> >  	R(d_init_buffer_options, S5P_FIMV_D_INIT_BUFFER_OPTIONS_V8);
> >  	R(d_available_dpb_flag_lower,
> > S5P_FIMV_D_AVAILABLE_DPB_FLAG_LOWER_V8);


