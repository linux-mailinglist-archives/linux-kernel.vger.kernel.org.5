Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8537FA15A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjK0Nuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjK0Nuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:50:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6CBC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:50:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a0907896so5504578e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701093041; x=1701697841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHnnOST8qodLmJFznIgEimpV+tpqmVRkoEWPEvmIUa4=;
        b=MQ8cKdK4bNOca3G7Et1zmM77SY/Ak0sQR1ArkiUBopHtmB1i0t07vcVVL1Nzo5mtGW
         ifUoi+1N5D/a3/KpQtuWOrdHZC23Sw+8hVbW4ofE+sb6PMKGXFOYgboRIFE7u6NuLoHy
         N0hpEee8gpG1cMEOy/fpt9qYYocKAeOYjN+ivAhx7YrmJSSIU6dx5lq2Vbo87RDVXc2G
         OiORGdHLWsCDvU0zHj+WJAksifhWR7fc0xFl3mCH6S+dG6R6D36cOQMa9KgWT1COgWFM
         NeEseneDVG1neSFiEs+g3+BmJE/Tf7aUDzveGJDN9Ho2MBbQQSBgOYv3ywYzQX5rwOto
         Nzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093041; x=1701697841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHnnOST8qodLmJFznIgEimpV+tpqmVRkoEWPEvmIUa4=;
        b=HgD8TVGyZm6lJXzLTgsLZ6nLbla4vLo1309ry3ghA+xICoN80VdlNEM7ZdMLNt5ggp
         2geQ58MDB6i04q1dVbW6CZ/EuCqZu0eKzqX2KRri5Z8Fd4kU3MLpZ+FxeUdeUzXznL3m
         ULlz1m+rlpSynTBKIIdWwKXaYBkAGRH0Pegi6uFwCQqhmGp54K597I/lAXynwocX6Bd2
         Gb5IvndcTAN9F6yc08BF9F2lglFbSkP/ysLhyyOIf2y6oFFww/79Appc8qR2JStLqVea
         fx8DmIBVxycQAhiaP5qB+i67QGk/NpU/VAlhNvEMUt5DTfDA9ccuyfj0GkhCC3KcMdcs
         JOqQ==
X-Gm-Message-State: AOJu0YydKscLF0KnV6mhaRHtYum8NuVMC30WrHyI2mf1mHkSLwfdZxe3
        CcPFXi8mc4O9Fs2RVujq/87plz6Zz6nyIO/aZ1I=
X-Google-Smtp-Source: AGHT+IGDiNX5D7/anI1R+Tudw4bfEQ/qcFxbTMxwrBkuAl4rMaVjucnEIl1eTqCSkKJvrItPiZdwTg==
X-Received: by 2002:ac2:4210:0:b0:50a:9fb9:91b with SMTP id y16-20020ac24210000000b0050a9fb9091bmr6551854lfh.64.1701093040398;
        Mon, 27 Nov 2023 05:50:40 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id t7-20020a19ad07000000b0050a71ac3f45sm1472663lfc.203.2023.11.27.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 05:50:39 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: arm: Avoid polling for scmi_perf_domain
Date:   Mon, 27 Nov 2023 14:50:33 +0100
Message-Id: <20231127135033.136442-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was a mistake to prefer polling based mode when setting a performance
level for a domain. Let's instead rely on the protocol to decide what is
best and thus avoid polling when possible.

Reported-by: Nikunj Kela <nkela@quicinc.com>
Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index bc3f78abb6da..709bbc448fad 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -35,7 +35,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 	if (!state)
 		return -EINVAL;
 
-	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, true);
+	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
 	if (ret)
 		dev_warn(&genpd->dev, "Failed with %d when trying to set %d perf level",
 			 ret, state);
-- 
2.34.1

