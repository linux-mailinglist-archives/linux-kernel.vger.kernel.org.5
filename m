Return-Path: <linux-kernel+bounces-155924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A888AF8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCEA282DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44B14388A;
	Tue, 23 Apr 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVXt9rf1"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09D26288
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907955; cv=none; b=MsT4dDrDT7mgkZrJrGsQxzbd0JOPkGHHsEGfpJ7smXLqPXXOQQ6dxLKhatMK02rsQ+J4Hr/eFRlYXk8ews4LFfDo2DddnrbIJfWb32RXkdeeT7qqNor7+C+alFUBp9Zb74y4ovJcA16GWzzxxPWv3TOXttV8mPMA3Zc4H5A5wYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907955; c=relaxed/simple;
	bh=qv8E1gsMpWM5F+eV243zDVTTn4MJOqXdD270Vb9ivYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFXHE7Wu6umuaPuK0BVn3LG8P9w7Cwm+svh0iTjrEZwz3TmMtjuBcr7QAUVh2QPTT7xg+Wx1wBzPaYnDt+P9gSFbTGbGiNgNgaKdUkww6QN5q8lv3X1DDIpgFcT7WWjwuM4ngY2TH/g6D+jgSNI5OGV4x2O1oubSxlXoMGZavQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVXt9rf1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso4906935b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907953; x=1714512753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKWTSVVnluWR7STSuRRgwJ6Rd/eSnjR70lXgePt6SEU=;
        b=gVXt9rf1NYWcm0F+H9LBAxfAUcBbeQIs0Dl4nsq1V/ezUVA7JE3Fkl8iCmKGxBWpaB
         oSwIeHJRmHWRx4fWI2UBF3fru5uOIAfNXVcgsF23KSU5+OLdLI6sPMmvkSc2ALgAPZ9q
         n5yqnLZ9DBZcktHX5oHLdmaewhN/sAba+CfdeuaxuLZHGFMvXgjM7fvErUH5LUs/p8Dh
         c+XHSAF0GaM5Yz2GSJ3oEVDBZJpQyuwLLp9qvf5lFrsY6s4isL2SthDCB/SAfBVtKJC1
         fdoK2xzxdHTuICxqEznG/z3dm0laMwsugq0g2NJbqvVfBfYZMZt/3k7Ou7F33CkaZOXX
         vHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907953; x=1714512753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKWTSVVnluWR7STSuRRgwJ6Rd/eSnjR70lXgePt6SEU=;
        b=mCj+R1O3zJ41kKW1U6uupqr3QXXZGbEKgmG89TxyvgGndAxYbG1X8TLABZaxYgVrLC
         Clag1SyhvtdZuAhqhQocQxY8+p48MiwmRCmm5iTIoyMCfkEV41l48+2eunpo3JhLJXJc
         wSwq62RmyQGeqa/z0G3LwNT7LRZM+LweOOYPrjAtoRADCdNVqwIswJAhVIJ8RHtssH8f
         0f3wyWiri6F+QBQBXV6T9RUKK/CMpeZgBjP2MrGHxdC9tH6h+zaSF9wQFr5gLpyujlcz
         qZMwmUJeo95mdmyn4mQtvFF7Gq07MTHhy0w4AVOUWL82Ib9IHKvhIZvkGNUaetCEjlBn
         yyGw==
X-Forwarded-Encrypted: i=1; AJvYcCWk42W5pLJDk4srXWoGnK7DgEyOZN2aQ5FN890zEacGcwu50kzCOpXJM/Z4yUbXICRt1zGJfeaMcpm9RF6WYiFdcjMhZD6+tBhB1+K9
X-Gm-Message-State: AOJu0YzzNBeCe9/Qf1pcjyqV/a8UKq6OzFWRwQ5XSTotlsfotDCpq3Yd
	yCgp3NLBvFiF57RlYE1HOj66K6ihE1TUBIT5QhfIUlhyyYMe5/+W
X-Google-Smtp-Source: AGHT+IGrpbSit5J2n0PJb2L0MA0usVpInvB9ORrbXoqp3luIDwgWfImPPruwclc8bzba1CRst2wamQ==
X-Received: by 2002:a05:6a00:2442:b0:6ea:d794:ccee with SMTP id d2-20020a056a00244200b006ead794cceemr1003937pfj.17.1713907953467;
        Tue, 23 Apr 2024 14:32:33 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.gigstreem.net ([66.160.179.28])
        by smtp.gmail.com with ESMTPSA id fh9-20020a056a00390900b006ecf1922df7sm10047199pfb.36.2024.04.23.14.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:32:32 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: hpa@zytor.com,
	shenxiaxi26@gmail.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH] Replace of_node_put() with new cleanup feature
Date: Tue, 23 Apr 2024 14:40:06 -0700
Message-Id: <20240423214006.29030-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release and to simplify the error
paths

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
 arch/x86/platform/olpc/olpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc.c b/arch/x86/platform/olpc/olpc.c
index 1d4a00e767ec..66c4d1f888e7 100644
--- a/arch/x86/platform/olpc/olpc.c
+++ b/arch/x86/platform/olpc/olpc.c
@@ -202,7 +202,7 @@ static u32 __init get_board_revision(struct device_node *root)
 
 static bool __init platform_detect(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *root __free(device_node) = of_find_node_by_path("/");
 	bool success;
 
 	if (!root)
@@ -218,7 +218,6 @@ static bool __init platform_detect(void)
 			olpc_platform_info.boardrev >> 4);
 	}
 
-	of_node_put(root);
 	return success;
 }
 
-- 
2.34.1


