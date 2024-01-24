Return-Path: <linux-kernel+bounces-37185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906D83AC61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFF1F22899
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D96136678;
	Wed, 24 Jan 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IanqeSEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995E13666A;
	Wed, 24 Jan 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106724; cv=none; b=hZtG48PCHtDCHkdGCqoSM2wftdg58FvKY2JnyJQ3S57qltjSiBc6LNnE1hdiL/Sh1mB/T34pUQy82VfMutq1tryqZUwUrNNQm24q9D/dnvj9t4iBNeqTVvvUF1FTnoD40mLlt9y25daIaUmBgzmdPxbwggFP5aP4rVcdHxb/jzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106724; c=relaxed/simple;
	bh=5GUj9lY5aIF+2nq3uSOugqqu4at6clPIk9i1zaZs4Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh4gJhkmTBAJpVTo7wAvvonC3FDcoXPXUugpUBxfbdFRSJ7kS6dVXbThi81nOhi1EGMM14gfYYMzqgdEjKAAVeH5LDFZuesTKmYsTaGKvB2RU6h4AKXAs7yqeZOVdtF453ZAZgTQ5oZjSljA1FNaRwywMN/dEQPJMA1iZeUye7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IanqeSEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F6DC433C7;
	Wed, 24 Jan 2024 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106724;
	bh=5GUj9lY5aIF+2nq3uSOugqqu4at6clPIk9i1zaZs4Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IanqeSEz5tG/rGnktSbpk1ISULmnFXWIxPjpeZlM9Q7N4hFJWhl2+heFrW9Y7Tx7b
	 kZvaOaYp08CIGJSE/oSfWI0VFHPeutV+ZPjm1uKGabJzWWYJGs0zW10YYnlTLohXfk
	 3pMS83dq8tIk8yPlGQJbKGZOlDZyJ/ICkY3njaEOL6Xd4G0rgjdarHm3X3kQ+7fq+y
	 cFEwhj3SEUDW+TZp8cHehxQmDnMpIbOxaWvFTuZxIflYfZclznW4QZrcMqjO44e0a8
	 EkkXECxHlDVpdJ/e9UXM2rcdLuMMO6KPNnYl4RKZJGbx1KerrPj4OU6+vu01gfQkvP
	 QUas6iT1PzwXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 5/5] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:31:40 -0500
Message-ID: <20240124143149.1284622-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143149.1284622-1-sashal@kernel.org>
References: <20240124143149.1284622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index dd938a5d0409..6b7526669875 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1247,6 +1247,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0


