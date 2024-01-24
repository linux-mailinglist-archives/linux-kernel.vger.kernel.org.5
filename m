Return-Path: <linux-kernel+bounces-37180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9A83AC57
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9968028430A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3813541C;
	Wed, 24 Jan 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEw9TvP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE204135403;
	Wed, 24 Jan 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106699; cv=none; b=Y+viVl1XIsODncRyBWrZu5+xMr8Mn4OlS1OF9C6elRQ2trLXtppvSl1J+Cnk4aP0gy9O26pnOWgq75Z1TGo9qlOkDfWCxOgULNatv+mdongYX+mBaQTJkxHE9qcJe5Ne2NDQyI9ES6hCciI9urXJV+OFdi2gBR6sN7XVMrrkYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106699; c=relaxed/simple;
	bh=gZZWfrusIzBn7YqMLfITRoxZWoW21yGZ6L3rEYu5b4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjRnXlV6ueVB09doiVClRbLXQ4iGYCh5QtPkzbZ5Lfwsnw8KnRK0oS9Y9lwRyRgaCWNYsDpjTxnuyrvTFSU7Qpr/Eq8pbd8FeQwJ/dkgbcJc/XNBDyFyGlONa5VCu8+LGLXw6cUoheXwo8DptMp10hVGq6cD7PaCNA8BnhJT4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEw9TvP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139A6C433C7;
	Wed, 24 Jan 2024 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106699;
	bh=gZZWfrusIzBn7YqMLfITRoxZWoW21yGZ6L3rEYu5b4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEw9TvP1bjeAMT4UN3JkaKQ7Wt1VuiGOdT9VNcxFxmgzjUJ669LiGsBHastGhW+uA
	 efl3YneZ8MYlwNXT3RcP7xHuyG91F5ZsbE5+jGV2bgx/CpWCNQ/clsU8OAho3dCZxd
	 HeTQ6hznM7tJwNprXpBEYrXGn23So9XUuVy2nB0wPaCgLq3O2TqaMl+2IUYs3ukxz1
	 c3bOLDROUCkA0d013w1ACJw3WejUKM/mOmYwOzoYQswL72sJcV92/EIPz1bZxW/C8y
	 3o15GMwhhguxX5oy5zeRKZ5Ic6h8DZjSc2qnG7+HizpA3uUrmx1XwqMl+AjCiHCK3w
	 bekyy4b8vy2Nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 6/6] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:31:15 -0500
Message-ID: <20240124143124.1284462-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143124.1284462-1-sashal@kernel.org>
References: <20240124143124.1284462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 43169f25da1f..385db201fe9a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1299,6 +1299,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0


