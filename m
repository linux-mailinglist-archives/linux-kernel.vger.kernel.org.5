Return-Path: <linux-kernel+bounces-120737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBD88DC56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBB51C28897
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481905917B;
	Wed, 27 Mar 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQimpuTv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45C5821B;
	Wed, 27 Mar 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538315; cv=none; b=HoIo8kSgdCPZmiO++iemQKD9GjR+gErZN2uFPPOidqBq4nI+lLROHUeDGwK0Nt+AX09Z0Yxu8Uub3iFljmjdgtL1hchqIgqCkvC7qLQMUilEi3pAIoc/VynWioJ8+0EwC5Vd//OHPIW/b/hPupt4Ea6g5VCFDuQ0m6uRvS+HD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538315; c=relaxed/simple;
	bh=i2fa+3DR26Zj31lD2if0uoJhDszpehrNQXV32GdxVjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjNy1kAcKwd2JteGWYIVZxBgmMajvCjNMJ5hu7f5/POh30uhOV0EbYy8BqMcfedaoo4yo7btstrQYz0CiY/7PNlLDvMDcscW4eB09xLfaCpFIvvKb/Ql7gN2yrfJ3dUnZPgUqxhNshEwSrrNRa3TkI4BT35rDQHX9ZH3k1BF8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQimpuTv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d485886545so115142111fa.2;
        Wed, 27 Mar 2024 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711538311; x=1712143111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lp/zcrR0u0FeMfhA5vj2Juol5mBwEE6nXt1DO/sf7b4=;
        b=dQimpuTv2Dlrpake4/evK7/sIUxvaY0igaAsUFlXQowkiiv2uKLSYCAqmk+AuMb1BY
         dewpUqkIKtHzrMQQZOICGoJgrw794WtKE42LhZj7IsdNa/oJn/K7o6gh9p8Lxpg/d2CO
         tMmvbDFhY79CaCZVsr/kCQXS8Jacv53wvFJ4qOSw1q/HSvg+W5nXKaZH7kUgQvMSuH4s
         huwWw7guBFcvnblRiic7imVCkCR0KTJLPtwr9E24Lm9BC3k/5g27k1wk6ZY652+R7wDK
         CwLfCTO+PRkVtBmSrHemtFPqTmQWbm06UjhiJC2JdOUe6bqXbYotNpiU5lxG4aZvm/aV
         dM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711538311; x=1712143111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp/zcrR0u0FeMfhA5vj2Juol5mBwEE6nXt1DO/sf7b4=;
        b=bsP/9oyYqimaB+PwbGSc3vMlSv8wwkW9qXb5zLebQTLeLCA8RS6LKC0VYIwBkuNPdo
         WA5CFhRpHGEIYyVaftgPzu7nqNpcY25GIbZ7IFHBUHo85DcWHJghxW1xtHV38P3ktTn3
         4T/uiPuoK2kFCFrL2RCF2rTZX0YVNDkJGA5XVB9M9xsUCiEcdJ4m2IdS8fPsz3sE7TOq
         V3HqJOhw3FWoyTLJmRrbkgqBkNkG4cmY9R2GNU+JKnJNkVRJBomSi5RDouCJg4jpBlWl
         AROWYFiPbofimMhzgC9L6+4GTD66FOKrFsLDGoDD31ca+SfZJJ0f2edwwqD0kcDLRM4e
         Q6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEW9Qi69P78wCw7eTfJ+7GDer8keh59akrQN1VHRVTgfsblNhIuXWWJRuVl7e0H0Ua+u+L2b7Qbj7EvQx6+PNg/kAflZVd0KGufGh1
X-Gm-Message-State: AOJu0YwEe9Oj+uC5niQVcjgF2kvMfmichs8Tdv1s5eK0g35a2dLr+rjq
	O/9TCkRPXaVYuP0awmbr6FJrcqKVbyIZ0gO6sR/CBgKrDQsiRFUx
X-Google-Smtp-Source: AGHT+IGx+Aw4iJKhDOR4wJMItnvljG8SUMPzbwyM4c5FFUXIYLBPM7ZUstOEoE6+pVy1WSSrMM+wkw==
X-Received: by 2002:a05:651c:2120:b0:2d6:fd22:8065 with SMTP id a32-20020a05651c212000b002d6fd228065mr998773ljq.1.1711538311239;
        Wed, 27 Mar 2024 04:18:31 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e98cb000000b002d436e25f83sm2060091ljj.46.2024.03.27.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:18:30 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:18:29 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size"
 DT prop
Message-ID: <46lu36puyfwphpje3hndjictsols6tckbigxieufikl5kjtgdq@5cv353oijzub>
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
> Wave5 can enable/disable the sec_axi_info option for each instance.
> 
> How about handle sram-size through match_data ?
> I can find some drivers which use match_data to configure the sram size.
> 
> We can use current "ti,k3-j721s2-wave521c" device as a 4K supported device.
> - .sram_size = (64 * 1024);
> Driver just allocate the sram-size for max supported resolution of each device, and we don't need to check the sram-size is enough or not.

Sure, sounds reasonable.

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

