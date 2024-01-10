Return-Path: <linux-kernel+bounces-22490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF7829E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3032855A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA44CDE9;
	Wed, 10 Jan 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mm5fn8Zz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8103A264
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e549adb7dso14826235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704903878; x=1705508678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6/BfkOB3X/a4RKJT/vAJvs9aWAmPw+IY2BZPxEX1WY=;
        b=Mm5fn8Zz4YkbMXw+LMzSJEf1gQlHgDFH5AE23R3ml7b13HqyhQNM3laVHHXlXJ1vZN
         MYv0Xq3YNIvz6BhknECt4sn/+Qa63Q3BpTM9pD23neqEbp8VKYf70rVXTPuwBBDFW3zQ
         Snkk1dyQZv/fJXWy7ntqq3ekE5maXDxQEgr/C/wwaZ7t8WR75i30Le5Frf0E2oH2aQVT
         XGMQxbhBdDzc4vlvIEIgnPUqx+uTgJ1XpCFeTQcpKO4RIPtQ2PmTj02HINotAuM0Fz0D
         nbdIyE7zj70tYJ/LqBti0M5FI1ArXQbU3VyJt07LrIt2mekleVQdl4Au6yTFTfMCoBMH
         Y+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903878; x=1705508678;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6/BfkOB3X/a4RKJT/vAJvs9aWAmPw+IY2BZPxEX1WY=;
        b=Qs/EBv/Sh7nsdiVg7OmViyn/Na3u21UHAgCo8mGOXdupE5k+FEUV4xNtsgPNGrInu6
         tAvREKoysp4OWcgjVepaOPduNDW0ounKHjrknS+IUJgZlqmV6n7RwG6xcUIAWXMo5r/l
         dS7YpuSymRVWdi33anjJiIulBfNqz62TPt+9XL0eR4s0hiIMoJNnMSvlK4C9SOk78YDE
         VzOIrVjUge9P+8zoNjLl+B09/q1DEbTnSWdh77K1r0PJ9fek/loEQ0qStFvxni7zB2Bi
         QLdz3jJK6bvlXvwRZ5OReyKCVQbDxNkg4G3+E0vSJPhnyd6J3ff6HCnY+3/aSd7HvwHV
         IInw==
X-Gm-Message-State: AOJu0YzYhHtwlNMy6OmAo5TE94+to0+GyX4sXtZNK9wpiHb8CzHMTHvx
	/bQGsSs5a2+Pm0k0GrdhNJ7p8ZEsstznfA==
X-Google-Smtp-Source: AGHT+IFGJW2y/e3roICrA8K9wFuh4EUFJkXNrLyEpHPqRYRlYSswh+UYKkdhr0qfFvxHn8GQE/wsvg==
X-Received: by 2002:a05:600c:5208:b0:40e:3654:29f4 with SMTP id fb8-20020a05600c520800b0040e365429f4mr665511wmb.32.1704903877854;
        Wed, 10 Jan 2024 08:24:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040d30af488asm2686451wmo.40.2024.01.10.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:24:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Christian Gmeiner <cgmeiner@igalia.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240110153704.1364073-1-tomeu@tomeuvizoso.net>
References: <20240110153704.1364073-1-tomeu@tomeuvizoso.net>
Subject: Re: [PATCH 1/2] drm/etnaviv: Expose a few more chipspecs to
 userspace
Message-Id: <170490387684.1887297.10058632363349793019.b4-ty@linaro.org>
Date: Wed, 10 Jan 2024 17:24:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Wed, 10 Jan 2024 16:37:00 +0100, Tomeu Vizoso wrote:
> These ones will be needed to make use fo the NN and TP units in the NPUs
> based on Vivante IP.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.9/arm64-dt)

[1/2] drm/etnaviv: Expose a few more chipspecs to userspace
      (no commit info)
[2/2] arm64: dts: amlogic: meson-g12-common: Set the rates of the clocks for the NPU
      https://git.kernel.org/amlogic/c/507b3e756ffcb174d383dd05df5084aed9bb6d14

These changes has been applied on the intermediate git tree [1].

The v6.9/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


