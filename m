Return-Path: <linux-kernel+bounces-110112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E0885A27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93A62829B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EB84FAB;
	Thu, 21 Mar 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFTLqnz9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03383CBD;
	Thu, 21 Mar 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029262; cv=none; b=WwwUx+TdanK/3i/L2lEnLnpS349PNtvT1Jc+4Y7V5GGNbFhlNqNLj4T6Y0H02JEbXMXnFUmbtB7+6VS6xbj09dsAVFo2c9/iob2p/w9HE2Rdju99fBs6LEKmHo8yARN2Ih3eb01Z8cIgo/q5vLhCe7woP9y7mUb1mEGMnEEfstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029262; c=relaxed/simple;
	bh=yBIC1I5/CGJewUczVdGzE+xSoggq/bg+8ZYTCA2HupY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oYPpgf5csHtJGob3qn+gacrNs3De+SGGVZyPmuL+lzruDahErjHiyBXvGkNAIP5i3sCIyS2urXI6AWW8V3pl1GfnBNVdN14cxCFSDyzL6C6Wqk5fG3xTIMoTr5BwC+/Dc+AEMKO1NEtgMIUf0z7kxbSlxnhT//A/R3CQccssAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFTLqnz9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so1226701a12.3;
        Thu, 21 Mar 2024 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711029259; x=1711634059; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RISJ51b+qHtZnF1GQnWK2y8jYm5bTJzD2sPnVFGaQwU=;
        b=LFTLqnz9EaNZJoo/YNlY5h1CatuCgZPB/HhPAGUFVinx9P+T0oD3coaquwyAfsrp0D
         GO0+IdzQ2HvfyZ5rfvyvj0ItQVfU2uPxJFDBsfmGAMD3dyQ0CR0m4qQqT1o1HyVfyzas
         FwvgWmLH7VZU+dQ5J/RSiKYlqoOd+zr2ifQ2lK32ImBUpf/myZd0j4qA0cgyI66B5ScV
         UGLXUTZ+FHSQsV47Xgzd+zQ3YfftAC/8Mcy3OqbD41nzBaaiGktja2lRGXRTI7vGHPPQ
         uyjPoKuq/4iCbI7c0W0mCVmBoh9zHhrF60lh4Y+04qmQzlIeVN+TQzCeeBVv54RRI5lz
         91gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711029259; x=1711634059;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RISJ51b+qHtZnF1GQnWK2y8jYm5bTJzD2sPnVFGaQwU=;
        b=ilhnGsXCZ1pAmv2SmNhL+2hurEOCbHYpyBzNHSDwJanZme5AzsB9Tn3O/gCv3EfjND
         9/roAh1wBGJt54k/aNQE3EpPWtYMzODkOl4P8jIzyhvBq2upBrKedfRUVmKpRoFJlubF
         YPSv821QBe7r5xI7fZOBsEUiF/VX/+NDzgD3w1Tt5qwYqMn+0l4wtsmfcAM8oHKyh24T
         ad8ifbvcw1RhGq6cJl7eskoCo4RGHxJe4MrJ6RecsyuQL4fitwBiBUXiWueGeD/o9+Pn
         189tAiAYJDDKD8+JlrytZHRJlleazAfOQVoMovq4XcM/mXuz6RPHl+Y9xKY2lsNwIV+O
         mApA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNzIjkRYBFnCXr8neZ3h2JotdaRuyGQCVDQG3inPXbsv1slvXVtg749lDBVUC+98yfUoptxOmzsEEa7vCJLtwfMw0focuOQTH83/U
X-Gm-Message-State: AOJu0YxAiAK5l6i6j8mD0L1VufqQfFrcMZTKNZhYIOSNnFhOEXGeLyoN
	16/dTZQbRzkANGI6HXzHxdMe2h6WHExj7jI2UGQXcfSDYW5vLc7P
X-Google-Smtp-Source: AGHT+IGadgowPlBXY8+3yucdMCmheOCbVFSzXp6SgBTcViNNF5D6JaD0RNL1gKemJKrXc0/SJj8hbA==
X-Received: by 2002:a50:c011:0:b0:567:3ed0:47ec with SMTP id r17-20020a50c011000000b005673ed047ecmr1405423edb.23.1711029258435;
        Thu, 21 Mar 2024 06:54:18 -0700 (PDT)
Received: from [127.0.1.1] ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id cb4-20020a0564020b6400b005663b0d7243sm8130749edb.83.2024.03.21.06.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 06:54:17 -0700 (PDT)
From: Mikhail Malyshev <mike.malyshev@gmail.com>
Date: Thu, 21 Mar 2024 13:54:15 +0000
Subject: [PATCH] net: stmmac: Do not enable/disable runtime PM for PCI
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-stmmac-fix-v1-1-3aef470494c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAY8/GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyND3eKS3NzEZN20zArdNFMDsxRTIwsLoxQjJaCGgqJUoDDYsOjY2lo
 A6gFopFwAAAA=
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mikhail Malyshev <mike.malyshev@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711029257; l=1598;
 i=mike.malyshev@gmail.com; s=20240321; h=from:subject:message-id;
 bh=yBIC1I5/CGJewUczVdGzE+xSoggq/bg+8ZYTCA2HupY=;
 b=NSMFpt+cRP1D2Zcz2GidQr5P61iTF4xy8bTCVVY7Ik9xa6MmzN2Jv5ofNejppMhHLNJEiTVvy
 uCDtXvBXHWvAkOkLQu70oxopzpwhZnTouzFZWRD8RpCfjH7H+sDM69Z
X-Developer-Key: i=mike.malyshev@gmail.com; a=ed25519;
 pk=dEab2IpWMPzEiv9/nKbxaOgLTBJJfCpKN4FJcNIQk5k=

Common function stmmac_dvr_probe is called for both PCI and non-PCI
device. For PCI devices pm_runtime_enable/disable are called by framework
and should not be called by the driver.

For PCI devices plat->pdev != NULL. Use this fact to detect PCI devices

Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24cd80490d19..db45d8dbc1eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7743,7 +7743,9 @@ int stmmac_dvr_probe(struct device *device,
 
 	pm_runtime_get_noresume(device);
 	pm_runtime_set_active(device);
-	if (!pm_runtime_enabled(device))
+
+	/* For PCI devices PM is disabled/enabled by the framework */
+	if (!priv->plat->pdev)
 		pm_runtime_enable(device);
 
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
@@ -7846,7 +7848,10 @@ void stmmac_dvr_remove(struct device *dev)
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
-	pm_runtime_disable(dev);
+	/* For PCI devices PM is disabled/enabled by the framework */
+	if (!priv->plat->pdev)
+		pm_runtime_disable(dev);
+
 	pm_runtime_put_noidle(dev);
 }
 EXPORT_SYMBOL_GPL(stmmac_dvr_remove);

---
base-commit: 23956900041d968f9ad0f30db6dede4daccd7aa9
change-id: 20240321-stmmac-fix-f506d52882d2

Best regards,
-- 
Mikhail Malyshev <mike.malyshev@gmail.com>


