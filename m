Return-Path: <linux-kernel+bounces-95410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF30874D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F199C1C23564
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305B1292DE;
	Thu,  7 Mar 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYBZWY6C"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9995DF09;
	Thu,  7 Mar 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810562; cv=none; b=gXFS93gjTd5TlqnkN9ap7cYtbbR7YbsYa4awWqXuitg5UarxkPa2fFlf685+CRrqn87uNX6tVodn+3QFG6KxEc2IhyFDSkiLllJcZU0WQ51AhMolvnBda1Ebx2iWb/N96nHQDJ/X5Rvc7yAbYfrSq13r7Vb9jVEv6JAURTU2DnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810562; c=relaxed/simple;
	bh=QbBoznELF4RPIIGSlVT8QW/K0ipqkCyskhj6N/Qsj+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W0gt3L0HhAIwlf0Zn6DO4waqTR0XcAsnkBijHq/ZK/h8kov8Q5DpMAip5KGZ2YloBLwkbtRwZ4adnCiY9yfbOiwRe7ULcqVmyi1Y8QxB+iENHHMcXhi8YdBAoygAKQas/KuRevKHcTYbZ6mQA9lHejIKS1d4BTzV/Co0zELSWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYBZWY6C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4131285a72cso2419195e9.2;
        Thu, 07 Mar 2024 03:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709810559; x=1710415359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzug+Af3jxeyGuDs+eE9TEatkps3KOh95GMDpEu1psM=;
        b=HYBZWY6CkGlBkurqKYXC/g5q4apsglzBwpBU/5wNLVlBEHcRoEVD8IlZGZylhhh+ri
         MckiSooRgIFBAjPxim+qICxpPM1Rs3WXkMT2egs0fCztz7Msvu/aCWV68yfOZJbbk3RB
         qWQQhOjEWS21KX6Ws2DskScgYFu3mMmdrhhWCTc47MbKyVcEHCRWDF70+6RXNsYukaq1
         Ye2zIT75mbnLF736mUSLfwPK7hWitTCqFQGwM05XhfK1InXakqL4bi+KrKmuob+egDW8
         UZOno+mc4NFcoWjAMnatU+mkixcGdmpGIiozs7gr4Q7a/n+GyPaQMiRJzgwUW0s2nXcW
         dVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810559; x=1710415359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kzug+Af3jxeyGuDs+eE9TEatkps3KOh95GMDpEu1psM=;
        b=SaNsLTcrG3Un6Q6aVXiZqrgQxu+qarhpcxZcxlR1crDPNJ9vXwTocRwAQOINxpu0fg
         6BjJsp2R9FCSnyZpgDgHBl3Sh7VG9wdkVR4cG/VPRj5T5P92fCAtcOg/t+f7SS03DVVE
         v+x/1sV94nIH4VBRpIj95sc8X1YXlcgheaagkIaIqSYEOrxk9bwrwYo82R+VrdNZA9gJ
         A4TDGN23T2KItJGVerNPbH5BRSKubTBR04ddKwFOgb1Ftc9n1LE6YiA8whN8mJ15ROJq
         gexyTuqaO0ix3LOzzX+xXqN8jhY8um8yGRnsHEST5iGN3Zn3HfdM7eA667nF8tRJHyP3
         ksPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDM06Fm2lbQ2ezow2apETYZVEHS9AE2xeJwgyMeq09Bai3KL/5oW/ebld7TDlY+ZMlqC2rBXqYWMRwkFkid3Mycc49hm3IdSbxkZiYsL1YiG9eqjhkQ980ojUZHhAG3tRg/HBb
X-Gm-Message-State: AOJu0Yy3MTmaJWirotcd958fVawdylzaVSwB4rsD0VxEvK9ScJSeBm/D
	yHM7qI+7WbSXE1RxALmQ8c/FuWJ+dpRfNOZQiS8MWfbxFqvDIU/r
X-Google-Smtp-Source: AGHT+IHP9mjOmo+Y5z7Nt0QwEqGpxU+etrc6rWvzibYekbrqyKDH7cagDUHjeXocMYBUtc3AQAROug==
X-Received: by 2002:a05:600c:4705:b0:412:bfa1:fc0 with SMTP id v5-20020a05600c470500b00412bfa10fc0mr13800295wmo.8.1709810558618;
        Thu, 07 Mar 2024 03:22:38 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b00413079f9065sm2369892wmq.8.2024.03.07.03.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:22:38 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: chelsio: remove unused function calc_tx_descs
Date: Thu,  7 Mar 2024 11:22:37 +0000
Message-Id: <20240307112237.1982789-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The inlined helper function calc_tx_descs is not used and is redundant.
Remove it.

Cleans up clang scan build warning:
drivers/net/ethernet/chelsio/cxgb4/sge.c:814:28: warning: unused
function 'calc_tx_descs' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index b5ff2e1a9975..49d5808b7d11 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -803,20 +803,6 @@ static inline unsigned int calc_tx_flits(const struct sk_buff *skb,
 	return flits;
 }
 
-/**
- *	calc_tx_descs - calculate the number of Tx descriptors for a packet
- *	@skb: the packet
- *	@chip_ver: chip version
- *
- *	Returns the number of Tx descriptors needed for the given Ethernet
- *	packet, including the needed WR and CPL headers.
- */
-static inline unsigned int calc_tx_descs(const struct sk_buff *skb,
-					 unsigned int chip_ver)
-{
-	return flits_to_desc(calc_tx_flits(skb, chip_ver));
-}
-
 /**
  *	cxgb4_write_sgl - populate a scatter/gather list for a packet
  *	@skb: the packet
-- 
2.39.2


