Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AC757129
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGRBC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGRBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:02:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F5095
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:02:17 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4gdw558TzBQsl5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:02:12 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689642131; x=1692234132; bh=lRAf8pvgVJE37sbYG4AkQgI1mkz
        Em8ZxZlvvn5AiZxs=; b=CJh2plWWnXG1MKV0UKNjkuHRJ0wLe6z6hFnwFQQStU7
        49O9PtNtbw42uTTAVyQtwY4aEmzsEcz9Ix6czkui+hE47HWfM7f4ls44TCnojvNl
        YEKamI8gehhEefX5af6rKJ16qwF68Rve/TjGOy3GKErh1rA6GmvM62x9cPiHmkB8
        PLvi2gtCRd0LeO+vIROMxkIs9wkrTS09w6FptD481u53gwrfZUAMHvP6F62SmqdJ
        LMH9hA/o8WiLhFAWbW786EfddrtdNzBGcDZQJsHG2AKdyfCrxnCy/7t+iAc/cq88
        L+0QMFaC8szF1CnUyumvx5/O1eg8WYszJdJlIpI2BQA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MomEJgrcTGG4 for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 09:02:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4gdv4YTZzBQsl1;
        Tue, 18 Jul 2023 09:02:11 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 09:02:11 +0800
From:   shijie001@208suo.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: gus: Fix errors in gus_mem.c
In-Reply-To: <tencent_A8FDB76658AA971B46D1614E4FE8F214FE08@qq.com>
References: <tencent_A8FDB76658AA971B46D1614E4FE8F214FE08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <49700e1a2452104bb89fcdca291fd429@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: trailing whitespace
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  sound/isa/gus/gus_mem.c | 24 ++++++++++++------------
  1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index 3e56c01c4544..00c73c0b068f 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -11,11 +11,11 @@
  #include <sound/info.h>

  #ifdef CONFIG_SND_DEBUG
-static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
+static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
                    struct snd_info_buffer *buffer);
  #endif

-void snd_gf1_mem_lock(struct snd_gf1_mem * alloc, int xup)
+void snd_gf1_mem_lock(struct snd_gf1_mem *alloc, int xup)
  {
      if (!xup) {
          mutex_lock(&alloc->memory_mutex);
@@ -67,7 +67,7 @@ snd_gf1_mem_xalloc(struct snd_gf1_mem *alloc, struct 
snd_gf1_mem_block *block,
      return nblock;
  }

-int snd_gf1_mem_xfree(struct snd_gf1_mem * alloc, struct 
snd_gf1_mem_block * block)
+int snd_gf1_mem_xfree(struct snd_gf1_mem *alloc, struct 
snd_gf1_mem_block *block)
  {
      if (block->share) {    /* ok.. shared block */
          block->share--;
@@ -97,7 +97,7 @@ int snd_gf1_mem_xfree(struct snd_gf1_mem * alloc, 
struct snd_gf1_mem_block * blo
      return 0;
  }

-static struct snd_gf1_mem_block *snd_gf1_mem_look(struct snd_gf1_mem * 
alloc,
+static struct snd_gf1_mem_block *snd_gf1_mem_look(struct snd_gf1_mem 
*alloc,
                           unsigned int address)
  {
      struct snd_gf1_mem_block *block;
@@ -110,7 +110,7 @@ static struct snd_gf1_mem_block 
*snd_gf1_mem_look(struct snd_gf1_mem * alloc,
      return NULL;
  }

-static struct snd_gf1_mem_block *snd_gf1_mem_share(struct snd_gf1_mem * 
alloc,
+static struct snd_gf1_mem_block *snd_gf1_mem_share(struct snd_gf1_mem 
*alloc,
                            unsigned int *share_id)
  {
      struct snd_gf1_mem_block *block;
@@ -125,8 +125,8 @@ static struct snd_gf1_mem_block 
*snd_gf1_mem_share(struct snd_gf1_mem * alloc,
      return NULL;
  }

-static int snd_gf1_mem_find(struct snd_gf1_mem * alloc,
-                struct snd_gf1_mem_block * block,
+static int snd_gf1_mem_find(struct snd_gf1_mem *alloc,
+                struct snd_gf1_mem_block *block,
                  unsigned int size, int w_16, int align)
  {
      struct snd_gf1_bank_info *info = w_16 ? alloc->banks_16 : 
alloc->banks_8;
@@ -177,7 +177,7 @@ static int snd_gf1_mem_find(struct snd_gf1_mem * 
alloc,
      return -ENOMEM;
  }

-struct snd_gf1_mem_block *snd_gf1_mem_alloc(struct snd_gf1_mem * alloc, 
int owner,
+struct snd_gf1_mem_block *snd_gf1_mem_alloc(struct snd_gf1_mem *alloc, 
int owner,
                         char *name, int size, int w_16, int align,
                         unsigned int *share_id)
  {
@@ -210,7 +210,7 @@ struct snd_gf1_mem_block *snd_gf1_mem_alloc(struct 
snd_gf1_mem * alloc, int owne
      return nblock;
  }

-int snd_gf1_mem_free(struct snd_gf1_mem * alloc, unsigned int address)
+int snd_gf1_mem_free(struct snd_gf1_mem *alloc, unsigned int address)
  {
      int result;
      struct snd_gf1_mem_block *block;
@@ -226,7 +226,7 @@ int snd_gf1_mem_free(struct snd_gf1_mem * alloc, 
unsigned int address)
      return -EINVAL;
  }

-int snd_gf1_mem_init(struct snd_gus_card * gus)
+int snd_gf1_mem_init(struct snd_gus_card *gus)
  {
      struct snd_gf1_mem *alloc;
      struct snd_gf1_mem_block block;
@@ -255,7 +255,7 @@ int snd_gf1_mem_init(struct snd_gus_card * gus)
      return 0;
  }

-int snd_gf1_mem_done(struct snd_gus_card * gus)
+int snd_gf1_mem_done(struct snd_gus_card *gus)
  {
      struct snd_gf1_mem *alloc;
      struct snd_gf1_mem_block *block, *nblock;
@@ -271,7 +271,7 @@ int snd_gf1_mem_done(struct snd_gus_card * gus)
  }

  #ifdef CONFIG_SND_DEBUG
-static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
+static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
                    struct snd_info_buffer *buffer)
  {
      struct snd_gus_card *gus;
