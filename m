Return-Path: <linux-kernel+bounces-37278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A137B83ADAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80666B28D43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8AA7CF11;
	Wed, 24 Jan 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="PqmT2AhX"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE47A73A;
	Wed, 24 Jan 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111151; cv=none; b=jvaTSwupRLUpFRUf3pXCAKrROx9Sz6KogFrrHikXjJTX8yNd2sflPFE40sNXTEp27aTbr2UNY+nGHkm4iZQOKQdmguQFbXvCSmcRFbZPMR0t9DU3N6PzMQH6xWpsXBoyaFMNPJ/+C+zvyHMFDdqVWIdXZcSoT94FowwzYNmcoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111151; c=relaxed/simple;
	bh=3w0zJbK0IDPeu/hH2PDT6HPDjBr3kJyNxu0J7fAtHck=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=hAhTQ8XYhklyXXXsf6zlmVqzo/C2ER13S32hBpC+8uz0923yppvwlJ0n6XvG8xNS0fA5xKvQNXBDxBflos18NJsari0j81AD8QXCCS7LsYADMZZHPQfvrRTE3XNFALRjzrS3kb3l1PD3oTX/tZIUaYjgsNnQt8/If1D2SX1zTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=PqmT2AhX; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=+Z54aSLpEvYnpSXkQig7RN53BwEOPHP1mbv5XzUrq1g=; b=PqmT2AhXkzKLSdA8CCNbm5Vu24
	RGHzpWArVrutqMZ02EqM8rewAKWFTmsEpkZuJ8MAi95n3JR4v7m4GTrWLYHCQZBXmgxYvIoPGPW9+
	XXgeNguaOoqllx1yYYhtvAf1BArBm0KbA7WLz0Q7cchBT0Bues9FrqP5heZTpvIBEJaQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46384 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSfRZ-0007N8-A2; Wed, 24 Jan 2024 10:45:37 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	leoyang.li@nxp.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Jan 2024 10:44:19 -0500
Message-Id: <20240124154422.3600920-1-hugo@hugovil.com>
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
Subject: [PATCH 0/2] board: imx8mn-rve-gateway: fix compatible description
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series fixes compatible description for the RVE gateway board.

Thank you.

Hugo Villeneuve (2):
  dt-bindings: arm: fsl: remove redundant company name
  arm64: dts: imx8mn-rve-gateway: remove redundant company name

 Documentation/devicetree/bindings/arm/fsl.yaml       | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
-- 
2.39.2


