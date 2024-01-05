Return-Path: <linux-kernel+bounces-17660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E428250D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80EA285C72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32425241E7;
	Fri,  5 Jan 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhfTxyQh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7B2374D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso16022111fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704447168; x=1705051968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByzwZGHe2vxw8uFwYxJ78SuaBAL6cggpBYAyl9030dc=;
        b=EhfTxyQh7LxkGuDqQgAN31FHIBLzu3s1ADinOsuKpM67aMdLOq/VQkkHcQ8S3MZoU4
         VXPB1U5YY/4ATh2FJgfj0wDoHWariMyKEiUEQszFG5Vby4npL8NhjhnoBRw11oZPLqS2
         WWiN8UI+5sm2q2M/K5f1slD1hiqS403XQh2baVKmvExHFm0u2Fsfnl4CEMSm6889XlwO
         hDBxCWOKlYRJB2CkDHJ9KlvXG5c3w5AFlk/VHRxKJAiv5BbhX/5lbRaxY6/lm+yNRnbF
         QQYNUeCLIafAEk4YWP+QqK3fvzETN6/eS+sCD2LRRJM6oHqLXK0TZS1R4WZrYv05WO0r
         9H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447168; x=1705051968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByzwZGHe2vxw8uFwYxJ78SuaBAL6cggpBYAyl9030dc=;
        b=rxdtV/fHRMk7ZWrv5mIAWr5II2RDbselADnG1S+ZCgLChHDeyMjxjpWI3eY+ugxCWH
         4O7TZA4YuPU72Bjq1E7R+thXwQb8vHGOBwI7uiWTu2QVdua61+PzmqT9bfJV5K78KHFq
         c6R7XPBKEbnWBSblw69pR911KlvKgzA2HWzhxL+kTEH3ox2CyPkZcsmT0z6IGzpFC1kO
         UXAxMNypRATkAegHzxl+0aEdkwnuupeSEPI5gF1EaeZ3HrckEp96eAWQfXH6BihCLGeX
         epC88TGgMp8Ljy6ZZZ6ZY20CtwRSHF0oKlceIrTMqGVNTHbXY3xjDrWusOTxGzBzRfCS
         Um8A==
X-Gm-Message-State: AOJu0Yz3ROQQchWH5VTIL3vM9YSapxBmLVFJOzYipuoDVTjnO3p33E9q
	irMergAWBmemJdiXu9NaiD4=
X-Google-Smtp-Source: AGHT+IFXft7wZ3/+4JSVA4Zv8xNgK2YCrmv+Iqwmhw2YCnQdDT4+DX7aAPzeLbFmrc/spYOXsyc7YQ==
X-Received: by 2002:a05:651c:547:b0:2cd:15ee:fa8f with SMTP id q7-20020a05651c054700b002cd15eefa8fmr1028470ljp.55.1704447167779;
        Fri, 05 Jan 2024 01:32:47 -0800 (PST)
Received: from localhost.localdomain (ip5f5aba64.dynamic.kabel-deutschland.de. [95.90.186.100])
        by smtp.gmail.com with ESMTPSA id b69-20020a509f4b000000b005557bbb81bfsm774885edf.79.2024.01.05.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:32:47 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: remove return statement from void function
Date: Fri,  5 Jan 2024 10:32:16 +0100
Message-ID: <20240105093216.13981-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove return statement from the void function _rtl92e_if_check_reset().
Found by checkpatch.

WARNING: void function return statements are not generally useful

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 5107d06a9fd0..6450f86c563e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -909,7 +909,6 @@ static void _rtl92e_if_check_reset(struct net_device *dev)
 		netdev_info(dev, "%s(): TxResetType is %d, RxResetType is %d\n",
 			    __func__, TxResetType, RxResetType);
 	}
-	return;
 }
 
 static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
-- 
2.43.0


