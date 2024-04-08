Return-Path: <linux-kernel+bounces-135370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D589BF9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167C8B25858
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825A77F1B;
	Mon,  8 Apr 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIdioGhg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE17640D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580912; cv=none; b=sS+UO0SvIwUKD8BvyvvIOJVrXc+K28hGvbVZ7PsgKJ0jKnXX9NnmuSX5I4K9mnHYPV5KiUK/0b9+lZyLiLOJTa5GWgASKCNdOInR3XQGz8hGvpb06GZlvWCJHNKWpGLsogLevQ6VjVlj41ovMzJfIO4GGNz6EsdjmzDmNT889J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580912; c=relaxed/simple;
	bh=zNm3sqMhI/Yp0BpqNAy2dxpqoDl6p4U4ZJ8XBKnytdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JPcGZGfM7sfz/gXGiyxY4Sm38YbAu1zSQOitR4PPUgFgfHyVxi1sdsZ8CvAfAeTb+G3uz4X0krRvo3sa4fq3EYahJSdha8YoYNDMUOUrori2JVIZoiiuI/v4s70SjIZtcFJNaaiJIZxN5aT4AsLF8NP2oNVYXuZO9qGDol2Jp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIdioGhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A32C433C7;
	Mon,  8 Apr 2024 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712580911;
	bh=zNm3sqMhI/Yp0BpqNAy2dxpqoDl6p4U4ZJ8XBKnytdc=;
	h=From:To:Cc:Subject:Date:From;
	b=dIdioGhgVrUrrgN1KmD0C0EgFvzbQsE0bMepTP4Y2bLIZep3qyiiT/7ZuSOolbXij
	 ACQHnU4g9IMYARg3dWS9a3uaqMl9NtFm8tbimcHCidIr3Qln9oycglJLwS0M8qD1O0
	 yBI+ZIKXlujlh/BmW1ze4+eE8q/T7Mz4Agvx4cSMSWQNmcBYpEhJARZM2o5s3qZiK6
	 4yq7KqOdNJlq5FZuVXeTuMYzJB1nHEH6KfS72znGrJVjroLrqyqTqSOB6f7EbtX4XS
	 m2fBaUWYFUTkvBfbpxWGzi4LzXjf4BRVNa0JSLUDJdLVSyLFqchovB4MTy6wqfjhyV
	 Q2T09lJL8WjUQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	William-tw Lin <william-tw.lin@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mtk-socinfo: select CONFIG_SOC_BUS
Date: Mon,  8 Apr 2024 14:55:00 +0200
Message-Id: <20240408125506.1594257-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is needed to avoid a link failure:

ERROR: modpost: "soc_device_register" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
ERROR: modpost: "soc_device_unregister" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!

Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 50c664b65f4d..1b7afb19ccd6 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -72,6 +72,7 @@ config MTK_SOCINFO
 	tristate "MediaTek SoC Information"
 	default y
 	depends on NVMEM_MTK_EFUSE
+	select SOC_BUS
 	help
 	  The MediaTek SoC Information (mtk-socinfo) driver provides
 	  information about the SoC to the userspace including the
-- 
2.39.2


