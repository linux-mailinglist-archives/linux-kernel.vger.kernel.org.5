Return-Path: <linux-kernel+bounces-111149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54988685E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FF428378B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4820DDC;
	Fri, 22 Mar 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oK7NoNUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vb3Oy6vQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2E17748;
	Fri, 22 Mar 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096781; cv=none; b=ZoRdKIt9WB5j2bl1zBttKEkGX21apkBKiFuezZhRMmnWGO+FqH0U7hILBbtjwaioH0X27PXde/FfulX3i7Ex7sQk/u6O3P89QDi2sGyYGfLSiCROqFRofcO5+wCChG5IbLzk18sKon+VzPxW+PcQWM1j07OiE0GVqRnTxGkaRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096781; c=relaxed/simple;
	bh=93gzeeaN5qm6QBijvEufRQFWB3Ij9g2W1AnCC2UY6P8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oS/EDwqbsMhiuJFuxcSsxth3U0qgR4RxdG+ITlK8wD1H+wM01nFUQ493sKZ6w+6nQTXIBxP+0uKH++dMiJUpQgHeKCqH3AbKHou7HG56fnz7PAOAR0IJ90krURo8DTimwWl3qJw2u2bzeRf0tAFI+wj4nGg+qeCil68Yyjqkp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oK7NoNUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vb3Oy6vQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 08:39:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711096777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpnWBcijJRp3CYhHfLyQRUEM3geIo4pmSyJ1q1PutW4=;
	b=oK7NoNUaMeqeB36UHcmUGxBQD8HBJ1uAdbPXTmRhy8BcKnTL8ekGTt1hegZgbqh4ix+pCD
	YnUGcIv0KSG4DxBhguEYBK+hqVOvImdygOBa74Zy+7h9rbzYcQs6eBvARgglpYozk5pOOx
	NiMjawkJI3n7TVq7q3nqq7uRn+rgR5iw4nKEGtClXFNcra14GNBaKU9XPpyQm1FSrYVrxP
	kEE8UyHcV2G3rP82Tdek6COuUWE2gHqmQCStNK8Wb4Ux1Aca+SnMm9HFMwHqHc/h1UA0K1
	/QGDe/gHA5Q38rTHvPvAJcm3TKrfSGxjBIEiD0N29vWYIzJtQ2tdVqdNA/+b3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711096777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpnWBcijJRp3CYhHfLyQRUEM3geIo4pmSyJ1q1PutW4=;
	b=vb3Oy6vQVkh2VOaq/mb7O55sIXlaODveekHVlQqE7efesz9vt6sQGLjZrC6fwZQLHMhxVJ
	MEBqu3mSaM5hskBw==
From: "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/virt/tdx: Remove duplicate include
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Ingo Molnar <mingo@kernel.org>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322061741.9869-1-jiapeng.chong@linux.alibaba.com>
References: <20240322061741.9869-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171109677707.10875.10683497940799180966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     27d45fc7df2d9026185e86a7e45f3dd17f3e8ba4
Gitweb:        https://git.kernel.org/tip/27d45fc7df2d9026185e86a7e45f3dd17f3e8ba4
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Fri, 22 Mar 2024 14:17:41 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 09:35:43 +01:00

x86/virt/tdx: Remove duplicate include

/arch/x86/virt/vmx/tdx/tdx.c: linux/acpi.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/r/20240322061741.9869-1-jiapeng.chong@linux.alibaba.com

Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8609
---
 arch/x86/virt/vmx/tdx/tdx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a..49a1c68 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -27,7 +27,6 @@
 #include <linux/log2.h>
 #include <linux/acpi.h>
 #include <linux/suspend.h>
-#include <linux/acpi.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>

