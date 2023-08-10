Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B54777A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHJOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjHJOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F8F2705
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C000365D90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED0C433C7;
        Thu, 10 Aug 2023 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677343;
        bh=TM24uN9AHGtsUilsrwg5FSsq+8PkBzf9zCmDCBK6pHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfVaivzZylAfe2Vo7lZzVKCdMWMCPe819yCAzVffAZ/7NggfFtLUheeQ3XYKEINnn
         qfLbrpn1tWj1AdB5lKjZnVH1AwVntCsN1Qz5BYGL6p5ILiU9AYG+kAG7F4dE6UI6KV
         syLekCJQQdjcinNjD9lZMlMXHzPl1k8wKN65EJ77HPaH13bCZdEHWb2HG31/5C/FEc
         9jozP4HX9GIOhIePoM5TxtpXZYk92vo3GAecrdkywky+EK48qGk2aWmGSCsaMNutNa
         /mKuEC3QiPRlxLuQP8vnDstzIBBUrv9f/HniM1dBuMA1Bqa/ArfQas1CYc0QDVvmGD
         vyqNA8jBkXHWA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 10/17] zorro: include zorro.h in names.c
Date:   Thu, 10 Aug 2023 16:19:28 +0200
Message-Id: <20230810141947.1236730-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The zorro_name_device() function is defined in drivers/zorror/names.c, but
the declaration is not visible there:

drivers/zorro/names.c:58:13: error: no previous prototype for 'zorro_name_device' [-Werror=missing-prototypes]
   58 | void __init zorro_name_device(struct zorro_dev *dev)

Include the header to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/zorro/names.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/zorro/names.c b/drivers/zorro/names.c
index fa3c83dbe8431..077114ccc8407 100644
--- a/drivers/zorro/names.c
+++ b/drivers/zorro/names.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/zorro.h>
 
+#include "zorro.h"
 
 struct zorro_prod_info {
 	__u16 prod;
-- 
2.39.2

