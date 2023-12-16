Return-Path: <linux-kernel+bounces-2329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78709815B23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B09CB23867
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DF31755;
	Sat, 16 Dec 2023 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+xhS1H/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBD1E4B3;
	Sat, 16 Dec 2023 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50be24167efso1896508e87.3;
        Sat, 16 Dec 2023 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702752670; x=1703357470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyyk7PYn5UsLoIP5w0Df/PxhFykyWSZXEGZH2I4+NT4=;
        b=A+xhS1H//GsPHa2H8xWFtam+0QoDACp5NDFtD0kf+LpmnZiYNs+pr5maGSL43ApkXs
         NyeDFBEffbo6uhzgeeoor0+A0SxbR049v13quQbDrfnzPCKwoU14bz8CtXg60hQ8aWUR
         A6+ssMi0d+k5zTseNGYC4Yet2qHTQN8Ve10Dv+bifqCMUK06GBYryvmkqJfFDQz0iUW2
         cLi3tH87BilsCYJb+RWFP10m3czbjgHSyizc4kQ6KxX1AOzUOrhtGBxyfKEakh4lDA8B
         JjYyzRyIZv4cTp3wUqlxINVLkr0/pv4S6BcAvTQk957gIl9vIx8III0B3g6FM32qAiat
         fjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702752670; x=1703357470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lyyk7PYn5UsLoIP5w0Df/PxhFykyWSZXEGZH2I4+NT4=;
        b=tXkFqcr+88fZTASuYFkQ6m6gIems3mcHsYAly16jiY+RMsTWkAh1K4hbp+DKvk8E7i
         xk2Nz0IKcBvxRAF1mdRjPx1oAO4OCSwHPwKfNThhkgDg6iFQcgNgYgThpHYlPfKh2+is
         0eSrx5ZnlHusAO2Saz90zecyMulAeInKvrYVrVHb6fDqhua0vTwFj3O57DtZOV/Ek5h6
         +rqImKZiGXdg0cCZFdzHQyhNsDWNibPgi9VJY+rvlinh9xwec80rhc4Pg3xSqvSK8dLC
         AM36BRY8tVipxu8VOcX6zVsGfOOO14qY8TUULiz8EZWWPFFQ1zIV5UXfT+1Aciyytpw4
         g70Q==
X-Gm-Message-State: AOJu0YxJ0mHXm9BK+c0itxKrDW99MjK3F7EzKGiXsjbW1axDFB8jd7+4
	VXZ+EHzoiDl6IW2+im8Ka2k=
X-Google-Smtp-Source: AGHT+IFBrxIEcx3sGb1otg83XeIUGtYMN52U/6Tdch9rV8eObLZNgz2naAx+nw7gw53JmqbimrgnzA==
X-Received: by 2002:a19:8c14:0:b0:50e:20af:2297 with SMTP id o20-20020a198c14000000b0050e20af2297mr503110lfd.255.1702752670176;
        Sat, 16 Dec 2023 10:51:10 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id y21-20020a196415000000b0050e150ccee2sm838303lfb.267.2023.12.16.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 10:51:09 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] scsi: fix calculation of phy_addr in mvumi_delete_internal_cmd
Date: Sat, 16 Dec 2023 21:50:06 +0300
Message-Id: <20231216185006.19200-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calculation of phy_addr in mvumi_delete_internal_cmd contained an issue
where the expression '(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16)' was used.
This expression was found to be incorrect and useless because it always evaluates
to zero, regardless of the actual value of m_sg->baseaddr_h since it's u32.

This commit resolves the issue by placing the casting inside the brackets, making it
more meaningful: (((dma_addr_t) m_sg->baseaddr_h << 16) << 16)

The corrected expression ensures that phy_addr is calculated correctly and
addresses the previous issue, preventing the unnecessary use of a zero value.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/scsi/mvumi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 0354898d7cac..675ea5dcaa21 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -296,7 +296,7 @@ static void mvumi_delete_internal_cmd(struct mvumi_hba *mhba,
 			sgd_getsz(mhba, m_sg, size);
 
 			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
-				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
+				(((dma_addr_t) m_sg->baseaddr_h << 16) << 16);
 
 			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
 								phy_addr);
-- 
2.34.1


