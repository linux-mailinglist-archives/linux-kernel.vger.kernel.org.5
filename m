Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AA7F4BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjKVQED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjKVQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:04:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E614D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:03:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BCCC433C8;
        Wed, 22 Nov 2023 16:03:54 +0000 (UTC)
Message-ID: <e8594414-eaea-4022-8835-0c093657b005@xs4all.nl>
Date:   Wed, 22 Nov 2023 17:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] media: visl: Add a stable_output parameter
Content-Language: en-US, nl
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
 <20231024191027.305622-3-detlev.casanova@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231024191027.305622-3-detlev.casanova@collabora.com>
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

On 24/10/2023 21:09, Detlev Casanova wrote:
> This parameter is used to ensure that for a given input, the output
> frames are always identical so that it can be compared against
> a reference in automatic tests.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/media/test-drivers/visl/visl-core.c |   5 +
>  drivers/media/test-drivers/visl/visl-dec.c  | 125 +++++++++++---------
>  drivers/media/test-drivers/visl/visl.h      |   1 +
>  3 files changed, 77 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
> index df6515530fbf..d28d50afec02 100644
> --- a/drivers/media/test-drivers/visl/visl-core.c
> +++ b/drivers/media/test-drivers/visl/visl-core.c
> @@ -88,6 +88,11 @@ module_param(bitstream_trace_nframes, uint, 0);
>  MODULE_PARM_DESC(bitstream_trace_nframes,
>  		 " the number of frames to dump the bitstream through debugfs");
>  
> +bool stable_output;
> +module_param(stable_output, bool, 0644);
> +MODULE_PARM_DESC(stable_output,
> +		 " only write stable data for a given input on the output frames");
> +
>  static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
>  	{
>  		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
> index 318d675e5668..61cfca49ead9 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.c
> +++ b/drivers/media/test-drivers/visl/visl-dec.c
> @@ -197,19 +197,30 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
>  {
>  	u32 stream_ms;
>  
> -	stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
> -
> -	scnprintf(buf, bufsz,
> -		  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
> -		  (stream_ms / (60 * 60 * 1000)) % 24,
> -		  (stream_ms / (60 * 1000)) % 60,
> -		  (stream_ms / 1000) % 60,
> -		  stream_ms % 1000,
> -		  run->dst->sequence,
> -		  run->dst->vb2_buf.timestamp,
> -		  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> -		  (run->dst->field == V4L2_FIELD_TOP ?
> -		  " top" : " bottom") : "none");
> +	if (!stable_output) {
> +		stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
> +
> +		scnprintf(buf, bufsz,
> +			  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
> +			  (stream_ms / (60 * 60 * 1000)) % 24,
> +			  (stream_ms / (60 * 1000)) % 60,
> +			  (stream_ms / 1000) % 60,
> +			  stream_ms % 1000,

How useful is this 'stream time' anyway? I don't think this adds anything
useful.

> +			  run->dst->sequence,
> +			  run->dst->vb2_buf.timestamp,
> +			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> +			  (run->dst->field == V4L2_FIELD_TOP ?
> +			  " top" : " bottom") : "none");
> +	} else {
> +		scnprintf(buf, bufsz,
> +			  "sequence:%u timestamp:%lld field:%s",
> +			  run->dst->sequence,
> +			  run->dst->vb2_buf.timestamp,
> +			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> +			  (run->dst->field == V4L2_FIELD_TOP ?
> +			  " top" : " bottom") : "none");
> +
> +	}
>  }
>  
>  static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
> @@ -244,15 +255,17 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  	frame_dprintk(ctx->dev, run->dst->sequence, "");
>  	line++;
>  
> -	visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);

This function shows both the ts of the ref frames and the buffer
index. Is it just the buffer index that causes the problem? If so,
then wouldn't it be better to either never show the buffer index
or only if !stable_output.

> +	if (!stable_output) {
> +		visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
>  
> -	while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
> -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, line_str);
> -		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", line_str);
> -	}
> +		while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
> +			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, line_str);
> +			frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", line_str);
> +		}
>  
> -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> -	line++;
> +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> +		line++;
> +	}
>  
>  	scnprintf(buf,
>  		  TPG_STR_BUF_SZ,
> @@ -280,28 +293,30 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  	}
>  
> -	line++;
> -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> -	scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
> -	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> -	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
> +	if (!stable_output) {
> +		line++;
> +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> +		scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
> +		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  
> -	len = 0;
> -	for (i = 0; i < out_q->num_buffers; i++) {
> -		char entry[] = "index: %u, state: %s, request_fd: %d, ";
> -		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
> +		len = 0;
> +		for (i = 0; i < out_q->num_buffers; i++) {
> +			char entry[] = "index: %u, state: %s, request_fd: %d, ";
> +			u32 old_len = len;
> +			char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
>  
> -		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> -				 entry, i, q_status,
> -				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
> +			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> +					 entry, i, q_status,
> +					 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
>  
> -		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> -					   &buf[len],
> -					   TPG_STR_BUF_SZ - len);
> +			len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> +						   &buf[len],
> +						   TPG_STR_BUF_SZ - len);
>  
> -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> -		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> +			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +		}
>  	}
>  
>  	line++;
> @@ -333,25 +348,27 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  	}
>  
> -	line++;
> -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> -	scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
> -	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> -	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
> +	if (!stable_output) {
> +		line++;
> +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> +		scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
> +		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>  
> -	len = 0;
> -	for (i = 0; i < cap_q->num_buffers; i++) {
> -		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
> +		len = 0;
> +		for (i = 0; i < cap_q->num_buffers; i++) {
> +			u32 old_len = len;
> +			char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
>  
> -		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> -				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
> -				 cap_q->bufs[i]->index, q_status,
> -				 cap_q->bufs[i]->timestamp,
> -				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
> +			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> +					 "index: %u, status: %s, timestamp: %llu, is_held: %d",
> +					 cap_q->bufs[i]->index, q_status,
> +					 cap_q->bufs[i]->timestamp,
> +					 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
>  
> -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> -		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
> +			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
> index 31639f2e593d..5a81b493f121 100644
> --- a/drivers/media/test-drivers/visl/visl.h
> +++ b/drivers/media/test-drivers/visl/visl.h
> @@ -85,6 +85,7 @@ extern unsigned int visl_dprintk_nframes;
>  extern bool keep_bitstream_buffers;
>  extern int bitstream_trace_frame_start;
>  extern unsigned int bitstream_trace_nframes;
> +extern bool stable_output;
>  
>  #define frame_dprintk(dev, current, fmt, arg...) \
>  	do { \

Should stable_output perhaps be 1 by default?

Regards,

	Hans
