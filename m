Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097D7F2A98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjKUKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjKUKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218EB123
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A90DC433C9;
        Tue, 21 Nov 2023 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700562995;
        bh=ePkHUZAKxjj2Jg7Kd1bP4Zaca9R79v2WfPvnz48hE58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSr8LW23lkduPYNmLdvejeBcSGnX9RJR0zXrL9jAmtu1B5ILBicrMjDEy/tRd+NjK
         4lHDLPMlklSJFPU++1VqEuDxFqh5/TAZHGhBMCPDeSLnBTmTh9C3gTNVPdzQAWugto
         QGz0ZTh+MtevAO69oPRBC/JKG5rjDd1HIQlCzyWmddz7mPRVFJiF27rR5i387P/JTR
         uVVS8K9ZSpE/Oi0P/vuUhYd1mMT8870Tw+lHIcB7gQtUXVYEX+GDenGe0JJTg/qwYB
         G4tgTJHIM+esBxeD40Y8/Ik+3m6vxIAAf/r3UpKFmdZS3vD9l0Pem7VT3NfNCLbRxt
         EgpYsk0KNj1Rg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] tty: ipwireless: remove unused ipw_dev::attribute_memory
Date:   Tue, 21 Nov 2023 11:36:22 +0100
Message-ID: <20231121103626.17772-3-jirislaby@kernel.org>
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

clang-struct [1] found ipw_dev::attribute_memory unused.

As far as I can see it was never used since the driver merge. Drop it.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
---
 drivers/tty/ipwireless/main.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/ipwireless/main.h b/drivers/tty/ipwireless/main.h
index 73818bb64416..a5728a5b3f83 100644
--- a/drivers/tty/ipwireless/main.h
+++ b/drivers/tty/ipwireless/main.h
@@ -49,9 +49,6 @@ struct ipw_dev {
 
 	void __iomem *common_memory;
 
-	/* Reference to attribute memory, containing CIS data */
-	void *attribute_memory;
-
 	/* Hardware context */
 	struct ipw_hardware *hardware;
 	/* Network layer context */
-- 
2.42.1

