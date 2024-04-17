Return-Path: <linux-kernel+bounces-148822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F383A8A87CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE701285229
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA211487DF;
	Wed, 17 Apr 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="j4M13Y0U"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F0147C6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368146; cv=none; b=fIyCQIab5FKMbHLHsts7EGc/K8WEw7x/l9ajExEhJWhJgwXPUWGuEtEj3+573tgmFiyUj4Ka7CmMB+UmKL/0VOoQZbZf0Y6IoEzyuByolVmNgBSwB9GcLLb5uQ0ekXsOwdYJE3aBsQBp+iB4shpaVINjtR8lcKY6mQQTfKhKP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368146; c=relaxed/simple;
	bh=pDXnvTYDcnQuVId72ZBjMPQReEig8zoC6BZfnfYFX44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrmxfmuLa4rNXda53sGivakUC87ym0PdmDs+2u3wTV0xb9iPWxYYUBnP3BcTvvI++83dSyHjCoMzaPFL2YXK04ha9gsktgunkSpJpQkMjmyBvmbASg5OqAQcI4xEcuVo0T8/DAn61T8K9Jj74E7kNc6G1cqwgWEHkXTNS4tUL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=j4M13Y0U; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.9.15])
	by Aruba Outgoing Smtp  with ESMTPSA
	id x7JrrIqgbiznzx7JsrXauv; Wed, 17 Apr 2024 17:35:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713368133; bh=pDXnvTYDcnQuVId72ZBjMPQReEig8zoC6BZfnfYFX44=;
	h=From:To:Subject:Date:MIME-Version;
	b=j4M13Y0UKIEQQLubyKuY7puuKS5hkz1FaH5n8h+9l7SuNQhfg4pChcJq90yEApGDD
	 XDop4U73PkpDe4ME5pDK5CSRSy0ZbLEZLAjLxMJqVgDKHuRESnYT+1UOBFPntM+cHh
	 w1eyhRZu9wY51syVCYrVKqDguThcTezleqiAiFRejGci/odAXrDYl2S8hv4TvvEZ4a
	 1u/CHeLbOpNeQZfLZDzfxwm6HQ1ECq4KDJD2xUMQiGLxiw3PJLr0JUi/ALyphMRGdK
	 aimhmEPtjc7/bHV6hASao3wAh/bXtA19C5FjErhSAyqISezzvkr3iM9O8kcFGSUdjM
	 a6ExR0kvICl5A==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>
Subject: [PATCH 0/4] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Wed, 17 Apr 2024 17:35:24 +0200
Message-Id: <20240417153528.7838-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKf54hZLWy+EqOg5Nqgc0goNOHAhokwMzcseEGM/md4Kj+Xk6iBWYxM59JqOzXCKNRty4XULab5exIS2u3izr6RaljxgtYxGjR+musWIS2kHsPo2muOv
 cx3OAN2qTT04yrg1TnQSd/TGRTbIBJ49ikYOuGYSAC668GVbSEiL+A4+F+NF7/UcLRNHt+Ljnq15HKJMUA19RxQpy1tgpl/+zVIFANO0OhDrAfynWBafbNqy
 90LKZbt8HIO9w1KJHfR486IuQhL8t3QtB6A11+64v8UOgzF3MRFf+OnPpipSZSdLmEP2BPimD/TBmqs0wevGvygwAjNPsqPcPSfytRAb1owt02fMSYPS98fV
 dSAYjNwraYX9oQdhmcBjVWistHt5eU+ACMQB+x+o7LTyT6dOKcknOXv81kvwXtuOHcMfr6YbjT7clvO1o7g1HevnAxxsSpavI6pJWA7EE9KfjSpPMMIWXCLN
 6+Y/7DmdNLbtQ5JlGfwfqPigO732gyjIKhEFKgzIG53Gy0hmaaYhTBi4FGAQYneeZCTK8txkrwQJaMeAo/nNmQSrJUs4B8+RuW59dw==

Hello all,

this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
a SoM + Evaluation Board combination from Engicam.

If I'm not wrong the change I propose on patch 2 has been already
queued up in regulator subsystem, anyway I put it here to satisfy
requirements for dt-bindings patch submission (if I don't do that
checkpatch complains about that).

Thanks in advance,

fabio

Fabio Aiuto (4):
  dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
  regulator: dt-bindings: pca9450: add pca9451a support
  arm64: dts: imx93: add Engicam i.Core MX93 SoM
  arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../regulator/nxp,pca9450-regulator.yaml      |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 356 ++++++++++++++++++
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 271 +++++++++++++
 5 files changed, 636 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

-- 
2.34.1


