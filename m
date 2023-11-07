Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92237E4B15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjKGVre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjKGVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:47:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A345710CF;
        Tue,  7 Nov 2023 13:47:31 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 454726607479;
        Tue,  7 Nov 2023 21:47:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699393650;
        bh=Wd+mOYLiwknQrs4ZPLDPT6EpeXqS6AylXK6ib0MoKl0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N6s+zGIaJQIu+GyjfbOPaXqUulA7JbVvTIvQ0BC4cVN1VwzrHlsV8Owqf1bsBBx4m
         gI611QH0C+/Lx8UE9Tliq0sH8y8b1bCMEBGArH8vwU8yPvkHerj3cE/n/WvuBsl/Vp
         gSkTX8Ki+Chix3P+QASp5i3BsaKU8N//8xGxRJKdmVSIMK2VURcTzCxyYQFy8phTpa
         t+CzbM6ZuDwJClbanRn11huUw82j6juvbIyAKwLBtLTcSNm0TJEQWn3dp7B0OKkZH8
         VyPzsVBYnI0RiE02VfLSxHdLK2DV21re9bTFVAm/7WbFF7jI2izeaqpv/SYAM9WPo8
         DCNil1/6BLacw==
Message-ID: <7d4a1662ad9bb3531793c47b6c41dad3215f9162.camel@collabora.com>
Subject: Re: [PATCH v4 04/11] media: rkvdec: h264: Don't hardcode SPS/PPS
 parameters
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 16:47:17 -0500
In-Reply-To: <20231105165521.3592037-5-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-5-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> From: Alex Bee <knaerzche@gmail.com>
>=20
> Some SPS/PPS parameters are currently hardcoded in the driver even
> though they exist in the stable uapi controls.
>=20
> Use values from SPS/PPS controls instead of hardcoding them.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> [jonas@kwiboo.se: constraint_set_flags condition, commit message]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v4:
> - No change
>=20
> v3:
> - New patch
>=20
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging=
/media/rkvdec/rkvdec-h264.c
> index 7a1e76d423df..8bce8902b8dd 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -655,13 +655,14 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
> =20
>  #define WRITE_PPS(value, field) set_ps_field(hw_ps->info, field, value)
>  	/* write sps */
> -	WRITE_PPS(0xf, SEQ_PARAMETER_SET_ID);
> -	WRITE_PPS(0xff, PROFILE_IDC);
> -	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
> +	WRITE_PPS(sps->seq_parameter_set_id, SEQ_PARAMETER_SET_ID);
> +	WRITE_PPS(sps->profile_idc, PROFILE_IDC);
> +	WRITE_PPS(!!(sps->constraint_set_flags & (1 << 3)), CONSTRAINT_SET3_FLA=
G);
>  	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
>  	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
>  	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
> -	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
> +	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_B=
YPASS),
> +		  QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
>  	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
>  	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
>  	WRITE_PPS(sps->pic_order_cnt_type, PIC_ORDER_CNT_TYPE);
> @@ -688,8 +689,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
>  		  DIRECT_8X8_INFERENCE_FLAG);
> =20
>  	/* write pps */
> -	WRITE_PPS(0xff, PIC_PARAMETER_SET_ID);
> -	WRITE_PPS(0x1f, PPS_SEQ_PARAMETER_SET_ID);
> +	WRITE_PPS(pps->pic_parameter_set_id, PIC_PARAMETER_SET_ID);
> +	WRITE_PPS(pps->seq_parameter_set_id, PPS_SEQ_PARAMETER_SET_ID);
>  	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE),
>  		  ENTROPY_CODING_MODE_FLAG);
>  	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_=
FRAME_PRESENT),

