Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6207B6D20
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbjJCP3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjJCP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:29:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53781A7;
        Tue,  3 Oct 2023 08:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2069C433CC;
        Tue,  3 Oct 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696346975;
        bh=HtTtHLoy/MEzOVrBl6HeLbM2k/FSWqbhpLx6b5+quR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfH+56jDO4zxiShPdqoi4Vuh7ctOnxMEghAm0nReivKZMqBx8zLfJoZmmvdCTfwDJ
         shNDol7mXZvIwlj7eRp7r+RPzrUyCVyyYyMNUJKCFIQbXkTra8L3xGlgp4cvl6BhEt
         B0l3woOTIPyump/qHTMvJcgF5qY/KUeIgTR7mH/1G5/+p4GMP0KcOzU2oRQerw6AdR
         iZDYjBQe7qwuqc/wFGB/Iram0zn1nUamZXGu7n8sWwckC2G4X+Km1hbS243Czp9lnG
         k04k9ABPRCBhzBDS31TwTQ72/Y13glbigHYdJK/bqM8/qn0dVG0SXasSgImyRImqeM
         ob+CPFEkpC+dQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhLF-0003uP-2s;
        Tue, 03 Oct 2023 17:29:45 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/5] mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
Date:   Tue,  3 Oct 2023 17:29:25 +0200
Message-ID: <20231003152927.15000-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003152927.15000-1-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using EXPORT_SYMBOL_GPL() for the revid helper as there is no
reason not to use it.

Cc: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 8e449cff5cec..ee55f09da3ba 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -241,7 +241,7 @@ const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
 
 	return &spmi->pmic;
 }
-EXPORT_SYMBOL(qcom_pmic_get);
+EXPORT_SYMBOL_GPL(qcom_pmic_get);
 
 static const struct regmap_config spmi_regmap_config = {
 	.reg_bits	= 16,
-- 
2.41.0

