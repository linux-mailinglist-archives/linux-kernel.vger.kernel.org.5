Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C08798537
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbjIHJ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjIHJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:55:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE61FC0;
        Fri,  8 Sep 2023 02:55:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1f7f7151fso14708385ad.1;
        Fri, 08 Sep 2023 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694166878; x=1694771678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8s+ls8Yw6NMJtaPKq6UHyd+YkBQYdgGHT2EXOl3gig=;
        b=qoE5NaSsAVcMCg55dp8M93+qCAbk1lTLlqzFyCdVQCOQzQjIaKF0ANspZgNAudyucB
         ycCPzomoyxwTkvhpGFjZlG9ZDTb72Hlyfg3L0Cgb6ItPrRcRKCnpPZ64WT1XmHInZhJT
         /NY8gpt/+w0HzbxwAq3ekF7YzhJikJ0BO+/yG+FdENBQ9GSSgw9SqV6cO+y7nYYC6tuB
         9znf0hvzgJS5Y06/IDozsDwBGM/mFJEX80ZBVqsujNT/9rTEn0X7CQAKHGNDMd4jstbp
         XHwY2U68FnFpivM7yIyGdXqmLet8KtwCLHZ+56WxxuhbJ6S75UaltJloN/u8lhTbNCb7
         ylkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694166878; x=1694771678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8s+ls8Yw6NMJtaPKq6UHyd+YkBQYdgGHT2EXOl3gig=;
        b=P6A1ZozpCe+YDjjdgMTaGLq1KofK0rIe+3bvmV/+s7YKVBfHtGefhe167+72vmudwX
         U/dP+EvpBwfHcL1NGthztNhsr0jfjpsKnvpbxDt9L8rpygU4BJlYJ0I0xYUAazbfxEdl
         J0KWlq4BjhMOcGHhr4OpCVoHL4boTEZho+dIZAxVdgbu57nPZprBv5iXiGzWFJpOzsQb
         aR24TQwCcV8nuxU8C5YdOlD4iNPyz2yKbeOLtWwl5IsrT83EoTvb/nP61IcL55Aq8Dnm
         Pkyb94ilnKykL4oDqZWJChhxX5mUhri5jfjgPzVfk682L28mhKFRONAtCXtOEX+GhMhC
         XFKA==
X-Gm-Message-State: AOJu0Yxy9LIndYksSfz1YgynJxlFrhswSSNaLvBx5CXOq2tw8T3n5OZp
        fdqqzI7Furv76gI1mKU5QZY=
X-Google-Smtp-Source: AGHT+IGkEuaMtsMJEpkKEUMVZ4JFUo6BWDh7HgM+Rdg6xJ3sUgBglI0Cdx2KW2uHkPBgKkajdeMWDA==
X-Received: by 2002:a17:902:ce92:b0:1bf:3378:6808 with SMTP id f18-20020a170902ce9200b001bf33786808mr2410620plg.56.1694166878099;
        Fri, 08 Sep 2023 02:54:38 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a1-00a4-a20b-46bc-ccec-3e79.emome-ip6.hinet.net. [2001:b400:e3a1:a4:a20b:46bc:ccec:3e79])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b892aac5c9sm1172178plg.298.2023.09.08.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 02:54:37 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V11 21/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri,  8 Sep 2023 17:53:28 +0800
Message-Id: <20230908095330.12075-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908095330.12075-1-victorshihgli@gmail.com>
References: <20230908095330.12075-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index add0eea55b24..517c497112f4 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1267,6 +1267,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5235f2da6568..300108cc255d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

