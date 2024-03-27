Return-Path: <linux-kernel+bounces-121230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87988E432
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535711C2B957
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4018D88D;
	Wed, 27 Mar 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+ljkFOK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8118C9F3;
	Wed, 27 Mar 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542411; cv=none; b=mbkNpELU7LXEbj8c3+8UEhTHZDH+rTRp+vUky9edzv+2dCp5SEIZ4HO6+yJZM5AMi9Js5xegIVQOF+rJqyuus7g/x99kAr/tZ/KuBuPtGZ0ikaZ/o/8m48uQpllUdgPmvtSNP287c/82biU9umNXHN9J194xpx1UkB6TdW77RoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542411; c=relaxed/simple;
	bh=DVg52Ew3U5j5zZL1/z9QRNQpCoKZZHYMPcKlLTQF/xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad+Ezw/gseBHJc1qjV264ODnawy3L/16Ib9o6muCPBY6sjrGnr/x+3zOqUx12pzqCbrkaxONXamGA0eKmcjqY0/CT/xtFazUaYnygacpPglisf7ZYdmFMhpW0i8Kn0zwepxqY8jQCZOC98gU5hlrn2oYZbb1FVcuiKhp6Oyt2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+ljkFOK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a86daf09so5007269e87.3;
        Wed, 27 Mar 2024 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711542407; x=1712147207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZi1ihD7jb4n7LHpF8XtHp/FApS7UcJ7/s08szlYQpw=;
        b=Q+ljkFOKszbgy/HvVevVEL6cJ3W+hyrmsgNqh6WOTRqvYYPWHAeKK9C7s8V3mKd8jE
         Ua991EB4HKZWzCcHohbJhwV7U4OuexW6rxJNUF3twZ7h3Fwzp1Bh4SszV0KMrVD16PVD
         CmwfpSqyo+EtQBWl0OwoI9xonRGP/f8Tzx/fH3Gsyq5BgmVl9KyiZoKJtveDnbwhQ/C7
         GZQ3gbUncg/XdvacE4wXkEurZcXMNN80qBdHY04g60JZHHWRMmVjYQthQxKdT/kzKpoe
         sbUDMSewvPXQW0Vr/fO5eNCDWkr4kE2wB5OQecOu4hdkhV+wRj5ZsflKr8947tmisSnu
         +yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711542407; x=1712147207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZi1ihD7jb4n7LHpF8XtHp/FApS7UcJ7/s08szlYQpw=;
        b=vMLJHfNFEqjAXT3k5fEUlReVlxtqYDt0eQiMoapq0mp4u6ZyRS/Dg4VxKbRurSGWHM
         wUdwylAt1/ApX7kcvRH1/4rjkbAToFXk/sKdedy2EYleRnmsi+4a4hh0E6K199V5+kPy
         9Ku38QcAaXUHCaXbnDoN9ncq3v5MttphHHBwGWNAEec7yvEeqSGsmkPm57KzPNITgcTF
         2gR/hJcDs8DH0W3UGdtuqhoKH+q8MRuz3Ns27RBMKi6G8c2tY9bV+y8wvfK4ll4YIzdp
         iqy9E4ls6XkqKs6gVHQZlxPHJki1FN65QiKh0+7HQMG2961c3hj2OLJTU7KZFoaSbeSN
         QfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsgdM/LSKkuH+1tVJl4IZxhHzeWr1HBW8PYN1Z3PqSAlw4k1C7LHyy9hK9CoybXL+aoZAD690shdzoulWWnQTtKBb4BEHjm5fGJtBr
X-Gm-Message-State: AOJu0Yyy0pvzOeeXhkcov6PY68ez/KvgBklNEzIIo7zI2373GkJuThzp
	7EfXivW2Rkn3ahdYbHZZsvzSAaeTEeGPjXurtlrLq3UGwuJWGwyS
X-Google-Smtp-Source: AGHT+IEn+IKBA1m4vUYaNhqcW+3lQ2x8L4xpEjXc73JlZyF1Bd6lYH7hKZMN5cYrtBDzol+pDBe1AA==
X-Received: by 2002:ac2:5f9b:0:b0:515:9dcd:22ae with SMTP id r27-20020ac25f9b000000b005159dcd22aemr902917lfe.66.1711542406820;
        Wed, 27 Mar 2024 05:26:46 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id er15-20020a05651248cf00b00513d1ff9eb2sm1810444lfb.208.2024.03.27.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:26:46 -0700 (PDT)
Date: Wed, 27 Mar 2024 15:26:44 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size"
 DT prop
Message-ID: <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>

On Wed, Mar 27, 2024 at 10:27:19AM +0000, Nas Chung wrote:
> Hi, Ivan.
> 
> >-----Original Message-----
> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
> >Sent: Monday, March 25, 2024 3:41 PM
> >To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> >Philipp Zabel <p.zabel@pengutronix.de>
> >Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
> >linux-kernel@vger.kernel.org
> >Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
> >prop
> >
> >Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
> >excessive "sram-size" device-tree property as genalloc is already able
> >to determine available memory.
> >
> >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> >---
> > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
> > .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
> > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> > .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
> > 4 files changed, 13 insertions(+), 18 deletions(-)
> >
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >index 3809f70bc0b4..a63fffed55e9 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> >*vpu_dev, struct vpu_buf *array,
> > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> > {
> > 	struct vpu_buf *vb = &vpu_dev->sram_buf;
> >+	dma_addr_t daddr;
> >+	void *vaddr;
> >+	size_t size;
> >
> >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> >+	if (!vpu_dev->sram_pool || vb->vaddr)
> > 		return;
> >
> >-	if (!vb->vaddr) {
> >-		vb->size = vpu_dev->sram_size;
> >-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> >-					       &vb->daddr);
> >-		if (!vb->vaddr)
> >-			vb->size = 0;
> >+	size = min_t(size_t, WAVE5_MAX_SRAM_SIZE, gen_pool_avail(vpu_dev-
> >>sram_pool));
> >+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> >+	if (vaddr) {
> >+		vb->vaddr = vaddr;
> >+		vb->daddr = daddr;
> >+		vb->size = size;
> > 	}
> >
> > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> >0x%p\n",
> >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device *vpu_dev)
> > 	if (!vb->size || !vb->vaddr)
> > 		return;
> >
> >-	if (vb->vaddr)
> >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> >-			      vb->size);
> >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> >>size);
> >
> > 	memset(vb, 0, sizeof(*vb));
> > }
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >index 1e631da58e15..2a972cddf4a6 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct platform_device
> >*pdev)
> > 		goto err_reset_assert;
> > 	}
> >
> >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> >-				   &dev->sram_size);
> >-	if (ret) {
> >-		dev_warn(&pdev->dev, "sram-size not found\n");
> >-		dev->sram_size = 0;
> >-	}
> >-
> > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > 	if (!dev->sram_pool)
> > 		dev_warn(&pdev->dev, "sram node not found\n");
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >index da530fd98964..975d96b22191 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >@@ -750,7 +750,6 @@ struct vpu_device {
> > 	struct vpu_attr attr;
> > 	struct vpu_buf common_mem;
> > 	u32 last_performance_cycles;
> >-	u32 sram_size;
> > 	struct gen_pool *sram_pool;
> > 	struct vpu_buf sram_buf;
> > 	void __iomem *vdb_register;
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >index d9751eedb0f9..9d99afb78c89 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >@@ -28,6 +28,8 @@
> > #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AVC
> >40K
> > #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
> >
> >+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
> 
> WAVE521 can support 8K stream decoding/encoding.
> So, I suggest the MAX_SRAME_SIZE to 128 * 1024 (128KB).
> 
> And, Current driver always enable sec_axi_info option if sram buffer is allocated.
> But, we have to enable/disable the sec_axi_info option after checking the allocated sram size is enough to decode/encode current bitstream resolution.

Do we really? As an experiment I tried to provide to Wave515 1KB of SRAM
memory and decoded 4k sample file was fine...

> Wave5 can enable/disable the sec_axi_info option for each instance.
> 
> How about handle sram-size through match_data ?
> I can find some drivers which use match_data to configure the sram size.
> 
> We can use current "ti,k3-j721s2-wave521c" device as a 4K supported device.
> - .sram_size = (64 * 1024);
> Driver just allocate the sram-size for max supported resolution of each device, and we don't need to check the sram-size is enough or not.
> 
> Thanks.
> Nas.
> 
> >+
> > #define MAX_NUM_INSTANCE                32
> >
> > #define W5_MIN_ENC_PIC_WIDTH            256
> >--
> >2.44.0
> 

