Return-Path: <linux-kernel+bounces-78813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62863861933
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E78028719E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBDF130AD0;
	Fri, 23 Feb 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBXx2Oo4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CC823A7;
	Fri, 23 Feb 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708674; cv=none; b=jCTgpCX1903pXOkSosV13W1faQSG1chMqAWi7LoacAMw7wRIoJh9HMNRQVBemhTT44VazyVVE2g2Kch7LZsb8w5o1JvjrUA8oqe1Cu5jZA80PRpxd/bup9MHxftGiIRPXBjxmXIKj39vpQNgp4JRsS8w7aMM7L2tIAVBhRsKaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708674; c=relaxed/simple;
	bh=yAqE4Gklx+CS9b43iJDoKMxjk5QyMnffq2TCExLKUk8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f3TQnXetakyZepdznPonnBabSVR3yo95MKQiN/LDe21T4j2gWXoQxPr2emPFEL/4xGGpN0plzrawDCIbyw9FnQC/ep5OeX2/GR6gayZ8MNgRO0FcvwyAszd7hC9XjPz3mjXKh1e9HIiQLdmd7NaZrCo4cRryHkRfc0WvTWCQb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBXx2Oo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C80F0C433F1;
	Fri, 23 Feb 2024 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708673;
	bh=yAqE4Gklx+CS9b43iJDoKMxjk5QyMnffq2TCExLKUk8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jBXx2Oo4n56X2vPHDy7uduZsqr+3dG5b2SdOH3qW3/pVc++iCm9yEOpHy3jy57lbn
	 U5XqM0LtL4++5SsSXHS4zBx3ApKIOO4Fex+kp8LCyKizJWqcOE2h59QCnVfxmoxsqZ
	 ahPKHYxRVNF335OWKFA3Bg3E8FBnFsjaa+2JjZwxrta3rKrPvOw2mVGQdSSsXg7Y3M
	 1hGzK8xsGsW/jmvm8WZFrSzpHMSw00nw2aHuRzLxhkwAjI8bKnlmwpXnGXwG91DeuP
	 +NXG8zEGVprs0uyBVL+WItjr99bU2yy+uWMeJ303ZoZq25VjCYP4ODED+mLci8TH6Y
	 Ig0YhJ2wuAAUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26C8C54798;
	Fri, 23 Feb 2024 17:17:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/2] usb: dwc3: add glue driver for Hi3798MV200
Date: Sat, 24 Feb 2024 01:17:48 +0800
Message-Id: <20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzT2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Nz3ZTyZGNdM0tzCyOLJBMLg8REJaDSgqLUtMwKsDHRsbW1AOQg0ip
 WAAAA
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708708670; l=874;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=yAqE4Gklx+CS9b43iJDoKMxjk5QyMnffq2TCExLKUk8=;
 b=L/FFhJMRyX2yxgyBw/IzR4EWYcSESiHMGfckFR27oIqWZL2j763k/uZXLFLA/1ei4SiT7MC97
 zT471j/+NPMB2WVcMPCt4PgkUqPBJwdn7DLr52+L3+dadQX+MXT8WZR
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
Yang Xiwen (2):
      dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
      usb: dwc3: of-simple: Add compatible for hi3798mv200 DWC3 controller

 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 100 +++++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c                  |   1 +
 2 files changed, 101 insertions(+)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240217-dwc3-697828b480aa

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


