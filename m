Return-Path: <linux-kernel+bounces-73793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E0885CB46
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E810E1F22B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDE154BEE;
	Tue, 20 Feb 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdzK+hfx"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8F154BE3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469929; cv=none; b=DjzUFbabT5g1fkfnTPNkEihex7D+iiBxPj31cYK6egEyj+UIIOVo38ZYCpl5fTwDLf0oU0RP5BhTQO9w+JphoT/eLHDKy5W5sJXnsn2ZUv+I441jdBjHWOyqhK/KIHQVHo3woHbTOVIRyJbed5dn03eAX3uDtkitLPIYV5QvU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469929; c=relaxed/simple;
	bh=2KMavfot7dn/jSlYRp4vCD7QcIkkOuyAV9KqDkyaykQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UsAcGGhE9jsBTx8n2+PJkiyZY5dDPo/chvAbUtquAetEqrgeb1/ydz72DFYE/A1QlxdhIyPFKEngvotcPxuifKGt/lEq4z5Mbzo+rT6lom+eXUn1HNQHQaaz2OPJTC/eKiFWIlXnbp7+x77eiCK/F4fTrEQ4gpI8O1b03vC1PX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdzK+hfx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a36126ee41eso799099666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469926; x=1709074726; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUcIEfTpYZcXd0dHJfdR5ASrz4snMW6xTMGC+3CDi/Q=;
        b=gdzK+hfxp3w//WJXkZf0jhXFjBXCszr82lsBlru4jGHjsZixGxF/FMG39fjEoQlR6p
         JbcZ70CSIK1KcZKxcp6kTnh6LMmENu8Hq5a0smyGD01m1qiNs3MT1QkXiTmqBIR8vhv0
         PajGMh8NmCv/TDVCjLxi7eOxeFnXqt7SWRXzwphZ9QOz2/5/hqFMU20XQ1kO3+TIGuQc
         Gt8zK0K4MT1UyvvPqnB7lREYMs8yBjJnt56ckAQUjB/AFvk8dCMZllJ2pncaaSUdohlZ
         tAhQFZiRzGVRkpz08R/Y4TJfAIUjY9CmRA0T8ZBXwNtrDH17/ZBYAiQJrgWYwqxuDHxv
         271A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469926; x=1709074726;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUcIEfTpYZcXd0dHJfdR5ASrz4snMW6xTMGC+3CDi/Q=;
        b=YVssxHeIgGqWnN8TGdbG/An6NObLefgSYACncMGeRWAZXEFI99367wrPpWIf214+BW
         2fakaPNFEK+YZ+imTihXsOntlabARcvdmzKiTXeWBJexJndjZS9l9IgAq0bdmf3iVZDL
         yRXIFpFwI1rvRz7m+d9C3yGSi8O0OU+rDsRpgwcc5p0Pq3cq0QyBi5PbWnBxnVS9CpHs
         V/f5iZFJP3AcDGfmqqR4Tt4h9cRoGr777vYVhA0yUDTlLsP1OkjBLu4Ia4pQKK5Ncmpj
         cAcbsmhYBzTclAMadAKMOXDaMyDejstKWmccPCHfIMXbd90+qV0WhrGof42pkrlxQ7ix
         c0RA==
X-Forwarded-Encrypted: i=1; AJvYcCUifXE9Lek7DlgqWQlXYNxXSozHEPFx/z5grryNiwFTlC85xxBgPvBjGWkd+WlkWyX0XuxB8avXfp47RujSpQ6m75QwEq4nJ7ohVWj0
X-Gm-Message-State: AOJu0Yw6YBnKsU5H+zYHVFUHbiKfKaCiDUF2KFeJa1joMlZFgbvCKWCW
	P89y8iDMrXAyWIx3vFg8Ak/wdaJRj8xcv17KBCH5eXfE7HJfH2HGO1UkiKVXKYk=
X-Google-Smtp-Source: AGHT+IF2fSCulCys+V0r+zufqoHv/4IUYP8LW9DrBLQfm3rB+JxNdqLqcpFaKpM80DQhAG7gS+CJaA==
X-Received: by 2002:a17:906:e2cb:b0:a3f:175b:ea91 with SMTP id gr11-20020a170906e2cb00b00a3f175bea91mr1274492ejb.13.1708469925781;
        Tue, 20 Feb 2024 14:58:45 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id tb5-20020a1709078b8500b00a3d599f47c2sm4417614ejc.18.2024.02.20.14.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:58:45 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 23:58:45 +0100
Subject: [PATCH] mmc: sh_mmcif: sg_miter does not need to be atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-fix-sh-mmcif-v1-1-b9d08a787c1f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKQu1WUC/x2MQQqAIBAAvxJ7bkHFkPpKdChdcw9aKEQg/j3pO
 AwzFQplpgLLUCHTw4Wv1EGOA9iwp5OQXWdQQmmhlEDPL5aAMVr2qGcrHRlhp8NAT+5M3f+7dWv
 tA64RybheAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

All the sglist iterations happen in the *threaded* interrupt handler
and that context is not atomic, so don't request an atomic
sglist miter. Using an atomic miter results in "BUG: scheduling while
atomic" splats.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Geert, it'd be great if you could test this!
---
 drivers/mmc/host/sh_mmcif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1ef6e153e5a3..669555b5e8fa 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -607,7 +607,7 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		       SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_READ;
 
@@ -662,7 +662,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		       SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 
@@ -710,7 +710,7 @@ static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		       SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_WRITE;
 
@@ -765,7 +765,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		       SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 

---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240220-fix-sh-mmcif-49c1de70c5b7

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


