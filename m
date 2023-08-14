Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3977C201
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjHNVAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjHNU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:59:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42B172C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:59:37 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a78604f47fso4508230b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692046777; x=1692651577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IkvgHM7pwrERf757dL/7S3wwO2XY8ZMTsiS3lItPt14=;
        b=L4RbZ4iYTLfI0NBGTSBmGQM9yDD007sNKt+vGh3vPFD28bi/2M8Y3Du0IJlhX7O8IU
         NAMlVJPAtzpShWIA3quJT++O/HWEqgm+3QVty1Ynin8debf1D9e9JOWcu6GdPe99FHWL
         /N+vVaOD3hwOA2ZsIW2M8d7xyPNrFrBggsoSe5KecIQ5PqhWBqQWl+hk/VJ0+H4aPjBR
         qtp4dsp5KB6W1eaOd05dkLM6EqSrNrtjsMgZDhq96+S3qLd5bU5bnFEXodXdc9XzVmWu
         MAD0gnL2VhAbF/csTbcR4qaKjXhbP09Xw9vfC4yAQQaFcZ6L+qbnFen/pcfKUzCMRQ75
         e3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046777; x=1692651577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkvgHM7pwrERf757dL/7S3wwO2XY8ZMTsiS3lItPt14=;
        b=BKGpsU9dPWKs7fQQ6RtCbujyc3astw3xpf/Bfh1GY7x1RD6u61rLgho0JSSOEAmpY+
         tBRE35HKejEhVzg7DGZsYqFkBwG6HrbjcFLH19ESopSwZhFIa10T+n9NTDkvv1iJTHry
         tmoGxQucJrNZDfKbmbKbtd8fgkFYtDPR/nogrLPtkhueNG5bCT5ny+vDF9Uya0Tjz+sL
         y5GuZq4h2oIgpF2WYVilTtBemfA1kr8je4LDy6QYSurCNIHxKEeQyaWSS7XbdP9wOU81
         8By37MvkA6q/zHF6pBMXBIdfEO64WTDxGlmWbQjNRA5rDTrQZe8//MREhVlm8Jcj36XT
         ystg==
X-Gm-Message-State: AOJu0Yx1uj6jpALD0kfGfomSHPpcA+yK1Wp0cWphilKujTvUYxHqXFGg
        jehNYC7PfzsyAucnwpBxLSrqjh1Cwx99n7zfnBTMGA==
X-Google-Smtp-Source: AGHT+IHDw56TmyTxOqQ0ocOhxAOxNQoFiTeFqwJl7F7D7NJy9FhImNJQIHCjY05cQZSyMTzgyhd5srPVYalOB4agZYI=
X-Received: by 2002:a05:6358:9209:b0:129:c6d6:ce40 with SMTP id
 d9-20020a056358920900b00129c6d6ce40mr8875645rwb.15.1692046776937; Mon, 14 Aug
 2023 13:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-30-git-send-email-quic_vgarodia@quicinc.com>
 <7e51bbe3-5a28-da22-84fa-3f2964556198@linaro.org> <1f009684-4d99-ecf6-001e-7925d0159a02@quicinc.com>
In-Reply-To: <1f009684-4d99-ecf6-001e-7925d0159a02@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 14 Aug 2023 23:59:25 +0300
Message-ID: <CAA8EJpruzBy8OadRKaUtL0+pKp0ek1hsVAogpFrO-E01jC6apQ@mail.gmail.com>
Subject: Re: [PATCH 29/33] iris: variant: iris3: add helpers for buffer size calculations
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 23:00, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
>
>
> On 7/28/2023 7:49 PM, Dmitry Baryshkov wrote:
> > On 28/07/2023 16:23, Vikash Garodia wrote:
> >> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >>
> >> This implements iris3 specific buffer size calculation for
> >> firmware internal buffers, input and output buffers for
> >> encoder and decoder.
> >>
> >> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> >> ---
> >>   .../qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h | 1481
> >> ++++++++++++++++++++
> >>   .../iris/variant/iris3/inc/msm_vidc_buffer_iris3.h |   19 +
> >>   .../iris/variant/iris3/src/msm_vidc_buffer_iris3.c |  595 ++++++++
> >>   3 files changed, 2095 insertions(+)
> >>   create mode 100644
> >> drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
> >>   create mode 100644
> >> drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_buffer_iris3.h
> >>   create mode 100644
> >> drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_buffer_iris3.c
> >>
> >> diff --git
> >> a/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
> >> b/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
> >> new file mode 100644
> >> index 0000000..cb068ca
> >> --- /dev/null
> >> +++ b/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
> >> @@ -0,0 +1,1481 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights
> >> reserved.
> >> + */
> >> +
> >> +#ifndef __HFI_BUFFER_IRIS3__
> >> +#define __HFI_BUFFER_IRIS3__
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +#include "hfi_property.h"
> >> +
> >> +typedef u8      HFI_U8;
> >> +typedef s8      HFI_S8;
> >> +typedef u16     HFI_U16;
> >> +typedef s16     HFI_S16;
> >> +typedef u32     HFI_U32;
> >> +typedef s32     HFI_S32;
> >> +typedef u64     HFI_U64;
> >> +typedef u32     HFI_BOOL;
> >
> > No custom typedefs please.
> >
> >> +
> >> +#ifndef MIN
> >> +#define  MIN(x, y) (((x) < (y)) ? (x) : (y))
> >> +#endif
> >> +
> >> +#ifndef MAX
> >> +#define  MAX(x, y) (((x) > (y)) ? (x) : (y))
> >> +#endif
> >
> > You have seen <linux/minmax.h>, didn't you? If so, why are you adding new
> > wrappers?
> >
> >> +
> >> +#define HFI_ALIGNMENT_4096 (4096)
> >> +
> >> +#define BUF_SIZE_ALIGN_16 (16)
> >> +#define BUF_SIZE_ALIGN_32 (32)
> >> +#define BUF_SIZE_ALIGN_64 (64)
> >> +#define BUF_SIZE_ALIGN_128 (128)
> >> +#define BUF_SIZE_ALIGN_256 (256)
> >> +#define BUF_SIZE_ALIGN_512 (512)
> >> +#define BUF_SIZE_ALIGN_4096 (4096)
> >
> > So nice, so useless.
> >
> >> +
> >> +#define HFI_ALIGN(a, b) (((b) & ((b) - 1)) ? (((a) + (b) - 1) / \
> >> +    (b) * (b)) : (((a) + (b) - 1) & (~((b) - 1))))
> >
> > Can you use ALIGN instead?
> >
> >> +
> >> +#define HFI_WORKMODE_1 1
> >> +#define HFI_WORKMODE_2 2
> >> +
> >> +#define HFI_DEFAULT_METADATA_STRIDE_MULTIPLE (64)
> >> +#define HFI_DEFAULT_METADATA_BUFFERHEIGHT_MULTIPLE (16)
> >> +
> >> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT (8)
> >> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH (32)
> >> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT (8)
> >> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH (16)
> >> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_HEIGHT (4)
> >> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_WIDTH (48)
> >> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_HEIGHT (4)
> >> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_WIDTH (24)
> >> +#define HFI_COLOR_FORMAT_RGBA8888_UBWC_TILE_HEIGHT (4)
> >> +#define HFI_COLOR_FORMAT_RGBA8888_UBWC_TILE_WIDTH (16)
> >> +
> >> +#define HFI_NV12_IL_CALC_Y_STRIDE(stride, frame_width, stride_multiple) \
> >> +    (stride = HFI_ALIGN(frame_width, stride_multiple))
> >
> > macros with side actions are not really welcomed. Especially as they do not
> > bring any additional value and can be inlined.
> >
> >> +
> >> +#define HFI_NV12_IL_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
> >> +    min_buf_height_multiple) (buf_height = HFI_ALIGN(frame_height, \
> >> +    min_buf_height_multiple))
> >> +
> >> +#define HFI_NV12_IL_CALC_UV_STRIDE(stride, frame_width, stride_multiple) \
> >> +    (stride = HFI_ALIGN(frame_width, stride_multiple))
> >> +
> >> +#define HFI_NV12_IL_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
> >> +    min_buf_height_multiple) (buf_height = HFI_ALIGN((((frame_height) +
> >> 1) \
> >> +     >> 1),    min_buf_height_multiple))
> >> +
> >> +#define HFI_NV12_IL_CALC_BUF_SIZE(buf_size, y_bufsize, y_stride,
> >> y_buf_height, \
> >> +    uv_buf_size, uv_stride, uv_buf_height) \
> >> +    do { \
> >> +        y_bufsize = (y_stride * y_buf_height); \
> >> +        uv_buf_size = (uv_stride * uv_buf_height); \
> >> +        buf_size = HFI_ALIGN(y_bufsize + uv_buf_size, HFI_ALIGNMENT_4096) \
> >> +    } while (0)
> >> +
> >> +#define HFI_NV12_UBWC_IL_CALC_Y_BUF_SIZE(y_bufsize, y_stride,
> >> y_buf_height) \
> >> +    (y_bufsize = HFI_ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096))
> >> +
> >> +#define HFI_NV12_UBWC_IL_CALC_UV_BUF_SIZE(uv_buf_size, \
> >> +    uv_stride, uv_buf_height) \
> >> +    (uv_buf_size = HFI_ALIGN(uv_stride * uv_buf_height,
> >> HFI_ALIGNMENT_4096))
> >> +
> >> +#define HFI_NV12_UBWC_IL_CALC_BUF_SIZE_V2(buf_size,\
> >> +    frame_width, frame_height, y_stride_multiple,\
> >> +    y_buffer_height_multiple, uv_stride_multiple, \
> >> +    uv_buffer_height_multiple, y_metadata_stride_multiple, \
> >> +    y_metadata_buffer_height_multiple, \
> >> +    uv_metadata_stride_multiple, uv_metadata_buffer_height_multiple) \
> >> +    do { \
> >> +        HFI_U32 y_buf_size, uv_buf_size, y_meta_size, uv_meta_size;   \
> >> +        HFI_U32 stride, _height; \
> >> +        HFI_U32 half_height = (frame_height + 1) >> 1; \
> >> +        HFI_NV12_IL_CALC_Y_STRIDE(stride, frame_width,\
> >> +                    y_stride_multiple); \
> >> +        HFI_NV12_IL_CALC_Y_BUFHEIGHT(_height, half_height,\
> >> +                    y_buffer_height_multiple); \
> >> +        HFI_NV12_UBWC_IL_CALC_Y_BUF_SIZE(y_buf_size, stride, _height);\
> >> +        HFI_NV12_IL_CALC_UV_STRIDE(stride, frame_width, \
> >> +                    uv_stride_multiple); \
> >> +        HFI_NV12_IL_CALC_UV_BUFHEIGHT(_height, half_height, \
> >> +                    uv_buffer_height_multiple); \
> >> +        HFI_NV12_UBWC_IL_CALC_UV_BUF_SIZE(uv_buf_size, stride, _height);\
> >> +        HFI_UBWC_CALC_METADATA_PLANE_STRIDE(stride, frame_width,\
> >> +                y_metadata_stride_multiple, \
> >> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH);\
> >> +        HFI_UBWC_METADATA_PLANE_BUFHEIGHT(_height, half_height, \
> >> +                y_metadata_buffer_height_multiple,\
> >> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT);\
> >> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(y_meta_size, stride, \
> >> +                _height);    \
> >> +        HFI_UBWC_UV_METADATA_PLANE_STRIDE(stride, frame_width,\
> >> +                uv_metadata_stride_multiple, \
> >> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH); \
> >> +        HFI_UBWC_UV_METADATA_PLANE_BUFHEIGHT(_height, half_height,\
> >> +                uv_metadata_buffer_height_multiple,\
> >> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT);\
> >> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(uv_meta_size, stride, \
> >> +                 _height); \
> >> +        buf_size = (y_buf_size + uv_buf_size + y_meta_size + \
> >> +            uv_meta_size) << 1;\
> >> +    } while (0)
> >
> > Even more macro with side effects. Please consider rewriting them to be
> > functions. Small function is usually easier to understand compared to the
> > complex macro.
> >
> The calculations here are about the size of internal buffers, which is
> based on agreed interface between driver and hardware. We will discuss with
> hardware team on the suggested changes so that driver and hardware aligned
> on the size calculations.

Any size / interface / buffer calculations are not a reason for the
bad code style.

>
> Thanks,
> Dikshita
> >> +
> >> +#define HFI_YUV420_TP10_CALC_Y_STRIDE(stride, frame_width,
> >> stride_multiple) \
> >> +    do { \
> >> +        stride = HFI_ALIGN(frame_width, 192); \
> >> +        stride = HFI_ALIGN(stride * 4 / 3, stride_multiple); \
> >> +    } while (0)
> >> +
> >> +#define HFI_YUV420_TP10_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
> >> +                min_buf_height_multiple) \
> >> +    (buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
> >> +
> >> +#define HFI_YUV420_TP10_CALC_UV_STRIDE(stride, frame_width,
> >> stride_multiple) \
> >> +    do { \
> >> +        stride = HFI_ALIGN(frame_width, 192); \
> >> +        stride = HFI_ALIGN(stride * 4 / 3, stride_multiple); \
> >> +    } while (0)
> >> +
> >> +#define HFI_YUV420_TP10_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
> >> +                min_buf_height_multiple) \
> >> +    (buf_height = HFI_ALIGN(((frame_height + 1) >> 1), \
> >> +            min_buf_height_multiple))
> >> +
> >> +#define HFI_YUV420_TP10_CALC_BUF_SIZE(buf_size, y_buf_size, y_stride,\
> >> +        y_buf_height, uv_buf_size, uv_stride, uv_buf_height) \
> >> +    do {    \
> >> +        y_buf_size = (y_stride * y_buf_height); \
> >> +        uv_buf_size = (uv_stride * uv_buf_height); \
> >> +        buf_size = y_buf_size + uv_buf_size \
> >> +    } while (0)
> >> +
> >> +#define HFI_YUV420_TP10_UBWC_CALC_Y_BUF_SIZE(y_buf_size, y_stride, \
> >> +                    y_buf_height) \
> >> +    (y_buf_size = HFI_ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096))
> >> +
> >> +#define HFI_YUV420_TP10_UBWC_CALC_UV_BUF_SIZE(uv_buf_size, uv_stride, \
> >> +                    uv_buf_height) \
> >> +    (uv_buf_size = HFI_ALIGN(uv_stride * uv_buf_height,
> >> HFI_ALIGNMENT_4096))
> >> +
> >> +#define HFI_YUV420_TP10_UBWC_CALC_BUF_SIZE(buf_size, y_stride,
> >> y_buf_height, \
> >> +    uv_stride, uv_buf_height, y_md_stride, y_md_height, uv_md_stride, \
> >> +    uv_md_height)\
> >> +    do { \
> >> +        HFI_U32 y_data_size, uv_data_size, y_md_size, uv_md_size; \
> >> +        HFI_YUV420_TP10_UBWC_CALC_Y_BUF_SIZE(y_data_size, y_stride,\
> >> +                        y_buf_height); \
> >> +        HFI_YUV420_TP10_UBWC_CALC_UV_BUF_SIZE(uv_data_size, uv_stride, \
> >> +                        uv_buf_height); \
> >> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(y_md_size, y_md_stride, \
> >> +                        y_md_height); \
> >> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(uv_md_size, uv_md_stride, \
> >> +                        uv_md_height); \
> >> +        buf_size = y_data_size + uv_data_size + y_md_size + \
> >> +                        uv_md_size; \
> >> +    } while (0)
> >> +
> >> +#define HFI_YUV420_P010_CALC_Y_STRIDE(stride, frame_width,
> >> stride_multiple) \
> >> +    (stride = HFI_ALIGN(frame_width * 2, stride_multiple))
> >> +
> >> +#define HFI_YUV420_P010_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
> >> +                min_buf_height_multiple) \
> >> +    (buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
> >> +
> >> +#define HFI_YUV420_P010_CALC_UV_STRIDE(stride, frame_width,
> >> stride_multiple) \
> >> +    (stride = HFI_ALIGN(frame_width * 2, stride_multiple))
> >> +
> >> +#define HFI_YUV420_P010_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
> >> +                min_buf_height_multiple) \
> >> +    (buf_height = HFI_ALIGN(((frame_height + 1) >> 1), \
> >> +            min_buf_height_multiple))
> >> +
> >> +#define HFI_YUV420_P010_CALC_BUF_SIZE(buf_size, y_data_size, y_stride, \
> >> +    y_buf_height, uv_data_size, uv_stride, uv_buf_height) \
> >> +    do { \
> >> +        y_data_size = HFI_ALIGN(y_stride * y_buf_height, \
> >> +                HFI_ALIGNMENT_4096);\
> >> +        uv_data_size = HFI_ALIGN(uv_stride * uv_buf_height, \
> >> +                HFI_ALIGNMENT_4096); \
> >> +        buf_size = y_data_size + uv_data_size; \
> >> +    } while (0)
> >> +
> >> +#define HFI_RGB888_CALC_STRIDE(stride, frame_width, stride_multiple) \
> >> +    (stride = ((frame_width * 3) + stride_multiple - 1) & \
> >> +             (0xffffffff - (stride_multiple - 1)))
> >> +
> >> +#define HFI_RGB888_CALC_BUFHEIGHT(buf_height, frame_height, \
> >> +            min_buf_height_multiple) \
> >> +    (buf_height = ((frame_height + min_buf_height_multiple - 1) & \
> >> +            (0xffffffff - (min_buf_height_multiple - 1))))
> >> +
> >> +#define HFI_RGB888_CALC_BUF_SIZE(buf_size, stride, buf_height) \
> >> +    (buf_size = ((stride) * (buf_height)))
> >> +
> >> +#define HFI_RGBA8888_CALC_STRIDE(stride, frame_width, stride_multiple) \
> >> +    (stride = HFI_ALIGN((frame_width << 2), stride_multiple))
> >> +
> >> +#define HFI_RGBA8888_CALC_BUFHEIGHT(buf_height, frame_height, \
> >> +            min_buf_height_multiple) \
> >> +    (buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
> >> +
> >> +#define HFI_RGBA8888_CALC_BUF_SIZE(buf_size, stride, buf_height) \
> >> +    (buf_size = (stride) * (buf_height))
> >> +
> >> +#define HFI_RGBA8888_UBWC_CALC_DATA_PLANE_BUF_SIZE(buf_size, stride, \
> >> +                buf_height) \
> >> +    (buf_size = HFI_ALIGN((stride) * (buf_height), HFI_ALIGNMENT_4096))
> >> +
> >> +#define HFI_RGBA8888_UBWC_BUF_SIZE(buf_size, data_buf_size, \
> >> +    metadata_buffer_size, stride, buf_height, _metadata_tride, \
> >> +    _metadata_buf_height) \
> >> +    do { \
> >> +        HFI_RGBA8888_UBWC_CALC_DATA_PLANE_BUF_SIZE(data_buf_size, \
> >> +                stride, buf_height); \
> >> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(metadata_buffer_size, \
> >> +                _metadata_tride, _metadata_buf_height); \
> >> +        buf_size = data_buf_size + metadata_buffer_size \
> >> +    } while (0)
> >> +
> >> +#define HFI_UBWC_CALC_METADATA_PLANE_STRIDE(metadata_stride, frame_width,\
> >> +    metadata_stride_multiple, tile_width_in_pels) \
> >> +    ((metadata_stride = HFI_ALIGN(((frame_width + (tile_width_in_pels -
> >> 1)) /\
> >> +    tile_width_in_pels), metadata_stride_multiple)))
> >> +
> >> +#define HFI_UBWC_METADATA_PLANE_BUFHEIGHT(metadata_buf_height,
> >> frame_height, \
> >> +    metadata_height_multiple, tile_height_in_pels) \
> >> +    ((metadata_buf_height = HFI_ALIGN(((frame_height + \
> >> +    (tile_height_in_pels - 1)) / tile_height_in_pels), \
> >> +    metadata_height_multiple)))
> >> +
> >> +#define HFI_UBWC_UV_METADATA_PLANE_STRIDE(metadata_stride, frame_width, \
> >> +    metadata_stride_multiple, tile_width_in_pels) \
> >> +    ((metadata_stride = HFI_ALIGN(((((frame_width + 1) >> 1) +\
> >> +    (tile_width_in_pels - 1)) / tile_width_in_pels), \
> >> +    metadata_stride_multiple)))
> >> +
> >> +#define HFI_UBWC_UV_METADATA_PLANE_BUFHEIGHT(metadata_buf_height,
> >> frame_height,\
> >> +    metadata_height_multiple, tile_height_in_pels) \
> >> +    (metadata_buf_height = HFI_ALIGN(((((frame_height + 1) >> 1) + \
> >> +    (tile_height_in_pels - 1)) / tile_height_in_pels), \
> >> +    metadata_height_multiple))
> >> +
> >> +#define HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(buffer_size, _metadata_tride, \
> >> +                    _metadata_buf_height) \
> >> +    ((buffer_size = HFI_ALIGN(_metadata_tride * _metadata_buf_height, \
> >> +                    HFI_ALIGNMENT_4096)))
> >> +
> >> +#define BUFFER_ALIGNMENT_512_BYTES 512
> >> +#define BUFFER_ALIGNMENT_256_BYTES 256
> >> +#define BUFFER_ALIGNMENT_128_BYTES 128
> >> +#define BUFFER_ALIGNMENT_64_BYTES 64
> >> +#define BUFFER_ALIGNMENT_32_BYTES 32
> >> +#define BUFFER_ALIGNMENT_16_BYTES 16
> >> +#define BUFFER_ALIGNMENT_8_BYTES 8
> >> +#define BUFFER_ALIGNMENT_4_BYTES 4
> >
> > -ETOOMUCH.
> >
> > [skipped the rest, internal reviewer exception]
> >



-- 
With best wishes
Dmitry
