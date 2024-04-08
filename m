Return-Path: <linux-kernel+bounces-135237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3689BD91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BB1B2332C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77760262;
	Mon,  8 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="gWjvX8kn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1E5FB95
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573578; cv=none; b=pYh2EomCp8syqvc0BMgpoxWLk9bbhAK4fnZCcQpu2nh3g7obLChmqFUBUOsZbkHG2T9jUzpoeXvSiVnajW2TnCQOWOeRzsoBLpxYrE/+CCVooPaYp2GhiC82uHf6dtulnyArC7XCK6x1ye9QDQVC04T5UxfTRnBANaxN9dmJy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573578; c=relaxed/simple;
	bh=aF/W46UoLp2taMYWzXVCLlW68M9W3n2oWkNKNWSuY7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W26fichbpgeApATiTaP18EEilYWTKyEIzMqA3baxoYloIzsGazKKLZurf7CyWQgyIIkU/X/Ljo5YWyoKpUdC3HLmEPngouTkYYlz7245mDPK8eP9s9UZuNHX/nIwlYCYsitNO/cImxTJMSWEKYwUs27rOb61FiBVj8E9/nPlEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=gWjvX8kn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51a7d4466bso316127866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712573573; x=1713178373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+6FLVqqHt8Puy85HABB6phKSAnHTOaWceMatcPamvE=;
        b=gWjvX8knPeP5lAuTtc5pkOU7gKGKBK4a6gsdE+UzCEpIAPbSIGGCuVW+zGGkRbIz4B
         2cHMdu8RdnEXacrIZZCCaK6yHj1fDj4DUNkL78X/TAjVpRo7TRGsLAYVHzXgU7kGjlcZ
         RFcoVKA59Olsh4Czgk9NcqUGGSY8YvaZ4u6WPH6BaVo0NAY1zinpZl1wWqPJi0Z3C0yn
         x75XIvAGsRvLn5sGUIdfghFBnTW23xn2OqhvJ2KQOAH1RgIdLBg/jmGTHTkjJtJwsMB5
         HlegJhSPQFtKdf5Ii3XtmyJAYQGJzyAvBbGfg4a0m67KDyDfCPLWk8VbnSOVTWlA5aOA
         YcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573573; x=1713178373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+6FLVqqHt8Puy85HABB6phKSAnHTOaWceMatcPamvE=;
        b=iie/YcEfFkqRbwa2/PcA3LUzIOtojCfYElV97bZM//b1HgY9kkRF/nU+5YEkVQtGTy
         LgKepTUAnCrZtXGqk7jJjLJXkC8YBprNNpSWffDqDmxWS1ZNVLJBLKptek1NMiyzSrq3
         MZHzjMYF7VEauQ6mo9O9AcQuSSJPfC/UQBz1xxocmnMnRdCr1UzdsKRpvGRZtCrozYRp
         IL2lbBk2F254xUiJDMGXRtg9YQX1J7kVkGkXF5QIfL5igkv4x7dpVnS2q4lvuDqgvuAx
         Wy6WkHpJxWUed1l8kIJWaxJALRbxco9h71bQeqL0uKVoqDlhGMLjvFqRPi1hO2l/ibRb
         8pkw==
X-Forwarded-Encrypted: i=1; AJvYcCVZY/2eHFKg7l3ipE9RLuCWly/hZJ3DYl3yIB9t5V+T4cvBJfo6E2+YfsgW7xVks3CB+cIXykb4Yf7CdZtb0IQKuoFgronVSiM7XYM3
X-Gm-Message-State: AOJu0YzBDiC2MIpE4P8vJGHiyA/Krj7u2ksQNUP+C0UXIVb1b/njr4Dt
	lSGqPvwHd+0i4jcV287/x/nW9GllJXsbAc8hAKDG97E7m9VQNRVciakR1bBIaKY=
X-Google-Smtp-Source: AGHT+IHtnHD0iZGBcOLtZepHusEAfnU6WYK0+W/v7TX2d8AXCJpOSAKOKV0P/Fas9oUdy52dsQXIyg==
X-Received: by 2002:a17:906:c104:b0:a51:aad5:8c62 with SMTP id do4-20020a170906c10400b00a51aad58c62mr6350921ejc.60.1712573573514;
        Mon, 08 Apr 2024 03:52:53 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id gx12-20020a1709068a4c00b00a4e03c28fd5sm4310119ejc.43.2024.04.08.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:52:53 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] s390/smp: Use min() to fix Coccinelle warning
Date: Mon,  8 Apr 2024 12:51:25 +0200
Message-ID: <20240408105124.2162-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for min()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/s390/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0324649aae0a..d69cf2475744 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1205,7 +1205,7 @@ static int __init s390_smp_init(void)
 
 	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "s390/smp:online",
 			       smp_cpu_online, smp_cpu_pre_down);
-	rc = rc <= 0 ? rc : 0;
+	rc = min(rc, 0);
 out:
 	return rc;
 }
-- 
2.44.0


