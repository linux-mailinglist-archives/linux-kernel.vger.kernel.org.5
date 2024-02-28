Return-Path: <linux-kernel+bounces-85458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1C86B64E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2712E28A4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221A15DBB9;
	Wed, 28 Feb 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ymi35g3E"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACB3FBB0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142251; cv=none; b=LVc+DGnubN2PR3z5a4ZIWSJHBIMqrTNi/shBTzNTPhdlX1Lk4xssWfA+ySqvL53Nf1Pfdy5Fcdd7khSve0FtUUxMbiDOc3vLiYP4AifDy+ZUp+q9BAgSOoh/DNKZGfcea0U3vdiP0w8zXnYg3+4k3BGiCFsdoJaZ7D36AsIeC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142251; c=relaxed/simple;
	bh=W6V/WUDrcU6ltqu9bzNaahvrM7LME69p9CtE6KRKCd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qGeuyO8GtFDi10GYyXbPZO7CI81ghAaXx0cFtMvx/SwjsegIfrc4fpoRzd43RT9+r+o6CHioMp/aA+8M6ntVeZyQ/6P64YuAIH7eJTdwsCgk0wCCVuiDc4j9uVVEtQqT1WkTHofmU5FODoto2aXFpornsLjsOptOHMO/lKcS8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ymi35g3E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412b4a12bbaso59905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709142247; x=1709747047; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQYfGRlMuAzV9NGrkcAH7hkAKHgrR0yYSvegD/d+xL8=;
        b=Ymi35g3EEvkMiXXIouWabZ77SZcpf2PnI9YixiRbeWetDQW5jVnR0/tzDLx6B33lb7
         mEwhM0o+GsJ15JdH2I6QtSJLUYiyKJgdytf/qU+QbIwuGU7J+3R23l2p8jLII2PFUyCt
         PceCeRRomVtvwV+l8Koe0VfAakSwMeFBzADIFlk6wqyuuT4YvR+uD8GQ7aDsv8xi/ICF
         06tkgwhsxkzWc/Q1qG/b0shlaVDg0dwtmk1SxZu68jzKN+zpn/QxyK6D8f9Tw7DRuhVY
         KhU/LS6YLpruRlZqJiJIGkW+IKx8HruMK4gJC4BIGSShmpPYew7tLI3BQ/QpP7ICcQK1
         b1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142247; x=1709747047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQYfGRlMuAzV9NGrkcAH7hkAKHgrR0yYSvegD/d+xL8=;
        b=B9GAfJUKDhxZO8cJ8D/5qyCWpaVrB4icbaUfplQYAxnwjMtXMyBfE6TyJX9BdByBNa
         6NEauhylqsh7892l7WUahG3PW6oYQ1AQuUTATnnZ5JfdzF9PiFcHJtyNVW/8phI0VADf
         uYq5JDBLu6cq9XGybSTVaDWXvWbyz+K0ylK28x7n0dJLoypTWiB7lsUpUdqG4ZJN5r77
         8EEySx/01EV96U0drwDNJjqsFFSGAuq7XAdV8uePScH69IdNbwF9GjHbH2dlQmBNL1uN
         DisVug3X8vwSy+YTmIcoIVngz4fk37/mOCpF6pC+bXNmbcJPNA9bwRjB7CSIrw/5kAGK
         YaAA==
X-Forwarded-Encrypted: i=1; AJvYcCUyWUpGxpl/NQegIoR05ji3jwAbGPDIDjIB6W79JbQLE2Yj4l7eV9sltmn4aZlQCMZ+x+M4LdeeH6TK0BRrHjM5duiPIia/hq84791v
X-Gm-Message-State: AOJu0YxO+NSgSRRsyjkrhUIL3BpuuRFD4W4OtHCorGtpi1oOzAdyjVYP
	AjEL9I8neK0OupR6BmE5XQ1pWSLFSgG4Cz6/KRO79phByEsqwIA8Is+qphRjotY=
X-Google-Smtp-Source: AGHT+IHOwDyfmepDmBoQvFrRKQ7FFwyrzLDzVXnTAg0OSmmsmnEyu00VFewWnjH4ylk3CMxRj1xMVg==
X-Received: by 2002:a05:600c:468f:b0:412:64a5:a21 with SMTP id p15-20020a05600c468f00b0041264a50a21mr127317wmo.40.1709142247357;
        Wed, 28 Feb 2024 09:44:07 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d564a000000b0033e0523b829sm1008975wrw.13.2024.02.28.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:44:07 -0800 (PST)
Date: Wed, 28 Feb 2024 20:44:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
reading one element beyond the end of the array.

Add an array_index_nospec() as well to prevent speculation issues.

Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: add array_index_nospec().

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b7a1fb88c506..eb914084c650 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
 
-	if (index > dev->vq_num)
+	if (index >= dev->vq_num)
 		return -EINVAL;

 	vq = dev->vqs[index];
 	vaddr = vq->vdpa_reconnect_vaddr;
 	if (vaddr == 0)
-- 
2.43.0


