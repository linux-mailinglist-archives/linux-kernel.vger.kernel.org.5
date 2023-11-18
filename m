Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12AA7EFFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKRNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKRNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:30:44 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3BC1AD
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 05:30:39 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A17F424002D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 14:30:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1700314237; bh=ppeSPYByp7ZY04Nxe+RB15OngC/qv/0ZK9gTwKftWFc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=R25U3z2UdyDFHzSI05ePIS6J6Otb7N969k/ubFPsry/p4fPmPxXaRc3h/cmG8ed9W
         q5U0eW/IGRlzg5uM4y0HmCeuq/k2Ep7sQTG2uHD5oa/kEiphKOuiM3OmtBCGt/X7km
         XMp7x9Zd1IO2TAMJSBZKCCMqTmr7mzBTaLkAERhkJDdIoqoR2aONCwL5MsXupMGpC9
         ZMtEx+3CXhkXDDbaf4qB/Rva6m7P417ZsN8zsR6thBljP8DqGcvQ26iEPIGcZyDx4S
         vyBalMdn7zIiiIBqUkcMMjvP9Al14fJKrEkt8lk9rMg4VYRp2uhJS3TnLz5ORr142c
         gXc6JioidGwjA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SXZQh54nQz6tyH;
        Sat, 18 Nov 2023 14:30:36 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 2/2] power: supply: Use multiple MODULE_AUTHOR statements
Date:   Sat, 18 Nov 2023 13:29:58 +0000
Message-Id: <20231118132958.157238-3-charmitro@posteo.net>
In-Reply-To: <20231118132958.157238-1-charmitro@posteo.net>
References: <20231118132958.157238-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves checkpatch warning "quoted string split across lines" on:
	1640: WARNING: quoted string split across lines
	1641: WARNING: quoted string split across lines

The motive to use multiple MODULE_AUTHOR statements came from this
comment from "include/linux/module.h":
	/*
	 * Author(s), use "Name <email>" or just "Name", for multiple
	 * authors use multiple MODULE_AUTHOR() statements/lines.
	 */
	#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 drivers/power/supply/power_supply_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4a5b570dff44..ecef35ac3b7e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1637,6 +1637,6 @@ subsys_initcall(power_supply_class_init);
 module_exit(power_supply_class_exit);
 
 MODULE_DESCRIPTION("Universal power supply monitor class");
-MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
-	      "Szabolcs Gyurko, "
-	      "Anton Vorontsov <cbou@mail.ru>");
+MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
+MODULE_AUTHOR("Szabolcs Gyurko");
+MODULE_AUTHOR("Anton Vorontsov <cbou@mail.ru>");
-- 
2.39.2

