Return-Path: <linux-kernel+bounces-91269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99CC870C11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C541C20E47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7721EB5A;
	Mon,  4 Mar 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Y9XH6vec"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C51CAA9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586284; cv=none; b=oAS4Lzd/JZbBTG1l9oTIAOyfi8ls/YKAw0qZJxBCKAtX2Udt2D6CJqs0R8v05Z8mPWq5jRSNKDCmi+dcoEMLNAnsimC5BVgq/k1D/dUpa7eFG5f8kjJjDMAtHEHZO8jvQ0rJAAIXljKocXX5SoAmyC7c4VfJxt8ZNxmCtFHNleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586284; c=relaxed/simple;
	bh=Tw6Vginuy7S095bACk50UnmKKPupKBfXrXjYBWULZyE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=glKxS8rWClvHuP2g6rj2FgF5YXvOLWzoW0+wu7biQeEjBplXcDXSIKYqfvqnCAess9OIWrdZJfiij0E5ZP1nON19mbX9K1+R6dnYRzAXWQJu1iIDeLrrQFhZqSPpyif1VqMkFBgUegzWrVzY7yi36yawVqFCso/VG72Za0paocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Y9XH6vec; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586276; bh=GFMJlJjTlI/YnjqaRDuRJEvR/O/AOIAkbGZdzMRZ1v0=;
	h=From:To:Cc:Subject:Date;
	b=Y9XH6vec7VecGyC+qUpR5WS7gAphXv1mDq3MeWyze30OlEeSV8lRbv/FJXi7aeghm
	 LJf+8yHAkIe2DkLhFUdPiqWfYZRP7wPbFi++duJj8Gf/9esBp0Bz5s2+HUJ6O4JEuY
	 KpbueOpbM9pEB81kn7QrNGNXrVRjepSGsaqA9reo=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 11F9664F; Tue, 05 Mar 2024 05:04:31 +0800
X-QQ-mid: xmsmtpt1709586271t3nxb2zjd
Message-ID: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
X-QQ-XMAILINFO: OOnbKU/qCQQlTfJAqINLSh0d4KoIoE+5EG42uJPeTXDuDxpVHH4R5nzqxk1Ct5
	 NW7LDGxcpXuOVjHMhG8ahYOt/uaDlZzhmWYtv+/b2580LFjJJ9xS4+lr6KmiiYri0Bke+VWzYxhy
	 sPqdPDEcfzc341a9H4kUVehG5L0/ociq/P2j+GnN8gkPhcxzkbpQgbo7NxDP2kGPLeAwA8bPWwVV
	 p6fJVOv1KFwUc7WukryBd07MbPSMEwNrTEGbvLr07Z1CQjk5aJZ7Gri89VxKv0X2jxXJJpZA3kV/
	 s54fnlvwjfare/3qqfxBkGS4oRU+yekg3anKR8VdvdE5S+A7y/GX+AXDvLwB9TpsKZ9zg8uHQ/QW
	 /Ii7c6QOKtY03P+NoPalujMCajnQsLk9PermHgKU+F6WiY3U+aeyt09OST52VALFAGXLnZfinU3a
	 z1w8wh5pk6ZFQyqEIt0qI8n6PWpTNj+JZVYyi74e8rL/G2GcWeeZO4bAJekU9m+K22E94hDKbNDZ
	 v4KwIiiMfHmFhn0uggiLcnMvv4aY2a/9ScF3K7PI6AkyQJaunwaUjX33EQAgvTOipfgw5dU8rKCP
	 v+ox8MaJnn5eguzT+ikx7RbczyZxXdvIOsmX4o33pke+xFK0PF4hv/7VXvA43t1wHp+gHFtBioro
	 LawTYZXJeGy3qcef21pbQVQBqHBL/XaDoAa/6XFw9lDi2Ejw1pOjuBS8kA9eRVlJoeCQUo2lE0/7
	 w2xsFCzoyvB0YRmk+leqY29Fw7UQFkAtiQrSsLJeJduZqkvvztOCk295T+SGpDROGFrVHjxKf2Bx
	 4gtlcVpwz1fnPEKnAHhSVMatX3MSMHF0Q80Py6nhArxU3B1fynNJkMUx9pCgHs0eKP71Bhfij/p4
	 ODic4vcVBJyH2IEnrtVudlPX4TzFPiz4g9A5gNU/f84w2kWws5JkLc5hcFG4d1rZ9jSJ8Lcp5WsG
	 U0BewuP0ZT/Jvl0LzYg+byRNH6ZF5NL31PjksCgaY7pLEPyJLrbtSuFUAPpAQh20oGvGu0U2/cWW
	 zF1OhNdhXalt1jbpHt
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH v3 0/7] riscv: add initial support for Canaan Kendryte K230
Date: Tue,  5 Mar 2024 05:03:21 +0800
X-OQ-MSGID: <20240304210321.777296-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
support for it to allow more people to participate in building drivers
to mainline for it.

This kernel has been tested upon factory SDK [1] with
k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
locked pmp and successfully booted to busybox on initrd with this log [3].

[1] https://github.com/kendryte/k230_sdk
[2] https://github.com/cyyself/opensbi/tree/k230
[3] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176

Changes since v2:
- Add MIT License to dts file
- Sort dt-binding stings in alphanumerical order
- Sort filename in dts Makefile in alphanumerical order
- Rename canmv-k230.dts to k230-canmv.dts

v2: https://lore.kernel.org/linux-riscv/tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com/

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
 arch/riscv/boot/dts/canaan/k230-canmv.dts     |  24 +++
 arch/riscv/boot/dts/canaan/k230-evb.dts       |  24 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 140 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 10 files changed, 203 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

base-commit: 45e0b0fd6dc574101825ac2738b890da024e4cda
prerequisite-patch-id: 2374c56c0032e616e45854d2bc2bb1073996313d

Dependencies: https://lore.kernel.org/linux-riscv/tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com/
-- 
2.43.0


