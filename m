Return-Path: <linux-kernel+bounces-37173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8383AC47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973511F25537
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF71339B5;
	Wed, 24 Jan 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR8EOlg0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EB1339A6;
	Wed, 24 Jan 2024 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106675; cv=none; b=EK8ZXVzVZTfcbPC9ByzYvqETisy88WkuW9uRT4FOsguIz7/hMhKbm9zmRrIKql6FKOs+uFMB8XGkyCLnhBaNWxhavV8ueNDirytNovjdTrglE9DgStre9rJog21f1vFUmcp1IuSgcngCmA5Y81UQEfVIwPag3Mo3g9oNj4vuS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106675; c=relaxed/simple;
	bh=5BJYqYtGWEDnpz7L0bP9ZmxYRgVMCx/wPtXvJ+mTaMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/DW3rEv0jUAZPkxo+znXgxK2kvVisHPX1+Y7LXvYjJl0f3MU6lXg5ubS0TDwJ0mFjz3vh9HpN5Kw6BTnkpS6PgHgpindwyFWw4jLM7ziQ0xP7gImYOOivqKRRKCSci2Ss9PuXulfdP07dyFm4xEg/ZjAlIWbVLbu5YI86rbPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR8EOlg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BD5C433F1;
	Wed, 24 Jan 2024 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106674;
	bh=5BJYqYtGWEDnpz7L0bP9ZmxYRgVMCx/wPtXvJ+mTaMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR8EOlg0HhEQLGcNw0mKBexq+zNPjQg7st5hQUhO5PRYtsymC9gREQg3MNPQxFeq0
	 M3JrPrrt77GqxElANp13ESl/lXCqWWUpJbMv2u5jb24lSWoL6d9NiOOzDqM+OXZ6kJ
	 WdfBJ4EuGvQufhzL1ZumUomteUAxC4H79JHQ1CpcjqG6TvgeRm5m2OD2P7AIKYUSRe
	 xJjb7LybaCYtSefELrd90jiEIhpDFqcAQhWU88mAzZ6BNlH2TOiJFJNnm1mYlTGZba
	 HE7AWLJVc8xPH/y+HKzb4OUmZkbVy8D9/w/ofcLeIl+4KQQtG7ekVD73GZ/nvRDx5N
	 4/QiXvRXf62LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 7/7] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:30:48 -0500
Message-ID: <20240124143057.1284274-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143057.1284274-1-sashal@kernel.org>
References: <20240124143057.1284274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index b8847ae04d93..c5c6608ccc84 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1382,6 +1382,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0


