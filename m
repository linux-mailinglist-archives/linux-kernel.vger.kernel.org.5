Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98877D2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbjHOTDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjHOTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891810DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D9751FD6B;
        Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NulgZ+I3Oy7nzxJJ1bqwE8Bv2yKQrwT2tCgp2KXuefI=;
        b=TSDiA7MeXEdjzGY6xLKrSFR8wUeLIr+uapzCpchIYhpqBzucXri8vRhTO+hjpt5sfVutr+
        LkOsIG1KGrBu9j5wZegKAUhGE6J2R/mMbZqUhlJr8f9GS6IryuylDWYg6qMoIY9yxrnVbC
        o70Z9wLdOLtVmMcot8zkCsxhfnlJKKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NulgZ+I3Oy7nzxJJ1bqwE8Bv2yKQrwT2tCgp2KXuefI=;
        b=sDpVxR73Gn8ID8RWy1yIFSPH2YsWcWBFQ8xuNhEOpRS16JDaLJaiabCcs0br3LYWvBYHeQ
        83ubIOnsMS878cDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77DBA1353E;
        Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SOFpHJ3L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:49 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 16/25] ALSA: pcmtest: Update comment about PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:27 +0200
Message-Id: <20230815190136.8987-17-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just an update of a comment mentioning the old PCM callbacks to
correct to the new PCM copy ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/pcmtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 291e7fe47893..d205e10a0605 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -225,7 +225,7 @@ static void check_buf_block(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runti
 
 /*
  * Fill buffer in the non-interleaved mode. The order of samples is C0, ..., C0, C1, ..., C1, C2...
- * The channel buffers lay in the DMA buffer continuously (see default copy_user and copy_kernel
+ * The channel buffers lay in the DMA buffer continuously (see default copy
  * handlers in the pcm_lib.c file).
  *
  * Here we increment the DMA buffer position every time we write a byte to any channel 'buffer'.
-- 
2.35.3

