Return-Path: <linux-kernel+bounces-162956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428C8B62B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDABE2856AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DD514389A;
	Mon, 29 Apr 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROLnCNST"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84A1419AD;
	Mon, 29 Apr 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419588; cv=none; b=hVYC2BqkJOVXyPdkkN74FPuLDkkdS4MBaDnozqr0q90xI/fV24z5WPIQQx0bwPdmob70hjC/cMvp+jR6VTCe9n1M9pLrny2LO2sZfPY2x3kd46jasf/DJPlAncgmJ57T4/qTWiQRnQCKbjl5EzQ8s6vEIZgc2gYY+BJFUCZ+wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419588; c=relaxed/simple;
	bh=pDuYHUWb78NUezMer2s4ZMlqPswwqeKYYv0uXixfqXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bapiS5iH+26Vr8q1FMkoy3p+FsPEPTsMdpOTq1bgalIM+VQdUEeE0Fgsfd7r3biQelJ5sKbfvGWceHcYl/Rnp6mW+nNDAemZTir8A1k/ToeJJQVqNGKfR8Qi+F7xF+q4DH1ob8xIfMh8nLbPwmxS9p1vfdQ2Gdwew0yfjfobQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROLnCNST; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7deb424da41so138744539f.1;
        Mon, 29 Apr 2024 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419586; x=1715024386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvtcoSNmHJyPK9Yxvdf/16D7QT7gwaP1R4zyZ6VaX/E=;
        b=ROLnCNSTu3yYd2T5SodL/QjyuxSTFDTtHa9j9mSMcUsEMhwres7nFNDjRnAge+jlzV
         pAiBr/0mG2nsQy/AGWVZk/8rvixUuN6cG3IX6BlSSmXAfC31Dr93Jy74SP3ca/CXyj4x
         TtelDeEd1gSv/2FQHCGTFURV4OdoKqWjQWLBdlHbWkUpkcwBx5EGy8k9EA0jJG/0YI+3
         GR3uxfMvz6PGAr72N6ucmMp4QDCEPgKNkbdmlKEYG4XiE9RHJhgX7w0/Tc6wbWM0RnsP
         wkpWVS81y8myIf8UiZm0f6iY9RY1jOlqCqcaU9md79Bw2rTvrh3khF9gieKhPoN2pBCm
         Ubew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419586; x=1715024386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvtcoSNmHJyPK9Yxvdf/16D7QT7gwaP1R4zyZ6VaX/E=;
        b=ImcoYr17w96kwhf9ezE9CIG8RA4A/vk5z0dXDAjv9q41kVLi96MkEF5yYu99XjFtur
         cJXmHKh9CPjUnYZBtldUIJWcZhlL0CY7nk7yXlE8GxyHyq9rOlSO3aKy7MIlVQrdqugu
         II/5KTUkOyQ8DQvFBBTv9m/vVG1dVc6D7JXoELpmzWiqFXQS0spmhgpOHdVBgkmaBqqe
         fJIUxPLHXg8JRpzkkSbdj5i/oE+2WoXMRKM6i8JSRKddGwBrll2QrjK5q6f22SkP59aI
         RBEiiV6Ak5RGJF1TKE0ksKeOXqHbpE669dz34z5BhpaG2ipi4G+zfjfm5amvqee0OjfV
         mgvA==
X-Forwarded-Encrypted: i=1; AJvYcCX3P3+/KNvTYynsSEgT2SsAznS0Cm3FyvtT3w+erS/TlEru6l63tYR97h6Jnltyq4yPbKtdDN1NsdA0gxBDOsL02N6+m/DB/VfbOLkSiVpnBVgE9XOxnthCRJZLvw0lpgJFswgQqskM
X-Gm-Message-State: AOJu0YyMhHQo5gqQLjB68wZXhnXkj1UNzuCrLV6zVePtIsWabOLYOV67
	j4tgVMaWm7Z4I7G0UQ/J0SUCDoYSN2Sq+XeMxcwkG3jGxxSzy1O0
X-Google-Smtp-Source: AGHT+IHSnDWahXuoiSDXC0PbzHzDdWYaT2zAER4xc4v4brlYZetM7hGw+hMRIEMbRLILknW0hU1xag==
X-Received: by 2002:a5d:9492:0:b0:7da:67fa:7da7 with SMTP id v18-20020a5d9492000000b007da67fa7da7mr14361568ioj.3.1714419586086;
        Mon, 29 Apr 2024 12:39:46 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:45 -0700 (PDT)
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
Subject: [PATCH v8 35/35] drm-print: workaround compiler meh
Date: Mon, 29 Apr 2024 13:39:21 -0600
Message-ID: <20240429193921.66648-16-jim.cromie@gmail.com>
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

For some reason I cannot grok, I get an unused variable 'category'
warning/error, though the usage follows immediately.  This drops the
local var and directly derefs in the macro-call, which somehow avoids
the warning.

commit 9fd6f61a297e ("drm/print: add drm_dbg_printer() for drm device specific printer")
CC: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index efdf82f8cbbb..c400441cd77e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -183,11 +183,10 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 	const char *prefix = p->prefix ?: "";
 	const char *prefix_pad = p->prefix ? " " : "";
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	/* Note: __builtin_return_address(0) is useless here. */
-- 
2.44.0


