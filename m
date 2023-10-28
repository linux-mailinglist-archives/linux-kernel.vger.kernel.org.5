Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA527DA5DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjJ1ImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjJ1ImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:42:22 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC4107;
        Sat, 28 Oct 2023 01:42:19 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qwetb-0006mt-2p;
        Sat, 28 Oct 2023 10:42:15 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v3 0/4] media: i2c: imx214: Extend with sensor size and
 firmware information
Date:   Sat, 28 Oct 2023 10:41:44 +0200
Message-Id: <20231028-imx214-v3-0-cd4bf77f9690@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEjJPGUC/2WMzQ6CMBAGX4Xs2Zr+kFo9+R7GAy1b2YNAWmxQ0
 ne3cDAaD3uYzTezQMRAGOFULRAwUaShL6B2Fbiu6W/IqC0MkkslyjG6z1LUTBtXK4PWW+6gjMe
 AnuYtdLkW7ihOQ3hu3STW718iCcaZVcoLa1vhnT83I02v6Lo9PmCNJPktmo8oi6iPjfH2oHir8
 VfMOb8B9RQXXtcAAAA=
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the effective and active sensor sizes and add functionality to read
rotation and orientation from device trees.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v3:
- Squash patch 5/5 with patch 2/5
- Link to v2: https://lore.kernel.org/r/20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu

Changes in v2:
- Use integer representation for default exposure (Kieran)
- Replace dev_err_probe() by dev_err()
- Increase number of pre-allocated control slots (Jacopo)
- Fix typo in commit message (Jacopo)
- Add r-b tags
- Add patch to fix ctrls init error handling
- Link to v1: https://lore.kernel.org/r/20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu

---
André Apitzsch (4):
      media: i2c: imx214: Explain some magic numbers
      media: i2c: imx214: Move controls init to separate function
      media: i2c: imx214: Read orientation and rotation from system firmware
      media: i2c: imx214: Add sensor's pixel matrix size

 drivers/media/i2c/imx214.c | 175 +++++++++++++++++++++++++++++++--------------
 1 file changed, 120 insertions(+), 55 deletions(-)
---
base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
change-id: 20231023-imx214-68c438ebfb0c

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

