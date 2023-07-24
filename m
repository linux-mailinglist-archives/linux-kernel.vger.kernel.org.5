Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49B75EC90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGXHct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGXHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:32:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080018C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:32:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8X1l6JCbzBRx57
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:32:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690183963; x=1692775964; bh=S9tFFcFdxC3EfuKS841EZfUjDnN
        6RZk4grIKnUJ88MA=; b=JNpDSiJfxvqunsECsmaImwqu58zbRVWQG1PQDcBUhmr
        UflbDfvmfrH7XhDSOSDAssxX8qJnNag8x57qDIdLQ5yxWBrWTvzVGiL9OZZVaTPD
        LEyzotFQztuGIJo21LLojjgtsSxjKJyGhFbGLWMmM6nwJ34hNLMdR6BKJ+a1avrL
        wGjP17Ppwk3/e8n01t73OKLhpUGaWqjpizx0gaSX+lVDCdguLAbcMg0BiG0yfxV5
        xgx3psQwmEskqN4t0tMCI09oW/J43nmdZxql6OhgXn2YuGK2nzAqOBrvvKzYw2js
        8N4X/VL7OYZZpR+hGq/CTFJy8AMUZVCV4CNyaJk4Qqg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h2C9NHMj4AsB for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 15:32:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8X1l4TNBzBHBPw;
        Mon, 24 Jul 2023 15:32:43 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 15:32:43 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Clean up errors in arcturus_ppt.c
In-Reply-To: <20230724073153.9003-1-xujianghui@cdjrlc.com>
References: <20230724073153.9003-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <71605c0ae02fcfd1d044aa9e52088543@208suo.com>
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

ERROR: spaces required around that '=' (ctx:VxW)
ERROR: spaces required around that '>=' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 3bb18396d2f9..c49f770c97b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -598,7 +598,7 @@ static int arcturus_get_smu_metrics_data(struct 
smu_context *smu,
  					 MetricsMember_t member,
  					 uint32_t *value)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
  	int ret = 0;

@@ -1482,7 +1482,7 @@ static int arcturus_set_power_profile_mode(struct 
smu_context *smu,
  		return ret;

  	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu_version >=0x360d00)) {
+	     (smu_version >= 0x360d00)) {
  		ret = smu_cmn_update_table(smu,
  				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
  				       WORKLOAD_PPLIB_CUSTOM_BIT,
