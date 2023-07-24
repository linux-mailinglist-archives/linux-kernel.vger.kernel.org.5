Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045AE75ECC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGXHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjGXHtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:49:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5BF1A4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:49:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8XNl6M0XzBRx58
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:49:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690184951; x=1692776952; bh=vVJ3bb7oMBjSr1+hADUC18TYJ4B
        8OELU7j0ImBjB188=; b=AEIBg110l0BbLzgJd6nPytBbDM69Vbgy04pv8tHC2YP
        hNelaIt3d/efZCLpNVu/CzCqwfxjFQ/hjstWAXCGq5WAWGmYXkN1czq9OurgBVLd
        r70n0WF3bW6QJrrN/BJVzUWkm3QKyD27XXg4CbrGAUbkk+waLvNE6Fyj3xp6IQ3N
        MAprRne3s0xPaNi8JmM/K+WMZPG5113fYPo352pC1Edn0gK6q5xDdKRQR5Jg7C8/
        OMdS6QOsKdJWg5W8skBWHWnb67ZT1Uzl7kt13816WTP3STUdROg3loqRhhG0Uqp1
        5kQThPqSImZ/3HZT81FPVTn5GzWayXGJXiqGoZ71NWA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c5wqdFTEt1V6 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 15:49:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8XNl31xyzBHBPw;
        Mon, 24 Jul 2023 15:49:11 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 15:49:11 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Clean up errors in arcturus_ppt.c
In-Reply-To: <20230724074800.9099-1-xujianghui@cdjrlc.com>
References: <20230724074800.9099-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d6c3b91864b9f3f90d8a2d3cd952bada@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..b26e9ac1ac30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -691,7 +691,7 @@ int smu_cmn_feature_set_enabled(struct smu_context 
*smu,

  #undef __SMU_DUMMY_MAP
  #define __SMU_DUMMY_MAP(fea)	#fea
-static const char* __smu_feature_names[] = {
+static const char *__smu_feature_names[] = {
  	SMU_FEATURE_MASKS
  };

@@ -927,7 +927,7 @@ int smu_cmn_get_metrics_table(struct smu_context 
*smu,
  			      void *metrics_table,
  			      bool bypass_cache)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	uint32_t table_size =
  		smu_table->tables[SMU_TABLE_SMU_METRICS].size;
  	int ret = 0;
@@ -969,7 +969,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, 
uint8_t frev, uint8_t crev)
  	struct metrics_table_header *header = (struct metrics_table_header 
*)table;
  	uint16_t structure_size;

-#define METRICS_VERSION(a, b)	((a << 16) | b )
+#define METRICS_VERSION(a, b)	((a << 16) | b)

  	switch (METRICS_VERSION(frev, crev)) {
  	case METRICS_VERSION(1, 0):
