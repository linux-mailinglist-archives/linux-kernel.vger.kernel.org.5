Return-Path: <linux-kernel+bounces-92592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7D872291
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8B828363C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD9127B4A;
	Tue,  5 Mar 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut2PNkBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D01272A2;
	Tue,  5 Mar 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652106; cv=none; b=Japy7pDEgaFsYIDv56HhPSOH0srbsee2j0L/DThO7wAGlv1567/Pob+lfkNZ6v/ZN1rLRdkcp6I+A2KXO+kIgwyswh5vOqhUJWkGBw44ItyaHaeSQ/1pC6feLLEvM4ZX6ilA+pVH4d7dJnNTXRzkfsUscqfCEX4l3SSLen2/b+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652106; c=relaxed/simple;
	bh=H5a6Zjeh7JVn3ZqUuQlhd5EvWGSBzuJ+rvKeiaAiIpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V53XEZ6DX3c/7+JFSOFZbqeMuZGTJ2vX62cjMcF6Rsy0iCOGC08v7qiaKmZsFPKtmonosBPLR1fW83NBf4YH3IHWE/mN5ME6bFxov0s+QyJOqOsvQFOhCBskIZ6fNvF/eOXPbaZpM7VuB27bzeKCl2sEtrkQEfQn/vvjcBdMUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut2PNkBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D501DC433F1;
	Tue,  5 Mar 2024 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709652106;
	bh=H5a6Zjeh7JVn3ZqUuQlhd5EvWGSBzuJ+rvKeiaAiIpI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ut2PNkBkdWERAv+dE4+39HeeJ/DJWbkGASbz6s5E1C3NxIdhVOppjdwDbocccD1wG
	 N3lb0NVWTchEUqKT7zkdd3K4+4+Rhfy9ONZ0tvVzkoYDhD7cmLaM/mdNlW6aui4sz2
	 mRWAYcSS24E4sETlcEupwqbpVhJ5BL+HzQCZfcSFy5rY8Fm1SKxvUiCINT4eMtkg6d
	 9HWdAagR3UcWoxZSe6zuU8trB1xm+Re57w3b031wJNDdUNDL4tXHZtLBGV6/mpVp2I
	 HS9dRs+kHRWTxs7HySQxHohVoLsbKRiFTfQ3dujM+cEByxql5oyMp5x0hzfialr/c7
	 9Znx5Euowlnog==
From: Rob Herring <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: nvidia: Fix 'lge' vendor prefix
Date: Tue,  5 Mar 2024 09:21:31 -0600
Message-ID: <20240305152131.3424326-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documented vendor prefix for LG Electronics is 'lg' not 'lge'. Just
change the example to 'lg' as there doesn't appear to be any dependency
on the existing compatible string.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
index c29d7942915c..241d20f3aad0 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
@@ -64,7 +64,7 @@ examples:
     #include <dt-bindings/clock/tegra30-car.h>
     #include <dt-bindings/soc/tegra-pmc.h>
     sound {
-        compatible = "lge,tegra-audio-max98089-p895",
+        compatible = "lg,tegra-audio-max98089-p895",
                      "nvidia,tegra-audio-max98089";
         nvidia,model = "LG Optimus Vu MAX98089";
 
-- 
2.43.0


