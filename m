Return-Path: <linux-kernel+bounces-30051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD05831873
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADF91C2254C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9A241F5;
	Thu, 18 Jan 2024 11:29:49 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A46241E6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577389; cv=none; b=RwH+7De+Xj9JQKl4N/3WW2fmyv57oRA0Lo1b1cEow8XT32Pz4oiygiNo8pE59d6vkQl3B+dZJU25qL4TvwFbLex4eZWGPwREpMtWnJoLMwax/dDlvuloZHw11ipCUFaOvB5ZG9s1z0OZq5bWuUP7UHpTv/Ha8Lpppl9wFEdaAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577389; c=relaxed/simple;
	bh=2O/Iy75bfDjbulHm6Kr0GcsGes52RG+ad0YMMtt2/IE=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID; b=ENmcVzfKoA3WED69hguS+1xM8UTJdCcBdLzp0fkdoEYuEeR6V7lknVXL8P1PhLKDxkiVahcWAxuPK0zj+OS0NpquJJ3QqVXsRMo+u+tDmwna8O3u8qF857KdvEgCd991f3oKaMwdgW33++lAjMB3eLOqhDLxFqARmwN1JYJOUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp83t1705577346tdoedby8
X-QQ-Originating-IP: z8HZiEvB8MCnJh6D5ALakYlaw3Og1CMVu3niRRp9io4=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 19:29:05 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 5q30pvLz2id7POveai5rqRYqIb7Na7Xb+LYrC+8Tki+RmEjeg7Mtf2uB0Qx7w
	cluUF3W8HTUn5Fx9OpY0XDdldvUSH8UQ1kjAsa+NvXnDsQa8newApYLlsrYTGBgUl0sSapi
	XN+mQQj3L9IJPubGvjGLxIIqlf56g9T86h/S6neGrL5k42/Vc3PnNgqYTBflHTLaQyoFBac
	VsVn06xm7ZBHVw2r5mUmtPxrD+ZnYmFRm0dLtkKXFiKNLpAghKEkSdyP4LFsmZvCSRiP4/D
	gjBV6dMIUr7XI/N4BekoBdZ1l/zbWBlkvwYQC2wXbdwhoOIUaocMWC1mbmbZdaA54Igi2U2
	74MkMCZ9gP+RBUruhbbowlPSmj5wnVqdleekGRzln6aDUUcXHE=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2331251602607730780
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH 0/4] Minor cleanup on gic(v3) and genirq
Date: Thu, 18 Jan 2024 19:27:35 +0800
Message-Id: <20240118112739.2000497-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Thomas, Marc:

This is a small cleanup series on gic(v3) and genirq, in which:
- #1-2 are minor cleanup on gic/gic-v3 codes;
- #3 is a trival cleanup on genirq header;
- #4 is a fix on genirq;

Dawei Li (4):
  irqchip/gic-v3: Implement read polling with dedicated API
  irqchip/gic: Implement generic gic_irq() API for GIC & GIC-v3
  genirq: Remove unneeded forward declaration
  genirq: Initialize resend_node hlist for all irq_desc

 drivers/irqchip/irq-gic-common.h |  5 +++++
 drivers/irqchip/irq-gic-v3.c     | 32 ++++++++------------------------
 drivers/irqchip/irq-gic.c        |  5 -----
 include/linux/irqhandler.h       |  2 +-
 kernel/irq/irqdesc.c             |  2 +-
 5 files changed, 15 insertions(+), 31 deletions(-)

base-commit: 69ffab9b9e698248cbb4042e47f82afb00dc1bb4

Thanks,
  Dawei

-- 
2.27.0


