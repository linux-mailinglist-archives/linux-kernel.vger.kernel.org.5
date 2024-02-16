Return-Path: <linux-kernel+bounces-68444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8B857A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE75028837C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6982C1A3;
	Fri, 16 Feb 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bokedZ5L"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624412C860;
	Fri, 16 Feb 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079323; cv=none; b=rmQIVfLkgks8sW3wQS3ldKvcgH5o1ua1jgvQvVQZNQcq6voZAwa5ZpKe6btwhf8PzewczCigOXqn2AjoIsKYEp6autAullSGshK+WAVD+UFoHILatMK+XS5KBOJV9BBHFHYqpc/ndxb/UNdsn4dHLzL1MVQ2k7OvOqsCIWPDDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079323; c=relaxed/simple;
	bh=32pqVwO+RqnwFfeQjxXXUN1e/1XXDkQ0T1CtIpBLZps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfzjgisc/oOClIZ/n0NHCbAhUvTEW+mWzYfF+RlQCw8iA95g6Isejjgqo60rpZAqHaC2ZY4k/tK2GwW4d9IgUAs4ZHwbeFXRzEnRJGd3xkQoJY2nxQu1LJEpOryOTDFMA/ig86vs4q5TB3eO3b3eUtmWrdEvcFyhlBM8sZhLtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bokedZ5L; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708079320; x=1739615320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MB/nN9a0T/r1EBacRJA4wapz9QQsMCAXdIXZIw6yqkc=;
  b=bokedZ5LEAuB7WNDt8rwuV2fT2hZuD+WY8jw0viP+lxudc0CuIK4Vq1K
   oZvWpoYxPbQOVqEIjg1Epl8ZT7o3e5oGSXG6nQgH439b+AoiKAH19CYzy
   hFRl2DLZAtp4p/diTZ0ngUNXpd4bknvS5ESIvFXFvZWc5q0G23jHQQFzD
   z7cyliDoGvBKmvbnpAv7mbdnjdMKpy/mXiyWCvVCd6iqeA/24sPdD0XjS
   tXbWckNb1oU8O+tO5Au2MDM3TsSm8XDNlpoTrYber2e2DrjtXddR1mt8y
   NdBA+dgdzHCRGkMseABkTSUtFxN2ZzOf1Vjalk2yz9p06yQNSomzaVaRR
   w==;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="35443367"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2024 11:28:36 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6E28B280075;
	Fri, 16 Feb 2024 11:28:34 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Paul Elder <paul.elder@ideasonboard.com>
Cc: kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com, aford173@gmail.com, Paul Elder <paul.elder@ideasonboard.com>, Dafna Hirschfeld <dafna@fastmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 11/12] media: rkisp1: Fix endianness on raw streams on i.MX8MP
Date: Fri, 16 Feb 2024 11:28:36 +0100
Message-ID: <1980499.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240216095458.2919694-12-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com> <20240216095458.2919694-12-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Paul,

thanks for updating this.

Am Freitag, 16. Februar 2024, 10:54:57 CET schrieb Paul Elder:
> The i.MX8MP has extra register fields in the memory interface control
> register for setting the output format, which work with the output
> alignment format register for byte-swapping and LSB/MSB alignment.
>=20
> With processed and 8-bit raw streams, it doesn't cause any problems to
> not set these, but with raw streams of higher bit depth the endianness
> is swapped and the data is not aligned properly.
>=20
> Add support for settings these registers and plumb them in to fix this.
>=20
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> Changes in v12:
> - replace MP_OUTPUT_FORMAT feature flag with MAIN_STRIDE
>=20
> New in v6
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 93 ++++++++++++++-----
>  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  8 ++
>  2 files changed, 78 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c index
> 64b1d1104e20..28a99b31581b 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -48,16 +48,20 @@ enum rkisp1_plane {
>   * @fmt_type: helper filed for pixel format
>   * @uv_swap: if cb cr swapped, for yuv
>   * @yc_swap: if y and cb/cr swapped, for yuv
> + * @byte_swap: if byte pairs are swapped, for raw
>   * @write_format: defines how YCbCr self picture data is written to memo=
ry
> - * @output_format: defines sp output format
> + * @output_format_mp: defines mp output format
> + * @output_format_sp: defines sp output format
>   * @mbus: the mbus code on the src resizer pad that matches the pixel
> format */
>  struct rkisp1_capture_fmt_cfg {
>  	u32 fourcc;
>  	u32 uv_swap : 1;
>  	u32 yc_swap : 1;
> +	u32 byte_swap : 1;
>  	u32 write_format;
> -	u32 output_format;
> +	u32 output_format_mp;
> +	u32 output_format_sp;
>  	u32 mbus;
>  };
>=20
> @@ -96,42 +100,50 @@ static const struct rkisp1_capture_fmt_cfg
> rkisp1_mp_fmts[] =3D { .fourcc =3D V4L2_PIX_FMT_YUYV,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_UYVY,
>  		.uv_swap =3D 0,
>  		.yc_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YUV422P,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV16,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV61,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV16M,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV61M,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YVU422M,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv400 */
> @@ -139,6 +151,7 @@ static const struct rkisp1_capture_fmt_cfg
> rkisp1_mp_fmts[] =3D { .fourcc =3D V4L2_PIX_FMT_GREY,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV400,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv420 */
> @@ -146,81 +159,107 @@ static const struct rkisp1_capture_fmt_cfg
> rkisp1_mp_fmts[] =3D { .fourcc =3D V4L2_PIX_FMT_NV21,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV21M,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV12M,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YUV420,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YVU420,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	},
>  	/* raw */
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_SRGGB8,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus =3D MEDIA_BUS_FMT_SRGGB8_1X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SGRBG8,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus =3D MEDIA_BUS_FMT_SGRBG8_1X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SGBRG8,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus =3D MEDIA_BUS_FMT_SGBRG8_1X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SBGGR8,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8,
>  		.mbus =3D MEDIA_BUS_FMT_SBGGR8_1X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SRGGB10,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus =3D MEDIA_BUS_FMT_SRGGB10_1X10,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SGRBG10,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus =3D MEDIA_BUS_FMT_SGRBG10_1X10,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SGBRG10,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus =3D MEDIA_BUS_FMT_SGBRG10_1X10,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SBGGR10,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10,
>  		.mbus =3D MEDIA_BUS_FMT_SBGGR10_1X10,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SRGGB12,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus =3D MEDIA_BUS_FMT_SRGGB12_1X12,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SGRBG12,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus =3D MEDIA_BUS_FMT_SGRBG12_1X12,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SGBRG12,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus =3D MEDIA_BUS_FMT_SGBRG12_1X12,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_SBGGR12,
> +		.byte_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_MP_WRITE_RAW12,
> +		.output_format_mp =3D RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12,
>  		.mbus =3D MEDIA_BUS_FMT_SBGGR12_1X12,
>  	},
>  };
> @@ -235,50 +274,50 @@ static const struct rkisp1_capture_fmt_cfg
> rkisp1_sp_fmts[] =3D { .fourcc =3D V4L2_PIX_FMT_YUYV,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_INT,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_UYVY,
>  		.uv_swap =3D 0,
>  		.yc_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_INT,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YUV422P,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV16,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV61,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV16M,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV61M,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YVU422M,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv400 */
> @@ -286,19 +325,19 @@ static const struct rkisp1_capture_fmt_cfg
> rkisp1_sp_fmts[] =3D { .fourcc =3D V4L2_PIX_FMT_GREY,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* rgb */
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_XBGR32,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_RGB888,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_RGB888,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_RGB565,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_RGB565,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_RGB565,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>  	},
>  	/* yuv420 */
> @@ -306,37 +345,37 @@ static const struct rkisp1_capture_fmt_cfg
> rkisp1_sp_fmts[] =3D { .fourcc =3D V4L2_PIX_FMT_NV21,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV21M,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_NV12M,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_SPLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YUV420,
>  		.uv_swap =3D 0,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	}, {
>  		.fourcc =3D V4L2_PIX_FMT_YVU420,
>  		.uv_swap =3D 1,
>  		.write_format =3D RKISP1_MI_CTRL_SP_WRITE_PLA,
> -		.output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
> +		.output_format_sp =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV420,
>  		.mbus =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
>  	},
>  };
> @@ -484,10 +523,12 @@ static void rkisp1_mp_config(struct rkisp1_capture
> *cap) */
>  	if (rkisp1_has_feature(rkisp1, MAIN_STRIDE)) {
>  		reg =3D rkisp1_read(rkisp1,=20
RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
> -		if (cap->pix.cfg->yc_swap)
> +		if (cap->pix.cfg->yc_swap || cap->pix.cfg->byte_swap)
>  			reg |=3D=20
RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
>  		else
>  			reg &=3D=20
~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
> +
> +		reg |=3D RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_LSB_ALIGNMENT;
>  		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT,=20
reg);
>  	}
>=20
> @@ -554,7 +595,7 @@ static void rkisp1_sp_config(struct rkisp1_capture *c=
ap)
> mi_ctrl &=3D ~RKISP1_MI_CTRL_SP_FMT_MASK;
>  	mi_ctrl |=3D cap->pix.cfg->write_format |
>  		   RKISP1_MI_CTRL_SP_INPUT_YUV422 |
> -		   cap->pix.cfg->output_format |
> +		   cap->pix.cfg->output_format_sp |
>  		   RKISP1_CIF_MI_SP_AUTOUPDATE_ENABLE;
>  	rkisp1_write(rkisp1, RKISP1_CIF_MI_CTRL, mi_ctrl);
>  }
> @@ -946,6 +987,7 @@ static void rkisp1_cap_stream_enable(struct
> rkisp1_capture *cap) struct rkisp1_device *rkisp1 =3D cap->rkisp1;
>  	struct rkisp1_capture *other =3D &rkisp1->capture_devs[cap->id ^ 1];
>  	bool has_self_path =3D rkisp1_has_feature(rkisp1, SELF_PATH);
> +	u32 reg;
>=20
>  	cap->ops->set_data_path(cap);
>  	cap->ops->config(cap);
> @@ -965,8 +1007,13 @@ static void rkisp1_cap_stream_enable(struct
> rkisp1_capture *cap) */
>  	if (!has_self_path || !other->is_streaming) {
>  		/* force cfg update */
> -		rkisp1_write(rkisp1, RKISP1_CIF_MI_INIT,
> -			     RKISP1_CIF_MI_INIT_SOFT_UPD);
> +		reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_INIT);
> +
> +		if (rkisp1_has_feature(rkisp1, MAIN_STRIDE))
> +			reg |=3D cap->pix.cfg->output_format_mp;

I don't have any documents regarding that ISP, but shouldn't you clear the=
=20
bits for output_format_mp before OR'ing the new ones on top?

Best regards,
Alexander

> +
> +		reg |=3D RKISP1_CIF_MI_INIT_SOFT_UPD;
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_INIT, reg);
>  		rkisp1_set_next_buf(cap);
>  	}
>  	spin_unlock_irq(&cap->buf.lock);
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h index
> 3b19c8411360..762243016f05 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> @@ -144,6 +144,14 @@
>  /* MI_INIT */
>  #define RKISP1_CIF_MI_INIT_SKIP				BIT(2)
>  #define RKISP1_CIF_MI_INIT_SOFT_UPD			BIT(4)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV400		(0 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV420		(1 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV422		(2 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_YUV444		(3 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW12		(4 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW8		(5 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_JPEG		(6 << 5)
> +#define RKISP1_CIF_MI_INIT_MP_OUTPUT_RAW10		(7 << 5)
>=20
>  /* MI_CTRL_SHD */
>  #define RKISP1_CIF_MI_CTRL_SHD_MP_IN_ENABLED		BIT(0)


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



