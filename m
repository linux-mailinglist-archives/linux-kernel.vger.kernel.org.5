Return-Path: <linux-kernel+bounces-69891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4E858FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1401F220D6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E27B3F9;
	Sat, 17 Feb 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prdu52zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1107A716;
	Sat, 17 Feb 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178572; cv=none; b=G7OignI4wyMfHVzkERFpEEB07oUuGsVMvvX/B/Tj7uf8Pf1/wiYnYZO6mvOEf73pv9zgkIgfyzgYp4T8H5dWQwSjnQCgahx1sXS4WProPRaShsIp+vNbXbx0dGA4vnmRIdMOYlLDpq4VH10YBVPnngSgXRVvb7OYl+Ne09Egcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178572; c=relaxed/simple;
	bh=HB/UpB50BILuiF8CCfmMOQJkOn4bkGggnUNO1Au7/nE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EiQCs0WjyvkzLzyZK4Lzl8Q9JJ0ZPHwKTP0h1mNK6JY7OxCAAuyq+AqIyFr7SvQktR4uLRAVrB2Y+PLMXWf4pT69Jj8iiB921ItS5DVfYJIGZXB+hN0SxutB3NFzT7suijK8jFv8JrzX+/hAGfVv4amnZWoipZK2nk3c7o/Si0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prdu52zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D570DC433C7;
	Sat, 17 Feb 2024 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708178571;
	bh=HB/UpB50BILuiF8CCfmMOQJkOn4bkGggnUNO1Au7/nE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Prdu52zqYBAbheYenbmHAmkvNyf3gxxsgDI4gPL1iwJz0eqqICn6UhzcszE96p5jq
	 5opzJ03909QPtY3otj7mjvoJTNkqMzajh6d8N8kJY0MObDCWpS49BR+ZuZoeOohSLk
	 EGIW2zXlCR/XrQbfkdU3t6pxE8biBnslTU8Ewcn0bfnNc42z0xlAA3/S68hzeq43Tf
	 XsNJCp/cWfztxd7uQyApyioePF43u8IojjzSfI7P/iZSAbDKfbQxNzjI8AX4Vl82oe
	 mp9r2ve00uWeAGpy/SNegoxCmL0EZOCv7ruoO5yDdtKt9xRM6Q8g304DMgaOl1XvqQ
	 YbesphRRlgY7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C9DC48BC3;
	Sat, 17 Feb 2024 14:02:51 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC v2 0/4] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Date: Sat, 17 Feb 2024 22:02:44 +0800
Message-Id: <20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIS80GUC/2WMQQ6CMBBFr0JmbU07IKgrExMP4NawaKGVCdohL
 RIJ4e42bF2+/1/eAtEGshHO2QLBThSJfQLcZdB02j+toDYxoMRCoioFec9i6GahsT1W6EpTFQa
 SPgTr6LulHnC/XaFOY0dx5DBv+Ult139pUkIKpc1JoZOHPHcX/owv5n7f8BvqdV1/XYibgKcAA
 AA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708178566; l=1863;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=HB/UpB50BILuiF8CCfmMOQJkOn4bkGggnUNO1Au7/nE=;
 b=9VtvWJ4V8m6j4mczC2xd3BTH2B4ji+ttMI83t6mBEq3+QIfY/Z3xZyGrhV1q081YTkor8OFur
 RHlXOYnBjoGAmx9h+rnXOm3h7dPDjMMla2G0IUHmN9F61Y4Fb5cJIGK
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This should be considered a dirty hack. The proper solution would be
extracting write_reg logic to a separate regmap driver. Leaving only
"write BIT(2) to address 0x6" to the PHY driver.

The initial commit is already doing things wrong. The following patches
adding hi3798mv100 support is also very confusing. The name of the
enumeration "PHY_TYPE_x" is very misleading as if it's the phy which is
different across SoCs. But actually it's the bus (i.e. how to write to a
given address) which is different, not the PHY.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- rewrite commit msg to show why hisilicon,hi3798mv100-usb2-phy is added
  during YAML convertion.
- split required: to multiple line
- add allOf to wrap if:
- remove perictrl wrapper and the second phy in the example
- tested the binding both for mv200 and cv200 dts. fix some silly
  errors.
Above all are suggested by Krzysztof
- use reset_control_array_* APIs to ensure all resets are controlled
- Link to v1: https://lore.kernel.org/r/20240216-inno-phy-v1-0-1ab912f0533f@outlook.com

---
Yang Xiwen (4):
      dt-bindings: phy: hisi-inno-usb2: convert to YAML
      phy: hisilicon: hisi-inno-phy: enable clocks for every ports
      phy: hisilicon: hisi-inno-phy: add support for Hi3798MV200 INNO PHY
      dt-bindings: phy: hisi-inno-usb2: add compatible of hisilicon,hi3798mv200-usb2-phy

 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 123 +++++++++++++++++++++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 ------------
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |  69 +++++++-----
 3 files changed, 165 insertions(+), 98 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-inno-phy-a2d872f6b74b

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


