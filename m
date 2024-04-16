Return-Path: <linux-kernel+bounces-146746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDB8A6A39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23291C21116
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB212A15A;
	Tue, 16 Apr 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6R8VmxA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D896D1BC;
	Tue, 16 Apr 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269217; cv=none; b=cwQcMt3avox2sUpTbINcKKqIJvCAMl5mKre9gx7XsdADejJVHC9mgy2JRY00GHlSfu4TbHnUeBC/DRhq9+5JuW7Sma5XAAmy6F/KD6fH45SeppqujxU1E6WMl3Nw8vITAtwP4f+NOhmVweJFjPwNoiEpLDVMnHr4u4TdbmymDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269217; c=relaxed/simple;
	bh=aLGjwKsUkhJyDnihkDIIByyYkg6df93bUPXuv1sTlYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxRDTcg6gEI18xy/v84KvoJ+xnNqKg0kW11HJxNwuo0hPkIRHG5iizQllzO1ncQBT1cp1MTgJowFUPzMg8s63LQIzskN3FMBiZi/UuEdlLEB09LeQuem8aA5N/v9c/TI/nKVt3qTGtVK14c0HleGMLsVR5j9D2/aXufimQeCBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6R8VmxA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ca546d40so30651725ad.3;
        Tue, 16 Apr 2024 05:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269213; x=1713874013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bxCFPrPN7YYp9G6q6vxreo9zNUW585IcR1CQUImrPQ=;
        b=Q6R8VmxAdY4Pt2XUpv6pcrpSQ1+YI+Ba+uHmHjzl10T2QLlic3Fq8rQEXUdKvb7+Ne
         Hzb0TxMXjTo4p9uRT4wHQw00bOkLkKCEmvKa9RTTzBaE95mbOpz6j3fXtG3/DJZEIngN
         WhF+NgtXkQCBPD/QBHeVosA/+HMxfGUCMbIsI/na14hI7qBobAWUb7SsuV0/IHFqE0aW
         SWNXKM5WKOL8UCBK2Xn07x0PX4ypYuB2eDME6NLNUSnCIQ73EYsfIFZq/2xi4skVZf1I
         bsBLDfzMxp6EBNCa6gGiUIpoOLphbRf7xk+hNYrG3vKDimYVYkYu6zCN+AbGI++9V5Eo
         RDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269213; x=1713874013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bxCFPrPN7YYp9G6q6vxreo9zNUW585IcR1CQUImrPQ=;
        b=wKHDc5qZWkZe/E3BnInD7qreZC9QdAIJnuQ7NzU6mOjkJ7X64a+u4v2T0YtE/aLWm2
         39yqBlsRU+7tmaiR50KdU/JYEvVX6J66aK20g3zOxewZfPEyeNCSL3t29AT/1yY2C5Py
         ZWKoXkMazGQdIHBrN/mBNqVebmykx1TnL4fQM6bOtzBxMZW8EWR3Ls0lIf52/9rKQWHE
         j4qwSwLxIZEy4osGzaWWSkOeA5eI4LvB/4GSwROfG/ddTW56LPb52U2xujwxUF190o5O
         oQfhuL8BRQylD6CvzNdyqmPR30jjrd7pkHYDBqzlgDfRemI4Dek4I/v6wYR0Be03ZVfT
         G2gw==
X-Forwarded-Encrypted: i=1; AJvYcCXlyLhe74eGBTvYtKcd7Vw+R7njIGDPuOKkP67d6/j/xIG6ikxjTsJxHPfUNLYYyhsHRCOudEBusHsD9PrMLwQXOaPZbX/m4wQ+NC1D
X-Gm-Message-State: AOJu0Yxxqk5af00seGx9GUr84U5m17oyB9p28F1cZsuyPelpam7UlTF+
	wAsVPJZyuEVrzop6yaODcbJO7tTQTFjW8lH0CtUxPrGEBX8/KauM
X-Google-Smtp-Source: AGHT+IHJUj+W9eJafOlJEfgDLN0EndGh1v6rprUj/GjSniPiLyQ1kYUQIqtp8KYoLEs3BGKJk++KYg==
X-Received: by 2002:a17:902:e9d4:b0:1e4:1bff:1f6f with SMTP id 20-20020a170902e9d400b001e41bff1f6fmr9339067plk.50.1713269212500;
        Tue, 16 Apr 2024 05:06:52 -0700 (PDT)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001e509d4d6ddsm9813684plk.1.2024.04.16.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:06:52 -0700 (PDT)
From: skseofh@gmail.com
To: robh@kernel.org,
	saravanak@google.com,
	rppt@kernel.org,
	akpm@linux-foundation.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] memblock: add no-map alloc functions
Date: Tue, 16 Apr 2024 21:06:34 +0900
Message-Id: <20240416120635.361838-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <linux-mm@kvack.org>
References: <linux-mm@kvack.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> > From: Daero Lee <daero_le.lee@samsung.com>
> > 
> > Like reserved-memory with the no-map property, there are memory regions
> > need to be allocated in memblock.memory marked with the
> > MEMBLOCK_NOMAP flag, but sholud not be allocated in memblock.reserved.
> 
> Can you please explain your use case?
> Why do you need this functionality?
Thank you for your comments.
I added a example to the commit message.

> > So, functions were added that find the required memory area in
> > memblock.memory, but do not allocate it to memblock.reserved.
> > 
> > The early_init_dt_alloc_reserved_memory_arch function was modified
> > using the no-map alloc function.
> > 
> > Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
> > ---
> >  drivers/of/of_reserved_mem.c |  9 +++--
> >  mm/memblock.c                | 78 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > index 8236ecae2953..504f2f60689c 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -40,15 +40,18 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
> >  
> >  	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
> >  	align = !align ? SMP_CACHE_BYTES : align;
> > -	base = memblock_phys_alloc_range(size, align, start, end);
> > +	if (nomap) {
> > +		base = memblock_phys_alloc_range_nomap(size, align, start, end);
> > +	} else {
> > +		base = memblock_phys_alloc_range(size, align, start, end);
> > +	}
> > +	
>
> This changes behaviour of internal function, what effect will it have on
> the users?
I added explanation about this to the commit message, too.

Thank you.

