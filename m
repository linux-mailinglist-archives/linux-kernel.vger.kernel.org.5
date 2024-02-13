Return-Path: <linux-kernel+bounces-64060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F5853987
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C773B1F2487A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2D605C3;
	Tue, 13 Feb 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4zBG6bU"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319B605B1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847811; cv=none; b=ZiwVLU0gZT3G9k0NcU6VUHOn6UAAU6Iuc371N4xqXEFTyGVMp5eMZHNmvqx+IhPy7vPhbi/+LbYDAjmobK3wXNgFPOdShFUbvRGy29WQuxRIbBQoz++ff4ctVdYd4FAZbMcJiEjU+WvDDxcjFW9mwIumWHCqbjFk4h3EEwBYFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847811; c=relaxed/simple;
	bh=UNgcle+d9r14K8JpjkfYo0Rz2jZg7GDPQvbA5DnyHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fzB5NWaE/fk/v/wgKdj5hfKkp6/+pQBMEC1QmAtsEqnN4aNvr/P8mbHicz/+0zrft5XenNZUZdcXkyhZ5VZhj67Xaa3F4AsoWOI/0I0r9jRK9R1JoD0YD60QNWz4/tLfY+yGq86+OmzoxLrvbmOsQHQ+zixlMQ9j4HVEc8HQ0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4zBG6bU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so7379215a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707847808; x=1708452608; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziAomXuWT8MH5zr/8s5imuynSnI7dntU0jZc1Z9tS6w=;
        b=W4zBG6bU2FvscZnF/LLJSIHajEUGwC1vc+FSoQi5TriqhYmN98o7Sr/xlHE9pUwlfp
         6KkjTqgqhkgQX/nEIHGgqUAaF7VpAO4DoprpWFSU8YP4Eu/S8uvqa67+zDMm9Ym0hIAK
         /fUwrxAFV3MuVFQ4WvG2Bo/EfUlTncZS/VEyG/UwS+EYIxuUM3Q+aAO0EiBxdk37j6Rr
         kvCLqZbZxVtpEQdu277HyQtLMBkKA2ip+8Zy5x8bU5eKGrIFwUw29RndP0eI+HQrZUh/
         FTwaINLBc43EsEq/Vn6Ojf8vp9rMNjohWvs4WMIH7ikUQ+Cajuh3tEoc+mBCq/4M9/dI
         WZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847808; x=1708452608;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziAomXuWT8MH5zr/8s5imuynSnI7dntU0jZc1Z9tS6w=;
        b=LZVihRbwJFyzFSZkJKuS04WZ1m4x/XXKCYqLRYJdR3R+y+YryjMMbQrpj8AEl/V6Bn
         qayYh8u1ooJin4LGfjeDmMpl6bR1v/6f8suTZ9PpK7yIqbhvU+6xQd7BS7sc8KZKZyJp
         9XiPC87vZJfAtsA9uKgitELIlGkpgyP2qSy/4avK1LMOA5Qi5r+ynWGmepNgHgBJWl0p
         BNsTfxUT3/3tz8e1iljT83ajuD6q+lGg/Mt38Hdc6AnZeWKgPKIYxaq5pTLAvDZeNTry
         UOzOBLFJXV5yHdnEBmU/R7KhJ9bygPKxk+XXjB07u2l5k8gHqRkNMoBb3Bu0uBxw07wG
         m4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiBUdtysvLzmjdSqc7U41KxfgnxwBVipAo0EK2Gu/AcQi9JZXSnPAKWnQ+7h3fI/GGVd++Q2GFGDMVX/T9NLNjCycNEVpogajx2fR
X-Gm-Message-State: AOJu0YyYUqzVk/hiSODie/L6b/CD8ebIuectienkCp4Cjh5MrDTha8ae
	WJO7wMnA9NHRpfsP+CFROdeddKG3wmhsD2VU/4d4o0AKp3zAKR8BZQ80GKs8cnk=
X-Google-Smtp-Source: AGHT+IEEYP79160/4gREQSMT99NQJR66fKb5tUCe7r25eVUrmQpy2NIZzr9MrcCjSU/z8yF+NtlVDg==
X-Received: by 2002:a05:6402:2c9:b0:561:a444:8e49 with SMTP id b9-20020a05640202c900b00561a4448e49mr321854edx.0.1707847807927;
        Tue, 13 Feb 2024 10:10:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKqe9LXaXCTJL+0+XDewhVE3YzUr7ESGe3puDPcSskby8iGkPYz0oTenO+aCQtAlemdNeKRkzKYJlPZOsdV/bkrYnGTABsLqMej8xFl5Venr0cVbu+kUwioToW0tuN37GrnXm1zl8RNNt+PmS9NRMOlig5wSYbq4nHSKJpn1Gxs+/FrLQnUB+R+1pZL8dayot7Z/MxtO8CbqlbZbNekuTO8DqhNqGbw5LLLxeAvovKEdJcQctLm/+1+ctUpF5TT2LAMp/333ubfflOQkXZxMefbY8cKqI/KPZcGSN/N9/5Knu6C059CGx3T0q9AbJAMzqc4sRCchCipGb6gWHlYZ6n/fkcMtUhnfoy5BIRRfR6rQ==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b005606b3d835fsm3935468edw.50.2024.02.13.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:10:07 -0800 (PST)
Date: Tue, 13 Feb 2024 21:09:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/nouveau/mmu/r535: uninitialized variable in
 r535_bar_new_()
Message-ID: <dab21df7-4d90-4479-97d8-97e5d228c714@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If gf100_bar_new_() fails then "bar" is not initialized.

Fixes: 5bf0257136a2 ("drm/nouveau/mmu/r535: initial support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
It looks like this was intended to handle a failure from the "rm" func
but "rm" can't actually fail so it's easier to write the error handling
for the code as-is.

 drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
index 4135690326f4..3a30bea30e36 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
@@ -168,12 +168,11 @@ r535_bar_new_(const struct nvkm_bar_func *hw, struct nvkm_device *device,
 	rm->flush = r535_bar_flush;
 
 	ret = gf100_bar_new_(rm, device, type, inst, &bar);
-	*pbar = bar;
 	if (ret) {
-		if (!bar)
-			kfree(rm);
+		kfree(rm);
 		return ret;
 	}
+	*pbar = bar;
 
 	bar->flushBAR2PhysMode = ioremap(device->func->resource_addr(device, 3), PAGE_SIZE);
 	if (!bar->flushBAR2PhysMode)
-- 
2.43.0


