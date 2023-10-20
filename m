Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD07D11BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377547AbjJTOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbjJTOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:43:47 -0400
X-Greylist: delayed 138733 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 07:43:43 PDT
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0187106
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697813021;
        bh=K83F6SskCJLMqeCBk7w6O0CFlOxHTQk9Oh1VXwnu6bQ=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=ZUHL2clxRG+MPwnLwAlGNm+vCWDYPoYi4XesKmvDoPxKz54FcJMi+v6U9eIKLxNSx
         RLkYZUY0okAmgsMYSgb+F9G0id4C7Bc8p93LblAEicfiM18hDd2ZhRQK5hLvFCc+NV
         k4WuQmFX8eph8hbb6wSQ2bnnprVu24cDfHKRFKbo=
Received: from rtoax.lan ([120.245.114.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id AE3AEEEC; Fri, 20 Oct 2023 22:43:35 +0800
X-QQ-mid: xmsmtpt1697813017tr3admgz9
Message-ID: <tencent_49AFDBA31F885906234219591097D42ABE08@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCu0TFj/+Ks7ktWUvfayv2uurkgvqnyHovMHS0AUi4113gtu1fIz
         odH7cfi7qgLWd9vSrZh4Xyvw3YXJrb+zou0eOojNscTk6JxHjBDllg070sKwdX0AcrOg+Lu/vF8j
         1bx60T6nDJvETAde7g/zs7V9dcDelygJZQwIIu+eXb1Z0KDHUbh4f8avtWiGp3ZIChMU+dyCMzP0
         M47McCn4SQURXb+xPDUqkusXnqGx/K9sO5Jq9bVJjv+ppiKia5yMrHGVF2PjZvnJZwjI7052a+Gn
         PQU94362WzsBO7geGKIlD4tS8eNtjjDV5ZfR8vlofuIGR+b0/kIBaW4T9aCE5Z1OE90IlxmIBOMD
         L5Z9aylWK9GY1+YNrsVHIoxQIhYXdXCnvSsxevnEh+9vanX1QwVpgbeQREo+ph8toilGhQQBlpB7
         Sxm9GVZvC3PXRJRF/ISCG/8dAcrxvMKyBdD3H8dZcQkL0Rrgt6I89sMcBeMJo1NvngZaVEYkUGjf
         2sluDofD8ibXe6IRv82F4JAyxh5MBdbjncy3wnltrEWGB/XfsrLe4qg22vqHU7UVYds46nsMqB8w
         HS8Zt7SzQC1QPFcZJ8cLxC05kW8in7VQZK+wofBsm82mEftCM8IFYgFVt4epzfHLJKyaRDntFgkY
         1I8b3730I5aaXdKomPdOW/EAFZHDzGIJoNYqBrWuIncD9PVYbfEjZsBpeRRfksfzeGjt/jVcbRVn
         k72To2fWg6EHQkshHPBJAQ/vSVzaB7Yd7YoxPGFz8Pxql6X2HqFccMGI6XItw3HVsLdmTJxpApY5
         M8tpiqXnBXM/PMZWUUEibiWaSYmVOdRU5Y7a+C+wP29r4NUP4zkiSOOMCe8mgHNb5oXx2g2LPO+/
         TfrL2Rb0+y3cxAlhUnBFV2BcVYHTLY8HKoI9S/XBS0zX8Lrx13IXVcdznk/5tVMEwvRwizEldvjw
         cdzJdk2MhK7Tpzh1TXzOV5CHMMyia4SJZh6LQIXTgDGh7KOf6uYYUzO8YRBT5UVpbUUCwVKFyYS2
         GDMRAkJw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com, elver@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rongtao@cestc.cn, rtoax@foxmail.com, tglx@linutronix.de
Subject: [PATCH 1/2] stop_machine: Use non-atomic read multi_stop_data::state clearly
Date:   Fri, 20 Oct 2023 22:43:33 +0800
X-OQ-MSGID: <ec679f9a9877849ee649da1b355f995e71d42737.1697811778.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697811778.git.rongtao@cestc.cn>
References: <cover.1697811778.git.rongtao@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
solved the race behaviour problem, to better show that race behaviour
does not exist, pass the 'curstate' directly to ack_state() instead of
refetching msdata->state in ack_state().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/stop_machine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..268c2e581698 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data *msdata,
 }
 
 /* Last one to ack a state moves to the next state. */
-static void ack_state(struct multi_stop_data *msdata)
+static void ack_state(struct multi_stop_data *msdata,
+		      enum multi_stop_state curstate)
 {
 	if (atomic_dec_and_test(&msdata->thread_ack))
-		set_state(msdata, msdata->state + 1);
+		set_state(msdata, curstate + 1);
 }
 
 notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
@@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
 			default:
 				break;
 			}
-			ack_state(msdata);
+			ack_state(msdata, curstate);
 		} else if (curstate > MULTI_STOP_PREPARE) {
 			/*
 			 * At this stage all other CPUs we depend on must spin
-- 
2.41.0

