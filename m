Return-Path: <linux-kernel+bounces-107454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6C87FCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F91F2341F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF57EF12;
	Tue, 19 Mar 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O20sswb2"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BA7E583;
	Tue, 19 Mar 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847500; cv=none; b=HzfqudvDjrSJjQ48mmyqvRJOwHt4PxMngMb1jl4a6tT8emSMiqT1Su1T9Gf2dDnpdZtsWMu9V7PfH5kSDPquGk/H2Vv+u0q1epR4Hv3gAyY3LPrPEl3pCkPm9OegZZwmWQYGX+EEgBqcxk8Omh1BjvNXSujSPzblJi4raQrQBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847500; c=relaxed/simple;
	bh=t9s2QcAhnjlkxjg36NHwG/aB9v2vkm4Np9cVrSyOH/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IotemSnqQIuCaGEiM97snrIFqEVZSgnJch2AeKHbFSGCksDArVUiTnP7UIy5h1rp+qrRicCT4OFYKfTWLk8KvG9XgdTsmRL4nxXkmW67qTcIPHjBNyP7e/XTLLegIPSSBwWZuiRlmlmb4XiulPWMuC4LZspqPGw/XAde8I4N89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O20sswb2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513da1c1f26so6209467e87.3;
        Tue, 19 Mar 2024 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710847497; x=1711452297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+YtbcMVH5KBfGZARaI42tnGj6XuMVEbdDIudU3cTNA=;
        b=O20sswb2xJBsGNt/MzDZ6jfZgWs99gxDEOHXKOWwO8BMHtucFagOcOuqhNfgleKSyR
         6TsNpsoXdEn07AUtITQSofYLLza/B6kaseOkvzWhwFXMaV2ITpDPXmW03/gZu8QH4hC8
         TcIaeWa2iXaxvU9gnvhxNLdTEZ+MSBJYeaTSrA5tkqVAYfPYSH9YoYJ/skrtuepQbqgi
         5hqHnaK1S7VrwDmkebWJhVD2ORz/fa99RWNQGAvqxHZMlKwx0RdrayOA6B6a2YqEowxU
         OCZWvHAvG+E68KbwfTM8ilQj3+YQe3rCqjqnmUp6CNxztK52kz2owydiH0+k/PcbhiiH
         A1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710847497; x=1711452297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+YtbcMVH5KBfGZARaI42tnGj6XuMVEbdDIudU3cTNA=;
        b=H3DOwPhcqeCnfOcxZMa87SSC0sKQ911R5WODy0Y1r6HP0xdM34Ac4WWcyLCkx16MWi
         D3U5/jaixo+sgaoBNHPekQ/OfT524LUBfi5iTmp+xphXh3hd5ZRhYb1axHP//L8yTA0I
         OqAKdNXa/WJu2o43aeR1H8GC0bJP0byMLznazhiKhhPTrbX3cZOOyLOorcfHBC1jNe9F
         B0DeQs2WZgRHwp68ZFSkALm6lfgIdSsB139bg+b9YDwpQd57hirYT54D/hFJ8Dvd+3gP
         v8yO2oTGubsKcozXpj7+5UW3s+Ccfv3loeEMBNJbZrg5gE+YH2wmkFWoVlwpFoAK6g7n
         ERZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiOc2PJh4XzBmBEQiLw+NzZ4dFk7psqujeCPVR0mhTX+V08RKvyWyk9WMOiewtKGaHyGnCU/RyPTwejH5OrdFOWtupBh35lgdOfTPR3MRNolyCVQjCqOjGAN/HdIID7WbLi3BfRAARWj/W7N3S+pbOE1it3Ea6ks9ZW/0ML41+bIspOODw
X-Gm-Message-State: AOJu0Yyow6ApK1KFfzeGsIWq+/RW76OOzs0J85E6bwuEZpElpgM8S8cv
	LHeJVqs9SYNs7OXHrrk1MBe6dZCXseYhg4WNeaZ2REMA3baq+YXj
X-Google-Smtp-Source: AGHT+IEMQpH6QPDnCc12JTmpzEX0aJsXOi+1ZMGyv4Yv6p3BZGyf8yg+vuthbySGIZLownvYTxvldg==
X-Received: by 2002:a05:6512:60e:b0:513:d484:da51 with SMTP id b14-20020a056512060e00b00513d484da51mr9405857lfe.65.1710847496345;
        Tue, 19 Mar 2024 04:24:56 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id x21-20020a19f615000000b005132f8547cdsm1898261lfe.19.2024.03.19.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:24:55 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:24:54 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: RE: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Message-ID: <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>

Hello, Nas

On Tue, Mar 19, 2024 at 10:56:22AM +0000, Nas Chung wrote:
> Hi, Ivan.
> 
> >-----Original Message-----
> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
> >Sent: Monday, March 18, 2024 11:42 PM
> >To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>
> >Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; Philipp Zabel
> ><p.zabel@pengutronix.de>; Rob Herring <robh@kernel.org>; Krzysztof
> >Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> ><conor+dt@kernel.org>; linux-media@vger.kernel.org; linux-
> >kernel@vger.kernel.org; devicetree@vger.kernel.org
> >Subject: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
> >
> >Allocate SRAM memory on module probe, free on remove. There is no need
> >to allocate on device open, free on close, the memory is the same every
> >time.
> 
> If there is no decoder/encoder instance, driver don't need to allocate SRAM memory.
> The main reason of allocating the memory in open() is to allow other modules to
> use more SRAM memory, if wave5 is not working.
> 
> >
> >Also use gen_pool_size() to determine SRAM memory size to be allocated
> >instead of separate "sram-size" DT property to reduce duplication.
> >
> >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> >---
> > .../platform/chips-media/wave5/wave5-helper.c |  3 ---
> > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
> > .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
> > .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
> > .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
> > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> > 6 files changed, 16 insertions(+), 25 deletions(-)
> >
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >index 8433ecab230c..ec710b838dfe 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
> > {
> > 	int i;
> >
> >-	if (list_is_singular(&inst->list))
> >-		wave5_vdi_free_sram(inst->dev);
> >-
> > 	for (i = 0; i < inst->fbc_buf_count; i++)
> > 		wave5_vpu_dec_reset_framebuffer(inst, i);
> >
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >index 3809f70bc0b4..ee671f5a2f37 100644
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
> >+	size = gen_pool_size(vpu_dev->sram_pool);
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
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >index aa0401f35d32..84dbe56216ad 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file *filp)
> > 		goto cleanup_inst;
> > 	}
> >
> >-	wave5_vdi_allocate_sram(inst->dev);
> >-
> > 	return 0;
> >
> > cleanup_inst:
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >index 8bbf9d10b467..86ddcb82443b 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file *filp)
> > 		goto cleanup_inst;
> > 	}
> >
> >-	wave5_vdi_allocate_sram(inst->dev);
> >-
> > 	return 0;
> >
> > cleanup_inst:
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >index f3ecadefd37a..2a0a70dd7062 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct platform_device
> >*pdev)
> > 		return ret;
> > 	}
> >
> >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> >-				   &dev->sram_size);
> >-	if (ret) {
> >-		dev_warn(&pdev->dev, "sram-size not found\n");
> >-		dev->sram_size = 0;
> >-	}
> >-
> 
> Required SRAM size is different from each wave5 product.
> And, SoC vendor also can configure the different SRAM size
> depend on target SoC specification even they use the same wave5 product.
> 

One can limit iomem address range in SRAM node. Here is the example of
how I setup Wave515 with SRAM:

	sram@2000000 {
		compatible = "mmio-sram";
		reg = <0x0 0x2000000 0x0 0x80000>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x2000000 0x80000>;
		
		wave515_vpu_sram: wave515-vpu-sram@0 {
			reg = <0x0 0x80000>;
			pool;
		};
	};

	wave515@410000 {
		compatible = "cnm,wave515";
		reg = <0x0 0x410000 0x0 0x10000>;
		clocks = <&clk_ref1>;
		clock-names = "videc";
		interrupt-parent = <&wave515_intc>;
		interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
		resets = <&wave515_reset 0>,
			 <&wave515_reset 4>,
			 <&wave515_reset 8>,
			 <&wave515_reset 12>;
		sram = <&wave515_vpu_sram>;
	};

gen_pool_size() returns size of wave515_vpu_sram, no need for extra
"sram-size" property.

> Thanks.
> Nas.
> 
> > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > 	if (!dev->sram_pool)
> > 		dev_warn(&pdev->dev, "sram node not found\n");
> >+	else
> >+		wave5_vdi_allocate_sram(dev);
> >
> > 	dev->product_code = wave5_vdi_read_register(dev,
> >VPU_PRODUCT_CODE_REGISTER);
> > 	ret = wave5_vdi_init(&pdev->dev);
> >@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct platform_device
> >*pdev)
> > err_clk_dis:
> > 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> >
> >+	wave5_vdi_free_sram(dev);
> >+
> > 	return ret;
> > }
> >
> >@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct platform_device
> >*pdev)
> > 	v4l2_device_unregister(&dev->v4l2_dev);
> > 	wave5_vdi_release(&pdev->dev);
> > 	ida_destroy(&dev->inst_ida);
> >+	wave5_vdi_free_sram(dev);
> > }
> >
> > static const struct wave5_match_data ti_wave521c_data = {
> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >index fa62a85080b5..8d88381ac55e 100644
> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >@@ -749,7 +749,6 @@ struct vpu_device {
> > 	struct vpu_attr attr;
> > 	struct vpu_buf common_mem;
> > 	u32 last_performance_cycles;
> >-	u32 sram_size;
> > 	struct gen_pool *sram_pool;
> > 	struct vpu_buf sram_buf;
> > 	void __iomem *vdb_register;
> >--
> >2.44.0
> 

