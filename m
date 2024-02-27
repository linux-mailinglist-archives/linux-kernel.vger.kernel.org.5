Return-Path: <linux-kernel+bounces-83498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E47869A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B502628EBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2D14532C;
	Tue, 27 Feb 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ri3l2R7A"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4E4D5A3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047318; cv=none; b=ZqWHFewAlcL5MADUKbsiLhjoab2cssKneVgsi/2RRkkzL18C/LptknNmgykknIvfxzIwZfhgYSIDq+lf5FLxrbVy8DASsIOyg94TIYIFCJxwC12uT7QskHszXJU9xY0/1ocINJZW0ulc6PtNk5IMq9202tIExyITaOxvNPuUp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047318; c=relaxed/simple;
	bh=QsD3Iiv/LhOTtgVgR1olwTS+toXhr/zliUNlH+elpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m75eEfEcKt7F0JU8a/+eG3p1y13biKQVQ5aQzmwej/fI73ghphVij/OYWlAwWK0rhPVOfO84TbWINeY9O7EvcD9DeGBwTdE33jpQ/49+rRECg01glXKgBjVobSKJsS/GqTfdPKsieEpihvbGfuGua6AeF3bQdebzSRpa+b9JuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ri3l2R7A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d066f8239so3192588f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047311; x=1709652111; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAR0191YpG6gmNK9RS3NwTYy2tpEgrl20yHlWytzXZU=;
        b=ri3l2R7A+XrPEGDg6IcfpybA9G2bLkWtL9ROxsuL+Bs9als04aADEZjU6hoLdwWmxW
         DI1YwI6IpAeWNUkGBFLgwaQqRpQKetF6mIT+UwHGaviO2aPiYCgB3hDNeWLruViR+r4X
         ++HMzuE1EZ7fvxbMUk2E1q3IJoIUDw3yjXXiXCz2BMhMU1md//636IORhVO0U5pDAi7d
         7kzLuNr8YUPxlUZ4lez7BBG3lPDRcGjBMqw2/+p1vCIrCrKf/sKlOLFjPayhyYtMQAQ8
         +XSBdiT1IZ2L6lEA4xgjY2A3994vSge7hRfNEzO6v4D6XTf2dLqlqJbvdv1A0i0LgmnG
         WVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047311; x=1709652111;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAR0191YpG6gmNK9RS3NwTYy2tpEgrl20yHlWytzXZU=;
        b=Vi4yatT/Dkl09WYD4JOjlI7781rDZ9Yx5KCFCkyyvemKnQv1UlGSfHBI+CGLFgAYLH
         FyVf9My8uUh6Tm95r9XEH89rfNcx5gpKMobVcFg8W/pf4/zJruq+8RZ0XUZVlUlUlUeU
         0SoBEDu29CXOTlLecjdYBSAZKJT8X16Ge7kNx+w3w9LQCwCUUHFGoD3FHFc5olod2JQc
         QEnendj6QMvup5nn0o7P/1dBJY4omC2VuSCaJId6ENOEO3qLkRSh2oxJMJJMcxhXj4o2
         IH7ExRHcWEn/o+kz5o/kHPwAhBN85pnr9ZomTZrsSz2OdK5KNJvwbUyfeE6RKXPd9reb
         Qdxw==
X-Forwarded-Encrypted: i=1; AJvYcCUj2KdyK8NZxNJ11wD79dhVBOtBwzD1gjukYjEhiYufo42xxUBpeFumfRN66ZuAO6kAQAfI2VrLXLR9vDfG/gnApEKvZDKDB5Ly0De1
X-Gm-Message-State: AOJu0Yx8sNTPE5mtwbszI92UrlRhPxqxEQutlbnkOJEYggy9XajhUOuB
	j2jGBv1vfc7SDxKlhxNzh0q5ixejbIM8jG0+uV8VB47rTUnjFXp2HR+JzvqHERw=
X-Google-Smtp-Source: AGHT+IGx3UJwCU3OwYophAFSeMY+HT7j8jGN+JsrR+9BGVpaMQSzmvZQht8iS1eq9Il37PGPrMeIYg==
X-Received: by 2002:a5d:4f01:0:b0:33d:87e9:5905 with SMTP id c1-20020a5d4f01000000b0033d87e95905mr6160029wru.28.1709047311631;
        Tue, 27 Feb 2024 07:21:51 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0033b79d385f6sm11579719wri.47.2024.02.27.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:21:51 -0800 (PST)
Date: Tue, 27 Feb 2024 18:21:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
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

Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b7a1fb88c506..9150c8281953 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1532,7 +1532,7 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
 
-	if (index > dev->vq_num)
+	if (index >= dev->vq_num)
 		return -EINVAL;
 
 	vq = dev->vqs[index];
-- 
2.43.0


