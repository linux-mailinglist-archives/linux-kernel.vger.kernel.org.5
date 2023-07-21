Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179575BF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGUG5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:57:04 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 452162709;
        Thu, 20 Jul 2023 23:57:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7E089807E;
        Fri, 21 Jul 2023 06:57:02 +0000 (UTC)
Date:   Fri, 21 Jul 2023 09:57:01 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <20230721065701.GQ5194@atomide.com>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
 <2023072144-splurge-debate-e681@gregkh>
 <20230721061523.GP5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721061523.GP5194@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230721 06:19]:
> Looks like linux-serial not getting added is caused by MAINTAINERS
> not listing serial_base_bus.c, serial_ctrl.c and serial_port.c. This
> causes get_maintainer.pl to not show linux-serial for a patch touching
> serial_base_bus.c.. And this will causes git send-email to not pick up
> linux-serial.. I'll send a patch for MAINTAINERS file too.

And the TTY LAYER is missing the list entries.. Does something like below
make sense to you guys to include lkml and linux-serial for TTY LAYER?

Regards,

Tony

8< ---------------------
diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21628,11 +21628,17 @@ F:	Documentation/translations/zh_TW/
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-serial@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 F:	Documentation/driver-api/serial/
 F:	drivers/tty/
+F:	drivers/tty/serial/serial_base.h
+F:	drivers/tty/serial/serial_base_bus.c
 F:	drivers/tty/serial/serial_core.c
+F:	drivers/tty/serial/serial_ctrl.c
+F:	drivers/tty/serial/serial_port.c
 F:	include/linux/selection.h
 F:	include/linux/serial.h
 F:	include/linux/serial_core.h
-- 
2.41.0
