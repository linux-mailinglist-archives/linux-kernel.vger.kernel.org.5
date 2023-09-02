Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4279074B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbjIBKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:18:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612CDE42
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:18:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31977ace1c8so2427384f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693649919; x=1694254719; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cPjsAQl04XnhZxl0NHYlFpZiPiUV/HBAEo5z2OviaQI=;
        b=dfsurfWhJDAjO0WtpZSItNVtAJoxkNfcDxeSSNpT9h71qDruZcwe954xocV13yutTG
         1EZK5X4iXNO9Qes0x0iLtVgc0J7mSXpvJj5Ic/2hv8bHzBnu/73xVwJ2Zf3bAaxD93VO
         Qk641yDDQcoGIQ/XvXzXDLwOhEoldOT001ZlocSpBE8VnfxK3J4yIZHFvo4znC+CRD11
         ub+QX0limtPclIqhsAl3qwxfDEBqYve/ylTyq+blVR6MjFyqUMjmJDAmAuKSKuyUdfUp
         J8jkeF0EQZJSl3qVvjqGjC5SVFAHBqPbaHbk7sogTpr9EXbRWVoA5coZ29JaYZud7IDC
         nbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693649919; x=1694254719;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPjsAQl04XnhZxl0NHYlFpZiPiUV/HBAEo5z2OviaQI=;
        b=L6XNUQZXQ4RYnzXua+HKzn0Ttx1yEtr4m+H+bqoD1LkQiu23iAHR4NcdXbGA5Fx7cu
         RMV4xfbiOqcNH6gKMqT1G+LOyL3hcZEt8IkeL9H18PlEYI0Vkx1R4ihFE1u8VR8TEt0J
         f5vkRkToEvcC7y0y1lNn7hmYfq34FoNXfiZQfANoEQrxeIHA9EAUqUbobC2UQUOAcL10
         NDMEpl8IpWBiAhWH85eYE93DTcMXq4n7FqzJ5DR/lGfcomvQ0AKdfNLEgcmEF7b6Q4mA
         iO8yUfcp0a+981r9vcMfFsdrDxjebQFfal6P46V2wo6onGTFiGWrKGWuLuIfG2D++9Ry
         Xy1Q==
X-Gm-Message-State: AOJu0Yy3j/2mbx2JaXScll0TZE+F7XNW2asQlkZBXDJ8OmqkCLPZhKBi
        2E1wNvO0Se769Rv62z8SQqU=
X-Google-Smtp-Source: AGHT+IFJ5hpWjYuxIZYYcAu9KkIOtrQ/EkSkPlT9mPXIRNLRQ/KqyF4Exos/lYX2nHO+IOJIGfaHDQ==
X-Received: by 2002:a05:6000:10:b0:319:8261:2087 with SMTP id h16-20020a056000001000b0031982612087mr3346566wrx.43.1693649918763;
        Sat, 02 Sep 2023 03:18:38 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id h18-20020adff4d2000000b003141e629cb6sm8022621wrp.101.2023.09.02.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:18:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:18:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timers fix
Message-ID: <ZPML+/Q7TpgLCQfB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-09-02

   # HEAD: 96c1fa04f089a7e977a44e4e8fdc92e81be20bef tick/rcu: Fix false positive "softirq work is pending" messages

Fix false positive "softirq work is pending" messages on -rt
kernels, caused by a buggy factoring-out of existing code.

 Thanks,

	Ingo

------------------>
Paul Gortmaker (1):
      tick/rcu: Fix false positive "softirq work is pending" messages


 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4df14db4da49..87015e9deacc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1045,7 +1045,7 @@ static bool report_idle_softirq(void)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-	if (!local_bh_blocked())
+	if (local_bh_blocked())
 		return false;
 
 	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
