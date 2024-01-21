Return-Path: <linux-kernel+bounces-32182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DA8357BD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B619281C63
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5838F84;
	Sun, 21 Jan 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCWEtf7A"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0738DD3
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869030; cv=none; b=uOLa4MlkdF1GjqXIOUPvQXg3jAl8NNcCISzjZvsYrlp864/oFJhWDNpP8Yry7jRbRysuhHZCKo1nlSsKA/Dv02l6ldoIl37A6otGQYMgJLg4VulzjSEQz1tcD3I7x+L2jmXOqAzlBIQc1hSZvB/eZgwtYtuXKMCLsAtT29t24U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869030; c=relaxed/simple;
	bh=qd/WQekHV6Ik6ClIc99ynF3CW8rR0t1PzhaYDAk7+bU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLDjgTEJwqvOuTcRAevAPSZAxLkNl0goPkyqEcJaN0cpc6ZK1laWtZY26OTOPZ3HlDof1W7mKv1idOCtF9BS3bHUEDMLHZFDnOE7HWqqqvKNYSu/I//0Yo4DSOMu3uVOtUqhNeBphcpIDEKA38zHvP7gSIsJISS8LneNj2CT/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCWEtf7A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so33533385e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705869026; x=1706473826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njA8TuiX4/CIlcjU6qTOSBsn0Z7EKlFnGPhxFsmpsIY=;
        b=MCWEtf7Al9wF1JaN7027hUf4lYh8zl5MDiMOSwjJUeCW33801a+bB+vB39hjrww9xT
         aURypKJuh/022AyGmXYyuqkR1H1o2P1kOebQO07YQg6FSQHJEDGsdMQzWpKLEOvjgE/N
         e1a3Dhvxi771D9iaOnj/BSKzqjiyPvNeP5wG1P+qYAwGCL4m443HiPVuC+yIjFlBLzR5
         q3u3Ps7R4WY772BT/0e+lkUg65gZX0IfoQTSJpu44wPy3rPkf+LZR7na49YMzTORRJdz
         fJjfgDWx6f+6jK0QNT0hqTlYYkPo6x3BlWuE8GDGbJ7QcNYWlZnzLKhQTcXwCvlavpvH
         uyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705869026; x=1706473826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njA8TuiX4/CIlcjU6qTOSBsn0Z7EKlFnGPhxFsmpsIY=;
        b=dAQSa8gtUfs4fsN0JMyg8f/wZhE/j9PFAaNmT9waT+bOI/QjUUe+D/d9+x/avwRb5c
         liJ0EkV+GVX14HI8EjPoNUgRaOBI/NlDxksny81GDo8CfYVWIalPnyuw9Nfv2hy4cuFj
         7NnFF4Rvqe+2oc6mi1dF12X3g9s/WipHrnb/BWfj2MEIG5oKQXnDoJa2+wDOebRhs/Wu
         exH4mHZn5y23dVPokwSZ1Wt3F7d0z1yGAvGaFTb6pce9RjUHFDfLKqq83zK7Yi9esSG1
         edcry9DCnrz//IXfp5ZijPvZ+08O86SO2BfkjsXqFxXxFCXHjywSg9Fowvk3nmQPoQDn
         mBIg==
X-Gm-Message-State: AOJu0Yz1a6x1KEhl0d1NuGbXoO8lsFLbYL5hsugX5lH3EXwPJk1W5H9V
	WeK7p4KpT09vuLCHaiNk8XZhp2L80V1hGxPYBBGIi5YqPkilI9OD
X-Google-Smtp-Source: AGHT+IE4DRxICmPiz2zCdXgFL6qIV+pc0m2t7s6qhqFbkIpFndXOczB4KLmQjjL0M52jhmwTacoSHg==
X-Received: by 2002:a05:600c:6907:b0:40e:88a8:2185 with SMTP id fo7-20020a05600c690700b0040e88a82185mr1825036wmb.176.1705869025687;
        Sun, 21 Jan 2024 12:30:25 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b0040e9f7dadc6sm9021967wms.25.2024.01.21.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 12:30:25 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: [PATCH v2 2/2] ARM: decompressor: add option to ignore MEM ATAGs
Date: Sun, 21 Jan 2024 21:29:34 +0100
Message-ID: <20240121203009.9257-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121203009.9257-1-ansuelsmth@gmail.com>
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders can pass broken MEM ATAGs that provide hardcoded
information about mounted RAM size and physical location.
Example booloader provide RAM of size 1.7Gb but actual mounted RAM
size is 512Mb causing kernel panic.

Add option CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM to ignore these ATAG
and not augument appended DTB memory node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                        | 12 ++++++++++++
 arch/arm/boot/compressed/atags_to_fdt.c |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b2ab8db63c4b..6bb5c6b28106 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1549,6 +1549,18 @@ config ARM_ATAG_DTB_COMPAT
 	  bootloaders, this option allows zImage to extract the information
 	  from the ATAG list and store it at run time into the appended DTB.
 
+config ARM_ATAG_DTB_COMPAT_IGNORE_MEM
+	bool "Ignore MEM ATAG information from bootloader"
+	depends on ARM_ATAG_DTB_COMPAT
+	help
+	  Some bootloaders can pass broken MEM ATAGs that provide hardcoded
+	  information about mounted RAM size and physical location.
+	  Example booloader provide RAM of size 1.7Gb but actual mounted RAM
+	  size is 512Mb causing kernel panic.
+
+	  Enable this option if MEM ATAGs should be ignored and the memory
+	  node in the appended DTB should NOT be augumented.
+
 choice
 	prompt "Kernel command line type" if ARM_ATAG_DTB_COMPAT
 	default ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 627752f18661..b5bce4dad321 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -170,6 +170,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 				setprop_string(fdt, "/chosen", "bootargs",
 					       atag->u.cmdline.cmdline);
 		} else if (atag->hdr.tag == ATAG_MEM) {
+			/* Bootloader MEM ATAG are broken and should be ignored */
+			if (IS_ENABLED(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM))
+				continue;
+
 			if (memcount >= sizeof(mem_reg_property)/4)
 				continue;
 			if (!atag->u.mem.size)
-- 
2.43.0


