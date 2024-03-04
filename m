Return-Path: <linux-kernel+bounces-90794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E7870522
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063F51F231E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC53487BC;
	Mon,  4 Mar 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zziNOuqm"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF301946C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565312; cv=none; b=WU6ra37jh91OAj5xq20psH1kSLHRLw7wNYqzVWbXqjrBGiS0sJxooVp3ALtgdiEqDAQpFZHTN1f5gmekg+n6rq8ho4HyboOcbAzSPTU+jj9lghLM3cAwfMiExaAp68mywTG7WQ97lz1i9kn1hWFa/1g9efC2Zukzjyd21WRn7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565312; c=relaxed/simple;
	bh=UVb+UzDGo6r93A9kFqS+4qMonZQvvkS3RQouaGJ0r58=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=AsU5JXNu+3CC7og1WqbMSLeTp5CHQrhM0eRGByJkPIa3biaD3DjCaIamFWrEiK+UCEnhEmLsP8zAjcwUJyVjkMJwGsv9gJ3WR3I4uFtE9yatePcOm9O7w2jLlFQ6nQiooLDLhoDrXGk+ZigvLq+5+7oi2laNgfjIeF7WcRPzduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zziNOuqm; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565305; bh=j3aOvq2bodsmjXO3Ej4yrzGf1N49aFt+VJq79Wh3FMI=;
	h=From:To:Cc:Subject:Date;
	b=zziNOuqmPjts8WAyk2XbyJbjmqbQw5D0C3s63ZH0+yYSt4Ml1NW9F+r3uY51aHwSb
	 9YTbG4pqrlMsPEXn2MQ1vQajHzFN+x+CSufH9tOMSKTnCg4PU1+89pLkdfBePAbekj
	 TpEUWk9a7vjh1ZDaHKvSpjF1fOOiAvNq5qX8KHsQ=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 3C13D406; Mon, 04 Mar 2024 23:15:01 +0800
X-QQ-mid: xmsmtpt1709565301tiowc6h9o
Message-ID: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/VZ9FGJP60gUkkwv9Ys6etbYC0HQzPMG9u1NmtOFAC+KD+70eV4
	 DALqGINNHW7TlqRmECPbqlydAcDQGZBlLNoQeAkp3PbCC9/6x0SGR2ujaEjYSivx2keWX3GUWpNh
	 9S0zYADtu4mmoZw0gBHlSHZD8jZszuwacGdV3w4kztTPHnVi1yubqH2bgjf/HbJ8PvoH8foCFy1b
	 XnrJA6XmjKXcNV50feLGAT54IIWAtZsJ2s4PFMOIPZjFoY8wUC79GcUGdP9K3E66IVWOG3i6ck5I
	 FVO9tiDkhmIdQsU60bvjQzJeHHRPo5wZbn/RZR5cjtNpNnfrnZ4X3E5CwNu8mVYvlA33/B0QeXc2
	 +qDJ6RCkY5yQ84asD6CfEBZhfMHe8HFyatVn9mIzhy73io/irXN0aTe35Afmg5qOpVUsdAWY7zZs
	 znrdKAqP+DaBOz+Z3cdja4jcQWlSs+w+2hzjprmwkWXZTA4Sf0hSpRNVmOyS5QHFpxhU0gYind9C
	 KqxmyatdLSmjUcex/n88dXo30d0KE2DNANH+EdtI/k2fBwruoEXk0+KF7HvYW7yf3IPlVa/X5m8j
	 DV5/yB2ik3ORaQZPYoEstwf8lxjDXQU4BB7XrvVDHvYLMYp80PV9HIP4Eq33lli2UFHeQwnwR1qh
	 yl+PFHbhfZF6AsHRbQM9kpC2I8j7H5j42mRyY0Dg4YBFW4s817m1N1mP3AanQ828Zcwp+RYirX1J
	 nqIsBbLcJ4Ivcp5US1RLfYlmDhGCz3t9GaxTM8+mndH+EYoOvdbYtzdttRCVGZreQ9K7sQqXpjT3
	 xHYUvoLADbRHuGm4HP7rue78/nThXcPNFoc505i9VOv88LURaVfwGeVJlDT/bzgRhtp8Y5IT2Xp3
	 k/RV6LsYAA3UOVUCu85vIDggJIRYND50yQDBBhQ1i8HcZLG8ZHAAkZAkQRZ/BgowwVh4IrrAezsv
	 VSuBQ0PAZRutrm2iuK0pN9YGDKykdHdjktSi4nRpEYox4oVT1f8QYarYxhfB9vtQT0qGR+jdhNpa
	 hSsa1tzs8dV56OgiOFGkaDjRWfbQo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 0/7] riscv: add initial support for Canaan Kendryte K230
Date: Mon,  4 Mar 2024 23:14:38 +0800
X-OQ-MSGID: <20240304151438.758641-1-cyy@cyyself.name>
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

Changes since v1:
- Patch dt-bindings in clint and plic
- Use enum in K230 compatible dt bindings
- Fix dts to pass `make dtbs_check`
- Add more details in commit message

v1: https://lore.kernel.org/linux-riscv/tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com/

Yangyu Chen (7):
  dt-bindings: riscv: Add T-HEAD C908 compatible
  dt-bindings: add Canaan K230 boards compatible strings
  dt-bindings: timer: Add Canaan K230 CLINT
  dt-bindings: interrupt-controller: Add Canaan K230 PLIC
  riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for K230
  riscv: dts: add initial canmv-k230 and k230-evb dts
  riscv: config: enable SOC_CANAAN in defconfig

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/canaan.yaml     |   8 +-
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/Kconfig.socs                       |   5 +-
 arch/riscv/boot/dts/canaan/Makefile           |   2 +
 arch/riscv/boot/dts/canaan/canmv-k230.dts     |  24 +++
 arch/riscv/boot/dts/canaan/k230-evb.dts       |  24 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 140 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 10 files changed, 203 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/canaan/canmv-k230.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

base-commit: 45e0b0fd6dc574101825ac2738b890da024e4cda
prerequisite-patch-id: 2374c56c0032e616e45854d2bc2bb1073996313d

Dependencies: https://lore.kernel.org/linux-riscv/tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com/
-- 
2.43.0


