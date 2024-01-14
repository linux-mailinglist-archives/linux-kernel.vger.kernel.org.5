Return-Path: <linux-kernel+bounces-25402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7682CFCC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A091F21E3E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6B21852;
	Sun, 14 Jan 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vno/ZvQi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47A7E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CPQtu7/pS8bzdUYTqORQKwX5wbUpg7ZbTKuka+g4g+4=; b=Vno/ZvQisOZVmXFVrUOwfSARPa
	W6KsXT5zGr66smHvPNjZMlGKvJIaRZ8R57NoUvE6uVEzfuHQafRqNFWR6RWorj1ru6ZU4RV4qiLSg
	4FJ08z/en0ZhreYm1sI54GC/hNc/b3/NmCujm46VXVXbc64TnmFjdk9oGvLJ2DLeGI3/+uEsOOEgl
	xv7+YGrZTc5accYinJoDantOV/hrsSU1DE5a2b/3ZDA8o2N3ICWBQ1LV+5IO9wgAoNt0+Mh/FCf9I
	ijfdqSFmZAmwrDbcebgNDJn+azYcRnTLEZg/3tVgs/1CDkEQtsnLLmBpJE8bk6JptoqnEwI+hh1z8
	JzCT9gzQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOssK-006CHT-2s;
	Sun, 14 Jan 2024 05:17:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Michal Simek <michal.simek@amd.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH] ARM: zynq: slcr: fix function prototype kernel-doc warnings
Date: Sat, 13 Jan 2024 21:17:30 -0800
Message-ID: <20240114051730.16796-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the same name in the function prototype description and the function
to prevent kernel-doc warnings:

slcr.c:158: warning: expecting prototype for zynq_slcr_cpu_state(). Prototype was for zynq_slcr_cpu_state_read() instead
slcr.c:176: warning: expecting prototype for zynq_slcr_cpu_state(). Prototype was for zynq_slcr_cpu_state_write() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-zynq/slcr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -146,7 +146,7 @@ void zynq_slcr_cpu_stop(int cpu)
 }
 
 /**
- * zynq_slcr_cpu_state - Read/write cpu state
+ * zynq_slcr_cpu_state_read - Read cpu state
  * @cpu:	cpu number
  *
  * SLCR_REBOOT_STATUS save upper 2 bits (31/30 cpu states for cpu0 and cpu1)
@@ -165,7 +165,7 @@ bool zynq_slcr_cpu_state_read(int cpu)
 }
 
 /**
- * zynq_slcr_cpu_state - Read/write cpu state
+ * zynq_slcr_cpu_state_write - Write cpu state
  * @cpu:	cpu number
  * @die:	cpu state - true if cpu is going to die
  *

