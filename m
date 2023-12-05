Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C31806235
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjLEW6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:58:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800DB5;
        Tue,  5 Dec 2023 14:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+wPQgMtfP3e+4Wk8NNsQzADS8z91J+KBS6ktKYz5c3k=; b=SyeWcAiTZWnRR5UdV+pQOksTQV
        j/lgXABiUbfdSoeR0tkqA9lDLIYgGvkUceaJK8glrdHDycjTE6zuLCo15Giyt/MLgsCmu1hqRoAvs
        Ft2OCuPEkm/Z98RqKalBfmQJIfEcpvfsF6DLY3GnSwy4yNNYAfqbAY88SaRHTjq8pKcoVzp76aWJZ
        I+rUK5LL2bI44mLfOcaftgkqKe77YyZrfgcv3mR1xle87Qbg5JUN/FCc3oWlv3xnsRN5dUhAXw4ka
        TPz/GBNZ6LCYB4JN5RTdYtE+0lzjxKObsW6vG673UFgDibCdI42a1+DrdRHOsogx2JRInA+2nh1Fn
        nzWrp4+w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAeNU-008Z1T-2S;
        Tue, 05 Dec 2023 22:58:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM: domains: fix domain_governor kernel-doc warnings
Date:   Tue,  5 Dec 2023 14:58:56 -0800
Message-ID: <20231205225856.32739-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings found when using "W=1".

domain_governor.c:54: warning: No description found for return value of 'default_suspend_ok'
domain_governor.c:266: warning: No description found for return value of '_default_power_down_ok'
domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/base/power/domain_governor.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -49,6 +49,8 @@ static int dev_update_qos_constraint(str
 /**
  * default_suspend_ok - Default PM domain governor routine to suspend devices.
  * @dev: Device to check.
+ *
+ * Returns: true if OK to suspend, false if not OK to suspend
  */
 static bool default_suspend_ok(struct device *dev)
 {
@@ -261,6 +263,8 @@ static bool __default_power_down_ok(stru
  * @now: current ktime.
  *
  * This routine must be executed under the PM domain's lock.
+ *
+ * Returns: true if OK to power down, false if not OK to power down
  */
 static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 {
@@ -406,8 +410,8 @@ struct dev_power_governor simple_qos_gov
 	.power_down_ok = default_power_down_ok,
 };
 
-/**
- * pm_genpd_gov_always_on - A governor implementing an always-on policy
+/*
+ * pm_domain_always_on_gov - A governor implementing an always-on policy
  */
 struct dev_power_governor pm_domain_always_on_gov = {
 	.suspend_ok = default_suspend_ok,
