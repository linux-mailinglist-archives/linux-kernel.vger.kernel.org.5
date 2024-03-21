Return-Path: <linux-kernel+bounces-109908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC38857A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800A51F22949
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CADE57323;
	Thu, 21 Mar 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcZKBnRV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2741A91;
	Thu, 21 Mar 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018330; cv=none; b=ozQ0POezDNfPL4WqtXbbT7iafsFTJz0EbckXPyIsOjW2ZK8hyvIz5ZgVVDR4evMZSP9oh42YUHfSdRruFaZsWUi9AVBslJLotOZMzHCocIzizprIWTrZFj1U9Bx52YUq2FwRQUuQjQZvuDN6yilVzZP5wr70H4XPOumg7NJXMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018330; c=relaxed/simple;
	bh=J7qo+0sdXTmMkR47uNMgU/tE+pZlQVsJlmWUqzXgKsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPMWaR/uPTld63RwwlYDDczfNtN4ekcOPsiXhVJKD9MItL/4P8F9qxwghaOnDdJGbyuGEZIBgXAqiyyV+oV8JvKp7mhoZaEqpvkjbKyffF62Z9IJTMBSQabHLK+pMefXgO+PEhtGrf1b8bxmhrqnskpH0FObMByfOwbkAkhChR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcZKBnRV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512f892500cso953323e87.3;
        Thu, 21 Mar 2024 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711018326; x=1711623126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtE8DhP4hGBF+/6PHU0enNa+mit7p71WmHR0SCZe11c=;
        b=FcZKBnRVbdE9kB0jyKOGHCW/br1i5xmUT6nHBKgPlyeJLjBFMOmw/q8oL50DDno/8X
         dAJb5IN4w65TjhRWwaEaHe+GUxB4kODmo5tY+Q1ZIhuuYERRWzsLBJNNspJjaVSsXWso
         xS2vuwPW4oVarNJy89D3M2NtlQwlrDq65DBU3SI+Fha8Rqv3ywUjeB7KzT+ypNCMg5pZ
         5l7fDMpOpwqGwmcxJkR6MQsLO3zKF6U1eZj6EMPCcrGCFjNWm+91TKr3jKDQ0waVKREe
         Fzhd9ISP7qIP4hBePJqSmuYTjlxdi3J0wjBKFbTuV2r9pknPJ3ulH+AL/SogOA5AaIEU
         75bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711018326; x=1711623126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtE8DhP4hGBF+/6PHU0enNa+mit7p71WmHR0SCZe11c=;
        b=Rstuk6osGnWHF72EUezR0wFPBJCBGyHjgZidGAFJ1DNX8t7NPY9EhlFdzX+7wY8uBx
         8C9hCmhIQLUBWl7IJf9RO81dfvHFAjZziwxNLh1M7eVBZOXrf8KGVGhzM0yb9eI/S5tE
         1LDPgyBQ745ucTRun5JqRuSsTh1PgnCrI0PfWIlwIOh0yU6Scv/BQsGA3MJyqfZzxWrx
         fwmvQHx40qf7FKXB7kqAP90f9BdRdIgoqcXhXxBs0R+ZGQixPPgiQJcuuGFtLWHODqR4
         XnMWY0xgpESAO84HlioQ7LYfwfTqZQdpyt2g4TUpdqUjHliPlxowIwSUeIXznD0lGDQR
         MGBg==
X-Forwarded-Encrypted: i=1; AJvYcCVsGU2CVtiXL2ejgAdT2vmmP4MWl65MDVm3BAUNTdvKn+9VHt7GjukKxSjAOKWKN1xcSzPvjnVmzci3MATZB+wicvfCAzjCfTwAvVXUIAcEBACxiowmyWHReAhhq7xmO/Xp0CEaOFnBKtO3rNjHwpZkUmUE5T3nCHAsfAPfuKfEvA5x07LI
X-Gm-Message-State: AOJu0Yyz++657li2BMighyszcuuVeAW4Rwm7NF5s3owkaeXnMjP4qm5C
	nNhvbDg339N09XP0WUmiSlg3GB+mofLJ3Btb4rxtopzerxWjAloy
X-Google-Smtp-Source: AGHT+IHMVq5EcxMs3De+XX6IOf4T1JD/B3VgakI0+SS3/WpluY1jdpheGYwXppW+vxPF5UEBius2qw==
X-Received: by 2002:ac2:4db1:0:b0:513:dc47:4408 with SMTP id h17-20020ac24db1000000b00513dc474408mr1566792lfe.36.1711018325157;
        Thu, 21 Mar 2024 03:52:05 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id i1-20020a0565123e0100b005159626af49sm48874lfv.244.2024.03.21.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:52:04 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:52:03 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: Brandon Brnich <b-brnich@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: RE: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Message-ID: <tg32tsfnj3pmboaaeslvrmf7wtvznagio3vtqot42iflz5lvh7@25s5ykv3dfuz>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
 <20240319210106.awn33cm7ex33g65b@udba0500997>
 <SL2P216MB12468C7256CE2468EE088E7CFB322@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB12468C7256CE2468EE088E7CFB322@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>

Hi!

On Thu, Mar 21, 2024 at 09:29:04AM +0000, Nas Chung wrote:
> Hi, Ivan and Brandon.
> 
> >-----Original Message-----
> >From: Brandon Brnich <b-brnich@ti.com>
> >Sent: Wednesday, March 20, 2024 6:01 AM
> >To: Ivan Bornyakov <brnkv.i1@gmail.com>
> >Cc: Nas Chung <nas.chung@chipsnmedia.com>; Philipp Zabel
> ><p.zabel@pengutronix.de>; Rob Herring <robh@kernel.org>; Krzysztof
> >Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> ><conor+dt@kernel.org>; linux-media@vger.kernel.org; linux-
> >kernel@vger.kernel.org; devicetree@vger.kernel.org; jackson.lee
> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>
> >Subject: Re: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
> >
> >Hi Ivan,
> >
> >On 14:24-20240319, Ivan Bornyakov wrote:
> >> Hello, Nas
> >>
> >> On Tue, Mar 19, 2024 at 10:56:22AM +0000, Nas Chung wrote:
> >> > Hi, Ivan.
> >> >
> >> > >
> >> > >Allocate SRAM memory on module probe, free on remove. There is no
> >need
> >> > >to allocate on device open, free on close, the memory is the same
> >every
> >> > >time.
> >> >
> >> > If there is no decoder/encoder instance, driver don't need to
> >allocate SRAM memory.
> >> > The main reason of allocating the memory in open() is to allow other
> >modules to
> >> > use more SRAM memory, if wave5 is not working.
> >
> >I have to agree with this statement. Moving allocation to probe results
> >in wasting SRAM when VPU is not in use. VPU should only be allocating
> >SRAM
> >when a stream instance is running and free that back once all instances
> >close.
> >
> >> > >
> >> > >Also use gen_pool_size() to determine SRAM memory size to be
> >allocated
> >> > >instead of separate "sram-size" DT property to reduce duplication.
> >> > >
> >> > >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> >> > >---
> >> > > .../platform/chips-media/wave5/wave5-helper.c |  3 ---
> >> > > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++-------
> >--
> >> > > .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
> >> > > .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
> >> > > .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
> >> > > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> >> > > 6 files changed, 16 insertions(+), 25 deletions(-)
> >> > >
> >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >> > >b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >> > >index 8433ecab230c..ec710b838dfe 100644
> >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> >> > >@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance
> >*inst)
> >> > > {
> >> > > 	int i;
> >> > >
> >> > >-	if (list_is_singular(&inst->list))
> >> > >-		wave5_vdi_free_sram(inst->dev);
> >> > >-
> >> > > 	for (i = 0; i < inst->fbc_buf_count; i++)
> >> > > 		wave5_vpu_dec_reset_framebuffer(inst, i);
> >> > >
> >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> > >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> > >index 3809f70bc0b4..ee671f5a2f37 100644
> >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> > >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> >> > >*vpu_dev, struct vpu_buf *array,
> >> > > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> >> > > {
> >> > > 	struct vpu_buf *vb = &vpu_dev->sram_buf;
> >> > >+	dma_addr_t daddr;
> >> > >+	void *vaddr;
> >> > >+	size_t size;
> >> > >
> >> > >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> >> > >+	if (!vpu_dev->sram_pool || vb->vaddr)
> >> > > 		return;
> >> > >
> >> > >-	if (!vb->vaddr) {
> >> > >-		vb->size = vpu_dev->sram_size;
> >> > >-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> >> > >-					       &vb->daddr);
> >> > >-		if (!vb->vaddr)
> >> > >-			vb->size = 0;
> >> > >+	size = gen_pool_size(vpu_dev->sram_pool);
> >> > >+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> >> > >+	if (vaddr) {
> >> > >+		vb->vaddr = vaddr;
> >> > >+		vb->daddr = daddr;
> >> > >+		vb->size = size;
> >> > > 	}
> >> > >
> >> > > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> >> > >0x%p\n",
> >> > >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
> >*vpu_dev)
> >> > > 	if (!vb->size || !vb->vaddr)
> >> > > 		return;
> >> > >
> >> > >-	if (vb->vaddr)
> >> > >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> >> > >-			      vb->size);
> >> > >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> >> > >>size);
> >> > >
> >> > > 	memset(vb, 0, sizeof(*vb));
> >> > > }
> >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-
> >dec.c
> >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >> > >index aa0401f35d32..84dbe56216ad 100644
> >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> >> > >@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file
> >*filp)
> >> > > 		goto cleanup_inst;
> >> > > 	}
> >> > >
> >> > >-	wave5_vdi_allocate_sram(inst->dev);
> >> > >-
> >> > > 	return 0;
> >> > >
> >> > > cleanup_inst:
> >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-
> >enc.c
> >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >> > >index 8bbf9d10b467..86ddcb82443b 100644
> >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> >> > >@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file
> >*filp)
> >> > > 		goto cleanup_inst;
> >> > > 	}
> >> > >
> >> > >-	wave5_vdi_allocate_sram(inst->dev);
> >> > >-
> >> > > 	return 0;
> >> > >
> >> > > cleanup_inst:
> >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> > >index f3ecadefd37a..2a0a70dd7062 100644
> >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> > >@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct
> >platform_device
> >> > >*pdev)
> >> > > 		return ret;
> >> > > 	}
> >> > >
> >> > >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> >> > >-				   &dev->sram_size);
> >> > >-	if (ret) {
> >> > >-		dev_warn(&pdev->dev, "sram-size not found\n");
> >> > >-		dev->sram_size = 0;
> >> > >-	}
> >> > >-
> >> >
> >> > Required SRAM size is different from each wave5 product.
> >> > And, SoC vendor also can configure the different SRAM size
> >> > depend on target SoC specification even they use the same wave5
> >product.
> >> >
> >>
> >> One can limit iomem address range in SRAM node. Here is the example of
> >> how I setup Wave515 with SRAM:
> >>
> >> 	sram@2000000 {
> >> 		compatible = "mmio-sram";
> >> 		reg = <0x0 0x2000000 0x0 0x80000>;
> >> 		#address-cells = <1>;
> >> 		#size-cells = <1>;
> >> 		ranges = <0x0 0x0 0x2000000 0x80000>;
> >>
> >> 		wave515_vpu_sram: wave515-vpu-sram@0 {
> >> 			reg = <0x0 0x80000>;
> >> 			pool;
> >> 		};
> >> 	};
> >>
> >> 	wave515@410000 {
> >> 		compatible = "cnm,wave515";
> >> 		reg = <0x0 0x410000 0x0 0x10000>;
> >> 		clocks = <&clk_ref1>;
> >> 		clock-names = "videc";
> >> 		interrupt-parent = <&wave515_intc>;
> >> 		interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> >> 		resets = <&wave515_reset 0>,
> >> 			 <&wave515_reset 4>,
> >> 			 <&wave515_reset 8>,
> >> 			 <&wave515_reset 12>;
> >> 		sram = <&wave515_vpu_sram>;
> >> 	};
> >>
> >> gen_pool_size() returns size of wave515_vpu_sram, no need for extra
> >> "sram-size" property.
> 
> Thanks for sharing the example.
> I agree that the "sram-size" property is not needed.
> 
> >
> >"sram-size" property does need to be removed, as this was the consensus
> >gathered from my patch[0]. However, I think your method is still taking
> 
> I missed the previous consensus for the sram-size property.
> Thanks for letting me know.
> 
> >a more static approach. One of the recommendations in my thread[1] was
> >making a list of known SRAM sizes given typical resolutions and
> >iterating through until a valid allocation is done. I don't think this
> >is the correct approach either based on Nas's comment that each Wave5
> >has different SRAM size requirement. It would clutter up the file too
> >much if each wave5 product had its own SRAM size mapping.
> >
> >Could another approach be to change Wave5 dts node to have property set
> >as "sram = <&sram>;" in your example, then driver calls
> >gen_pool_availble to get size remaining? From there, a check could be
> >put in place to make sure an unnecessary amount is not being allocated.
> 
> Ivan's approach looks good to me.
> It is similar to your first patch, which adds the sram-size property
> to configure different SRAM sizes for each device.
> And, Driver won't know unnecessary amount is allocated before parsing
> bitstream header.
> 

To sum up, there is 2 favourable approaches:

1) to have dedicated SRAM partition for Wave5 VPU as suggested in this
patchset. In this approach SoC vendor can setup address range of said
partition to their needs, but other devices won't be able to use SRAM
memory reserved for Wave5 VPU, unless other device's SRAM memory needs
don't exceed the size of reserved partition.

Therefore it is sensible to substitute alloc/free on open/close with
alloc/free on open/close.

Advantages: driver code is simpler, no need for platform-specific defines
or DT properties. Wave5 is guaranteed to get SRAM memory.

Disadvantage: waste of SRAM memory while VPU is not in use

2) allocate all available SRAM memory on open (free on close) from the
common SRAM pool, but limit maximum amount with SoC-specific define.

Advantage: less memory waste

Disadvantages: still need SoC-specific define or DT property, not much
differ from current state. Wave5 is not guaranteed to get SRAM memory.

Which of these approaches would be preferable?

> >
> >
> >[0]:
> >https://lore.kernel.org/lkml/99bf4d6d988d426492fffc8de9015751c323bd8a.cam
> >el@ndufresne.ca/
> >[1]: https://lore.kernel.org/lkml/9c5b7b2c-8a66-4173-dfe9-
> >5724ec5f733d@ti.com/
> >
> >Thanks,
> >Brandon
> >>
> >> > Thanks.
> >> > Nas.
> >> >
> >> > > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> >> > > 	if (!dev->sram_pool)
> >> > > 		dev_warn(&pdev->dev, "sram node not found\n");
> >> > >+	else
> >> > >+		wave5_vdi_allocate_sram(dev);
> >> > >
> >> > > 	dev->product_code = wave5_vdi_read_register(dev,
> >> > >VPU_PRODUCT_CODE_REGISTER);
> >> > > 	ret = wave5_vdi_init(&pdev->dev);
> >> > >@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct
> >platform_device
> >> > >*pdev)
> >> > > err_clk_dis:
> >> > > 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> >> > >
> >> > >+	wave5_vdi_free_sram(dev);
> >> > >+
> >> > > 	return ret;
> >> > > }
> >> > >
> >> > >@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct
> >platform_device
> >> > >*pdev)
> >> > > 	v4l2_device_unregister(&dev->v4l2_dev);
> >> > > 	wave5_vdi_release(&pdev->dev);
> >> > > 	ida_destroy(&dev->inst_ida);
> >> > >+	wave5_vdi_free_sram(dev);
> >> > > }
> >> > >
> >> > > static const struct wave5_match_data ti_wave521c_data = {
> >> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> > >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> > >index fa62a85080b5..8d88381ac55e 100644
> >> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> > >@@ -749,7 +749,6 @@ struct vpu_device {
> >> > > 	struct vpu_attr attr;
> >> > > 	struct vpu_buf common_mem;
> >> > > 	u32 last_performance_cycles;
> >> > >-	u32 sram_size;
> >> > > 	struct gen_pool *sram_pool;
> >> > > 	struct vpu_buf sram_buf;
> >> > > 	void __iomem *vdb_register;
> >> > >--
> >> > >2.44.0
> >> >
> >>

