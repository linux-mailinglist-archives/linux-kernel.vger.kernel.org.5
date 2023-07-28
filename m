Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138F766F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbjG1OT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjG1OTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:19:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850E3C30
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so3765523e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690553971; x=1691158771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwC1GnhTIaS1iQUgfL/p8s3hC5LFjPYomRAoG7YJ7FA=;
        b=xeREq3Cd4kH9iJCkMZdFmavDkhLL+IrGzu3OlZJ5MWF/douNVsygXfRp1WhAKJlfM2
         XlppJrJKl2JFAtKIshrhlJ7aSfSCTqVrtuJ+bmFrsnD+tErduzpHkvDYUanAAnrdNA9I
         RkymAaXG+BJwEDMLz5LEXAU2tcv0S6d1eM8p2s6XF5bN6rbJ7buPV1+Cg2Y5cQMsf2j6
         pTGl6uW09AqtPu8vbhrif29v28OiabFwMnZvawTlmNkyJxuqmMIlCEKDkOTk7OFFptfO
         smYU7fuZwQgj3m2F6hEueOcHrl52xV9dyN7hd6aCX8hlx7Xvo/1GD/lmeTcSCDkAE95K
         OLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553971; x=1691158771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwC1GnhTIaS1iQUgfL/p8s3hC5LFjPYomRAoG7YJ7FA=;
        b=J07aS+ikyFZ6KmFb8XrHScOfUXq3/jUGIhN3iQmhNYgAw9PXbIqELUv3fFm84bT1QM
         HXwlZv7MJM+kcCfVQddMl5AQk4Ku36S1wp/WoJu0M0u55Df/BFnSrZcUU6c2PV1vttzQ
         M3FuL5oaBNCrklCAAEO24Cl3QnUjc5Ye2uUwbQLQnDNcqK71DRTbJS6QjmwxdismTDPB
         1Sugxkdvobx3j+r4rdRw9k/LQB55+ityu13QberJIlKDo1JA89Pwo1fbszKHSGxTdXSQ
         mXUkrr1dBr+JJbEayNYjE5AIdtds54oe2K20U6TRyR4PrEM4Wrlx1+J2L52qFRg/PyqK
         Shig==
X-Gm-Message-State: ABy/qLaX2cAddTODOYk7xZQIkCf0fqxG5dSDwIem77T2MEer/TgebBjv
        5/sp7l1PdmY6PTK17kvQtMbCPA==
X-Google-Smtp-Source: APBJJlHzw1rBPo079EO+VWTgu2lUabU7pwoieaXR8FYzSmvqpnehu09eQhphUQei2bfDV1iEY+i9xg==
X-Received: by 2002:ac2:5f43:0:b0:4fb:8680:138a with SMTP id 3-20020ac25f43000000b004fb8680138amr1781361lfz.22.1690553971398;
        Fri, 28 Jul 2023 07:19:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b004fe09920fe5sm849910lfk.47.2023.07.28.07.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:19:30 -0700 (PDT)
Message-ID: <7e51bbe3-5a28-da22-84fa-3f2964556198@linaro.org>
Date:   Fri, 28 Jul 2023 17:19:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 29/33] iris: variant: iris3: add helpers for buffer size
 calculations
Content-Language: en-GB
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-30-git-send-email-quic_vgarodia@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1690550624-14642-30-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 16:23, Vikash Garodia wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> This implements iris3 specific buffer size calculation for
> firmware internal buffers, input and output buffers for
> encoder and decoder.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   .../qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h | 1481 ++++++++++++++++++++
>   .../iris/variant/iris3/inc/msm_vidc_buffer_iris3.h |   19 +
>   .../iris/variant/iris3/src/msm_vidc_buffer_iris3.c |  595 ++++++++
>   3 files changed, 2095 insertions(+)
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_buffer_iris3.h
>   create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_buffer_iris3.c
> 
> diff --git a/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h b/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
> new file mode 100644
> index 0000000..cb068ca
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
> @@ -0,0 +1,1481 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __HFI_BUFFER_IRIS3__
> +#define __HFI_BUFFER_IRIS3__
> +
> +#include <linux/types.h>
> +
> +#include "hfi_property.h"
> +
> +typedef u8      HFI_U8;
> +typedef s8      HFI_S8;
> +typedef u16     HFI_U16;
> +typedef s16     HFI_S16;
> +typedef u32     HFI_U32;
> +typedef s32     HFI_S32;
> +typedef u64     HFI_U64;
> +typedef u32     HFI_BOOL;

No custom typedefs please.

> +
> +#ifndef MIN
> +#define  MIN(x, y) (((x) < (y)) ? (x) : (y))
> +#endif
> +
> +#ifndef MAX
> +#define  MAX(x, y) (((x) > (y)) ? (x) : (y))
> +#endif

You have seen <linux/minmax.h>, didn't you? If so, why are you adding 
new wrappers?

> +
> +#define HFI_ALIGNMENT_4096 (4096)
> +
> +#define BUF_SIZE_ALIGN_16 (16)
> +#define BUF_SIZE_ALIGN_32 (32)
> +#define BUF_SIZE_ALIGN_64 (64)
> +#define BUF_SIZE_ALIGN_128 (128)
> +#define BUF_SIZE_ALIGN_256 (256)
> +#define BUF_SIZE_ALIGN_512 (512)
> +#define BUF_SIZE_ALIGN_4096 (4096)

So nice, so useless.

> +
> +#define HFI_ALIGN(a, b) (((b) & ((b) - 1)) ? (((a) + (b) - 1) / \
> +	(b) * (b)) : (((a) + (b) - 1) & (~((b) - 1))))

Can you use ALIGN instead?

> +
> +#define HFI_WORKMODE_1 1
> +#define HFI_WORKMODE_2 2
> +
> +#define HFI_DEFAULT_METADATA_STRIDE_MULTIPLE (64)
> +#define HFI_DEFAULT_METADATA_BUFFERHEIGHT_MULTIPLE (16)
> +
> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT (8)
> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH (32)
> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT (8)
> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH (16)
> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_HEIGHT (4)
> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_WIDTH (48)
> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_HEIGHT (4)
> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_WIDTH (24)
> +#define HFI_COLOR_FORMAT_RGBA8888_UBWC_TILE_HEIGHT (4)
> +#define HFI_COLOR_FORMAT_RGBA8888_UBWC_TILE_WIDTH (16)
> +
> +#define HFI_NV12_IL_CALC_Y_STRIDE(stride, frame_width, stride_multiple) \
> +	(stride = HFI_ALIGN(frame_width, stride_multiple))

macros with side actions are not really welcomed. Especially as they do 
not bring any additional value and can be inlined.

> +
> +#define HFI_NV12_IL_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
> +	min_buf_height_multiple) (buf_height = HFI_ALIGN(frame_height, \
> +	min_buf_height_multiple))
> +
> +#define HFI_NV12_IL_CALC_UV_STRIDE(stride, frame_width, stride_multiple) \
> +	(stride = HFI_ALIGN(frame_width, stride_multiple))
> +
> +#define HFI_NV12_IL_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
> +	min_buf_height_multiple) (buf_height = HFI_ALIGN((((frame_height) + 1) \
> +	 >> 1),	min_buf_height_multiple))
> +
> +#define HFI_NV12_IL_CALC_BUF_SIZE(buf_size, y_bufsize, y_stride, y_buf_height, \
> +	uv_buf_size, uv_stride, uv_buf_height) \
> +	do { \
> +		y_bufsize = (y_stride * y_buf_height); \
> +		uv_buf_size = (uv_stride * uv_buf_height); \
> +		buf_size = HFI_ALIGN(y_bufsize + uv_buf_size, HFI_ALIGNMENT_4096) \
> +	} while (0)
> +
> +#define HFI_NV12_UBWC_IL_CALC_Y_BUF_SIZE(y_bufsize, y_stride, y_buf_height) \
> +	(y_bufsize = HFI_ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096))
> +
> +#define HFI_NV12_UBWC_IL_CALC_UV_BUF_SIZE(uv_buf_size, \
> +	uv_stride, uv_buf_height) \
> +	(uv_buf_size = HFI_ALIGN(uv_stride * uv_buf_height, HFI_ALIGNMENT_4096))
> +
> +#define HFI_NV12_UBWC_IL_CALC_BUF_SIZE_V2(buf_size,\
> +	frame_width, frame_height, y_stride_multiple,\
> +	y_buffer_height_multiple, uv_stride_multiple, \
> +	uv_buffer_height_multiple, y_metadata_stride_multiple, \
> +	y_metadata_buffer_height_multiple, \
> +	uv_metadata_stride_multiple, uv_metadata_buffer_height_multiple) \
> +	do { \
> +		HFI_U32 y_buf_size, uv_buf_size, y_meta_size, uv_meta_size;   \
> +		HFI_U32 stride, _height; \
> +		HFI_U32 half_height = (frame_height + 1) >> 1; \
> +		HFI_NV12_IL_CALC_Y_STRIDE(stride, frame_width,\
> +					y_stride_multiple); \
> +		HFI_NV12_IL_CALC_Y_BUFHEIGHT(_height, half_height,\
> +					y_buffer_height_multiple); \
> +		HFI_NV12_UBWC_IL_CALC_Y_BUF_SIZE(y_buf_size, stride, _height);\
> +		HFI_NV12_IL_CALC_UV_STRIDE(stride, frame_width, \
> +					uv_stride_multiple); \
> +		HFI_NV12_IL_CALC_UV_BUFHEIGHT(_height, half_height, \
> +					uv_buffer_height_multiple); \
> +		HFI_NV12_UBWC_IL_CALC_UV_BUF_SIZE(uv_buf_size, stride, _height);\
> +		HFI_UBWC_CALC_METADATA_PLANE_STRIDE(stride, frame_width,\
> +				y_metadata_stride_multiple, \
> +			HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH);\
> +		HFI_UBWC_METADATA_PLANE_BUFHEIGHT(_height, half_height, \
> +				y_metadata_buffer_height_multiple,\
> +			HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT);\
> +		HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(y_meta_size, stride, \
> +				_height);    \
> +		HFI_UBWC_UV_METADATA_PLANE_STRIDE(stride, frame_width,\
> +				uv_metadata_stride_multiple, \
> +			HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH); \
> +		HFI_UBWC_UV_METADATA_PLANE_BUFHEIGHT(_height, half_height,\
> +				uv_metadata_buffer_height_multiple,\
> +			HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT);\
> +		HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(uv_meta_size, stride, \
> +				 _height); \
> +		buf_size = (y_buf_size + uv_buf_size + y_meta_size + \
> +			uv_meta_size) << 1;\
> +	} while (0)

Even more macro with side effects. Please consider rewriting them to be 
functions. Small function is usually easier to understand compared to 
the complex macro.

> +
> +#define HFI_YUV420_TP10_CALC_Y_STRIDE(stride, frame_width, stride_multiple) \
> +	do { \
> +		stride = HFI_ALIGN(frame_width, 192); \
> +		stride = HFI_ALIGN(stride * 4 / 3, stride_multiple); \
> +	} while (0)
> +
> +#define HFI_YUV420_TP10_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
> +				min_buf_height_multiple) \
> +	(buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
> +
> +#define HFI_YUV420_TP10_CALC_UV_STRIDE(stride, frame_width, stride_multiple) \
> +	do { \
> +		stride = HFI_ALIGN(frame_width, 192); \
> +		stride = HFI_ALIGN(stride * 4 / 3, stride_multiple); \
> +	} while (0)
> +
> +#define HFI_YUV420_TP10_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
> +				min_buf_height_multiple) \
> +	(buf_height = HFI_ALIGN(((frame_height + 1) >> 1), \
> +			min_buf_height_multiple))
> +
> +#define HFI_YUV420_TP10_CALC_BUF_SIZE(buf_size, y_buf_size, y_stride,\
> +		y_buf_height, uv_buf_size, uv_stride, uv_buf_height) \
> +	do {	\
> +		y_buf_size = (y_stride * y_buf_height); \
> +		uv_buf_size = (uv_stride * uv_buf_height); \
> +		buf_size = y_buf_size + uv_buf_size \
> +	} while (0)
> +
> +#define HFI_YUV420_TP10_UBWC_CALC_Y_BUF_SIZE(y_buf_size, y_stride, \
> +					y_buf_height) \
> +	(y_buf_size = HFI_ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096))
> +
> +#define HFI_YUV420_TP10_UBWC_CALC_UV_BUF_SIZE(uv_buf_size, uv_stride, \
> +					uv_buf_height) \
> +	(uv_buf_size = HFI_ALIGN(uv_stride * uv_buf_height, HFI_ALIGNMENT_4096))
> +
> +#define HFI_YUV420_TP10_UBWC_CALC_BUF_SIZE(buf_size, y_stride, y_buf_height, \
> +	uv_stride, uv_buf_height, y_md_stride, y_md_height, uv_md_stride, \
> +	uv_md_height)\
> +	do { \
> +		HFI_U32 y_data_size, uv_data_size, y_md_size, uv_md_size; \
> +		HFI_YUV420_TP10_UBWC_CALC_Y_BUF_SIZE(y_data_size, y_stride,\
> +						y_buf_height); \
> +		HFI_YUV420_TP10_UBWC_CALC_UV_BUF_SIZE(uv_data_size, uv_stride, \
> +						uv_buf_height); \
> +		HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(y_md_size, y_md_stride, \
> +						y_md_height); \
> +		HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(uv_md_size, uv_md_stride, \
> +						uv_md_height); \
> +		buf_size = y_data_size + uv_data_size + y_md_size + \
> +						uv_md_size; \
> +	} while (0)
> +
> +#define HFI_YUV420_P010_CALC_Y_STRIDE(stride, frame_width, stride_multiple) \
> +	(stride = HFI_ALIGN(frame_width * 2, stride_multiple))
> +
> +#define HFI_YUV420_P010_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
> +				min_buf_height_multiple) \
> +	(buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
> +
> +#define HFI_YUV420_P010_CALC_UV_STRIDE(stride, frame_width, stride_multiple) \
> +	(stride = HFI_ALIGN(frame_width * 2, stride_multiple))
> +
> +#define HFI_YUV420_P010_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
> +				min_buf_height_multiple) \
> +	(buf_height = HFI_ALIGN(((frame_height + 1) >> 1), \
> +			min_buf_height_multiple))
> +
> +#define HFI_YUV420_P010_CALC_BUF_SIZE(buf_size, y_data_size, y_stride, \
> +	y_buf_height, uv_data_size, uv_stride, uv_buf_height) \
> +	do { \
> +		y_data_size = HFI_ALIGN(y_stride * y_buf_height, \
> +				HFI_ALIGNMENT_4096);\
> +		uv_data_size = HFI_ALIGN(uv_stride * uv_buf_height, \
> +				HFI_ALIGNMENT_4096); \
> +		buf_size = y_data_size + uv_data_size; \
> +	} while (0)
> +
> +#define HFI_RGB888_CALC_STRIDE(stride, frame_width, stride_multiple) \
> +	(stride = ((frame_width * 3) + stride_multiple - 1) & \
> +			 (0xffffffff - (stride_multiple - 1)))
> +
> +#define HFI_RGB888_CALC_BUFHEIGHT(buf_height, frame_height, \
> +			min_buf_height_multiple) \
> +	(buf_height = ((frame_height + min_buf_height_multiple - 1) & \
> +			(0xffffffff - (min_buf_height_multiple - 1))))
> +
> +#define HFI_RGB888_CALC_BUF_SIZE(buf_size, stride, buf_height) \
> +	(buf_size = ((stride) * (buf_height)))
> +
> +#define HFI_RGBA8888_CALC_STRIDE(stride, frame_width, stride_multiple) \
> +	(stride = HFI_ALIGN((frame_width << 2), stride_multiple))
> +
> +#define HFI_RGBA8888_CALC_BUFHEIGHT(buf_height, frame_height, \
> +			min_buf_height_multiple) \
> +	(buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
> +
> +#define HFI_RGBA8888_CALC_BUF_SIZE(buf_size, stride, buf_height) \
> +	(buf_size = (stride) * (buf_height))
> +
> +#define HFI_RGBA8888_UBWC_CALC_DATA_PLANE_BUF_SIZE(buf_size, stride, \
> +				buf_height) \
> +	(buf_size = HFI_ALIGN((stride) * (buf_height), HFI_ALIGNMENT_4096))
> +
> +#define HFI_RGBA8888_UBWC_BUF_SIZE(buf_size, data_buf_size, \
> +	metadata_buffer_size, stride, buf_height, _metadata_tride, \
> +	_metadata_buf_height) \
> +	do { \
> +		HFI_RGBA8888_UBWC_CALC_DATA_PLANE_BUF_SIZE(data_buf_size, \
> +				stride, buf_height); \
> +		HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(metadata_buffer_size, \
> +				_metadata_tride, _metadata_buf_height); \
> +		buf_size = data_buf_size + metadata_buffer_size \
> +	} while (0)
> +
> +#define HFI_UBWC_CALC_METADATA_PLANE_STRIDE(metadata_stride, frame_width,\
> +	metadata_stride_multiple, tile_width_in_pels) \
> +	((metadata_stride = HFI_ALIGN(((frame_width + (tile_width_in_pels - 1)) /\
> +	tile_width_in_pels), metadata_stride_multiple)))
> +
> +#define HFI_UBWC_METADATA_PLANE_BUFHEIGHT(metadata_buf_height, frame_height, \
> +	metadata_height_multiple, tile_height_in_pels) \
> +	((metadata_buf_height = HFI_ALIGN(((frame_height + \
> +	(tile_height_in_pels - 1)) / tile_height_in_pels), \
> +	metadata_height_multiple)))
> +
> +#define HFI_UBWC_UV_METADATA_PLANE_STRIDE(metadata_stride, frame_width, \
> +	metadata_stride_multiple, tile_width_in_pels) \
> +	((metadata_stride = HFI_ALIGN(((((frame_width + 1) >> 1) +\
> +	(tile_width_in_pels - 1)) / tile_width_in_pels), \
> +	metadata_stride_multiple)))
> +
> +#define HFI_UBWC_UV_METADATA_PLANE_BUFHEIGHT(metadata_buf_height, frame_height,\
> +	metadata_height_multiple, tile_height_in_pels) \
> +	(metadata_buf_height = HFI_ALIGN(((((frame_height + 1) >> 1) + \
> +	(tile_height_in_pels - 1)) / tile_height_in_pels), \
> +	metadata_height_multiple))
> +
> +#define HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(buffer_size, _metadata_tride, \
> +					_metadata_buf_height) \
> +	((buffer_size = HFI_ALIGN(_metadata_tride * _metadata_buf_height, \
> +					HFI_ALIGNMENT_4096)))
> +
> +#define BUFFER_ALIGNMENT_512_BYTES 512
> +#define BUFFER_ALIGNMENT_256_BYTES 256
> +#define BUFFER_ALIGNMENT_128_BYTES 128
> +#define BUFFER_ALIGNMENT_64_BYTES 64
> +#define BUFFER_ALIGNMENT_32_BYTES 32
> +#define BUFFER_ALIGNMENT_16_BYTES 16
> +#define BUFFER_ALIGNMENT_8_BYTES 8
> +#define BUFFER_ALIGNMENT_4_BYTES 4

-ETOOMUCH.

[skipped the rest, internal reviewer exception]

-- 
With best wishes
Dmitry

