Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228697FB25C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjK1HJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343699AbjK1HJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:09:08 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB835182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:09:14 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-58d54612d9cso1546069eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701155354; x=1701760154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DfVtya4RBsfO21aPZQimz87Ty2xKQDd/O6zJS+ytuc=;
        b=BrkX1gFFbVKElH0gabTl1nw2cvkPGbYPoO0dTp39wLntPiyY/Xi1yew3opTJe5gQSl
         prN3QNlqBWAv1rPjoVsFHKS6Oqvn6ttSfEvsN0zN6fomGBRdulnfGHcYuc7Sr+xGpscN
         H5siQDf6kJ5YQa3D1VXRlpNs8hGc+kv7Q7wn2UGmI1P8opQWUtZNi1pqHh0KfCrJnzE/
         JDhmQa6gKg/UczkneuvHC80zEjF3gQIWTRI71N7oa+ADOEDbC4WyjqiY92ipLUpoVllh
         lQZ/YGVUBECVbtItcf8g1I0F88rtK8t6Z9Wb8GyjH7Vpku7U4wqZGW6De/jHUariA5+q
         vQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155354; x=1701760154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DfVtya4RBsfO21aPZQimz87Ty2xKQDd/O6zJS+ytuc=;
        b=vvJiQztWOwwgD5XNLjwPN6EF6Y2RP9KP/76pBCrEhdxeUsl3680l4Jgk7+8A7CjRVW
         RIX/FaH4wZFvjkDfWHdnXdcg89o6g5XpiNBetLN3VcTJ98A4ZxpOSPF7KGUvsLHQvH7j
         Af6StH5rGnGql4ZhXr1RoSXmeWWD0kRqI/CiMc79Prg1jDm0d9YvbshVW3x1/uLVYgBn
         ML0Hzg0rs7YQBQ6RgBOgOcllpndcU4w8lFS5779TjGpZ6lS1pOHw6MIr3DDJsA34coQ9
         HcCQIT4bgWgtuSHmJpUhFQnxgbxsbhHzxXpL2N257qIEsFGN97k8+jxxvNd0wCI55jqm
         KWPQ==
X-Gm-Message-State: AOJu0YwesOh3sCz2AT8kyI5ndvefZOhSr+nBhRzcyAZ/U/EpZQouY7jB
        SfaQ1/iKIPsICDXpjXV7pyAxeQ==
X-Google-Smtp-Source: AGHT+IH7FQgKd0fBaTnW20DKZfN/lO92e7D73F9a16o4SUVO0itFXdjiYg1ryLnRHh7o+XxouhfCAg==
X-Received: by 2002:a05:6820:60a:b0:58d:9c58:428e with SMTP id e10-20020a056820060a00b0058d9c58428emr4726750oow.5.1701155353956;
        Mon, 27 Nov 2023 23:09:13 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id o18-20020a63e352000000b005b1bf3a200fsm9070147pgj.1.2023.11.27.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:09:13 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Check for invalid OPP in dev_pm_opp_find_level_ceil()
Date:   Tue, 28 Nov 2023 12:39:06 +0530
Message-Id: <51b7d5dec3d4f3a677b355b12fac9dcac63828cf.1701155328.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_find_key_ceil() may return an error and that must be checked before
passing the same to dev_pm_opp_put().

Fixes: 41907aa4ae37 ("OPP: Level zero is valid")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4f1ca84d9ed0..c022d548067d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -808,6 +808,8 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 	struct dev_pm_opp *opp;
 
 	opp = _find_key_ceil(dev, &temp, 0, true, _read_level, NULL);
+	if (IS_ERR(opp))
+		return opp;
 
 	/* False match */
 	if (temp == OPP_LEVEL_UNSET) {
-- 
2.31.1.272.g89b43f80a514

