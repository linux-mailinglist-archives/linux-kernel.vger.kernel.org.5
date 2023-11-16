Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF037EDB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbjKPFpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:45:14 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB633192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:45:08 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231116054507epoutp048d9919fde8d05b4fc3bb87982306fb14~YBDo4Zs_Y1332213322epoutp04B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:45:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231116054507epoutp048d9919fde8d05b4fc3bb87982306fb14~YBDo4Zs_Y1332213322epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700113507;
        bh=adDn9SMUO5PptBlKoqNyPN7f6E4/59yYlCSyuFhzZIY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=di6gWO6924Ce/8NKUq3HMc8MY5pQhc1HKXJzCrfIjE0u0gUqCg8wRExir0eGNIS3v
         LvPpbPJEMfGrtvmZdgMtOo7Ry45sCMJoS/F1BHft62P8SJDZAjWlVjjPyJQdte14gn
         ab8P/IiiiLF9D2ODoFlXe9aZ8y+1Tp2gORYl/YeE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231116054506epcas5p36961d9ef34b3e576b14d0823e28a04ce~YBDoOT4IN1109511095epcas5p3q;
        Thu, 16 Nov 2023 05:45:06 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SW8BS5MNFz4x9Pv; Thu, 16 Nov
        2023 05:45:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.E9.19369.06CA5556; Thu, 16 Nov 2023 14:45:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231116054504epcas5p31d3e2b7c8dd7605c353f42093f1aa891~YBDlxZk5x1109511095epcas5p3g;
        Thu, 16 Nov 2023 05:45:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231116054504epsmtrp17ab9f2d3f094e4ac2f3006a86db740ca~YBDlwWRN41913719137epsmtrp12;
        Thu, 16 Nov 2023 05:45:04 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-da-6555ac60c187
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.59.18939.F5CA5556; Thu, 16 Nov 2023 14:45:03 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231116054500epsmtip1236470d537e3c6260035db4cb9a1d6fd~YBDiuUwoG1438014380epsmtip1b;
        Thu, 16 Nov 2023 05:45:00 +0000 (GMT)
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
In-Reply-To: <20231025102216.50480-4-aakarsh.jain@samsung.com>
Subject: RE: [Patch v4 03/11] media: s5p-mfc: Add initial support for MFCv12
Date:   Thu, 16 Nov 2023 11:14:59 +0530
Message-ID: <0d6201da1850$0bd48ba0$237da2e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQIIuTk5ALqF0vauTLP2UA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVRTdRjufmx3ILPboMOv0TGakQc4g03HuCs+FKlzz4mSIgIyGoPdwzjA
        NrcRyTklFlCCEPRBMkCFLUiciOBkfAgM8CCicEC+MlEhQVAx48tS4sS4aPz3vO/7PO/7Pr/f
        eVkIJxfjshKUOkqjlCXxmPbouQ73bfwYUzglaJ3eSkxaihhE259WlDD8fQcmbhrmUaK9zowR
        pvO9MFHZ1cYgjnX2Moh66wRK/NbWABP9RWMokTc9jhC1fwwziPG7EcTVxhImcbjGzCCO9LXA
        xKnOMYz4ZaQfJipql2Gi3LyAEZnnOzEi46CRsdOZNB01QeSIcQ4hG/RjGGlonoHJ2qpDTPL6
        cDOTrDMeIDMvPEbJvLNVELnyVSlGztduIS8tzmOhDh8n+ikomZzSuFLKOJU8QRnvz3snTLpb
        6iMWCPlCCeHLc1XKkil/XnBIKP/thKRV3zzXz2RJKaupUJlWy/MO8NOoUnSUq0Kl1fnzKLU8
        SS1Se2llydoUZbyXktK9IRQItvusEmMSFfndS7A6rxD6/M7UKDMdqkzLhuxYABeBotkOZjZk
        z+LgzRAoXCnD6GAOAuYj7dCzoO7UAPRUMtl7EaULDRDI6J1E6GAaAg9OFCM2FhPnA4sha62x
        E26BwKDJsCZB8MMomP91ALWx7PAAMJ5lYmRDLJYjHgJma7ba0ijuBobLFmEbZuMSUNaSs45f
        AN1Ft9ekCP4KqJ8tQeiVXME/kxUMG3bCg0C3tRyjOc5g5kLnmiGAN9mB8svXYNssgAeDb7K/
        oLWO4G7XWYzGXDDzXRZGU0hQvsyl0wowW3l63X0gaBssQW0UBHcHpxu96UmbQe6T2+vN2eDb
        LA7NdgNfPxhCaewCCnJyGDQmgfXRMpoPvarf4Eu/wZd+w/76/4cdh9AqiEuptcnxVJyPWshX
        UqnPfjxOlVwLrd2FR6gFOlnzr1c7BLOgdgiwEJ4T23fLhxSHLZftT6M0KqkmJYnStkM+q69d
        gHBfjFOtHpZSJxWKJAKRWCwWSXaIhTxn9r3MUjkHj5fpqESKUlOapzqYZcdNh7kPU2ry90Ze
        2db3409Gs6XYwxrI8cp0ya/Sth7aNWS971DKCB93U37p83jiZEZ1YOrAQ8No1QHnimsLDu8J
        ft5smdkUVhRz8a37dQa/nombBz1aI6Zu7ZJGsdOCY5tavO3r9h3vuWQyvysWX/asfr0riHT5
        dK8vJyLjXLjnRzf0bpKW/rm+ocape4+evxKP2H9fknOjYw93U/QxhwoUhj0VHUblnjffjy6W
        iI7KB39Y2ncisvxMdIi0KfG1DwozWrmHwl46Qxa6PNmeWuh0Pep3fvqOpaBc7nBsj+PO6hH3
        hf2NUcbG5zrHIgMKVgb+qh+7Nf4yHvsJS3R10V+e6yPJG2VkpfFQrUIm9EA0Wtl/0leK16AE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7bCSnG78mtBUg6vTLSye7pjJanHg/UEW
        i8U/njNZ3F/8mcXi0Oat7BZr9p5jslh+/ACrxfwj51gtth98xGJx88BOJouLM++yWPS9eMhs
        senxNVaLh6/CLS7vmsNm0bNhK6vFjPP7mCzWHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8RdouW
        xiWsDuIea+atYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sqRo9/
        TXPZPT5vkvM49fUzewBPFJdNSmpOZllqkb5dAlfGhJPfmAr6pjFWPH92g62BcXlVFyMnh4SA
        icTTcydYuhi5OIQEtjNK3Hu+nx0iIS1xfeMEKFtYYuW/5+wQRc8YJY6232UDSbAJ6ErsWNzG
        BpIQEdjDKNE99SIrSIJZYB6LxKFbGhAdBxklZp9oYARJcArYSTxsWwNUxMEhLOAj8XaDMkiY
        RUBV4trCr0wgNq+ApcTCfd1QtqDEyZlPWCBmaks8vfkUypaX2P52DjPEdQoSP58uA9srIuAk
        cfLgInaIGnGJl0ePsE9gFJ6FZNQsJKNmIRk1C0nLAkaWVYyiqQXFuem5yQWGesWJucWleel6
        yfm5mxjByUIraAfjsvV/9Q4xMnEwHmKU4GBWEuE1lwtJFeJNSaysSi3Kjy8qzUktPsQozcGi
        JM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamAK5kqX7WNS9Fsuu97Wc2G7dtdC0QWxkjMeXJ2l
        vfj2bY6qmAajLZqGxXcit0rGTFdRuH49gaukSLbmD/veqYpV99mjD72J2ruI18ZML+/yBaNr
        K90m/Wr59DqDe4r7hHWnNjAtOCFocCTf3fCup/midSIJU4vPfK+f9PzV5plWKy96/PGeETd1
        c/XMaVOLLWoyF+vd/bjUNCOnzGZ6Vczx+jib8mmat25Uz5GJ2Glfwb1HkktPw/BDwnWGmP/3
        yhj2qb9rULjdHBJQKars+CrVPmM6a8etOJ4Pd0/zPY1Y036yoOLuuv9xyVc+/szhntMQrSmc
        s6zXkS9RlHXtrI0Ba6OvxEyty/N9WS6XfluJpTgj0VCLuag4EQBtBbSPhQMAAA==
X-CMS-MailID: 20231116054504epcas5p31d3e2b7c8dd7605c353f42093f1aa891
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4@epcas5p1.samsung.com>
        <20231025102216.50480-4-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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
> Subject: [Patch v4 03/11] media: s5p-mfc: Add initial support for MFCv12
> 
> Add support for MFCv12, with a new register file and necessary hw control,
> decoder, encoder and structural changes. Add luma dbp, chroma dpb and mv
> sizes for each codec as per the UM for MFCv12, along with appropriate
> alignment.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   | 50 +++++++++++
>  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 30 +++++++
> .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 15 +++-
>  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 83
> ++++++++++++++++---  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |
> 6 +-
>  9 files changed, 175 insertions(+), 30 deletions(-)  create mode 100644
> drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> new file mode 100644
> index 000000000000..6c68a45082d0
> --- /dev/null
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Register definition file for Samsung MFC V12.x Interface (FIMV)
> +driver
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *     http://www.samsung.com/
> + */
> +
> +#ifndef _REGS_MFC_V12_H
> +#define _REGS_MFC_V12_H
> +
> +#include <linux/sizes.h>
> +#include "regs-mfc-v10.h"
> +
> +/* MFCv12 Context buffer sizes */
> +#define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
> +#define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
> +#define MFC_OTHER_DEC_CTX_BUF_SIZE_V12	(30 * SZ_1K)
> +#define MFC_H264_ENC_CTX_BUF_SIZE_V12	(100 * SZ_1K)
> +#define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
> +#define MFC_OTHER_ENC_CTX_BUF_SIZE_V12	(25 * SZ_1K)
> +
> +/* MFCv12 variant defines */
> +#define MAX_FW_SIZE_V12			(SZ_1M)
> +#define MAX_CPB_SIZE_V12		(7 * SZ_1M)
> +#define MFC_VERSION_V12			0xC0
> +#define MFC_NUM_PORTS_V12		1
> +#define S5P_FIMV_CODEC_VP9_ENC		27
> +
> +/* Encoder buffer size for MFCv12 */
> +#define ENC_V120_BASE_SIZE(x, y) \
> +	(((x + 3) * (y + 3) * 8) \
> +	+ (((y * 64) + 2304) * (x + 7) / 8))
> +
> +#define ENC_V120_H264_ME_SIZE(x, y) \
> +	ALIGN((ENC_V120_BASE_SIZE(x, y) \
> +	+ (DIV_ROUND_UP(x * y, 64) * 32)), 256)
> +
> +#define ENC_V120_MPEG4_ME_SIZE(x, y) \
> +	ALIGN((ENC_V120_BASE_SIZE(x, y) \
> +	+ (DIV_ROUND_UP(x * y, 128) * 16)), 256)
> +
> +#define ENC_V120_VP8_ME_SIZE(x, y) \
> +	ALIGN(ENC_V120_BASE_SIZE(x, y), 256)
> +
> +#define ENC_V120_HEVC_ME_SIZE(x, y)     \
> +	ALIGN((((x + 3) * (y + 3) * 32)       \
> +	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
> +
> +#endif /*_REGS_MFC_V12_H*/
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index e30e54935d79..dee9ef017997 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -790,6 +790,8 @@ static int s5p_mfc_open(struct file *file)
>  	INIT_LIST_HEAD(&ctx->dst_queue);
>  	ctx->src_queue_cnt = 0;
>  	ctx->dst_queue_cnt = 0;
> +	ctx->is_422 = 0;
> +	ctx->is_10bit = 0;
>  	/* Get context number */
>  	ctx->num = 0;
>  	while (dev->ctx[ctx->num]) {
> @@ -1660,6 +1662,31 @@ static struct s5p_mfc_variant mfc_drvdata_v10 = {
>  	.fw_name[0]     = "s5p-mfc-v10.fw",
>  };
> 
> +static struct s5p_mfc_buf_size_v6 mfc_buf_size_v12 = {
> +	.dev_ctx        = MFC_CTX_BUF_SIZE_V12,
> +	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V12,
> +	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V12,
> +	.h264_enc_ctx   = MFC_H264_ENC_CTX_BUF_SIZE_V12,
> +	.hevc_enc_ctx   = MFC_HEVC_ENC_CTX_BUF_SIZE_V12,
> +	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V12, };
> +
> +static struct s5p_mfc_buf_size buf_size_v12 = {
> +	.fw     = MAX_FW_SIZE_V12,
> +	.cpb    = MAX_CPB_SIZE_V12,
> +	.priv   = &mfc_buf_size_v12,
> +};
> +
> +static struct s5p_mfc_variant mfc_drvdata_v12 = {
> +	.version        = MFC_VERSION_V12,
> +	.version_bit    = MFC_V12_BIT,
> +	.port_num       = MFC_NUM_PORTS_V12,
> +	.buf_size       = &buf_size_v12,
> +	.fw_name[0]     = "s5p-mfc-v12.fw",
> +	.clk_names	= {"mfc"},
> +	.num_clocks	= 1,
> +};
> +
>  static const struct of_device_id exynos_mfc_match[] = {
>  	{
>  		.compatible = "samsung,mfc-v5",
> @@ -1682,6 +1709,9 @@ static const struct of_device_id
> exynos_mfc_match[] = {
>  	}, {
>  		.compatible = "samsung,mfc-v10",
>  		.data = &mfc_drvdata_v10,
> +	}, {
> +		.compatible = "tesla,fsd-mfc",
> +		.data = &mfc_drvdata_v12,
>  	},
>  	{},
>  };
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index e6ec4a43b290..dd2e9f7704ab 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -19,7 +19,7 @@
>  #include <media/v4l2-ioctl.h>
>  #include <media/videobuf2-v4l2.h>
>  #include "regs-mfc.h"
> -#include "regs-mfc-v10.h"
> +#include "regs-mfc-v12.h"
> 
>  #define S5P_MFC_NAME		"s5p-mfc"
> 
> @@ -720,6 +720,8 @@ struct s5p_mfc_ctx {
>  	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	size_t scratch_buf_size;
> +	int is_10bit;
> +	int is_422;
>  };
> 
>  /*
> @@ -775,6 +777,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh,
> struct vb2_queue *vq);
>  #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
>  #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
>  #define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
> +#define IS_MFCV12(dev)		(dev->variant->version >= 0xC0)
>  #define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
> 
>  #define MFC_V5_BIT	BIT(0)
> @@ -782,11 +785,15 @@ void s5p_mfc_cleanup_queue(struct list_head *lh,
> struct vb2_queue *vq);
>  #define MFC_V7_BIT	BIT(2)
>  #define MFC_V8_BIT	BIT(3)
>  #define MFC_V10_BIT	BIT(5)
> +#define MFC_V12_BIT	BIT(7)
> 
>  #define MFC_V5PLUS_BITS		(MFC_V5_BIT | MFC_V6_BIT |
> MFC_V7_BIT | \
> -					MFC_V8_BIT | MFC_V10_BIT)
> +					MFC_V8_BIT | MFC_V10_BIT |
> MFC_V12_BIT)
>  #define MFC_V6PLUS_BITS		(MFC_V6_BIT | MFC_V7_BIT |
> MFC_V8_BIT | \
> -					MFC_V10_BIT)
> -#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT |
> MFC_V10_BIT)
> +					MFC_V10_BIT | MFC_V12_BIT)
> +#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT |
> MFC_V10_BIT | \
> +					MFC_V12_BIT)
> +
> +#define MFC_V10PLUS_BITS	(MFC_V10_BIT | MFC_V12_BIT)
> 
>  #endif /* S5P_MFC_COMMON_H_ */
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> index 54b54b2fa9b1..b49159142c53 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> @@ -130,7 +130,7 @@ int s5p_mfc_reset(struct s5p_mfc_dev *dev)
>  			mfc_write(dev, 0, S5P_FIMV_REG_CLEAR_BEGIN_V6
> + (i*4));
> 
>  		/* check bus reset control before reset */
> -		if (dev->risc_on)
> +		if (dev->risc_on && !IS_MFCV12(dev))
Please write in the comment why this is needed for V12

>  			if (s5p_mfc_bus_reset(dev))
>  				return -EIO;
>  		/* Reset
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index 268ffe4da53c..e219cbcd86d5 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> @@ -146,7 +146,7 @@ static struct s5p_mfc_fmt formats[] = {
>  		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
>  		.type		= MFC_FMT_DEC,
>  		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10PLUS_BITS,
>  		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION |
> 
> V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM,
>  	},
> @@ -155,7 +155,7 @@ static struct s5p_mfc_fmt formats[] = {
>  		.codec_mode	= S5P_FIMV_CODEC_VP9_DEC,
>  		.type		= MFC_FMT_DEC,
>  		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10PLUS_BITS,
>  		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION,
>  	},
>  };
> @@ -355,7 +355,7 @@ static int vidioc_g_fmt(struct file *file, void *priv,
> struct v4l2_format *f)
>  		pix_mp->width = ctx->buf_width;
>  		pix_mp->height = ctx->buf_height;
>  		pix_mp->field = V4L2_FIELD_NONE;
> -		pix_mp->num_planes = 2;
> +		pix_mp->num_planes = ctx->dst_fmt->num_planes;
>  		/* Set pixelformat to the format in which MFC
>  		   outputs the decoded frame */
>  		pix_mp->pixelformat = ctx->dst_fmt->fourcc; diff --git
> a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index f62703cebb77..e4d6e7c117b5 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> @@ -92,7 +92,7 @@ static struct s5p_mfc_fmt formats[] = {
>  		.codec_mode	= S5P_FIMV_CODEC_HEVC_ENC,
>  		.type		= MFC_FMT_ENC,
>  		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10PLUS_BITS,
>  	},
>  };
> 
> @@ -1179,7 +1179,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx
> *ctx)
>  		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
>  			ctx->scratch_buf_size = s5p_mfc_hw_call(dev-
> >mfc_ops,
>  					get_e_min_scratch_buf_size, dev);
> -			ctx->bank1.size += ctx->scratch_buf_size;
> +			if (!IS_MFCV12(dev))
> +				ctx->bank1.size += ctx->scratch_buf_size;
>  		}
>  		ctx->state = MFCINST_HEAD_PRODUCED;
>  	}
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> index b9831275f3ab..87ac56756a16 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> @@ -166,9 +166,9 @@ struct s5p_mfc_regs {
>  	void __iomem *d_decoded_third_addr;/* only v7 */
>  	void __iomem *d_used_dpb_flag_upper;/* v7 and v8 */
>  	void __iomem *d_used_dpb_flag_lower;/* v7 and v8 */
> -	void __iomem *d_min_scratch_buffer_size; /* v10 */
> -	void __iomem *d_static_buffer_addr; /* v10 */
> -	void __iomem *d_static_buffer_size; /* v10 */
> +	void __iomem *d_min_scratch_buffer_size; /* v10 and v12 */
> +	void __iomem *d_static_buffer_addr; /* v10 and v12 */
> +	void __iomem *d_static_buffer_size; /* v10 and v12 */
> 
>  	/* encoder registers */
>  	void __iomem *e_frame_width;
> @@ -268,7 +268,7 @@ struct s5p_mfc_regs {
>  	void __iomem *e_vp8_hierarchical_qp_layer0;/* v7 and v8 */
>  	void __iomem *e_vp8_hierarchical_qp_layer1;/* v7 and v8 */
>  	void __iomem *e_vp8_hierarchical_qp_layer2;/* v7 and v8 */
> -	void __iomem *e_min_scratch_buffer_size; /* v10 */
> +	void __iomem *e_min_scratch_buffer_size; /* v10 and v12 */
>  	void __iomem *e_num_t_layer; /* v10 */
>  	void __iomem *e_hier_qp_layer0; /* v10 */
>  	void __iomem *e_hier_bit_rate_layer0; /* v10 */ diff --git
> a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 882166e4ac50..fb3f0718821d 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -60,12 +60,14 @@ static void
> s5p_mfc_release_dec_desc_buffer_v6(struct s5p_mfc_ctx *ctx)  static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
> -	unsigned int mb_width, mb_height;
> +	unsigned int mb_width, mb_height, width64, height32;
>  	unsigned int lcu_width = 0, lcu_height = 0;
>  	int ret;
> 
>  	mb_width = MB_WIDTH(ctx->img_width);
>  	mb_height = MB_HEIGHT(ctx->img_height);
> +	width64 = ALIGN(ctx->img_width, 64);
> +	height32 = ALIGN(ctx->img_height, 32);
> 
>  	if (ctx->type == MFCINST_DECODER) {
>  		mfc_debug(2, "Luma size:%d Chroma size:%d MV
> size:%d\n", @@ -82,7 +84,44 @@ static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>  			ctx->tmv_buffer_size =
> S5P_FIMV_NUM_TMV_BUFFERS_V6 *
> 
> 	ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
>  			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
> +			lcu_height = S5P_MFC_LCU_HEIGHT(ctx-
> >img_height);
> +			if (ctx->codec_mode ==
> S5P_FIMV_CODEC_HEVC_ENC &&
> +								ctx->is_10bit)
> {
> +				ctx->luma_dpb_size =
> +					width64 * height32 +
> +					ALIGN(DIV_ROUND_UP(lcu_width *
> 32, 4),
> +							16) * height32 + 128;
> +				if (ctx->is_422)
> +					ctx->chroma_dpb_size =
> +						ctx->luma_dpb_size;
> +				else
> +					ctx->chroma_dpb_size =
> +						width64 * height32 / 2 +
> +
> 	ALIGN(DIV_ROUND_UP(lcu_width *
> +						32, 4), 16) * height32 / 2 +
> 128;
> +			} else if (ctx->codec_mode ==
> S5P_FIMV_CODEC_VP9_ENC &&
> +					ctx->is_10bit) {
> +				ctx->luma_dpb_size =
> +					ALIGN(ctx->img_width * 2, 128) *
> +					height32 + 64;
> +				ctx->chroma_dpb_size =
> +					ALIGN(ctx->img_width * 2, 128) *
> +					height32 / 2 + 64;
> +			} else {
> +				ctx->luma_dpb_size =
> +					width64 * height32 + 64;
> +				if (ctx->is_422)
> +					ctx->chroma_dpb_size =
> +						ctx->luma_dpb_size;
> +				else
> +					ctx->chroma_dpb_size =
> +						width64 * height32 / 2 + 64;
> +			}
> +			ctx->luma_dpb_size = ALIGN(ctx->luma_dpb_size +
> 256, SZ_2K);
> +			ctx->chroma_dpb_size = ALIGN(ctx-
> >chroma_dpb_size + 256, SZ_2K);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>  			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
>  			lcu_height = S5P_MFC_LCU_HEIGHT(ctx-
> >img_height);
>  			if (ctx->codec_mode !=
> S5P_FIMV_CODEC_HEVC_ENC) { @@ -230,7 +269,11 @@ static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>  			DEC_VP9_STATIC_BUFFER_SIZE;
>  		break;
>  	case S5P_MFC_CODEC_H264_ENC:
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			mfc_debug(2, "Use min scratch buffer size\n");
> +			ctx->me_buffer_size =
> +				ENC_V120_H264_ME_SIZE(mb_width,
> mb_height);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  			ctx->me_buffer_size =
>  			ALIGN(ENC_V100_H264_ME_SIZE(mb_width,
> mb_height), 16); @@ -254,7 +297,11 @@ static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>  		break;
>  	case S5P_MFC_CODEC_MPEG4_ENC:
>  	case S5P_MFC_CODEC_H263_ENC:
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			mfc_debug(2, "Use min scratch buffer size\n");
> +			ctx->me_buffer_size =
> +				ENC_V120_MPEG4_ME_SIZE(mb_width,
> mb_height);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  			ctx->me_buffer_size =
> 
> 	ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
> @@ -273,7 +320,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)
>  		ctx->bank2.size = 0;
>  		break;
>  	case S5P_MFC_CODEC_VP8_ENC:
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			mfc_debug(2, "Use min scratch buffer size\n");
> +			ctx->me_buffer_size =
> +				ENC_V120_VP8_ME_SIZE(mb_width,
> mb_height);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>  			mfc_debug(2, "Use min scratch buffer size\n");
>  			ctx->me_buffer_size =
>  				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width,
> mb_height), @@ -297,9 +348,14 @@ static int
> s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>  		ctx->bank2.size = 0;
>  		break;
>  	case S5P_MFC_CODEC_HEVC_ENC:
> +		if (IS_MFCV12(dev))
> +			ctx->me_buffer_size =
> +				ENC_V120_HEVC_ME_SIZE(lcu_width,
> lcu_height);
> +		else
> +			ctx->me_buffer_size =
> +				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
> +							lcu_height), 16);
>  		mfc_debug(2, "Use min scratch buffer size\n");
> -		ctx->me_buffer_size =
> -			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
> lcu_height), 16);
>  		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
>  		ctx->bank1.size =
>  			ctx->scratch_buf_size + ctx->tmv_buffer_size + @@
> -452,12 +508,15 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct
> s5p_mfc_ctx *ctx)
> 
>  	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
>  			ctx->codec_mode ==
> S5P_MFC_CODEC_H264_MVC_DEC) {
> -		if (IS_MFCV10_PLUS(dev)) {
> -			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx-
> >img_width,
> -					ctx->img_height);
> +		if (IS_MFCV12(dev)) {
> +			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx-
> >img_width,
> +					ctx->img_height, 1024);
> +		} else if (IS_MFCV10_PLUS(dev)) {
> +			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx-
> >img_width,
> +					ctx->img_height, 512);
>  		} else {
> -			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx-
> >img_width,
> -					ctx->img_height);
> +			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx-
> >img_width,
> +					ctx->img_height, 128);
>  		}
>  	} else if (ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
>  		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx-
> >img_width,
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> index e4dd03c5454c..30269f3e68e8 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> @@ -19,10 +19,8 @@
> 
>  #define MB_WIDTH(x_size)		DIV_ROUND_UP(x_size, 16)
>  #define MB_HEIGHT(y_size)		DIV_ROUND_UP(y_size, 16)
> -#define S5P_MFC_DEC_MV_SIZE_V6(x, y)	(MB_WIDTH(x) * \
> -					(((MB_HEIGHT(y)+1)/2)*2) * 64 +
> 128)
> -#define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
> -					(((MB_HEIGHT(y)+1)/2)*2) * 64 +
> 512)
> +#define S5P_MFC_DEC_MV_SIZE(x, y, offset)	(MB_WIDTH(x) * \
> +					(((MB_HEIGHT(y)+1)/2)*2) * 64 +
> offset)
>  #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
>  #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
> 
> --
> 2.17.1


