Return-Path: <linux-kernel+bounces-79224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC3861F34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EE01C239F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1314CAD8;
	Fri, 23 Feb 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijEGgFni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165431493BB;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724595; cv=none; b=tDhElV/N/bWq9umSHH7K5ZpWMPHGrcCiIAcu3u8FFxrYATn/Vpw8T3yLuWsPBHqZFYXjOVYcqgIxcNhkGqkTLTB26MZqFE3JrTMtEc6KycLLxSJJyjInfmINs1olDZjJgcIhd6AWIfZdrdvMhGl+zm7YcAbySDBBLwYoRN1w2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724595; c=relaxed/simple;
	bh=wxmKrh/Cs57CnGFgC1amvY2Csn44ZKMzdK1MVS66FAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SGgydk0G7jsJVF9Ti9vtjZxPCw+1GilR0IuHXRpcO7rMBDRYtfXd2xiDssuSSI/+gHZbAy8adbenE+0UXZv+LJH6sN9vaL1sqgl0ftmi03Ymea/QzswKByxCQeBKPVhDdomjq5mIjasXRAScOlkDeq7Xd2icYstZ0ABIZyXxN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijEGgFni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B0DFC433C7;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708724594;
	bh=wxmKrh/Cs57CnGFgC1amvY2Csn44ZKMzdK1MVS66FAw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ijEGgFni62LEo/HJ95y5Enpmbq4UqSS0FpUbrRqayiHs8RoDRozNP1Ev69P4DwFnv
	 TQygTodvfadMReqSOzTvfvTmozO9XvIF1DOPABGnZHok9MmXD6CcKq/7Ei9rmLJwV1
	 F6I1PfEaX1V3SqgpazvN4XPMOarSdyOvIl5u+WvRwkNhP/JwdvC8nSBIo9gOE1lBwy
	 lv+SrHQxvIlVkyCLWdlvt61Ck+vXkETY82gZ8fp+4R19LWT6EMOq4K4Z4DS0V/R/J/
	 L4nUAMvHSus1T0o5ubXekWM75KNFav/SQZatqSJqf95PpE9k7ethBIvNIKeuB1Hr/1
	 08a0bx/nZeBqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA66C54798;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/2] usb: dwc3: add glue driver for Hi3798MV200
Date: Sat, 24 Feb 2024 05:43:11 +0800
Message-Id: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG8R2WUC/y3MQQ7CIBCF4as0sxZDp0TQlfcwXQAFO1GLgYqah
 ruL1eX/8vItkFwkl+DQLBBdpkRhqoGbBuyop7NjNNQG5Cg4tpINT9ux3V4qVEYorjXU6z06T6+
 VOfW1R0pziO9Vze13/QMofkBuGWfSe4MOjdayO4bHfA3hsrXhBn0p5QMPbBkDmgAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708724592; l=1171;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=wxmKrh/Cs57CnGFgC1amvY2Csn44ZKMzdK1MVS66FAw=;
 b=/y6KnlSRzutvZJNPU9nmWv2ucnSM2BFbmplrG3GtCQGdIKS/YQ/nnXibiML6lMg3E0yNOw7jS
 u6eecyQOmGID+ddnSVp2f/Vhm9o3fOUgy6hiT3MZdhEKiAeIII3D4uR
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Hi3798MV200 uses DWC3 with a few more clocks and a dedicated reset.

Note xhci-histb.c can also be used. But since it's DWC3 in fact, trying
to support it with the help of DWC3 framework seems a better solution.

Hi3798CV200 can also try to migrate to this driver too. Thus we can
remove xhci-histb.c in the future.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- remove histb-clock.h as it's deprecated.
- fix bot error (Rob Herring)
- add a dummy reg property to make simple-bus parent node happy.
  (duplicate with subnode, not used in driver)
- Link to v1: https://lore.kernel.org/r/20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com

---
Yang Xiwen (2):
      dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
      usb: dwc3: of-simple: Add compatible for hi3798mv200 DWC3 controller

 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 103 +++++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c                  |   1 +
 2 files changed, 104 insertions(+)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240217-dwc3-697828b480aa

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


