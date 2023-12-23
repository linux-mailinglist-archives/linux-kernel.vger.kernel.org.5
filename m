Return-Path: <linux-kernel+bounces-10313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5281D299
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43F628497D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3A6116;
	Sat, 23 Dec 2023 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzyEBLBS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBA63C7;
	Sat, 23 Dec 2023 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d089e8b1b2so1689821b3a.3;
        Fri, 22 Dec 2023 22:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703311472; x=1703916272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXkJe47tIZ6CS0rCi+p/41rd9M+SnrlGZxxaIAMxpHI=;
        b=SzyEBLBSUbKmCDuF5ykwdpXdY31RQrRHcGzJDG45+PDTEAvPBDoMzgQ4rYbEjhi3YP
         9Orj6L3WciUBMeutoWuHw36rlaN8rw5yjIebgS+jeCLbqkMUakQluSgxgMeIwPC49iS2
         FYzB89sa+sN2sFd5LXjYxCLflEvDJ692A9ZwtnnJmsUwtxIv8gdqTOnBSKRHxzpsBCTz
         YcHBT5LpD7BxjqQQFYbDCccki2RqPLbJ+4uZZqtKOBQL8KiyJPgQI7Zb97EqR+7Yh/Uu
         24nPPiAjmUmVwphViUgKOEQBg3hfW2gi0V6DU/pJKpnq7VGNYZWDZlZSDlju3mFPpVp6
         iDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703311472; x=1703916272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXkJe47tIZ6CS0rCi+p/41rd9M+SnrlGZxxaIAMxpHI=;
        b=Ig3Ej3X5YUTRmT4gXzN+7BPmnrwsMHqePDNF4t6CcTQc1ZyDNhXzqy/Fz3jHejFlxT
         X7FVlCuPoEwWDltCBeJSp3se6S+Lg3q88gun4E8/NVZjyd5B/5ouWBMEyq+0kdkEziNZ
         uXI37RmCurnypHzd85CD9567W0pk4K9a8sztGT+m5hod7g6g4/aXRKIyMiS7YtptBgHg
         6/wuyE1YAZP4G+fsEeCv2URDi3yYJPdwpSlc3lUek6PqFcAQqaWWNfK2yi+NHIo8bcl9
         7NFqJGkCYygjoV2tsbXN8OAvMURqOKGvVQQiKeMnnlL2/3uu6qWMFCHhEinBJ2+gV7jq
         SHbA==
X-Gm-Message-State: AOJu0YyS9acE/K5omV0LpBV1NEudsdIn2j/9VQlatrJOfJm+0XcRRdM7
	z9XCUdN5k3DmyLNeUhHh4dvWAJ5crgaNyA==
X-Google-Smtp-Source: AGHT+IHOyCwfs7Vf2ci1UdE0M1SAzA3hPLcfvCDSsqlTXNEfg/W3ZBqqM/SLwNDrMh5AOSpPF80Png==
X-Received: by 2002:a05:6a20:4e11:b0:195:79a:a29c with SMTP id gk17-20020a056a204e1100b00195079aa29cmr1354700pzb.96.1703311471697;
        Fri, 22 Dec 2023 22:04:31 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b001cca8a01e68sm4335750plo.278.2023.12.22.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 22:04:31 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: media/atomisp/pci/base/circbuf/src: Fix spelling mistakes in circbuf.c
Date: Sat, 23 Dec 2023 11:49:22 +0545
Message-Id: <20231223060422.77789-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistakes
in circbuf.c as below:

'''
./circbuf.c:27: whehter ==> whether
./circbuf.c:132: offest ==> offset
'''
This patch fixes these spelling mistakes.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c b/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
index d9f7c143794d..2f484ef9d4b5 100644
--- a/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
+++ b/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
@@ -24,7 +24,7 @@
  **********************************************************************/
 /*
  * @brief Read the oldest element from the circular buffer.
- * Read the oldest element WITHOUT checking whehter the
+ * Read the oldest element WITHOUT checking whether the
  * circular buffer is empty or not. The oldest element is
  * also removed out from the circular buffer.
  *
@@ -129,7 +129,7 @@ uint32_t ia_css_circbuf_extract(ia_css_circbuf_t *cb, int offset)
 	u32 src_pos;
 	u32 dest_pos;
 
-	/* get the maximum offest */
+	/* get the maximum offset */
 	max_offset = ia_css_circbuf_get_offset(cb, cb->desc->start, cb->desc->end);
 	max_offset--;
 
-- 
2.39.2 (Apple Git-143)


