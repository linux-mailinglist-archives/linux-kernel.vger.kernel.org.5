Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084A7690F2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGaJA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGaJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9343F4;
        Mon, 31 Jul 2023 02:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72AF960F9B;
        Mon, 31 Jul 2023 09:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84E4C433C7;
        Mon, 31 Jul 2023 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794012;
        bh=r05v/Z3avoaL+J176Epb/F0IBfdt+0+lEHtBxlv9Ftk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRD8O0p0Klk8GRjsrovatlOKkNihWh//41kunvXqlkMzoIYRb68ZXcAa7L69HTeig
         pNrgLCCfU6seAw/gDhb7w2DvaihY62b3QPqlxaaz7dR7VLCdrS2ldI0fv1Q28SF5ma
         obpWNgb2DiUOr8iwVh4HmvMWRlCYDe+noWifTKxJ7K6uc2Q/SBFaNooCK5BBHRKh4v
         RQCYJU61M9KFgf3oXrC6MY9sMNZVAoxP3JEnbSE/DYzEEFdYagTbJFU0ZljgLe6bAz
         mcLHLnEGHgHfBygmTngE67uz3yrMUD0suXYk2NogU7CFP2kqEHYn6t2oYo3TPUxh7n
         i57BSH0Dl96+w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 5/7] tty: synclink_gt: use PCI_VDEVICE
Date:   Mon, 31 Jul 2023 11:00:00 +0200
Message-ID: <20230731090002.15680-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes the device entries quite a bit readable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 4a93e0e48156..381b2e22fa96 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -93,11 +93,11 @@ MODULE_LICENSE("GPL");
 #define MAX_DEVICES 32
 
 static const struct pci_device_id pci_table[] = {
-	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT2_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT4_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_AC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{0,}, /* terminate list */
+	{ PCI_VDEVICE(MICROGATE, SYNCLINK_GT_DEVICE_ID) },
+	{ PCI_VDEVICE(MICROGATE, SYNCLINK_GT2_DEVICE_ID) },
+	{ PCI_VDEVICE(MICROGATE, SYNCLINK_GT4_DEVICE_ID) },
+	{ PCI_VDEVICE(MICROGATE, SYNCLINK_AC_DEVICE_ID) },
+	{ 0 }, /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, pci_table);
 
-- 
2.41.0

