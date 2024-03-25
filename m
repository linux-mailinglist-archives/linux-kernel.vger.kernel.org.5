Return-Path: <linux-kernel+bounces-116622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CEF889EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ABB1C35B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89B17E3C9;
	Mon, 25 Mar 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F36dxSIb"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D83C1849;
	Mon, 25 Mar 2024 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337677; cv=none; b=IU4VMYTZQYIPJ0X98/MQwKe3MqH8vR+Y5VRNejcujVbtzadquDYv7+yBbRyCHLowLbdevNRx5UjiNkZ1fmBU2ZO52SOadz9kX3dByJbYnHmfaTJafpRV/RDF94iWTHu68rAfaUbatR2yjM5TiNqnN5e0xKYl28ylDcUg2gZt1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337677; c=relaxed/simple;
	bh=dgHhWcmK4wzqyaiiERdmFMSqnnE06qaplwlkFBXUdIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6izZg6c47zD+lJHk1eACxWT97uPbLPlfzWnidzcOFSV/pfOAHop8NrCpNnwDdhmDx/Enrd02dhvbkmU6OENeEvFDMjK9QoMsbN/BxfWTgfP1MryZMpSGxa56lD33wcy6VCROGZhzYA1LbRLltgLM6EWHkIh4xvH0sa1PpQfG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F36dxSIb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e6cf03a76dso861040a34.3;
        Sun, 24 Mar 2024 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711337674; x=1711942474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMpIxPMCcxDzGX2UXAJvTPFkeya4KxDWX8GZFo5s2Gc=;
        b=F36dxSIb8glcVBGwkg/y7d1rhEOQGMC7HMbBf+789BYngmKYPXcYUQnyX0+qpzl5aM
         094qnaJgyU5xh36QP1cJxlQ4WlQcXSY4SV/iY8ucY0YwkMJ5uM4e779OLxamshfxMebR
         djH68BBi3ofbAbnaXyZrzQIBfipdBLuoMwj1ktEAMRhRVXccK59DkQj+W3wxss52P9Pd
         CGZv1yvB81ZnjxSz3uxqIEM8BGTCNhXpk2vXmTbsD5MmuFoVHx1OpkXaruj6vWoginHT
         ll/RzK6zizzVyr/fN9k/5lhkgtUi5kX4Z/N8Te85aSP0zuUZSZ7J6pphIlUENoWwHNS2
         wtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711337674; x=1711942474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMpIxPMCcxDzGX2UXAJvTPFkeya4KxDWX8GZFo5s2Gc=;
        b=EqcURx4ajz7Mn/6xeybSaShBcvEChWJ1UbIVHAn8vEvT6uRnuTqtUYBGLyU1n9LeQ9
         ehsuTwnQVjm8Ru9PdwWzv/96s61OMSlN6uK9I1DzcJT5WaWYamtGy2le46XekE1XPGGg
         eTjVwrGwRUvUtISBTOojey05EVV00RbfvUCIDsEPJh0rbdQNPEzWRvTFGtqb96Mca5+Y
         1RszUKGRSjAesCqHZJPJ5EfmFWnkIfLygqBNgD2vnFoMSvyt8OzwVNom3oxz5Xjw5iAt
         B3OMPOUb+2t1Eoj5iAse1qjPUOTq4QYLSR2lsdrp8ecw6L4R/S681/MAajsfvi8GQkSK
         zwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbnL5tX2eX0xCO1OtiLi1luNEOa3/zlx811sDvsEvSiC7lczBQtvnS63ol3US5oNoKrhjOUW3L2e20CA1xrEYy08hlhlpvHlwzD15E8y3pLbG7ZHw2Hum5bTNb288mhOT3tFQCdehcw7A=
X-Gm-Message-State: AOJu0YytZ0vFf95j/wbet+TTNNSrTw9iJvKMlpmyA5hZDDw7iXdc38b5
	MCq+3sak9q3aDbUPtvcut4h72QCBfmtXoUVCVn/Gg1KsW2CyEqQS
X-Google-Smtp-Source: AGHT+IGSrQDNPv9m6amL42+SaReUA0caWi4XU01dj8E7zHNP41xfBJTTfNqiPAlE6na2wTOq0RYS1g==
X-Received: by 2002:a05:6870:2183:b0:222:b950:6785 with SMTP id l3-20020a056870218300b00222b9506785mr6717232oae.28.1711337674272;
        Sun, 24 Mar 2024 20:34:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1010:877d:14ff:b313:5f57:6762])
        by smtp.gmail.com with ESMTPSA id i25-20020aa787d9000000b006e66a76d877sm3310747pfo.153.2024.03.24.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:34:33 -0700 (PDT)
From: coolrrsh@gmail.com
To: slongerbeam@gmail.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] staging: media: remove duplicates
Date: Mon, 25 Mar 2024 09:04:27 +0530
Message-Id: <20240325033427.4708-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The kernel configuration VIDEO_DEV is defined twice in Kconfig.
Thus, the redundant code is removed.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
modified the subject and commit message

---
 drivers/staging/media/imx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 21fd79515042..772f49b1fe52 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -4,7 +4,6 @@ config VIDEO_IMX_MEDIA
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_DMA
 	depends on VIDEO_DEV
-	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
 	select V4L2_MEM2MEM_DEV
-- 
2.25.1


