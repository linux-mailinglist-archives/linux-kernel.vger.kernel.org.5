Return-Path: <linux-kernel+bounces-150815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC848AA4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F391283E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F1199E9B;
	Thu, 18 Apr 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIN38O6a"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF7199E87;
	Thu, 18 Apr 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477127; cv=none; b=EJWgM0kZt+UOZ7wgneZxheM0JEFIoPDMEeSnzGiyL4m9zBLrURhqYp4801HoVDzHjjhgrLXvO1KFXrsCb7ZfhgRDtRanbg3izSIUjIZ/7vxGJYulsPhAoiDiNhNvFFaoKjqy3/Q+WQe6dIQO9M2pQk+Mu3aQh3FnOKpYxUuQGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477127; c=relaxed/simple;
	bh=u9w0koOyrXHDNGQ2JZWlE7REzf/app2RdDcoENY+Es0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Iu60r6VSKoiT3WSpkxNacN6ryOZcq64sdAX9S67Jq8nHhck5Z4oJUGkXNbmrcamE4uC09nXfj+tvLvxHRXDpi8/LVRublgsBQ08zA/8L/C/P7R9ip6ikWr6T60laX2FWTUs63z5b0DyQ3Td+Pxb0cFQab44urKPweOSWrtlmXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIN38O6a; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34a32ba1962so618685f8f.2;
        Thu, 18 Apr 2024 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477124; x=1714081924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Sta3zja1Zn6ZMjwAn2JaaKTmw+SVa+2lRhvrmyccIk=;
        b=MIN38O6aDrnBnRJMFYVVHBP85NIq+Vu3Oc/8Y4LZgCNXIS3En12JC8bosptGI1N1xn
         YbrxYcl3eFRxJlQRj6n/Xhq59rNenMc/0owqDNvND48ZXpMwiO1qZwTG9rqQKhb5cGTU
         iptXw/7hvjJAeByykFtZJmQc3YSP0EIZkI3let+4SgTQj0A7shaH7kcqN3BF4suJISoe
         sx4OQg7VPfv0rokmRQAnBONU7LYajAs74PY+uXIBJwcGpg7mCr4Bj5dgW7YTQgna2bXo
         06AY8kHOn4ZUVu624m6I16ZWY9794rYvYnKEpZt+ZefoYyaEi1V5aUFbfkm7LAWidnTn
         swyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477124; x=1714081924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Sta3zja1Zn6ZMjwAn2JaaKTmw+SVa+2lRhvrmyccIk=;
        b=IWXjNdHOqYu0fw/q091iQRdXbZ8gy/JliaOIazv0qEErW89ejrebxci2x/OhqmGuec
         ivPUVctHcNfMcc9LCxNPNOun7PPnAUNsyTtbeozmka14MnRXli6j5i2OyPqNqgzkSI38
         nJo/FyHEIUcfEb+IPc4ii6B6IXFwHS2vMXpZDGSWChHfSEtXxhPdpAqlQnmgaQHAE2/b
         Akgo/SoaWEsZNgSMrH2xmtC8iZLDs41CpbeyRU6kE3St82x920AAeocfimoDa+pP8a3s
         j5g7rURDqBuP6p+1wGhyvBucCFmfOj1Y5uC20CYogzdw1PQBclVXkjA1FD0vwFoXPnsJ
         yGgA==
X-Forwarded-Encrypted: i=1; AJvYcCUqiYo7HD7+yvQsmvRy22B8GJqEDsbpkctu4qfhOqRz6RrQz8Py6oDu0nrexbyfXMCMXmBq+sSRAHp4xKsnWO2VzVz6VDmixfKc0dQgb4mhMSyRnRnbccoQ1C4XBIlpw1ZdCg6CACxUimHIuk+LQYhM3w==
X-Gm-Message-State: AOJu0Yyw6UwtQhEGEwO1HUH4xoxTQNH1+TbOVVNovSiZe0tdelyPq4yU
	D4oVeuTtLwAif3jOcmBi9TAqHu3jQ0f+lf96Jq5MvlNhkh6LWTle
X-Google-Smtp-Source: AGHT+IFv9XBzkNI6IupVn5uohmdkzdVgv7d5DKKbgI47BgV163ty4NmTXEpfVAe6SByXBXkJHXB5Yg==
X-Received: by 2002:adf:e60d:0:b0:34a:4f5a:ac20 with SMTP id p13-20020adfe60d000000b0034a4f5aac20mr93512wrm.11.1713477124029;
        Thu, 18 Apr 2024 14:52:04 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id x12-20020adfdd8c000000b00349f139dbe4sm2767019wrl.91.2024.04.18.14.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/x86/intel/pmc: Fix PCH names in comments
Date: Thu, 18 Apr 2024 22:52:02 +0100
Message-Id: <20240418215202.879171-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The PCH names in the pmc drivers are incorrect in the comments,
fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 2 +-
 drivers/platform/x86/intel/pmc/lnl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 34b4cd23bfe5..e10527c4e3e0 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains platform specific structure definitions
- * and init function used by Meteor Lake PCH.
+ * and init function used by Arrow Lake PCH.
  *
  * Copyright (c) 2022, Intel Corporation.
  * All Rights Reserved.
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 068d72504683..ec89e7dda103 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains platform specific structure definitions
- * and init function used by Meteor Lake PCH.
+ * and init function used by Lunar Lake PCH.
  *
  * Copyright (c) 2022, Intel Corporation.
  * All Rights Reserved.
-- 
2.39.2


