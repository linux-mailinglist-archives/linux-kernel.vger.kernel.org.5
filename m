Return-Path: <linux-kernel+bounces-142245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD928A2973
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0705E1C21D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804652C6B3;
	Fri, 12 Apr 2024 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeF+6BRs"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C631B5A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911131; cv=none; b=jcprN1WZ6wtR4ay71c8W/p9ZPSZEyEzDkMajlrMhVm1qSBdpnRECNxs47k2dhmgAVcWZqbnbbSkGYQzh6A5RfK3FgoB4EAHJXM5RNqFYDavDUvUcJN14+86vg26BLugZIdCJgf3Cw526mSUIQWBw+pJr4yYVANS9N6RBTjliEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911131; c=relaxed/simple;
	bh=cLljHdlKbk8oW5qf2GQZA1xukk3FvSfGAx6fkKt2Sjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2gD5tx43Kx1G8WJSVJKWUD8lZa2waWC1hmqcJJZ6h+2YCUTcUtvPGgpwebEJGeIgnXWVsLKL1HDDhSKScqZ/rWT+t20hkEg4LVwMhuX+5fNHU5BeOiymmL7PJAZKTLTPCRd5TejH9zdo57AOq5ZHqG8/3sKaPf6NrtcTf2V9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeF+6BRs; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso505149a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712911130; x=1713515930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDpbeX0iPVfonJMyHLwpARBi5sjPgC14ra6nRm3PiEA=;
        b=jeF+6BRsD88O6SX6ORMiHGaw43+xUdZMj8G6eXx82gBioT5wG45JjnlXgjNGNW6Wx6
         9LbvzXYr8kR/yfgFv+u86B4KQslT2+vEPMeyorUn45V4gorJRkrQGNnoFqFYMf8/x5k8
         CA+WvVQ4gxj7jTgNEptkCVfygme5lNlx/BOp8wSRb26j3p3RZc4xKZdGMwKskSzQRvzq
         bVSdAgBN/+69tm7jEYJ4vums4LbU76YuBSziEdxKec/Q7vJ1oQxYfx18pL3io9rBwfYH
         udkolrj0cFYugSMJ800TmLiIcVRc/1JuqJZZqx6vd1D/W0LSxrxDvrvn9HD4AFAbJ4PE
         4lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911130; x=1713515930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDpbeX0iPVfonJMyHLwpARBi5sjPgC14ra6nRm3PiEA=;
        b=QymmqZaaQINYNLYDKu/4RRkBlQtB8gyB/PkS91p4tYQISlgr/R31WngVhnl8ksd9Il
         gUx+LNUqJg3yOe3QPE1hjNZYT4j6JKQZgZZetJNjD3E8UUMobFY0ucyJEFTl8J6AH+4c
         yYo9hj7uwLQtK5La8mdu+4ny9x1TRuZ3cfRwJHiG7vzXBNGBZcjI05QEGhRqa/I/4ZwX
         dIY/RotS4sCT2lBBafXIqRxPhrgYbHqSbXvebxDDcaoJvy53MMWx2HDqjKRagOaOOms/
         Fg6HtIN1p1Axz64K7TVW6aQugZDyyCSiOdUgoy3mvl/ZKVYvW/niMFMpXAw3Cdh3JVss
         XreQ==
X-Gm-Message-State: AOJu0YxFL42fmMG6laN7nD2s8JbkHbwQayPaBAs7XvEY6cFrOrtnEynl
	fUewqE1/egbyBVisvW6/fNbvUbpw27s4m523Fv0zCifRgU9Pua9CG0fgOZ3p+qOGHA==
X-Google-Smtp-Source: AGHT+IH/yhfkMuh8gXktV8C4CUL1Q1ThQK7KumbewV79Rr0mKEtToeguKzOvY6eLrICRnwB4vUGIrA==
X-Received: by 2002:a05:6a20:dca0:b0:1a7:4a6f:f1a6 with SMTP id ky32-20020a056a20dca000b001a74a6ff1a6mr2289769pzb.3.1712911129616;
        Fri, 12 Apr 2024 01:38:49 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a1f4100b002a5e73ba87dsm2554173pjy.6.2024.04.12.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:38:49 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: sudipm.mukherjee@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH V4] ppdev: Add an error check in register_device
Date: Fri, 12 Apr 2024 16:38:40 +0800
Message-Id: <20240412083840.234085-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In register_device, the return value of ida_simple_get is unchecked, 
in witch ida_simple_get will use an invalid index value.

To address this issue, index should be checked after ida_simple_get. When
the index value is abnormal, a warning message should be printed, the port
should be dropped, and the value should be recorded.

Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
V2:
* In patch V2, we found that parport_find_number implicitly calls 
parport_get_port(). So when dealing with abnormal index values, we should
call parport_put_port() to throw away the reference to the port.
V3:
* In patch V3, we made some additional adjustments to the jump labels,
making the code more concise and readable.
  Thanks to Christophe JAILLET for helpful suggestion.
V4:
* In patch V4, we found that a related function has changed, causing this
patch inapplicable to the tree, so we regenerated the patch on version 
'v6.9-rc3'.
  Thanks to Greg KH for pointing this out.
---
 drivers/char/ppdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index ee951b265213..58e9dcc2a308 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -296,28 +296,35 @@ static int register_device(int minor, struct pp_struct *pp)
 	if (!port) {
 		pr_warn("%s: no associated port!\n", name);
 		rc = -ENXIO;
-		goto err;
+		goto err_free_name;
 	}
 
 	index = ida_alloc(&ida_index, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err_put_port;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
 	ppdev_cb.private = pp;
 	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
-	parport_put_port(port);
 
 	if (!pdev) {
 		pr_warn("%s: failed to register device!\n", name);
 		rc = -ENXIO;
 		ida_free(&ida_index, index);
-		goto err;
+		goto err_put_port;
 	}
 
 	pp->pdev = pdev;
 	pp->index = index;
 	dev_dbg(&pdev->dev, "registered pardevice\n");
-err:
+err_put_port:
+	parport_put_port(port);
+err_free_name:
 	kfree(name);
 	return rc;
 }
-- 
2.34.1


