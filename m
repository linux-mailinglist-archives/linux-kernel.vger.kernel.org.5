Return-Path: <linux-kernel+bounces-68448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DC857A54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8211B24DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114854F204;
	Fri, 16 Feb 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AhFboV3T"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3948787;
	Fri, 16 Feb 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079511; cv=none; b=gXXxVYUjN8+V3YkG5nZvoQBTXr2Nb/ZCrPAUswBWF1K/rpp8yflbqot0zKXN9RXLgQ0xXyR922w5xEtZHiwjUBNxC22o1D3lUW8f1vPzeH0N5aK4vipREK8GlTXPj3sj0LM69Ll4qMoga/eP3FTdI33mOEuP2LsxU6KTXhTWPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079511; c=relaxed/simple;
	bh=csqlvpw2z/3yyzJxjjS9Fpo71nKwxnAJ+b++04+50pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArBP6ExZ3AbhPMX2lwJDxNHNdaLT6vgxCwn5q/kvStNzVw5zA9J4491QNib0E4MJ+bFIP1JgFNvQ8nkXcER6djBlYzGzM9uUrQepHdF2iZGVVn5HVMs4loNdN1P3YZvSHV8AZf37l4J4h6CR+Yls1vrbLLw4SR98gWxVOuZY7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AhFboV3T; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708079508; x=1739615508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WOmoaQaLsDmrtvGLYushRM/n3wRCUbdTRdZi3Ojwz58=;
  b=AhFboV3T/PVE5Q0xAgLw0tTQF8tuKNIEWAU2jIkgz+n3kyXhnLGjx4pl
   UX+z5cNUwBSEUrNtlBC6O1X8MNdFSX5+jC44OLBlwEzT2/TNf/VvsDrz5
   b+jR3lwPFonYyOW9QJ/ZTtnf/i9pWJKRZNGM7i0i4AFR8jwGUtxLesW3z
   4CYffV+67nc1oF1DyV+XYvMmZOpAoiBqgYrWfNYZk9+ebc3wUw2Vs6RAV
   mjMmliD8JhI9mua5dYDBXZbxFjGApVEHlLSeHv4Tw/jm8qMThduIEmDMP
   LDBNKNJEonp8S8NQ19jPFsg5SK6kXhfHVM/GtGJTOm7SVsRhQzJKRiJ69
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="35443453"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2024 11:31:45 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 22D87280075;
	Fri, 16 Feb 2024 11:31:45 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Paul Elder <paul.elder@ideasonboard.com>
Cc: kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com, aford173@gmail.com, Paul Elder <paul.elder@ideasonboard.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dafna Hirschfeld <dafna@fastmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 08/12] media: rkisp1: Support i.MX8MP's 34-bit DMA
Date: Fri, 16 Feb 2024 11:31:46 +0100
Message-ID: <1884916.CQOukoFCf9@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240216095458.2919694-9-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com> <20240216095458.2919694-9-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Paul,

thanks for the update.

Am Freitag, 16. Februar 2024, 10:54:54 CET schrieb Paul Elder:
> On the ISP that is integrated in the i.MX8MP, DMA addresses have been
> extended to 34 bits, with the 32 MSBs stored in the DMA address
> registers and the 2 LSBs set to 0.
>=20
> To support this:
> - Shift the addresses to the right by 2 when writing to registers
> - Set the dma mask to 34 bits
> - Use dma_addr_t instead of u32 when storing the addresses
>=20
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes since v5:
>=20
> - Improve the commit message
>=20
> Changes since v4:
>=20
> - Squash in fix from Tomi:
>   -
> https://gitlab.com/ideasonboard/nxp/linux/-/commit/d6477fe673b1c0d05d12ae=
21
> d8db9a03b07e7fea
>=20
> Changes since v2:
>=20
> - Document the RKISP1_FEATURE_DMA_34BIT bit
> - Use the rkisp1_has_feature() macro
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 20 ++++++++++---------
>  .../platform/rockchip/rkisp1/rkisp1-common.h  |  4 +++-
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  8 ++++++++
>  3 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c index
> ca95f62822fa..1ee7639c42b7 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -648,11 +648,13 @@ static void rkisp1_dummy_buf_destroy(struct
> rkisp1_capture *cap)
>=20
>  static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
>  {
> +	u8 shift =3D rkisp1_has_feature(cap->rkisp1, DMA_34BIT) ? 2 : 0;
> +
>  	cap->buf.curr =3D cap->buf.next;
>  	cap->buf.next =3D NULL;
>=20
>  	if (!list_empty(&cap->buf.queue)) {
> -		u32 *buff_addr;
> +		dma_addr_t *buff_addr;
>=20
>  		cap->buf.next =3D list_first_entry(&cap->buf.queue, struct=20
rkisp1_buffer,
> queue); list_del(&cap->buf.next->queue);
> @@ -660,7 +662,7 @@ static void rkisp1_set_next_buf(struct rkisp1_capture
> *cap) buff_addr =3D cap->buf.next->buff_addr;
>=20
>  		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
> -			     buff_addr[RKISP1_PLANE_Y]);
> +			     buff_addr[RKISP1_PLANE_Y] >> shift);
>  		/*
>  		 * In order to support grey format we capture
>  		 * YUV422 planar format from the camera and
> @@ -669,17 +671,17 @@ static void rkisp1_set_next_buf(struct rkisp1_captu=
re
> *cap) if (cap->pix.cfg->fourcc =3D=3D V4L2_PIX_FMT_GREY) {
>  			rkisp1_write(cap->rkisp1,
>  				     cap->config->mi.cb_base_ad_init,
> -				     cap->buf.dummy.dma_addr);
> +				     cap->buf.dummy.dma_addr >>=20
shift);
>  			rkisp1_write(cap->rkisp1,
>  				     cap->config->mi.cr_base_ad_init,
> -				     cap->buf.dummy.dma_addr);
> +				     cap->buf.dummy.dma_addr >>=20
shift);
>  		} else {
>  			rkisp1_write(cap->rkisp1,
>  				     cap->config->mi.cb_base_ad_init,
> -				     buff_addr[RKISP1_PLANE_CB]);
> +				     buff_addr[RKISP1_PLANE_CB] >>=20
shift);
>  			rkisp1_write(cap->rkisp1,
>  				     cap->config->mi.cr_base_ad_init,
> -				     buff_addr[RKISP1_PLANE_CR]);
> +				     buff_addr[RKISP1_PLANE_CR] >>=20
shift);
>  		}
>  	} else {
>  		/*
> @@ -687,11 +689,11 @@ static void rkisp1_set_next_buf(struct rkisp1_captu=
re
> *cap) * throw data if there is no available buffer.
>  		 */
>  		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
> -			     cap->buf.dummy.dma_addr);
> +			     cap->buf.dummy.dma_addr >> shift);
>  		rkisp1_write(cap->rkisp1, cap->config->mi.cb_base_ad_init,
> -			     cap->buf.dummy.dma_addr);
> +			     cap->buf.dummy.dma_addr >> shift);
>  		rkisp1_write(cap->rkisp1, cap->config->mi.cr_base_ad_init,
> -			     cap->buf.dummy.dma_addr);
> +			     cap->buf.dummy.dma_addr >> shift);
>  	}
>=20
>  	/* Set plane offsets */
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h index
> 69940014d597..26573f6ae575 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -114,6 +114,7 @@ enum rkisp1_isp_pad {
>   * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on =
the
> main path * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
>   * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the
> resizer input + * @RKISP1_FEATURE_DMA_34BIT: The ISP uses 34-bit DMA
> addresses
>   *
>   * The ISP features are stored in a bitmask in &rkisp1_info.features and
> allow * the driver to implement support for features present in some ISP
> versions @@ -124,6 +125,7 @@ enum rkisp1_feature {
>  	RKISP1_FEATURE_MAIN_STRIDE =3D BIT(1),
>  	RKISP1_FEATURE_SELF_PATH =3D BIT(2),
>  	RKISP1_FEATURE_DUAL_CROP =3D BIT(3),
> +	RKISP1_FEATURE_DMA_34BIT =3D BIT(4),
>  };
>=20
>  #define rkisp1_has_feature(rkisp1, feature) \
> @@ -239,7 +241,7 @@ struct rkisp1_vdev_node {
>  struct rkisp1_buffer {
>  	struct vb2_v4l2_buffer vb;
>  	struct list_head queue;
> -	u32 buff_addr[VIDEO_MAX_PLANES];
> +	dma_addr_t buff_addr[VIDEO_MAX_PLANES];
>  };
>=20
>  /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c index
> d0a3a13d9dd7..54a62487a4e8 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -552,6 +552,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct rkisp1_device *rkisp1;
>  	struct v4l2_device *v4l2_dev;
> +	unsigned long long dma_mask;

The signature for dma_set_mask_and_coherent() uses u64 for the mask, so I=20
would use the same type here as well.

Best regards,
Alexander

>  	unsigned int i;
>  	int ret, irq;
>  	u32 cif_id;
> @@ -566,6 +567,13 @@ static int rkisp1_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, rkisp1);
>  	rkisp1->dev =3D dev;
>=20
> +	dma_mask =3D rkisp1_has_feature(rkisp1, DMA_34BIT) ? DMA_BIT_MASK(34)=20
:
> +							  =20
DMA_BIT_MASK(32);
> +
> +	ret =3D dma_set_mask_and_coherent(dev, dma_mask);
> +	if (ret)
> +		return ret;
> +
>  	mutex_init(&rkisp1->stream_lock);
>=20
>  	rkisp1->base_addr =3D devm_platform_ioremap_resource(pdev, 0);


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



