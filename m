Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB97809A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359868AbjHRKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359795AbjHRKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C1C4207;
        Fri, 18 Aug 2023 03:04:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-689fb672dc8so452540b3a.0;
        Fri, 18 Aug 2023 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692353013; x=1692957813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw3KVUjxPHsxE9rbw9OxgUokTZEojzM8gkSFLav2SmI=;
        b=dph/xEyW3O8UGZZ/Rtg2mFZZXCcofV4ApKG48cObmHxTUPvFDbT/eQtP7YaWYGomsR
         ig+kkO5hb6CQ/dq8gBD4DvOdfnqPPJTfGtCGdCdqpltnRcQ39HfxokKxneO5Z1nIObSr
         h0gNe3fPoQu+9qqXKYMoV5R6x4BB4EYFZkNenacVTc5Z5EpziM3Mdo1uZBdbjecIcQ7T
         3RxPfP0LXKhrdfAmA9b1DM8FerGCDBifE7YLODm661w+gdOCYTf5cdo7W7DztlD4xYuI
         es2/iqNB6SRuLHQT4gs2ZHKQpu4EY2jQYZQ4TQUjDsoRn/X8SbRabJQa3TitsMjAqNHe
         XJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692353013; x=1692957813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw3KVUjxPHsxE9rbw9OxgUokTZEojzM8gkSFLav2SmI=;
        b=dVuKuywaNctp/q1U9FFtiq8/edM+fPvRv4Id2lWCm25mjpfhU0UqXXoE2u+pdkvCBL
         8JvVkzJvO/IDOTvJlSmlKYcvbgFGfUxpEFaHDVJsy/Lo3cRtBLxVRqqaWQe+8TwQwAqt
         jnOPWHfwb/bntt9xTAsUGBv20yVgRhactkjJ3OlpHXO3XpwrYQyx00Ga4P5AzFtbrsrD
         0P9UpHRUi1OdmA8PX/tTHk4hbQLkQKDVhruTB3D18Y67TKCZE7XloTTDq26LLwG9XPct
         NECxzMSWnS5Z6dkiZ4S/YuZdrt8t65o5rtuqPYtEGxxtoZ2WoxGvZhBkwqMjB+KVZrk6
         LQGg==
X-Gm-Message-State: AOJu0Yxjwe9O08PSFCw8UtFuKE2dqGeTFk1CTxPnflwqyDeuBKV0rs7y
        OXFhc79W5lujqutC9AlWbVw=
X-Google-Smtp-Source: AGHT+IGtGaEHEaU8Ndm7jAChVx7auVBBlQx4WYZI1XpXMXxujDMc7utK3GFNkCa/4mum3viuoWaFHg==
X-Received: by 2002:a05:6a00:b49:b0:686:de6c:a9e5 with SMTP id p9-20020a056a000b4900b00686de6ca9e5mr2472791pfo.31.1692353012726;
        Fri, 18 Aug 2023 03:03:32 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:03:32 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V10 21/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 18 Aug 2023 18:02:15 +0800
Message-Id: <20230818100217.12725-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 80eafacc8b9f..a97f4c9d31f0 100644
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

