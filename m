Return-Path: <linux-kernel+bounces-153201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E18ACADC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5A8B2260D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC191465A2;
	Mon, 22 Apr 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R65eK9bu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60256146582;
	Mon, 22 Apr 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782287; cv=none; b=UTeVPZSbijtG+7X8do6AnEK8lvr+uAaFlF+hvdbE4BXULuYL/c6rqcCMcECaST6dnGcDIrEErADPGMyJreehaGBPa6hpBYRhdxzYhoihSSHEwH6By2veHgTdqR9LFejrp2nQhwfk5YkutcfXdxkxGC0jWlyrnBp7TQ+WWSjL1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782287; c=relaxed/simple;
	bh=OGtEAdD7dw2omBkJ9nOfQmxnHB5yrP/FtvV8LB645q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3xDlFbj34I3FVMf85FLITyaVxzUOjVIkQmW5uBFU+AhiHcP2dPmfRjcYXwXVO+MxOI/6M692oQU8IIPDVhi4yMC/gH3gu1zf1jOhXFPCmjr+M6QwVE1a8F7WsmiZfQvkhADkwXot8qXAQ99RmA3KCmX1ico1AdNYzKcmKW2wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R65eK9bu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2bbc2048eso34833705ad.3;
        Mon, 22 Apr 2024 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782286; x=1714387086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDs+d4/tnVJir9Vj/JzDA8awGIauH4+78L9fkQUktx4=;
        b=R65eK9buiY0hlBhaSpx+l8E42zp8p0HFUu19iZKo1m+WdPyL4QNmwkUNvkgGpoakQ5
         b+Hv7Q0ft7zbUHjPtuL2XMwKvzf7K6gTkykoxg8zIUmsSVz6AddIMQa/gYmN5a2qiury
         8haZ2wGrKdj+nCLHGAABei127RjK0yNXwSPxE/P+KFlhZrCjUOaQCRd+f0PiDRo8fgp+
         VO3CJgx3LTEhIrmjG9wxoIMv45S08EvBztDfRWWySaXzPobZQK0eKI9J/vKSR6vojkjJ
         QaHjbHch5OI4UHbVzdJUVoyTd/LKWeYftM86APlkQ10Y9JCX2ZMIChSSst9ymMd3DySX
         by6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782286; x=1714387086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDs+d4/tnVJir9Vj/JzDA8awGIauH4+78L9fkQUktx4=;
        b=vAN2KbnYHFTZ2FEW/X1OW/KQJPiIBhQaK5jGy3uLj5SH0P0YY0cQdAKZlSeVXvAu67
         JGY0xwN8SabQuSdStIQn6mclPzRWMJA3qFZhNVuzdl2AR6A7kn1OnsFYJly4hQDEof38
         7IteEBTAui4ELiJtvFHGUhpTd7R4eBEzhai588Wajr9gQB+2WyhGhlizjg+aikmeT9kk
         mjMJGl5JeA9PIcgRmdeGjw2tRORVn2hERHxv3/gW/k+yMqM1sKZFtTVNdCe2Ki8b1tBv
         zqWYiIEhTuEws7XG+R5KInbj/NMsSEP6OTbBkes/7Z+mqCAZW4U99JccvyoqjHSbkfZ8
         v7uA==
X-Forwarded-Encrypted: i=1; AJvYcCU/fPy4qN8TmgXvFQFxAlG/Y+u2S2HPzj+cUkXheWzrydnd6EFfhtECUx9mzdbX1AjiPzBgn1wl9rJknlqX3K4L+2lvgHJYIADVYQAq
X-Gm-Message-State: AOJu0Yw4mIsTMcLHcU9yzoEmgTnZyV1gz5MGxhz3+Ssnwbf04128KtSc
	PbslZHCwN/gVH8R5oPf5YcH/j4DjWMJ09ZQqxSdnH1KLJSEMjdeH
X-Google-Smtp-Source: AGHT+IFmoJoLcEF4KAJVo0Paum3mK+XUFoRJ0fVPy3Fc1gp8Dkm1abkTO5go48yizoqFb/iRXzi9Aw==
X-Received: by 2002:a17:903:2d2:b0:1e4:55d8:e74c with SMTP id s18-20020a17090302d200b001e455d8e74cmr13327304plk.2.1713782285632;
        Mon, 22 Apr 2024 03:38:05 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:05 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V15 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Mon, 22 Apr 2024 18:37:26 +0800
Message-Id: <20240422103745.14725-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V14:
 - Move mmc_card_uhs2() to include/linux/mmc/host.h, so that
   mmc_card_uhs2() can be available for host drivers.

Updates in V10:
 - Modify the commit message.

Updates in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

---

 drivers/mmc/core/bus.c   | 4 +++-
 include/linux/mmc/host.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 6731b46e855f..f9a67beb68f0 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -344,7 +344,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85ab5753c22a..3e823ef5f672 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -661,6 +661,14 @@ static inline int mmc_card_uhs(struct mmc_card *card)
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
-- 
2.25.1


