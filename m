Return-Path: <linux-kernel+bounces-136420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1589D3E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFDD1C22441
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A286B7E794;
	Tue,  9 Apr 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW2oOX5k"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11E7E0FF;
	Tue,  9 Apr 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650331; cv=none; b=ququOUQRGrwMNAvtVo7xIaHOGjjdMy9tmh4Eym0/relSRaEz0i1Np/TC6bA1BEJLUXnjT4reg8fJAQo9HRmOmAgz6lJJJUuReNNWUZfA4ukhzbFkkhaGUVT8eZbIRIcgSlv6UeQjtkD8zhEAvdNulltrv8QBLjbsSsipmSeJmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650331; c=relaxed/simple;
	bh=nZo2wMb32ghNIpPxrtuiDRI8kma8KvKCG7s1wLtjRws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J95uHZWnbUupGRHDSW1VEUDtrZZPHQYsY387FNl2RywmEbrivNKnXwH6Gssy/OcypDp/2wL6WHJPSRq3mydZ6l6R9e0I63SsybeGE4Ctf+k247OHq3WstRUEwmh0psXdJv1UuXeM9AlnrsP8utd+TqFGDAZ4NSAuUDh5nSwFBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW2oOX5k; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516a01c8490so5284624e87.1;
        Tue, 09 Apr 2024 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712650328; x=1713255128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKRbDg+hptmOInjg61uPR9fJTiU7+0+1LuZmHDST6ok=;
        b=UW2oOX5k9XbpsiOJ57iETZOULj43hA+uxGM/yW0NMXl+bprJy5SFvwHe5RpjACbekv
         HVCBfggwfYRwGwT31HU7fxCn1jUAhy+CHR24AuXKukjHJLqbCR+gzFPwQxdv1C5Pmu2y
         nOe7yWvC7hh1ULPbvE3jyfDarMFbU7WYGXMZRXrTmlPsdvRuy+74AD4x+wnsFHU6yhiz
         KfFlyuGIZU0a6AUiajaQ/ZJIrCIL+6ndJig1WbV1UzdUZXiZO19kiV4Z92Uz4K3vikFl
         iobQB3AJMGoWTvvVDKj2PyIkuE7N+q501KW9C6obNWIHvYepwBh4+glhlMzFwneoaoaY
         bkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712650328; x=1713255128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKRbDg+hptmOInjg61uPR9fJTiU7+0+1LuZmHDST6ok=;
        b=dI39/oA9EO5eWN5ubbeKWePKWt6SI+ZeZiGV7fT0lzgY6e78bBhkZhdrSlqBB/jMl/
         eUj8urZPfxsd2Ux5Zb92IjIhZzduWBejUBdQyQYI5a3q+EadE9q9G0vax25POkPcWni8
         cECyOEnfhQpJbrBsu70u2VlmYAnIJAklMHZS5lAozafwV+kwptURhcS9zDJMDSB2TLAf
         EzwH8vgbxU/ppwA8chva1Mr4RYDJWST4NfaJFJtKgcqS1a2vKOKiXsb2HvdQngzSQNS9
         dm2e7Nru3vEm28PFOBLovpv062gtlJWY+4TIzqp2YWNxK/4UKz3flJ/tQ1NYSU+s7ayu
         JD3A==
X-Forwarded-Encrypted: i=1; AJvYcCXhHMfJYsDSa61gwVEw362L/o6CWGVtYxhPGLgzqiwnbazk+Ic12Svyu64X9ANsCwGBkOdC0vKZHI8kJVVlUwWJCjsBx7fRA5j4sVoZtZJoxdJzmt7BVR4KveU8yS9LV4H/T9XYrRJ1NDs=
X-Gm-Message-State: AOJu0YyZlpcqtLOLgnxIRqMmkHOsUn9iDWy1vwLqPb/pt8DxsONWVR9l
	JsgKA5dgFSsHHTxekeg1PExHC61pjQJmYKuFH77QvAZ09bdSpLpT
X-Google-Smtp-Source: AGHT+IE1K5DTT9Bzs+eYNZ+5d4vEmMPmrMuCSIFcsczs2jcVdVG9PJoOrBo8ds8I7I9Dw7XHpPH3Dg==
X-Received: by 2002:ac2:5309:0:b0:516:c8c3:60cf with SMTP id c9-20020ac25309000000b00516c8c360cfmr672960lfh.18.1712650327694;
        Tue, 09 Apr 2024 01:12:07 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id a7-20020ac25207000000b00516c0e178fbsm1486056lfl.282.2024.04.09.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:12:07 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:12:05 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size"
 DT prop
Message-ID: <zrwlu2e2slf7g4izorqbzwahysz6a3diux6zjyfmgtkofzdpuj@cvfl4kqhzvef>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
 <20240405164112.24571-5-brnkv.i1@gmail.com>
 <SE1P216MB130327BE82553DA3F34BBF17ED072@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SE1P216MB130327BE82553DA3F34BBF17ED072@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>

Hi, Jackson

On Tue, Apr 09, 2024 at 04:50:15AM +0000, jackson.lee wrote:
> Hey Ivan
> 
> > -----Original Message-----
> > From: Ivan Bornyakov <brnkv.i1@gmail.com>
> > Sent: Saturday, April 6, 2024 1:41 AM
> > To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> > <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> > Philipp Zabel <p.zabel@pengutronix.de>; Sebastian Fricke
> > <sebastian.fricke@collabora.com>
> > Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size" DT
> > prop
> > 
> > Move excessive "sram-size" device-tree property to device match data.
> > Also change SRAM memory allocation strategy: instead of allocation exact
> > sram_size bytes, allocate all available SRAM memory up to sram_size.
> > Add placeholders wave5_vpu_dec_validate_sec_axi() and
> > wave5_vpu_enc_validate_sec_axi() for validation that allocated SRAM memory
> > is enough to decode/encode bitstream of given resolution.
> > 
> > Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> > ---
> >  .../platform/chips-media/wave5/wave5-hw.c     | 62 +++++++++++++++++--
> >  .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++---
> >  .../platform/chips-media/wave5/wave5-vpu.c    | 11 ++--
> >  3 files changed, 72 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > index cdd0a0948a94..36f2fc818013 100644
> > --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > @@ -843,6 +843,36 @@ int wave5_vpu_dec_register_framebuffer(struct
> > vpu_instance *inst, struct frame_b
> >  	return ret;
> >  }
> > 
> > +static u32 wave5_vpu_dec_validate_sec_axi(struct vpu_instance *inst) {
> > +	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
> > +	u32 bit_size = 0, ip_size = 0, lf_size = 0, ret = 0;
> 
> The bit_size, ip_size and 1f_size is always 0? If so, why are you using them ?
> 

Since I don't have documentation on Wave521, this is a placeholder for
someone who have documentation to write proper SRAM size validation,
hence TODO comment.

In the next patch "media: chips-media: wave5: support Wave515 decoder"
I added validation of SRAM usage for Wave515, for which I do have
documentation.

> 
> > +	u32 sram_size = inst->dev->sram_size;
> > +
> > +	if (!sram_size)
> > +		return 0;
> > +
> > +	/*
> > +	 * TODO: calculate bit_size, ip_size, lf_size from inst-
> > >src_fmt.width
> > +	 * and inst->codec_info->dec_info.initial_info.luma_bitdepth
> > +	 */
> > +
> > +	if (p_dec_info->sec_axi_info.use_bit_enable && sram_size >=
> > bit_size) {
> > +		ret |= BIT(0);
> > +		sram_size -= bit_size;
> > +	}
> > +
> > +	if (p_dec_info->sec_axi_info.use_ip_enable && sram_size >= ip_size)
> > {
> > +		ret |= BIT(9);
> > +		sram_size -= ip_size;
> > +	}
> > +
> > +	if (p_dec_info->sec_axi_info.use_lf_row_enable && sram_size >=
> > lf_size)
> > +		ret |= BIT(15);
> > +
> > +	return ret;
> > +}
> > +
> >  int wave5_vpu_decode(struct vpu_instance *inst, u32 *fail_res)  {
> >  	u32 reg_val;
> > @@ -855,9 +885,7 @@ int wave5_vpu_decode(struct vpu_instance *inst, u32
> > *fail_res)
> >  	vpu_write_reg(inst->dev, W5_BS_OPTION,
> > get_bitstream_options(p_dec_info));
> > 
> >  	/* secondary AXI */
> > -	reg_val = p_dec_info->sec_axi_info.use_bit_enable |
> > -		(p_dec_info->sec_axi_info.use_ip_enable << 9) |
> > -		(p_dec_info->sec_axi_info.use_lf_row_enable << 15);
> > +	reg_val = wave5_vpu_dec_validate_sec_axi(inst);
> >  	vpu_write_reg(inst->dev, W5_USE_SEC_AXI, reg_val);
> > 
> >  	/* set attributes of user buffer */
> > @@ -1938,6 +1966,31 @@ int wave5_vpu_enc_register_framebuffer(struct
> > device *dev, struct vpu_instance *
> >  	return ret;
> >  }
> > 
> > +static u32 wave5_vpu_enc_validate_sec_axi(struct vpu_instance *inst) {
> > +	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
> > +	u32 rdo_size = 0, lf_size = 0, ret = 0;
> 
> The rdo_size and 1f_size is always 0? If so, why are you using them ?
>

Same as above. It is a placeholder for someone else to implement these.

> > +	u32 sram_size = inst->dev->sram_size;
> > +
> > +	if (!sram_size)
> > +		return 0;
> > +
> > +	/*
> > +	 * TODO: calculate rdo_size and lf_size from inst->src_fmt.width
> > and
> > +	 * inst->codec_info-
> > >enc_info.open_param.wave_param.internal_bit_depth
> > +	 */
> > +
> > +	if (p_enc_info->sec_axi_info.use_enc_rdo_enable && sram_size >=
> > rdo_size) {
> > +		ret |= BIT(11);
> > +		sram_size -= rdo_size;
> > +	}
> > +
> > +	if (p_enc_info->sec_axi_info.use_enc_lf_enable && sram_size >=
> > lf_size)
> > +		ret |= BIT(15);
> > +
> > +	return ret;
> > +}
> > +
> >  int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param *option,
> > u32 *fail_res)  {
> >  	u32 src_frame_format;
> > @@ -1959,8 +2012,7 @@ int wave5_vpu_encode(struct vpu_instance *inst,
> > struct enc_param *option, u32 *f
> > 
> >  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_AXI_SEL,
> > DEFAULT_SRC_AXI);
> >  	/* secondary AXI */
> > -	reg_val = (p_enc_info->sec_axi_info.use_enc_rdo_enable << 11) |
> > -		(p_enc_info->sec_axi_info.use_enc_lf_enable << 15);
> > +	reg_val = wave5_vpu_enc_validate_sec_axi(inst);
> >  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_USE_SEC_AXI, reg_val);
> > 
> >  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_REPORT_PARAM, 0); diff --
> > git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > index 3809f70bc0b4..556de2f043fe 100644
> > --- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> 
> 
> The below code is not based on the current upstream code. Where did you get the original code ?
> 

What do you mean? This patch series is based on the latest linux-next.

> > @@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> > *vpu_dev, struct vpu_buf *array,  void wave5_vdi_allocate_sram(struct
> > vpu_device *vpu_dev)  {
> >  	struct vpu_buf *vb = &vpu_dev->sram_buf;
> > +	dma_addr_t daddr;
> > +	void *vaddr;
> > +	size_t size;
> > 
> > -	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> > +	if (!vpu_dev->sram_pool || vb->vaddr)
> >  		return;
> > 
> > -	if (!vb->vaddr) {
> > -		vb->size = vpu_dev->sram_size;
> > -		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> > -					       &vb->daddr);
> > -		if (!vb->vaddr)
> > -			vb->size = 0;
> > +	size = min_t(size_t, vpu_dev->sram_size, gen_pool_avail(vpu_dev-
> > >sram_pool));
> > +	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> > +	if (vaddr) {
> > +		vb->vaddr = vaddr;
> > +		vb->daddr = daddr;
> > +		vb->size = size;
> >  	}
> > 
> >  	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> > 0x%p\n", @@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
> > *vpu_dev)
> >  	if (!vb->size || !vb->vaddr)
> >  		return;
> > 
> > -	if (vb->vaddr)
> > -		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> > -			      vb->size);
> > +	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> > >size);
> > 
> >  	memset(vb, 0, sizeof(*vb));
> >  }
> > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > index 1e631da58e15..9e93969ab6db 100644
> > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > @@ -25,6 +25,7 @@
> >  struct wave5_match_data {
> >  	int flags;
> >  	const char *fw_name;
> > +	u32 sram_size;
> >  };
> > 
> >  int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int
> > timeout) @@ -177,17 +178,12 @@ static int wave5_vpu_probe(struct
> > platform_device *pdev)
> >  		goto err_reset_assert;
> >  	}
> > 
> > -	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> > -				   &dev->sram_size);
> > -	if (ret) {
> > -		dev_warn(&pdev->dev, "sram-size not found\n");
> > -		dev->sram_size = 0;
> > -	}
> > -
> >  	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> >  	if (!dev->sram_pool)
> >  		dev_warn(&pdev->dev, "sram node not found\n");
> > 
> > +	dev->sram_size = match_data->sram_size;
> > +
> >  	dev->product_code = wave5_vdi_read_register(dev,
> > VPU_PRODUCT_CODE_REGISTER);
> >  	ret = wave5_vdi_init(&pdev->dev);
> >  	if (ret < 0) {
> > @@ -281,6 +277,7 @@ static void wave5_vpu_remove(struct platform_device
> > *pdev)  static const struct wave5_match_data ti_wave521c_data = {
> >  	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
> >  	.fw_name = "cnm/wave521c_k3_codec_fw.bin",
> > +	.sram_size = (64 * 1024),
> >  };
> > 
> >  static const struct of_device_id wave5_dt_ids[] = {
> > --
> > 2.44.0
> 

