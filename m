Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BC77274B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjHGOPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjHGOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:15:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE3EF3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:15:37 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJGp0B1vzfbnw;
        Mon,  7 Aug 2023 22:14:26 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:15:35 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: info: Remove unused function declarations
Date:   Mon, 7 Aug 2023 22:15:13 +0800
Message-ID: <20230807141513.31440-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These declarations is never used since beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/sound/info.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 7c13bf52cc81..adbc506860d6 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -118,8 +118,6 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
 					     const char *name,
 					     struct snd_info_entry *parent);
 void snd_info_free_entry(struct snd_info_entry *entry);
-int snd_info_store_text(struct snd_info_entry *entry);
-int snd_info_restore_text(struct snd_info_entry *entry);
 
 int snd_info_card_create(struct snd_card *card);
 int snd_info_card_register(struct snd_card *card);
-- 
2.34.1

