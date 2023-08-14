Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55A377B7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjHNL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjHNL4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E61715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BAD61FD67;
        Mon, 14 Aug 2023 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NulgZ+I3Oy7nzxJJ1bqwE8Bv2yKQrwT2tCgp2KXuefI=;
        b=ehIXL7SSEAudNuUZbYEYATRZt/Zn0E8WMcMS+DHnx8RymOXQplkIwYyXd7G67/iTbZ4KcC
        GPZtgRD4gl71hWQvPIA8I3qPiJPw80LLKyDQbsBMD92ArsEyXKatAQUpiKzmQc+F1MeItO
        EJH1BDAMcpNJoU/ecTbIZHtfiqR7IVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NulgZ+I3Oy7nzxJJ1bqwE8Bv2yKQrwT2tCgp2KXuefI=;
        b=EfIJ/1GmzqGJ1kl5lSgpJOG6OBljWLkPsKKd1pFBlMzSeJo3qtWbUM0tzkJ1POEcw3KNtL
        EPyiUzz9w1caKWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A029138EE;
        Mon, 14 Aug 2023 11:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mI25DEgW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:52 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/25] ALSA: pcmtest: Update comment about PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:14 +0200
Message-Id: <20230814115523.15279-17-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814115523.15279-1-tiwai@suse.de>
References: <20230814115523.15279-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

