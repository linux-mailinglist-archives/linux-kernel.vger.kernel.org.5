Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A87DE716
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbjKAUJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:09:49 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B9DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:09:46 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f04c5ed8d7so64899fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698869385; x=1699474185; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IeufSj0n6hMJbgpG5/8Ozo6xGL5uwP7BoRuRS4U9yYQ=;
        b=ZrtTJ3HeZ7tVRqf/w4JlscIoUFdJj1SnMFMFTJZ114agIBD/66EN31THT8oVnWsB/U
         Bdfs2b5es92S9naYpNzF4qs+O4EpM/kJWHIfihVPu/4DB4lyCR6kNT/J73BAaF0HnLV1
         I/tCMdBDepHFaNJ8wAVBD8vtVSyFC0l4zSFvzmmrRCmhTS66/KokDhQCXAUpRmcGDg/f
         oA7Yqv2UscRP8NxiUfFfGIkMDQeimpmqhwujbJofnlHRsJO9SlS3C56PGi2zV8YeRpDd
         L0Gr8oGsAP/d4jAiFnmtkwOPlA/5OvCzW1/64yz072Tv75GIS9cYKO+kMSG2YennmDbG
         AXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698869385; x=1699474185;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeufSj0n6hMJbgpG5/8Ozo6xGL5uwP7BoRuRS4U9yYQ=;
        b=rmppWxG9Y1N5Nw3ZB2CkXYfbDsQPZDWyhCOQHIzo4BrGmUf0pSoCCDvpF9573Lzjl0
         9EvxKCJMh0GNXU98ejytcEbIOAwP2QuOquRvSEESVnREdgSxb4kyUeuRJiKGlgmgJeoL
         RO1JV9m5mR0UJjtgRwFpvJArfmY91QxMJgdHzaqsRIGYZ741ryV4c8gvNDbYcWI93S1b
         qfGkrth29RLrSA7vHq8dOoXSnseQVg01Fk/T6vDkZfqFJaCfjnRaOFwcaqGrl0WwcIiZ
         Lw8z+rTQFUpxaXtHgaN+A8GJUQGh4sTOaY4R/pAZaYD/27cCxJoBfMXLydZmu6sXLk5W
         ScJw==
X-Gm-Message-State: AOJu0YwjtuSz6liWH505BV3F1314zktRPmLf64AsfNXDTq02m6l8rkxG
        dvZZ+zMqKobito43OW9qJg==
X-Google-Smtp-Source: AGHT+IEd6UQ0Ln42FZfBQMeNQF+AaOIGY8fS/cR2U3qjwR0Kt3SjLxLjX6Dj9zpHTiPFunkR6w+YvQ==
X-Received: by 2002:a05:6870:a548:b0:1ef:b669:ba1f with SMTP id p8-20020a056870a54800b001efb669ba1fmr14783183oal.8.1698869385201;
        Wed, 01 Nov 2023 13:09:45 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
        by smtp.gmail.com with ESMTPSA id er1-20020a0568303c0100b006b74bea76c0sm300868otb.47.2023.11.01.13.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:09:44 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:6bc2:793f:82fc:c2f9])
        by serve.minyard.net (Postfix) with ESMTPSA id 249F4180053;
        Wed,  1 Nov 2023 20:09:43 +0000 (UTC)
Date:   Wed, 1 Nov 2023 15:09:41 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI fixes for 6.7
Message-ID: <ZUKwhZT4CCwv3FOP@mail.minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3669558bdf354cd352be955ef2764cde6a9bf5ec:

  Merge tag 'for-6.6-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-09-12 11:28:00 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.7-1

for you to fetch changes up to b00839ca4cca8aa9641c121c848a553d6220ce70:

  ipmi: refactor deprecated strncpy (2023-09-13 12:55:11 -0500)

----------------------------------------------------------------
Pull request for IPMI

Well, only one change, and I would normally just wait, but it will make
the people trying to get rid of strncpy happy.  Its a good change,
anyway.

----------------------------------------------------------------
Justin Stitt (1):
      ipmi: refactor deprecated strncpy

 drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
 drivers/char/ipmi/ipmi_ssif.c       |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

