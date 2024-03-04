Return-Path: <linux-kernel+bounces-91157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32503870A31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AD91C21B27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB87BAFD;
	Mon,  4 Mar 2024 19:11:02 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5817AE72
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579461; cv=none; b=p1g0iDpzkQg63zpxBnhm/moN8lFmm/BEsd/sBbQJMaNYJmdvbGaugOBTgQnnINGeF3ewLHAISoK5iwtY049D9naSEXttwCgeu6K0b1Z9QUaj9433QS05LXYzm1+9c7rhcDdd7kMXbtB+FTTdsYhdufAqwLnCOMdFIluVhuranEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579461; c=relaxed/simple;
	bh=E+qJDFY6zi9Nz5E3gi8d133G0ewbF7dK4ZuSWuhwbU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npR9r8oUl692Qt/V8zPYxGB1WFtt46+92AMBdjVv8wrr6hUQ0T+hwkFADB1X95cI+p57JCoSjKmTku8JZfHAdobFlQ1wfYQgPr3H0rEyUILBfW5TAvdrRCkxI+v0I4dtLBJvqKEFoxsGC2OlrExurNIgC1DuN/HOiNA5v4wB1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by andre.telenet-ops.be with bizsmtp
	id ujAr2B00F2qflky01jArLi; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KKF-PG;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcx-EG;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] sh: sh7757: Add missing #include <asm/mmzone.h>
Date: Mon,  4 Mar 2024 20:10:48 +0100
Message-Id: <c9c26472151d16a2ca91f14bccd64af07a6abdd8.1709579038.git.geert+renesas@glider.be>
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

arch/sh/kernel/cpu/sh4a/setup-sh7757.c:1240:13: warning: no previous prototype for ‘plat_mem_setup’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 67e330b7ea4621e9..2ad19a0c5e04ef2a 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -17,8 +17,11 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
 #include <linux/usb/ohci_pdriver.h>
+
 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
+
+#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 static struct plat_sci_port scif2_platform_data = {
-- 
2.34.1


