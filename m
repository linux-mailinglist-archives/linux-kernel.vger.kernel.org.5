Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C957F710A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjKXKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbjKXKPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:15:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBBBBB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:15:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D15CC433CA;
        Fri, 24 Nov 2023 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700820920;
        bh=K8c3CvTDdS55RC9NLl6N86xxOb4or8TCl0n+Zl6sVx8=;
        h=Date:From:To:Cc:Subject:From;
        b=pPE1PgTDiczuxiA2bhqHEUEAqGtc/M5IFII2ibnBOYKyJ9ljGah8f+rmYYs4RuJjY
         rLj/986St3NsP9c2FooP7Ey27ExyDcatCP3jG2ythi6aRQ3dCM7/vWYk2N8+hyIfRi
         pBV7oAbTuqUhvsa3lWOw8tCppKPXVfqQNB2iH/KfpLPqGDpcTp7minwnbiwjwZ1jPS
         kLji9dHnwdcqk7DjmXVqawU5UB4bP2DZzY56HI1INV40Z8FYKatf6apfeJwi2jzpmY
         e5590mjAfS+v0ul2pJzOp9sDy6DVDOqV4wkMlO5QGlamAev7ThYK97opqH9LiOpgs6
         dyWgYLgc4dksQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r6TDo-0007DY-26;
        Fri, 24 Nov 2023 11:15:40 +0100
Date:   Fri, 24 Nov 2023 11:15:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.7-rc3
Message-ID: <ZWB3zPa1o74IfDM5@hovoldconsulting.com>
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

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.7-rc3

for you to fetch changes up to da90e45d5afc4da2de7cd3ea7943d0f1baa47cc2:

  USB: serial: option: add Luat Air72*U series products (2023-11-23 18:39:30 +0100)

----------------------------------------------------------------
USB-serial fixes for 6.7-rc3

Here are a couple of modem device entry fixes and some new modem device
ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Asuna Yang (1):
      USB: serial: option: add Luat Air72*U series products

Lech Perczak (1):
      USB: serial: option: don't claim interface 4 for ZTE MF290

Puliang Lu (1):
      USB: serial: option: fix FM101R-GL defines

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

 drivers/usb/serial/option.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
