Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B847D41E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjJWVtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJWVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:49:35 -0400
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F410E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:49:32 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qv2ng-0004Kz-0W;
        Mon, 23 Oct 2023 23:49:28 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH 0/4] media: i2c: imx214: Extend with sensor size and
 firmware information
Date:   Mon, 23 Oct 2023 23:47:49 +0200
Message-Id: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAXqNmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINbNzK0wMjTRNbNINjG2SE1KSzJIVgIqLihKTcusABsUHVtbCwAFW6l
 0WAAAAA==
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
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
André Apitzsch (4):
      media: i2c: imx214: Explain some magic numbers
      media: i2c: imx214: Move controls init to separate function
      media: i2c: imx214: Read orientation and rotation from system firmware
      media: i2c: imx214: Add sensor's pixel matrix size

 drivers/media/i2c/imx214.c | 171 +++++++++++++++++++++++++++++++--------------
 1 file changed, 117 insertions(+), 54 deletions(-)
---
base-commit: e8361b005d7c92997d12f2b85a9e4a525738bd9d
change-id: 20231023-imx214-68c438ebfb0c

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

