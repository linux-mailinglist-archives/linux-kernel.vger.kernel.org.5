Return-Path: <linux-kernel+bounces-89755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7186F522
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4441F2244E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B1FC16;
	Sun,  3 Mar 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GctLVweN"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD8FBFC;
	Sun,  3 Mar 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472641; cv=none; b=RjUFMilLrbaY/Xnq5AyiIzv08QUTL/FFK9WkwNc5AfG8quEM5qcbEoINnHiIaI6LetQBA3VnQ5erZMW5J6FVPeVAvh5otkLOih4Mo7w5gqjfbuxin/5GLDOADA11B51JCxggRM430vfcSEL8SO+6siQacwQz+sIu8RdpgjehALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472641; c=relaxed/simple;
	bh=rxdJ/+aOv2gHONz7u651HyYacZjNdwfVMJzTD8JojKE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dqU4tubVUsI7smYvGfj6xBUmH7PodVrP0bbN+/LVOsQ12rt7eMElKhZawkL3eBrFj404Wk8FqzwCvAGhhKnCThmCPDDaYQ6aN+q+bBLBqU+/QhLm/GhZETLNtkmw/PFgu/uhIe2pgGG8audyjvDkajnpk82JEg0nSxbaXQNmBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GctLVweN; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472337; bh=0NnuotmW82k9Uowjug3hFc1tBh20nPWYMO1pQs9NtRU=;
	h=From:To:Cc:Subject:Date;
	b=GctLVweN2bt94o0GW0IDtMFLTA2Ht8varYIami5ayj3VwOyQrExLu2nH3/wyAcOwO
	 2sEzMxfIQDOxI8J512z+p9CG08FdHs5XiNgDbjUDx9gH/90VDh0E05/BGZ1YwAAGe0
	 S4YkdR6rkepDV+Y5VJIJG3jQ+RtOVGFM0o6hl4VE=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 66020E94; Sun, 03 Mar 2024 21:25:32 +0800
X-QQ-mid: xmsmtpt1709472332tpga3oaze
Message-ID: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
X-QQ-XMAILINFO: OAope3s6+8XpDdhJJsQ3bRuNam29vw7aFRTpansOS8sQmNaPjd7Xszx2BYgI7u
	 Td30rFfPDfs0CCsxthDeMzuSbG+KEfeDD88J9Chx0ds7Dgl78SHvhY5XIFFv/Yp2b3gs82bIEXtb
	 jR0As8tbpQEP2ci/vrabea1X1eWOawXDEuvf7FMqLd05cx+zi1Pj9cpt63uQIC8vaCDLeFuPj8iE
	 Gww+jVvbSw/pDiiiCZ3GTtuBzQqoKJSgLw2g1BWOSLyfATbKT1G8l+04+CE2gln2hGwCaGj4HgOk
	 4Hntiax37kiHJcRfhp7+B0tVeb30deSakyaDf5d7HRnq1t2He6GzgiAhT7cHuKQ7Oom7fESNSLIm
	 CTKPfxnr2rP0Z8T5yBA3ZScunYW7HOibZFkqro5u6cU6rLwyz9V4whWwtJXs2jhvem+SoEwnpMch
	 KNJgbgpcx2ITmDZiWyaGC148LIj6qgjB7Cm31mFlDqyV6mz/ZeUy10DqjkgHCpskBsDHhQfEqBDq
	 O8wUU5ogleoc5IUilB0ME6d12MCW+rTwNOHxTqdcx6Y0ZKPayfj8ylahTpxqJp5beKZj5+vls01Y
	 CA6uH1+aL3EW6iDOMD+nFpKQ+3vdAsP3shtoxyTVvtQS+PR0I3Nl87dbCBBkS7A+AdunvA0JaxOp
	 1msHnuAiOEQtUy9vNV45WE4QiAJsEGwSlPeZ84IxH3/yj08bH2W5GdeymU9W/skO88rrswAcqcs0
	 q9OaH5gOoaa+pQBxZ8bA/ZynFu/7tHv5zmoOLzYfI6aeTydKwh9AgWRY5YtEqxTHNek/Yx1QMfd5
	 CByDJU4VMgARlVzuB3d2h8SoBowF3A2BhkWyODLQe/6s6XTG0kO9dgYmNgrjJbTgE2/A6kDnV9oQ
	 k20ZQqxYu/Qro2sTJguxJn0e4VklZHqy5k+x4iprefrQYrcs8otLPS+1bmulpXJ/TBmROIzpQXjS
	 Hm7zb0lt+++33S0S2LldrcBeLJG/B0kuE1VDCkFMGsPtRTmp/XvfLpIWdNnWlflWZAO4FTR/CrkR
	 AYPYtl2gPtCsdxJKmf
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 0/5] riscv: add initial support for Canaan Kendryte K230
Date: Sun,  3 Mar 2024 21:24:19 +0800
X-OQ-MSGID: <20240303132419.553143-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

K230 is an ideal chip for testing RISC-V Vector 1.0 now. Add initial
support for it to allow more people to participate in building drivers
to mainline for it.

This kernel has been tested upon factory SDK [1] with
k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
locked pmp and successfully booted to busybox on initrd with this log [3].

[1] https://github.com/kendryte/k230_sdk
[2] https://github.com/cyyself/opensbi/tree/k230
[3] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176

Yangyu Chen (5):
  dt-bindings: riscv: Add T-HEAD C908 compatible
  dt-bindings: add Canaan K230 boards compatible strings
  riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for K230
  riscv: dts: add initial canmv-k230 and k230-evb dts
  riscv: config: enable SOC_CANAAN in defconfig

 .../devicetree/bindings/riscv/canaan.yaml     |  13 +-
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 arch/riscv/Kconfig.socs                       |   5 +-
 arch/riscv/boot/dts/canaan/Makefile           |   2 +
 arch/riscv/boot/dts/canaan/canmv-k230.dts     |  23 +++
 arch/riscv/boot/dts/canaan/k230-evb.dts       |  23 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 146 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 8 files changed, 210 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/canaan/canmv-k230.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi


base-commit: 45e0b0fd6dc574101825ac2738b890da024e4cda
prerequisite-patch-id: 2374c56c0032e616e45854d2bc2bb1073996313d

Dependencies: https://lore.kernel.org/linux-riscv/tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com/
-- 
2.43.0


