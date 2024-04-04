Return-Path: <linux-kernel+bounces-131072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D3B8982BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D40728BA73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2B75F850;
	Thu,  4 Apr 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3uw+9VbY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34225CDD0;
	Thu,  4 Apr 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217760; cv=none; b=TuqrOl1R2iz7AqpUR+91UmL7YAFifOS7W+HHfAUqP0s6oo/80zLNjK+JraiGH3OmoXgSCO5UbEaKJQyy6vBY5UzeHEw4T//Q64nZnYYmvx/vpFdfCIkai9oqw4J0yfDdbYSTAAJ1jPGm1PY6QtpzwaV+Pd4zYVy4YC8Ir44U45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217760; c=relaxed/simple;
	bh=yN2xAs2RcFv+rKH6Q+v2gZ1VuhrWI7CZM+57SiQ7epo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRuN/4PFDwrQIFJtwKwR8xGLK3h9i8Mrejl1+XrjiBvrzrQPLQQMNxl45rTTAN+LfowhoVXyoBierykE9WRgFt/9OuEMqUA7N1xuZnkNGljTPk6F42eT+11k1XhH+NA9XjmMZHGAu1OQM9EWVF0fsv0VkPak6X5y5FbOAvMvW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3uw+9VbY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712217757;
	bh=yN2xAs2RcFv+rKH6Q+v2gZ1VuhrWI7CZM+57SiQ7epo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3uw+9VbY5ahs/Qf7XZaciO/K9QLuSzDY+NB5HnLPS3mxJT3Fe5KuP6Z5ZB5f66ZBl
	 ZT9sNhTkUTxrSkC59QC6gtOzp63iE/mgLRMxBdLgqC8pKzGtMsst5lO9zlxRj5B1pl
	 3dSmCl4zdUo0yEup6dFZwoaprBYDnmlWA58sxQ+Unye8oLvTikgTfNFiEI4kqIQ3ym
	 Q8swqcrm4wZImtWaux0MJfaqEhdM2VS5Q5RUFWtL+1lxkMS8dzvcUeJx8sanzeZ5SS
	 HmzopcnTDKzV67wbFnRshW3DnynfRCaU8z/gPBf2kU23TNLk1kQc2M1g4Iy+hsAd4w
	 R+kuKkr/9+qQQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E1485378209A;
	Thu,  4 Apr 2024 08:02:36 +0000 (UTC)
Date: Thu, 4 Apr 2024 10:02:35 +0200
From: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jackson.lee" <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Message-ID: <20240404080235.kab6taeimsxpjtr3@basti-XPS-13-9310>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
 <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <7lro7ryzjajpzvkjdj5cndkmzmjkqvhts6dmer4pkkt7dluiii@wp7ael4ae7jd>
 <SL2P216MB1246597E5880A5A590CE1DB2FB3F2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <SL2P216MB1246597E5880A5A590CE1DB2FB3F2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>

Hey Nas,

On 01.04.2024 09:28, Nas Chung wrote:
>Hi, Sebastian.
>
>>-----Original Message-----
>>From: Ivan Bornyakov <brnkv.i1@gmail.com>
>>Sent: Thursday, March 28, 2024 8:36 PM
>>To: Nas Chung <nas.chung@chipsnmedia.com>
>>Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>>jackson.lee <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
>><mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
>>Subject: Re: RE: RE: [PATCH v2 4/5] media: chips-media: wave5: drop
>>"sram-size" DT prop
>>
>>On Thu, Mar 28, 2024 at 10:16:53AM +0000, Nas Chung wrote:
>>> Hi, Ivan.
>>>
>>> >-----Original Message-----
>>> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
>>> >Sent: Wednesday, March 27, 2024 9:27 PM
>>> >To: Nas Chung <nas.chung@chipsnmedia.com>
>>> >Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> >jackson.lee <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
>>> ><mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
>>> >Subject: Re: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-
>>> >size" DT prop
>>> >
>>> >On Wed, Mar 27, 2024 at 10:27:19AM +0000, Nas Chung wrote:
>>> >> Hi, Ivan.
>>> >>
>>> >> >-----Original Message-----
>>> >> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
>>> >> >Sent: Monday, March 25, 2024 3:41 PM
>>> >> >To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
>>> >> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
>>> ><mchehab@kernel.org>;
>>> >> >Philipp Zabel <p.zabel@pengutronix.de>
>>> >> >Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-
>>media@vger.kernel.org;
>>> >> >linux-kernel@vger.kernel.org
>>> >> >Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size"
>>DT
>>> >> >prop
>>> >> >
>>> >> >Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
>>> >> >excessive "sram-size" device-tree property as genalloc is already
>>able
>>> >> >to determine available memory.
>>> >> >
>>> >> >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>>> >> >---
>>> >> > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++------
>>---
>>> >> > .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
>>> >> > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
>>> >> > .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
>>> >> > 4 files changed, 13 insertions(+), 18 deletions(-)
>>> >> >
>>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>>> >> >index 3809f70bc0b4..a63fffed55e9 100644
>>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>>> >> >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct
>>vpu_device
>>> >> >*vpu_dev, struct vpu_buf *array,
>>> >> > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
>>> >> > {
>>> >> > 	struct vpu_buf *vb = &vpu_dev->sram_buf;
>>> >> >+	dma_addr_t daddr;
>>> >> >+	void *vaddr;
>>> >> >+	size_t size;
>>> >> >
>>> >> >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
>>> >> >+	if (!vpu_dev->sram_pool || vb->vaddr)
>>> >> > 		return;
>>> >> >
>>> >> >-	if (!vb->vaddr) {
>>> >> >-		vb->size = vpu_dev->sram_size;
>>> >> >-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb-
>>>size,
>>> >> >-					       &vb->daddr);
>>> >> >-		if (!vb->vaddr)
>>> >> >-			vb->size = 0;
>>> >> >+	size = min_t(size_t, WAVE5_MAX_SRAM_SIZE,
>>gen_pool_avail(vpu_dev-
>>> >> >>sram_pool));
>>> >> >+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
>>> >> >+	if (vaddr) {
>>> >> >+		vb->vaddr = vaddr;
>>> >> >+		vb->daddr = daddr;
>>> >> >+		vb->size = size;
>>> >> > 	}
>>> >> >
>>> >> > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu,
>>vaddr:
>>> >> >0x%p\n",
>>> >> >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
>>> >*vpu_dev)
>>> >> > 	if (!vb->size || !vb->vaddr)
>>> >> > 		return;
>>> >> >
>>> >> >-	if (vb->vaddr)
>>> >> >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb-
>>>vaddr,
>>> >> >-			      vb->size);
>>> >> >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
>>vb-
>>> >> >>size);
>>> >> >
>>> >> > 	memset(vb, 0, sizeof(*vb));
>>> >> > }
>>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> >> >index 1e631da58e15..2a972cddf4a6 100644
>>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>>> >> >@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct
>>platform_device
>>> >> >*pdev)
>>> >> > 		goto err_reset_assert;
>>> >> > 	}
>>> >> >
>>> >> >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
>>> >> >-				   &dev->sram_size);
>>> >> >-	if (ret) {
>>> >> >-		dev_warn(&pdev->dev, "sram-size not found\n");
>>> >> >-		dev->sram_size = 0;
>>> >> >-	}
>>> >> >-
>>> >> > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram",
>>0);
>>> >> > 	if (!dev->sram_pool)
>>> >> > 		dev_warn(&pdev->dev, "sram node not found\n");
>>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-
>>vpuapi.h
>>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> >> >index da530fd98964..975d96b22191 100644
>>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>>> >> >@@ -750,7 +750,6 @@ struct vpu_device {
>>> >> > 	struct vpu_attr attr;
>>> >> > 	struct vpu_buf common_mem;
>>> >> > 	u32 last_performance_cycles;
>>> >> >-	u32 sram_size;
>>> >> > 	struct gen_pool *sram_pool;
>>> >> > 	struct vpu_buf sram_buf;
>>> >> > 	void __iomem *vdb_register;
>>> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-
>>> >vpuconfig.h
>>> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>>> >> >index d9751eedb0f9..9d99afb78c89 100644
>>> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>>> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>>> >> >@@ -28,6 +28,8 @@
>>> >> > #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K,
>>> >AVC
>>> >> >40K
>>> >> > #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
>>> >> >
>>> >> >+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
>>> >>
>>> >> WAVE521 can support 8K stream decoding/encoding.
>>> >> So, I suggest the MAX_SRAME_SIZE to 128 * 1024 (128KB).
>>> >>
>>> >> And, Current driver always enable sec_axi_info option if sram buffer
>>is
>>> >allocated.
>>> >> But, we have to enable/disable the sec_axi_info option after
>>checking
>>> >the allocated sram size is enough to decode/encode current bitstream
>>> >resolution.
>>> >
>>> >Do we really? As an experiment I tried to provide to Wave515 1KB of
>>SRAM
>>> >memory and decoded 4k sample file was fine...
>>> >
>>>
>>> You can think It seems like driver works fine.
>>> But, This is not the behavior we expect.
>>> There is a possibility that unexpected problems may occur.
>>>
>>
>>Ok, then we either
>>
>> 1) don't try to allocate any availible SRAM memory up to
>>    match_data->sram_size, but allocate exact match_data->sram_size
>>
>>or
>>
>> 2) allocate any available SRAM memory up to match_data->sram_size, but
>>    check for allocated size before writing to registers W5_USE_SEC_AXI
>>    and W5_CMD_ENC_PIC_USE_SEC_AXI
>>
>>With second variant I won't be able to add said check for Wave521, as I
>>don't know its memory requirements.
>>
>>Also would this check be SoC specific or would it be common for any SoC
>>with same Wave5xx IP?
>>
>>> >> Wave5 can enable/disable the sec_axi_info option for each instance.
>>> >>
>>> >> How about handle sram-size through match_data ?
>>> >> I can find some drivers which use match_data to configure the sram
>>size.
>
>I proposed using match_data to allocate different sram size for each device.
>Do you think this is a reasonable approach ?

As discussed here:
https://patchwork.linuxtv.org/project/linux-media/patch/20240201184238.2542695-1-b-brnich@ti.com/

To quote Brandon Brnich from TI:

If static SRAM allocation is the correct method to go, then this series
can be ignored and I will add section in device tree and remove check
for parameter in driver as that will now be a bug.

I would like to adhere to that.

>
>Thanks.
>Nas.

Greetings,
Sebastian

>
>>> >>
>>> >> We can use current "ti,k3-j721s2-wave521c" device as a 4K supported
>>> >device.
>>> >> - .sram_size = (64 * 1024);
>>> >> Driver just allocate the sram-size for max supported resolution of
>>each
>>> >device, and we don't need to check the sram-size is enough or not.
>>> >>
>>> >> Thanks.
>>> >> Nas.
>>> >>
>>> >> >+
>>> >> > #define MAX_NUM_INSTANCE                32
>>> >> >
>>> >> > #define W5_MIN_ENC_PIC_WIDTH            256
>>> >> >--
>>> >> >2.44.0
>>> >>

