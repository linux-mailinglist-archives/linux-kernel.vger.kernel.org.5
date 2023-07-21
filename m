Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA92D75BF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGUGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGUGxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:53:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213082709
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:53:07 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6gHL6TQGzBRDt0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:53:02 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689922382; x=1692514383; bh=bE2eoiKcgHV8FnTvBqMi4GoMdW6
        Ca5I52TBEIsR7l3M=; b=Bw0EtnLOPRDoAQ2p0VNxqxonBZE4TRQ2vhmAEptd0gz
        EpPK10M3nXr+j9w9thX/Ng+vxW5gpX7ziXn2f9+ddycgvyreg3JXyhcMkIRgPFAC
        M44873S2dafeCKqEbN41U+QcM1UfmxzoGTGWaLjlumXFY40kZ5VMuR620Tds0IeX
        XJDu4Tdu/1/bSfgUlz6eoGdnTin8SCme6AP0nYtK3azllkHZKuDlBNBkjXWsLRJk
        lwWYQo+oDrnI+KBrE4jqDjmm9jBorxCvNfpRPlnorOxfJf2L3Nb+GkzMqPzFg6g5
        zg5POFdoju+uZkIhIE1WBA08m3je9DOfqhy1/hvzZPw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sIgKBPdp-TSs for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 14:53:02 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6gHL3vjbzBRDrN;
        Fri, 21 Jul 2023 14:53:02 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 06:53:02 +0000
From:   sunran001@208suo.com
To:     alexdeucher@gmail.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230721060919.5133-1-xujianghui@cdjrlc.com>
References: <20230721060919.5133-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <19d2a2414f4c2422a13ee74b502d484d@208suo.com>
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

Signed-off-by: Jianghui Xu <xujianghui@cdjrlc.com>
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
