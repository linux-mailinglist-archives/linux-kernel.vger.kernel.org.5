Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE775C46B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGUKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGUKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:16:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2364206;
        Fri, 21 Jul 2023 03:15:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso11262825ad.2;
        Fri, 21 Jul 2023 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934521; x=1690539321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owjmmZ3WPeByFPSci4+o5GvMgP/2FTIn9FbOlImGOcE=;
        b=NVjh6GMSpwP+Jp1fM3Is6ktzx7gm4XJA2FUVC2Zb/jlqBsLmrgFWE3hA5mw2TsUGpk
         5WL98vtmKeFwANEdQhFF3DQptmsCFhzp4KM+gsP2+Ge7766y3aNwV8lxKhaVRG5AdLuN
         wyJ+DYJ2m6UDuPHGM+vyG/NoKUTDrtF9xi4JHZSJWrBfLf/uMWpU0+urJQWZUQN0Xmyw
         AvLxnxT15PUe8/wBS+IUGH1OJVk0jgVztB0Cm/yDJhLUXdmztgdvuakBQ6wAzb/p53WR
         JPiiG7B6haX/rKDm8rshvb3tdVlXfAG27Upf/BqaFiJEzp9x212Sgm0gWJcTTDPN4owi
         3Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934521; x=1690539321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owjmmZ3WPeByFPSci4+o5GvMgP/2FTIn9FbOlImGOcE=;
        b=YFUIPpLaANOIzc1iIlXYRbtjr5jQAYU+Z1mh/PKRyBOGWo+arT7SJWa5eP4isfQ0wD
         Xnkqc2n0e8QKB1EkAj0K2S7zMdY178KRgTd3dvdMNpHMzK5P3F0zct3a7td1Aj8uTjvn
         YTp/Oou9S2X5ySWt1T4JeIgzLCBzVsyF8+TTlFmmGAws1S9WgxYKLY0mWx34vAKUuN7I
         nNruaA/aFZP9ot61lMrO94prB9fXz7HHPLunwJpl8tD3EK5zjbzbWhYj1qQJXSMIr6df
         lV+xj8mgLF6SVc0XqAHWrqe4qnKsDncR9NJQlBC01m+7aMQn12oINPfS59JUU4TOkHVV
         mWrA==
X-Gm-Message-State: ABy/qLYyesmkM8EegoOl+KUegAhpi2Ycx1OfEvNDH+V2jOUBhl/qbczK
        uFv3Nz8dI9vLmDCnx7TDdAQ=
X-Google-Smtp-Source: APBJJlGva3G8UEsdRt7E4a0WWZ0ae4RiPFnOpIPb5nDfQKYHJH4miBoWcQkEgJoHbhi1txyxpFpLTw==
X-Received: by 2002:a17:902:e843:b0:1b8:a569:f980 with SMTP id t3-20020a170902e84300b001b8a569f980mr1143520plg.65.1689934520784;
        Fri, 21 Jul 2023 03:15:20 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:15:20 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V9 21/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 21 Jul 2023 18:13:47 +0800
Message-Id: <20230721101349.12387-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721101349.12387-1-victorshihgli@gmail.com>
References: <20230721101349.12387-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index a31ccb98692e..2eb2895d494e 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1269,6 +1269,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
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

