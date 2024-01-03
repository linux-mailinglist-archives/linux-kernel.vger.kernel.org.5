Return-Path: <linux-kernel+bounces-15448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69F822C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D401F24203
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABFE18E2D;
	Wed,  3 Jan 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="mkA1cIYq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986B18E29
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5f40ce04so57432165e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 03:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1704281357; x=1704886157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uonm83saY7VBk1RNLrVWufQJZVuuKsJnIJ61x/jSfWM=;
        b=mkA1cIYq8mdO7YNfl3dF2y81az2v5Uo0OJgNcl0idgZJlaw4MmE2qLAPbOMB1Khjjg
         b7vjAPEnJmWyVKOLRi0QO8IcJ4cYq0yIRVro7SSJS+hRguFY/t4Rud0PkvOTZeFntghZ
         2Z/9qPf8tk3cUgRfnMzhP0f93E2Zkv6D2wNSzjIJsOOuA3ZYJQjdmRTy8cvcNk8pn1Zx
         60B+6YTT7nIvheDywSTyvl0o5ciRMPCyTqkfExVnguCkdK1vdkEeCAMLExqQTuxGOi+C
         F4CDx8HJwFnBeffMpFhWjUoMQRLN0iqXOEGXqL5qQg47HYCi+m6ijdy+0Ow+VU9AUSfj
         3uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704281357; x=1704886157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uonm83saY7VBk1RNLrVWufQJZVuuKsJnIJ61x/jSfWM=;
        b=hcCvPp1HTnJ6M/H+sh0/QKmb4wy+KI3s2VRHdTg4exMNEBa2qmjp1SLLonhe3QqgBG
         Vlw5A0lIz8EL8oY6C+M9xnJJKrGXe/aCB8f3faKFXXZ5IQgQvthQCMjKd7GOM1K9ovtJ
         xqVCmYZ7UanXzLSPP7egof1Q4QonttDWjwzPZU03hH6Sh7yUUvJL+DLemcG36mjamvFg
         u0Dcay0MfrCcdW3NaiCBYguAdv7BsgpmD6mCPWyLWEVNN0T2Icv0TyDlrHGBJrQ3P9sv
         cJVQfk0TNOa4zUzZYuBK7r9Y1T8UWbe+2vBXQje/JzkP25x+yEkSvpH0HYc8/J3E3W9d
         E+TQ==
X-Gm-Message-State: AOJu0YzHZaYBfbi01y5kXCzoZeXY711QVvq3WWq6YViXKPvdymBHYys7
	iyZJKjV7jCfy8pQj8NTbKyRWJ3PiMj/U3w==
X-Google-Smtp-Source: AGHT+IEC+hprC1XD+29xo+6JDXtpHJkshKG3WDHJW6XayhZvzoUEfoHZBqjP139IJtRL+0r2qG/ITQ==
X-Received: by 2002:a05:600c:314d:b0:40d:6e2f:da7b with SMTP id h13-20020a05600c314d00b0040d6e2fda7bmr4455448wmo.13.1704281356698;
        Wed, 03 Jan 2024 03:29:16 -0800 (PST)
Received: from trax.. (96.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.96])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040d5f3ef2a2sm2040128wmn.16.2024.01.03.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:29:16 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	adrian.hunter@intel.com,
	Avri.Altman@wdc.com,
	ulf.hansson@linaro.org,
	christian.loehle@arm.com,
	ricardo@foundries.io
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCHv3] mmc: rpmb: do not force a retune before RPMB switch
Date: Wed,  3 Jan 2024 12:29:11 +0100
Message-Id: <20240103112911.2954632-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting a retune before switching to the RPMB partition has been
observed to cause CRC errors on the RPMB reads (-EILSEQ).

Since RPMB reads can not be retried, the clients would be directly
affected by the errors.

This commit disables the retune request prior to switching to the RPMB
partition: mmc_retune_pause() no longer triggers a retune before the
pause period begins.

This was verified with the sdhci-of-arasan driver (ZynqMP) configured
for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
cases, the error was easy to reproduce triggering every few tenths of
reads.

With this commit, systems that were utilizing OP-TEE to access RPMB
variables will experience an enhanced performance. Specifically, when
OP-TEE is configured to employ RPMB as a secure storage solution, it not
only writes the data but also the secure filesystem within the
partition. As a result, retrieving any variable involves multiple RPMB
reads, typically around five.

For context, on ZynqMP, each retune request consumed approximately
8ms. Consequently, reading any RPMB variable used to take at the very
minimum 40ms.

After droping the need to retune before switching to the RPMB partition,
this is no longer the case.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Acked-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 v3:
    Added some performance information to the commit message
 v2:
    mmc_retune_pause() no longer can trigger a retune.
    Keeping Avri Altman Acked-by since they are functionally equivalent.
 v1:
    modify mmc_retune_pause to optionally trigger a retune.


 drivers/mmc/core/host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 096093f7be00..ed44920e92df 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -119,13 +119,12 @@ void mmc_retune_enable(struct mmc_host *host)

 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command.
  */
 void mmc_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
--
2.34.1

