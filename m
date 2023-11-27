Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6AE7FA444
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjK0PTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjK0PTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:19:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C2D0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:19:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6213266e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098383; x=1701703183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ41arVcAuG43JZqYRRYkpgAWKlZs6YO605nhsMazRg=;
        b=v677vaar2lyjPuA8ZSFU5/CskWsfVobXQA6tXFK9nk3Xes/HIpCGD7Xrjk2Kmtk1JL
         N+E5Sp+FhDdEP5QkUyDizRuYql4kexFpZC3pHKod0+Q+DKYbkrmjXbWJ+Hi2+DdYzbFu
         s7iJmDbVW7XxfeC0bKQ4NRAD94S5tsHSFBek8qv5FRHH64XtNXvgxSWCJ9VjUvNR/JWG
         06GlBblij2zAhT4Poq1RENOCuXdfUvQq6C7H4t1rcdkQd7Qo+kDmEWjKoXPuMevwMKZd
         SKsTo+bQte8Q062iNb9hyhkaZCGoiZdq+Q2Yg9BpcCMuP5zzCgB4RlKaZeG9QoFVyXVE
         sf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098383; x=1701703183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQ41arVcAuG43JZqYRRYkpgAWKlZs6YO605nhsMazRg=;
        b=Q34hOprPjsAoZwe84EEcxdY37nCPaO/Exm+Hzb6GgxfoAyREYPkC+2tAuT7L2Jpmha
         VtkpZlE+Ko1i4A3sWEtoaOQ6RtdmXde2/kpsa5cfe2aj8FHVo+5JKZt+LPg0NXskyuU+
         foJix+iOArw8EzOU6T8rlPnFpvCTClaMjOvPRfZPRYBX2BYtrkaF9tXQskRVhpaEpTSe
         SlQdwBQ6bIgaGkMkK4PN6zYOc/ZJuLFY3MDesFnhFjlRiKXYa0ehfEqtDsGD35hIm06Z
         Iqn05gtSRZe6+InawOQr1qqVgwKBbWkk22l26MHE7VH8FhuXLBaKTTvzqhsvEPgTZnTE
         0Ybw==
X-Gm-Message-State: AOJu0YwZ3si/HuboBT46a//FnwZ5Z3uqFChn5rOGtUJnS0xEnYJC3m/O
        Al38sfJm7tbFKokBGJwm40Xo0Q==
X-Google-Smtp-Source: AGHT+IGzphxorONaJExp0yvzdHT7XzIgSeo6DYR811cKr73UStSCVUYTy9QQ+4aEmW2vjMUL46D7SA==
X-Received: by 2002:a2e:8196:0:b0:2bc:c004:cc22 with SMTP id e22-20020a2e8196000000b002bcc004cc22mr8315420ljg.33.1701098383440;
        Mon, 27 Nov 2023 07:19:43 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e8011000000b002b6c61bac2esm1371363ljg.92.2023.11.27.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:19:42 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
Date:   Mon, 27 Nov 2023 16:19:31 +0100
Message-Id: <20231127151931.47055-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
level dance"), there is no longer any users of the
pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
corresponding ->opp_to_performance_state() callback, which also no longer
has any users.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 32 --------------------------------
 include/linux/pm_domain.h   | 12 ------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1777e39eaa..cf65b5a9783c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3042,38 +3042,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
-/**
- * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
- *
- * @genpd_dev: Genpd's device for which the performance-state needs to be found.
- * @opp: struct dev_pm_opp of the OPP for which we need to find performance
- *	state.
- *
- * Returns performance state encoded in the OPP of the genpd. This calls
- * platform specific genpd->opp_to_performance_state() callback to translate
- * power domain OPP to performance state.
- *
- * Returns performance state on success and 0 on failure.
- */
-unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-					       struct dev_pm_opp *opp)
-{
-	struct generic_pm_domain *genpd = NULL;
-	int state;
-
-	genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
-
-	if (unlikely(!genpd->opp_to_performance_state))
-		return 0;
-
-	genpd_lock(genpd);
-	state = genpd->opp_to_performance_state(genpd, opp);
-	genpd_unlock(genpd);
-
-	return state;
-}
-EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
-
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 34663d0d5c55..b97c5e9820f9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -118,7 +118,6 @@ struct genpd_power_state {
 };
 
 struct genpd_lock_ops;
-struct dev_pm_opp;
 struct opp_table;
 
 struct generic_pm_domain {
@@ -146,8 +145,6 @@ struct generic_pm_domain {
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
 	struct opp_table *opp_table;	/* OPP table of the genpd */
-	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
-						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
@@ -348,8 +345,6 @@ int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
-unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-					       struct dev_pm_opp *opp);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -395,13 +390,6 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
-static inline unsigned int
-pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-				  struct dev_pm_opp *opp)
-{
-	return 0;
-}
-
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
-- 
2.34.1

