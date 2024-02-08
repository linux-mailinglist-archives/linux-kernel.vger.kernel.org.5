Return-Path: <linux-kernel+bounces-57698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A193584DC7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F601F212EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD196D1AC;
	Thu,  8 Feb 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asaT2fk2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D66BFBF;
	Thu,  8 Feb 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383461; cv=none; b=f1zye2SieKH2YsuxtnDt3z5FaJsj4i3fFeMunpggFu22XVIu+nvYDB8ttRZvjDKcvezObhWlpe8H+6earKjCP6FAStpMQ9tXZvxWNMRSlNqDUHFlm3zqQthB43zCRSCTVm/AXz04LCalELBnhX1EY3vnF4xhusWWeMsOvkTODjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383461; c=relaxed/simple;
	bh=xztAfe8NIrTxTOh+SaDpX4UWTD8vUatoOqQ8o2Ddmg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=to+n2pTADVh14KcQLz3CPi8vhBfId1PxmqTaKi/XsMs70fe93WYUnjdaJUIOxbJ5hhsqQbgHBGvq1L9lrs8a/AcNmk1GKsUoKqPOuAQCB98K68ejenSrS2B1BEK0DE/nnHBg6m6k6+LwAymyREDma/cWGAvJcM1laLntWw9VF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asaT2fk2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so2340172a12.3;
        Thu, 08 Feb 2024 01:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383458; x=1707988258; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jf+IpQUM3GkSU331X0U1mVeh/2v5Zggac5yTBr9mH/Y=;
        b=asaT2fk2xxJru586BZ+omuHroe8lydrgxo0As/jFX04Hth9G7aFXQACRK3TYGNeZuF
         0aPgVTg7Cmkm9KS3JQYM8TRlAa6UCNPEV8p5VNpH5Z40Lezunkt0e1gW2bsmyhbSlOHJ
         x5aV9usyuUQFQb6AylAQbsZ2wbpsd24Tj1K7DImI+LUzBNiezEwgFPNKuowwP+w3tIhy
         ycfqAUfNwkO9/294KId0KITjyxRN/NgQ7F/1c8zd44FV4FGCSrG2mqBZN5N5qBq2rlAT
         XmEPIUAtwQUnv7X82Qa0kATo41h0BzNmiJvc+Lf66Ifw9S1gssgK/pakhYEnOJ5Wq3XA
         HQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383458; x=1707988258;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf+IpQUM3GkSU331X0U1mVeh/2v5Zggac5yTBr9mH/Y=;
        b=upfok5SaJU5zPzHyTv/FAwUdM7R04c8kXW9vRpUg2+sN3fieOVRq3JXr7ayJ41Ykmd
         rZai7/yIbXuSGisyXMcnvUxKo/V3KHnVnERrAJen7hR/eQbw9d/5Ka6UlC8K9Wb9Rbnw
         RvuntuTyKMime3OXLkBbnFXXFX2uY32+1uDTop6nqnEt1nu52yvG+GriVQMLTS+wHYXw
         YNXyVVAlIEIfSK4pLiAIVuI3gdXm9gdC0cpxQVWdWPcw9XHmTXBI+XYqd9VOFJZp+ZZX
         b2Bli2NWtT+bU6huXsnJ1pJ55RnwH19g71HmBc1rued+C5l9tjD/uM1yg1QdWgqrcDaq
         mizQ==
X-Gm-Message-State: AOJu0YxHYuyj45uXSeRGkveggOqdDL4UiVDuDdiM0XEAzG8GguZDV5zj
	E9AGpdYxT20+ByL1CvJQQSShUiRJS1Tb5dN297t6xujPyoyBzrNE
X-Google-Smtp-Source: AGHT+IHLSmXltAPAHNrVTintZ+4Trcvv/+wBCABaTPXruhUo1Rrh9Ii7BcEwfOcukmmsx9Ia6CbUnA==
X-Received: by 2002:a17:907:778a:b0:a38:174c:c985 with SMTP id ky10-20020a170907778a00b00a38174cc985mr5328923ejc.63.1707383457589;
        Thu, 08 Feb 2024 01:10:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMwbC3ZfT8JJu+zXu2Yw6lHz1u5DESJSr8MH8BvzWT14jYqm+iTCb0IHHAoyL2fDe/D8vqzajCtcA5zPvaWZrVjR2Ojcx4b5/r/COxIkVqAfRj+f46e+9eTvKT7hx3pDk1tNbHYc8CevniMt2d+D9GqslCKg9CgsixRpjGDdbw1SsCJxmPrRkYBYuCFxe5axO5FK5phtTHKV/f6t0g
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:f81c:5b24:d269:24d])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090646c500b00a38535c6be0sm1691887ejs.16.2024.02.08.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:10:57 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] hardening: drop obsolete DRM_LEGACY from config fragment
Date: Thu,  8 Feb 2024 10:10:45 +0100
Message-Id: <20240208091045.9219-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
References: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 94f8f319cbcb ("drm: Remove Kconfig option for legacy support
(CONFIG_DRM_LEGACY)") removes the config DRM_LEGACY, but one reference to
that config is left in the hardening.config fragment.

As there is no drm legacy driver left, we do not need to recommend this
attack surface reduction anymore.

Drop this reference in hardening.config fragment.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/configs/hardening.config | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 4dc0cd342ced..ed126d7b5e83 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -92,6 +92,3 @@ CONFIG_SYN_COOKIES=y
 
 # Attack surface reduction: Use the modern PTY interface (devpts) only.
 # CONFIG_LEGACY_PTYS is not set
-
-# Attack surface reduction: Use only modesetting video drivers.
-# CONFIG_DRM_LEGACY is not set
-- 
2.17.1


