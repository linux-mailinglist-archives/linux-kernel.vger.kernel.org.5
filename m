Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628A97F4D65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbjKVQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbjKVQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:52:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E1D50;
        Wed, 22 Nov 2023 08:51:59 -0800 (PST)
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B622E6607392;
        Wed, 22 Nov 2023 16:51:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700671918;
        bh=1VPwfkITmRU+YlSEzmhy+Urrbi2kRzxRc9orsM0XTDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S67VFX9bpyIDMeZrQ8Ey1Q3nX0BMmBgqlMykUWO3c/JvbJZkpTqvRkZiZ4m3oMDiX
         eFcI7xehaZurotFxE5hoNqIAUpmOv4GzY84D1P/E8JPx3Jcesjxovafw0kOVW61xX6
         x+yKzvZBvjKUzXN4KsO9KbhHipCf0yiG9XXze2iIvsKN+YueHgtZIwpro2pGHo8BEc
         IBl2KrDHPrARiZw39HIepVMGj+GDjIODhn2OqXJttTJ9/ZZSHyQ+y0ciSvCwTqmSQf
         3GBjR3UzdrWprh5A2O6FCHKBFQDG/otXYK2u5vMbvC4RK33iYDcQyzzJrnqZgByQmB
         0FQFb3uNs5wWw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 4/5] visl: Add a codec specific variability parameter
Date:   Wed, 22 Nov 2023 11:52:08 -0500
Message-ID: <10376589.nUPlyArG6x@arisu>
In-Reply-To: <bbc673bd-de2c-43eb-81c0-16a9dfad4c4e@xs4all.nl>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
 <20231024191027.305622-5-detlev.casanova@collabora.com>
 <bbc673bd-de2c-43eb-81c0-16a9dfad4c4e@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2250269.iZASKD2KPV";
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

--nextPart2250269.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 22 Nov 2023 11:52:08 -0500
Message-ID: <10376589.nUPlyArG6x@arisu>
In-Reply-To: <bbc673bd-de2c-43eb-81c0-16a9dfad4c4e@xs4all.nl>
MIME-Version: 1.0

On Wednesday, November 22, 2023 11:07:18 A.M. EST Hans Verkuil wrote:
> On 24/10/2023 21:09, Detlev Casanova wrote:
> > When running tests with different input data, the stable output frames
> > could be too similar and hide possible issues.
> > 
> > This commit adds variation by using some codec specific parameters.
> > 
> > Only HEVC and H.264 support this.
> > 
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  drivers/media/test-drivers/visl/visl-core.c |  5 ++++
> >  drivers/media/test-drivers/visl/visl-dec.c  | 27 +++++++++++++++++++++
> >  drivers/media/test-drivers/visl/visl.h      |  1 +
> >  3 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/media/test-drivers/visl/visl-core.c
> > b/drivers/media/test-drivers/visl/visl-core.c index
> > d28d50afec02..e7466f6a91e1 100644
> > --- a/drivers/media/test-drivers/visl/visl-core.c
> > +++ b/drivers/media/test-drivers/visl/visl-core.c
> > @@ -93,6 +93,11 @@ module_param(stable_output, bool, 0644);
> > 
> >  MODULE_PARM_DESC(stable_output,
> >  
> >  		 " only write stable data for a given input on the 
output frames");
> > 
> > +bool codec_variability;
> > +module_param(codec_variability, bool, 0644);
> > +MODULE_PARM_DESC(codec_variability,
> > +		 " add codec specific variability data to generate more 
unique frames.
> > (Only h.264 and hevc)");
> Why make this a module parameter instead of always doing this?
> 
> It's not clear from the commit log why a parameter is needed.

I agree with that, I started as a parameter when I wasn't sure what 
variability values or method would be used, but just showing a value can be 
integrated without a parameter and keep it more simple. I'll change that.

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
> > 61cfca49ead9..002d5e3b0ea4 100644
> > --- a/drivers/media/test-drivers/visl/visl-dec.c
> > +++ b/drivers/media/test-drivers/visl/visl-dec.c
> > @@ -223,6 +223,26 @@ static void visl_tpg_fill_sequence(struct visl_ctx
> > *ctx,> 
> >  	}
> >  
> >  }
> > 
> > +static bool visl_tpg_fill_codec_specific(struct visl_ctx *ctx,
> > +					 struct visl_run *run,
> > +					 char buf[], size_t 
bufsz)
> > +{
> > +	switch (ctx->current_codec) {
> > +	case VISL_CODEC_H264:
> > +		scnprintf(buf, bufsz,
> > +			  "H264: %u", run->h264.dpram-
>pic_order_cnt_lsb);
> > +		break;
> > +	case VISL_CODEC_HEVC:
> > +		scnprintf(buf, bufsz,
> > +			  "HEVC: %d", run->hevc.dpram-
>pic_order_cnt_val);
> > +		break;
> 
> Perhaps mention here why these specific values are chosen?

Will do.

> > +	default:
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > 
> >  static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
> >  {
> >  
> >  	u8 *basep[TPG_MAX_PLANES][2];
> > 
> > @@ -255,6 +275,13 @@ static void visl_tpg_fill(struct visl_ctx *ctx,
> > struct visl_run *run)> 
> >  	frame_dprintk(ctx->dev, run->dst->sequence, "");
> >  	line++;
> > 
> > +	if (codec_variability && visl_tpg_fill_codec_specific(ctx, run, buf,
> > TPG_STR_BUF_SZ)) { +		tpg_gen_text(&ctx->tpg, basep, line++ *
> > line_height, 16, buf);
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", 
buf);
> > +		frame_dprintk(ctx->dev, run->dst->sequence, "");
> > +		line++;
> > +	}
> > +
> > 
> >  	if (!stable_output) {
> >  	
> >  		visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
> > 
> > diff --git a/drivers/media/test-drivers/visl/visl.h
> > b/drivers/media/test-drivers/visl/visl.h index 5a81b493f121..4ac2d1783020
> > 100644
> > --- a/drivers/media/test-drivers/visl/visl.h
> > +++ b/drivers/media/test-drivers/visl/visl.h
> > @@ -86,6 +86,7 @@ extern bool keep_bitstream_buffers;
> > 
> >  extern int bitstream_trace_frame_start;
> >  extern unsigned int bitstream_trace_nframes;
> >  extern bool stable_output;
> > 
> > +extern bool codec_variability;
> > 
> >  #define frame_dprintk(dev, current, fmt, arg...) \
> >  
> >  	do { \
> 
> Regards,
> 
> 	Hans


--nextPart2250269.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmVeMbgACgkQ5EFKUk4x
7bbEgwf9FHsPocHfueH/kMUZBCVG54oUWXAp8/xnRXclmaGhbQ8W58q4rvF868aU
QaF6Nt63eTSEMj9h9xyqjKQbZX9JT7YgvOtN6C+6og3cGdg5+0k8/wdjww/QCYvl
61EvpvrktJYt9+60g/bB4Vv2m5a1AzJdpuUvFb9vughsrEJpoEFNkaSb1STh5xPL
frGUAPDP35aD2L1+gJa8mshRiadh9pGDp2k/uY1+LEq1AUly09TwxEyiIRSb/9VJ
w2iZCRDeZgRVdZmaV6ImvkzNDxXaiiaYtcXF/Xmtu6A3asNkEDYXFn4vu2C8AjNw
hVo1uyjutdQr2Mv4VM9ZsMc318S6pg==
=buIh
-----END PGP SIGNATURE-----

--nextPart2250269.iZASKD2KPV--



