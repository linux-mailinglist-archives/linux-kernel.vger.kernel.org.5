Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C247E83FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbjKJUcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjKJUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:31 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808893E8;
        Fri, 10 Nov 2023 00:20:56 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1C6C3100056;
        Fri, 10 Nov 2023 11:20:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1C6C3100056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699604455;
        bh=dVQtaNyPN9nUWE3NWOdgUjTqXOPqcFthjjE7iq861T4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=DcVrmpnOlw1zROFqaS/aS69Wnasdnyfdch2TbHfxi8HEk4dudUsr7yKxXHZQNmVzp
         e8lT9mrx8tRV5D06Nsas7IuyCI1G2/dGLjUgitFXOtUv4JAKF6OapF7IF5BVRZ2jkJ
         1rFao1wZ0UR2zsx79tdsE9TpQIPB5nlUpg2S5Jb6qisgS/byhI1bpdmrVQ6cc3MMv0
         YdOFKaKw+gpjGEzjH2rYtbBxGibakbTI9ayhjh/sIchqp3+T7KDWDYD3HnYcCb8vRB
         ssp4lk1LG94GoO2rwKweS6JsJfhfDevRP3ePZcyvkdxZL9iejAk3ddp/ctN/suPocG
         8s3Q2EzbPIrIQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 10 Nov 2023 11:20:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 10 Nov 2023 11:20:54 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 3/3] mm: memcg: add reminder comment for the memcg v2 events
Date:   Fri, 10 Nov 2023 11:20:45 +0300
Message-ID: <20231110082045.19407-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231110082045.19407-1-ddrokosov@salutedevices.com>
References: <20231110082045.19407-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181265 [Nov 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/10 05:52:00 #22426579
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maintain the correct state, it is important to ensure that events for
the memory cgroup v2 are aligned with the sample cgroup codes.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..d088b63740c2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6555,6 +6555,10 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+/*
+ * Note: don't forget to update the 'samples/cgroup/cgroup_v2_event_listener'
+ * if any new events become available.
+ */
 static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 {
 	seq_printf(m, "low %lu\n", atomic_long_read(&events[MEMCG_LOW]));
-- 
2.36.0

