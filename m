Return-Path: <linux-kernel+bounces-115193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B101C888DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65703296452
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541B30B49E;
	Mon, 25 Mar 2024 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsP/CEda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7C18411E;
	Sun, 24 Mar 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324263; cv=none; b=oPmuQkGFe1cLqrwI8HI0OtPf/RYmx8Xt/inHzisBifOPIGo5MU7hA+fv3pgJglTsbmomeiVCnM+xIabmFHseTrSrXI1IowZNFXk27l16/iRABP0nqv7plC8h4Vv7z+sloUjoZD4So/+pwLNEfqDtXnRYr+LJulGG0JsUukU3gM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324263; c=relaxed/simple;
	bh=9wwExgAB4sB/tBUpT+ZhNtlqdGcbolB8jF8LTbKf1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soWqe8UZxltqo4B7Ajn/NvMjBjPJOvZjN5yG5hwjHgKPIqg7qDTwqCMyCpguyugwIvwQ+bHvOZo58Z1MDhU3VBA7w/44pbiPF9KYCkpvSzXBY+eoTu0Z6M/RzILRz37LMd2nbB8Vi5LF7wPEW+gO6E9jn6i3Y2wQjKQuXkMFSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsP/CEda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC53C433C7;
	Sun, 24 Mar 2024 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324262;
	bh=9wwExgAB4sB/tBUpT+ZhNtlqdGcbolB8jF8LTbKf1yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsP/CEdasFcakEVxb4HKdpWdMLdvYRHESFHF+uA10W8pcgepUUWM3NBAD/TVtpK9J
	 buix/SUBFVOVyinKJPLhv39Nhfd3/qhOgwgmC8Rl5S6AZZX7COLEnxm5gX6W++KwPT
	 GmiRhsComdgRNHE+De7a/OGbiN728mhTjrNl6YvjpxvRsSZs9tbLe6FGZRsVbPds0T
	 TEUfxhG+2tj50JjB/tuV/7dQUizf9KqzSFvfTTjCH1di46y2QiEsrCznK4uioZwQEK
	 Z5EE781sIg7I3n56gt8C0ZuP64lbLArA6Caua7NkMwG64KoHiFdl+ZYPK4+WIld+3N
	 7xRpdMGaGWNBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/148] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:48:26 -0400
Message-ID: <20240324235012.1356413-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 4acd21a45c1446277e2abaece97d7fa7c2e692a9 ]

Update the architecture dependency to be the generic Tegra
because the driver works on the four latest Tegra generations
not just Tegra210, if you build a kernel with a specific
ARCH_TEGRA_xxx_SOC option that excludes Tegra210 you don't get
this driver.

Fixes: 46a88534afb59 ("bus: Add support for Tegra ACONNECT")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc294..02ef3399bf810 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -126,12 +126,13 @@ config SUNXI_RSB
 
 config TEGRA_ACONNECT
 	tristate "Tegra ACONNECT Bus Driver"
-	depends on ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA
 	depends on OF && PM
 	select PM_CLK
 	help
 	  Driver for the Tegra ACONNECT bus which is used to interface with
-	  the devices inside the Audio Processing Engine (APE) for Tegra210.
+	  the devices inside the Audio Processing Engine (APE) for
+	  Tegra210 and later.
 
 config TEGRA_GMI
 	tristate "Tegra Generic Memory Interface bus driver"
-- 
2.43.0


