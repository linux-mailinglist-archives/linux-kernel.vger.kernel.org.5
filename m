Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC87075BF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGUHAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUHAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:00:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92F32719
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:00:19 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6gFG1llgzBRDtW
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:51:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689922274; x=1692514275; bh=qgoRVZJ5UPM8I4JL2ASPKtZbKEH
        PPt1Pqb5QUXsg76g=; b=zUPwB8WllMvdQeGR1ge5ZfgOSAqC8f1hoLyXiBllzhc
        71RZQjtTGGGB7u5nn2viBD9sBZDnncmTDMaZZGwLwQ6YWBU/OnofVZsGCqC+Nqt9
        kJdv+KSoiuOlt1WqpYJ3ZFlrx6THuGoggvUA54nPCpO71dFiaRyPPF+WCAYN8i7m
        WjfPAP5wA+1jRdF0SXvEX2c/YB2sMvysuZxFWT2ORAZWaWnZ0A2DKjP85mcwWK/5
        4+oc+/BnZd/edkNozU2yA1uQtO0OqNVBVvtevZ/mbg/fERtbYWbFIs0ML9PASdVu
        RYkwITXKGxg5D1foN58Ip7HKLJezaXVRAFghuqIOujA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YxI4UvXxbAjL for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 14:51:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6gFF5gh4zBRDrN;
        Fri, 21 Jul 2023 14:51:13 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 06:51:13 +0000
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <696ea9a46762e16d993f8fc4bf26fb7f@208suo.com>
References: <20230721060919.5133-1-xujianghui@cdjrlc.com>
 <696ea9a46762e16d993f8fc4bf26fb7f@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <d6f31f5ef758427e95a31892ff153f8c@208suo.com>
X-Sender: sunran001@208suo.com
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

Fix two occurrences of the checkpatch.pl error:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
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
