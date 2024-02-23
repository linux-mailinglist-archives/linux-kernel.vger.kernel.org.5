Return-Path: <linux-kernel+bounces-78407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D98861313
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB6F1F254CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF17FBC8;
	Fri, 23 Feb 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUKYes58"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48D7EEFF;
	Fri, 23 Feb 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695832; cv=none; b=QhltKRakw7tP6qlx9Ve3jSBPm02nTj/kjHmIqlDWe5UHG20cinuwuxINpfa19oaFkJY0DxmyHP9M5d21prid8D/CIzPilZ6q+RtItG37ea8Ecs4e/m/iH9CFM6RuTsodMgRb4Tp3noPUPDI0vhAoPStsJGmBSG28TmlEZ9mb/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695832; c=relaxed/simple;
	bh=YlAkG1NjLt1BPx3c0QOJwwkn6FnM1Le7rrXcmsU3dqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mEpapHBBEMWRGCn7g/ykZwEIl91g4/rID8+pHIpaLeXcXa/Bg3cjyn6Vx0EWh6a4B8Qm1pZZluI7ItvOcRe5edGweTiwHOXJ/XfSLTX9Fgwsbg2Bb84qMXKF26iA4kx+Jundt3Lsfxy+T3dJnX6YtSe/3oLR3ZMd3E9nzULjLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUKYes58; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412960dbb0eso2752135e9.1;
        Fri, 23 Feb 2024 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708695828; x=1709300628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MU2sVD1dKQkXFBV/2lOKUBvmSJdVDqTPygsANSVveDA=;
        b=hUKYes58bSSt08i4Gs3EcTtqVk+nNC2ZMe4NiahcH2wuD/d8kljarskltOhZt1oqxj
         hfuH1xwosMDSuSLoNnGf0AOVFFQyijk5bI1TlOD+oaS/qxjCLXcf1pwj8bGzRKXu8YE3
         s45h4+TSQVTlfK5CiSbcx8dX2kK2Oc9m1ikoANcA7AsUy5Pt8ZZu4QahqM6y/T0zhqbb
         Eze60WF0aqZrxbstFLXWUyQRXjFZmrRPanLY/TutK9HVY2R2IQGApxrBtgL66x8dETaD
         YK2UKgMM4QF1/l3PnbZ9yFe1HyrgbbSW3HvFKz/az9qn08ho2IYwiQACoOpGl9NCFpCZ
         1f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695828; x=1709300628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MU2sVD1dKQkXFBV/2lOKUBvmSJdVDqTPygsANSVveDA=;
        b=b1An7OVMXw+Q1PsDv4A2UaZ1lqsClfijv3b6S+cnjNR1a5AVW6KxobsLXANJpPoLcz
         g1j34TAL/qdNqRh5NAEKA32V0AkHSsrB544HleUGgu/G7pjWjh7DPIcsp4NVQ132hxO/
         fKXbTGYVQTIVkYt57bKOJDrKPxvW4B7UBiFS9bJ1691i/PZL3LtdWBlyGnTO6YJXHnAf
         nu7KwkcbPTocxRrrxz4CuTsBBPW7RAqgEvNZEqW1IG/6u7WQ88YVLvmeBEhd+gGS0EWj
         y+dP8pcqKvAJsaYxySxJu6+R0ys8SYMjX7CQzvJac69kCA9JYvMp0VWnCj+J4L7dhQPx
         9krg==
X-Forwarded-Encrypted: i=1; AJvYcCWU2qgAuzwwSvLnde40KL6nkKDCJj5ZnE+w3epdlxCNfmGtyLb9spA8J/6VEevvncIOep0bgXdMP20IODu5jzazALXt/eL5wYkrwXYLOld1ae1DljNIFb7L7j9V9O61cqZb1AgN2kaw
X-Gm-Message-State: AOJu0YyZgMvBBPV0eA2qtRKw8gqjtYqZftC2Pg3SAaA+sa7cf1oH0sjF
	BAvGKlK6ZBky7f7+j19yk2ULL9vGOhGduy0BTdfrbhXzfPWNX5pK
X-Google-Smtp-Source: AGHT+IEoOr/wovuVU84wwaIU1tZ3DkQrFObSLZXV9WEeLb+FRbEKQKNr7Px6ERkE1O9z4rS6In43/w==
X-Received: by 2002:a05:600c:3b89:b0:412:94b7:bc2 with SMTP id n9-20020a05600c3b8900b0041294b70bc2mr1322633wms.2.1708695828307;
        Fri, 23 Feb 2024 05:43:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id hi17-20020a05600c535100b0041290251dc2sm2316210wmb.14.2024.02.23.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:43:47 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: clocking-wizard: Remove redundant initialization of pointer div_addr
Date: Fri, 23 Feb 2024 13:43:47 +0000
Message-Id: <20240223134347.3908301-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer div_addr is being assigned a value that is never used, it is
being re-assigned a different value near the end of the function where
it is being read in the next statement. The initialization is redundant
and can be removed.

Cleans up clang scan build warning:
drivers/clk/xilinx/clk-xlnx-clock-wizard.c:501:16: warning: Value stored
to 'div_addr' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 6a6e5d9292e8..19eb3fb7ae31 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -498,7 +498,7 @@ static int clk_wzrd_dynamic_all_nolock(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
 	unsigned long vco_freq, rate_div, clockout0_div;
-	void __iomem *div_addr = divider->base;
+	void __iomem *div_addr;
 	u32 reg, pre, f;
 	int err;
 
-- 
2.39.2


