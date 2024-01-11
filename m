Return-Path: <linux-kernel+bounces-22934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDA282A5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A1D28231C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08216807;
	Thu, 11 Jan 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IaOwmW4x"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB87E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=k5VNdGMF80cW8A+9od
	/r+mA42tX8H/bCQrmzoQSX/SY=; b=IaOwmW4xcICu0x76jKckESsSDt3+tLdC/+
	cPJDRReKTW4MNsEUnfo4iQ6ok5sedGFFpU23mEdsrdc/E7mdwcyppZV3KOAKgIhg
	pxb/FnchXE4SoThMyozPF8hHVnRkPYVwCljkqlUc60u7QkyFnrmydC40aVJPLKLM
	oPLfPNBtw=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDXH8ZXSJ9lgZ0sAA--.12694S2;
	Thu, 11 Jan 2024 09:46:01 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] mfd: twl: Clean up errors in twl.h
Date: Thu, 11 Jan 2024 01:45:55 +0000
Message-Id: <20240111014555.5117-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXH8ZXSJ9lgZ0sAA--.12694S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF13tF1UXF1UJF1UGF1Utrb_yoWftrb_Cw
	1Fyr4UWrs7WFn7tw10q39rtFs0yw4UJr15WF1ktr47JryvkF45Ga4DCa9rJryUurs5uF9a
	yFWrKFZ3urnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCa0P5UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHAlixWV2zz23nAAAs4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited after that open parenthesis '('
ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 include/linux/mfd/mcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index fd5cafc77e8a..ed56c67bbbc7 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -53,7 +53,7 @@ int mcp_driver_register(struct mcp_driver *);
 void mcp_driver_unregister(struct mcp_driver *);
 
 #define mcp_get_drvdata(mcp)	dev_get_drvdata(&(mcp)->attached_device)
-#define mcp_set_drvdata(mcp,d)	dev_set_drvdata(&(mcp)->attached_device, d)
+#define mcp_set_drvdata(mcp, d)	dev_set_drvdata(&(mcp)->attached_device, d)
 
 static inline void *mcp_priv(struct mcp *mcp)
 {
-- 
2.17.1


