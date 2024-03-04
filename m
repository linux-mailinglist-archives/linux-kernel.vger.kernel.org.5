Return-Path: <linux-kernel+bounces-91155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D08E870A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF701C2186D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8A79DC2;
	Mon,  4 Mar 2024 19:10:58 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37878B7D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579458; cv=none; b=XakjLzZ6eJEMdTKq1HKiaMSI2Tr6+1wQzOB8vq4T1KsSZeVp9OiwkYZu0+MXnbGJGf8uia6YNXpXI+D/XB08zPGF0bmU0aO5INxavrRBf3ARtkDdH24FfLgkikvRD+VHZ2mXRWBe5xLtn1cO91HDRsVT0Nyz8COAz766JckJdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579458; c=relaxed/simple;
	bh=YBY7KZbj02wlfGdHmoSJj6VE56Cov9ptssg9IM+FkNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCx/Urit4buXdFKfPR8bSEBvFSYV9yJWN+LKkzH8EVr0i2C+j1tIn+JQTGZe0PRY62VEr/kMaXf15CKWQDiinM7Jl5JGUlw4K3x72fMqfdI7VSov4sj4d0gMd/zK15yJEk1bwtLV7dlVCahFz5wNX3YsIdIvsQyS1BbUwGMnjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by laurent.telenet-ops.be with bizsmtp
	id ujAr2B00J2qflky01jArdh; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KK3-Mr;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcp-Ck;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] sh: mach-sh03: Make sh03_rtc_settimeofday() static
Date: Mon,  4 Mar 2024 20:10:46 +0100
Message-Id: <95417f2a3eb1561af7c2ee064efbc3ef3f03dac3.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/boards/mach-sh03/rtc.c:123:5: warning: no previous prototype for ‘sh03_rtc_settimeofday’ [-Wmissing-prototypes]

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/mach-sh03/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 7fb474844a2d1d65..bc6cf995128c6547 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -120,7 +120,7 @@ static int set_rtc_mmss(struct rtc_time *tm)
 	return retval;
 }
 
-int sh03_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
+static int sh03_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
 {
 	return set_rtc_mmss(tm);
 }
-- 
2.34.1


