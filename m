Return-Path: <linux-kernel+bounces-70535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D869D8598EF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688CAB20F79
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9F74E22;
	Sun, 18 Feb 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKpsh04U"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE79745F6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283097; cv=none; b=a5lDq5T1OHf0KrnfLn/A0Nr83KYf6uCIQgJVcyRA9CxDuDSJU/9Fe+Jz37mOG8TN4G6Qcwh7zq/yrBdJjGdcK4osqDgpg4bQVy1Jkxo0dT59EZH/I0wCgzvMD8Am3ZMzLP00LCjxIiTD1icBjEwKEh35hBnTFcnTSQlFPAn9QII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283097; c=relaxed/simple;
	bh=EiHEARKfsSch8CWg3qSOqrgsBmJrYMqzousU6JGvsio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LeXbL7BX7Oo8tnuRknSEDUsS2k9BTE1+OKcoDMD8yIq7PpBq9ualIbapO4T7EyJpJ5Jc1N2z6sSv22hsi0SbEqOUXnF/QNuNlALJGylvtTKUsAAhoxHimaPPL50EZgpOMizPFrEP+69boniXHub5OHXYQI9U87fHGJbxRtPKFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKpsh04U; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so134543039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708283095; x=1708887895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkl65YWoZqBRy7PXp9WalSTMwRYxXFsGyTDBtpnT5Zg=;
        b=kKpsh04U8AChJFNvvcK2Ypa5nxuU1bHtMcF3zIopO7rd6k+gU7sTHPQVGhUBe7T3+/
         SyR88IB/HfQO76TU76Qi/Bv2kL2/HE75Rm7MCB1NtwEgoI481MOHedeDZUuFJgKmnGpy
         UWqak5GMtrBPCuEXrcwWrwfxNmyoONtxhmcuQzizK9BVjciqoWsLGs5ONKx7pfFtYxq+
         gOKS6HCsrsjVscKeIcMPpEJGZ3eme7QK4dBssRzt2vRUrpusHhwV4wJXm6K14Wi/FDX6
         m1syRbF5wEQK7jQWIuZo03St9ZILsJqSfI71uFvDI99WKA0W0qumTaUhewBWPqICLBXC
         9b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283095; x=1708887895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pkl65YWoZqBRy7PXp9WalSTMwRYxXFsGyTDBtpnT5Zg=;
        b=IxpyTdHFMddsHSDi+nzmbyeeUIntuwiroxcsh4F/MporlJExV0YpKF2HKeTOIEOXvD
         195NxCq/3f3rEpx9a9EZT4QH3ZeIJsq/KIivhLEwRpHY9bRuOduca7ASDBMRde10Aufi
         gUXja9dgJeFy8QP6RS2JJ3xz78LxOIhIjBLycQ09dl2e1awlV78QU0X60tYmjxVY9iRO
         hJRVs5ujVYSENnWJFC4GOBhkWDlFCEEkIKvuml9HVzKmpibXqc3Lv7Z75xrxAQY7RPOW
         wIN8miqdF7QewXrEZk1WVRxilt3vRxEfx0b9JnGmhxw20FrsYBx+AaBEdd0jYm7s6OUd
         9gMw==
X-Forwarded-Encrypted: i=1; AJvYcCXLj7DyUC4lf4JBFciTSC/yrHDiv3GMf+obPxSzakaxlJVEZn+4b0o9oHk4Iiji5JmplMAT5s/YVcyvRWyOCRG3HfhfkSNHSF92Vp0M
X-Gm-Message-State: AOJu0Yzk1f15fdvBh6+Vi8iiyNSv+bYZN2AGoI5HR4RGyof0KuPy3iRG
	GAVHFhSj2IlflgC+/tFfFafxRiJSUaT9aJ0iJCUzvYOCo3N6AR2XLUtA+zN4V7w=
X-Google-Smtp-Source: AGHT+IE21IIK1ncR0fK9WJenlFaj9vCYmwKeALvy5FLMhK6sgLjICHI8UkJIFsBzKwoWy9WfbsAPtg==
X-Received: by 2002:a6b:6113:0:b0:7c3:ec35:8df7 with SMTP id v19-20020a6b6113000000b007c3ec358df7mr12455709iob.3.1708283095387;
        Sun, 18 Feb 2024 11:04:55 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t125-20020a6bc383000000b007c4926ebed8sm1300105iof.40.2024.02.18.11.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:04:54 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipa: don't overrun IPA suspend interrupt registers
Date: Sun, 18 Feb 2024 13:04:50 -0600
Message-Id: <20240218190450.331390-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In newer hardware, IPA supports more than 32 endpoints.  Some
registers--such as IPA interrupt registers--represent endpoints
as bits in a 4-byte register, and such registers are repeated as
needed to represent endpoints beyond the first 32.

In ipa_interrupt_suspend_clear_all(), we clear all pending IPA
suspend interrupts by reading all status register(s) and writing
corresponding registers to clear interrupt conditions.

Unfortunately the number of registers to read/write is calculated
incorrectly, and as a result we access *many* more registers than
intended.  This bug occurs only when the IPA hardware signals a
SUSPEND interrupt, which happens when a packet is received for an
endpoint (or its underlying GSI channel) that is suspended.  This
situation is difficult to reproduce, but possible.

Fix this by correctly computing the number of interrupt registers to
read and write.  This is the only place in the code where registers
that map endpoints or channels this way perform this calculation.

Fixes: f298ba785e2d ("net: ipa: add a parameter to suspend registers")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 4bc05948f772d..a78c692f2d3c5 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -212,7 +212,7 @@ void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
 	u32 unit_count;
 	u32 unit;
 
-	unit_count = roundup(ipa->endpoint_count, 32);
+	unit_count = DIV_ROUND_UP(ipa->endpoint_count, 32);
 	for (unit = 0; unit < unit_count; unit++) {
 		const struct reg *reg;
 		u32 val;
-- 
2.40.1


