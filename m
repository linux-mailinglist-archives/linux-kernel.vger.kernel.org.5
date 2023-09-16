Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB97A2FCB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjIPL7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIPL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:59:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3530DCCB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:59:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DDFC433C7;
        Sat, 16 Sep 2023 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694865543;
        bh=76wPwulo/cXNp40P+q+GDdQrRZmAZGnvwIqofTmTG6s=;
        h=Date:From:To:Cc:Subject:From;
        b=n8Qlt43JtDoLnnDmYZrIoK28eoDnf5lx0Ep7DLrXi9R5Ggl/1cyi+67Bp9rmc6o/4
         A2L5dLzEZZxgyvK7DPURUTO9jq5lCeTS2Cl006iEMKiHDfIPa4WbA+87eM9VovdkHi
         fTTR4Jui5RZ8sDgGUdcBxgEPG4nUWxy4fWI0VuOA=
Date:   Sat, 16 Sep 2023 13:59:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 6.6-rc2
Message-ID: <ZQWYhSxtU3PRwKys@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc2

for you to fetch changes up to 98a15816636044f25be4644db2a3e09fad68aaf7:

  Revert "comedi: add HAS_IOPORT dependencies" (2023-09-12 15:49:20 +0200)

----------------------------------------------------------------
Char/Misc fix for 6.6-rc2

Here is a single patch for 6.6-rc2 that reverts a 6.5 change for the
comedi subsystem that has ended up being incorrect and caused drivers
that were working for people to be unable to be able to be selected to
build at all.  To fix this, the Kconfig change needs to be reverted and
a future set of fixes for the ioport dependancies will show up in
6.7-rc1 (there's no rush for them.)

This has been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ian Abbott (1):
      Revert "comedi: add HAS_IOPORT dependencies"

 drivers/comedi/Kconfig | 103 +++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 68 deletions(-)
