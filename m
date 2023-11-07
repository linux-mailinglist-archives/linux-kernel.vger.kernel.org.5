Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EDB7E3269
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjKGAyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGAyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:54:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB49C;
        Mon,  6 Nov 2023 16:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+jE7ou4tFave3TjR5lTzlebNRDC+nUyolnwZE03xHrY=; b=5E00zc3mJHrCjCa1Jjqugu9zfZ
        gMghqEmOlmO+V+p2vJeB3HfG3JzJV9ZcTxp/QnIoi4rxfJ8KeT8D5ZcTUEZsWlbTqvbVmLDDIlBPo
        KJtuVFMblQhMTIeYm+s3eUgX+2P5unqNUv7B20B2GkIFAqnr+ikb3ah8q5GTK0l09atGtznBrGP1v
        uAqL6She5egRliutYc29b3lPXG1r76PIvt4k0EsBT7RyM/I8UR0jQezjggZKVg8Cilourqbbh0ZY6
        P9tgoJwgUUBovm37Fb8d2VLMms1FhJ1j6tqKFhtyti6W59j9GDCY/BQY+twlZjQ5FTL+UZCyfV2Ez
        5Bd7KZAw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0AM8-000F96-2Z;
        Tue, 07 Nov 2023 00:54:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: domains: fix inappropriate use of kernel-doc
Date:   Mon,  6 Nov 2023 16:54:12 -0800
Message-ID: <20231107005412.24070-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.1
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

There is no mechanism for using kernel-doc notation on a data item
(only struct/union/enum definitions, functions, and function-like
macros). Since the comment does not add any useful information,
just drop it completely to avoid a kernel-doc warning:

drivers/base/power/domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org
---
v2: drop the comment completely (Ulf)

 drivers/base/power/domain_governor.c |    3 ---
 1 file changed, 3 deletions(-)

diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -406,9 +406,6 @@ struct dev_power_governor simple_qos_gov
 	.power_down_ok = default_power_down_ok,
 };
 
-/**
- * pm_genpd_gov_always_on - A governor implementing an always-on policy
- */
 struct dev_power_governor pm_domain_always_on_gov = {
 	.suspend_ok = default_suspend_ok,
 };
