Return-Path: <linux-kernel+bounces-162955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879AF8B62B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48332280FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5377142E6A;
	Mon, 29 Apr 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzmK9r7p"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3090141981;
	Mon, 29 Apr 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419588; cv=none; b=OwjxnyRaRWodzPByjwMDmUPOD8zA9f7S+rHv2onuJ8kvF/Enug0gP1YuJp3+aL+SNufXVusFLf/FdXb1y7yM3h4JxrE/miMWI+TK7+7H3uns4eqmP6hNH12HLjH8w+nK9mY6+zCGjjsQIVJ3NygeLgYdd28fh5pdUiqspEjGME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419588; c=relaxed/simple;
	bh=CY5SSg3Y/KHWFF7uTYbBZ1nnlQ7TMQuqoGmTfXWEFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQgLdlIkBfS7sBYgJjzhNwJfw6YAX8wBloni9HKvesmv9rEyHmvVjXU+QaUcOUH3luplD/dFMCm9QhYwFP9imBe9HJ/dKNSBVBJHPIFtURfOdLrLFtLBfpiPTdAJPPEV/z9QPwr6sxbzk4iIajR/tmwDtI2BG1A1VBE0To7463Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzmK9r7p; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7de9261da9bso243920939f.0;
        Mon, 29 Apr 2024 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419585; x=1715024385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJYPCWLWtk5u9OuODPiVoHDlhD50vJ4NXaKLOLuEW/c=;
        b=MzmK9r7pZXSka3F25MX7K2Pu/JfBqD32QIJXfU3Leo10SLZ7ZxDlLSWpTIItF59DsI
         ld/SbKEZpcrlGA0/jeiPnAQkRlAXCe1JUYiUKbEM1nC7oGLal6o1Zu5qS035h5tDkzFo
         XBG1K4SyHVrHeMEMuDCYzlUchK4X8UMvKAw0+HSz7UIcvBd4HTrpcwO2njt39prI0ZiO
         pMkSUOrAZi5dBZz4hCqC4R3n4WUbA42haqhZOpRkctIZR6qOmYj8fi2pmQcstH9jtSfw
         zWVNRrQgXuzXgbhNz6CR6dcK1TGnS/NhzWg1eEZjjqwJ+TAr65Yj+pecaA0fv7VzRxd3
         BRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419585; x=1715024385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJYPCWLWtk5u9OuODPiVoHDlhD50vJ4NXaKLOLuEW/c=;
        b=l8WURulGCTBJkrt0v6N4t/XU+Qe49ApFinyMRF41b+Ka79bW/R8vLIuKLNLriWauuj
         2M0Jd0Xhv1UJFWfWxeUFYekLKHAoEGsQUZ/tzjw5IvhljadTTKBninjVLyMOfcVXH0xF
         UqDvNjFRx/jQVNyoocmh73L8TMmpYMJZjnXfnqenK9Z2rZY84RgYG40IWwmr2Q7OAIW7
         UEwLaTqsul3+UQkX5ztSwxvZ+0ABA6BK4SAXg6+yS5vwr+YplEIZFjUWV8zz1xe4d23Y
         pspMBGGH12hMxVJKqoPWmgn0y0bSjXyHktgJ2CLSJayqmXqcSjxdFnur6iwYiyxdycWu
         XEDg==
X-Forwarded-Encrypted: i=1; AJvYcCV0hUpG3Evs1wKWKzo4gHT1pgRCSiBLKx0VLgZFhwalh7GAjHLmvKcr2RWFexBL5ExwGm/WrzIFIx2dyCVMCvY73uqMfNH77RbmVtFv1h7bfJOqtpJwN6r1Wi0NAtPrm0HSBBYTNOF5
X-Gm-Message-State: AOJu0YxDzuu848sj1cgNNQN63yBPuqBCKvDDtd36HN0Cqp1J7f//ysJA
	mHcY3CLBqnqKiMLJKG6aGvqiV5UpOsKYKtenDSUjQNxVZ6xZaVMD
X-Google-Smtp-Source: AGHT+IHjOhQgOCcXtw7/jegYglzMKIrb6oRCN1PRx9oGSN8qw5xCJw9DpglxKehiLtweVV/J2JilLg==
X-Received: by 2002:a5e:9742:0:b0:7de:da61:7a3a with SMTP id h2-20020a5e9742000000b007deda617a3amr906777ioq.20.1714419585057;
        Mon, 29 Apr 2024 12:39:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 34/35] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date: Mon, 29 Apr 2024 13:39:20 -0600
Message-ID: <20240429193921.66648-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Time for some quality CI

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5a0c476361c3..b2ea73ae48f0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -54,8 +54,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.44.0


