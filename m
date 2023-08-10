Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E23778006
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjHJSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjHJSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:12:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677172123
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:12:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9c0391749so19703931fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691691128; x=1692295928;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbko1ie21EmrHam9zE7OmrbWipe6Zn4PD2Jb8HdIlvI=;
        b=ZXrkVJwXoMvaalWcrMIqQqkVyieuWdVsqozNAsI3wa4cGtWajQiwWuMikaxEImsXA8
         ra7Gba3+QHfB96/Yq+nAhmELTf4d9xeCfE+Lv7BA4oy3aNSD/IJl79pmE4ulzdV98QT+
         6wfP3fLdijjTV7Ftjvf4v0fqUvADIYqZiIvm0SPRdGdRZRynuoP7OmlTma5nfHDzm47K
         5ulRlMjPwtDp2mX5iviVudPwUk1KNLkL6ZIF76x5togadcVSIj5G0TjrfUPeFnhrYgdY
         OrRNiD/lO8vX9ZMQPD3i3cm03Ik6JPgCexNd63LuPBtv1gHWIw886kn9gs7yAbtS+P1U
         EFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691128; x=1692295928;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbko1ie21EmrHam9zE7OmrbWipe6Zn4PD2Jb8HdIlvI=;
        b=JR2SqSh5HPgtuzoTTY13+4IWVFDffAYAUpJn6wqgxwhVUm/aeDpoWFPRl8sz/hdd7S
         7ZM7fL0qcf0gej8JPfCxUibEL6dwk5onOBNTwDtRWfkV7fYdi2eg0MK3s4NEyP2nKZqP
         +efVF2A8M/4u5ZsQ/EyAykfnndeL0NyjLMKEtUB9ORXMaLAVxKgGQub5Hw+p1YdTfMtq
         a9F4S/U1ZXzxf1qTgRViLRtsQIF9+gyhctu8/0CdEbgmLkUtXAXOOSidVB4bKUgNJesR
         NGedgsJp9DkJ5AeZdRZmSAZvLhxZmBcLl0FYgkdUJ9msi7M4+pe4b+C3a5yodWEZh80t
         55Zw==
X-Gm-Message-State: AOJu0YzFUuuXfi9vObZUD94TUyzjpxk4B9Ww4OyG07ERolgHs4MSuVUa
        iJacY2LZiOuc81bnLJr2oLsJSkKW4Rca0HSYNGk=
X-Google-Smtp-Source: AGHT+IEwP7fzvIS0NEzTzMO1heFpeKEKZ7p3yiRnTAYgiv0QUz/QETCEH9UHAyRhmI+7NIFrAq2X8Q==
X-Received: by 2002:a05:651c:238:b0:2b9:5eae:814f with SMTP id z24-20020a05651c023800b002b95eae814fmr2404041ljn.50.1691691128330;
        Thu, 10 Aug 2023 11:12:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id n19-20020a2e7213000000b002b9f239df62sm457621ljc.74.2023.08.10.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:12:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 10 Aug 2023 20:12:03 +0200
Subject: [PATCH] cpufreq: mediatek-hw: Remove unused define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-topic-mtk_fixup-v1-1-88022eaea0ac@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHIo1WQC/x2NUQqEMAwFryL5NtAqhV2vIiJtjWtYraVVEcS7G
 /yc4Q3vgkyJKUNTXJDo4MxrENBlAX6y4UfIgzBUqqrVRyvc1sgel+3fj3zuEUkPzn+NMbUZQSp
 nM6FLNvhJurDPs8iYSNbvTdvd9wPmgW6fdgAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691691127; l=878;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ifZhDFap5bks4IWvBGc5lYMz3WsqWbWti71CuknCvOE=;
 b=L/I2QS1YREUvkMZGYEnL9kfATn0rRfKSXj0r+utNJGyDY2HdOOKua0fKaNfRDyEP96V1DtNrQ
 rwSt/HYJlYTAmNA3YTbUjlTGse9mcnLmkWpthz7Y03g/RioQSXLEWVK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DYNAMIC_POWER does not seem to be used anywhere in the tree, remove it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index fef68cb2b38f..a0a61919bc4c 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -313,8 +313,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
-#define DYNAMIC_POWER "dynamic-power-coefficient"
-
 static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 				    unsigned long event, void *data)
 {

---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230810-topic-mtk_fixup-e1dbc955535f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

