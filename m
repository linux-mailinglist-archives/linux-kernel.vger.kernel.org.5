Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6175A77D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGTHOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjGTHNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:13:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B822C270D;
        Thu, 20 Jul 2023 00:13:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579dd20b1c8so5336707b3.1;
        Thu, 20 Jul 2023 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689837226; x=1692429226;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVKm/i8teXdZv2e5QcK5beq0yMLwsXjjM3s1QCY0LCU=;
        b=QO6fax06CAuznD+VUdKHxKESSSYPNUQHHp2PWvLc83exnbiOTFIDIhpQuZ4+QsfuD6
         Zb2Yo218Mc1y2ttDp2jMWSR+VxwBnUA+v1RWFbMuzNecIyGCbaIF+e9uZWxSZfaO0OcP
         KDrbSMdxyRR+N02dScmXZrKg6prEEVz0Vu7cAcdqP69ZYsyh9C67pVfpi7WBn4qMu7Xi
         OGq9Rnn3Ktet6Q/kC8jYq2MJ1Jo8iQ/MfAew4jba1j21sMO9DZS64m0DNFrbH5R2HORl
         glZ0X6lTMWiSTAnsQDvWw/mDV9gvCW01CmRix3U7TAqmOC4IOilLBUlzLSrZToMDh4Z+
         N5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837226; x=1692429226;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVKm/i8teXdZv2e5QcK5beq0yMLwsXjjM3s1QCY0LCU=;
        b=LLbeMvsa7iL5sRo3fY7JkdpF6HM4GImtzPdDbJLZcIyYP0xydd6gavEXpdQHlq+aWL
         HxfZNYA1kDG8aIlv44yvsH1x8oz7l8CsXue4evO0ZyrHpM/Jm8BJQP/j1gM8p7USmlMD
         t7Qy407rhLuVN3/AwDX1VewyU10EHOE0WCkEqKeb1X1YR8DcugpE6VOWd0+tq8ug2alf
         K9cUegHcg3558nq3hiB3Hhwb2dQmjUwfPyTrQ6cIiFmHz1uGsxX1XEGYtA8zWHhgLtm/
         YKR7RIWb6ixFuY2iDON5l+7AVf0Cj6rtxGmHoEN0iT6GNdq54DLtUgz6pziRMSU7O7Rz
         VZ7Q==
X-Gm-Message-State: ABy/qLb6aP95dmw4yb+lfjRAODSbreqQbgKOk06k4yN1PhOUewzxOKMl
        Xwhr+nm9ZykrsH31nwRc4L0=
X-Google-Smtp-Source: APBJJlHi9fosF2chC/KD7ruAwz7Sue/UFzpCdeKStJeFJCKrHmDxDFm9ghx/eXpYn/rcBX99SpunSg==
X-Received: by 2002:a0d:ea4f:0:b0:576:8d7f:d163 with SMTP id t76-20020a0dea4f000000b005768d7fd163mr1502973ywe.8.1689837226409;
        Thu, 20 Jul 2023 00:13:46 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id j131-20020a819289000000b00570253fc3e5sm62560ywg.105.2023.07.20.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:13:45 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org
Cc:     sboyd@codeaurora.org, srinivas.kandagatla@linaro.org,
        quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] mfd: qcom-pm8xxx: Fix potential deadlock on &chip->pm_irq_lock
Date:   Thu, 20 Jul 2023 07:13:30 +0000
Message-Id: <20230720071330.50382-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &chip->pm_irq_lock is acquired by pm8xxx_irq_handler() under irq
context, other process context code should disable irq before acquiring
the lock.

Since .irq_set_type and .irq_get_irqchip_state callbacks are generally
executed from process context without irq disabled by default, the same
lock acquision should disable irq.

Possible deadlock scenario
pm8xxx_irq_set_type()
    -> pm8xxx_config_irq()
    -> spin_lock(&chip->pm_irq_lock)
        <irq interrupt>
        -> pm8xxx_irq_handler()
        -> pm8xxx_irq_master_handler()
        -> pm8xxx_irq_block_handler()
        -> pm8xxx_read_block_irq()
        -> spin_lock(&chip->pm_irq_lock) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

Fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
Changes in v2:
- Modified word usage in commit message as suggested by Bjorn Andersson
---
 drivers/mfd/qcom-pm8xxx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 9a948df8c28d..07c531bd1236 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -103,8 +103,9 @@ static int
 pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
 {
 	int	rc;
+	unsigned long flags;
 
-	spin_lock(&chip->pm_irq_lock);
+	spin_lock_irqsave(&chip->pm_irq_lock, flags);
 	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", bp, rc);
@@ -116,7 +117,7 @@ pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
 	if (rc)
 		pr_err("Failed Configuring IRQ rc=%d\n", rc);
 bail:
-	spin_unlock(&chip->pm_irq_lock);
+	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
 	return rc;
 }
 
@@ -321,6 +322,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
 	unsigned int pmirq = irqd_to_hwirq(d);
 	unsigned int bits;
+	unsigned long flags;
 	int irq_bit;
 	u8 block;
 	int rc;
@@ -331,7 +333,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 	block = pmirq / 8;
 	irq_bit = pmirq % 8;
 
-	spin_lock(&chip->pm_irq_lock);
+	spin_lock_irqsave(&chip->pm_irq_lock, flags);
 	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, block);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", block, rc);
@@ -346,7 +348,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 
 	*state = !!(bits & BIT(irq_bit));
 bail:
-	spin_unlock(&chip->pm_irq_lock);
+	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
 
 	return rc;
 }
-- 
2.17.1

