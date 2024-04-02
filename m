Return-Path: <linux-kernel+bounces-127642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0043A894ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936701F23DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006858ADD;
	Tue,  2 Apr 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMyvl4Ui"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46658AB8;
	Tue,  2 Apr 2024 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050565; cv=none; b=S381+2SuxJIiTvVr1BKRCbOxp57bCs6AS/t7+dWMYICzE/dwgb+Ho1WSUd99jH5M3nWuKwlVQ0bg9PqOo5/e1N0+TnFz5ZR8sam/1m8mx1wl/QlSumLqsz4nr3cyKrpNOJo4yAOUZN/l8VGXvjger3OAiO63Mi5CcHpEkJeUk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050565; c=relaxed/simple;
	bh=oo8LCFs0K6UW8PnwVXkDxkA/M8FXv9GgBghk8p1hx9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e04ditFskueelhWvfBii9TQJ2HeymMi6gHtQ0dMeGDmV/VVuIov0SOZ7ALcz1mtuN0qI1Hg4ue41vL0Zc+jgGDupuNDNExhSNUGCfdaBiCKmifynfMvP0q/nzX9SqSkAb0WPAHNCJzkWo/ofmhhBI2H3d8qUoLT6G7TQaI9goTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMyvl4Ui; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-515d49a6b92so2128416e87.3;
        Tue, 02 Apr 2024 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712050562; x=1712655362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZV/SsIKkEaQCqdYk9TBykFcJ+oJa9wAg2KtGvwPvy8=;
        b=bMyvl4UiLB57bRBmrele6GzPt46oPLgaeMLBK1ZUPv2j+jFsaXPPSvaSexYYkKqdw2
         LV1mkGqFbMxCJuvpFUb60WugSp6XI5bthwt675F+RRu97Xybc+XhlgIuyOwbG8eGA7JU
         fKwjzXjRhMuz71sGqIlP4znQe4ixcF4DSsrf7iRAOrEwVy4sORq7NVmvgshPy+RUgQqR
         mrysmN7z22h15nImgKiSxL+Q+v0mp0vHIM+lVvON1+NOWr0cl2zeQjUuoV6dLYsbBul5
         iQQ6/mVtrYKdXR1AGGHr0aia6FfJsTjR6Db4UgXGXzYqjao5MJMeQ0mJrAZ+9CmaSFvi
         5pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050562; x=1712655362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZV/SsIKkEaQCqdYk9TBykFcJ+oJa9wAg2KtGvwPvy8=;
        b=rKSEttXvIPY4fW2bxHTjmt4usZaI+lJG72MrNTWefZe09l8aWJ29owPiADg5Ww2dQo
         BEwX73hJZpPhw7ZskqJzzy0HLu8ds7bg597XtpFFFG+zBIlIr8l9LMA6AKJblFc7PKJ5
         PGllgMUK8jebuFYMT5nvU2PmhHGJWIREmStcL7ixpywVSPRNVWYk3Hm9TfpM5z2k7Qvb
         AXyUNI/Ux4BxPG72+IjW48T5fLKQH2WEIoMKZ2tGDKKoINhMgwcre1WzLiPE6aQKenXq
         X0apyQgJK3FliT03PffHcDxn2Bk4l2ma0OeNk4zAx/2G8Z27JO/Cwd1tS4QJrLLmp64Q
         bSTA==
X-Forwarded-Encrypted: i=1; AJvYcCVMQ6Xgplo7bYw9KOc+QX2m6K9Gbz1yjqXy+emnGNSsOCNFY4slQsBojassM+LjhcCBIT4oymBlMY0iYefluj9LL89ZurCULPucRvLsXCsmZJ5XgypENyNMnI80+xeNPxCcqtxtHJU1
X-Gm-Message-State: AOJu0YzWxamNhxjkfr+6dJWm8khR9jbmmrxQUzbyZuWk0iqrtAxJ5ABQ
	8wPjsMpfmsQv7AS1mWzGRcHBzE4kutBVu8Sc9kQxT5k/fAB6BHVG
X-Google-Smtp-Source: AGHT+IHnOCdQzRsIXq6lSasShgW4dSeETqZam+8LeKGX0mbaLMyqUsarhFySo1aiBOtxxwSvwYzurA==
X-Received: by 2002:a05:6512:3ba8:b0:515:9652:7f76 with SMTP id g40-20020a0565123ba800b0051596527f76mr9928132lfv.1.1712050561644;
        Tue, 02 Apr 2024 02:36:01 -0700 (PDT)
Received: from user-PC.. ([193.176.212.206])
        by smtp.gmail.com with ESMTPSA id d25-20020a196b19000000b005131544fc6fsm1641379lfa.291.2024.04.02.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:36:01 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
	Drew Fustini <drew@pdp7.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop count to 128
Date: Tue,  2 Apr 2024 12:35:39 +0300
Message-Id: <20240402093539.184287-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix SD card tuning error by increasing tuning loop count
from 40(MAX_TUNING_LOOP) to 128.

For some reason the tuning algorithm requires to move through all the taps
of delay line even if the THRESHOLD_MODE (bit 2 in AT_CTRL_R) is used
instead of the LARGEST_WIN_MODE.

Tested-by: Drew Fustini <drew@pdp7.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
Previous discussion was here:
https://lore.kernel.org/lkml/CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com/

 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8d6cfb648096..1001b6ea1a89 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 	/* perform tuning */
 	sdhci_start_tuning(host);
+	host->tuning_loop_count = 128;
 	host->tuning_err = __sdhci_execute_tuning(host, opcode);
 	if (host->tuning_err) {
 		/* disable auto-tuning upon tuning error */
-- 
2.40.1


