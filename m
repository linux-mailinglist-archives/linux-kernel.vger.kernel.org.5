Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2E768F85
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGaIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGaIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4143212A;
        Mon, 31 Jul 2023 01:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCFA660F6D;
        Mon, 31 Jul 2023 08:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87FC433C7;
        Mon, 31 Jul 2023 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790567;
        bh=sz0W8TWwDCZSDXacy5qFJ8iQI502iNXILpE0ymuNVfw=;
        h=From:To:Cc:Subject:Date:From;
        b=tHPODxfZybRK3y1v2GMX5qW2Chercg8j0kZLxqtYuf4czbNMsMrljy0T4IY/CZUvo
         0rwPYkpCnCMzd3HyJtmhzOmqgASIBO2L9YZ/hrJOE+9+vjNOsVXzvL8IQDv6NF+BNw
         b5VKtXikVdg/M+RXn/15gjCNUfhYrLl1qBL2lDvMHNDm4wYIjCPzAQcmKjlWFw4ECG
         H9zPdvPT7G+SO038mok1a2ug8jTfMqcAQJN18AYY5OWgR5uXUoTPNcejZNq6ZDvVvA
         tHOcY7BakONs8OObQyR6OInxJaMfwgdHxDZqNTxZmF/7AB6uPKsJS1hKM1Nsd9dfcZ
         KjrIb4ILGEH7Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/10] tty: minor cleanups
Date:   Mon, 31 Jul 2023 10:02:34 +0200
Message-ID: <20230731080244.2698-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another round of minor cleanups in the tty/serial/related
drivers.

Jiri Slaby (SUSE) (10):
  serial: move WARN_ON() in uart_write() to the condition
  Bluetooth: rfcomm: remove casts from tty->driver_data
  tty: hvsi: remove an extra variable from hvsi_write()
  input: serport: remove casts from tty->disc_data
  can: slcan: remove casts from tty->disc_data
  serial: altera_jtaguart: switch status to u32
  speakup: switch to unsigned iterator in spk_ttyio_receive_buf2()
  misc: ti-st: remove forward declarations and make st_int_recv() static
  misc: ti-st: remove ptr from recv functions
  misc: ti-st: don't check for tty data == NULL

 drivers/accessibility/speakup/spk_ttyio.c |  2 +-
 drivers/input/serio/serport.c             | 10 +++++-----
 drivers/misc/ti-st/st_core.c              | 11 +++--------
 drivers/misc/ti-st/st_kim.c               |  9 +--------
 drivers/net/can/slcan/slcan-core.c        |  8 ++++----
 drivers/tty/hvc/hvsi.c                    |  3 +--
 drivers/tty/serial/altera_jtaguart.c      |  2 +-
 drivers/tty/serial/serial_core.c          |  8 ++------
 net/bluetooth/rfcomm/tty.c                | 22 +++++++++++-----------
 9 files changed, 29 insertions(+), 46 deletions(-)

-- 
2.41.0

