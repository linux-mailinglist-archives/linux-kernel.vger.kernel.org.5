Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F87B476B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjJAMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjJAMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:25:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED2FA2
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 05:25:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C58C433C8;
        Sun,  1 Oct 2023 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696163138;
        bh=Y8h6/pHNPKaBhh5W5fxoAFUk9icvSdNDrj/2bOcdiaA=;
        h=Date:From:To:Cc:Subject:From;
        b=g+GUpIZT0jeW/M52dfkzKb8EXmr+3yalNNImEPJobYzgvFz/WUEW0D0hhvE7Rgup4
         gUEieuTAgF9c8ycxfYlPESrqE/QAeAuVXHGC31VBoXmpnF0qxH6QdXZyLxsDtF3OAu
         6BC05ksabz1ZpbWKu8A0xM1bVHVYsJxk01nPFm+k=
Date:   Sun, 1 Oct 2023 14:25:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 6.6-rc4
Message-ID: <ZRllP2-4Lxm3t49d@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc4

for you to fetch changes up to 0e4cac557531a4c93de108d9ff11329fcad482ff:

  misc: rtsx: Fix some platforms can not boot and move the l1ss judgment to probe (2023-09-25 10:48:19 +0200)

----------------------------------------------------------------
Misc driver fix for 6.6-rc4

Here is a single, much requested, fix for a set of misc drivers to
resolve a much reported regression in the -rc series that has also
propagated back to the stable releases.  Sorry for the delay, lots of
conference travel for a few weeks put me very far behind in patch
wrangling.

It has been reported by many to resolve the reported problem, and has
been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ricky WU (1):
      misc: rtsx: Fix some platforms can not boot and move the l1ss judgment to probe

 drivers/misc/cardreader/rts5227.c  | 55 ++++--------------------------------
 drivers/misc/cardreader/rts5228.c  | 57 ++++++++++++--------------------------
 drivers/misc/cardreader/rts5249.c  | 56 +++++--------------------------------
 drivers/misc/cardreader/rts5260.c  | 43 +++++++++-------------------
 drivers/misc/cardreader/rts5261.c  | 52 +++++++++-------------------------
 drivers/misc/cardreader/rtsx_pcr.c | 51 ++++++++++++++++++++++++++++++----
 6 files changed, 102 insertions(+), 212 deletions(-)
