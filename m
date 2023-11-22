Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA77F5176
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjKVUWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:22:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6E191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:21:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4594C433C8;
        Wed, 22 Nov 2023 20:21:55 +0000 (UTC)
Message-ID: <1a3a7de2-8ada-46cf-bdb7-fe622528bdc6@xs4all.nl>
Date:   Wed, 22 Nov 2023 21:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] visl: Add AV1 support
Content-Language: en-US, nl
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20231113154109.114488-1-detlev.casanova@collabora.com>
 <20231113154109.114488-2-detlev.casanova@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231113154109.114488-2-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 16:39, Detlev Casanova wrote:
> Let the visl test driver accept the AV1 pixel format.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

smatch reports this error:

drivers/media/test-drivers/visl/visl-dec.c:165 visl_get_ref_frames() error: buffer overflow 'run->av1.frame->ref_frame_idx' 7 <= 7

Regards,

	Hans

> ---
>  drivers/media/test-drivers/visl/visl-core.c   |  21 ++
>  drivers/media/test-drivers/visl/visl-dec.c    |  70 +++-
>  drivers/media/test-drivers/visl/visl-dec.h    |   8 +
>  .../media/test-drivers/visl/visl-trace-av1.h  | 314 ++++++++++++++++++
>  .../test-drivers/visl/visl-trace-points.c     |   1 +
>  drivers/media/test-drivers/visl/visl-video.c  |  18 +
>  drivers/media/test-drivers/visl/visl-video.h  |   1 +
>  drivers/media/test-drivers/visl/visl.h        |   1 +
>  8 files changed, 433 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/test-drivers/visl/visl-trace-av1.h
> 
> diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
> index 9970dc739ca5..68dac896277b 100644
> --- a/drivers/media/test-drivers/visl/visl-core.c
> +++ b/drivers/media/test-drivers/visl/visl-core.c
> @@ -211,6 +211,27 @@ const struct visl_ctrls visl_hevc_ctrls = {
>  	.num_ctrls = ARRAY_SIZE(visl_hevc_ctrl_descs),
>  };
>  
> +static const struct visl_ctrl_desc visl_av1_ctrl_descs[] = {
> +	{
> +		.cfg.id = V4L2_CID_STATELESS_AV1_FRAME,
> +	},
> +	{
> +		.cfg.id = V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY,
> +		.cfg.dims = { V4L2_AV1_MAX_TILE_COUNT },
> +	},
> +	{
> +		.cfg.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
> +	},
> +	{
> +		.cfg.id = V4L2_CID_STATELESS_AV1_FILM_GRAIN,
> +	},
> +};
> +
> +const struct visl_ctrls visl_av1_ctrls = {
> +	.ctrls = visl_av1_ctrl_descs,
> +	.num_ctrls = ARRAY_SIZE(visl_av1_ctrl_descs),
> +};
> +
>  struct v4l2_ctrl *visl_find_control(struct visl_ctx *ctx, u32 id)
>  {
>  	struct v4l2_ctrl_handler *hdl = &ctx->hdl;
> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
> index 318d675e5668..684feb6fde58 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.c
> +++ b/drivers/media/test-drivers/visl/visl-dec.c
> @@ -13,6 +13,7 @@
>  #include "visl-trace-vp9.h"
>  #include "visl-trace-h264.h"
>  #include "visl-trace-hevc.h"
> +#include "visl-trace-av1.h"
>  
>  #include <linux/delay.h>
>  #include <linux/workqueue.h>
> @@ -152,6 +153,61 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
>  
>  		break;
>  	}
> +
> +	case VISL_CODEC_AV1: {
> +		int idx_intra = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_INTRA_FRAME];
> +		int idx_last = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_LAST_FRAME];
> +		int idx_last2 = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_LAST2_FRAME];
> +		int idx_last3 = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_LAST3_FRAME];
> +		int idx_golden = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_GOLDEN_FRAME];
> +		int idx_bwd = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_BWDREF_FRAME];
> +		int idx_alt2 = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_ALTREF2_FRAME];
> +		int idx_alt = run->av1.frame->ref_frame_idx[V4L2_AV1_REF_ALTREF_FRAME];
> +
> +		struct vb2_buffer *ref_intra =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_intra]);
> +		struct vb2_buffer *ref_last =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last]);
> +		struct vb2_buffer *ref_last2 =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last2]);
> +		struct vb2_buffer *ref_last3 =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last3]);
> +		struct vb2_buffer *ref_golden =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_golden]);
> +		struct vb2_buffer *ref_bwd =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_bwd]);
> +		struct vb2_buffer *ref_alt2 =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_alt2]);
> +		struct vb2_buffer *ref_alt =
> +			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_alt]);
> +
> +		scnprintf(buf, buflen,
> +			  "ref_intra_ts: %llu, vb2_idx: %d\n"
> +			  "ref_last_ts: %llu, vb2_idx: %d\n"
> +			  "ref_last2_ts: %llu, vb2_idx: %d\n"
> +			  "ref_last3_ts: %llu, vb2_idx: %d\n"
> +			  "ref_golden_ts: %llu, vb2_idx: %d\n"
> +			  "ref_bwd_ts: %llu, vb2_idx: %d\n"
> +			  "ref_alt2_ts: %llu, vb2_idx: %d\n"
> +			  "ref_alt_ts: %llu, vb2_idx: %d\n",
> +			  run->av1.frame->reference_frame_ts[idx_intra],
> +			  ref_intra ? ref_intra->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_last],
> +			  ref_last ? ref_last->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_last2],
> +			  ref_last2 ? ref_last2->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_last3],
> +			  ref_last3 ? ref_last3->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_golden],
> +			  ref_golden ? ref_golden->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_bwd],
> +			  ref_bwd ? ref_bwd->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_alt2],
> +			  ref_alt2 ? ref_alt2->index : -1,
> +			  run->av1.frame->reference_frame_ts[idx_alt],
> +			  ref_alt ? ref_alt->index : -1);
> +		break;
> +	}
>  	}
>  }
>  
> @@ -410,7 +466,13 @@ static void visl_trace_ctrls(struct visl_ctx *ctx, struct visl_run *run)
>  			trace_v4l2_hevc_dpb_entry(&run->hevc.dpram->dpb[i]);
>  
>  		trace_v4l2_hevc_pred_weight_table(&run->hevc.spram->pred_weight_table);
> -	break;
> +		break;
> +	case VISL_CODEC_AV1:
> +		trace_v4l2_ctrl_av1_sequence(run->av1.seq);
> +		trace_v4l2_ctrl_av1_frame(run->av1.frame);
> +		trace_v4l2_ctrl_av1_film_grain(run->av1.grain);
> +		trace_v4l2_ctrl_av1_tile_group_entry(run->av1.tge);
> +		break;
>  	}
>  }
>  
> @@ -469,6 +531,12 @@ void visl_device_run(void *priv)
>  		run.hevc.sm = visl_find_control_data(ctx, V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
>  		run.hevc.dpram = visl_find_control_data(ctx, V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
>  		break;
> +	case VISL_CODEC_AV1:
> +		run.av1.seq = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_SEQUENCE);
> +		run.av1.frame = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_FRAME);
> +		run.av1.tge = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY);
> +		run.av1.grain = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_FILM_GRAIN);
> +		break;
>  	}
>  
>  	frame_dprintk(ctx->dev, run.dst->sequence,
> diff --git a/drivers/media/test-drivers/visl/visl-dec.h b/drivers/media/test-drivers/visl/visl-dec.h
> index 4a706a9de02e..c2c2ef3a8798 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.h
> +++ b/drivers/media/test-drivers/visl/visl-dec.h
> @@ -45,6 +45,13 @@ struct visl_hevc_run {
>  	const struct v4l2_ctrl_hevc_decode_params *dpram;
>  };
>  
> +struct visl_av1_run {
> +	const struct v4l2_ctrl_av1_sequence *seq;
> +	const struct v4l2_ctrl_av1_frame *frame;
> +	const struct v4l2_ctrl_av1_tile_group_entry *tge;
> +	const struct v4l2_ctrl_av1_film_grain *grain;
> +};
> +
>  struct visl_run {
>  	struct vb2_v4l2_buffer	*src;
>  	struct vb2_v4l2_buffer	*dst;
> @@ -56,6 +63,7 @@ struct visl_run {
>  		struct visl_vp9_run	vp9;
>  		struct visl_h264_run	h264;
>  		struct visl_hevc_run	hevc;
> +		struct visl_av1_run	av1;
>  	};
>  };
>  
> diff --git a/drivers/media/test-drivers/visl/visl-trace-av1.h b/drivers/media/test-drivers/visl/visl-trace-av1.h
> new file mode 100644
> index 000000000000..09f205de53df
> --- /dev/null
> +++ b/drivers/media/test-drivers/visl/visl-trace-av1.h
> @@ -0,0 +1,314 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if !defined(_VISL_TRACE_AV1_H_) || defined(TRACE_HEADER_MULTI_READ)
> +#define _VISL_TRACE_AV1_H_
> +
> +#include <linux/tracepoint.h>
> +#include "visl.h"
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM visl_av1_controls
> +
> +DECLARE_EVENT_CLASS(v4l2_ctrl_av1_seq_tmpl,
> +	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
> +	TP_ARGS(s),
> +	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_sequence, s)),
> +	TP_fast_assign(__entry->s = *s;),
> +	TP_printk("\nflags %s\nseq_profile: %u\norder_hint_bits: %u\nbit_depth: %u\n"
> +		  "max_frame_width_minus_1: %u\nmax_frame_height_minus_1: %u\n",
> +		  __print_flags(__entry->s.flags, "|",
> +		  {V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE, "STILL_PICTURE"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK, "USE_128X128_SUPERBLOCK"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA, "ENABLE_FILTER_INTRA"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER, "ENABLE_INTRA_EDGE_FILTER"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND, "ENABLE_INTERINTRA_COMPOUND"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND, "ENABLE_MASKED_COMPOUND"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION, "ENABLE_WARPED_MOTION"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER, "ENABLE_DUAL_FILTER"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT, "ENABLE_ORDER_HINT"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP, "ENABLE_JNT_COMP"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS, "ENABLE_REF_FRAME_MVS"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES, "ENABLE_SUPERRES"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF, "ENABLE_CDEF"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION, "ENABLE_RESTORATION"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME, "MONO_CHROME"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE, "COLOR_RANGE"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X, "SUBSAMPLING_X"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y, "SUBSAMPLING_Y"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT, "FILM_GRAIN_PARAMS_PRESENT"},
> +		  {V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q, "SEPARATE_UV_DELTA_Q"}),
> +		  __entry->s.seq_profile,
> +		  __entry->s.order_hint_bits,
> +		  __entry->s.bit_depth,
> +		  __entry->s.max_frame_width_minus_1,
> +		  __entry->s.max_frame_height_minus_1
> +	)
> +);
> +
> +DECLARE_EVENT_CLASS(v4l2_ctrl_av1_tge_tmpl,
> +	TP_PROTO(const struct v4l2_ctrl_av1_tile_group_entry *t),
> +	TP_ARGS(t),
> +	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_tile_group_entry, t)),
> +	TP_fast_assign(__entry->t = *t;),
> +	TP_printk("\ntile_offset: %u\n tile_size: %u\n tile_row: %u\ntile_col: %u\n",
> +		  __entry->t.tile_offset,
> +		  __entry->t.tile_size,
> +		  __entry->t.tile_row,
> +		  __entry->t.tile_col
> +	)
> +);
> +
> +DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
> +	TP_PROTO(const struct v4l2_ctrl_av1_frame *f),
> +	TP_ARGS(f),
> +	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_frame, f)),
> +	TP_fast_assign(__entry->f = *f;),
> +	TP_printk("\ntile_info.flags: %s\ntile_info.context_update_tile_id: %u\n"
> +		  "tile_info.tile_cols: %u\ntile_info.tile_rows: %u\n"
> +		  "tile_info.mi_col_starts: %s\ntile_info.mi_row_starts: %s\n"
> +		  "tile_info.width_in_sbs_minus_1: %s\ntile_info.height_in_sbs_minus_1: %s\n"
> +		  "tile_info.tile_size_bytes: %u\nquantization.flags: %s\n"
> +		  "quantization.base_q_idx: %u\nquantization.delta_q_y_dc: %d\n"
> +		  "quantization.delta_q_u_dc: %d\nquantization.delta_q_u_ac: %d\n"
> +		  "quantization.delta_q_v_dc: %d\nquantization.delta_q_v_ac: %d\n"
> +		  "quantization.qm_y: %u\nquantization.qm_u: %u\nquantization.qm_v: %u\n"
> +		  "quantization.delta_q_res: %u\nsuperres_denom: %u\nsegmentation.flags: %s\n"
> +		  "segmentation.last_active_seg_id: %u\nsegmentation.feature_enabled:%s\n"
> +		  "loop_filter.flags: %s\nloop_filter.level: %s\nloop_filter.sharpness: %u\n"
> +		  "loop_filter.ref_deltas: %s\nloop_filter.mode_deltas: %s\n"
> +		  "loop_filter.delta_lf_res: %u\ncdef.damping_minus_3: %u\ncdef.bits: %u\n"
> +		  "cdef.y_pri_strength: %s\ncdef.y_sec_strength: %s\n"
> +		  "cdef.uv_pri_strength: %s\ncdef.uv_sec_strength:%s\nskip_mode_frame: %s\n"
> +		  "primary_ref_frame: %u\nloop_restoration.flags: %s\n"
> +		  "loop_restoration.lr_unit_shift: %u\nloop_restoration.lr_uv_shift: %u\n"
> +		  "loop_restoration.frame_restoration_type: %s\n"
> +		  "loop_restoration.loop_restoration_size: %s\nflags: %s\norder_hint: %u\n"
> +		  "upscaled_width: %u\nframe_width_minus_1: %u\nframe_height_minus_1: %u\n"
> +		  "render_width_minus_1: %u\nrender_height_minus_1: %u\ncurrent_frame_id: %u\n"
> +		  "buffer_removal_time: %s\norder_hints: %s\nreference_frame_ts: %s\n"
> +		  "ref_frame_idx: %s\nrefresh_frame_flags: %u\n",
> +		  __print_flags(__entry->f.tile_info.flags, "|",
> +		  {V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING, "UNIFORM_TILE_SPACING"}),
> +		  __entry->f.tile_info.context_update_tile_id,
> +		  __entry->f.tile_info.tile_cols,
> +		  __entry->f.tile_info.tile_rows,
> +		  __print_array(__entry->f.tile_info.mi_col_starts,
> +				ARRAY_SIZE(__entry->f.tile_info.mi_col_starts),
> +				sizeof(__entry->f.tile_info.mi_col_starts[0])),
> +		  __print_array(__entry->f.tile_info.mi_row_starts,
> +				ARRAY_SIZE(__entry->f.tile_info.mi_row_starts),
> +				sizeof(__entry->f.tile_info.mi_row_starts[0])),
> +		  __print_array(__entry->f.tile_info.width_in_sbs_minus_1,
> +				ARRAY_SIZE(__entry->f.tile_info.width_in_sbs_minus_1),
> +				sizeof(__entry->f.tile_info.width_in_sbs_minus_1[0])),
> +		  __print_array(__entry->f.tile_info.height_in_sbs_minus_1,
> +				ARRAY_SIZE(__entry->f.tile_info.height_in_sbs_minus_1),
> +				sizeof(__entry->f.tile_info.height_in_sbs_minus_1[0])),
> +		  __entry->f.tile_info.tile_size_bytes,
> +		  __print_flags(__entry->f.quantization.flags, "|",
> +		  {V4L2_AV1_QUANTIZATION_FLAG_DIFF_UV_DELTA, "DIFF_UV_DELTA"},
> +		  {V4L2_AV1_QUANTIZATION_FLAG_USING_QMATRIX, "USING_QMATRIX"},
> +		  {V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT, "DELTA_Q_PRESENT"}),
> +		  __entry->f.quantization.base_q_idx,
> +		  __entry->f.quantization.delta_q_y_dc,
> +		  __entry->f.quantization.delta_q_u_dc,
> +		  __entry->f.quantization.delta_q_u_ac,
> +		  __entry->f.quantization.delta_q_v_dc,
> +		  __entry->f.quantization.delta_q_v_ac,
> +		  __entry->f.quantization.qm_y,
> +		  __entry->f.quantization.qm_u,
> +		  __entry->f.quantization.qm_v,
> +		  __entry->f.quantization.delta_q_res,
> +		  __entry->f.superres_denom,
> +		  __print_flags(__entry->f.segmentation.flags, "|",
> +		  {V4L2_AV1_SEGMENTATION_FLAG_ENABLED, "ENABLED"},
> +		  {V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP, "UPDATE_MAP"},
> +		  {V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE, "TEMPORAL_UPDATE"},
> +		  {V4L2_AV1_SEGMENTATION_FLAG_UPDATE_DATA, "UPDATE_DATA"},
> +		  {V4L2_AV1_SEGMENTATION_FLAG_SEG_ID_PRE_SKIP, "SEG_ID_PRE_SKIP"}),
> +		  __entry->f.segmentation.last_active_seg_id,
> +		  __print_array(__entry->f.segmentation.feature_enabled,
> +				ARRAY_SIZE(__entry->f.segmentation.feature_enabled),
> +				sizeof(__entry->f.segmentation.feature_enabled[0])),
> +		  __print_flags(__entry->f.loop_filter.flags, "|",
> +		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED, "DELTA_ENABLED"},
> +		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_UPDATE, "DELTA_UPDATE"},
> +		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT, "DELTA_LF_PRESENT"},
> +		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_MULTI, "DELTA_LF_MULTI"}),
> +		  __print_array(__entry->f.loop_filter.level,
> +				ARRAY_SIZE(__entry->f.loop_filter.level),
> +				sizeof(__entry->f.loop_filter.level[0])),
> +		  __entry->f.loop_filter.sharpness,
> +		  __print_array(__entry->f.loop_filter.ref_deltas,
> +				ARRAY_SIZE(__entry->f.loop_filter.ref_deltas),
> +				sizeof(__entry->f.loop_filter.ref_deltas[0])),
> +		  __print_array(__entry->f.loop_filter.mode_deltas,
> +				ARRAY_SIZE(__entry->f.loop_filter.mode_deltas),
> +				sizeof(__entry->f.loop_filter.mode_deltas[0])),
> +		  __entry->f.loop_filter.delta_lf_res,
> +		  __entry->f.cdef.damping_minus_3,
> +		  __entry->f.cdef.bits,
> +		  __print_array(__entry->f.cdef.y_pri_strength,
> +				ARRAY_SIZE(__entry->f.cdef.y_pri_strength),
> +				sizeof(__entry->f.cdef.y_pri_strength[0])),
> +		  __print_array(__entry->f.cdef.y_sec_strength,
> +				ARRAY_SIZE(__entry->f.cdef.y_sec_strength),
> +				sizeof(__entry->f.cdef.y_sec_strength[0])),
> +		  __print_array(__entry->f.cdef.uv_pri_strength,
> +				ARRAY_SIZE(__entry->f.cdef.uv_pri_strength),
> +				sizeof(__entry->f.cdef.uv_pri_strength[0])),
> +		  __print_array(__entry->f.cdef.uv_sec_strength,
> +				ARRAY_SIZE(__entry->f.cdef.uv_sec_strength),
> +				sizeof(__entry->f.cdef.uv_sec_strength[0])),
> +		  __print_array(__entry->f.skip_mode_frame,
> +				ARRAY_SIZE(__entry->f.skip_mode_frame),
> +				sizeof(__entry->f.skip_mode_frame[0])),
> +		  __entry->f.primary_ref_frame,
> +		  __print_flags(__entry->f.loop_restoration.flags, "|",
> +		  {V4L2_AV1_LOOP_RESTORATION_FLAG_USES_LR, "USES_LR"},
> +		  {V4L2_AV1_LOOP_RESTORATION_FLAG_USES_CHROMA_LR, "USES_CHROMA_LR"}),
> +		  __entry->f.loop_restoration.lr_unit_shift,
> +		  __entry->f.loop_restoration.lr_uv_shift,
> +		  __print_array(__entry->f.loop_restoration.frame_restoration_type,
> +				ARRAY_SIZE(__entry->f.loop_restoration.frame_restoration_type),
> +				sizeof(__entry->f.loop_restoration.frame_restoration_type[0])),
> +		  __print_array(__entry->f.loop_restoration.loop_restoration_size,
> +				ARRAY_SIZE(__entry->f.loop_restoration.loop_restoration_size),
> +				sizeof(__entry->f.loop_restoration.loop_restoration_size[0])),
> +		  __print_flags(__entry->f.flags, "|",
> +		  {V4L2_AV1_FRAME_FLAG_SHOW_FRAME, "SHOW_FRAME"},
> +		  {V4L2_AV1_FRAME_FLAG_SHOWABLE_FRAME, "SHOWABLE_FRAME"},
> +		  {V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE, "ERROR_RESILIENT_MODE"},
> +		  {V4L2_AV1_FRAME_FLAG_DISABLE_CDF_UPDATE, "DISABLE_CDF_UPDATE"},
> +		  {V4L2_AV1_FRAME_FLAG_ALLOW_SCREEN_CONTENT_TOOLS, "ALLOW_SCREEN_CONTENT_TOOLS"},
> +		  {V4L2_AV1_FRAME_FLAG_FORCE_INTEGER_MV, "FORCE_INTEGER_MV"},
> +		  {V4L2_AV1_FRAME_FLAG_ALLOW_INTRABC, "ALLOW_INTRABC"},
> +		  {V4L2_AV1_FRAME_FLAG_USE_SUPERRES, "USE_SUPERRES"},
> +		  {V4L2_AV1_FRAME_FLAG_ALLOW_HIGH_PRECISION_MV, "ALLOW_HIGH_PRECISION_MV"},
> +		  {V4L2_AV1_FRAME_FLAG_IS_MOTION_MODE_SWITCHABLE, "IS_MOTION_MODE_SWITCHABLE"},
> +		  {V4L2_AV1_FRAME_FLAG_USE_REF_FRAME_MVS, "USE_REF_FRAME_MVS"},
> +		  {V4L2_AV1_FRAME_FLAG_DISABLE_FRAME_END_UPDATE_CDF,
> +		   "DISABLE_FRAME_END_UPDATE_CDF"},
> +		  {V4L2_AV1_FRAME_FLAG_ALLOW_WARPED_MOTION, "ALLOW_WARPED_MOTION"},
> +		  {V4L2_AV1_FRAME_FLAG_REFERENCE_SELECT, "REFERENCE_SELECT"},
> +		  {V4L2_AV1_FRAME_FLAG_REDUCED_TX_SET, "REDUCED_TX_SET"},
> +		  {V4L2_AV1_FRAME_FLAG_SKIP_MODE_ALLOWED, "SKIP_MODE_ALLOWED"},
> +		  {V4L2_AV1_FRAME_FLAG_SKIP_MODE_PRESENT, "SKIP_MODE_PRESENT"},
> +		  {V4L2_AV1_FRAME_FLAG_FRAME_SIZE_OVERRIDE, "FRAME_SIZE_OVERRIDE"},
> +		  {V4L2_AV1_FRAME_FLAG_BUFFER_REMOVAL_TIME_PRESENT, "BUFFER_REMOVAL_TIME_PRESENT"},
> +		  {V4L2_AV1_FRAME_FLAG_FRAME_REFS_SHORT_SIGNALING, "FRAME_REFS_SHORT_SIGNALING"}),
> +		  __entry->f.order_hint,
> +		  __entry->f.upscaled_width,
> +		  __entry->f.frame_width_minus_1,
> +		  __entry->f.frame_height_minus_1,
> +		  __entry->f.render_width_minus_1,
> +		  __entry->f.render_height_minus_1,
> +		  __entry->f.current_frame_id,
> +		  __print_array(__entry->f.buffer_removal_time,
> +				ARRAY_SIZE(__entry->f.buffer_removal_time),
> +				sizeof(__entry->f.buffer_removal_time[0])),
> +		  __print_array(__entry->f.order_hints,
> +				ARRAY_SIZE(__entry->f.order_hints),
> +				sizeof(__entry->f.order_hints[0])),
> +		  __print_array(__entry->f.reference_frame_ts,
> +				ARRAY_SIZE(__entry->f.reference_frame_ts),
> +				sizeof(__entry->f.reference_frame_ts[0])),
> +		  __print_array(__entry->f.ref_frame_idx,
> +				ARRAY_SIZE(__entry->f.ref_frame_idx),
> +				sizeof(__entry->f.ref_frame_idx[0])),
> +		  __entry->f.refresh_frame_flags
> +	)
> +);
> +
> +
> +DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
> +	TP_PROTO(const struct v4l2_ctrl_av1_film_grain *f),
> +	TP_ARGS(f),
> +	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_film_grain, f)),
> +	TP_fast_assign(__entry->f = *f;),
> +	TP_printk("\nflags %s\ncr_mult: %u\ngrain_seed: %u\n"
> +		  "film_grain_params_ref_idx: %u\nnum_y_points: %u\npoint_y_value: %s\n"
> +		  "point_y_scaling: %s\nnum_cb_points: %u\npoint_cb_value: %s\n"
> +		  "point_cb_scaling: %s\nnum_cr_points: %u\npoint_cr_value: %s\n"
> +		  "point_cr_scaling: %s\ngrain_scaling_minus_8: %u\nar_coeff_lag: %u\n"
> +		  "ar_coeffs_y_plus_128: %s\nar_coeffs_cb_plus_128: %s\n"
> +		  "ar_coeffs_cr_plus_128: %s\nar_coeff_shift_minus_6: %u\n"
> +		  "grain_scale_shift: %u\ncb_mult: %u\ncb_luma_mult: %u\ncr_luma_mult: %u\n"
> +		  "cb_offset: %u\ncr_offset: %u\n",
> +		  __print_flags(__entry->f.flags, "|",
> +		  {V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN, "APPLY_GRAIN"},
> +		  {V4L2_AV1_FILM_GRAIN_FLAG_UPDATE_GRAIN, "UPDATE_GRAIN"},
> +		  {V4L2_AV1_FILM_GRAIN_FLAG_CHROMA_SCALING_FROM_LUMA, "CHROMA_SCALING_FROM_LUMA"},
> +		  {V4L2_AV1_FILM_GRAIN_FLAG_OVERLAP, "OVERLAP"},
> +		  {V4L2_AV1_FILM_GRAIN_FLAG_CLIP_TO_RESTRICTED_RANGE, "CLIP_TO_RESTRICTED_RANGE"}),
> +		  __entry->f.cr_mult,
> +		  __entry->f.grain_seed,
> +		  __entry->f.film_grain_params_ref_idx,
> +		  __entry->f.num_y_points,
> +		  __print_array(__entry->f.point_y_value,
> +				ARRAY_SIZE(__entry->f.point_y_value),
> +				sizeof(__entry->f.point_y_value[0])),
> +		  __print_array(__entry->f.point_y_scaling,
> +				ARRAY_SIZE(__entry->f.point_y_scaling),
> +				sizeof(__entry->f.point_y_scaling[0])),
> +		  __entry->f.num_cb_points,
> +		  __print_array(__entry->f.point_cb_value,
> +				ARRAY_SIZE(__entry->f.point_cb_value),
> +				sizeof(__entry->f.point_cb_value[0])),
> +		  __print_array(__entry->f.point_cb_scaling,
> +				ARRAY_SIZE(__entry->f.point_cb_scaling),
> +				sizeof(__entry->f.point_cb_scaling[0])),
> +		  __entry->f.num_cr_points,
> +		  __print_array(__entry->f.point_cr_value,
> +				ARRAY_SIZE(__entry->f.point_cr_value),
> +				sizeof(__entry->f.point_cr_value[0])),
> +		  __print_array(__entry->f.point_cr_scaling,
> +				ARRAY_SIZE(__entry->f.point_cr_scaling),
> +				sizeof(__entry->f.point_cr_scaling[0])),
> +		  __entry->f.grain_scaling_minus_8,
> +		  __entry->f.ar_coeff_lag,
> +		  __print_array(__entry->f.ar_coeffs_y_plus_128,
> +				ARRAY_SIZE(__entry->f.ar_coeffs_y_plus_128),
> +				sizeof(__entry->f.ar_coeffs_y_plus_128[0])),
> +		  __print_array(__entry->f.ar_coeffs_cb_plus_128,
> +				ARRAY_SIZE(__entry->f.ar_coeffs_cb_plus_128),
> +				sizeof(__entry->f.ar_coeffs_cb_plus_128[0])),
> +		  __print_array(__entry->f.ar_coeffs_cr_plus_128,
> +				ARRAY_SIZE(__entry->f.ar_coeffs_cr_plus_128),
> +				sizeof(__entry->f.ar_coeffs_cr_plus_128[0])),
> +		  __entry->f.ar_coeff_shift_minus_6,
> +		  __entry->f.grain_scale_shift,
> +		  __entry->f.cb_mult,
> +		  __entry->f.cb_luma_mult,
> +		  __entry->f.cr_luma_mult,
> +		  __entry->f.cb_offset,
> +		  __entry->f.cr_offset
> +	)
> +)
> +
> +DEFINE_EVENT(v4l2_ctrl_av1_seq_tmpl, v4l2_ctrl_av1_sequence,
> +	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
> +	TP_ARGS(s)
> +);
> +
> +DEFINE_EVENT(v4l2_ctrl_av1_frame_tmpl, v4l2_ctrl_av1_frame,
> +	TP_PROTO(const struct v4l2_ctrl_av1_frame *f),
> +	TP_ARGS(f)
> +);
> +
> +DEFINE_EVENT(v4l2_ctrl_av1_tge_tmpl, v4l2_ctrl_av1_tile_group_entry,
> +	TP_PROTO(const struct v4l2_ctrl_av1_tile_group_entry *t),
> +	TP_ARGS(t)
> +);
> +
> +DEFINE_EVENT(v4l2_ctrl_av1_film_grain_tmpl, v4l2_ctrl_av1_film_grain,
> +	TP_PROTO(const struct v4l2_ctrl_av1_film_grain *f),
> +	TP_ARGS(f)
> +);
> +
> +#endif
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH ../../drivers/media/test-drivers/visl
> +#define TRACE_INCLUDE_FILE visl-trace-av1
> +#include <trace/define_trace.h>
> diff --git a/drivers/media/test-drivers/visl/visl-trace-points.c b/drivers/media/test-drivers/visl/visl-trace-points.c
> index f7b866534f1e..321ff732c682 100644
> --- a/drivers/media/test-drivers/visl/visl-trace-points.c
> +++ b/drivers/media/test-drivers/visl/visl-trace-points.c
> @@ -8,3 +8,4 @@
>  #include "visl-trace-vp9.h"
>  #include "visl-trace-h264.h"
>  #include "visl-trace-hevc.h"
> +#include "visl-trace-av1.h"
> diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
> index 7cac6a6456eb..82d9c259e878 100644
> --- a/drivers/media/test-drivers/visl/visl-video.c
> +++ b/drivers/media/test-drivers/visl/visl-video.c
> @@ -40,6 +40,9 @@ static void visl_set_current_codec(struct visl_ctx *ctx)
>  	case V4L2_PIX_FMT_HEVC_SLICE:
>  		ctx->current_codec = VISL_CODEC_HEVC;
>  		break;
> +	case V4L2_PIX_FMT_AV1_FRAME:
> +		ctx->current_codec = VISL_CODEC_AV1;
> +		break;
>  	default:
>  		dprintk(ctx->dev, "Warning: unsupported fourcc: %d\n", fourcc);
>  		ctx->current_codec = VISL_CODEC_NONE;
> @@ -218,6 +221,21 @@ const struct visl_coded_format_desc visl_coded_fmts[] = {
>  		.num_decoded_fmts = ARRAY_SIZE(visl_decoded_fmts),
>  		.decoded_fmts = visl_decoded_fmts,
>  	},
> +	{
> +		.pixelformat = V4L2_PIX_FMT_AV1_FRAME,
> +		.frmsize = {
> +			.min_width = 64,
> +			.max_width = 4096,
> +			.step_width = 1,
> +			.min_height = 64,
> +			.max_height = 2304,
> +			.step_height = 1,
> +		},
> +		.ctrls = &visl_av1_ctrls,
> +		.num_decoded_fmts = ARRAY_SIZE(visl_decoded_fmts),
> +		.decoded_fmts = visl_decoded_fmts,
> +	},
> +
>  };
>  
>  const size_t num_coded_fmts = ARRAY_SIZE(visl_coded_fmts);
> diff --git a/drivers/media/test-drivers/visl/visl-video.h b/drivers/media/test-drivers/visl/visl-video.h
> index 27ad70a558db..92e274894c20 100644
> --- a/drivers/media/test-drivers/visl/visl-video.h
> +++ b/drivers/media/test-drivers/visl/visl-video.h
> @@ -17,6 +17,7 @@ extern const struct visl_ctrls visl_vp8_ctrls;
>  extern const struct visl_ctrls visl_vp9_ctrls;
>  extern const struct visl_ctrls visl_h264_ctrls;
>  extern const struct visl_ctrls visl_hevc_ctrls;
> +extern const struct visl_ctrls visl_av1_ctrls;
>  
>  int visl_queue_init(void *priv, struct vb2_queue *src_vq,
>  		    struct vb2_queue *dst_vq);
> diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
> index 31639f2e593d..c593b1337f11 100644
> --- a/drivers/media/test-drivers/visl/visl.h
> +++ b/drivers/media/test-drivers/visl/visl.h
> @@ -127,6 +127,7 @@ enum visl_codec {
>  	VISL_CODEC_VP9,
>  	VISL_CODEC_H264,
>  	VISL_CODEC_HEVC,
> +	VISL_CODEC_AV1,
>  };
>  
>  struct visl_blob {

