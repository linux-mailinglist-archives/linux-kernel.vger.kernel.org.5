Return-Path: <linux-kernel+bounces-137993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFF89EAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C061C2144C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DAF249F7;
	Wed, 10 Apr 2024 06:32:55 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EC22085
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730774; cv=none; b=L5lRzvkfjUGpohCydOjad4Y6hm7Fc/1GiVi3AA+yMbNSGe4QjJ1REEEXHndrNo8NeWDT5Es0adtnPkpOUH1j6d3cSTt8AqcYeqAlFC+7bxwXExZLrExUB3WQmgHBaCDWOWbh4g1B3LNZvR4vJ8bAtud9wQ3vta4n2VfoRQugNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730774; c=relaxed/simple;
	bh=DksJD71LSA/lTxh+KoWTN20bzXaJEvyG97ps3N4apDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fDC4wZDeVXx0yEvboP0t6+9/2pgw0mTnCafWifTeKq+Cp26wBw6zfQh3/T0H1Je1zF2vAG10YZSTvU/DIfuGrG2wAUpASzsj/Lv3PEE+SIU1V8ukkCbjOCm7kCqieNg0rLvwVfASGTLW5wdj/v2mm24ICpN+I52tPdbyAc7knaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp88t1712730689t01lhhz8
X-QQ-Originating-IP: DR2jmQRNoIooP2y4DSvc27GYUaEoyry4t3NtVCqNbKA=
Received: from HX01040082.powercore.com.cn ( [14.19.178.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 14:31:28 +0800 (CST)
X-QQ-SSF: 01400000000000B09000000A0000000
X-QQ-FEAT: BycE0arnt6RHytf6+hWz5URWjN+mlFrqYJZ7Wctl56D5JSUSbjoAAwPUFySvH
	/F2WWk8xOL9VAWvwPgGwIxwb1KNwNvw+ck9oRAQyWw7xTmv8nwZrKHCVpSsviHAdaT5ItK1
	x9HPuGbRcUcpfi2FAEYLBhJ8HUzduNIV1OxAz/h3ZdUxlXyKJQyjqRZnsmijX7Uc3HsB+iF
	YXiitiCFZozuR3kbMjZjxThs8Klpr3OuN++7rRgwl1FHh15pftH7Xh5kDK6yRM5RSYjXgdT
	FmWL7XYqSDqBAcuKXrdCXTPjIIka9ie/f7euWzxPRwejGaIRqp3WWor2K6q8AKispDZhFNI
	hdeSk9bPJlzgG4iYf8ZCLRyc3WMvg2Gi3bgiVYOGipEMq3o2+p817586rCGpwQ3ZaOkFcFY
	zZ+sULD3I7o=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8989228139429590105
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: palmer@dabbelt.com
Cc: paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	atishp@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: [PATCH 0/3] Add early console functionality
Date: Wed, 10 Apr 2024 14:31:06 +0800
Message-Id: <20240410063109.20483-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

The following patch series implements support for the early console
on the RISC-V platform.

Jinglin Wen (3):
  riscv: Support for early console.
  riscv: Support SBI as the interface for the RISC-V early console
  riscv: Add information for MAINTAINERS

 MAINTAINERS                            |   6 ++
 arch/riscv/include/asm/early_console.h |  23 ++++++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/early_console.c      | 108 +++++++++++++++++++++++++
 arch/riscv/kernel/setup.c              |   2 +
 drivers/tty/hvc/Kconfig                |  12 +++
 drivers/tty/hvc/hvc_riscv_sbi.c        |  29 +++++++
 7 files changed, 181 insertions(+)
 create mode 100644 arch/riscv/include/asm/early_console.h
 create mode 100644 arch/riscv/kernel/early_console.c

-- 
2.25.1


