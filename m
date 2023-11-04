Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A37E0DA0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjKDDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDDkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:40:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B62BF;
        Fri,  3 Nov 2023 20:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=U+9D1UD9cowPYuIICmEuA0h3GjH5Xsb90babyNblpd8=; b=o155olG8sm8yhfnbz+GMwiRvKK
        f/1s4DlOyjhKgr6l9y+Gb51R+W4Yn6/JyW+7Z4cKsVmacdl+PB+XnsCrM8cWzb9HsDEb59izObFsf
        i1krlaXvpPG8DFCv31d1GB0CytF0WeLbZJSWNr5qAfwHHUp+RjvLIH7KPflqtOtnWjRaUn1smmoWF
        EDqzGqJue8NCbwKILNO1sHV+0KTePiI0YcXqkRmXUmo8ZXBJuRwUbtVU2FNijSCFc8ra7zW/2+8ox
        9Dp2Zrz5Ycq+Z9Ymw2m4eueWQQFuTSGWJ5zOLkKzfYLEtrezrSmq5wpylGYIoWEIwWySzNkf69YdD
        Z9MgMP9Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qz7WT-00CZjk-1x;
        Sat, 04 Nov 2023 03:40:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH] PM: domains: fix inappropriate use of kernel-doc
Date:   Fri,  3 Nov 2023 20:40:33 -0700
Message-ID: <20231104034033.14926-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no mechanism for using kernel-doc notation on a data item
(only struct/union/enum definitions, functions, and function-like
macros), so convert the "/**" notation to C comment "/*" notation
to avoid a kernel-doc warning:

drivers/base/power/domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/base/power/domain_governor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -406,7 +406,7 @@ struct dev_power_governor simple_qos_gov
 	.power_down_ok = default_power_down_ok,
 };
 
-/**
+/*
  * pm_genpd_gov_always_on - A governor implementing an always-on policy
  */
 struct dev_power_governor pm_domain_always_on_gov = {
