Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58A75C455
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGUKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGUKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:14:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FF2D76;
        Fri, 21 Jul 2023 03:14:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b4749013so13209585ad.2;
        Fri, 21 Jul 2023 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934490; x=1690539290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1IqDQa1Bm9yylixDY8O9hLBQ0nGnqndZrsYvDaOD+4=;
        b=hw2emshtYoA9boL7tl1ZpQJvc240zglSlzRe0lNtTZ09lgqIjqx8iVDZkFcNgBxBoB
         uAJMQhx1E4HUjsHzgViS15SUFEQDPFtTPDL/wAuIXEEfmXTkEo8axi7/L2e3e6dhOyPA
         J7hv7iJ9RCyCN5pxV7YMHhPo91iDSxkx2ziPpHAM0CGMtt4qsMP4XXeZ4l0GAqJnmkc3
         nUPp/c7REfY+PWntD/srziv3/YUFwhhyfTIHht6mHHWOvkVGdpR2RfCjTLyUMxF66pqD
         Qq0VObV/99TglU9iYtHdTNEYGHYdMLPMMUxDLHSehCLyzA6dg4e1ILB/NgqpFutuY7xm
         SDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934490; x=1690539290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1IqDQa1Bm9yylixDY8O9hLBQ0nGnqndZrsYvDaOD+4=;
        b=GxjyEjP4HUPiTgwTL/ew17HnC0S2G6AEvcEXObvDhASRtxZNs7FnlYjy3uMukEk7dO
         Shb6ziOLly9lqvVzyYUNGE7sNfFcmzSQP9/RqyEs3EgufHTkCMRoKyTwP1ZhyWJzov0n
         IUSh6jh1M+3NaKyeJTHQizuUmZY215j6vKZ465+JSK0ObUfspJ5ymgj+YnkfWwwEU9UR
         OkZaukdwQ42cc+DRSgUiJ07SMnnc75sgNac2t1qCINKXNq9bR9sfrTY97nRfZOfw42aJ
         5iKvFOpawti4W/jZQEkUx8PARNUskzAiwawQUOVL2sVVDX5i1ux1BeSVTjq4OoFlMatV
         hj8w==
X-Gm-Message-State: ABy/qLZRCNMtp1U1g5WTPBKCdBeiuX2DoSN+Q4yCWN545YQFqoGW5su1
        hVcj7GAbUQzPysl/Hd4uW5W2DMZFE0o=
X-Google-Smtp-Source: APBJJlGS9QKKabSJOwUSYS7VscHtxsqJhngBkJxUzU2Fp2rcwP5SQSQ8chhCue9m3S7mPcL8LQrVUQ==
X-Received: by 2002:a17:903:2450:b0:1b8:3e15:40e8 with SMTP id l16-20020a170903245000b001b83e1540e8mr1720544pls.56.1689934490568;
        Fri, 21 Jul 2023 03:14:50 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:14:50 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V9 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri, 21 Jul 2023 18:13:38 +0800
Message-Id: <20230721101349.12387-13-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V5:
 - Use sdhci_uhs2_mode() to simplify code in
   sdhci_uhs2_start_signal_voltage_switch().

---

 drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index fc37a34629c2..92fb69b7e209 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 	}
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+	if (sdhci_uhs2_mode(host))
+		return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.25.1

