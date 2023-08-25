Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB47885AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjHYL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbjHYL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:26:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A443F210B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:26:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso1229951e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962815; x=1693567615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKye3n3ZdJM1hOodYZHu6U71dZ+JAqIemRtGr7VMK2Y=;
        b=rYShorJfvMUDKTzNQbTGT12boHv3XldzUNsyqVWJejs2shLiItEiWZy/D4ljdQpOHT
         qKATdWAfdaHcxQkFLryB29u6sbprTvGdFsE+LlvEEZ4rNu9NkdiydAuUzlgolG0fVT2g
         tD0C4MlzpEbRnSDuGuwonDwRxk7zskrju78y/cFcP2P5tq9xGXnsYG5Ackrg36CUWHyR
         nBrYlCDy6OWHpibxp2VrdXIHfgws3QWVZBHYHkIosU3isRryF2t5eiw88cfBIAhSrCs4
         2qepnHp0vDDmWCgXAM8SsdZnEhShM5tuJysaQ96ZObuEAvQDH3hT5DBnjjQavY+LQJ0d
         dHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962815; x=1693567615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKye3n3ZdJM1hOodYZHu6U71dZ+JAqIemRtGr7VMK2Y=;
        b=iXz8C0sJKId/ckaF7dSa3DN1T3eb4DhymY7/p3kmqzkjHYjZE0qvBySBI8QWuXjlmR
         4jm5tVODJaLk2LNP3h3yzkY7lk8hEF+5h9s5XiYi2CvItclwHiMVjb99ZD2wChcihNCy
         91MqnwkSe2ziHADdvKTTzU/IMgElpa8x4PKX6o6kvkGs/JWudcjYQ6LlfUNBU1wd8bTU
         oCi2jGvOFAM1khrhZ+uzSd7l8XlpqYnFnR0cMPkWa9CBUVytUAfCGlx2gvkTWBUxDps+
         wcnupXf0iyGaSs2d+DqTiiZ1VfmaQ01SkHcJrNjJJyVr+aAKFUOCl5/bW/BG9DeTfuf+
         Y6CA==
X-Gm-Message-State: AOJu0YwyaL3YMQqnN02a6Qf1oCRh75GwbuRskr2ThewE5AMls6E5YEvD
        E1zmBVaJUIJSLldkikvQ3PXQ7w==
X-Google-Smtp-Source: AGHT+IHsjbz0MgO8dJW0AMQvdho38ideebTyrMuKlL0qstLIcGn+3zblehkTB5qFDCLypNML9zZEog==
X-Received: by 2002:a05:6512:3045:b0:4fb:89b3:3374 with SMTP id b5-20020a056512304500b004fb89b33374mr16156290lfb.54.1692962814843;
        Fri, 25 Aug 2023 04:26:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] firmware: arm_scmi: Extend perf protocol ops to get information of a domain
Date:   Fri, 25 Aug 2023 13:26:22 +0200
Message-Id: <20230825112633.236607-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other protocol ops, it's useful for an scmi module driver to get
some generic information of a performance domain. Therefore, let's add a
new callback to provide this information. The information is currently
limited to the name of the performance domain and whether the set-level
operation is supported, although this can easily be extended if we find the
need for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Re-based.

---
 drivers/firmware/arm_scmi/perf.c | 47 ++++++++++++++++++++------------
 include/linux/scmi_protocol.h    |  8 ++++++
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9fb63dd44c20..d20bb6b8abfa 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -145,7 +145,6 @@ struct scmi_msg_resp_perf_describe_levels_v4 {
 struct perf_dom_info {
 	u32 id;
 	bool set_limits;
-	bool set_perf;
 	bool perf_limit_notify;
 	bool perf_level_notify;
 	bool perf_fastchannels;
@@ -154,7 +153,7 @@ struct perf_dom_info {
 	u32 sustained_freq_khz;
 	u32 sustained_perf_level;
 	u32 mult_factor;
-	char name[SCMI_MAX_STR_SIZE];
+	struct scmi_perf_domain_info info;
 	struct scmi_opp opp[MAX_OPPS];
 	struct scmi_fc_info *fc_info;
 	struct xarray opps_by_idx;
@@ -257,7 +256,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		flags = le32_to_cpu(attr->flags);
 
 		dom_info->set_limits = SUPPORTS_SET_LIMITS(flags);
-		dom_info->set_perf = SUPPORTS_SET_PERF_LVL(flags);
+		dom_info->info.set_perf = SUPPORTS_SET_PERF_LVL(flags);
 		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
 		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
 		dom_info->perf_fastchannels = SUPPORTS_PERF_FASTCHANNELS(flags);
@@ -276,7 +275,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			dom_info->mult_factor =
 					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
-		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
+		strscpy(dom_info->info.name, attr->name,
+			SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -288,7 +288,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET,
-					    dom_info->id, dom_info->name,
+					    dom_info->id, dom_info->info.name,
 					    SCMI_MAX_STR_SIZE);
 
 	if (dom_info->level_indexing_mode) {
@@ -430,6 +430,29 @@ static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
+static inline struct perf_dom_info *
+scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+
+	if (domain >= pi->num_domains)
+		return ERR_PTR(-EINVAL);
+
+	return pi->dom_info + domain;
+}
+
+static const struct scmi_perf_domain_info *
+scmi_perf_info_get(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return ERR_PTR(-EINVAL);
+
+	return &dom->info;
+}
+
 static int scmi_perf_msg_limits_set(const struct scmi_protocol_handle *ph,
 				    u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -453,17 +476,6 @@ static int scmi_perf_msg_limits_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static inline struct perf_dom_info *
-scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
-{
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-
-	if (domain >= pi->num_domains)
-		return ERR_PTR(-EINVAL);
-
-	return pi->dom_info + domain;
-}
-
 static int __scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 				  struct perf_dom_info *dom, u32 max_perf,
 				  u32 min_perf)
@@ -819,7 +831,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 		}
 
 		dev_dbg(dev, "[%d][%s]:: Registered OPP[%d] %lu\n",
-			domain, dom->name, idx, freq);
+			domain, dom->info.name, idx, freq);
 	}
 	return 0;
 }
@@ -956,6 +968,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
+	.info_get = scmi_perf_info_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 71b39cbbdace..71923ae63b01 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -97,11 +97,17 @@ struct scmi_clk_proto_ops {
 			      u32 clk_id);
 };
 
+struct scmi_perf_domain_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool set_perf;
+};
+
 /**
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
  * @num_domains_get: gets the number of supported performance domains
+ * @info_get: get the information of a performance domain
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -122,6 +128,8 @@ struct scmi_clk_proto_ops {
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	const struct scmi_perf_domain_info __must_check *(*info_get)
+		(const struct scmi_protocol_handle *ph, u32 domain);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1

