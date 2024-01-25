Return-Path: <linux-kernel+bounces-38985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BCD83C95D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31636298D01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534DB130E20;
	Thu, 25 Jan 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="JjdW87Kg"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE47316D;
	Thu, 25 Jan 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202003; cv=none; b=IizV8bEBXbnlyOEE16VQyAOZCsCXQzX+mgcA6M4H8AsmQxtHyYTKycK2AEBqTthndiEgBtzv4yarvEMf/8xhooePJR5YhEMlrxeeL3XsSgxYuUaa0Q+u+JGLNxVbUVNPxnXXZe+xM0T7EFPp6gdTC340aOHPAuc9sH8VG08vcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202003; c=relaxed/simple;
	bh=F+/LulHjm3raUIYCTv0pnF3mfBufzUFKnOHJu+49ccU=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=aL4k3R3pfYhRzhdTxqlbPp6eviKktwdea7iS1+vqNLcuSEGOT/nrWI7cnmX2S7bgZxsouYrQBNRTdKIWlPmT5XLla3qhdHx7EbiavpU/+rKZ5LLWVK3fwZHOeUNQsj01iutU9fCAqXw5ZZcxrBW1HXGYiw8dryNFsuF6+VtIWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=JjdW87Kg; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=CSdaTuh6l7rzeJ8o1jT/GzAkO+R5mh0+cv2zUDrUjgw=; b=JjdW87KgOInN5SfonDq7m7xSJG
	3RUQiQ0zrTeK4AarRYXTIDGg1QDjepWwX8R/oENEAc8lvVNPL4Z6sTffBfTSu5pe4ZBceRJRTdh5q
	nhVNRR8NHx2zh9iANHom2s+gZrXZzXRhMUh8daFBVGlHn+ySQ9zD/BkfrVLJBWRejZ6I=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48112 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rT34o-0001qz-Qw; Thu, 25 Jan 2024 11:59:43 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	leoyang.li@nxp.com,
	hvilleneuve@dimonoff.com
Cc: krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com
Date: Thu, 25 Jan 2024 11:59:33 -0500
Message-Id: <20240125165935.886992-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v3 0/2] board: imx8mn-rve-gateway: fix compatible description
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series fixes compatible description for the RVE gateway board.

The board is a prototype developed by my company and we are still at the
prototype stage, so there is zero ABI impact.

Thank you.

Link: [v1] https://lore.kernel.org/all/20240124154422.3600920-1-hugo@hugovil.com/raw
      [v2] https://lore.kernel.org/all/20240124164646.1506814-1-hugo@hugovil.com/raw

Changes for V2:
-Add Fixes tags

Changes for V3:
-Add ABI zero impact comments to commit messages and cover letter

Hugo Villeneuve (2):
  dt-bindings: arm: fsl: remove redundant company name
  arm64: dts: imx8mn-rve-gateway: remove redundant company name

 Documentation/devicetree/bindings/arm/fsl.yaml       | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 6098d87eaf31f48153c984e2adadf14762520a87
-- 
2.39.2


