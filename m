Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA297C76EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442407AbjJLTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442237AbjJLTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C6BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABD4C433CC;
        Thu, 12 Oct 2023 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139155;
        bh=5aGC/G+byzObqQL21CGtQDnMviiKaiIj+LBFIFBDttY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rt7pJs58qHDgY5FTWFs06oE+wyY0Hg643hOyyG5nRforSbEBl4pB0WoXkyyszzKBg
         eA73LVfQeXm3Q7SRaISGk4nfK3riJOzMolz/+l086d1lueHNrN8VNYFcbdftOzDHYC
         GBvwZ/Y/TxUN7s4GKfIJqB8CPZpJCVBirdgc4wTQLAYMKC4MJ086cfNgYebKA8rPKn
         rxap7r371Nyfh7o2JSNBGI6jGChppjXkToRpIqzcYQZXx4CJW5TIbbY03m8NrCTAVl
         QDDvCGXdGwH/IT27PyvB2duvmtg8xPVkdKxVsNK0pNZqYFWiknxU88bqPyLHNsMnjc
         1+Qrdq/jbZOqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 47E41CE0AD4; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 05/19] selftests/nolibc: use -nostdinc for nolibc-test
Date:   Thu, 12 Oct 2023 12:32:19 -0700
Message-Id: <20231012193233.207857-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Avoid any accidental reliance on system includes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index dfe66776a331..689658f81a19 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -170,7 +170,7 @@ sysroot/$(ARCH)/include:
 ifneq ($(NOLIBC_SYSROOT),0)
 nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
+	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include $< -lgcc
 else
 nolibc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-- 
2.40.1

