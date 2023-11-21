Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380A77F2A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjKUKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjKUKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1D9D47
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C6AC433C7;
        Tue, 21 Nov 2023 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700562998;
        bh=gYNUG4npFwZVxiI0KAeDKVJO+CZmchirHrnJPjLRzrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jL1qGK4L9thFFk/ZGqToKc4xbLb3qHBFTkNCUOSyhwIqdJgLb5SvApx1McOqjqYvY
         g0ZOaFMWTTczCN+tmQKQP6IV/yhzYFz7NhCl1MbgpUhDrKn3TY0akHXirl261UHQIS
         Jo1A87sobcOZLNI3+BXQkdco2DpqP31YCUreoRWsOcVsqHw0ESIX7HbIctVAYNwBAL
         cqC9qAGO2GjfmZdy8EylmCQ7jVzUidC/ygAmDA7xTbOf8nClHVOkf91lFrdcSE5pWh
         FJBPqDCfyJ/TmHmuV7nxlmZv7XLmfa3Mz2Oykwnaaae49HyDcpein9lPvv4tETyomr
         R8JsHFKpaAQHg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/6] tty: jsm: remove unused struct jsm_board members
Date:   Tue, 21 Nov 2023 11:36:24 +0100
Message-ID: <20231121103626.17772-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
References: <20231121103626.17772-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-struct [1] found jsm_board::type and ::jsm_board_entry unused.

::jsm_board_entry is unused since 614a7d6a76b7 ("fix up newly added jsm driver")
::type was never used as far as I can tell. Even when the driver was
introduced in the pre-git era.

Remove them both.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/jsm/jsm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm.h b/drivers/tty/serial/jsm/jsm.h
index 08a42f045ec8..df55e5dc5afc 100644
--- a/drivers/tty/serial/jsm/jsm.h
+++ b/drivers/tty/serial/jsm/jsm.h
@@ -125,7 +125,6 @@ struct jsm_board
 {
 	int		boardnum;	/* Board number: 0-32 */
 
-	int		type;		/* Type of board */
 	u8		rev;		/* PCI revision ID */
 	struct pci_dev	*pci_dev;
 	u32		maxports;	/* MAX ports this board can handle */
@@ -153,8 +152,6 @@ struct jsm_board
 	u32		bd_dividend;	/* Board/UARTs specific dividend */
 
 	struct board_ops *bd_ops;
-
-	struct list_head jsm_board_entry;
 };
 
 /************************************************************************
-- 
2.42.1

