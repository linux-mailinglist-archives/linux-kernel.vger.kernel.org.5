Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFA7DA571
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjJ1HS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjJ1HSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:18:48 -0400
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855310A;
        Sat, 28 Oct 2023 00:18:45 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qwdak-0002T7-0E;
        Sat, 28 Oct 2023 09:18:42 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v2 0/5] media: i2c: imx214: Extend with sensor size and
 firmware information
Date:   Sat, 28 Oct 2023 09:17:43 +0200
Message-Id: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJe1PGUC/2WMQQ6CMBBFr0JmbU2nJYa48h6GBS0zdhYCabFBS
 e9uZeviL97Py9shURRKcG12iJQlyTxVMKcGfBimBykZK4PRxmKdkudmsFWXzre2I8dOe6jyEol
 lO0L3vnKQtM7xfXQz/t6/REallbOW0bkR2fNtWGT9JB/O9IK+lPIF+ypPDp4AAAA=
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the effective and active sensor sizes and add functionality to read
rotation and orientation from device trees.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
- Use integer representation for default exposure (Kieran)
- Replace dev_err_probe() by dev_err()
- Increase number of pre-allocated control slots (Jacopo)
- Fix typo in commit message (Jacopo)
- Add r-b tags
- Add patch to fix ctrls init error handling
- Link to v1: https://lore.kernel.org/r/20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu

---
André Apitzsch (5):
      media: i2c: imx214: Explain some magic numbers
      media: i2c: imx214: Move controls init to separate function
      media: i2c: imx214: Read orientation and rotation from system firmware
      media: i2c: imx214: Add sensor's pixel matrix size
      media: i2c: imx214: Fix cleanup after controls initialization error

 drivers/media/i2c/imx214.c | 175 +++++++++++++++++++++++++++++++--------------
 1 file changed, 120 insertions(+), 55 deletions(-)
---
base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
change-id: 20231023-imx214-68c438ebfb0c

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

