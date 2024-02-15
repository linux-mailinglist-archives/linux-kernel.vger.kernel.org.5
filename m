Return-Path: <linux-kernel+bounces-66980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94485648E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5785B2B68A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD5130AEF;
	Thu, 15 Feb 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCj4W7Y8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12264130ADC;
	Thu, 15 Feb 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003825; cv=none; b=kieo63uiT0C2PW+jJaQlrnzSR7A+IwL/FTaHY2LYe5bwubbci9CeNBmpuH64Z83d2sDsF1DqyKhRNECyhBRLV/miaw7GU1Fs359pl7WBiB1Tq+Bga94RR7W0Tmd936euXw7Nd/EWvsCCmuh5zspacR7uAALEguQKznPYV2SKjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003825; c=relaxed/simple;
	bh=p+0qP4/2n7COOyx8ru8nVeV5lUukoT2wVONrXg/kkws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kU9GLrR93Um+Gidj/1K/D8FM2Dp7GSwp8Zs4TKxOyGyJPi9FjNdOl6KUYE5hLJAPpMx42enMnixyoeJr6PZztZk/HVfTQUR8Pe4mmeJpy4CaLQxocHTDEfuTn3A8jNkvCfDm1PMxeuVFvycalEb3UbawR1FFAyKMD1plGeeP9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCj4W7Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A139C433F1;
	Thu, 15 Feb 2024 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708003824;
	bh=p+0qP4/2n7COOyx8ru8nVeV5lUukoT2wVONrXg/kkws=;
	h=From:To:Cc:Subject:Date:From;
	b=bCj4W7Y8UPPXgaDjZ4gi9mQGUtdeSWR+5EhXCTTdwjIBkCwmXOnSkt+oiA78XQMMF
	 w/yBiBQYmnMcQYJJsfkgtV/DNdt1l8pASkj3i4AzDy/xw3hgeN7Fnj6EfuLL5olMhD
	 OtYeYLjHeOz6T0j6MH0ht8Ul7Z6tOV9INvclJ+BrBrVAuoUCV6GvCKApP8MMhBLMmb
	 /Dh9908cQpTrlH+g8SdEpk5MlfQR1uAGW7OT69Fx/t6Jb5MRAundprc0DNQNgz7Ujb
	 B+E2reJ+3rz1FTc9FutG3OQzV+FVDkGIOBcKPaT2GfOP6Ci2EkESmLcmN3YcLur8W0
	 +MBPoZ2Px58Dg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-sound@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: remove redundant 'tristate' in sound/soc/codecs/Kconfig
Date: Thu, 15 Feb 2024 22:28:54 +0900
Message-Id: <20240215132854.1907630-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type 'tristate' is already specified three lines above.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 sound/soc/codecs/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 59f9742e9ff4..f7e06ba99570 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2300,7 +2300,6 @@ config SND_SOC_WSA881X
 	tristate "WSA881X Codec"
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
-	tristate
 	help
 	  This enables support for Qualcomm WSA8810/WSA8815 Class-D
 	  Smart Speaker Amplifier.
@@ -2309,7 +2308,6 @@ config SND_SOC_WSA883X
 	tristate "WSA883X Codec"
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
-	tristate
 	help
 	  This enables support for Qualcomm WSA8830/WSA8835 Class-D
 	  Smart Speaker Amplifier.
@@ -2318,7 +2316,6 @@ config SND_SOC_WSA884X
 	tristate "WSA884X Codec"
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
-	tristate
 	help
 	  This enables support for Qualcomm WSA8840/WSA8845/WSA8845H Class-D
 	  Smart Speaker Amplifier.
-- 
2.40.1


