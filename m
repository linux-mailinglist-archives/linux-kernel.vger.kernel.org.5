Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61AC7D8E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0Flc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0Fl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:41:29 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 22:41:25 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047BF1AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:41:25 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202310270540212c492c79708ef8c715
        for <linux-kernel@vger.kernel.org>;
        Fri, 27 Oct 2023 07:40:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/KZ/e7ZMbAbly9okDCQ6zH4k2JlUxSD/DyA86W16Z+k=;
 b=qIxsC0d8D+pXUIy5HcRwCfSS1WpXHiH8s3D6Ak5jTZ7MpK2O05CQDZGIvX9MQNm5RyRrYJ
 CrR0NQK5q0lyRT46rCCdw7VD9/DwUjUIHHZbcgCSpxD5ptxYZpnrzWnU00xV3+JZJsCsMM8e
 9BgUVbVIhmm6lEYXrOXJj1YSkv8ak=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: add copyright Siemens Mobility GmbH
Date:   Fri, 27 Oct 2023 07:39:03 +0200
Message-Id: <20231027053903.1886-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

More than 1/3 of the n_gsm code has been contributed by us in the last
1.5 years, completing conformance with the standard and stabilizing the
driver:
- added UI (unnumbered information) frame support
- added PN (parameter negotiation) message handling and function support
- added optional keep-alive control link supervision via test messages
- added TIOCM_OUT1 and TIOCM_OUT2 to allow responder to operate as modem
- added TIOCMIWAIT support on virtual ttys
- added additional ioctls and parameters to configure the new functions
- added overall locking mechanism to avoid data race conditions
- added outgoing data flow to decouple physical from virtual tty handling
  for better performance and to avoid dead-locks
- fixed advanced option mode implementation
- fixed convergence layer type 2 implementation
- fixed handling of CLD (multiplexer close down) messages
- fixed broken muxer close down procedure
- and many more bug fixes

With this most of our initial RFC has been implemented. It gives the driver
a quality boost unseen in the decade before.

Add a copyright notice to the n_gsm files to highlight this contribution.

Link: https://lore.kernel.org/all/20220225080758.2869-1-daniel.starke@siemens.com/
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 1 +
 include/uapi/linux/gsmmux.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1f3aba607cd5..647e06b656bf 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2,6 +2,7 @@
 /*
  * n_gsm.c GSM 0710 tty multiplexor
  * Copyright (c) 2009/10 Intel Corporation
+ * Copyright (c) 2022/23 Siemens Mobility GmbH
  *
  *	* THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
  *
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 4c878d84dbda..3a93f17ca943 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2022/23 Siemens Mobility GmbH */
 #ifndef _LINUX_GSMMUX_H
 #define _LINUX_GSMMUX_H
 
-- 
2.34.1

