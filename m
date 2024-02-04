Return-Path: <linux-kernel+bounces-51884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153BF849065
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70E81F2232F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301C28688;
	Sun,  4 Feb 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="V7sOE/Hz"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98A25564
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078936; cv=none; b=HZInv2iSnGjcX+BSKzQ8yOBI0PnZZs5yO6wRi5voxMkCY7nic7VEtho+31aDAJBUcfouj0HwbttV92wzzvBlC5Fs2PTFCOPgdMZlOMIH0t9kebl2kRqJIFtrk0jhFBWy37C3YNio6cqiZCMuWEig0pXG+PDf3LMLvKkPWRTEXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078936; c=relaxed/simple;
	bh=93/OcGm5LMou7TvBpkkSH1fE2zupOQnOqaoy+vvXIKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WpGyGcFgjjfGPGjTlfX1voILk5zlJZJBcukDmn661xgNAQlo8SL7Fros7M0Wrla6veX9zVNUNoJ7DavuEQNqA+QHhb83/09fbX6i3A9O7LwHA6hNPmjqQDwDBtMaxsv/S9pxMJYBeAS6Syr6gfePwv+Ul18zLl9LRRho4LtSGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=V7sOE/Hz reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29080973530so3062083a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707078934; x=1707683734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJCJUyeVN4XZkLSj17IPVdPvP3yfvqYxNTgE8zH2JAo=;
        b=w5rA9CRRY1u0IvHMIt/NrYl6AuCyvwXaKg58OqyMNqYV6Ocp9D9G9cYwipOfdSWD26
         Blyf8qMGIyaJA2rbLLwGH0f3L8KkCyEwQU3YAKhZiZj2aPh+WCR2zbigCY5zxQF9C8vb
         d9sWqa9u3ANJWHiT1BBZwEcouyOPL/t+JUO5W51394Cjfts3wPq9rkTAd7iz17KHTJRz
         XDR5tHcN8ngAJeoLWFCWr+bT8eEA2H9RcR4tU3f5h1TkOcSW0svZOZYJKBvub92RA2JK
         oLrcadK+rKZ+bsJR+JGn+jyWpIMFJraw+7EtZdXSKkLmGkpsYvFb/Ymk++he72LS3AFH
         YXGA==
X-Gm-Message-State: AOJu0Yw+trf/fWIFr1eiPEbI6EWVHFDa4uegD/ah82/D9OnCOodbbf/H
	vqVxmf+vJNblDEQmHfYmTT568LrDDNFEy+UwvHcbIBxxdLHyd4CC
X-Google-Smtp-Source: AGHT+IEfAHinhDVZmF2h66fVJfdgqN5glsjh7C/XOfe2M3z9qeuTvAir/HD0vrJNZBMXRRzqYfmLMA==
X-Received: by 2002:a17:90b:30c3:b0:296:937:6144 with SMTP id hi3-20020a17090b30c300b0029609376144mr8185629pjb.45.1707078933902;
        Sun, 04 Feb 2024 12:35:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWK5szVoUm0zMmg30MDMcexHjISoX336VHs+CGzKWN50y229WjSP6rL1CNI1YWDorv9kvgNJ+j/kElZuf9kbo1o5CmurmqZfMi8lSWcOcFT5I5w7fiG6eREZXHr62QB/Pu2TevhisltUSOMvzo9QiNSLqKzQRlKsGySzP5kS/0sEZE=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090aeb0a00b002964ab6ffa2sm3685956pjz.6.2024.02.04.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:35:33 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707078932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJCJUyeVN4XZkLSj17IPVdPvP3yfvqYxNTgE8zH2JAo=;
	b=V7sOE/Hzw1d7Shzq4x2SVJ6YLOz2wQtVsp7ZD1fcbL8xoSmdgf2zfxh+dXUBuLIRnIM+mc
	zO6Z2OtBjAZ8MUgDo0URrmuMhdpsHBjWkX1BhMTYJRitokOn1abXBS8xrH2bGPbTCq9EPi
	tFi3ABuUesMBVEIRd7HZECtd2Z5WyygYMPW3o/OT7zNjIl2EUv/GFlZ15PiptpL8BETPLN
	RG0sKzEKaucgJChSnH9c1ZAZJ7s/bxV196gcyIRPWfIzLrH7L950xH5I++ccrCGp06U23z
	KCmxVc5xGW9RxMHTNEKU4jJYMRo5tFZiFfTB3fIshlmcNDziHwXYKr+C6oGEBQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:36:03 -0300
Subject: [PATCH] siox: make siox_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-siox-v1-1-2d12583d3a6c@marliere.net>
X-B4-Tracking: v=1; b=H4sIADL1v2UC/x2MQQqAIBAAvyJ7TjCxrL4SEWVrLYSFYgjh35OOA
 zPzQkBPGGBgL3h8KNDlCtQVA3MsbkdOW2GQQiohheJrDLM5cXHx5kVO3Bjbad2sVrQ9lOz2aCn
 9y3HK+QN3uvKEYgAAAA==
To: Thorsten Scherer <t.scherer@eckelmann.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=93/OcGm5LMou7TvBpkkSH1fE2zupOQnOqaoy+vvXIKI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/UyBIFIhDLcn6Xxp+q7mppyYSeZ8/zha0/vR
 nRalKeHPU+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/1MgAKCRDJC4p8Y4ZY
 pktaEAC4MmIbW3QHcEa9IE48qVyDLnUR2XOkLbDAU9nMfMmIJYYV7mjkdCPPW9L5xscTZZvvqyT
 Oxa21OgKMnq6j2/T8hjXCvmcqTFF6EoseqUqnsk3zlwY2mo/Rpb1nRDIjflxcPp0uWINb48cS4C
 mfWASr3KGn9Nz/QK5H1A4U6HR9UIOl4k+F81Bjc6RoFcp1Mm/fXniBB7N2MUdEc6z+TMhX7qinN
 tK9fuk9RDunbYa+v3R9YK3ZDqyNmvUWzPsR0IImON/ATSNirvLtujtgZWOH3BxHSMOJVp6vGjXh
 SBn2G43ad/mjDib0avh5xfgtcjJ29heLpntmW+ac325mEr7rlZnyrhFJlqR1uKvLrrtXyzPo8mD
 27AcXJpnIbbAdz+9fp/Bl2lgY4EOK/tmT/tfp7jT9I1T2hPAnvXDCeMwAOl0EYCMGwcAVohLinD
 fI90InEiPPpzQJxtmttYA5D5J4Mzd2jE/3pnd6v6FkBB+Bxrv8JKGU86a+MsWhQtI711xMC6yCW
 SSSmxhvIPwjKJAbAEYrzbdu1f147T6J5rkleQwl3bwUpF2uQhUGTBBvSNWPfogNq72sOpuLtXDo
 fQTrm6CkMTxV4AItiumcB2MFLgXegOuOy6KeZpz4vqAVAhHFK4W9lagiLlht4uYqLs5YaSJ3pbQ
 8yhMgoszfbKfY7g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the siox_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/siox/siox-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 561408583b2b..a1eda7bd76ed 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -543,7 +543,7 @@ static void siox_shutdown(struct device *dev)
 		sdriver->shutdown(sdevice);
 }
 
-static struct bus_type siox_bus_type = {
+static const struct bus_type siox_bus_type = {
 	.name = "siox",
 	.match = siox_match,
 	.probe = siox_probe,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-siox-ccf8775bf069

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


