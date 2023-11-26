Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0A7F9205
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjKZJj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:39:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11285
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:39:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so4286836a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700991567; x=1701596367; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OPk/i/oB8lqT1JkT4qcOFHig3Z2xZEfG6+EZza5vjsg=;
        b=IjOArQLIYqFVzSSWAqc+owsBZsPuZcOacxFTlbRlQqt2bgJhxxGCM9q7LQk6ZQov2q
         Un64IKpFSPGIWPs5a4nQv5OMlJF0XblHmfPj4HFrs7gaygFIupyv8Ib8HbMuosup40ng
         qO5eDX0AhUY63ouDiMEs/a39h20Ol6ixXKEW9j03izdLFFsJULdMj+nvYjoE67Y8x/2q
         xiem1ISD7jLJNf3rJI6JjQCHxtDGpcNPMCzhzj4hAFxkec2hmAX0NNJp4qrtBGlsiyrQ
         2B8UfaPQTU/Sv9GtBdaW8q9BCda2vw6r5XjIqw5+hXM3c2DQW42rfEeT7vkDaKXRD24H
         MH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700991567; x=1701596367;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPk/i/oB8lqT1JkT4qcOFHig3Z2xZEfG6+EZza5vjsg=;
        b=s+v7dxGOu1FT6fA/uKy+wJCT40n60CNEpfyJXmFGP5skFO85wdg4MXXVOwfnYH6Sb5
         xMxQYA+B6Q8rwpmvx0MGunxXRwT3qC5IdC1Wc3wsdLA1g8FfWKL1cu4o8Ug3u4TFRlve
         OfE+3loLjjQI8Q0a2rjNohqK5lWcRckxp+lOPm8Njc7dVdghdOYh8yV7fFPH+IC39TH7
         y8fYinvavfOrSh8iIZhzSGhzT0h7Urh5rMvkqq6v6GcyWm9jlxZ9IzXL8kBRgY4+n+5u
         CUUDo+hUieIwALDPxeLSgy4bfDmw+6SjmZ8488to9+Ryzarc2xmhmLJZF49kgvDLlL2p
         ig4g==
X-Gm-Message-State: AOJu0YyqDcModNRjSUOSJHFUkwE825DgOejMZTcdOab/aB2WwwaDxy2E
        CcHx6WPcAMeYVs4sL+rH+lY=
X-Google-Smtp-Source: AGHT+IF05ufQBW1NL0zuzt2bbZdziORnt6bX61cYIbvCWophNQcpKuWpIReGQXmI1V7PvNvb8wxDRA==
X-Received: by 2002:a50:aac3:0:b0:544:a153:cd19 with SMTP id r3-20020a50aac3000000b00544a153cd19mr4482943edc.41.1700991567497;
        Sun, 26 Nov 2023 01:39:27 -0800 (PST)
Received: from gmail.com (1F2EF15C.nat.pool.telekom.hu. [31.46.241.92])
        by smtp.gmail.com with ESMTPSA id ec27-20020a0564020d5b00b0054b14655134sm2077757edb.49.2023.11.26.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 01:39:26 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 26 Nov 2023 10:39:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] locking fix
Message-ID: <ZWMSTLo6kZ6qd6BU@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-11-26

   # HEAD: bca4104b00fec60be330cd32818dd5c70db3d469 lockdep: Fix block chain corruption

Fix lockdep block chain corruption resulting in KASAN warnings.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      lockdep: Fix block chain corruption


 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..151bd3de5936 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3497,7 +3497,8 @@ static int alloc_chain_hlocks(int req)
 		size = chain_block_size(curr);
 		if (likely(size >= req)) {
 			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
+			if (size > req)
+				add_chain_block(curr + req, size - req);
 			return curr;
 		}
 	}
