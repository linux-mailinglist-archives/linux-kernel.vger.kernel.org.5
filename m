Return-Path: <linux-kernel+bounces-152061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928D8AB832
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AF2B2143F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81211205E0A;
	Sat, 20 Apr 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xy4UOldt"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3138B;
	Sat, 20 Apr 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713574135; cv=none; b=IsXijn8HAGBKE8di0PQHos/IlGuPswEGUrTRgC2VD+tvZ9KEscpVV7HNPUBpIZY2wE7UFvOwhl6gQuCl71KISE8jSX21IzJO49/LZR1mvzYyVaFiIQKcsTEpyZDuD3RYWiP1ActSwvlyfcAhT+RZ/H0iNbJeOLRmF1mctFaNE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713574135; c=relaxed/simple;
	bh=1OzfHfUjuOL8HBvY/WRL+t2/ivkZS5+gTq6FVR17Nx4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bGZ3DsLdGXgYnZ4Ak1061h1oCO2MVc6ecLniTsYDFTI/xxVjj6cRHT83YrvlUuEhQ1hF8jLEqFly4FyPQbE+lKj4EFLK9YSz/Sx5zgjW8JeK+xYvdMGwoiqg4rrU380WDlDOsCkNi8juRwO3EbvgbizepRnCdFJP8nWEKZlkcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xy4UOldt; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1713574124;
	bh=p75aEPAFI48CpfiuqQ6DlpvF/5AH+93ALLOF8JLaB2c=;
	h=From:To:Cc:Subject:Date;
	b=xy4UOldtwKs3CuPla/zDeQCnyGXLEbbjXUVt43zI0cTGWKp6GxuCzZesGeqONp2u7
	 V2Aj5VS3nPnlib9P/q73GbF3VkWMOOskJ55YPBWmUWdkrY7j8QXE4LuheqfCqxXtOP
	 lVEjlKY6EBjMetrkcK/xZMsIDc8fYncJt6+s+xu0=
Received: from localhost.localdomain ([171.223.89.44])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id A96298CD; Sat, 20 Apr 2024 08:42:22 +0800
X-QQ-mid: xmsmtpt1713573742t47czu8gy
Message-ID: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>
X-QQ-XMAILINFO: N8nyCa1bmgri4t3IFtmHT5/5TiWHblYu3u4ROrTv39Az0xKwH+E4en5VHR6xU+
	 xWtp0uTOqlvL2nRrC1vE9RZaZSed9+BjR70A/JQEbzP+zUpLHJk/zQcDspmnPXBzrTdSwvLO6Y3S
	 oQJKxDGAeXdeZOq0KnfXKzcdJzl/wNEJ391LH68Oh851O12JtBwweaaW5RoyemEImbJ5K1tMsRfQ
	 2FHHBTO6XkTqwcf1kHQZMfJYsEnETx5a86BkhedzlDLxWkqjjRwmZehWffeD51Hu4NUjnlLAbGK6
	 /KHR+htkkp3bFPg4j8H1vMYrFR5yVnTZoTr6euAwmW9pWEx2Ekqc6x0HS6R6U2DEy8l4xeHuBRX4
	 MJkJq7jfloUnPSbmMt/29WzCa0F8Y0+1/ITmyUFMJQXXnVTLGaznWOp4sulEIHeZYjGlC3rs64JE
	 UQbSXiXycyfkUpHMy+mkyxgFAiMTu3MMLtrqXpU9FscUMA5MS7uO2Q2zUIVOwV2md4KK2Ewd6+fV
	 I0wp9MPAd5EOugWXOG2B2e8jd2SpGgJdafpXXm/FX+YYGKh9wIj4DtIpNjl4xV5Ky3s/0POdDhlg
	 EFeYC1+1tH5oo95Ps4FAg/CGr3rYc/U0S1bpGMYWVdkC7RS+lVcGRc5oiXnTMrkT28faA0FTBzUR
	 7vUigA21GObhlkMrg+9RrOHIvBZRyA3FGzLGbNrpLc/emnxEETcAZRCgBRD9Op5exiJKdWYNYS4l
	 fkpHVnB5bLK6VXAXKJH/9c9PeOvpNCo2ezpY4Rfe6LhhnulucZQR2z3jah7vGjEOEjoIIsVyyxh5
	 xb2cHCebeSrweAnhzHApHwJu2Nexdms3W7Qx/CzHLy33/50WP4b6JmeAxDsO/WyKu1rePhlpW+PL
	 5i14ROKhVDs01PQNS9uoiud1PEt7hcsSpnqHfIb6V7tE6lyaZfYdHy4l7CToe/YJWYM+PIBl6ip5
	 kkszw7mmgW7MTPF6DbTVtbNRrZxXPOc/cYlRGJWcRVLsDQTke3t+V75Yt86gi+J71yVxWo/k9LMW
	 PGOWwPuNcW6sQ1Kk4W
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: renjun wang <renjunw0@foxmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	renjun wang <renjunw0@foxmail.com>
Subject: [PATCH] net: phy: update fields of mii_ioctl_data for transferring C45 data.
Date: Sat, 20 Apr 2024 08:41:10 +0800
X-OQ-MSGID: <20240420004110.39402-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phy_id is used as u32 type in function mdio_phy_id_is_c45()
with the 30th bit for distinguishing C22 and C45. The reg_num is
also used as u32 type in function mdiobus_c45_read() or someplace
else. For more C45 information needed and data structure alignment
consideration, change these two fields to __u32 type which can make
user space program transferring clause 45 type information to kernel
directly.

Signed-off-by: renjun wang <renjunw0@foxmail.com>
---
 include/uapi/linux/mii.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 39f7c44baf53..68c085b049de 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -176,8 +176,8 @@
 
 /* This structure is used in all SIOCxMIIxxx ioctl calls */
 struct mii_ioctl_data {
-	__u16		phy_id;
-	__u16		reg_num;
+	__u32		phy_id;
+	__u32		reg_num;
 	__u16		val_in;
 	__u16		val_out;
 };
-- 
2.39.2


