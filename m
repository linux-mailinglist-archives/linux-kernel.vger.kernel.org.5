Return-Path: <linux-kernel+bounces-132737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F1899973
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FEF282190
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973815FD1F;
	Fri,  5 Apr 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5RUoa4u7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851115FCE2;
	Fri,  5 Apr 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309394; cv=none; b=HDZzeVuMzou43LzFfJyO8zpmAV8Os8lxrkKhXjEkjMV3nKGURejou4hzNuwu8SFknvUTSo+3UVD1haW8wfU6uX7cAcvTgOBH7hs6IeM17y59Jpa2EnSwKziGd7ceZ43xB1Xu4S5jcH2Rt46OgBYmS0FZANMAXsiDeJsLsAm04k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309394; c=relaxed/simple;
	bh=1XOKZGXshsQ///KoTh0XHfCQcdhzM+EgFmJYlctb1iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv7hVfWFjNkwnV8DDATJK5wxSBZtdK9nWaJWCawa02Jj+5ilCad7UEZqSyIwQ27zqs/iFK35bi095EazChrxzL44MV3wsSaMhbQ/NlGRvXKaTE2L7SCK15AsCAf/z085zPFTGHC+21AHT7WdjPvVQwWl4PxL7ipYSY8JaMLxTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5RUoa4u7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712309391;
	bh=1XOKZGXshsQ///KoTh0XHfCQcdhzM+EgFmJYlctb1iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5RUoa4u77q8qb4bYxjP5FFYd8uzH/rCVesLHzZoDTFNxy2tZoPZ8eGkUr+4RUeO7C
	 QSQMpQMh87gUg88C9ZU8X9EQTOupiPPVH5s6yAz1k0wQFB+EbDiIfwQAlrkAhphGP1
	 vLZg9o0GaeDYcfuEdNFI3LqGv1I9oYrgqAQ9kg3P4EeA1KsbRMDcHn4yHsnEIPTIWJ
	 VcCb2dajWYbJFVxRp1dMSv/X4BgJf0LrIYRTKXWSgkkPn27lCxeSTCaYhirUafeiGh
	 lSp1iyZFIFp3klvcjneUG8h21mP8tDgWystHbsBp0mKn0vqUA844nt3qwlfvCXKbh5
	 oWwV7lC1aZf5w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4152B3781116;
	Fri,  5 Apr 2024 09:29:51 +0000 (UTC)
Date: Fri, 5 Apr 2024 11:29:50 +0200
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] media: chips-media: wave5: separate irq setup
 routine
Message-ID: <20240405092950.wt5cvhvhiujicc5h@basti-XPS-13-9310>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-4-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325064102.9278-4-brnkv.i1@gmail.com>

Hey Ivan,

On 25.03.2024 09:40, Ivan Bornyakov wrote:
>Separate interrupts setup routine to reduce code duplication. Also

s/Separate interrupts setup routine/Implement a separate setup routine for interrupts/

>enable interrupts based on vpu_attr->support_encoders and
>vpu_attr->support_decoders fields to facilitate other Wave5xx IPs
>support, because not all of them are both encoders and decoders.

s/other Wave5xx IPs support/support for other Wave5xx IPs/

The rest looks good to me.

Greetings,
Sebastian

>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../platform/chips-media/wave5/wave5-hw.c     | 53 +++++++++----------
> 1 file changed, 24 insertions(+), 29 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>index 2d82791f575e..cdd0a0948a94 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>@@ -299,6 +299,27 @@ static int wave5_send_query(struct vpu_device *vpu_dev, struct vpu_instance *ins
> 	return wave5_vpu_firmware_command_queue_error_check(vpu_dev, NULL);
> }
>
>+static void setup_wave5_interrupts(struct vpu_device *vpu_dev)
>+{
>+	u32 reg_val = 0;
>+
>+	if (vpu_dev->attr.support_encoders) {
>+		/* Encoder interrupt */
>+		reg_val |= BIT(INT_WAVE5_ENC_SET_PARAM);
>+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
>+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
>+	}
>+
>+	if (vpu_dev->attr.support_decoders) {
>+		/* Decoder interrupt */
>+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
>+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
>+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
>+	}
>+
>+	return vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
>+}
>+
> static int setup_wave5_properties(struct device *dev)
> {
> 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
>@@ -340,6 +361,8 @@ static int setup_wave5_properties(struct device *dev)
> 	p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE, hw_config_def0);
> 	p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE, hw_config_def0);
>
>+	setup_wave5_interrupts(vpu_dev);
>+
> 	return 0;
> }
>
>@@ -417,16 +440,6 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
> 	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
> 	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>
>-	/* Encoder interrupt */
>-	reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
>-	reg_val |= BIT(INT_WAVE5_ENC_PIC);
>-	reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
>-	/* Decoder interrupt */
>-	reg_val |= BIT(INT_WAVE5_INIT_SEQ);
>-	reg_val |= BIT(INT_WAVE5_DEC_PIC);
>-	reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
>-	vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
>-
> 	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
> 		reg_val = ((WAVE5_PROC_AXI_ID << 28) |
>@@ -1034,16 +1047,6 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
> 		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
> 		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>
>-		/* Encoder interrupt */
>-		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
>-		reg_val |= BIT(INT_WAVE5_ENC_PIC);
>-		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
>-		/* Decoder interrupt */
>-		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
>-		reg_val |= BIT(INT_WAVE5_DEC_PIC);
>-		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
>-		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
>-
> 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
> 			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
>@@ -1134,15 +1137,7 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
> 		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
> 		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>
>-		/* Encoder interrupt */
>-		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
>-		reg_val |= BIT(INT_WAVE5_ENC_PIC);
>-		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
>-		/* Decoder interrupt */
>-		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
>-		reg_val |= BIT(INT_WAVE5_DEC_PIC);
>-		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
>-		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
>+		setup_wave5_interrupts(vpu_dev);
>
> 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
>-- 
>2.44.0
>
>

