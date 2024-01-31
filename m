Return-Path: <linux-kernel+bounces-45964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8C84386C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7780E1C2220F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F565645E;
	Wed, 31 Jan 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TFkNHvBM"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6D5D72A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688165; cv=none; b=BxEHTr6Geke557FJ0HUL/LAn8r+x8Rk4sdDCMp4eZPPnLf95fXvZzI4obJvu9xjNTWxUv9/fFLeTjLwUIGFt1+2NJalTob3b6BRn8T6sVDrYDjlmDvTbMVym+PIZcA1lJYnbu8pxT7rdgSSWXDD5LrGbSEeB207jtC9bajBYQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688165; c=relaxed/simple;
	bh=/aIiTcq6IFYg8C2DKhl+ENCN8VlB6eVN+tUgimzqR3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccwc5qAP5YyU+ke+8MBrpvvU+WbBX4FAc2+n/hWLtBXlMftDMr7cyEOiJlUmODpU9RogztWzNE3ooF+uHIylcmri8FjoJY09kRZXRzmFHqX4a+4n3LhA9RMtHJkSHzjKZEYelAbvsy+1OlOBrFYDaWZGOJOQQ7F39WfuQeejrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TFkNHvBM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40V81ikA3259659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 31 Jan 2024 00:01:49 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40V81ikA3259659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706688109;
	bh=PJQ2SCf6uARuhXxFd/abFulMkJbH8deOmdTwbDbxnjA=;
	h=From:To:Cc:Subject:Date:From;
	b=TFkNHvBMcMVE4KY+EchrdnI6SPNUcsXT+CdraqHR9ABvUXHZoSIBmYrJs5/68FF3z
	 /7pYxRlDJlBjFljTq0M2G5qi54Y3ntrRVLyrdLFw0a5+CnUgiHZEF52LNv9ODKUfC1
	 AYMqi1GjGhOnrwQFUQ0oD9O6zZS8p1dqw6pViS4ZkXeahoA+ksiKkv1wNErb4dab2D
	 yiRMMJSA0LKNHP6FLpIFcy8ZgPRjI2dAbJ8hpsuvjJxMFTytZtCRQ54l5xvyN70mZA
	 /ht3lQOjEN4rfGBqTViW3MhfVO7Vd7afZwRlCiXdyC3PgYhVjqt3Ygk9bIb1cONQpB
	 nMilQVh3qTDDw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH] MAINTAINERS: Add a maintainer entry for FRED
Date: Wed, 31 Jan 2024 00:01:43 -0800
Message-ID: <20240131080143.3259642-1-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add H. Peter Anvin and myself as maintainers for FRED.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..29574c65b26e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11151,6 +11151,16 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wwan/iosm/
 
+INTEL(R) FLEXIBLE RETURN AND EVENT DELIVERY
+M:	Xin Li <xin@zytor.com>
+M:	"H. Peter Anvin" <hpa@zytor.com>
+S:	Supported
+F:	Documentation/arch/x86/x86_64/fred.rst
+F:	arch/x86/entry/entry_64_fred.S
+F:	arch/x86/entry/entry_fred.c
+F:	arch/x86/include/asm/fred.h
+F:	arch/x86/kernel/fred.c
+
 INTEL(R) TRACE HUB
 M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Supported

base-commit: b564b0111a3f03d1a92ba87c4b0f054ad1845963
-- 
2.43.0


