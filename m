Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747DA7F4D30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjKVQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjKVQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:49:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC7F9;
        Wed, 22 Nov 2023 08:49:11 -0800 (PST)
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C0166607391;
        Wed, 22 Nov 2023 16:49:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700671750;
        bh=kZZVgMd43cIxply6qs3meHVC0n1uBKxNoWcslKFq91o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jk1KD73NYTQ5ojjViH79sZewAN1hrsZCqLVMq+eTWqNs4jmdncMj+K89AdIbxAs7/
         J8hPy1a92z5TaIaZ+yOBYf/UoLW63KswqxyzM5lv0alJzU1bI7/VoyuP7q4k92fotx
         nPeirJiE6fccsd3LqcEt/gkp5BhySjXBg/TWwLzgH/JvL94o5e2v3jSFcO4AkWE2rf
         mkJ6npiZNSGhf7BbsdRN+0+c6WUCuTybKX2aD7w5v8K8mn3EW9eOHmNFqJ24fhFMbX
         lcAzXGecsDuXIvZFb+Ez3j1gHHwXnVKpfAsL/mXjue0a3you6Bx/PKOTMBDJ9IYtjU
         gRTBiDrdzKFtg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 2/5] media: visl: Add a stable_output parameter
Date:   Wed, 22 Nov 2023 11:49:21 -0500
Message-ID: <2913770.e9J7NaK4W3@arisu>
In-Reply-To: <e8594414-eaea-4022-8835-0c093657b005@xs4all.nl>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
 <20231024191027.305622-3-detlev.casanova@collabora.com>
 <e8594414-eaea-4022-8835-0c093657b005@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3264630.aeNJFYEL58";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3264630.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v2 2/5] media: visl: Add a stable_output parameter
Date: Wed, 22 Nov 2023 11:49:21 -0500
Message-ID: <2913770.e9J7NaK4W3@arisu>
In-Reply-To: <e8594414-eaea-4022-8835-0c093657b005@xs4all.nl>
MIME-Version: 1.0

On Wednesday, November 22, 2023 11:03:53 A.M. EST Hans Verkuil wrote:
> On 24/10/2023 21:09, Detlev Casanova wrote:
> > This parameter is used to ensure that for a given input, the output
> > frames are always identical so that it can be compared against
> > a reference in automatic tests.
> > 
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  drivers/media/test-drivers/visl/visl-core.c |   5 +
> >  drivers/media/test-drivers/visl/visl-dec.c  | 125 +++++++++++---------
> >  drivers/media/test-drivers/visl/visl.h      |   1 +
> >  3 files changed, 77 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/media/test-drivers/visl/visl-core.c
> > b/drivers/media/test-drivers/visl/visl-core.c index
> > df6515530fbf..d28d50afec02 100644
> > --- a/drivers/media/test-drivers/visl/visl-core.c
> > +++ b/drivers/media/test-drivers/visl/visl-core.c
> > @@ -88,6 +88,11 @@ module_param(bitstream_trace_nframes, uint, 0);
> > 
> >  MODULE_PARM_DESC(bitstream_trace_nframes,
> >  
> >  		 " the number of frames to dump the bitstream through 
debugfs");
> > 
> > +bool stable_output;
> > +module_param(stable_output, bool, 0644);
> > +MODULE_PARM_DESC(stable_output,
> > +		 " only write stable data for a given input on the 
output frames");
> > +
> > 
> >  static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
> >  
> >  	{
> >  	
> >  		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
> > 
> > diff --git a/drivers/media/test-drivers/visl/visl-dec.c
> > b/drivers/media/test-drivers/visl/visl-dec.c index
> > 318d675e5668..61cfca49ead9 100644
> > --- a/drivers/media/test-drivers/visl/visl-dec.c
> > +++ b/drivers/media/test-drivers/visl/visl-dec.c
> > @@ -197,19 +197,30 @@ static void visl_tpg_fill_sequence(struct visl_ctx
> > *ctx,> 
> >  {
> >  
> >  	u32 stream_ms;
> > 
> > -	stream_ms = jiffies_to_msecs(get_jiffies_64() -
> > ctx->capture_streamon_jiffies); -
> > -	scnprintf(buf, bufsz,
> > -		  "stream time: %02d:%02d:%02d:%03d sequence:%u 
timestamp:%lld
> > field:%s", -		  (stream_ms / (60 * 60 * 1000)) % 24,
> > -		  (stream_ms / (60 * 1000)) % 60,
> > -		  (stream_ms / 1000) % 60,
> > -		  stream_ms % 1000,
> > -		  run->dst->sequence,
> > -		  run->dst->vb2_buf.timestamp,
> > -		  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> > -		  (run->dst->field == V4L2_FIELD_TOP ?
> > -		  " top" : " bottom") : "none");
> > +	if (!stable_output) {
> > +		stream_ms = jiffies_to_msecs(get_jiffies_64() -
> > ctx->capture_streamon_jiffies); +
> > +		scnprintf(buf, bufsz,
> > +			  "stream time: %02d:%02d:%02d:%03d 
sequence:%u timestamp:%lld
> > field:%s", +			  (stream_ms / (60 * 60 * 
1000)) % 24,
> > +			  (stream_ms / (60 * 1000)) % 60,
> > +			  (stream_ms / 1000) % 60,
> > +			  stream_ms % 1000,
> 
> How useful is this 'stream time' anyway? I don't think this adds anything
> useful.

I suppose that the more debug information is shown, the better.

> > +			  run->dst->sequence,
> > +			  run->dst->vb2_buf.timestamp,
> > +			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> > +			  (run->dst->field == V4L2_FIELD_TOP ?
> > +			  " top" : " bottom") : "none");
> > +	} else {
> > +		scnprintf(buf, bufsz,
> > +			  "sequence:%u timestamp:%lld field:%s",
> > +			  run->dst->sequence,
> > +			  run->dst->vb2_buf.timestamp,
> > +			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
> > +			  (run->dst->field == V4L2_FIELD_TOP ?
> > +			  " top" : " bottom") : "none");
> > +
> > +	}
> > 
> >  }
> >  
> >  static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
> > 
> > @@ -244,15 +255,17 @@ static void visl_tpg_fill(struct visl_ctx *ctx,
> > struct visl_run *run)> 
> >  	frame_dprintk(ctx->dev, run->dst->sequence, "");
> >  	line++;
> > 
> > -	visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
> 
> This function shows both the ts of the ref frames and the buffer
> index. Is it just the buffer index that causes the problem? If so,
> then wouldn't it be better to either never show the buffer index
> or only if !stable_output.

Indeed, the buffer index is the issue, but I did not check if the ref frames ts 
are stable. I'll do some tests with it and keep the ref frames in stable 
output mode if they are stable.

> > +	if (!stable_output) {
> > +		visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
> > 
> > -	while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
> > -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 
16, line_str);
> > -		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", 
line_str);
> > -	}
> > +		while ((line_str = strsep(&tmp, "\n")) && 
strlen(line_str)) {
> > +			tpg_gen_text(&ctx->tpg, basep, line++ * 
line_height, 16, line_str);
> > +			frame_dprintk(ctx->dev, run->dst->sequence, 
"%s\n", line_str);
> > +		}
> > 
> > -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> > -	line++;
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> > +		line++;
> > +	}
> > 
> >  	scnprintf(buf,
> >  	
> >  		  TPG_STR_BUF_SZ,
> > 
> > @@ -280,28 +293,30 @@ static void visl_tpg_fill(struct visl_ctx *ctx,
> > struct visl_run *run)> 
> >  		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", 
buf);
> >  	
> >  	}
> > 
> > -	line++;
> > -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> > -	scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
> > -	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> > -	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
> > +	if (!stable_output) {
> > +		line++;
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> > +		scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
> > +		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 
16, buf);
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", 
buf);
> > 
> > -	len = 0;
> > -	for (i = 0; i < out_q->num_buffers; i++) {
> > -		char entry[] = "index: %u, state: %s, request_fd: %d, 
";
> > -		u32 old_len = len;
> > -		char *q_status = visl_get_vb2_state(out_q->bufs[i]-
>state);
> > +		len = 0;
> > +		for (i = 0; i < out_q->num_buffers; i++) {
> > +			char entry[] = "index: %u, state: %s, 
request_fd: %d, ";
> > +			u32 old_len = len;
> > +			char *q_status = visl_get_vb2_state(out_q-
>bufs[i]->state);
> > 
> > -		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> > -				 entry, i, q_status,
> > -				 to_vb2_v4l2_buffer(out_q-
>bufs[i])->request_fd);
> > +			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - 
len,
> > +					 entry, i, q_status,
> > +					 
to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
> > 
> > -		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q-
>bufs[i]),
> > -					   &buf[len],
> > -					   TPG_STR_BUF_SZ - 
len);
> > +			len += 
visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> > +						   
&buf[len],
> > +						   
TPG_STR_BUF_SZ - len);
> > 
> > -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 
16,
> > &buf[old_len]);
> > -		frame_dprintk(ctx->dev, run->dst->sequence, "%s", 
&buf[old_len]);
> > +			tpg_gen_text(&ctx->tpg, basep, line++ * 
line_height, 16,
> > &buf[old_len]); +			frame_dprintk(ctx->dev, run-
>dst->sequence, "%s",
> > &buf[old_len]); +		}
> > 
> >  	}
> >  	
> >  	line++;
> > 
> > @@ -333,25 +348,27 @@ static void visl_tpg_fill(struct visl_ctx *ctx,
> > struct visl_run *run)> 
> >  		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", 
buf);
> >  	
> >  	}
> > 
> > -	line++;
> > -	frame_dprintk(ctx->dev, run->dst->sequence, "");
> > -	scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
> > -	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
> > -	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
> > +	if (!stable_output) {
> > +		line++;
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> > +		scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue 
status:");
> > +		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 
16, buf);
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", 
buf);
> > 
> > -	len = 0;
> > -	for (i = 0; i < cap_q->num_buffers; i++) {
> > -		u32 old_len = len;
> > -		char *q_status = visl_get_vb2_state(cap_q->bufs[i]-
>state);
> > +		len = 0;
> > +		for (i = 0; i < cap_q->num_buffers; i++) {
> > +			u32 old_len = len;
> > +			char *q_status = visl_get_vb2_state(cap_q-
>bufs[i]->state);
> > 
> > -		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
> > -				 "index: %u, status: %s, 
timestamp: %llu, is_held: %d",
> > -				 cap_q->bufs[i]->index, q_status,
> > -				 cap_q->bufs[i]->timestamp,
> > -				 to_vb2_v4l2_buffer(cap_q-
>bufs[i])->is_held);
> > +			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - 
len,
> > +					 "index: %u, status: 
%s, timestamp: %llu, is_held: %d",
> > +					 cap_q->bufs[i]-
>index, q_status,
> > +					 cap_q->bufs[i]-
>timestamp,
> > +					 
to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
> > 
> > -		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 
16,
> > &buf[old_len]);
> > -		frame_dprintk(ctx->dev, run->dst->sequence, "%s", 
&buf[old_len]);
> > +			tpg_gen_text(&ctx->tpg, basep, line++ * 
line_height, 16,
> > &buf[old_len]); +			frame_dprintk(ctx->dev, run-
>dst->sequence, "%s",
> > &buf[old_len]); +		}
> > 
> >  	}
> >  
> >  }
> > 
> > diff --git a/drivers/media/test-drivers/visl/visl.h
> > b/drivers/media/test-drivers/visl/visl.h index 31639f2e593d..5a81b493f121
> > 100644
> > --- a/drivers/media/test-drivers/visl/visl.h
> > +++ b/drivers/media/test-drivers/visl/visl.h
> > @@ -85,6 +85,7 @@ extern unsigned int visl_dprintk_nframes;
> > 
> >  extern bool keep_bitstream_buffers;
> >  extern int bitstream_trace_frame_start;
> >  extern unsigned int bitstream_trace_nframes;
> > 
> > +extern bool stable_output;
> > 
> >  #define frame_dprintk(dev, current, fmt, arg...) \
> >  
> >  	do { \
> 
> Should stable_output perhaps be 1 by default?

In that case, why not use the visl_debug parameter and show the unstable data 
only when it is set to one ?

--
Detlev

--nextPart3264630.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmVeMREACgkQ5EFKUk4x
7baiLQgAnNXNQEBpHOKQSfJzPc0ohDxroLGL3Se0aYP4pkeJb4+EIQO/tvWFKJtU
PWcSwFYzIoAloUcQCBDF68UkqE+TBDqEHyNKrW2kPwCq5gWanG64M4Embeby/Ebs
R2P7uiLKkPSXxrvzHf+fZk4SJAQChRs2VDdx5C7GXmq/ZscLHxN1JlynEYUMvr7e
BxqzI10JGHztK58YQA21AjVyX1K/2EwC9QTqrmKOnG1ThhbkBBZT5jYf6PLC3hMv
NLeDizNIeZggVNpeQJGEyRbIybE4l7UPUD5WTnm3io8Lq4uUDobe3uoqTuNm2dw1
6sEFHlOWWUGBn3yAVupFTl8JyknNvg==
=rzUM
-----END PGP SIGNATURE-----

--nextPart3264630.aeNJFYEL58--



