Return-Path: <linux-kernel+bounces-10330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551281D2D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF64285395
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380A79C5;
	Sat, 23 Dec 2023 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhlEK3tt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874106FAF;
	Sat, 23 Dec 2023 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7b7418bea02so106280739f.0;
        Fri, 22 Dec 2023 23:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703315526; x=1703920326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdq20GqT0V3FaSsYb4r80A7ENvWSSP5EMXwhIHB4x9c=;
        b=MhlEK3ttomMOkaZOGBQyWZagMBVhBUFjX84EnTEylesbSUocQMivC9aDqqs18szUTd
         rcm2T78yOHyIedkVsRrlslc9ZyPNyWD13HAZ1hKNdO/zvJnmzkm/vxyZKQl5h1EaM0G6
         ALf8SQnU34O/y7TMGjZ28wHcoKpk7u0WhBBg4evNkYs6sbXBrPtM1qNpPHIYJG+YpoN3
         RaNIOWFMH2z/Ww20JgBiUcPfCf999Bp3DXsuOOWgnted1HuNHvmMUed43g6BLqdTvDCr
         YPqJNBknSAQhKD9BokueN6R9Vt7wFdhoXQym9KZbP63je/WMhF9Lom48DQfjzabenJlR
         eVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703315526; x=1703920326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdq20GqT0V3FaSsYb4r80A7ENvWSSP5EMXwhIHB4x9c=;
        b=CeXw+pBLfTsNsf/3VTu44XhyZQiVMWSVlmEZFsGbZ9gc8H4A2673+GpxxfxYMg28kq
         fOkPorfVmFYAA4NpgHi6gnGhc8xgdevB28yKNyI0dDp383NW2sRGstfaEFJrMkmZ8JNN
         4GEBwYoDTXe/3Hi94MQrhdXFFuh7yTDdyvSE2D5WpE+wV3SFDsbTcO8MuwufYxn5H3Zy
         W3nWomIqhb/hYMS78Du8YCod7yk6sR20GSzVO63Q1VRiWxQ60UWXF90cvQJzlV9qEmyK
         D456JixDomr+gP0wkF7shCi/3ejTtZuCtcoq5Bwj3v2+MnwH9js79pL2q8XIKXir5xVl
         1D+A==
X-Gm-Message-State: AOJu0Yz+oF0ZkIdHWBpkSCZKL18AwDvVCa8hOcAbsXsJHR0f7RBKhX5J
	BXvWu87dCnP0HfuMqaxsuocy5kYeyf3/5Q==
X-Google-Smtp-Source: AGHT+IHgYkJh+MntoZJwAFW4c/GlkRitASejMY+WgAxbCAxYviF91k2BISccQHbOGesv8LalkuMPKA==
X-Received: by 2002:a05:6e02:338f:b0:35f:960e:c030 with SMTP id bn15-20020a056e02338f00b0035f960ec030mr3894872ilb.48.1703315526642;
        Fri, 22 Dec 2023 23:12:06 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d3d300b001d3eb987bb6sm4492132plb.149.2023.12.22.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 23:12:06 -0800 (PST)
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
Subject: [PATCH] staging: media/atomisp/pci/runtime/queue/src: Fix spelling mistakes in queue.c
Date: Sat, 23 Dec 2023 12:56:57 +0545
Message-Id: <20231223071157.81082-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistake
in queue.c as below:

'''
./runtime/queue/src/queue.c:126: uncessary ==> unnecessary
./runtime/queue/src/queue.c:183: uncessary ==> unnecessary
'''
This patch fixes these spelling mistakes.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c b/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
index 2f1c2df59f71..2c6c8fffc4e2 100644
--- a/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
+++ b/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
@@ -123,7 +123,7 @@ int ia_css_queue_enqueue(ia_css_queue_t *qhandle, uint32_t item)
 
 		/* c. Store the queue object */
 		/* Set only fields requiring update with
-		 * valid value. Avoids uncessary calls
+		 * valid value. Avoids unnecessary calls
 		 * to load/store functions
 		 */
 		ignore_desc_flags = QUEUE_IGNORE_SIZE_START_STEP_FLAGS;
@@ -180,7 +180,7 @@ int ia_css_queue_dequeue(ia_css_queue_t *qhandle, uint32_t *item)
 
 		/* c. Store the queue object */
 		/* Set only fields requiring update with
-		 * valid value. Avoids uncessary calls
+		 * valid value. Avoids unnecessary calls
 		 * to load/store functions
 		 */
 		ignore_desc_flags = QUEUE_IGNORE_SIZE_END_STEP_FLAGS;
-- 
2.39.2 (Apple Git-143)


