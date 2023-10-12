Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C37C71A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjJLPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379457AbjJLPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:36:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB40CCF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:36:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50567477b29so1540682e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124971; x=1697729771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oU0lIYVg56CkTRqLzmL92GAs1KwRLVAtgYT5VSBI6s=;
        b=zRq+5vasQ7te5GzpHIWog653v1vjbaHiROFnHhYGfGaZiNeadx0Po6epWCoHuC48Ge
         P+KY9OYkM3kSlL/lytyuFfnCOOaXL24LNiXYYjuFNf7QCc8ZMPMFGXkZQyrIK22lupLY
         JAs2H5pG9jCpnf+b3As9MTDnYgSLHj4xf0yLEhmYTXzKp+ygaqFAPW2sdrdpvBaMoe+L
         IMjtMYo1FqFe2tqXk4RIjirIagekM5x+U3fKEKLf36gMbEWJs1Vi0hCCTYK6g9MRhv4u
         MpVRixUGBoZvIW+sttVhKvdQLl3lEVMgF193+cPIHZ7n2KH7eXBCaGVzQHw6VLjLHvwi
         0sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124971; x=1697729771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oU0lIYVg56CkTRqLzmL92GAs1KwRLVAtgYT5VSBI6s=;
        b=Dgg8U6RIXy5pbxX4jJkm7sq7yVH8djymuO0oPeEd58nk39ty9rz8hfVkXLg/+m+zLv
         fK8kiKHf3r2vl5bGCHs9R6WUUwrPjRB5jz+7UWExJMDWqeB7J9xFjFPVaMFoT+lpDVX1
         5btV140ki3fF64cb6q+E6pnAXiIW56d7++Z6PFOY9FACrJvDQmIzb6yneZcKodjDpoLO
         sR+OKINiSHcIFjG9404hHuEeWKCe1hXSe/daI7+jSsfD/+VOpW+tWGHgyFsscZ9yk/ju
         tFG+yc5w03L3rxihZeakPo6xQlo9vUZuSEI5HrqqHf2j5V6V+Tq59HMF5hhJIu8CiaMx
         aF1Q==
X-Gm-Message-State: AOJu0Yw+PBuOTYZaYOTi8izPyYl4tE52llAXU15+fDmiy6SdCkktJyHj
        aoKba7Vno9EqHCLEzeKxDUdnEA==
X-Google-Smtp-Source: AGHT+IEK0E4FwtYKJpxrmPxWlWktvc53EX6B16eXxTE+hpXej8tzWOLjrlYIDiwRft4e2AyEKZsP+w==
X-Received: by 2002:ac2:44af:0:b0:505:7ac4:239 with SMTP id c15-20020ac244af000000b005057ac40239mr17911564lfm.1.1697124970871;
        Thu, 12 Oct 2023 08:36:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v21-20020ac25935000000b00505723e56acsm2850999lfi.273.2023.10.12.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:36:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/5] pmdomain: qcom: rpmhpd: Drop the ->opp_to_performance_state() callback
Date:   Thu, 12 Oct 2023 17:36:07 +0200
Message-Id: <20231012153607.101465-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012152108.101270-1-ulf.hansson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
level dance"), there is no longer any need for genpd providers to assign
the ->opp_to_performance_state(), hence let's drop it.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index ec2582f7225c..a631fe1f9a06 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -743,12 +743,6 @@ static int rpmhpd_set_performance_state(struct generic_pm_domain *domain,
 	return ret;
 }
 
-static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd,
-						 struct dev_pm_opp *opp)
-{
-	return dev_pm_opp_get_level(opp);
-}
-
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 {
 	int i;
@@ -838,7 +832,6 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_off = rpmhpd_power_off;
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
-		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
-- 
2.34.1

