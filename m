Return-Path: <linux-kernel+bounces-85529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445886B71A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82761F23CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866D40846;
	Wed, 28 Feb 2024 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joQFw1pO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691B40847
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144654; cv=none; b=XIEEjY2lVVc5LhNerFYzy7gMli5FodmRuRKggWf4bh6v7eS9s05kFq8zp91t4mrEvajwYK7M2FdJLVq1zO8G1ghgNgoqOuBDiL5elJR7Sg+pz7S6LZHZ0k5tC9zv2m57eQYCnBFqi4h54xQo9ZvB00CwX7ZnCEAUtnvitA2v7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144654; c=relaxed/simple;
	bh=r81XQMf23teX1T+JGKRU64I4W8Z8plFKuxG2dA9W0e0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JCBWLSyVeDskxfPVBAVU47aKSHXFDFJXANOdP45oR+dcrgtunb0VSrlSSuYp/IhEav4DivxYKLHndmnLX8JaqQeAPBjrYJmfL+5Mw9z/djXxz8Kdl71yLCE+Amb+wLuFAGROl0VkEm90wbu03piiz+xQKTrpsymPydZ8oQDbMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joQFw1pO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412b7bb0bd3so299395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709144651; x=1709749451; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Qz1dKrMSqcJN7vhekUwEPSMU/YeVaBN11f7/M4F1f4=;
        b=joQFw1pO5rSKT4ik+toEE+KLxABAeNEwHJ9bgvPrBH57WAqAZF45Q2eNXGmArQobII
         H14UpvAfd5yEx9YkWald8rilqmwVzYSQ8l3NUfFQGb90EekzxaETh7pcUjnoBOItqCTV
         Ml5haV6XcRJpbUbM7W8bhN9fDMuuuIPRYZCJ8X6Pr39V+sacyf5GzCLAUqBaHgTgKv69
         3OD0lGEvF768gLee0+GVxREkHN/qWfbwr4/3jRR5tAwr09Q85ltW7B1s0YvWlEhjdZTV
         2doyaAzVOv2nlKr+XlZ33h20HhONxLGj/aSxgG20i6mrA34jcl0n2DO4Gl9LqSfQLXAy
         dvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144651; x=1709749451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qz1dKrMSqcJN7vhekUwEPSMU/YeVaBN11f7/M4F1f4=;
        b=TEd1boNS07Q/9XHjgZUEeShf/27HCfQedEe6UdBn85AJgOU8N2FrPkbr+qKSSDDfDE
         Bq+r6Hpo7HUuuiAmwO4Kfq9PtM9VI0AzdCyAPpKYI05Zmv3OcVHQxjWp0QIgWcqu9GeA
         tWUOgCtBQAggLogd3SvLjjlLacY68NOPjSclHVMq30j+QNI6/ghcRCu6kZnOWKKCVOft
         O5wCG4FoEWwSRpnRXyDNHbEGLbDO+uKx/Ix49lN4wbQqqhfBKSoNxkzwDGUg+dTnl9lI
         ta386nN/joSMlglJ8lTs+xRRhhBQptdXrpPCeLcn/o/DxLjkP9QzOo4NJVZw6MhU3SfR
         4XGA==
X-Forwarded-Encrypted: i=1; AJvYcCXuhKDsP/mjHEq6fViZwXXU7Dp47a5PDnsv5uJNv/5I/cg07u4HmEYhwTCOoKLG4wlGOAL9SO9JfXVhX5dteFT/2a3nndZI3YoW0k4k
X-Gm-Message-State: AOJu0Yw+/XdTFoi++ZiUgOmbdbUJR3DvTpU/UE4l6r24bOcwRC76v5aC
	PqHk4CRn5+boQ5rYGs9GygDKP3KLACiQIMMZ+CtUK352QHqIu+XJpUK9ztJwtoA=
X-Google-Smtp-Source: AGHT+IElRJ3gqeiSGlL5qwYW93OYT6mf3vu1RfSzg+Bf0SkGa+KphevMjr4f+hkHMRduO19FmMIfEA==
X-Received: by 2002:a05:600c:4e90:b0:412:b659:1ac9 with SMTP id f16-20020a05600c4e9000b00412b6591ac9mr58808wmq.11.1709144651138;
        Wed, 28 Feb 2024 10:24:11 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b0041069adbd87sm2781312wmj.21.2024.02.28.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:24:10 -0800 (PST)
Date: Wed, 28 Feb 2024 21:24:07 +0300
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
Subject: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
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
v2: add array_index_nospec()
v3: I accidentally corrupted v2.  Try again.

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
 
+	index = array_index_nospec(index, dev->vq_num);
 	vq = dev->vqs[index];
 	vaddr = vq->vdpa_reconnect_vaddr;
 	if (vaddr == 0)
-- 
2.43.0


