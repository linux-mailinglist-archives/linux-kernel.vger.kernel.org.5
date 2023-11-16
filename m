Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7727EDB01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjKPFAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjKPFAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:00:18 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F319F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:00:11 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231116050009epoutp034a978771edf43689d9c5413192aec60c~YAcX2XdZA3011230112epoutp03Z
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:00:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231116050009epoutp034a978771edf43689d9c5413192aec60c~YAcX2XdZA3011230112epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700110809;
        bh=NAkytrCe5aM1b6jLPcoQx9e9hWt3OPZ5KoHNxK743cU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AIQTZWu14HZFwO07+tQcycuk/NmrqQV1L8mwSjv0FO8ctQvkqxfAdGJuNuhWuWAOE
         HgfRBUmF8OZVY2vUFcEMXwZQTLjyyFWPCV2HCBoOVnmBUDs3zphu5EpY6sYH2/e//Y
         bID8Y8dYaRSKEdiejFxbciN0fLmBoqpSwpzr+ZDM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231116050008epcas5p4f1adfabd64607c9a5721eea5b981cbd7~YAcXUjcu_2922529225epcas5p4q;
        Thu, 16 Nov 2023 05:00:08 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SW7BZ08b3z4x9QF; Thu, 16 Nov
        2023 05:00:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.9E.19369.5D1A5556; Thu, 16 Nov 2023 14:00:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231116050005epcas5p4f71e3d7d21802c738d331e69310656fd~YAcUbkGzV0330003300epcas5p4h;
        Thu, 16 Nov 2023 05:00:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231116050005epsmtrp2939be81164f51581702e0368b5b0da98~YAcUYYgXM2381423814epsmtrp2f;
        Thu, 16 Nov 2023 05:00:05 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-f5-6555a1d590a7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.66.08817.5D1A5556; Thu, 16 Nov 2023 14:00:05 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231116050002epsmtip13b38cf6e78094bb8f50b82e2d921876c~YAcRYNYOQ2191521915epsmtip1W;
        Thu, 16 Nov 2023 05:00:02 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Aakarsh Jain'" <aakarsh.jain@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <krzysztof.kozlowski+dt@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <andi@etezian.org>,
        <gost.dev@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <ajaykumar.rs@samsung.com>,
        <linux-fsd@tesla.com>,
        "'Smitha T Murthy'" <smithatmurthy@gmail.com>
In-Reply-To: <20231025102216.50480-3-aakarsh.jain@samsung.com>
Subject: RE: [Patch v4 02/11] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Thu, 16 Nov 2023 10:30:00 +0530
Message-ID: <0d2801da1849$c34ddc70$49e99550$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQGjI0AwA0f6tMSuO3P5oA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHvb23ve1i9cpQTmoya2XJYCm0G4/TBRgKG3duGpK5uCzG2rV3
        LYM+7GOO6RxuA3EwIkGIIOhoERi0A8sqZcJgpQPZDAuTMSsvQaC8io6yhzqnfYDuv8/vnO83
        v9/3d3KYaEgRzmFmqPSUViXJ4jHWYd92R0Twb1XvowSl1yGctpfTYddvVzBoeuCmwXGTF4OO
        FhsOzR39NFjX20WHXzn76bD1yiQGXV1tNDhQPorBotkJFFp/HaLDifk34Y+XKhmwsNlGh5/f
        uEyDFucoDr++PUCDtdaHNGi0reAwt8OJw9Mf1dCTw0jzl2aEvF2zjJJtFaM4aWqfo5HWhk8Y
        5MhQO4NsqTlB5l79EyOLLjYg5KOTVTjptW4gr9314ulPHshMUFASGaXlUiqpWpahkifydu8V
        p4hj4wRCvlAE43lclURJJfJS96Tzd2Zk+XLzuEckWQbfUbpEp+NFJyVo1QY9xVWodfpEHqWR
        ZWliNFE6iVJnUMmjVJR+m1Ag2BLrE76TqZi2NzI0VTuODnrasBykR3QGYTEBEQM8BQ7aGWQd
        M4RoR0C5+QIjWCwj4Of6j1eLewiYXiigr1lyh39AgxcdCMixDKz6ZxGQb1nA/CoGwQd2U17A
        HkrYETBoNmH+AiUKMeCtvxlQsYgk4C5pwv28nkgFj2YsqJ8xYiM4NfdLgNmECCzOzK3yM6Cv
        fCrgRYkXQKunEg3OxAV/TNcG5gslXgH/1NvQoCYMzF114v7GgGhlgQs/1a0aUsFifx8e5PVg
        vvfiKnOAd6nDNzbTxyQwPuQEjxXAU9eEBHk76BqsxPwSlIgATZeig62eAmf/mqIFnWyQnxcS
        VPuSLN3Cgvw8KC5Y2yIJJhpn6Z8iL1Y8FqzisWAVjwWo+L/ZOQRrQDiURqeUU9JYjZCvot77
        78mlaqUVCXyMyHQ70tj8d5QDoTERBwKYKC+UHb/hDSqELZNkH6O0arHWkEXpHEisb93FKOdZ
        qdr3s1R6sTBGJIiJi4uLEW2NE/LC2Au5VbIQQi7RU5kUpaG0az4ak8XJoYW9djrctXKZKP3M
        W8a1zty9PpAmnX29R79JnvLBHQ8QKHfqXGVDuzM7w+bTdi2P5S3zcz6UNSXuT9pecvz+ee+B
        TnG4jNXYf+ObSHYx1mdKG+sbcSMu12b9qalrHumegfBCTf6OLXkm8b6Tguye0vbpcmWa8fvv
        jqwc9ha8/ETKzWP7Z8ZPxCbjrvB33fFim93i9owkGO8dnP396bcmlzYbDi/umiK7zxqUe0ty
        y2zGBxuHew8djKxlVSldNZNvD2fDl46LE+ViwKBXF2Ykd246h7mVsi+qD+U7S486I8Jbxuge
        x7ZxkdrWYO6Ovq/QoefJV+8kW57bmuyVvY81G3mYTiERRqJaneRfAm9c+6EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xSYRiA951z4CBJndDyMxs5MmcWWq7LZ2utddnOWrnmurjWMsozMwUJ
        tOwqmbZ1sbVZFkwtQbFMZiIUKpSSll3NLInSygqJzMzoYq2sCbX579me9332/ng5OP8bMYmT
        Is1g5FJxmpDNJa7cEApET0rXMrMGCscip1nFQo0DTQTSDrkw9FLrIZCt1kSiKusDDFXcamSh
        c80PWOhq02sCORrrMNSu6ibQiXc9ODK86WShnvfrUUd9ERsdv2xiobNt1zCkb+4mUbm9HUM6
        wy8MaUxfSJRnbSZR7sEy1uIguqqkCtD2ss84XafuJmmtxY3RhsojbLqr08Kma8uy6byWnwR9
        wlgJ6OGcYpL2GAT0na8ecrX/Bu7CJCYtZScjj160mbvNab7ElhUvz3rcX0cowc3Yo8CPA6k5
        MO/5Pfwo4HL4VAOAmsMWwidCoL3mJOnjAHhx2EX6hnoBzK/XsUYEmxJBs/Ywe0QEUhYAj51u
        9wqcKiGg7VmEb6MJQJde5035UYugq6DaywHUMjjcq8dHmKCmwUPuV17mUbHwQ6/7H4+Ht1Vv
        CV90BnQ6nP94CrzaX4T7zguFP5y+iwKpJfDPBRPumwmC7pZm8iQIUI9KqUel1KNS6lEr5wFR
        CYIZmUKSLFHMlsVImV1RCrFEkSlNjtqaLjEA72tERpqBpfJTlA1gHGADkIMLA3nzBWsYPi9J
        vHsPI09PlGemMQobCOEQwiDet778JD6VLM5gUhlGxsj/W4zjN0mJRYgmBjZEfx+0phjVc5Wi
        mb+ib2+5HN9pLJSskCTekoFruvS7NTpHl1TJ7bME3xi0jRNdN7TGecZgxoQ1/a19esuQVRCf
        G5AubBmekbgiY8P9mu0ux6PwyW8moJhGwZhBZ5pJk18Qs6nPWL5K41lcEZ8ZlLdpx5RQLOF7
        Tpy2NP/M4P7kKGtw6/3aeV1PQy50OEOLKtoG2qwuc5gjvKvAnz89u1RTviBsvqN/4bvxKvep
        AxE5saI5ZRkdvHUbNU3nX8x0VssblKmqnoc1S43P6L0l++yFWfrs8uKSRwUPT0H91Mm/669/
        fP5hy/SwpNy71UMLUrNwe4p/B8Fa+fPJeyGh2CaeHYnLFeK/9bl4PYkDAAA=
X-CMS-MailID: 20231116050005epcas5p4f71e3d7d21802c738d331e69310656fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102237epcas5p28a5ad9db8d7dea072a6986d530810dde
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102237epcas5p28a5ad9db8d7dea072a6986d530810dde@epcas5p2.samsung.com>
        <20231025102216.50480-3-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aakarsh

> -----Original Message-----
> From: Aakarsh Jain <aakarsh.jain@samsung.com>
> Sent: Wednesday, October 25, 2023 3:52 PM
> To: linux-arm-kernel@lists.infradead.org; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> krzysztof.kozlowski+dt@linaro.org; dillon.minfei@gmail.com;
> david.plowman@raspberrypi.com; mark.rutland@arm.com;
> robh+dt@kernel.org; conor+dt@kernel.org; linux-samsung-
> soc@vger.kernel.org; andi@etezian.org; gost.dev@samsung.com;
> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; ajaykumar.rs@samsung.com;
> aakarsh.jain@samsung.com; linux-fsd@tesla.com; Smitha T Murthy
> <smithatmurthy@gmail.com>
> Subject: [Patch v4 02/11] media: s5p-mfc: Rename IS_MFCV10 macro
> 
> Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10 code
> can be resued for MFCv12 support. Since some part of MFCv10 specific code
> holds good for MFCv12 also.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 10 +++----
>  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
>  3 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index 5304f42c8c72..e6ec4a43b290 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -771,11 +771,11 @@ void s5p_mfc_cleanup_queue(struct list_head *lh,
> struct vb2_queue *vq);
>  #define HAS_PORTNUM(dev)	(dev ? (dev->variant ? \
>  				(dev->variant->port_num ? 1 : 0) : 0) : 0)
>  #define IS_TWOPORT(dev)		(dev->variant->port_num == 2 ? 1 : 0)
> -#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 :
> 0)
> -#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 :
> 0)
> -#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 :
> 0)
> -#define IS_MFCV10(dev)		(dev->variant->version >= 0xA0 ? 1 :
> 0)
> -#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
> +#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60)
> +#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
> +#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
> +#define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
> +#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
> 
>  #define MFC_V5_BIT	BIT(0)
>  #define MFC_V6_BIT	BIT(1)
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> index 6d3c92045c05..54b54b2fa9b1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> @@ -236,7 +236,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>  	else
>  		mfc_write(dev, 0x3ff, S5P_FIMV_SW_RESET);
> 
> -	if (IS_MFCV10(dev))
> +	if (IS_MFCV10_PLUS(dev))
>  		mfc_write(dev, 0x0, S5P_FIMV_MFC_CLOCK_OFF_V10);
> 
>  	mfc_debug(2, "Will now wait for completion of firmware
> transfer\n"); diff --git a/drivers/media/platform/samsung/s5p-
> mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-
> mfc/s5p_mfc_opr_v6.c
> index c0df5ac9fcff..882166e4ac50 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -72,9 +72,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
>  		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
>  	} else if (ctx->type == MFCINST_ENCODER) {
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev))
>  			ctx->tmv_buffer_size = 0;
> -		} else if (IS_MFCV8_PLUS(dev))
> +		else if (IS_MFCV8_PLUS(dev))
>  			ctx->tmv_buffer_size =
> S5P_FIMV_NUM_TMV_BUFFERS_V6 *
> 
> 	ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
>  			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> @@ -82,7 +82,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  			ctx->tmv_buffer_size =
> S5P_FIMV_NUM_TMV_BUFFERS_V6 *
> 
> 	ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
>  			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>  			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
>  			lcu_height = S5P_MFC_LCU_HEIGHT(ctx-
> >img_height);
>  			if (ctx->codec_mode !=
> S5P_FIMV_CODEC_HEVC_ENC) { @@ -133,7 +133,7 @@ static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>  	switch (ctx->codec_mode) {
>  	case S5P_MFC_CODEC_H264_DEC:
>  	case S5P_MFC_CODEC_H264_MVC_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  		else if (IS_MFCV8_PLUS(dev))
>  			ctx->scratch_buf_size =
> @@ -152,7 +152,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  			(ctx->mv_count * ctx->mv_size);
>  		break;
>  	case S5P_MFC_CODEC_MPEG4_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  		else if (IS_MFCV7_PLUS(dev)) {
>  			ctx->scratch_buf_size =
> @@ -172,7 +172,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  		break;
>  	case S5P_MFC_CODEC_VC1RCV_DEC:
>  	case S5P_MFC_CODEC_VC1_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  		else
>  			ctx->scratch_buf_size =
> @@ -189,7 +189,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  		ctx->bank2.size = 0;
>  		break;
>  	case S5P_MFC_CODEC_H263_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  		else
>  			ctx->scratch_buf_size =
> @@ -201,7 +201,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  		ctx->bank1.size = ctx->scratch_buf_size;
>  		break;
>  	case S5P_MFC_CODEC_VP8_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  		else if (IS_MFCV8_PLUS(dev))
>  			ctx->scratch_buf_size =
> @@ -230,7 +230,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  			DEC_VP9_STATIC_BUFFER_SIZE;
>  		break;
>  	case S5P_MFC_CODEC_H264_ENC:
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  			ctx->me_buffer_size =
>  			ALIGN(ENC_V100_H264_ME_SIZE(mb_width,
> mb_height), 16); @@ -254,7 +254,7 @@ static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>  		break;
>  	case S5P_MFC_CODEC_MPEG4_ENC:
>  	case S5P_MFC_CODEC_H263_ENC:
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  			ctx->me_buffer_size =
> 
> 	ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
> @@ -273,7 +273,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  		ctx->bank2.size = 0;
>  		break;
>  	case S5P_MFC_CODEC_VP8_ENC:
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  			ctx->me_buffer_size =
>  				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width,
> mb_height), @@ -452,7 +452,7 @@ static void
> s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
> 
>  	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
>  			ctx->codec_mode ==
> S5P_MFC_CODEC_H264_MVC_DEC) {
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>  			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx-
> >img_width,
>  					ctx->img_height);
>  		} else {
> @@ -668,7 +668,7 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct
> s5p_mfc_ctx *ctx)
> 
>  	mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
> 
> -	if (IS_MFCV10(dev)) {
> +	if (IS_MFCV10_PLUS(dev)) {
>  		/* start address of per buffer is aligned */
>  		for (i = 0; i < ctx->pb_count; i++) {
>  			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
> @@ -2455,7 +2455,7 @@ const struct s5p_mfc_regs
> *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
>  	R(e_h264_options, S5P_FIMV_E_H264_OPTIONS_V8);
>  	R(e_min_scratch_buffer_size,
> S5P_FIMV_E_MIN_SCRATCH_BUFFER_SIZE_V8);
> 
> -	if (!IS_MFCV10(dev))
> +	if (!IS_MFCV10_PLUS(dev))
>  		goto done;
> 
>  	/* Initialize registers used in MFC v10 only.
> --
> 2.17.1


