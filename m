Return-Path: <linux-kernel+bounces-51549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D846848C62
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B211A1C20D7B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD515AE0;
	Sun,  4 Feb 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqIqYawP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FB16423;
	Sun,  4 Feb 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038077; cv=none; b=C6cuFPlkmsa6FLiHfngnTBpHNW7eYV0BRNAst61pJbDtMcjD2VOM7XT3ARwC6zGe6sS1GzyPC0WfoLLGEFWV7iHv0hc6xWkgayB/R4gEPyDh9yqzIxcS/NG3usOPe5SsWTxBYqYE7972DN5yQ+n8GvaVFrkF7iXeR0blL789ewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038077; c=relaxed/simple;
	bh=tdJoA0gAQ+yEvvOzhSgqgVWMe4V3tFRmkcVSf9FiZeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjd/PBnG8LLhJvGbJRNbG1vXF0itgWw4s7eqi4OMKAR6zK41qxPCygWEVAI3EHp3ImIYAs44NM0EwxOh25cN7LeaDtFRM3wQrRq1l+6auF273v3OgE2OWP5HmReusFVMXDKvDGX9MJ62bvllCnO3C9IrD3DwhlmTu6TYFSNJ3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqIqYawP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F94C433F1;
	Sun,  4 Feb 2024 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707038077;
	bh=tdJoA0gAQ+yEvvOzhSgqgVWMe4V3tFRmkcVSf9FiZeI=;
	h=From:To:Cc:Subject:Date:From;
	b=IqIqYawPB2UqaopXb4BOlBNtLNHNY/WLA+C24JK1AJ2MkQtyrjTrHdQclMFQCj7io
	 q+QFXcytpGrJuKMfqgQQOSSN7b2/PHdFe/pBNLpFbQ8EuGYyeC5R6DWcnxr7m3tQ0U
	 RcyfeWVZTtudxYDLm+T6yaDJoeQxy4kc1rIFtVEizf80deWHtSUpyUyEmU08CgCghl
	 J+ckg6x+5zZ6zACK7zWmNZDYoVFfvayNQJoY2FJmxras1wSUS14gORkxiMJ5GzLf4U
	 T+457NBb7aF9By83MAjJcjEI309sbG3DS3kQ0aeVQTmtVIy2SvXlpX+FxuEkGRuyGY
	 AA3leXz5jeF/w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: pxa: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
Date: Sun,  4 Feb 2024 18:14:24 +0900
Message-Id: <20240204091424.38306-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'config SND_PXA2XX_AC97' is already present in sound/arm/Kconfig with
a prompt.

Commit 734c2d4bb7cf ("[ALSA] ASoC pxa2xx build support") redundantly
added the second one to sound/soc/pxa/Kconfig.

Remove it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Change the commit subject

 sound/soc/pxa/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f03c74809324..e05d6ce4c8fa 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -8,9 +8,6 @@ config SND_PXA2XX_SOC
 	  the PXA2xx AC97, I2S or SSP interface. You will also need
 	  to select the audio interfaces to support below.
 
-config SND_PXA2XX_AC97
-	tristate
-
 config SND_PXA2XX_SOC_AC97
 	tristate "SoC AC97 support for PXA2xx"
 	depends on SND_PXA2XX_SOC
-- 
2.40.1


