Return-Path: <linux-kernel+bounces-77068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4678600D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD061C24AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7115B98C;
	Thu, 22 Feb 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prc0E+AP"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37E15B0FE;
	Thu, 22 Feb 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625679; cv=none; b=JP9HPt+nmhhwyJm1aiZYu3ZGHP8xY3YG/mazqRungWEB3WOJsKtlW2aRcyANLKlmAIzClQudgs597sqVrPxzOICd4G+0z1na9ZqnzBa8FSC5KUSrYunaM3uiVZ/uXflX79Zkn/8+BVq/rV1R4q8HXajfoWS9kxLA4wJI0J7wE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625679; c=relaxed/simple;
	bh=j1JuK72lFu/VKsjL5teL4R8pfxfWUvJcKM4VxQumWtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5oe2EwE20rT0Rg6y6l2J4BNDpYzwugWb+FPSSP8Nc1Ztqs4E49Jw6s5tdPduVBLHntE1qXyvCOeI3BbJJF9G7QgNxH6kbXCaQff7U0XSQeFdL4bnn4tujnystVGXG8UvqCnhRrVXjENUhqLIADx0iuVaWp50rbfe5l+HbAVcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prc0E+AP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512be6fda52so122393e87.0;
        Thu, 22 Feb 2024 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625675; x=1709230475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75JkZwTsL4Dcbz0CcBW0plC9VrJj9UCwkyPRaMtpo4c=;
        b=Prc0E+APlCFXmIzm//SPQvX66/whInYBWH23ERhAlOGbf8ogHx+B0Au+3pmoWFysrl
         ojjViEgrowpvV7R+I2+KvmzxWN7fW/C4jtrtSh7HynGH+cn+k3HffFAkTtRzN8POZrHK
         Wk45Fw4qdJTZ17T7+YLB0lMA8yYCoIsrW3wV2wLz6XWymvpBIHyzJFgTBSsBKDObF9pX
         rM/Bhu0v5DcNNywuoV7aqDPY5nWADlJP1UKCa3D5ecSi03mc18j0WylrwG+7yF7+FR7I
         JpNiTHCHMOl5iOgMcDTzeFjgIaZL07BJHgapUenSUfqesajvas1nD6Br1cdwrIgUtw7v
         8LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625675; x=1709230475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75JkZwTsL4Dcbz0CcBW0plC9VrJj9UCwkyPRaMtpo4c=;
        b=C4iFaPCPNbmOxpuBaERaIbBfQPPCLpujWcPY2fFjFQedYhGnw8RHYgiUV912M81uHF
         y0YoPA02Nwx7fikzUzVboifFyZwB7AKbjG4aN/VJfmw+NVMptTUsCjlAExroc3yT6Bb+
         4wNppgVdJoaZIp3ayX5pjdQMOSCBvMo9Fqs8bMLlgUOZnmH20khWFUYemoarl19VvpUZ
         MjPQ3l0ya+nGNkY7F56et2bdkH6ilqDm33tccWPv3Im5hhu7CdeXeCp3tenwJCWnS84K
         9agrsY9aiLEspS7ooucVKY1JcZnRTpmnlGHx/lCIUB4syVWQL0czy8wq0Jd70mKFZt8o
         8DJw==
X-Forwarded-Encrypted: i=1; AJvYcCVS69ea1e3rNE+QC5Nx+f4Dtu8zsP7uZ+9D5j1/lI8dr1PLRqDslsT0NLM/EeZmflDeY+0T8kKYewQNACcrowNQ0+OD/hiLMgLiviwfV/N1lwziGfLPwPxJsVB16av4U3wkVt23TPrF+w==
X-Gm-Message-State: AOJu0Yy9Kp9Sdco65/fwNLe45T994M/67irfGUTRYUV0N/hBbXHzXpVu
	9H9YoQbcal8gaKx2bP80zuA+hvi7Oxz7KyGrI6gctX9VUxujTaBm
X-Google-Smtp-Source: AGHT+IHL5/hu6VK7d3WPOWjLHTAPQ0FqlAB/KtPSK88tLkHZmTgfAUxJRAjJ8Q5xs1zpJYKDO1R7kg==
X-Received: by 2002:a19:5e42:0:b0:512:aa57:f38b with SMTP id z2-20020a195e42000000b00512aa57f38bmr10450667lfi.53.1708625675351;
        Thu, 22 Feb 2024 10:14:35 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512047200b00512a62a176bsm2030675lfd.26.2024.02.22.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:35 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/20] EDAC/synopsys: Drop internal CE and UE counters
Date: Thu, 22 Feb 2024 21:12:53 +0300
Message-ID: <20240222181324.28242-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all these counters aren't exposed anyhow from the driver.
Secondly the EDAC core already tracks the total amount of the correctable
and uncorrectable errors (see mem_ctl_info.{ce_mc,ue_mc} fields usage).
Drop the useless internal counters then for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Drop redundant empty line.
- Drop private counters access from the check_errors() method too.
---
 drivers/edac/synopsys_edac.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6976ef84e952..5099246db90e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -304,8 +304,6 @@ struct synps_ecc_status {
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
- * @ce_cnt:		Correctable Error count.
- * @ue_cnt:		Uncorrectable Error count.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -319,8 +317,6 @@ struct synps_edac_priv {
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
-	u32 ce_cnt;
-	u32 ue_cnt;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -592,13 +588,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	if (status)
 		return IRQ_NONE;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
-
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
@@ -624,12 +615,7 @@ static void check_errors(struct mem_ctl_info *mci)
 	if (status)
 		return;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
-
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
-- 
2.43.0


