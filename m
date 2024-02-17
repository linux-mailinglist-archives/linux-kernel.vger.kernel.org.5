Return-Path: <linux-kernel+bounces-69914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C585902E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C511F214E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0627C6EE;
	Sat, 17 Feb 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdw2mjoa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845B7C6CD;
	Sat, 17 Feb 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181703; cv=none; b=TWTk1dZt4DCDfwXuzZ8qSLEaTZn0xlXPBV08BWUAF6g1itCeg+6xNxN2PjzgBPlpw9fwhWWA1f+Ar4fgpGTSKCDbLqM1hAnNwdPYBDHZDPmgV1mTFbmP5MRCECVYe12+/73rcWFfoGvpEhVm7YtnV1oMYxRPQcUl25KOHpUMkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181703; c=relaxed/simple;
	bh=UJc8Pftdab1S/MgsZW8hxK4dRCrJbQnMNrplUSPk6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7dpWLhGhBzkMh8GxyRI57Oxw0SvOlqvr9B6WuGECApwzrT00YzGPUMmsOJv2Sq3QsjwsL6Pp6rDHmyXlQyDN6zHwTFOBZNzFokcm+DjrzF4EkscnM6FKoFgB+MqSQNuL4AQt3Tk0ElWACD5Ldp+pKdqUnqzmQ7D6UQFGPkCmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdw2mjoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3151C43394;
	Sat, 17 Feb 2024 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708181703;
	bh=UJc8Pftdab1S/MgsZW8hxK4dRCrJbQnMNrplUSPk6L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdw2mjoacpFfvtxW0Xx39lnqAvTuZy4rvCresHMo6Ayvc2p3UG32PNZlVI8nj4gHc
	 4d15vZkCGAsCNgUH98zbLdxvvLo9Ag9GMvlh0hfj0XVXaZg16GjiHzwA8y7dsxrjE1
	 QAevFzx72i1UPZ642yXtrzVA1PkGDp8ws3zfivut6OTf0CEUjVr2atmW1PyIl5KrMD
	 iG/J/iQR0d1L8iiTnVLMmYoFlwnlFzt9BskCK5/ZszT+WtKos6CRu11byEU5c7L5wb
	 RMBZJaZ59c94/gNxWgZLCLQ7zC8Of0VI4ean/Yymtr/qADlKHnUwbu9r+kkXYUylbn
	 KKtDoNu2cmxzw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo CV1800B and SG2002 support
Date: Sat, 17 Feb 2024 22:42:01 +0800
Message-ID: <20240217144202.3808-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217144202.3808-1-jszhang@kernel.org>
References: <20240217144202.3808-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible value for the dwcmshc controller in Sophgo's CV1800B and
SG2002.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 42804d955293..4d3031d9965f 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,8 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - sophgo,cv1800b-dwcmshc
+      - sophgo,sg2002-dwcmshc
       - thead,th1520-dwcmshc
 
   reg:
-- 
2.43.0


