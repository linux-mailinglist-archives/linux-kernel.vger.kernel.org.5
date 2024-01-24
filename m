Return-Path: <linux-kernel+bounces-37162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB283AC32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D755E287AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22601130E57;
	Wed, 24 Jan 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABCSMXFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661B130E48;
	Wed, 24 Jan 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106646; cv=none; b=jGkxGvTFtsbCKLILxzCGdcivymQdteWViSZZSwk92dLHcXKvFroW8TE/jRaiHWmD6KoqcEfnxCTU/7XZNNRgNOZeRJ99eV6DZQxMoC04oD78wS0smPZ7pfPLrHCdHZfBtgfn/dHclHXT4TltejascQ6fkxajlJdpyYoPto8q7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106646; c=relaxed/simple;
	bh=urpVKp9VIJiUyPu3EzFvm+IMte+GlV5Rfeown6iMqOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQzLhCJFyBImPir0VwIMS0pTRP7gYdfFNaqeswjTdMNR71+iLR++iYxnlUTSes6p4a5bTu0Y+k2ToPu4bVUWhrDTtU1vm2TuqZ2Z1gTNf+Ue0pBaF0Uz+B9m0XqAKssw2umpuUeUzuxRLwcme8R9r4Yok34nV2JkJ27/IYma7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABCSMXFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7ECC43141;
	Wed, 24 Jan 2024 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106646;
	bh=urpVKp9VIJiUyPu3EzFvm+IMte+GlV5Rfeown6iMqOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABCSMXFtpJTee7MsywhWXfj3yKdsfQO8PqK51awOkythXEKKhjxfhTPUhYVTWH+Qi
	 ZN25NAesx7QO1PbvW5KhRCcuVt/Flsu3qwXrCi7y3MrN34qFtKpLV3l5R0UCRZLUHb
	 ORTLDvnOtQBtcc9hFupeTDGAdGHrlzz3IYKnErcYYQ8ACCMafct4uXhpAq1ffq8wyF
	 RoN1/BEUuQG0g8spBm/FvpHk2bPv8b1UWuhEOZmFVIVLiGzw9x5x0GqSnikvm24Wy7
	 BITNsREIMiv8ulPjjoyrgXRawmMz/Z33oPjRg049MB8mNcjg2m0obappQWLlisRSRR
	 ETyxwdOla4vLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 8/9] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:30:11 -0500
Message-ID: <20240124143024.1284046-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143024.1284046-1-sashal@kernel.org>
References: <20240124143024.1284046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 284d16c456e5d4b143f375b8ccc4038ab3f4ee0f ]

The ti_am335x_tscadc is specific to some TI SoCs, update
the dependencies for those SoCs and compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Link: https://lore.kernel.org/r/20231220155643.445849-1-pbrobinson@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ef550d33af92..1a790e7f6549 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1377,6 +1377,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0


