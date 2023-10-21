Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944CC7D1C8E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjJUKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:35:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF056D5D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:35:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB51C433C7;
        Sat, 21 Oct 2023 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697884546;
        bh=6yWmez/L+p/MIzkYttk/iFNjmxuQYstDYHQskwBxuv0=;
        h=Date:From:To:Cc:Subject:From;
        b=J+XtpMwBWTDzeYtSXcGY3Xjq6IzkNFgYth6kXpTRxjwDS8umaj4gK6c7qJ4q4GzVa
         uCJ9lIAsiMWSBttpm0SrB5ajKBV5n6dQVL/ytoNcVBVTXS75VMYiU5LkgDHft6Yfiq
         NNgDh0+ei2ExhePBEEg1ndyQ3ncLZwKpjOpYhSM4=
Date:   Sat, 21 Oct 2023 12:35:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt fixes for 6.6-rc7
Message-ID: <ZTOpf59MXETPspHM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc7

for you to fetch changes up to 21a68b69f7c16f026bd2e51884520aaf594977cb:

  Merge tag 'usb-serial-6.6-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2023-10-20 07:52:44 +0200)

----------------------------------------------------------------
USB/Thunderbolt fixes and ids for 6.6-rc7

Here are 4 small patches for USB and Thunderbolt for 6.6-rc7 that do the
following:
  - new usb-serial device ids
  - thunderbolt driver fix for reported issue

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Benoît Monin (1):
      USB: serial: option: add entry for Sierra EM9191 with new firmware

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Gil Fine (1):
      thunderbolt: Call tb_switch_put() once DisplayPort bandwidth request is finished

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.6-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.6-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

 drivers/thunderbolt/tb.c    | 10 ++++++----
 drivers/usb/serial/option.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)
