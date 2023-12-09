Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E254480B4C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjLINzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLINzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:55:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C8FC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:55:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0032C433C8;
        Sat,  9 Dec 2023 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702130122;
        bh=dAJrYs51pXw8gQPsCf2PNfad4fIq7GSCZB91uxi+/Og=;
        h=Date:From:To:Cc:Subject:From;
        b=O1pgvjC8Pka3IpyKzouBG5LtTdP01LEQ2wUpDHyL+JmAxuCceFU1EUCogKukS7yIe
         R0bXZPzTaF0MgKvvXMqm/bO0CrigCtMa+sTf19SXNPvNlmCr738TuljuvGeePmBUy5
         V0mnx+woSn3vv14RtWrFwXqXHIai4KiEY0fOcw8k=
Date:   Sat, 9 Dec 2023 14:55:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.7-rc5
Message-ID: <ZXRxx0o07FDnsRhN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc5

for you to fetch changes up to 61890dc28f7d9e9aac8a9471302613824c22fae4:

  usb: gadget: f_hid: fix report descriptor allocation (2023-12-07 10:12:05 +0900)

----------------------------------------------------------------
USB fixes for 6.7-rc5

Here are some small USB fixes for 6.7-rc5 to resolve some reported
issues.  Included in here are:
  - usb gadget f_hid, and uevent fix
  - xhci driver revert to resolve a much-reported issue
  - typec driver fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Konstantin Aladyshev (1):
      usb: gadget: f_hid: fix report descriptor allocation

Mathias Nyman (1):
      Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Roy Luo (1):
      USB: gadget: core: adjust uevent timing on gadget unbind

 drivers/usb/gadget/function/f_hid.c | 7 ++++---
 drivers/usb/gadget/udc/core.c       | 4 ++--
 drivers/usb/host/xhci-pci.c         | 2 --
 drivers/usb/typec/class.c           | 5 +++--
 4 files changed, 9 insertions(+), 9 deletions(-)
