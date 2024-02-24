Return-Path: <linux-kernel+bounces-79626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB88624DD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBFE282048
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F513F8E0;
	Sat, 24 Feb 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G00LVqS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38201B977;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776620; cv=none; b=Wx4Yxkiz0oyzbhJQVyRriK7hr74OvxuxL1cmgGtVtrR4Jm8iuG9EwCTQw/wGXdo5tmrFb3We205IrOU6+uDjyH8CMtc0JK8z7d97RRDyFkSON/nfWF2Zh4wjOg83KoYUOAWUhWfQ4TVkCiNl3FnKPQA8yzoAnG/NGOe74AQWVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776620; c=relaxed/simple;
	bh=wLy4fhXT7uKWi4ko1krpJhqxlUi/4wpBJplpCsyj4Pw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t3pZm+0WK6RXFZZ9iZy1ausDAekBqYY2vY/HS0ubneBEAmW37GolGB3hDsGKqMUcCwF79bDnz4TtBn+1/4Kz4PuLQ3o9YJwp00lhVDMdXph1oKjs5sj3NtyDQYhvECBG3ZPnHTPSA0LJVowXKO5DJbvBRAzjprN6p+EG9Qkm6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G00LVqS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85AEEC433F1;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776619;
	bh=wLy4fhXT7uKWi4ko1krpJhqxlUi/4wpBJplpCsyj4Pw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=G00LVqS3FR/NS73LgOkjWB8s2B6qgbO5qgRTK+wG55sjGWtOHG9m1CtFQieXjkAwp
	 KzJWbBAvS9F8sq7x2O/L5c9uS+LrqTtXAXDhDEjvMl32bLUA+r9hT5X1xaki9Ckle6
	 y3lAUCPCrTQl7jQgeRAtoCvdiOKOsIYVtJPTEscvGADyqS+JS75TnoQi7c34Fy8pfX
	 liIRHda0ZosKB5U86cjLtdUx+fHh4y+3/aAWQaZ3zXhbIpWSt7NxR2ByjoR78CzSRo
	 Evur6V7iJREhUhb/CwmvzD7/4b7VH8EmEd0Ek+ndxjL+scvN6NPf4FZfMw4kBvQvMW
	 Xk7ecUVjj5wHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A586C54E49;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/2] usb: dwc3: add glue driver for Hi3798MV200
Date: Sat, 24 Feb 2024 20:10:17 +0800
Message-Id: <20240224-dwc3-v3-0-2535fcee7f08@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnc2WUC/22MQQ7CIBQFr9KwFgO/VNCV9zAuKP1YohYDFTUNd
 5dWNyYu5+XNTCRicBjJrppIwOSi80OBelUR0+vhhNR1hQkwEAy4pN3D1HSzlQpUKxTTmpTrLaB
 1zyVzOBbuXRx9eC3VxOf1GwDxCSROGZXWtoDQai3rvb+PF+/Pa+OvZE4k+KdB0RQKazrZSC6bX
 y3n/AYMHU4B0QAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708776618; l=1490;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=wLy4fhXT7uKWi4ko1krpJhqxlUi/4wpBJplpCsyj4Pw=;
 b=76z/w4AgfyzzSxqjXPJB/F4CFpVUb0GttCQbTToPlTo3FDPmDXwf8UehaAtwn2Q1pq9FTrubu
 ME5knGb4xDDBYSWp8nhrkclCSO6jm3fU+5KeT/fYorLnehplOkLiSRd
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
Changes in v3:
- binding: remove example address
- binding: remove reg (Krzysztof)
- binding: rearrange required (Krzysztof)
- binding: put additionalProperties after required (Krzysztof)
- binding: indent properly (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20240224-dwc3-v2-0-8e4fcd757175@outlook.com

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

 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 99 ++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c                  |  1 +
 2 files changed, 100 insertions(+)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240217-dwc3-697828b480aa

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


