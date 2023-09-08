Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03879831B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjIHHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbjIHHN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:13:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F21BCB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:13:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A8A5215E6;
        Fri,  8 Sep 2023 07:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694157231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=skcGH8Kp+DnjE+52pR/0zaJLD+U7D3DCZjwJ6FRdRQU=;
        b=UhOm2CDvWc6ENUBzXk95Yd6Ie9IpSP+q4z32DO3AS1Dwq32Wp1IMd6LyR3NDWsKDzwOvRd
        VqJVPkl4NssBjYXRSF8QlArssyt/MJ4G/leGg+ZPPnT5FrmbXvaX4J8iLgurFBWvIcjAHX
        U99YxpDtRytZiNWvVYpDIHlbwn8ppSM=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 092332C142;
        Fri,  8 Sep 2023 07:13:50 +0000 (UTC)
Date:   Fri, 8 Sep 2023 09:13:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixup for 6.6
Message-ID: <ZPrJrWsAE-u8Lefq@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one revert in the printk code

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6-fixup

==========================

- Revert exporting symbols needed for dumping the raw printk buffer
  in panic().

==========================

I pushed the export prematurely before the user was ready for merging
into the mainline.

----------------------------------------------------------------
Christoph Hellwig (1):
      Revert "printk: export symbols for debug modules"

 kernel/printk/printk.c | 2 --
 1 file changed, 2 deletions(-)
