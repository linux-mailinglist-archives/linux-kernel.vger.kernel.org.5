Return-Path: <linux-kernel+bounces-18614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED54826009
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7449E282F88
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E98479;
	Sat,  6 Jan 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUPPheLz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570679F1;
	Sat,  6 Jan 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5ac76667so4301175e9.1;
        Sat, 06 Jan 2024 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704553499; x=1705158299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+jORYiUTO9PmKWOcOQPyN1v50dStgTx0NZ6TsUFmhg=;
        b=RUPPheLzW22N2QQs5S6NQF8/yVYBaJ6A+oK0uEV65wGdWmaeXFtBinll7qDQP2y8PA
         VhzHejNXI7R0CRQAx05M2v8s4tno0R55yQQlKjAqf5YTtb4KjPmeIlhyWPIGfz+UcQeX
         Q5c2Jfs1VyK7v/5W5xFjE3UMyfHdp6btz+9Rh+JIcQ0kJv38JoCi3axGdpWOQG8m2Gd2
         MbxZcoTrE+X2n3gdUD615pGPe6tMS2bxKBkizOQstHKHwh6tdHrCktSDsJk0OSoat8pX
         cr3Gwy4QH2OV2tQgLBdZns0F8dqAW4XrnZS068iWbjezdvCzPuXPWVFSpXb7hV1nxF1c
         yZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704553499; x=1705158299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+jORYiUTO9PmKWOcOQPyN1v50dStgTx0NZ6TsUFmhg=;
        b=SaWOfD6jvvsKfr65eMzNo5dWV+bzitA1i02j7qyGUACCdzXJ3P/7NUMII8iNEbUjwq
         6BYGobtUwOvlbRDCwDewdauK6t7QoQTJZQYOF+qRyjsfi1J6IJu4AXMFCdghFm6Q8AzC
         tDe5f2Tbn4Td0ZQgzbBV+ES1s4jVYrE6TZOtft3vL9oa2w/+al7RuR7Lo3v3eI4nccx0
         h47q6zGU6tmKzxeyXJnL0ndwSZ54TVT/dl9GSCGvfIDVJva0g1WVctP2fLW14mSqEi4J
         kTYF5V3Ziip0P4uDOQOr6Sw5Mzwb5vBv7dJHNWT28wkfMm35AXzxQaoH24WtfCOnSN+Z
         OF3Q==
X-Gm-Message-State: AOJu0YwJ3CudFtJ4wCwb9BEuKlr1xp7iNmRp4cw5b1Wb7YB3YN3Zi26K
	ILJochjhrRRFM5n7x/vUH6M=
X-Google-Smtp-Source: AGHT+IFBjfthUn80oHP48orVD+8I03MMj0HKnQn/QcpxmKjVJR8UyEDGbRq3D2m+XoyP5/EWszSOWg==
X-Received: by 2002:a05:600c:45c8:b0:40e:3f9f:8f76 with SMTP id s8-20020a05600c45c800b0040e3f9f8f76mr457834wmo.23.1704553499379;
        Sat, 06 Jan 2024 07:04:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b0040d8ff79fd8sm4942745wmq.7.2024.01.06.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:04:58 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] binder: remove redundant variable page_addr
Date: Sat,  6 Jan 2024 15:04:57 +0000
Message-Id: <20240106150457.53423-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@intel.com>

Variable page_addr is being assigned a value that is never read. The
variable is redundant and can be removed.

Cleans up clang scan build warning:
warning: Value stored to 'page_addr' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@intel.com>
---
 drivers/android/binder_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index ea5e1ba2d0d7..ed4ca6689c75 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -925,7 +925,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		int i;
 
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			unsigned long page_addr;
 			bool on_lru;
 
 			if (!alloc->pages[i].page_ptr)
@@ -933,7 +932,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 			on_lru = list_lru_del_obj(&binder_freelist,
 					      &alloc->pages[i].lru);
-			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				     "%s: %d: page %d %s\n",
 				     __func__, alloc->pid, i,
-- 
2.43.0


