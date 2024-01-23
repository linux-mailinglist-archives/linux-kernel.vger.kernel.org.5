Return-Path: <linux-kernel+bounces-34783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD84483876D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2491F24C62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3052F7C;
	Tue, 23 Jan 2024 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWjzyMbW"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA89524A3;
	Tue, 23 Jan 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991363; cv=none; b=rpPDSMetgMM+1Iz834ccXmXMNKtoshDo2kjGQqCQqdvfn89ajwyaIzTVtolQV3QL08bsOATEoGF2flVGfYoCLvt+Lw/FtRytEqFLZzBSxtoa/FDvRwP1+rJNv2VibF5LoBTQvw/arm/rJz2GYMaffKOxJnm2DGRZLVPbwEAkxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991363; c=relaxed/simple;
	bh=PVJAmPMR8F0OrJe+kXHRPDYfd5+hxfvCB2BI4WrJFxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0epwaZvI+DLNYcGrld/uSZeus8kaPKditnxQDp6rphbZ0lrZqIWOKAiccBCgjyh80uEmZ8EAOknykhcwwPhij+UOHik5WZVU4atbXi5ixA0quawIQ7qF8HNhF9f4iAvq66knEyHOXyT0qHCO0SEdBHJrgUgp6HnwTfUPjhgTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWjzyMbW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6db599d5cb8so2996720b3a.0;
        Mon, 22 Jan 2024 22:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991362; x=1706596162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVVK8PYza3PZw2RU4jEmSGH0po6YzhMl/TtdR6VRTik=;
        b=IWjzyMbWWDunO3siVK82t1CoqH+KHbzJODCBTI597JXhOkEr7675EZ7VA7Yk02o36H
         JbIWelDjSJhg3f9TLnDDZMDcdN941f3rKdc8nTSVKpMl6z+KSRy1mHfyh5iV8pFJZiN/
         j0JrC4/xPe03Cry5ATlgMAEY/Li5gy3Eo1GAeGhK40AfIfcZV+IXMgk4E7tU4W4zkbDu
         FxkX8ZYsQrPcdqmOtJ4LqTCv2YoWuzHuBXroGOoul8ANNaQRsuSq3dhCj3UzLiYBG19O
         5Xkcqo1FusEkV5wqyNh4tKDLoWXAOaKyzgdHV+W5vRl4nL+txIL82lKsNfJP2NQQZ9VI
         XEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991362; x=1706596162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVVK8PYza3PZw2RU4jEmSGH0po6YzhMl/TtdR6VRTik=;
        b=MPcn2TIcdSCq0N9XRuS3Bbur+a+am6sgzTCXcHNx7bPluQbxtuwPuSIYuj5BgQQawi
         bZR0JaJktCiaNd14seBPaK8JL+XspQeTrJtimrXX7BeuaLknj7p1OQyZ/WhCqbfskoLQ
         JkNeovgpzrBxVL5fZNO0kCA+hlkPBmT4jSq5Ki6zbLnxDLi6nPcMbnF8dv56fh28EWX+
         PbjJCBBTtwGH2QfVQDULbSkkv2wI3SNBU0Qz4XJZI08gNqJGguMcJ8mOZJ5xhISKId80
         DblJPbvPC/M4auEyJ0HQwwIBBA6hfMhyp1bO4vAajqi/efqDJaZXeN+NaF3w/lCD3vG1
         BOmw==
X-Gm-Message-State: AOJu0YyXQQror9P74wabZHKpHoCVXUoVP0SJIVsNHyz//y8+FsJcsCuJ
	10EuIW2JtxWR88cm9j45jxSjVL3hXO5xNEcVMmD6h8MZyrhYnfgIIlHqpXveUgk=
X-Google-Smtp-Source: AGHT+IE+E+gU+wcZjwZqsiR3bqAVLmFUsdw4opUUgFxQpgqMnyhdouk+TOAphbG18YohjzTV0Trz5Q==
X-Received: by 2002:a05:6a00:3ccd:b0:6db:ea97:bcd with SMTP id ln13-20020a056a003ccd00b006dbea970bcdmr1905149pfb.41.1705991361706;
        Mon, 22 Jan 2024 22:29:21 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:29:21 -0800 (PST)
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
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V14 13/21] mmc: sdhci-uhs2: add set_timeout()
Date: Tue, 23 Jan 2024 14:28:19 +0800
Message-Id: <20240123062827.8525-14-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's set_timeout() operation.
Use sdhci_uhs2_set_timeout() to set and calculate the timeout time.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_set_timeout().

Updates in V13:
 - Modify comment message.

Updates in V8:
 - Initialization be combined with declaration and realigned
   in sdhci_calc_timeout_uhs2().
 - Forward declare struct mmc_command in sdhci_uhs2.h.

Updates in V6:
 - Use GENMASK() and FIELD_PREP() in some case.
 - Use sdhci_uhs2_mode() to simplify code.
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 2 files changed, 74 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 4fe106e2ba8c..a2df109b49d8 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -134,6 +135,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 	}
 }
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
+{
+	/* timeout in us */
+	unsigned int dead_lock_timeout = 1 * 1000 * 1000;
+	unsigned int cmd_res_timeout = 5 * 1000;
+	unsigned int current_timeout;
+	u8 count;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (mmc_card_uhs2(host->mmc))
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index caaf9fba4975..089a6c0cabda 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -175,8 +175,10 @@
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
 struct sdhci_host;
+struct mmc_command;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1


