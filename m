Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36D807B78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377444AbjLFWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjLFWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:38:30 -0500
X-Greylist: delayed 250 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 14:38:36 PST
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de [80.67.31.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2093DD59;
        Wed,  6 Dec 2023 14:38:36 -0800 (PST)
Received: from [92.206.191.209] (helo=note-book.lan)
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1rB0TH-0007Ur-0d;
        Wed, 06 Dec 2023 23:34:23 +0100
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v4 0/4] media: i2c: imx214: Extend with sensor size and
 firmware information
Date:   Wed, 06 Dec 2023 23:33:54 +0100
Message-Id: <20231206-imx214-v4-0-7ef604b01dcb@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANL2cGUC/23MvQ6CMBSG4Vshna3pXwo4eR/GgbbnSAeBtNigh
 Hu3MBgNDh2+5jzvTCIED5GcipkESD76vstDHQpi26a7AfUubyKYkDw/6u+T4IrqyipZgUHDLMn
 HQwD00xa6XPNufRz78Ny6ia+/u0TilFEjJXJjHEeL52bw4yva9ggPskaS+IbVB4oMdd1UaErJn
 IY9lP+hzNA6ZbAssdY1+4XLsrwBvZLHGhABAAA=
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the effective and active sensor sizes and add functionality to read
rotation and orientation from device trees.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v4:
- Add r-b by Kieran to patch 1/4
- Link to v3: https://lore.kernel.org/r/20231028-imx214-v3-0-cd4bf77f9690@apitzsch.eu

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
base-commit: 577a4ee0b96fb043c9cf4a533c550ff587e526cf
change-id: 20231023-imx214-68c438ebfb0c

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

