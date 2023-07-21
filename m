Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1946375BF80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGUHWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGUHWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:22:03 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1795E75;
        Fri, 21 Jul 2023 00:22:02 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A179F807E;
        Fri, 21 Jul 2023 07:22:00 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v3 0/3] Serial core controller port device name fixes
Date:   Fri, 21 Jul 2023 10:21:39 +0300
Message-ID: <20230721072147.59121-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few issues have been found with device naming for the serial core
controller port device. These issues currently mostly affect the output
for /sys/bus/serial-base/devices, but need to be also fixed to avoid
port addressing issues later on.

Changes since v2:
- Fix my email script as it had started to drop linux-serial as noted by
  Greg

- Explain why we're changing ctrl_id as requested by Greg

Changes since v1:
- Port id cannot be negative as noted by Jiri

- Controller id cannot be negative as noted by Andy

- Port name is missing the controller instance as noted by Andy

Tony Lindgren (3):
  serial: core: Controller id cannot be negative
  serial: core: Fix serial core port id to not use port->line
  serial: core: Fix serial core controller port name to show controller
    id

 drivers/tty/serial/8250/8250_core.c  |  2 ++
 drivers/tty/serial/serial_base_bus.c | 33 ++++++++++++++++++----------
 include/linux/serial_core.h          |  3 ++-
 3 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.41.0
