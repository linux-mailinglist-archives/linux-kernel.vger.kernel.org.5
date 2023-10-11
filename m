Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A87C52D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbjJKMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJKMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:03:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC35893
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:03:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 729D01FEB3;
        Wed, 11 Oct 2023 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697025819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=igik5vbTCjI/MjAhd2Vo/eSKsJaNCOBwOolYGWAr1mo=;
        b=bhPr6HtRHiwEZfoikWc5AIYsdOMxFf2duAkklZ5SddKqpprKJXqxTpnL4N+I5JeoVbOk35
        eSp8LAf5Z7RtXqoy4Ird3j//IUman+fksZ4NV6FvogCT1Gn+jRtBKNw/aYJVy0KbYXOb5S
        KlLvGlKCLK7+eu+T9pSKt6pJSGjwPA0=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 534952C69E;
        Wed, 11 Oct 2023 12:03:38 +0000 (UTC)
Date:   Wed, 11 Oct 2023 14:03:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Todd Brandt <todd.e.brandt@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk regression fix for 6.6-rc6
Message-ID: <ZSaPGo13Fz9TLUc6@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a printk fix for a regression introduced in 6.6.-rc1:

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6-rc6

================================

- Avoid unnecessary wait and try to flush messages before checking
  pending ones.

----------------------------------------------------------------
John Ogness (1):
      printk: flush consoles before checking progress

Petr Mladek (1):
      Merge branch 'rework/misc-cleanups' into for-linus

 kernel/printk/printk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
