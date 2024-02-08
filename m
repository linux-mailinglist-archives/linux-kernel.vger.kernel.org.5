Return-Path: <linux-kernel+bounces-58188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC684E286
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB11128A271
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE679DB3;
	Thu,  8 Feb 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFXWuTTv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BF76C72;
	Thu,  8 Feb 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400338; cv=none; b=jtisCfabEpBcUO0H2UWRcrYdFAFzlOL0VILYaVVrawomNEM5t/PdYBZSGA6pV/Bzc7Ff9yqiwuYiBY/Sy8OFpVwfjjC/znfuKVd2Q3HWVzfAo5J3ralow6WJ01/yY+x7VolROeJ6dm46bheyoCFijlV4QzrsqkKY2nyQXaujdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400338; c=relaxed/simple;
	bh=lGGJYZsySgYC16vgMqmEbniij5NPti1Bfv2+TeiXMt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bwQUE7GIhDFvFurnmuUUN5ZfMwC06Ra2BP6CcESr1x+xmMKTp9+cJ8FQ6iuIxil+p1TgtzdDRzqjlBjHPd4Fa5ikTJYP6LMW57JVinwB3OrBBlT2lhPZ7JnK6j4NYm+5I+J+NsKgxAb6wQHGSrbe7SCPcg3u/V6UdqnvyDvcjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFXWuTTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822EFC433C7;
	Thu,  8 Feb 2024 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400337;
	bh=lGGJYZsySgYC16vgMqmEbniij5NPti1Bfv2+TeiXMt8=;
	h=From:Subject:Date:To:Cc:From;
	b=tFXWuTTvDGOqCrZx4IScvaAOJ4bKFMLfNEwbXbJ8ckUauW0ncDg89W1Pbv/rR3SaP
	 zgdul/J8iMWvLUaNpkmvbezZOisHI+j4hcG7LgINk6Ft0MprscjZiPruTdyfCMsWh4
	 ohQcbn21irHF5KlRUhCQWK0A/WWrtLRj2NZivBkdUYhao1MpAGRzgbYIHpkDIRgHHl
	 ZLks89Buscr96V+42lujuv9H+PZVpazKWhNAbodD5aa7YFjJ1U1HgFGXIg3HUC0KnJ
	 j6DvbAxc4DyhKQHULHGcspaljb9XLyR8C193mR3kKQXfQTGYPAEmoj9LAl3+r9CK2v
	 k+gIroAx7jhjw==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: ti: am65x: Add PCIe + USB DT overlay
 files
Date: Thu, 08 Feb 2024 15:51:42 +0200
Message-Id: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7cxGUC/x3MQQrCMBAF0KuUWfthHGuqXqW4SHWiA9rIBIJSe
 ndDl2/zFirqpoUu3UKu1YrluUF2Hd2ecX4o7N5MwtKz8AkpO2rAGfEdjshV/RV/BQLGJGFiicN
 w2Cdqwcc12XfLx+u6/gFuebcWbAAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Nikhil Devshatwar <nikhil.nd@ti.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, srk@ti.com, 
 r-gunasekaran@ti.com, Roger Quadros <rogerq@ti.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=lGGJYZsySgYC16vgMqmEbniij5NPti1Bfv2+TeiXMt8=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlxNyMcnGChkL09R0aX1YCeOOVfQ+iI+jzyBxDD
 M6pbiS3soOJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcTcjAAKCRDSWmvTvnYw
 kw0DEADPHofK1sEZTjyxsQ3wc4dfwP5Fs6GRWcUNqncNYllmWzFeBtRZVf2Qvwnk6FQ17HsNOYz
 xeh70t6Iuag4Os07yxsgQRZjmzYTx14hjK5qdbI1T2qBiwJS0b0SbaNuSJlY/BK9uJtRsugHZ4j
 zzpNotcxMCiBfb2gNCUKb0qJ2xIiHkR/SQGajZ5M8Jcrcb6aIohQm0u0onKyPW7mn2Pycc6zLGY
 jF+BJlLgBITJUMKsaXjjDaKW6jypImwNvpJ987reiarS8ki9I/SvN2yJlC6dRdPD8aDXDR9oSDI
 xxDiHw8RLk/pQhnN77Bm8LAwdlCtZPG2pVLrlt/78nnzjQgmDlhsO8emEzW/WrnE6O3E4bmKJn+
 4/xsapmgLg1V3KHvmcCQRjZBtoLBZsapUHjwqugt6xEZ5cNRceaQO2zeaOs9miCUpYgdJ81hq4l
 y4XkHRPymblpdbJ27wjg+3UtHopkZQfFz6c6TkbZw1kt+8Be4zoBWkJOyF/vIsiNw/wIPpyYzXQ
 RNdvVArSVpkuC0uVebp0YKm7tNM5I3XISSuezlGFM+9ank1coR5RR1cmVgxy5WWWe7nScEP4O2u
 2S0cGBQnNrx4uryxifXJzldODDW5lAeAYGE8Xs82Jkk56n2NBGT6Z9FeV6JHAXmiY7It29wjrWI
 frPlYKLlKf7j8+Q==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

There are 2 types of (PCIe + USB) expansion cards that are provided with
the AM654 board configurations.

1) 2 lane PCIe + USB 2.0 card is supplied with the AM65 IDK
configuration [1]

2) 1 lane PCIe + USB 3.0 card is supplied with the AM65 GP EVM
configuration [2]

Add DT overlay files for both cards.

[1] - https://www.ti.com/lit/ug/spruim6a/spruim6a.pdf
[2] - https://www.ti.com/lit/ug/spruim7/spruim7.pdf

Changelog in each file
v1: https://lore.kernel.org/all/20240126114530.40913-1-rogerq@kernel.org/

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Kishon Vijay Abraham I (1):
      arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personality card

Roger Quadros (2):
      arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
      arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personality card

 arch/arm64/boot/dts/ti/Makefile                |  9 +++-
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso | 59 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso | 61 ++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)
---
base-commit: 1e6bbc5185bcd113c8d2f7aa0a02f588a6bdbe5d
change-id: 20240208-for-v6-9-am65-overlays-2-0-b26b02a7731f

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


