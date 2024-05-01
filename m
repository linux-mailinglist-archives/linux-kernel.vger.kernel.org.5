Return-Path: <linux-kernel+bounces-165321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447CC8B8B43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1521F23466
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBC12E1E4;
	Wed,  1 May 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdNsCGdc"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCD12DDB0;
	Wed,  1 May 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570424; cv=none; b=hBGbWXFD8S4VSaJtUiwRiPbp6AvQ4SujGK9Np716Uu1uMQ6bK8A8nEKN1jnnb2vIA3tGfL8Gz1HS3/aN/vOatuf2s2PHAK5cTvmEvVyiJ/ciNtZNV0OPJ6qGGhU0u+CvG2RxrZ8azV3XDn3y6zAyvg1K6GP6d8k02DtWYmqCs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570424; c=relaxed/simple;
	bh=v1uq+AqyCYjTejfbtW5mvJzoxMflu+kesffuEm3SeEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1qj5FylZj6DFHkwcgNxyKYj48Y5cdDFvySAEch/CNB2DT+5/nuUbWH3dhWAzf1FbhpGbQMNOkiVGtIe5rQ86Ls1HFdcy72MHYr2HxFlwkU+RcoPiD3awqiA+VeaKjuOjQiMbGObhPoQys6lmM0TI4yYw8fPqWJDnKVrV467t+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdNsCGdc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so12082975ad.0;
        Wed, 01 May 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714570422; x=1715175222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIs2EAnwhy7zwu/YLIZtkKABdkCncOCCKCOVBsGpvIA=;
        b=BdNsCGdcqgcqVexGQrbg/DJ+fklwWTfkZL7NTPXycG4Om0c9e8VU9TShvK63b/CZdb
         zMr52VghsyYXzq/rGi9StMvZJBlDGjH8y2cZzaTkYNhfUTTJZLcy/I4xHbi9xnYloO2u
         jBzdyGpF1bILKMwAkJ9GkUFRmGFz93ZH8YI11vDcQjICsO3TQVIzSrkWQmc1Sa05bdZV
         OFtXZeV3wBZisXojvoufn5I6emQc8XQPjMwbDCPFVeVrdDgMoGNa8gQQP68ea6rtKDHL
         YXlPrMaBC2UG4HIVj4hQ4jp+I16hCkzlSaXco57VCJhrNHsFp60afPTnUWKllC5Co4iy
         TAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714570422; x=1715175222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIs2EAnwhy7zwu/YLIZtkKABdkCncOCCKCOVBsGpvIA=;
        b=e6P6n+ZfXrbb45DBw60LzcDw2aBcBlVTxEj77cbgeTa9QKRMRZQ/hjf7aSphSn2oeP
         1WrMP+4gQKleaKAEZtxL2INongZMFSUWuqhyeNeukPD6NpjLg+64qfiiaMoURJrV/Zwk
         1ZU9VrOi4qD4MxneZEgs9MZQLsbrj5I8YT5FIjEFiAGxbF5UjzrMGWqgvjIvJfP2LYCV
         g1sUG1HsEHyTcYyne+wdTF37UUr30WFoDaQODt85SCBE/0ZXtL1vLzyMEMjN2vODv41c
         QwfP7jvgeRCTsOuFnpVjMQuILDawvJ3c17f9jQ26usSEWwpoVjmcQEF6p3uMoxHt1MfH
         2IqA==
X-Forwarded-Encrypted: i=1; AJvYcCXjQ7xX2auAqAljn9jp2eW5sWgLC/jLF/pGGvZH0iAuNFSRiRfc6qJZdH9mMcS+tr+qFlXG5Zc7I+jTO/eNWT2kOWru2rDMU84+dONKaG+9kQ66X2lyulTc6HVZ++nZJVVqjnwL97FC
X-Gm-Message-State: AOJu0Yxx3pp0tuUM0NAjrl20lSuGQgrn0x/y4YbQZj0RFearG7m17jsg
	o4zZHw3FbPyPiXnVRBki2/8ERpYFzAFHbmx821EUUEQvQl6ahFQ=
X-Google-Smtp-Source: AGHT+IGoLzo5WXbR9Dq1fTr1Mlwf77nJ95s7iCo/7aejTpbvHOgX2b3snoBNCMj1rdhtryNIvOLIIg==
X-Received: by 2002:a17:903:191:b0:1e6:7731:80 with SMTP id z17-20020a170903019100b001e677310080mr2959626plg.11.1714570422111;
        Wed, 01 May 2024 06:33:42 -0700 (PDT)
Received: from utkarsh-ROG-Zephyrus-G14-GA401II-GA401II.. ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b001ea963d0d58sm12435926pls.137.2024.05.01.06.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:33:41 -0700 (PDT)
From: Utkarsh Tripathi <utripathi2002@gmail.com>
To: tj@kernel.org,
	jiangshanlai@gmail.com,
	skhan@linuxfoundation.org
Cc: Utkarsh Tripathi <utripathi2002@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Sphinx error fixed for inline literal end-string in include/linux/workqueue.h
Date: Wed,  1 May 2024 19:02:40 +0530
Message-Id: <20240501133240.6003-1-utripathi2002@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed Error in Workqueue Documentation in the kernel-doc comment 
for alloc_workqueue function in include/linux/workqueue.h, 
the error was "Inline literal start-string without end-string" 
which was fixed by removing the inline literal.
Kernel Version - 6.9.0-rc5

Signed-off-by: Utkarsh Tripathi <utripathi2002@gmail.com>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..b4aebd981a23 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -490,7 +490,7 @@ void workqueue_softirq_dead(unsigned int cpu);
  * min_active which is set to min(@max_active, %WQ_DFL_MIN_ACTIVE). This means
  * that the sum of per-node max_active's may be larger than @max_active.
  *
- * For detailed information on %WQ_* flags, please refer to
+ * For detailed information on WQ_* flags, please refer to
  * Documentation/core-api/workqueue.rst.
  *
  * RETURNS:
-- 
2.34.1


