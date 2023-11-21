Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0777F2AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjKUKhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjKUKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34F18C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5FEC433C7;
        Tue, 21 Nov 2023 10:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700563002;
        bh=ZUbsMm06fEd3nF1lhwAHhD7S+m2Uiy8kDq+uaKpBn3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJS2/TLHg6Kc6CyARmWS+Z7QYMmd2Rx11qBg83meZSGR0y4cUwo3RvTZ0oX8WedYS
         4zy5ksaJWE73HiL/d6Ig+JtZJ2t6G5tXuJcIoR5Re2O1NAqPe4XfP4h59EiU5I++Xj
         4ImSAzcq2ucVD6OeHSAASpOVnsH0i+PP13ApE+691H+lgrUfZ/kxQWBepxWU+lRV9L
         /bouSem61tHv6tiUZ7//5f7/2fExefTtU0s7cmbE7LTwI8s1OGSeEie0QR/wphEv2o
         qaqPIk5exwAYZzuV9Q0Kyro0FbtTE2c/ZxMaX03CAAkvePf2t5QIyfn/Bn2iZHonMy
         FaOscFZQbSyLA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6/6] tty: serial_cs: remove unused struct serial_cfg_mem
Date:   Tue, 21 Nov 2023 11:36:26 +0100
Message-ID: <20231121103626.17772-7-jirislaby@kernel.org>
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

clang-struct [1] found struct serial_cfg_mem's members unused.

In fact, the whole structure is unused since commit 6ae3b84d9793
("serial_cs: use pcmcia_loop_config() and pre-determined values"). Drop
it completely.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index dc2ef05a10eb..2056aed46688 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -90,12 +90,6 @@ struct serial_info {
 	const struct serial_quirk *quirk;
 };
 
-struct serial_cfg_mem {
-	tuple_t tuple;
-	cisparse_t parse;
-	u_char buf[256];
-};
-
 /*
  * vers_1 5.0, "Brain Boxes", "2-Port RS232 card", "r6"
  * manfid 0x0160, 0x0104
-- 
2.42.1

