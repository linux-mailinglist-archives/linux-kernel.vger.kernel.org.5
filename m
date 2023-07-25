Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A5760CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjGYINg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGYINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:13:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC53DE59
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:13:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R98t96NzjzBRydL
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:13:21 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690272801; x=1692864802; bh=YgqX7QCncubAlbC1mLbNMV/XhTM
        zTbCKkfaV7JVxeTg=; b=J6dRdyKwp5IddTSZTbVGzgAIBqEK2UsdSEXy/8lwV5F
        B1RG5NWXaDTj2nmwjqhua9ES/ISpf55f1HR6aiIqiBR1E1WT1piRADBx8fQXt6P1
        Bu6iJRp70a/8ILkUmhcR2HVkRGNXArFxYHq1bKpCF+TLnsh7yd9j3ejPKxV+XdNZ
        xfZ42r4ZwrZBikFIIjyUbwIT8gCJu/24+0qaxHhnlOwKiKEdvlDaR0X9jB2OlLO9
        V6LLDva/+OHLX7vOlC6MUHk58iNP5rclAMF0W01KPI0aS/+z0flLlGaWYXff7SO9
        Ych444o99J4QiYIgRUcsvaroZkArIYQ5Ck3IemoI+NA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5d93SOtzp_0V for <linux-kernel@vger.kernel.org>;
        Tue, 25 Jul 2023 16:13:21 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R98t94CJzzBL0tD;
        Tue, 25 Jul 2023 16:13:21 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 25 Jul 2023 16:13:21 +0800
From:   wuyonggang001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230725080906.2028-1-zhanglibing@cdjrlc.com>
References: <20230725080906.2028-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <b5933d7391b8e526894316b7e17b9637@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error(s):
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/gpu/drm/radeon/atom.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c 
b/drivers/gpu/drm/radeon/atom.c
index 11a1940bb26d..93acb0e42bd6 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -68,8 +68,8 @@ typedef struct {
  } atom_exec_context;

  int atom_debug = 0;
-static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t * params);
-int atom_execute_table(struct atom_context *ctx, int index, uint32_t * 
params);
+static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t *params);
+int atom_execute_table(struct atom_context *ctx, int index, uint32_t 
*params);

  static uint32_t atom_arg_mask[8] = {
  	0xFFFFFFFF, 0x0000FFFF, 0x00FFFF00, 0xFFFF0000,
