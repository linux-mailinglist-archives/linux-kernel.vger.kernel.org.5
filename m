Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB17789D14
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjH0Kzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjH0KzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A564FA;
        Sun, 27 Aug 2023 03:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8AC66119B;
        Sun, 27 Aug 2023 10:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21630C433C7;
        Sun, 27 Aug 2023 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693133717;
        bh=LxXSNmFLWYnruo+tmUqoxLa1j7F/1EjXT+s50IXbqhk=;
        h=Date:From:To:Cc:Subject:From;
        b=hX9r5ufyO+P2JqlZ11dm8GMcIFSg95M0gOuJC5kLz5CDkTKDOgDDOSDgeXo9Na0pC
         8RzPW07Y2O0gThTb6sbhi2K85qjAcjQ9kdPIVVvNv4Ao4483F5Norp0h6OGIpVRDEV
         pVSCoLF5I7y5NlsOPDFj5r9v3bMqpzWUgaXL4U0wajTapzjhqPDSo5uYnjL7QZv+Em
         LddRyFBKAK2qUErlNJnOnofayMzJQF4gyUNyguP2SqV0jKA7bA0hrt2rH8PSvU2Z6P
         7GxXsMESsZBZc+48vE0qhAh6qnGq7i050cn1RZPnIoh51StgDa1z9Qx2aEFn5sHGfz
         Pw4bQmFWjL2jw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qaDQO-0002mH-1r;
        Sun, 27 Aug 2023 12:55:20 +0200
Date:   Sun, 27 Aug 2023 12:55:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.6-rc1
Message-ID: <ZOsrmMtt5BTvfkcv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.6-rc1

for you to fetch changes up to 4d9488b294e1f8353bbcadc4c7172a7f7490199b:

  USB: serial: option: add FOXCONN T99W368/T99W373 product (2023-08-23 10:06:48 +0200)

----------------------------------------------------------------
USB-serial updates for 6.6-rc1

Here are the USB-serial updates for 6.6-rc1, including:

 - support for the RS485 mode of XR devices
 - new modem device ids

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Jarkko Sonninen (1):
      USB: serial: xr: add TIOCGRS485 and TIOCSRS485 ioctls

Martin Kohn (1):
      USB: serial: option: add Quectel EM05G variant (0x030e)

Slark Xiao (1):
      USB: serial: option: add FOXCONN T99W368/T99W373 product

 drivers/usb/serial/option.c    |  7 ++++
 drivers/usb/serial/xr_serial.c | 89 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)
