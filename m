Return-Path: <linux-kernel+bounces-70379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191D8596D5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AB11F214F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9664AAA;
	Sun, 18 Feb 2024 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHoNisqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F16340F;
	Sun, 18 Feb 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257788; cv=none; b=A9H+pMHrZXOFMDr4ANp6Bm5JobL5LBsBmBh6HvU9Npve02xLafvUkdJWyU6Aioz3kfpR9/TmjvqhuKY1RdWV/hMeGA9gYlBiXFHEvR3mJZWpbkzF75lJN5uVY+STenFVvsUCPR4ko9tOWz9IjFvIsrYFOtHvgovcXHuuzrfug8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257788; c=relaxed/simple;
	bh=y/WIW5qNdPD+SYYlidFaKT5euCg8gHN9F20TR9It0Y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ob+Nw4qr3qIe4VpWKlKnqN5VsGzirj38IkvDDf0saQ5jWeewsDg6ZUvL+ggLhqlwpEBzmKWAyvjzodJEAg0F3Msb+ZFe8FqAOuF+W6S2ZAsSFZAz5zbu1NpmLm6f9UKeNOl7av4MdwnZgGq5/d/bvVV/pjtta/pSQaaSAnxpWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHoNisqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D8DC433F1;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708257787;
	bh=y/WIW5qNdPD+SYYlidFaKT5euCg8gHN9F20TR9It0Y4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IHoNisqf+/F0cNor5jSXQrtJQXjzunUp9567BX5Upq5AQ5WdddiNI9GPjfNhoz/1c
	 FNk1DnADCFIeVis0ZpBNQ2UnXj9EF1IXWtWhrbYU4nKoB3FJVftI+1O4o5xL6p6dmj
	 48Hs6DINx2bA3yGOLefz3gTNyvqg9+6YzQ3IE0wV4Htg4OT994OxkJ/YSHi7a2iBzL
	 n8RcvplPNJEVxDngxGqaPXf/sRA+YOFydxbAptZifzYJLJrVCklOCkKOvk0HNnLJLq
	 IPYpTRNCBkX2pqox8WWPb7uw7OIqDQ3jqQJPeUzu9lVQYl9bTdw7BBaoyx0xZpOG+T
	 bFjiFmwH1RAng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA2CC48BF6;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
Date: Sun, 18 Feb 2024 20:02:49 +0800
Message-Id: <20240218-cache-v2-0-1fd919e2bd3e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnx0WUC/13MQQ7CIBCF4as0sxYDEyzElfcwXeA4FaKWBirRN
 Nxd7NLl//LyrZA5Bc5w7FZIXEIOcWqBuw7Iu+nGIlxbA0rUEpUV5MizUIrsZTSHvieE9p0Tj+G
 9OeehtQ95iemzsUX91n+hKCEFknTWaW2QzSm+lkeM9z3FJwy11i/5JAW5nAAAAA==
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708257770; l=1715;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=y/WIW5qNdPD+SYYlidFaKT5euCg8gHN9F20TR9It0Y4=;
 b=MaCi7riRn97ZX+LWscA01GTgPBnN1DBFlMZ5vlzWXAPis+uMoVXi78fazwJp8jeT1nYohx/Ew
 buTXhOraUuhAJJjWYS5Uo7UbArdaGzmBYZYpnXKr+gJyV1YHkocPJdZ
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

They are tested on a hi3798mv200 board in fact. Though the 2 SoCs are
highly similar and the CPU should be the same. Still, Tested-by are
welcomed.

The patchset fixes some warnings reported by the kernel during boot.

The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
2.2.1 Master Processor.

The cache line size and the set-associative info are from Cortex-A53
Documentation [2]. Dts for other SoCs are also a good reference.

From the doc, we know L1 i-cache is 4-way assoc, L1 d-cache is 2-way
assoc and L2 cache is 16-way assoc. Fill the dts props accordingly.

Also, to use KVM's VGIC code, we need to add GICH, GICV and maintenance
IRQ to the dts. They are added with verification.

Dear maintainers, maybe consider Cc to stable too?

[1]: https://github.com/96boards/documentation/blob/master/enterprise/poplar/hardware-docs/Processor_Datasheet_v2XX.pdf
[2]: https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- arm64: dts: hi3798cv200: add GICH, GICV register spces and
  maintainance IRQ.
- Link to v1: https://lore.kernel.org/r/20240218-cache-v1-0-2c0a8a4472e7@outlook.com

---
Yang Xiwen (3):
      arm64: dts: hi3798cv200: fix the size of GICR
      arm64: dts: hi3798cv200: add GICH, GICV register space and irq
      arm64: dts: hi3798cv200: add cache info

 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240218-cache-11c8bf7566c2

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


