Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683F378B996
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjH1Ue0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjH1UeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:34:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9933F9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:34:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so34112895e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693254853; x=1693859653;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zKX7FapVDlly7OXp3p4aUNBvruUHEMEBI5wW/7+/lMg=;
        b=X+xjONnChkcJz8wdNQX4pwHVG+GN1Bch1xwQzhLV9+X/Ksic6T+j1V83WE0gPn2Nz6
         jAvd7pRPqHcTskuIZnZAXxgCIF0N9A9AGLOR/y7TEsjvRWgbSxDYY678xrJ0LEh9B1Ub
         6/aVmvpzRKXmRcYaxh32s3JipzUm1zYCDTx2OMt1As8wEuYzODRiVBORTKApr2jpgd2j
         iM2sIMU3JBuUXYLd938JjvJsrB24DTFsZ8BhOrWHYAdx+Q1HZCHL+lLqtuaZNi0dhOR/
         bLw0Rk+9eFIStp6XqYP5szNRl6sTG5edOP79UJPGHGIM5pHSCwsHEw0o78y9RahaMTRl
         BXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254853; x=1693859653;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKX7FapVDlly7OXp3p4aUNBvruUHEMEBI5wW/7+/lMg=;
        b=k1CypsnF9I08Sp0xYByqWPBJja267jaQNB1plSTQiyEHsB3/YjiZxSPgwPP/RMBm/Q
         Mbd38lRIgo6lsA2HuEBbeeVHxFlXpCr+gaW59kc8FBE7OIUCplFe5Qy6MidhsIL3WJzp
         zg203tQSyIDEOflnlZrYE87/GCUlbArNaa6LymT4EQ75CWYAJvQam6/OZt2kbx8HO69S
         D80vfX/32N44G9ppX2BHwLT3JEgrtkQMwkiaJejx0FIOFT1Aq0FWGWzd5UePfWWrSGlf
         aorfgyLhNMzvZE+swIx/46CwdMyOLrXydTipwmE6CDEVoFherkMGS9RcwVSNLvn6X9uD
         W4TA==
X-Gm-Message-State: AOJu0Ywhhk8vk+l20JuJWkjUN5rBWVOuOtjfv7GMlaL1l7PoTebYNejc
        vPiRgYkEZbe8g4B9pnmfu4U=
X-Google-Smtp-Source: AGHT+IHzMSyKqcobZ6JHawcb3x9LZ9ysD9/j6616V/2SfybOIdMcCmDLNwEgwb1wXOupl2x1hGFboA==
X-Received: by 2002:a05:600c:2157:b0:3fb:b248:67c with SMTP id v23-20020a05600c215700b003fbb248067cmr21141991wml.22.1693254852848;
        Mon, 28 Aug 2023 13:34:12 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b003feee8d4b92sm11679851wmr.47.2023.08.28.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:34:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Aug 2023 22:34:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.6
Message-ID: <ZO0EwqEtfg/iczDM@gmail.com>
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

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-08-28

   # HEAD: f66c538098b61e2eb596bb88fae90dbd2cebb378 lockdep/selftests: Use SBRM APIs for wait context tests

Simplify the locking self-tests via using the new <linux/cleanup.h>
facilities for lock guards.

 Thanks,

	Ingo

------------------>
Boqun Feng (1):
      lockdep/selftests: Use SBRM APIs for wait context tests


 lib/locking-selftest.c | 133 +++++++++++++------------------------------------
 1 file changed, 34 insertions(+), 99 deletions(-)
