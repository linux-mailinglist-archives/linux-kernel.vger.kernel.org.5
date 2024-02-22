Return-Path: <linux-kernel+bounces-76310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69385F57E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195F31C237B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD003C087;
	Thu, 22 Feb 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgK0mX1b"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781239FDC;
	Thu, 22 Feb 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597118; cv=none; b=ZsjOxvmQQSdprXRnf7XkEFHFZgU6qaBdBZz0te4DVzcvjqs21a8eP0TjRk1MMbOVUVq/AF7FUMFrRk90+vO9n0H6nro8a4MvcZpfizwS21n4igJlgJyGkude+8COGMsxieASfUR23fzt2knwlMBj3LVPMM4l1Qc2jeIk5CiYslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597118; c=relaxed/simple;
	bh=hok62KdyZlUwWp+vCS6X/XQdwd32WCp3cJQev+HQ4/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYSih4gV5r3y8miqZyvV3OtAxCOUZ9aYXOJiDtJPQOUAxbRVH3/15e2yO1R5kKFvJj21oBxZoNT7Gcx12G5gwoSzlcIotUFPNA//N/cIg/YHNY0gnzA/9x0V4E1XimDbEW8riPxglv1Xx3S1aksqgWOtMe7UNrA0+DFsVSD1aM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgK0mX1b; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso128413466b.1;
        Thu, 22 Feb 2024 02:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597115; x=1709201915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wazdN7gWecYYIgnQB0kZi/Sg4s0sKcCnfJoTIpjsRfg=;
        b=OgK0mX1bIhk0BZWIiU+ecG5DI/BWIeIbBH4CiqjAKA4cpuJJw7gEblxsiVPCRPFbDt
         Ib1Eb2sM09VLTxorNO2Bz670DW3tq7oi40w4jqvXnmxP9Mlp7XotlBY+Y8NfMZCoNeMq
         w+mj5CxIYsfXIB8Hdgrpi639REzTbn0dZ1EYnvjVEb/iE1SN9FbfClqk/pmZWd9Scjji
         0+DClZ9tJgMjpNx5ng5TqnxOJY0tA3DXsu7+7FtRvnUEmO0duBYH6WeJgN1r9d5Ycnen
         uOT1VEDlAxjrCDAT7GLd1iuQbY9SNzG0xrDQB2ko8GYId1g1FdBHCv6SE0kicfr+fy/O
         VJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597115; x=1709201915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wazdN7gWecYYIgnQB0kZi/Sg4s0sKcCnfJoTIpjsRfg=;
        b=aOcr/lU+F5JM5h9KUZg2zSubsRwqaZKCN22MaWlxcqDEIorLQCVIXnjKRhGRwsVvXS
         VjQYIrNf4Lhm5xfUMSOwWcl8hIgJhRPz4WgDajYwjrh0i0YqU6WVSLPRweQvS4GoON3c
         KKDmTrHu3uTz+/lomaNbFi2djhTBIJcMi5gh4zih1cnvSHCtX91MLxKX2rLTUwkOwY7M
         wfOXSPCk+9eKHWeqxCG4ffLrO9XLx5uHmjBuQ+wlgwU4rp1IV5iO9fAXzDHT5b6xT3eZ
         Zz7iUbH3G3y0xfMLdbmAI2N0keUPmigHvIYcfsdXhlURbwtDdBleirZcWcgg81o+pN1W
         FKaA==
X-Forwarded-Encrypted: i=1; AJvYcCULIYyjgshq9ydX09xOpipy8OEIvN9uKTnmYOTiv6VaTsQYlmZSuHCU1/bvY6HfycumFYs+3VELGY0764Rnblo+nWThfWAmWI/BHEhcZqkh7v4/IpiaZ1HmiMzRQU4kkAHYsUCxx4iAGME=
X-Gm-Message-State: AOJu0YzgucuYnqQQZICGRfJHx6ANMsjbnpCD3pH5JFGiRNvfovWEA2fO
	j/jHtYNq+9tyI1Ha1d8FwHqGXtxVptPoiW9Q+yuYtWta9kEg7MC5
X-Google-Smtp-Source: AGHT+IGZ27fJTL64apoPGO4VOYi46MvyBCwr1MXEIO8hMCWqhotb2mjF1pXNuIe4xUKbGMSqBf5ExQ==
X-Received: by 2002:a17:906:6bc7:b0:a3f:9ff6:a1fa with SMTP id t7-20020a1709066bc700b00a3f9ff6a1famr179062ejs.17.1708597115198;
        Thu, 22 Feb 2024 02:18:35 -0800 (PST)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id vu2-20020a170907a64200b00a3fa275de38sm25932ejc.162.2024.02.22.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:18:34 -0800 (PST)
From: Yaraslau Furman <yaro330@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Yaraslau Furman <yaro330@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org (open list:HID LOGITECH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] HID: logitech-dj: allow mice to report multimedia keycodes
Date: Thu, 22 Feb 2024 12:18:11 +0200
Message-ID: <20240222101811.18921-1-yaro330@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130111700.11666-1-yaro330@gmail.com>
References: <20240130111700.11666-1-yaro330@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multimedia buttons can be bound to the mouse's extra keys in Windows application.
Let Linux receive those keycodes.

Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index e6a8b6d8eab7..3c3c497b6b91 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 		}
 		break;
 	case REPORT_TYPE_MOUSE:
-		workitem->reports_supported |= STD_MOUSE | HIDPP;
-		if (djrcv_dev->type == recvr_type_mouse_only)
-			workitem->reports_supported |= MULTIMEDIA;
+		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
 		break;
 	}
 }
-- 
2.43.0


