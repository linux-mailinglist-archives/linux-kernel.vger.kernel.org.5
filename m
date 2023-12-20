Return-Path: <linux-kernel+bounces-6550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB7819A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257AF1C214BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D81947F;
	Wed, 20 Dec 2023 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReySEGqb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241718E02
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e266e8d39eso44602997b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703060134; x=1703664934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ie0ioyzK5F91XlGUko+hrz9iXTr61vqqdsluw24vdng=;
        b=ReySEGqbjJ4nR/ihCqFkyGkU2/rMABa8ZrLAb533w8hSL4Ja5YSiPMN2X6AkUXfigF
         +u/1l2Lh3znK3cG+o+6twaphBlLbswrXCil8+/oC402WLbItpfDJuQewvyQRnDObyt7Q
         FIrzjnjloikCDQVsOJqFCfvfFem8UzDS6zWvk8lzahPZWXTlrGVz6H7zBHHJeWgF/31d
         G/eM7YLtChL7aLb9knVFJqG6hqdmgrzmIhPYz3/KDWgzu1lp9EeKG0ElRbul2h7LhnoR
         ofsfqdDo5oA7krFfXU3U8AVeGnP3SQGMC8aPBrK7yMYPZQY9jGwP9n23C/GX8QNjbiDG
         bYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060134; x=1703664934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ie0ioyzK5F91XlGUko+hrz9iXTr61vqqdsluw24vdng=;
        b=OrAJpQO0T9fPsfZ3qdeLItmMq+Z3M+wcERVaqKRRScKY6vT3TH+0d0sS6klcwT5cbZ
         NRkR5FIhhOr1THKkfwd0l5wDaluJbLoIqvkigoVDA8ZBI0mFhRHo3YIyPm+abZg2vqXZ
         ng+EiMWnmJBqNeTIcGOiJz76CwtTpuzmoTc8RqUxDYaSNMHO4K881vPKFoL/AOe48tzg
         fw2oBTbe676IssJma8AZi8Yusd9FTn/JDuwBdu502XL9v5lCbw/E8yS0TazDPmR61D5y
         +X25IIDfwx0EMPPjd8IfNc7nt4MI6VkP4sEbiV7VumBhyofSW1SDVpJqtgshGdntfsn9
         ychg==
X-Gm-Message-State: AOJu0YybzqBFxz6voIpU25zl4050g5X4yzKZA/ET9hj+LBVB4KcZ4Jzg
	jMLfB/MYZoAIhdFQfgqwUEU8RFZpI9uZpdjgM0DC4A==
X-Google-Smtp-Source: AGHT+IFMbUwUZlBYvXtm1m5bRGAQoKJhDM67O4n+wySvheIz9S1mmVaml3pbGFSa/0cZQUpNV+JDx3f+LQX3mO1syjQ=
X-Received: by 2002:a0d:d894:0:b0:5e8:9141:337d with SMTP id
 a142-20020a0dd894000000b005e89141337dmr287742ywe.98.1703060133603; Wed, 20
 Dec 2023 00:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-4-git-send-email-quic_dikshita@quicinc.com>
 <92fb416b-89f2-4fb6-81a9-0f8d7f654c89@linaro.org> <4da541df-345d-d777-e50b-811f9bd529dd@quicinc.com>
In-Reply-To: <4da541df-345d-d777-e50b-811f9bd529dd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 10:15:22 +0200
Message-ID: <CAA8EJpp7CjBuyWmgZGApihMBWvsfh_1yJdGTzjKidR3u=iQeJw@mail.gmail.com>
Subject: Re: [PATCH v2 03/34] media: introduce common helpers for buffer size calculation
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org, 
	bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org, 
	quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 10:04, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
>
>
> On 12/19/2023 12:02 AM, Dmitry Baryshkov wrote:
> > On 18/12/2023 13:31, Dikshita Agarwal wrote:
> >> Introduce helper to calculate size of pixel buffer and
> >> use in venus driver.
> >>
> >> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >> ---
> >>   drivers/media/platform/qcom/vcodec/buffers.c       | 103 ++++++++++++
> >>   drivers/media/platform/qcom/vcodec/buffers.h       |  15 ++
> >>   drivers/media/platform/qcom/vcodec/venus/Makefile  |   4 +-
> >>   drivers/media/platform/qcom/vcodec/venus/helpers.c | 172
> >> ++++-----------------
> >>   drivers/media/platform/qcom/vcodec/venus/helpers.h |   2 +-
> >>   .../platform/qcom/vcodec/venus/hfi_plat_bufs.h     |   4 +-
> >>   .../platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c  |  10 +-
> >>   drivers/media/platform/qcom/vcodec/venus/vdec.c    |   5 +-
> >>   8 files changed, 157 insertions(+), 158 deletions(-)
> >>   create mode 100644 drivers/media/platform/qcom/vcodec/buffers.c
> >>   create mode 100644 drivers/media/platform/qcom/vcodec/buffers.h
> >>
> >> diff --git a/drivers/media/platform/qcom/vcodec/buffers.c
> >> b/drivers/media/platform/qcom/vcodec/buffers.c
> >> new file mode 100644
> >> index 0000000..58ab3b0
> >> --- /dev/null
> >> +++ b/drivers/media/platform/qcom/vcodec/buffers.c
> >> @@ -0,0 +1,103 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
> >> reserved.
> >> + */
> >> +#include <linux/videodev2.h>
> >> +
> >> +#include "buffers.h"
> >> +
> >> +u32 video_raw_buffer_size(u32 colorformat,
> >
> > Usual drill, non-prefixed name.
> Will fix in next version.
> >
> >> +              u32 pix_width,
> >> +              u32 pix_height)
> >
> > My gut tells me that this is misaligned.
> >
> >> +{
> >> +    u32 size = 0;
> >> +    u32 y_plane, uv_plane, y_stride,
> >> +    uv_stride, y_sclines, uv_sclines;
> >> +    u32 y_ubwc_plane = 0, uv_ubwc_plane = 0;
> >> +    u32 y_meta_stride = 0, y_meta_scanlines = 0;
> >> +    u32 uv_meta_stride = 0, uv_meta_scanlines = 0;
> >> +    u32 y_meta_plane = 0, uv_meta_plane = 0;
> >> +
> >> +    if (!pix_width || !pix_height)
> >> +        goto invalid_input;
> >> +
> >> +    switch (colorformat) {
> >> +    case V4L2_PIX_FMT_NV12:
> >> +    case V4L2_PIX_FMT_NV21:
> >> +        y_stride = ALIGN(pix_width, 128);
> >> +        uv_stride = ALIGN(pix_width, 128);
> >> +        y_sclines = ALIGN(pix_height, 32);
> >> +        uv_sclines = ALIGN((pix_height + 1) >> 1, 16);
> >> +        y_plane = y_stride * y_sclines;
> >> +        uv_plane = uv_stride * uv_sclines;
> >> +        size = y_plane + uv_plane;
> >> +        break;
> >> +    case V4L2_PIX_FMT_QC08C:
> >> +        y_stride = ALIGN(pix_width, 128);
> >> +        uv_stride = ALIGN(pix_width, 128);
> >> +        y_sclines = ALIGN(pix_height, 32);
> >> +        uv_sclines = ALIGN((pix_height + 1) >> 1, 32);
> >> +        y_meta_stride = ALIGN(DIV_ROUND_UP(pix_width, 32), 64);
> >> +        uv_meta_stride = ALIGN(DIV_ROUND_UP((pix_width + 1) >> 1, 16), 64);
> >> +        y_ubwc_plane =
> >> +            ALIGN(y_stride * y_sclines, 4096);
> >> +        uv_ubwc_plane =
> >> +            ALIGN(uv_stride * uv_sclines, 4096);
> >> +        y_meta_scanlines =
> >> +            ALIGN(DIV_ROUND_UP(pix_height, 8), 16);
> >> +        y_meta_plane =
> >> +            ALIGN(y_meta_stride * y_meta_scanlines, 4096);
> >> +        uv_meta_scanlines =
> >> +            ALIGN(DIV_ROUND_UP((pix_height + 1) >> 1, 8), 16);
> >> +        uv_meta_plane =
> >> +            ALIGN(uv_meta_stride * uv_meta_scanlines, 4096);
> >> +        size = (y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
> >> +            uv_meta_plane);
> >> +        break;
> >> +    case V4L2_PIX_FMT_QC10C:
> >> +        y_stride =
> >> +            ALIGN(ALIGN(pix_width, 192) * 4 / 3, 256);
> >> +        uv_stride =
> >> +            ALIGN(ALIGN(pix_width, 192) * 4 / 3, 256);
> >> +        y_sclines =
> >> +            ALIGN(pix_height, 16);
> >> +        uv_sclines =
> >> +            ALIGN((pix_height + 1) >> 1, 16);
> >> +        y_ubwc_plane =
> >> +            ALIGN(y_stride * y_sclines, 4096);
> >> +        uv_ubwc_plane =
> >> +            ALIGN(uv_stride * uv_sclines, 4096);
> >> +        y_meta_stride =
> >> +            ALIGN(DIV_ROUND_UP(pix_width, 48), 64);
> >> +        y_meta_scanlines =
> >> +            ALIGN(DIV_ROUND_UP(pix_height, 4), 16);
> >> +        y_meta_plane =
> >> +            ALIGN(y_meta_stride * y_meta_scanlines, 4096);
> >> +        uv_meta_stride =
> >> +            ALIGN(DIV_ROUND_UP((pix_width + 1) >> 1, 24), 64);
> >> +        uv_meta_scanlines =
> >> +            ALIGN(DIV_ROUND_UP((pix_height + 1) >> 1, 4), 16);
> >> +        uv_meta_plane =
> >> +            ALIGN(uv_meta_stride * uv_meta_scanlines, 4096);
> >> +
> >> +        size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
> >> +            uv_meta_plane;
> >> +        break;
> >> +    case V4L2_PIX_FMT_P010:
> >> +        y_stride = ALIGN(pix_width * 2, 128);
> >> +        uv_stride = ALIGN(pix_width * 2, 128);
> >> +        y_sclines = ALIGN(pix_height, 32);
> >> +        uv_sclines = ALIGN((pix_height + 1) >> 1, 16);
> >> +        y_plane = y_stride * y_sclines;
> >> +        uv_plane = uv_stride * uv_sclines;
> >> +
> >> +        size = y_plane + uv_plane;
> >> +        break;
> >> +    default:
> >> +        break;
> >> +    }
> >> +
> >> +invalid_input:
> >> +
> >> +    return ALIGN(size, 4096);
> >> +}
> >> diff --git a/drivers/media/platform/qcom/vcodec/buffers.h
> >> b/drivers/media/platform/qcom/vcodec/buffers.h
> >> new file mode 100644
> >> index 0000000..ac1d052
> >> --- /dev/null
> >> +++ b/drivers/media/platform/qcom/vcodec/buffers.h
> >> @@ -0,0 +1,15 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
> >> reserved.
> >> + */
> >> +
> >> +#ifndef _BUFFERS_H_
> >> +#define _BUFFERS_H_
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +u32 video_raw_buffer_size(u32 colorformat,
> >> +              u32 pix_width,
> >> +              u32 pix_height);
> >> +
> >> +#endif
> >> diff --git a/drivers/media/platform/qcom/vcodec/venus/Makefile
> >> b/drivers/media/platform/qcom/vcodec/venus/Makefile
> >> index 1941ef4..6abd54a 100644
> >> --- a/drivers/media/platform/qcom/vcodec/venus/Makefile
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/Makefile
> >> @@ -1,8 +1,7 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>   # Makefile for Qualcomm Venus driver
> >>   -venus-core-objs += ../firmware.o \
> >> -           ../hfi_queue.o
> >> +venus-core-objs += ../firmware.o ../hfi_queue.o ../buffers.o
> >
> > Ugh. I missed that in the previous patches. This is not how the helpers are
> > done. Add normal kernel module instead.
> >
> I unnderstand this looks little messy, I can try to move the makefile one
> level up (in new vcodec folder), compile the common object by default and
> compile venus or iris based on config.
> Please let me know what do you think of this apporach.

I think that you want a venus-common or qcom-vcodec-common kernel
module instead. It will have a clean API and clean interfaces.

But, what we really want is to have iris as a subdir and subdriver inside venus.

>
> >>     venus-core-objs += core.o helpers.o firmware_no_tz.o \
> >>              hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
> >> @@ -10,6 +9,7 @@ venus-core-objs += core.o helpers.o firmware_no_tz.o \
> >>              hfi_platform.o hfi_platform_v4.o \
> >>              hfi_platform_v6.o hfi_plat_bufs_v6.o \
> >>   +venus-dec-objs += ../buffers.o
> >
> > I really wonder, why doesn't this end up with 'symbol defined multiple
> > times' error.
> >
> >>   venus-dec-objs += vdec.o vdec_ctrls.o
> >>   venus-enc-objs += venc.o venc_ctrls.o
> >>   diff --git a/drivers/media/platform/qcom/vcodec/venus/helpers.c
> >> b/drivers/media/platform/qcom/vcodec/venus/helpers.c
> >> index 8295542..95e4424 100644
> >> --- a/drivers/media/platform/qcom/vcodec/venus/helpers.c
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/helpers.c
> >> @@ -12,6 +12,7 @@
> >>   #include <media/v4l2-mem2mem.h>
> >>   #include <asm/div64.h>
> >>   +#include "../buffers.h"
> >>   #include "core.h"
> >>   #include "helpers.h"
> >>   #include "hfi_helper.h"
> >> @@ -616,6 +617,27 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
> >>       return 0;
> >>   }
> >>   +u32 to_v4l2_raw_fmt(u32 hfi_color_fmt)
> >> +{
> >> +    switch (hfi_color_fmt) {
> >> +    case HFI_COLOR_FORMAT_NV12:
> >> +        return V4L2_PIX_FMT_NV12;
> >> +    case HFI_COLOR_FORMAT_NV21:
> >> +        return V4L2_PIX_FMT_NV21;
> >> +    case HFI_COLOR_FORMAT_NV12_UBWC:
> >> +        return V4L2_PIX_FMT_QC08C;
> >> +    case HFI_COLOR_FORMAT_YUV420_TP10_UBWC:
> >> +        return V4L2_PIX_FMT_QC10C;
> >> +    case HFI_COLOR_FORMAT_P010:
> >> +        return V4L2_PIX_FMT_P010;
> >> +    default:
> >> +        break;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(to_v4l2_raw_fmt);
> >> +
> >>   static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
> >>                      struct hfi_buffer_requirements *req)
> >>   {
> >> @@ -639,20 +661,20 @@ static int platform_get_bufreq(struct venus_inst
> >> *inst, u32 buftype,
> >>           params.out_width = inst->out_width;
> >>           params.out_height = inst->out_height;
> >>           params.codec = inst->fmt_out->pixfmt;
> >> -        params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
> >> +        params.color_fmt = inst->fmt_cap->pixfmt;
> >>           params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
> >>           params.dec.buffer_size_limit = 0;
> >>           params.dec.is_secondary_output =
> >>               inst->opb_buftype == HFI_BUFFER_OUTPUT2;
> >>           if (params.dec.is_secondary_output)
> >> -            params.hfi_dpb_color_fmt = inst->dpb_fmt;
> >> +            params.dpb_color_fmt = to_v4l2_raw_fmt(inst->dpb_fmt);
> >>           params.dec.is_interlaced =
> >>               inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
> >>       } else {
> >>           params.width = inst->out_width;
> >>           params.height = inst->out_height;
> >>           params.codec = inst->fmt_cap->pixfmt;
> >> -        params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_out->pixfmt);
> >> +        params.color_fmt = inst->fmt_out->pixfmt;
> >>           params.enc.work_mode = VIDC_WORK_MODE_2;
> >>           params.enc.rc_type = HFI_RATE_CONTROL_OFF;
> >>           if (enc_ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)
> >> @@ -942,146 +964,10 @@ int venus_helper_set_profile_level(struct
> >> venus_inst *inst, u32 profile, u32 lev
> >>   }
> >>   EXPORT_SYMBOL_GPL(venus_helper_set_profile_level);
> >>   -static u32 get_framesize_raw_nv12(u32 width, u32 height)
> >> -{
> >> -    u32 y_stride, uv_stride, y_plane;
> >> -    u32 y_sclines, uv_sclines, uv_plane;
> >> -    u32 size;
> >> -
> >> -    y_stride = ALIGN(width, 128);
> >> -    uv_stride = ALIGN(width, 128);
> >> -    y_sclines = ALIGN(height, 32);
> >> -    uv_sclines = ALIGN(((height + 1) >> 1), 16);
> >> -
> >> -    y_plane = y_stride * y_sclines;
> >> -    uv_plane = uv_stride * uv_sclines + SZ_4K;
> >> -    size = y_plane + uv_plane + SZ_8K;
> >> -
> >> -    return ALIGN(size, SZ_4K);
> >> -}
> >> -
> >> -static u32 get_framesize_raw_nv12_ubwc(u32 width, u32 height)
> >> -{
> >> -    u32 y_meta_stride, y_meta_plane;
> >> -    u32 y_stride, y_plane;
> >> -    u32 uv_meta_stride, uv_meta_plane;
> >> -    u32 uv_stride, uv_plane;
> >> -    u32 extradata = SZ_16K;
> >> -
> >> -    y_meta_stride = ALIGN(DIV_ROUND_UP(width, 32), 64);
> >> -    y_meta_plane = y_meta_stride * ALIGN(DIV_ROUND_UP(height, 8), 16);
> >> -    y_meta_plane = ALIGN(y_meta_plane, SZ_4K);
> >> -
> >> -    y_stride = ALIGN(width, 128);
> >> -    y_plane = ALIGN(y_stride * ALIGN(height, 32), SZ_4K);
> >> -
> >> -    uv_meta_stride = ALIGN(DIV_ROUND_UP(width / 2, 16), 64);
> >> -    uv_meta_plane = uv_meta_stride * ALIGN(DIV_ROUND_UP(height / 2, 8),
> >> 16);
> >> -    uv_meta_plane = ALIGN(uv_meta_plane, SZ_4K);
> >> -
> >> -    uv_stride = ALIGN(width, 128);
> >> -    uv_plane = ALIGN(uv_stride * ALIGN(height / 2, 32), SZ_4K);
> >> -
> >> -    return ALIGN(y_meta_plane + y_plane + uv_meta_plane + uv_plane +
> >> -             max(extradata, y_stride * 48), SZ_4K);
> >> -}
> >> -
> >> -static u32 get_framesize_raw_p010(u32 width, u32 height)
> >> -{
> >> -    u32 y_plane, uv_plane, y_stride, uv_stride, y_sclines, uv_sclines;
> >> -
> >> -    y_stride = ALIGN(width * 2, 128);
> >> -    uv_stride = ALIGN(width * 2, 128);
> >> -    y_sclines = ALIGN(height, 32);
> >> -    uv_sclines = ALIGN((height + 1) >> 1, 16);
> >> -    y_plane = y_stride * y_sclines;
> >> -    uv_plane = uv_stride * uv_sclines;
> >> -
> >> -    return ALIGN((y_plane + uv_plane), SZ_4K);
> >> -}
> >> -
> >> -static u32 get_framesize_raw_p010_ubwc(u32 width, u32 height)
> >> -{
> >> -    u32 y_stride, uv_stride, y_sclines, uv_sclines;
> >> -    u32 y_ubwc_plane, uv_ubwc_plane;
> >> -    u32 y_meta_stride, y_meta_scanlines;
> >> -    u32 uv_meta_stride, uv_meta_scanlines;
> >> -    u32 y_meta_plane, uv_meta_plane;
> >> -    u32 size;
> >> -
> >> -    y_stride = ALIGN(width * 2, 256);
> >> -    uv_stride = ALIGN(width * 2, 256);
> >> -    y_sclines = ALIGN(height, 16);
> >> -    uv_sclines = ALIGN((height + 1) >> 1, 16);
> >> -
> >> -    y_ubwc_plane = ALIGN(y_stride * y_sclines, SZ_4K);
> >> -    uv_ubwc_plane = ALIGN(uv_stride * uv_sclines, SZ_4K);
> >> -    y_meta_stride = ALIGN(DIV_ROUND_UP(width, 32), 64);
> >> -    y_meta_scanlines = ALIGN(DIV_ROUND_UP(height, 4), 16);
> >> -    y_meta_plane = ALIGN(y_meta_stride * y_meta_scanlines, SZ_4K);
> >> -    uv_meta_stride = ALIGN(DIV_ROUND_UP((width + 1) >> 1, 16), 64);
> >> -    uv_meta_scanlines = ALIGN(DIV_ROUND_UP((height + 1) >> 1, 4), 16);
> >> -    uv_meta_plane = ALIGN(uv_meta_stride * uv_meta_scanlines, SZ_4K);
> >> -
> >> -    size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane + uv_meta_plane;
> >> -
> >> -    return ALIGN(size, SZ_4K);
> >> -}
> >> -
> >> -static u32 get_framesize_raw_yuv420_tp10_ubwc(u32 width, u32 height)
> >> -{
> >> -    u32 y_stride, uv_stride, y_sclines, uv_sclines;
> >> -    u32 y_ubwc_plane, uv_ubwc_plane;
> >> -    u32 y_meta_stride, y_meta_scanlines;
> >> -    u32 uv_meta_stride, uv_meta_scanlines;
> >> -    u32 y_meta_plane, uv_meta_plane;
> >> -    u32 extradata = SZ_16K;
> >> -    u32 size;
> >> -
> >> -    y_stride = ALIGN(width * 4 / 3, 256);
> >> -    uv_stride = ALIGN(width * 4 / 3, 256);
> >> -    y_sclines = ALIGN(height, 16);
> >> -    uv_sclines = ALIGN((height + 1) >> 1, 16);
> >> -
> >> -    y_ubwc_plane = ALIGN(y_stride * y_sclines, SZ_4K);
> >> -    uv_ubwc_plane = ALIGN(uv_stride * uv_sclines, SZ_4K);
> >> -    y_meta_stride = ALIGN(DIV_ROUND_UP(width, 48), 64);
> >> -    y_meta_scanlines = ALIGN(DIV_ROUND_UP(height, 4), 16);
> >> -    y_meta_plane = ALIGN(y_meta_stride * y_meta_scanlines, SZ_4K);
> >> -    uv_meta_stride = ALIGN(DIV_ROUND_UP((width + 1) >> 1, 24), 64);
> >> -    uv_meta_scanlines = ALIGN(DIV_ROUND_UP((height + 1) >> 1, 4), 16);
> >> -    uv_meta_plane = ALIGN(uv_meta_stride * uv_meta_scanlines, SZ_4K);
> >> -
> >> -    size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane + uv_meta_plane;
> >> -    size += max(extradata + SZ_8K, y_stride * 48);
> >> -
> >> -    return ALIGN(size, SZ_4K);
> >> -}
> >> -
> >> -u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height)
> >> -{
> >> -    switch (hfi_fmt) {
> >> -    case HFI_COLOR_FORMAT_NV12:
> >> -    case HFI_COLOR_FORMAT_NV21:
> >> -        return get_framesize_raw_nv12(width, height);
> >> -    case HFI_COLOR_FORMAT_NV12_UBWC:
> >> -        return get_framesize_raw_nv12_ubwc(width, height);
> >> -    case HFI_COLOR_FORMAT_P010:
> >> -        return get_framesize_raw_p010(width, height);
> >> -    case HFI_COLOR_FORMAT_P010_UBWC:
> >> -        return get_framesize_raw_p010_ubwc(width, height);
> >> -    case HFI_COLOR_FORMAT_YUV420_TP10_UBWC:
> >> -        return get_framesize_raw_yuv420_tp10_ubwc(width, height);
> >> -    default:
> >> -        return 0;
> >> -    }
> >> -}
> >> -EXPORT_SYMBOL_GPL(venus_helper_get_framesz_raw);
> >> -
> >>   u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
> >>   {
> >> -    u32 hfi_fmt, sz;
> >>       bool compressed;
> >> +    u32 sz;
> >>         switch (v4l2_fmt) {
> >>       case V4L2_PIX_FMT_MPEG:
> >> @@ -1112,11 +998,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32
> >> width, u32 height)
> >>           return ALIGN(sz, SZ_4K);
> >>       }
> >>   -    hfi_fmt = to_hfi_raw_fmt(v4l2_fmt);
> >> -    if (!hfi_fmt)
> >> -        return 0;
> >> -
> >> -    return venus_helper_get_framesz_raw(hfi_fmt, width, height);
> >> +    return video_raw_buffer_size(v4l2_fmt, width, height);
> >>   }
> >>   EXPORT_SYMBOL_GPL(venus_helper_get_framesz);
> >>   diff --git a/drivers/media/platform/qcom/vcodec/venus/helpers.h
> >> b/drivers/media/platform/qcom/vcodec/venus/helpers.h
> >> index 358e4f3..9b72d18 100644
> >> --- a/drivers/media/platform/qcom/vcodec/venus/helpers.h
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/helpers.h
> >> @@ -11,6 +11,7 @@
> >>   struct venus_inst;
> >>   struct venus_core;
> >>   +u32 to_v4l2_raw_fmt(u32 hfi_color_fmt);
> >>   bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt);
> >>   struct vb2_v4l2_buffer *venus_helper_find_buf(struct venus_inst *inst,
> >>                             unsigned int type, u32 idx);
> >> @@ -29,7 +30,6 @@ void venus_helper_m2m_device_run(void *priv);
> >>   void venus_helper_m2m_job_abort(void *priv);
> >>   int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
> >>                   struct hfi_buffer_requirements *req);
> >> -u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height);
> >>   u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height);
> >>   int venus_helper_set_input_resolution(struct venus_inst *inst,
> >>                         unsigned int width, unsigned int height);
> >> diff --git a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
> >> b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
> >> index 25e6074..20f684e 100644
> >> --- a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
> >> @@ -15,8 +15,8 @@ struct hfi_plat_buffers_params {
> >>       u32 out_width;
> >>       u32 out_height;
> >>       u32 codec;
> >> -    u32 hfi_color_fmt;
> >> -    u32 hfi_dpb_color_fmt;
> >> +    u32 color_fmt;
> >> +    u32 dpb_color_fmt;
> >
> > As usual. This is not a helper introduction. This is field rename. Could
> > you please split that.
> >
> >>       enum hfi_version version;
> >>       u32 num_vpp_pipes;
> >>       union {
> >> diff --git a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
> >> b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
> >> index f5a6559..3e06516 100644
> >> --- a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
> >> @@ -6,6 +6,7 @@
> >>   #include <linux/sizes.h>
> >>   #include <linux/videodev2.h>
> >>   +#include "../buffers.h"
> >>   #include "hfi.h"
> >>   #include "hfi_plat_bufs.h"
> >>   #include "helpers.h"
> >> @@ -1233,13 +1234,11 @@ static int bufreq_dec(struct
> >> hfi_plat_buffers_params *params, u32 buftype,
> >>                                  buffer_size_limit);
> >>       } else if (buftype == HFI_BUFFER_OUTPUT || buftype ==
> >> HFI_BUFFER_OUTPUT2) {
> >>           hfi_bufreq_set_count_min(bufreq, version, out_min_count);
> >> -        bufreq->size =
> >> -            venus_helper_get_framesz_raw(params->hfi_color_fmt,
> >> +        bufreq->size = video_raw_buffer_size(params->color_fmt,
> >>                                out_width, out_height);
> >>           if (buftype == HFI_BUFFER_OUTPUT &&
> >>               params->dec.is_secondary_output)
> >> -            bufreq->size =
> >> -                venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
> >> +            bufreq->size = video_raw_buffer_size(params->dpb_color_fmt,
> >>                                    out_width, out_height);
> >>       } else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
> >>           bufreq->size = dec_ops->scratch(width, height, is_interlaced);
> >> @@ -1297,8 +1296,7 @@ static int bufreq_enc(struct
> >> hfi_plat_buffers_params *params, u32 buftype,
> >>         if (buftype == HFI_BUFFER_INPUT) {
> >>           hfi_bufreq_set_count_min(bufreq, version, MIN_INPUT_BUFFERS);
> >> -        bufreq->size =
> >> -            venus_helper_get_framesz_raw(params->hfi_color_fmt,
> >> +        bufreq->size = video_raw_buffer_size(params->color_fmt,
> >>                                width, height);
> >>       } else if (buftype == HFI_BUFFER_OUTPUT ||
> >>              buftype == HFI_BUFFER_OUTPUT2) {
> >> diff --git a/drivers/media/platform/qcom/vcodec/venus/vdec.c
> >> b/drivers/media/platform/qcom/vcodec/venus/vdec.c
> >> index dbf305c..e6316be 100644
> >> --- a/drivers/media/platform/qcom/vcodec/venus/vdec.c
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/vdec.c
> >> @@ -15,6 +15,7 @@
> >>   #include <media/v4l2-mem2mem.h>
> >>   #include <media/videobuf2-dma-contig.h>
> >>   +#include "../buffers.h"
> >>   #include "hfi_venus_io.h"
> >>   #include "hfi_parser.h"
> >>   #include "core.h"
> >> @@ -777,9 +778,9 @@ static int vdec_output_conf(struct venus_inst *inst)
> >>           return ret;
> >>         inst->output_buf_size =
> >> -            venus_helper_get_framesz_raw(out_fmt, width, height);
> >> +            video_raw_buffer_size(to_v4l2_raw_fmt(out_fmt), width, height);
> >>       inst->output2_buf_size =
> >> -            venus_helper_get_framesz_raw(out2_fmt, width, height);
> >> +            video_raw_buffer_size(to_v4l2_raw_fmt(out2_fmt), width,
> >> height);
> >>         if (is_ubwc_fmt(out_fmt)) {
> >>           inst->opb_buftype = HFI_BUFFER_OUTPUT2;
> >



-- 
With best wishes
Dmitry

