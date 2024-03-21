Return-Path: <linux-kernel+bounces-110401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF67885EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C7A1F217AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370013442E;
	Thu, 21 Mar 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6L9MUS3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148F18AE8;
	Thu, 21 Mar 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039301; cv=none; b=n3IftFHfSvI8kUpdU+IrP1v6uOMRkRMaJHLzGcTIIpum64Kb+/EZycbuxOHlysvC4gVgaWJefQDdP2oPkkT9P4c7jUt8QaoXrkGWLc7Jfn0VlflQyMlbSH6hOTLVtglaP5+y/fenEqtjfo0/mUucWfWjWLpnc8oy0dWPd8Hz5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039301; c=relaxed/simple;
	bh=Fy5RRSblj9JJG8xmeQobLC1vEdqR6ArBP+pEaJH45pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYVQCPKSOctj663f7kicHQVziJqMovYoW/wYpNmcu0ZhrvqJHtSKsRlGwdfmeRjyH6os4Iy21Owek2ryQw+lIPT1s2RFaqF+7x1xyTgVm2innhPhcWMqceWQPB0Ndos34oR5Ttb0lWxkst+q+arXxyvPv3cnxL5UtzBikhJOgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6L9MUS3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d476d7972aso20997421fa.1;
        Thu, 21 Mar 2024 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711039298; x=1711644098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvR3EkXBYNnuqR8ShobNi9WlN5TclTQG4PhF93uu8ec=;
        b=E6L9MUS3IyzYUD9N9cfhd6iGWbzFVk5+AUsz9maHoGxumYfQ0yxvWfVuEDSWXq9PN4
         zm0rhtIUMDDiTqP7s/mXQczNBDH7tV9WGu8z6bB3bEpFBhcc+Bv7OsYrJJtcGGIbbCV+
         Cq4SqKuIB1W7mXnBqkWL3sdfM26OEx7ZXA7j9b8a3ji7wDaHgQmVYdpZHuGqvETGLE7F
         r12UyGnGeaogJ08TUard9jK7jW1awiM9ukS5UY+PIMkZ22T2YlbMXN86AgQ3wJmC8lOG
         BobMnfBUxgBOy2Izf0FyhXqAVwnCQol4xySVEkonBHod5EouaQM9QXtOOpzJJtmArVuN
         RQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039298; x=1711644098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvR3EkXBYNnuqR8ShobNi9WlN5TclTQG4PhF93uu8ec=;
        b=ihXzKMBhWFWVfISgX0ADN0P0cyh5kilAXn+aquM1vGkJ4yNtKNx9E9uzhD5dQdPCDt
         9lXfqoydG1mRbfsmddZ0tLnaHCv5yMssT2uGVZxHlEZJRbV2hn6ZeM6CZCOLSYtY31E8
         ah9ItMjsQVaF92mC7EoWQy4eEfL1hXMRCWFOsJ2BORFziIj7gI2Ogg1WA8HC3zmXZkzJ
         YhzgL1FZnBuqyL/83ygxRQLmb1K5yBfYmvq6Sm0Hn7f5HikBIZerSnyrufvt5ZsL/w8G
         dZK1sCgtO0xVZiLOZ77v0nXxz7YqngE67OXhIVYvY2Ngr3QKGYEUdeFAsGi8Yi+rGofk
         7dJw==
X-Forwarded-Encrypted: i=1; AJvYcCU3sE/nAVVr+a6ID0E11TQGdVj/mcobnajIbVb1WngGIUBF8LIpNh2mq5YqlELu1RGZbs6EmCFd3KCRewL7pOA3nLWH/kXhk91we1m6LqiQkzbCPsh69b6TTFmS2xErgTxvGKhNc9kOpc1GjZ+qlVA+TxbOHGUEwlOtdXq1yRhleNKcRYET
X-Gm-Message-State: AOJu0Yym4RaG7xpnh+xvpSqPrWpNFk+XK6edSN1pEH5JLS5h5YbLmOeM
	/ZewuGuJnu5RCqd4fqhB74O11OWBz6lCgQ3bPcQQfSORa2c0joL5
X-Google-Smtp-Source: AGHT+IHIDFiLuq44EHkONVOTA/sn26LNjbii8c+wHceLOlU24dMQpmrUgMaVyr+PKkfrehPxagK5qQ==
X-Received: by 2002:a19:2d17:0:b0:513:353e:bcaa with SMTP id k23-20020a192d17000000b00513353ebcaamr7248411lfj.36.1711039297334;
        Thu, 21 Mar 2024 09:41:37 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b00513d24f1d38sm1131lfu.172.2024.03.21.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:41:36 -0700 (PDT)
Date: Thu, 21 Mar 2024 19:41:35 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Brandon Brnich <b-brnich@ti.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: Re: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Message-ID: <mhh25et5r36zr332iselgtmwuynl644zggw2h66ypjy5wyov5t@heve5x2z4njz>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
 <20240319210106.awn33cm7ex33g65b@udba0500997>
 <SL2P216MB12468C7256CE2468EE088E7CFB322@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <tg32tsfnj3pmboaaeslvrmf7wtvznagio3vtqot42iflz5lvh7@25s5ykv3dfuz>
 <20240321161405.i3xnyuqnfwzyomex@udba0500997>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321161405.i3xnyuqnfwzyomex@udba0500997>

On Thu, Mar 21, 2024 at 11:14:05AM -0500, Brandon Brnich wrote:
> Hi Ivan, 
> 
> On 13:52-20240321, Ivan Bornyakov wrote:
> > Hi!
> > 
> > On Thu, Mar 21, 2024 at 09:29:04AM +0000, Nas Chung wrote:
> > > Hi, Ivan and Brandon.
> > > 
> > > >-----Original Message-----
> > > >On 14:24-20240319, Ivan Bornyakov wrote:
> > > >> Hello, Nas
> > > >>
> > > >> On Tue, Mar 19, 2024 at 10:56:22AM +0000, Nas Chung wrote:
> > > >> > Hi, Ivan.
> > > >> >
> > > >> > >
> > > >> > >Allocate SRAM memory on module probe, free on remove. There is no
> > > >need
> > > >> > >to allocate on device open, free on close, the memory is the same
> > > >every
> > > >> > >time.
> > > >> >
> > > >> > If there is no decoder/encoder instance, driver don't need to
> > > >allocate SRAM memory.
> > > >> > The main reason of allocating the memory in open() is to allow other
> > > >modules to
> > > >> > use more SRAM memory, if wave5 is not working.
> > > >
> > > >I have to agree with this statement. Moving allocation to probe results
> > > >in wasting SRAM when VPU is not in use. VPU should only be allocating
> > > >SRAM
> > > >when a stream instance is running and free that back once all instances
> > > >close.
> > > >
> > > >> > >
> > > >> > >Also use gen_pool_size() to determine SRAM memory size to be
> > > >allocated
> > > >> > >instead of separate "sram-size" DT property to reduce duplication.
> > > >> > >
> > > >> > >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> > > >> > >---
> > > >> > > .../platform/chips-media/wave5/wave5-helper.c |  3 ---
> > > >> > > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++-------
> > > >--
> > > >> > > .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
> > > >> > > .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
> > > >> > > .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
> > > >> > > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> > > >> > > 6 files changed, 16 insertions(+), 25 deletions(-)
> > > >> > >
> > > >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > > >> > >b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > > >> > >index 8433ecab230c..ec710b838dfe 100644
> > > >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > > >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > > >> > >@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance
> > > >*inst)
> > > >> > > {
> > > >> > > 	int i;
> > > >> > >
> > > >> > >-	if (list_is_singular(&inst->list))
> > > >> > >-		wave5_vdi_free_sram(inst->dev);
> > > >> > >-
> > > >> > > 	for (i = 0; i < inst->fbc_buf_count; i++)
> > > >> > > 		wave5_vpu_dec_reset_framebuffer(inst, i);
> > > >> > >
> > > >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > >> > >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > >> > >index 3809f70bc0b4..ee671f5a2f37 100644
> > > >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > >> > >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> > > >> > >*vpu_dev, struct vpu_buf *array,
> > > >> > > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> > > >> > > {
> > > >> > > 	struct vpu_buf *vb = &vpu_dev->sram_buf;
> > > >> > >+	dma_addr_t daddr;
> > > >> > >+	void *vaddr;
> > > >> > >+	size_t size;
> > > >> > >
> > > >> > >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> > > >> > >+	if (!vpu_dev->sram_pool || vb->vaddr)
> > > >> > > 		return;
> > > >> > >
> > > >> > >-	if (!vb->vaddr) {
> > > >> > >-		vb->size = vpu_dev->sram_size;
> > > >> > >-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> > > >> > >-					       &vb->daddr);
> > > >> > >-		if (!vb->vaddr)
> > > >> > >-			vb->size = 0;
> > > >> > >+	size = gen_pool_size(vpu_dev->sram_pool);
> > > >> > >+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> > > >> > >+	if (vaddr) {
> > > >> > >+		vb->vaddr = vaddr;
> > > >> > >+		vb->daddr = daddr;
> > > >> > >+		vb->size = size;
> > > >> > > 	}
> > > >> > >
> > > >> > > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> > > >> > >0x%p\n",
> > > >> > >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
> > > >*vpu_dev)
> > > >> > > 	if (!vb->size || !vb->vaddr)
> > > >> > > 		return;
> > > >> > >
> > > >> > >-	if (vb->vaddr)
> > > >> > >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> > > >> > >-			      vb->size);
> > > >> > >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> > > >> > >>size);
> > > >> > >
> > > >> > > 	memset(vb, 0, sizeof(*vb));
> > > >> > > }
> > > >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-
> > > >dec.c
> > > >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > >> > >index aa0401f35d32..84dbe56216ad 100644
> > > >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > >> > >@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file
> > > >*filp)
> > > >> > > 		goto cleanup_inst;
> > > >> > > 	}
> > > >> > >
> > > >> > >-	wave5_vdi_allocate_sram(inst->dev);
> > > >> > >-
> > > >> > > 	return 0;
> > > >> > >
> > > >> > > cleanup_inst:
> > > >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-
> > > >enc.c
> > > >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > >> > >index 8bbf9d10b467..86ddcb82443b 100644
> > > >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > >> > >@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file
> > > >*filp)
> > > >> > > 		goto cleanup_inst;
> > > >> > > 	}
> > > >> > >
> > > >> > >-	wave5_vdi_allocate_sram(inst->dev);
> > > >> > >-
> > > >> > > 	return 0;
> > > >> > >
> > > >> > > cleanup_inst:
> > > >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > >> > >index f3ecadefd37a..2a0a70dd7062 100644
> > > >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > >> > >@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct
> > > >platform_device
> > > >> > >*pdev)
> > > >> > > 		return ret;
> > > >> > > 	}
> > > >> > >
> > > >> > >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> > > >> > >-				   &dev->sram_size);
> > > >> > >-	if (ret) {
> > > >> > >-		dev_warn(&pdev->dev, "sram-size not found\n");
> > > >> > >-		dev->sram_size = 0;
> > > >> > >-	}
> > > >> > >-
> > > >> >
> > > >> > Required SRAM size is different from each wave5 product.
> > > >> > And, SoC vendor also can configure the different SRAM size
> > > >> > depend on target SoC specification even they use the same wave5
> > > >product.
> > > >> >
> > > >>
> > > >> One can limit iomem address range in SRAM node. Here is the example of
> > > >> how I setup Wave515 with SRAM:
> > > >>
> > > >> 	sram@2000000 {
> > > >> 		compatible = "mmio-sram";
> > > >> 		reg = <0x0 0x2000000 0x0 0x80000>;
> > > >> 		#address-cells = <1>;
> > > >> 		#size-cells = <1>;
> > > >> 		ranges = <0x0 0x0 0x2000000 0x80000>;
> > > >>
> > > >> 		wave515_vpu_sram: wave515-vpu-sram@0 {
> > > >> 			reg = <0x0 0x80000>;
> > > >> 			pool;
> > > >> 		};
> > > >> 	};
> > > >>
> > > >> 	wave515@410000 {
> > > >> 		compatible = "cnm,wave515";
> > > >> 		reg = <0x0 0x410000 0x0 0x10000>;
> > > >> 		clocks = <&clk_ref1>;
> > > >> 		clock-names = "videc";
> > > >> 		interrupt-parent = <&wave515_intc>;
> > > >> 		interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> > > >> 		resets = <&wave515_reset 0>,
> > > >> 			 <&wave515_reset 4>,
> > > >> 			 <&wave515_reset 8>,
> > > >> 			 <&wave515_reset 12>;
> > > >> 		sram = <&wave515_vpu_sram>;
> > > >> 	};
> > > >>
> > > >> gen_pool_size() returns size of wave515_vpu_sram, no need for extra
> > > >> "sram-size" property.
> > > 
> > > Thanks for sharing the example.
> > > I agree that the "sram-size" property is not needed.
> > > 
> > > >
> > > >"sram-size" property does need to be removed, as this was the consensus
> > > >gathered from my patch[0]. However, I think your method is still taking
> > > 
> > > I missed the previous consensus for the sram-size property.
> > > Thanks for letting me know.
> > > 
> > > >a more static approach. One of the recommendations in my thread[1] was
> > > >making a list of known SRAM sizes given typical resolutions and
> > > >iterating through until a valid allocation is done. I don't think this
> > > >is the correct approach either based on Nas's comment that each Wave5
> > > >has different SRAM size requirement. It would clutter up the file too
> > > >much if each wave5 product had its own SRAM size mapping.
> > > >
> > > >Could another approach be to change Wave5 dts node to have property set
> > > >as "sram = <&sram>;" in your example, then driver calls
> > > >gen_pool_availble to get size remaining? From there, a check could be
> > > >put in place to make sure an unnecessary amount is not being allocated.
> > > 
> > > Ivan's approach looks good to me.
> > > It is similar to your first patch, which adds the sram-size property
> > > to configure different SRAM sizes for each device.
> > > And, Driver won't know unnecessary amount is allocated before parsing
> > > bitstream header.
> 
> I am aware of this, I should have been more specific. By unnecessary
> amount, I meant something greater than the max use case for device.
> Could we populate some macros that have max SRAM required for 4K stream?
> There's never a need to allocate more SRAM than that for a particular
> instance. If the amount available is less than that, then fine. But it
> should never be greater.
> 
> > > 
> > 
> > To sum up, there is 2 favourable approaches:
> > 
> > 1) to have dedicated SRAM partition for Wave5 VPU as suggested in this
> > patchset. In this approach SoC vendor can setup address range of said
> > partition to their needs, but other devices won't be able to use SRAM
> > memory reserved for Wave5 VPU, unless other device's SRAM memory needs
> > don't exceed the size of reserved partition.
> > 
> > Therefore it is sensible to substitute alloc/free on open/close with
> > alloc/free on open/close.
> 
> Not sure what you mean here. Were you trying to refer to your
> substitution of alloc/free from open/close to probe/remove?
> 
> If that is what you mean, and the decision is a specific carveout for
> SRAM, then I don't see a point in having allocation in open and close
> either since Wave5 would be the only IP that could use the pool.
> 
> > 
> > Advantages: driver code is simpler, no need for platform-specific defines
> > or DT properties. Wave5 is guaranteed to get SRAM memory.
> > 
> > Disadvantage: waste of SRAM memory while VPU is not in use
> > 
> > 2) allocate all available SRAM memory on open (free on close) from the
> > common SRAM pool, but limit maximum amount with SoC-specific define.
> > 
> 
> Why does it have to be on SoC specific define?

Well, if I understood correctly, in [1] Nas said that SRAM usage is
SoC-specific even with same Wave5 IP.

[1] https://lore.kernel.org/linux-media/SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM/

> Max size required for SRAM in a 4K case is known.

From docs I have for Wave515 it's _seems_ to be about 64K, but it's not
too clear.

> A call can be made to get the size of the
> pool and from there the driver can take a portion. Just make sure that
> portion is less than known value for 4K. 
> 

Yeah, I did exactly that in v2, was about to send, until I got
"Ivan's approach looks good to me" :)

> > Advantage: less memory waste
> > 
> > Disadvantages: still need SoC-specific define or DT property, not much
> > differ from current state. Wave5 is not guaranteed to get SRAM memory.
> > 
> 
> Wave5 does not need SRAM to function properly so it doesn't have to be
> guaranteed. 
> 

True.

> > Which of these approaches would be preferable?
> > 
> > > >
> > > >
> > > >[0]:
> > > >https://lore.kernel.org/lkml/99bf4d6d988d426492fffc8de9015751c323bd8a.cam
> > > >el@ndufresne.ca/
> > > >[1]: https://lore.kernel.org/lkml/9c5b7b2c-8a66-4173-dfe9-
> > > >5724ec5f733d@ti.com/
> > > >
> > > >Thanks,
> > > >Brandon
> > > >>
> > > >> > Thanks.
> > > >> > Nas.
> > > >> >
> > > >> > > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > > >> > > 	if (!dev->sram_pool)
> > > >> > > 		dev_warn(&pdev->dev, "sram node not found\n");
> > > >> > >+	else
> > > >> > >+		wave5_vdi_allocate_sram(dev);
> > > >> > >
> > > >> > > 	dev->product_code = wave5_vdi_read_register(dev,
> > > >> > >VPU_PRODUCT_CODE_REGISTER);
> > > >> > > 	ret = wave5_vdi_init(&pdev->dev);
> > > >> > >@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct
> > > >platform_device
> > > >> > >*pdev)
> > > >> > > err_clk_dis:
> > > >> > > 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> > > >> > >
> > > >> > >+	wave5_vdi_free_sram(dev);
> > > >> > >+
> > > >> > > 	return ret;
> > > >> > > }
> > > >> > >
> > > >> > >@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct
> > > >platform_device
> > > >> > >*pdev)
> > > >> > > 	v4l2_device_unregister(&dev->v4l2_dev);
> > > >> > > 	wave5_vdi_release(&pdev->dev);
> > > >> > > 	ida_destroy(&dev->inst_ida);
> > > >> > >+	wave5_vdi_free_sram(dev);
> > > >> > > }
> > > >> > >
> > > >> > > static const struct wave5_match_data ti_wave521c_data = {
> > > >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > > >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > > >> > >index fa62a85080b5..8d88381ac55e 100644
> > > >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > > >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > > >> > >@@ -749,7 +749,6 @@ struct vpu_device {
> > > >> > > 	struct vpu_attr attr;
> > > >> > > 	struct vpu_buf common_mem;
> > > >> > > 	u32 last_performance_cycles;
> > > >> > >-	u32 sram_size;
> > > >> > > 	struct gen_pool *sram_pool;
> > > >> > > 	struct vpu_buf sram_buf;
> > > >> > > 	void __iomem *vdb_register;
> > > >> > >--
> > > >> > >2.44.0
> > > >> >
> > > >>

