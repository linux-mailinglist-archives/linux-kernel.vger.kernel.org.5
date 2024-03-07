Return-Path: <linux-kernel+bounces-95198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310B874A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A45B238D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86603839F8;
	Thu,  7 Mar 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfJlr8Ua"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE546350B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803073; cv=none; b=hfh4mOtez5BPc8O8YWCenHgPjR4zlc7oTQNF55lRZcCenMDV7KzCGoEYMmbB6LJHn7ArJ61p8lXEoHZVEdNUqx3Mv4JbXLqXu4P9lzpXOOtYdSmj1QoSCNg1oG+N772zHRwXE4in1BDBLGeC9voocINGlo77SvF04ZMzRaFzjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803073; c=relaxed/simple;
	bh=Humaw0sG6WscSuSXYKTw4+zlioKOT4E7YRzCDIj+y+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlD6Xf3beOPfbYS+I4qgmuks5kpwHmrln5JKNAtp7ozFCewywRVnnGkMIM24r8nUsoYyBmWGYVfJC5CtTR0JOFY/AaDDb3kcS2cedGeXA4X3kPCQlmSRyo44AuKUSGt8K5cKLOMgZPmPVQ3n3vnMQXfjqDMWJSl9UbJzr1s6DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfJlr8Ua; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413007fe6a3so5822045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709803070; x=1710407870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzqqO8837G1P/dhMJFjVPLECn5ANz/m4HM5TG7NuLXk=;
        b=SfJlr8UaTqBqlhyxPPlGC7RZ/f2Ra7yHwUku0fRSEM/QonQlBekyIKbRtuULESWbdm
         dlvAs8kmo7yTpwKx1XUSGmgwfyppiwEC7psBMqCZGsctgoIjjRE7gfcqN1nt5rC6b+QS
         /yw7eeHsHndZfF+LXiRYBuZbibCNdyj+LVNcAfrqMbBwqBnzR6xJs1TMOD61mG7EJ5J7
         9BK974fV+AWUYcyUdayKZV528AcX3d/s6Q80OWNw5lwihozdD0AjvRLdL4pfbxexPK03
         W+jM4vdw/pNFXs3QAHGaM1S2LoEANvwD+dtRGphhfPtnXfKfwhF8CikRrck1gvqfQcoJ
         l+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803070; x=1710407870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzqqO8837G1P/dhMJFjVPLECn5ANz/m4HM5TG7NuLXk=;
        b=LQfE01CyjZ+mjZclmfwaZTh7dri+Wp/yV3WKeDqTOjqcfE9qTPmQl3xJ/mwGlAR8z3
         rIXdzWjjdQmquHyT4HvrnF2IHaBQLLFtfksNxoDbVOe1iCGy/S0B3ookI9BAPn3I/1qJ
         VDGBYiz/P+wOCGE+yFvQzbie7wLJZyNdP/wctuFzMEMVQSYi2YjXX7ddCYH5R1Tg7s2b
         /3exfyJjVV7MoU8vrt3sISddizE3XDGwLLLFIW5y3C0Bl0dm0J3h3UQjzYbCGacHQolK
         VW4q6p9+BcVvW/8Vf0U+ehLHYCakkQLqScu7qr4MDNHj7IGF5KzQ6fXlkw8k9Tmz+vbH
         M0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWao2I5Y1SHbE3N6amJfT75/ur+Qg3Kmfsb8Y/bFXA+CQA+6Bn5naswDaNDdidXhOAkSK6fQNVmW8JiBGEikpKeQwW/e37bbuux6tc5
X-Gm-Message-State: AOJu0Yzdx6FTxOALNiWHRdFVrx1YR3Winh6Cn5SVkUHehk0G2aJ4nahN
	YbtIuduQaWvswbYt+EK/5gKV8u0JGHWK/ORWUhegrH4PILyudnsfJyzGm0VDOf0=
X-Google-Smtp-Source: AGHT+IFNRbJImoy7bq/rIW/7veLCiGFWp22d/+OEE1Oaaq9c8kZXoos4Z/RypLyxR6Ozd+0Xjud1Zg==
X-Received: by 2002:a05:600c:3b8c:b0:412:faa6:b45d with SMTP id n12-20020a05600c3b8c00b00412faa6b45dmr2403274wms.5.1709803070083;
        Thu, 07 Mar 2024 01:17:50 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id er15-20020a05600c84cf00b00412ff07df2bsm1926934wmb.37.2024.03.07.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:17:49 -0800 (PST)
Date: Thu, 7 Mar 2024 12:17:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
Message-ID: <27c875fb-9507-4034-8468-c4d46c952754@moroto.mountain>
References: <31a20aead3419209991bf01aaeaefe07ab94d23a.1709081052.git.daniel@makrotopia.org>
 <8ae44e8e-fc3d-28bd-5d1e-e900ce53529f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ae44e8e-fc3d-28bd-5d1e-e900ce53529f@huawei.com>

On Wed, Feb 28, 2024 at 09:45:13AM +0800, Zhihao Cheng wrote:
> 在 2024/2/28 8:46, Daniel Golle 写道:
> > A compiler warning related to sizeof(int) != 8 when calling do_div()
> > is triggered when building on 32-bit platforms.
> > Address this by using integer types having a well-defined size.
> > 
> > Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v2: use size_t for 'bytes_left' variable to match parameter type
> > 
> >   drivers/mtd/ubi/nvmem.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> > index b7a93c495d172..e68b8589c4279 100644
> > --- a/drivers/mtd/ubi/nvmem.c
> > +++ b/drivers/mtd/ubi/nvmem.c
> > @@ -23,9 +23,12 @@ struct ubi_nvmem {
> >   static int ubi_nvmem_reg_read(void *priv, unsigned int from,
> >   			      void *val, size_t bytes)
> >   {
> > -	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
> >   	struct ubi_nvmem *unv = priv;
> >   	struct ubi_volume_desc *desc;
> > +	size_t bytes_left = bytes;
> > +	uint32_t offs, to_read;
> There still exist a type truncation assignment 'to_read = bytes_left' below,
> although it's safe in logic.

Yeah.  As you say, from looking at the logic we know it's safe.

    41                  if (to_read > bytes_left)
    42                          to_read = bytes_left;

Obviously the new value is smaller than the original, so it must fit
within a u32 range...

This bug has been breaking the build since Dec 19.  It's fine if you're
able to manually create your own .configs to work around build breakage.
But if you're doing automated testing at scale then it's a show stopper.
Could we please fix it.

regards,
dan carpenter


