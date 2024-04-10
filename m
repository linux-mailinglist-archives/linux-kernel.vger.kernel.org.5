Return-Path: <linux-kernel+bounces-138002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46489EAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4B81C2152D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757B3F8F0;
	Wed, 10 Apr 2024 06:36:27 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055663F8FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730987; cv=none; b=pNd8/VENSJ1XeLE5KEKXkGyQLY/jYh8as09FatrSfcuYGumOQunqaDIcBAAbOqMBIabIzdxB5B/ZfXcKqUUx80RmM5/uQ8Y9ECdT64GFPEo63bMl1W7uEZj63cpydmqrd5DQigBvUWfj7YZqFyL782+dqkiPqgBQRdjq/OfBfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730987; c=relaxed/simple;
	bh=xs83s6oIEPW4cMhg8wwW1AMRm0+CYAxYP4GtGXNydqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXQFquEK4TSrqBwXi2eNwSsV0FjgMW5xT77F0AQW1hgLKoIJCSIx9yApOP/86rumelO8cO02UXcZ399LEDcXWn85CBeqG2qLxlkyHrgcqqc8bzbJfiuVbNw8VAJ6j/MKoFX58WeHclG0qBx7EKOf+pPnHVmk313Tmi7sx3HroG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1712730902t5w2xg72
X-QQ-Originating-IP: 11WQUV0r5zeVO1AoN22iVtolLSL58diAT6MAVG6NtKQ=
Received: from HX01040082.powercore.com.cn ( [14.19.197.107])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 14:34:58 +0800 (CST)
X-QQ-SSF: 01400000000000B09000000A0000000
X-QQ-FEAT: 5x8Sgf4S6/ibmGyV3WobG9KCGSh3CfJOt5MS70mBYmRNDkCu/CLpXhQakp5Oe
	foHkHFQ1Xb62EDUYBvSRqWRKlrXc7moIGe8iNUnjxQKslMyV8YQCBcaGCOiKN72aLhnkb9s
	qNBcKElaSgGw8eK1Nbg9TW54oX0kJKLmJ8SyGcJiZc7LN/WMbDkysH3TowkGKuVqHU6AJf1
	TYjI62P5c24MuSiQtir9YxixB4NvUopOkYEibXf8t3Lt0uc0GN87tZogJaE3W1IdwghmFxk
	hhxcKuRf8YDztHPEySvI6UzYdBhu4PwrfPMQ4CCuDkJtK0XQKTnFDDQtDD8ypNIj5YhN0mH
	9WhpuUyxrla5J1CssyEBPGPLczjMHHJFTsvpxDbDMOwE687rH6VyqHNv4N19U5fyff5++lE
	P0eZmeeSJvRVNpBLaMYAgGZSpm8ogdtr
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4090882819559728776
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: palmer@dabbelt.com
Cc: paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	atishp@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: [PATCH 3/3] riscv: Add information for MAINTAINERS
Date: Wed, 10 Apr 2024 14:34:32 +0800
Message-Id: <20240410063432.23058-4-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
References: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

Add the description of the RISC-V early console to
MAINTAINERS.

Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..bdc013ac4e75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18936,6 +18936,12 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V EARLY CONSOLE SUPPORT
+M:	Jinglin Wen <jinglin.wen@shingroup.cn>
+S:	Supported
+F:	arch/riscv/include/asm/early_console.h
+F:	arch/riscv/kernel/early_console.c
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.25.1


