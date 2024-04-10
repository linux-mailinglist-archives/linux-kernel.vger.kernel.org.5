Return-Path: <linux-kernel+bounces-137996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79689EAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D891F21998
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692017BDA;
	Wed, 10 Apr 2024 06:36:00 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078ABAD39
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730960; cv=none; b=ZI7wPkqeRe65DpQdM78YJTOoa2JM+0O5F4FpGebOE76C5pbBW4lC/9D1JOmyVPM6ZVfPiXa/jvZDh9q8aem4oHU5dh2virFm3EP/Kt8Li7QgSePJoU4Qpjhws6h+8zRBWrleKTt410OWDiyrIuZlPLxSkKD5mte0rX/xQMeu44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730960; c=relaxed/simple;
	bh=Wbk7+tt5B+KjHhhiI2wSv4G+x2qk5YCSrg5cYvP/3d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGkTJl226jEzbRmEl2kTykLVfDtDr1Vl4C12Antv73RgfhFmDcx37OZD/yfoOeK0ZumwiSX0uTXaHSVE3f5XR3IV7/zxuLkJq0LuiCQbeI4p4/ljbsTdmMYEMmBEF1R7V+EdkAtmJDzl9gZaeC4HfbI0OkYnP3RNsY98hob45w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1712730877tdxfamr5
X-QQ-Originating-IP: XMC/Y2Cff99dY9PQbikRSBmS4897mos9i3ewMrbtgHA=
Received: from HX01040082.powercore.com.cn ( [14.19.197.107])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 14:34:36 +0800 (CST)
X-QQ-SSF: 01400000000000B09000000A0000000
X-QQ-FEAT: LE7C6P2vL8QcpsM0XxE6roUsBBlPUMTUXBLuXMBDE/CETF9FiznKeqh03oOnY
	M0Qw4nvC45lLsSp2KTiohwk3Md8pj3He3/RNlXxl6qsh0VZW4nmsTHqOG/k3xMHNd+98SiQ
	4AXDYlAwyljrezLrsEZCfyWKrbPqoulb1KXTR1rQKAppiYr07C7dlBAyw57vIurjQLngyt/
	mWGF4wTTzBwIklwl2uY5zCZqjpI25KhEW0TpNbxBsXlq3Eui2FcbIPh2ZGKPLmEvkvVilZJ
	Kslifj+HIXWgKWM9cQN4mPlPIBjkhX0kNw75PJ9MtnteXeFSK0+0etopbWLj1yCT3SnBiSB
	qqAuaG2ieslEQ5EMUXnFavqyG5C7iF7EIzgaLWzsshBDF0UVd8xsaRVdaKI41F0afh9Sqkb
	7XD/9mG/m4g=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1382288310512996310
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
Date: Wed, 10 Apr 2024 14:34:29 +0800
Message-Id: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
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

The following patch series implements support for the early
console on the RISC-V platform.

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


