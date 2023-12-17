Return-Path: <linux-kernel+bounces-2689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A8B816094
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4A01F22BF0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005EC46B8B;
	Sun, 17 Dec 2023 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW/x8Gbc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614C46B80
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso1136768b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 08:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702832118; x=1703436918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKsWRncfuCPQDnZgbnpk1pj6VXWzGGiRXpku/betyaY=;
        b=bW/x8GbcszGYxG2WfWQlvgLeIOKOtlomtAPU6viKyV5/Gl39o8Mughk/8vu9Wm4d2v
         6iXZrNVUos8Jn5mZAlUGY+b02cG3NyaXb1IA5BzTtx3aqib/uuNaWezuaKQ6MsCNQpRb
         CMMgXsFM0p8yw6QBeFSaqaZ5v3KgMkxuYGk1qjHlR0sX8YYMiI7AWEFUjA1UPsH8U1x7
         iL5LEiJ0wUYqIF+A+XxRmScFTDHyrRGa1W5hP/oWeJ+dmMmoHSQ5bYehMgHU8dj1eMm3
         o1DezUYgR9HAF3thBLz8gvlynSDF5uxUxRZ2MaSOCEK8sEoGlKOPZ/T7NxWDO1KyZFFy
         8EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702832118; x=1703436918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKsWRncfuCPQDnZgbnpk1pj6VXWzGGiRXpku/betyaY=;
        b=CZnKuf4gHvIxEIYf+wITQzRjnJrFCs5g1dheU+FMnDM/tCaHRvIC75vzZGr9GM5Q2R
         4RGbDRDQnoajHqV2mG2iOnuQ85JpWZ15L2XTtbt9jF3wieH+2Gbz62aU8P9Lzb/5mrBy
         dmzBuSHbEycEu0U6xcGKOV8Pn17Bz25voaazP9jlqvcCxt9mGUJEFLEbKyDAzLRcx5WN
         IspzMgE6w8bFtK8SejjbtfByfAZWMopnqSHXJhhV0gO6GuP8pSa9+9nthlXC9g7H+Epv
         deMcTHjz29/TugH2q/G48Cobet47nxd+GaJET5+NEDh3IMs3pfCS1R0bK05HrwSsQrzl
         H30A==
X-Gm-Message-State: AOJu0YzZhknLMnaCWw6YKmg4FOIIRvXXHbbmNFGAbKjzbxDVadYXpcoW
	ObwrPj9hBUT9qakJt38PwTNWBN7w9XWzzQ==
X-Google-Smtp-Source: AGHT+IElv+rw7sIJijJRD+OdyZtfVrQkm1+LOYAXSc4i+0RHL3+E7jluDilGz3cyuXwh9uqgyEvdkQ==
X-Received: by 2002:a17:90a:1c09:b0:28b:2219:e78f with SMTP id s9-20020a17090a1c0900b0028b2219e78fmr1758461pjs.78.1702832118124;
        Sun, 17 Dec 2023 08:55:18 -0800 (PST)
Received: from ubuntu.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id pb7-20020a17090b3c0700b0028aea6c24bcsm4705292pjb.53.2023.12.17.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 08:55:17 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drivers: staging: rtl8712: Fixes spelling mistake in rtl871x_mp_phy_regdef.h
Date: Sun, 17 Dec 2023 16:54:43 +0000
Message-Id: <20231217165444.448133-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script checkpatch.pl reported spelling error 
in rtl871x_mp_phy_regdef.h as below:

'''
WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
#129:
#define rFPGA0_XA_LSSIReadBack          0x8a0   /* Tranceiver LSSI Readback */
                                                   ^^^^^^^^^^
'''

This patch corrects a spelling error,
changing "Tranceiver" to "Transceiver."

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
index a08c5d2f59e3..bb9f83d58225 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
@@ -126,7 +126,7 @@
 #define	rFPGA0_AnalogParameter3		0x888	/* Useless now */
 #define	rFPGA0_AnalogParameter4		0x88c
 
-#define	rFPGA0_XA_LSSIReadBack		0x8a0	/* Tranceiver LSSI Readback */
+#define	rFPGA0_XA_LSSIReadBack		0x8a0	/* Transceiver LSSI Readback */
 #define	rFPGA0_XB_LSSIReadBack		0x8a4
 #define	rFPGA0_XC_LSSIReadBack		0x8a8
 #define	rFPGA0_XD_LSSIReadBack		0x8ac
-- 
2.34.1


