Return-Path: <linux-kernel+bounces-107307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD587FAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F3A1C21753
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A07E563;
	Tue, 19 Mar 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8NiiWkI"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A17E0E5;
	Tue, 19 Mar 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840934; cv=none; b=roiLtkZ+j78ovhhInCH/6WSPXe6WHMccX2raR0K3k7N/53FvXEIi2naJr6OGwe7zzvA8KM438cggVMBG2W04ZgzeXu8q5Vp33+wn7pW5RCQ11roWOfmVGC1SrnYt/EvUeLFL3OLrjKtvUF50XSCZuGGwhTVFf9X2VnsYkVdZ3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840934; c=relaxed/simple;
	bh=B2St2jdTzgdL5ciZ8vjLkpMdfiPTA/dDEh0pYWYDhWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+s1tyGpMTIIzbByrLDE/oX9fRN+DxUGCyE8yFJCk5pZTyk85l1PomJCxIGfdDc99bEuUM9lRu+muRkZ4QaFBC06p3m+boZs+amwGsRPNm+2LEixWt21z8+bmcUVTC9tdznsQ2Z7aRBiIc+dM325pLMYOBnDOzuYJnfL30GPn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8NiiWkI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc29f1956cso31368165ad.0;
        Tue, 19 Mar 2024 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710840932; x=1711445732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e94g+9vzH11aUQZhgMcMoQcXNPU48KmdzBLfG1dsEIk=;
        b=m8NiiWkIy9FQNnpzEhNvUNT4sTDXjRFnx17WYU+/Zz6/c3ZzjkeIjmDDfOARXfDlLG
         6df+ejgLELUpHmvBgjjJVm+XKkNved96FYPdHtD3vgDHTdfqA18ozHlDEiVqR20jvYAU
         ItueJwn2HbbLDv9UiFWBHQ47VplJYvdtkeq+yTyjJcTbOi27ay1Jpuvlb6XD15OAgL5s
         voWiZnHuJWa4DzkxGRn40KrVfpRX6JjtEweYQpQe9Ou7eP6Egevti28xZA0Lm/mgWG1Q
         j5L/0UYG8522v4sE8lxYzQWO8tSUxzN1lcdw08TC0dpvtHKkr2HHeieXEH5hKBu0Q0yI
         zybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840932; x=1711445732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e94g+9vzH11aUQZhgMcMoQcXNPU48KmdzBLfG1dsEIk=;
        b=H0+syFwKuaIFV2BLtCDfe4+I56XQAt8up6OymKyrMtT3HAUI4oTeNLiZUr6tWd7Zhw
         QUbx0cV6+jCYWQfcWDawbzGzkn4TA+5noKTj+KALcyZdYFGbVC5nsDSM6+MnFg2PlXNo
         QY3T7xExFHxQr9rImV8t4tTtgNw4crYGL9CHSbAeDK+2rQ78yP74J8fhXa60jXrOsO4J
         JGEhBhw/PFsn+QQH6MX1CPDAmdqz+Uj1R/poig3ZABp2Pe5LRM3G8rfhIy22ppIEbJFk
         LLB7G+UaIGyehHd8eNnmmmgYDVpN+FdbpNrCNbw3W3e5isk3RDeLq8e22rti/AQ25q1/
         sbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXr5aWFxlQzbhhlM6ei0oMflMcjRoAgeFr3W7pV1rskTqv9YOPfZDflJqV2W6ri76kBMi+Z3FyUiQtsxhBVNKXeakf7iqgPJZ0K9e6P/5B1luzQ5YZtoe/t/IDBLyt1WoHpTnmIhc9kg==
X-Gm-Message-State: AOJu0Yy2HZOYP3+XgMc9xZ20WeOdYzU/pVvd0kcPJAuN+3SDPUq1omta
	8aMpZ7cNEAyIGCVWTWH+axuUhcjJ7yJ4WX/AFD2jlFTRiDI/h+hrqBdwOH2g00Y=
X-Google-Smtp-Source: AGHT+IGRQerkxhBoo9SgQmB9rahSKXo6Kh9y5bn7m0LW33X3wWAr2V/9ZSigvft5pwucY8WqXpU8Zg==
X-Received: by 2002:a17:902:ea08:b0:1db:55cc:d226 with SMTP id s8-20020a170902ea0800b001db55ccd226mr12398549plg.66.1710840932208;
        Tue, 19 Mar 2024 02:35:32 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.3])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001ddc0bc5934sm10942432plh.249.2024.03.19.02.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:35:31 -0700 (PDT)
From: Manojkiran Eda <manojkiran.eda@gmail.com>
To: patrick.rudolph@9elements.com,
	chiawei_wang@aspeedtech.com,
	ryan_chen@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	manojkiran.eda@gmail.com,
	jk@codeconstruct.com.au,
	openbmc@lists.ozlabs.org
Subject: [PATCH v2 2/4] mtd: Replace module_init with subsys_initcall
Date: Tue, 19 Mar 2024 15:04:03 +0530
Message-Id: <20240319093405.39833-3-manojkiran.eda@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240319093405.39833-1-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While engaged in development on the espi kernel device driver[1],
I noticed that the espi flash driver, utilizing the mtd subsystem,
appears to initialize before the mtdcore subsystem registers the
mtd_class. As a result, although the mtd device for espi is created,
it does not populate within the /sys/class/mtd hierarchy.

Given that mtd serves as a subsystem upon which numerous other drivers
rely for infrastructure, it appears logical to adjust the module_init()
call to an alternative priority initcall, subsys_initcall(), thereby
ensuring that the mtd core subsystem is probed prior to the drivers
utilizing its infrastructure.

Although this adjustment alters the initialization ordering, there
exists a slight risk of uncovering implicit initialization ordering
issues. However, I believe it is preferable to prioritize it reasonably
rather than having module_init() in order to maintain the exact old
ordering.

Link : [1] https://lore.kernel.org/openbmc/20240213-espi_driver-v1-1-92741c812843@gmail.com

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e451b28840d5..cc51c9fb2c1e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2560,7 +2560,7 @@ static void __exit cleanup_mtd(void)
 	idr_destroy(&mtd_idr);
 }
 
-module_init(init_mtd);
+subsys_initcall(init_mtd);
 module_exit(cleanup_mtd);
 
 MODULE_LICENSE("GPL");
-- 
2.40.1


