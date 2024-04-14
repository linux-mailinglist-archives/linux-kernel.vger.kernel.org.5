Return-Path: <linux-kernel+bounces-144290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B128A4436
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3879CB2225C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214B81353FF;
	Sun, 14 Apr 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLlScyLi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A3135418;
	Sun, 14 Apr 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713113843; cv=none; b=hxVFPZTDpV0jBsFaMK6CDDQ+5IlnmRteQ8HGc6oxG7OjnAGLZGRWQgUrNI2jPsfDP9ToILBVhrt/qWhwPYI1G1oSf9u3/BfUnzSStTzqWXoo5mVsizEe9fV/H427yOW+HNCsA0psTY4jzkkyhS5gk1+Vcm93cTZPNwVqJ9J4k+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713113843; c=relaxed/simple;
	bh=0hqHEfGYsuQ38NNJ/X3OjRVhOCpRvM4xvnQ1utdc0Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skm+9zN0j2MYaeeyDSQ5rbwipgG+9cRp7RVZ4id6AjX1PJPhq9qA4yDQUsoYxxCo/bXzu48Ti0+ba74tvozG7W+3DA01L+b6ufnRj8gFFPHZ1TbJcO/Bx1BAv4CBjOsVoPAav+fYs1WGYmAfRplX+TBJ2dGFhuKqa7+3mRz1UNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLlScyLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F7C072AA;
	Sun, 14 Apr 2024 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713113842;
	bh=0hqHEfGYsuQ38NNJ/X3OjRVhOCpRvM4xvnQ1utdc0Rw=;
	h=From:To:Cc:Subject:Date:From;
	b=XLlScyLi2ugsvveQw/Ww2S7XA9IXUcXpm1oTlz12tmB2alf0NGcpGGgOAApEppQCW
	 d/HXs8LCcHkBS66AGZVsbsC/YvzPDE6WpazWvn1O7hbt7KVCXtMLPG/VC3Bi6emK09
	 Xu+S9W9UY54uAK35HbjF1nvHxB4543Y3iNbsIQH1NeOxe2VziN1VaNukYeufFf6661
	 n2cD6GMyMME5Ce6VJ79uewX5rvionRIS5fprI0xHjJHLv3c7j7SSHkgYXDlWnbNfIp
	 ny5LIYuDGoAtekCetqIuTCjCXO5rE+Xs+Aa1jKduRCGbaQuvpA9c+sC4IoYfoaDRyl
	 G4zqc2wMZUsZg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Remove useless "&" of th1520_execute_tuning
Date: Mon, 15 Apr 2024 00:43:57 +0800
Message-ID: <20240414164357.2841-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The preceding "&" before th1520_execute_tuning is useless, remove it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 7b55acd9830c..6206ff7615e8 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -822,7 +822,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
 	.reset			= th1520_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 	.voltage_switch		= dwcmshc_phy_1_8v_init,
-	.platform_execute_tuning = &th1520_execute_tuning,
+	.platform_execute_tuning = th1520_execute_tuning,
 };
 
 static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
-- 
2.43.0


