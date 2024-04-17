Return-Path: <linux-kernel+bounces-148990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0788A8A28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF561C222C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A917167F;
	Wed, 17 Apr 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmFzZbJk"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E4171673;
	Wed, 17 Apr 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374837; cv=none; b=lZr6HNoOhsWm/oyK+4tDmH2BPGWYOz/J2YaxpxdTPmSwHglewd3iCCyTWHbOl35NWoWYZ+kzHX9sCTWxNVRA+3B4A1JLBxQeK9DdfpBlnnkivoO1GjMmmX1aLnFGYfK7JSgw0LnM2yC6rdjNKaMOO3yvMBQQkss0XxheFzCWT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374837; c=relaxed/simple;
	bh=LH0E3f14sFod+vFzZXCOs/IXORwqoeiG9y513UfProA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj4grDn4fa96vaNBDVOzdg2a6suZsnWA+DFIhaw9Fe/xTAoVn47A7IVKV0V4QxSIlW3YMpdUrxNiPL6YUHYi63NJ5nYI6UfYnwLDl4NKWohWfwwfvaxbscO+On2elKKYfnz800yz9Y54bTeYuiPySB12+bL9IOmt/KninhWn3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmFzZbJk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6150670d372so53482077b3.1;
        Wed, 17 Apr 2024 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713374835; x=1713979635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H1FLmdDfTUyGnOxaA/bUaKhz9a7gwzyhRJlNB5u2xbs=;
        b=JmFzZbJkjbA/MaeSUo7H/uF9Re1ettKdLBbG/D+KEHSV8heQSzwfO5lyGCawgGmxUd
         uAQn+Xjs1LKZFBCvAohd5DfavDDFGaw98UOqznqrbBK26ntXcCqHspKf8du0VAQtGPxj
         yPdoutAH3kaGTs7TJY8jz3VN5yRFe+ojelSqLSc6xUd1qdWKjEdCN6NB66oBKbnoNtmt
         r1xoAlU+Ec4wJqAyGW14+pd1oXjMWaoHlcuTW0QzEj8ZoytvHdNAsmY5mrXDrXg8G5WR
         sMC1bp2ahueb4zo7u+uPAz/T0NvjdaZejzEUXup9n9S/wGRQvcgszyAGyQwdvOJZXWqD
         NKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374835; x=1713979635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1FLmdDfTUyGnOxaA/bUaKhz9a7gwzyhRJlNB5u2xbs=;
        b=ViW8CXMMuYzKvTMpy5VQFFtNxO+uv9uxfcbL+fzHQLRFfYifEZfLmQC2CYxuVJjsVk
         DoDF1tpMaQL+aK314cx+qE4WLgUSeO2dofs1j0gnulWl8BcIz1JuNZigza1p1cv+J8XF
         yDS3Jv56puinABznsqhry0KngQ140Y1k5IuAEPhf/ydTDcyXiPkJZ3/5zhwNSmzri0WT
         BcbRt+kaptvHhUpaxC8j033MK1IYH+U457UtevwCrZevdvk0BhxavcCjccmuaimr5U9j
         jjYpEJiWYZq03EUDjtrqcc9ouUCTZTcqgvelaRWR86c9N9K1kP9TwbzKWCfr78rMsjtG
         2Hlw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Jt3ObzhgQVEkgGvSt+Fys1x717oEsd27WzhZP5WQIU9dx9E8vH4s4N4FpCPgAPZkj6hfZ95VWcZvdQj+9+ykyyb+sTlljSv4Ig==
X-Gm-Message-State: AOJu0YzDaKVkpGI2Aw3qTJNISlvBXRNlYoYtSV2cY0srL83k4hTKKwnR
	Wk7qlVzuJ+ZEFmoKan4HIaq/peqDCRUbUjPuEkpkPJWsaQEzM3Ww
X-Google-Smtp-Source: AGHT+IHrgo/4WOLhe519ATtEJSHUOL3hyJCh7y166B/d1PG7w93DabYySgJ2SkIflN7ls6t/cZU4Xw==
X-Received: by 2002:a05:690c:6f05:b0:61b:11d5:a675 with SMTP id jd5-20020a05690c6f0500b0061b11d5a675mr2147492ywb.32.1713374835278;
        Wed, 17 Apr 2024 10:27:15 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:7ca6:7207:b6c4:2389])
        by smtp.gmail.com with ESMTPSA id t1-20020a81e441000000b00610eaf46c6dsm3028484ywl.117.2024.04.17.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:27:14 -0700 (PDT)
Date: Wed, 17 Apr 2024 10:27:13 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: SGI-IP30: Use bitmap API when iterating over bitmap
Message-ID: <ZiAGcb3eY/Nqamb9@yury-ThinkPad>
References: <20240417071830.47703-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417071830.47703-1-philmd@linaro.org>

On Wed, Apr 17, 2024 at 09:18:29AM +0200, Philippe Mathieu-Daudé wrote:
> Do not open-code bitmap_set(). Besides, <linux/bitmap.h> API
> allows architecture specific optimizations, so prefer it.
> 
> Use the HEART_NUM_IRQS definition to express the end of the
> HEART bitmap.
> 
> Inspired-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  arch/mips/sgi-ip30/ip30-irq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
> index 423c32cb66ed..bdafff076191 100644
> --- a/arch/mips/sgi-ip30/ip30-irq.c
> +++ b/arch/mips/sgi-ip30/ip30-irq.c
> @@ -264,7 +264,6 @@ void __init arch_init_irq(void)
>  	struct irq_domain *domain;
>  	struct fwnode_handle *fn;
>  	unsigned long *mask;
> -	int i;
>  
>  	mips_cpu_irq_init();
>  
> @@ -300,8 +299,7 @@ void __init arch_init_irq(void)
>  	set_bit(HEART_L3_INT_TIMER, heart_irq_map);
>  
>  	/* Reserve the error interrupts (#51 to #63). */
> -	for (i = HEART_L4_INT_XWID_ERR_9; i <= HEART_L4_INT_HEART_EXCP; i++)
> -		set_bit(i, heart_irq_map);
> +	bitmap_set(heart_irq_map, HEART_L4_INT_XWID_ERR_9, HEART_NUM_IRQS);

This function has a signature
        bitmap_set(map, start, length)

So this should be a:
        bitmap_set(heart_irq_map, HEART_L4_INT_XWID_ERR_9,
                   HEART_NUM_IRQS - HEART_L4_INT_XWID_ERR_9 + 1)

Also on the above group of set_bit(). It should be 2 bitmap_set()
calls to me. HEART_L0_INT [0, 2] is the first one, and HEART_L2_INT
to HEART_L4_INT [46, 63] is the other. Isn't?

Thanks,
Yury

