Return-Path: <linux-kernel+bounces-80052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC92862A30
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F1B281C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F401426F;
	Sun, 25 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyiBkJ9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8012E5D;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862643; cv=none; b=esfq21ImW7XWEFLlhHYt1uNNe9m/JUWOlCQkFCRaISbppRdlVr4q8i6Si6JsmHX13/j3N+lFxXMXgo+h1N79OdLRJaFq9yoTkTlhvbLjSFeTX8Dmp3f/xEinB+rXOemz7xKFjVdGjkyUbcBa98XcwPhx5kqKJLtzoAy+8yEYn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862643; c=relaxed/simple;
	bh=zPcJ2vC3A6HhIVo48qXQTTqMOtfOET2qYf2tQ9lsrYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IRu1O+/lz4g9JoiQ6OvZN7RNIenvgHgz9Je4CXbJz9wtRK5Hwlf5uf1GdN4LRVjlwmxFrh25LjlINzk7vOJKu6iEpsflbOP9cK6YbGbcS3ZYGJeVYLAld8HJywCKXt5OAFfO9Sm26d11cMNDdgXdAPwHz8Q6AY7tXY93rmWS/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyiBkJ9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB42C433F1;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708862643;
	bh=zPcJ2vC3A6HhIVo48qXQTTqMOtfOET2qYf2tQ9lsrYY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RyiBkJ9UMomoycGN8oAtIW8hlI/RFu9MkPMz7e0LzdwMDzdwpLtRi5ia6S97Mlhz7
	 wMMoSsn0tfIC3O/I/TgUKzhjP/qZesZGfxZlg9yzblW0GK+rWmGdbPqft/FhCHt2r4
	 HsDxhfavXrR4sIG5cwZl9eIkKv8v3p+QCw9Og2jQQ/IYUB6qcs/Z/eB6cfeBOuZqNy
	 WESnJFfMyVsX6TXCgYZGinj1JqZrESk1vbXrXd3LPh0uF1VpkM+X73uaGnJw08Lfej
	 f1SDd8GZXGpHrcpGdN+jLlZLn8UKh95CMY9bwTv4nemhRhcrwlo1MAa0uYCwFsSl2v
	 gE5zMBZuaaelg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E3C47DD9;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v4 0/2] usb: dwc3: add glue driver for Hi3798MV200
Date: Sun, 25 Feb 2024 20:03:47 +0800
Message-Id: <20240225-dwc3-v4-0-8c1fd6c6f615@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMs22UC/23MQQ7CIBCF4as0rMXAAIKuvIdxQelgiVpMW1HT9
 O7S6sbY5ZvM9w+kwzZgR3bFQFpMoQuxyUOuCuJq25yQhipvAgwkA65p9XCCbrbagCmlYdaS/Hp
 r0YfnnDkc865D18f2NVcTn67fAMhPIHHKqPa+BITSWi328d5fYjyvXbySKZFgiUFmBqV3lVaaa
 /XPxBITmYESyjtE7Zn5ZeM4vgE6APEuCAEAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708862628; l=1668;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zPcJ2vC3A6HhIVo48qXQTTqMOtfOET2qYf2tQ9lsrYY=;
 b=sjlryJDUd028obFeraj/Zs16TT0AhhjYtAK23/PgjYEVlDO03Ex/s8VCyMAXzJb26y7kuRDiB
 bhkAaOd4SckApV2UcAI3de8VumYuXzlh2cEG0qf88nN38lAIOcx/vAL
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
Changes in v4:
- bindings: example: move ranges after compatible
- remove me from email
- Link to v3: https://lore.kernel.org/r/20240224-dwc3-v3-0-2535fcee7f08@outlook.com

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


