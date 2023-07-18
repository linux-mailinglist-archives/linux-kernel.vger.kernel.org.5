Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67DD75714B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGRBQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:16:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAFFED
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:16:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4gyh3X8mzBQslB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:16:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689643004; x=1692235005; bh=J9z0K2+84DoDvde/ssEFJqweBjV
        qXi6Xd6ylgi3yydU=; b=cygc5OSx4DQqdNr/TS9dPcht/aJjAf0RzQxefAWwEUS
        mrYDNaurzcOvvqIbEm04d3O96WSoBKlGXjx3Xfc4KOKQEP5hvlMPIwapKMk5XCM4
        t9FC3LkNwdXFQ0+7DOwEEemUU0Oa4saxJ8PgLOfrN9vd+zWJrCtSKnUfPCJ8DRv2
        7oS+hnipJvIaKmhyfecBRbkUJ2cXPyJFqKQBvEfjQPAufYambmj+hvFtnoeXBOR6
        /TymHkfS4VrTsJnBHBha8KZ39+93xIlgvZYJqpcJgrG1wlSejMka4914CqkqYZn+
        egH2FuTs46zkox3QZZmEw2WJoPeoObvu/VfU+PB/p6g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MMiV7w4194kA for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 09:16:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4gyh0c7lzBQsl6;
        Tue, 18 Jul 2023 09:16:44 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 09:16:44 +0800
From:   shijie001@208suo.com
To:     geoff@infradead.org, perex@perex.cz, tiwai@suse.com
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ps3: Fix errors in snd_ps3.h
In-Reply-To: <tencent_2130AC270179617F92DB16AC98CB57239507@qq.com>
References: <tencent_2130AC270179617F92DB16AC98CB57239507@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <4141ec70d3f6115eee4b14a914dc5e1c@208suo.com>
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
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  sound/ppc/snd_ps3.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/snd_ps3.h b/sound/ppc/snd_ps3.h
index 8b554a79bc14..63bdb8ee3953 100644
--- a/sound/ppc/snd_ps3.h
+++ b/sound/ppc/snd_ps3.h
@@ -69,11 +69,11 @@ struct snd_ps3_card_info {
      /* dma buffer management */
      spinlock_t dma_lock;
          /* dma_lock start */
-        void * dma_start_vaddr[2]; /* 0 for L, 1 for R */
+        void *dma_start_vaddr[2]; /* 0 for L, 1 for R */
          dma_addr_t dma_start_bus_addr[2];
          size_t dma_buffer_size;
-        void * dma_last_transfer_vaddr[2];
-        void * dma_next_transfer_vaddr[2];
+        void *dma_last_transfer_vaddr[2];
+        void *dma_next_transfer_vaddr[2];
          int    silent;
          /* dma_lock end */
