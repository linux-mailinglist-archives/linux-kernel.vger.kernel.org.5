Return-Path: <linux-kernel+bounces-134551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D093689B2ED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D99B1F223CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320C3A1CF;
	Sun,  7 Apr 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rACQ1qYj"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AD8485;
	Sun,  7 Apr 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507251; cv=none; b=Pdja0btM9i0GyO6BZAvlkBqpgEvcjrZmqPf1WgIBTsJpFY2bS8154ZuI5kknZetEx9SWkIdXPt/A0jntoCtx49fQwXu7MkF9wAqWvkFAAT/y74vLP0xGshvJmgvJjh1x8qEKTQoxhUSJx8ghNXm3KRA6fijYSJm23WxjRSKxotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507251; c=relaxed/simple;
	bh=T8OwOOVKfWiqgdRaYqfMZmwwXk9ZpJJklZsyw3+08qs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=u67oVAukfLn1wPTpGEq0+L2uUE8CQImJ82IKXDKAY90QwSH+o6z+BNH7CvJuPMk82dVSzv7ZA8m4LE3edkRMFgIjWerMiWQPqQ4rYfHDq0CyeQ9YFPZ+OvilArOfTl0LBKZtvuypa7MZMHfNXerUPCICKC+mZhRXdNMrdhUKCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rACQ1qYj; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507238; bh=8u+cV9KILSoHh+LKeRuUnoqayiOf2plCmWOJHizy47E=;
	h=From:To:Cc:Subject:Date;
	b=rACQ1qYjJT/I+e7iHeHJQS1pAwgN4v3P+MM8P8muw+Mx8P8cunLP8vZ4axddqQEDZ
	 vX9bdvoRFZTXw7EB5lgQwDCQd3DBMpUAx+zI5vN0d32QHj0hLu1k4YmKs+VmxcRE/z
	 tIa3Cd7oQeJCw9Iqupq6cHOOHtEMSwnfAdLxZUUU=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 6CE08642; Mon, 08 Apr 2024 00:27:14 +0800
X-QQ-mid: xmsmtpt1712507234t2l6iwczm
Message-ID: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
X-QQ-XMAILINFO: Md8NwmqZYy3fDy3ETQuYENYYYUvQVOi8ulHLChbgsiQjywXmCazVr5/wXMezX+
	 ZIVZ16anZUcYC/VT70cPfByk7LRdQrl/vE+RS1n6EHK6BzHzEwAlgEGPX2O4Oru6AYE5DxkOzccZ
	 WhQUeYfjlUzLFMqjVXGddS2YnSK6tjYOrQs+AQsPbs4fX3gIvMxvcj+daf6tEjYlapEQGjJgcigQ
	 SSyRojB4O+yOu9xseyY7QvM83OWr+e6ajLPNx6WxEyAjkJdXyFOJJ6Deo/Cbb75PL8lPVgoUnpid
	 pFjpr6TlyLTkzwb4eSvQJZfoqiMnSGnjIKeAJu+6OxM1kQh3MlqhLwi1fGW87mZ3/AfmBNt5RJQa
	 r1n2f9C9GjxK5/J0eX0cIAtC6XN8cFysZSzkYphgZywYxCwNj0ERDKImGw3BvzLS+438eUGtyver
	 WQqoENcCJZwSScCYhF042MQN+KxHSdUpRDWUaax3AcTatqqWjVgMxSNv/qWpiqpi7I6QjZCNechE
	 f7zEbKqVpBwLJSVPwC8hi/JPbxeAGEYEATAKj8B15rv2/AgJYqar0gWRS5bXXVguQhAw/IvCcQ3y
	 HRk2JoJ+QsFteUvqf80NmcJlgmiHLhuHxu6x8p7AFdq8WOEdMuuNKsOsdvJE5SBff7I7SiYiIApU
	 Av2xwZFWZeEDcM7h+fPnQIKTQqrHQtCPWlyQqbsaqjtsfh5oW5IKvYjCFcc6Ekg5O/BuMw3s++zq
	 9NAhMKDpAf4mi6b4LkZl7eMDiDi0wmjiaaPoJleVJeVc7rsie637zIHg3Bks+/+PBWXEDuTaO7bo
	 UfRiQZ1n6l39Yw9q2qGxYgpQa5O1p8KQtXwWqIq5KiDkHH15OGfgAbeZiGPfTl1ElXLtxRszNvkL
	 vCIKqohNonf6XbHomSmwwZn4nXPyVQiiYaAR9Zo34La2sIdO7TlaL3HMFJC/rR2B7DczRiSU6Xo8
	 CBbc7hkffK8fF63m6v0BA+rdtw32uTiSxzTQt0iT2RHzPb2jhb+57POjfkq9Y2RHzYaRjH4Qe63t
	 JKTyDuCA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH RESEND v8 0/6] riscv: add initial support for Canaan Kendryte K230
Date: Mon,  8 Apr 2024 00:26:58 +0800
X-OQ-MSGID: <20240407162658.3199215-1-cyy@cyyself.name>
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

Changes in resend v8:
- Add missing cc to lkml and linux-dt list and correct Krzysztof's address
- No change in content

v8: https://lore.kernel.org/linux-riscv/tencent_9F423E3DC13F6D5FC7415C89988490F04607@qq.com/

Changes since v7:
- Add missing riscv,cbop-block-size and riscv,cboz-block-size in dts

v7: https://lore.kernel.org/linux-riscv/tencent_F6392EE11AC6A485C43406F1BD09C268DB0A@qq.com/

Changes since v6:
- Split SOC_CANAAN clean up to a separate patch [4]
- Add zicbop and zicboz in dts
- Rebase to riscv-dt-for-next branch

v6: https://lore.kernel.org/linux-riscv/tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com/

Changes since v5:
- Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210 SoCs
- Modify existing K210 drivers depends on SOC_CANAAN_K210 symbol
- Reword dts commit message
- Modify dts to use Full 512MB memory
- Rebase to linux mainline master

v5: https://lore.kernel.org/linux-riscv/tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com/

Changes since v4:
- Reword commit message on dts that the B-ext version of c908 is 1.0 rather
  than 1.0-rc1

v4: https://lore.kernel.org/linux-riscv/tencent_587730262984A011834F42D0563BC6B10405@qq.com/

Changes since v3:
- Refactor Kconfig.soc which uses ARCH_CANAAN for regular Canaan SoCs and
  rename SOC_CANAAN to SOC_CANAAN_K210 for K210 in patch [5/7]
- Sort dt-binding stings on Cannan SoCs in alphanumerical order

v3: https://lore.kernel.org/linux-riscv/tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com/

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

[1] https://github.com/kendryte/k230_sdk
[2] https://github.com/cyyself/opensbi/tree/k230
[3] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176
[4] https://lore.kernel.org/linux-riscv/tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com/

Yangyu Chen (6):
  dt-bindings: riscv: Add T-HEAD C908 compatible
  dt-bindings: add Canaan K230 boards compatible strings
  dt-bindings: timer: Add Canaan K230 CLINT
  dt-bindings: interrupt-controller: Add Canaan K230 PLIC
  riscv: dts: add initial canmv-k230 and k230-evb dts
  riscv: config: enable ARCH_CANAAN in defconfig

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/canaan.yaml     |   8 +-
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/boot/dts/canaan/Makefile           |   2 +
 arch/riscv/boot/dts/canaan/k230-canmv.dts     |  24 +++
 arch/riscv/boot/dts/canaan/k230-evb.dts       |  24 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 142 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 9 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
-- 
2.43.0


