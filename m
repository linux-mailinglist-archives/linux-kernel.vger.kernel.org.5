Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DE7D80F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjJZKl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:55 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF91B2;
        Thu, 26 Oct 2023 03:41:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F20F824000B;
        Thu, 26 Oct 2023 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698316908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7FO3bXg4jaYqWVw7SUw9GVHbeVNPGlx4JKNogiekb4w=;
        b=nuNiebBs72L1ynsy2Kldz2/h12GOsQYrI8XbztCaRZlHCO+74uJ1qjaiLXX9heZSnEvVf3
        AJPBvI8zVv0oqF/xzmyHPW0kpZSW+x9Jvv/CuOn5DBTMpDsR5IuLjazzEHqMQvsQgD/QM1
        BE97roaofc9OeBsJXP537pvNtmv8WSVgGb5rjcBi9kBuZqZ/AD/I6SVe6MLMXexaLybEuM
        v+jl67/WdATJFIwE1fWNF8INxAltZF6dHD+4bGkATvgYGzDoP+y7oig8xRl4sFMv8i8vvF
        o/OpRYGoY8ADus4Q2dCxDuNn57XTLgpnaGp2exuR60E7A1e6wYTkwDqmWiqwRA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/6] Cleanup AMBA PL011 driver
Date:   Thu, 26 Oct 2023 12:41:17 +0200
Message-Id: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE1COmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINbNTcqp1C1NLCrRTUxLTkxOSrK0SLNIUgKqLyhKTcusAJsVHVtbCwB
 74cndWwAAAA==
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While adding upstream support to a new platform (Mobileye EyeQ5[1]) that
uses the AMBA PL011 driver, I took some time to look at the PL011
driver and ended up with a few patches that cleanup parts of it. The
line-diff is big mostly because of the checkpatch-fixing commits.

The driver hadn't received any love for quite some time. A single commit
changes the code's behavior: see "tty: serial: amba-pl011: Parse bits
option as 5, 6, 7 or 8 in _get_options". See commit messages for more
information.

[1]: https://lore.kernel.org/all/202310050726.GDpZbMDO-lkp@intel.com/T/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (6):
      tty: serial: amba: cleanup whitespace
      tty: serial: amba: Use BIT() macro for constant declarations
      tty: serial: amba-pl011: cleanup driver
      tty: serial: amba-pl011: replace TIOCMBIT macros by static functions
      tty: serial: amba-pl011: unindent pl011_console_get_options function body
      tty: serial: amba-pl011: Parse bits option as 5, 6, 7 or 8 in _get_options

 drivers/tty/serial/amba-pl011.c | 238 ++++++++++++++++++++--------------------
 include/linux/amba/serial.h     | 192 ++++++++++++++++----------------
 2 files changed, 214 insertions(+), 216 deletions(-)
---
base-commit: ad582615776e62e365ab2dfa7a7a3806ada28b30
change-id: 20231023-mbly-uart-afcacbb98f8b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

