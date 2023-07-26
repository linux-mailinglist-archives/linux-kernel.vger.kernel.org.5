Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B787642B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGZXtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGZXtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:49:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C2E0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o4y3h13DqwkObDVE8uFly/JudDZ7Hu6hufCHbRpUZRY=; b=svZOQRP3b5N7hdQtIEFYu5nyfd
        5ilogn+EVo7SXOTvC6TFP5CCjIvGNKioJCtN7ztJ6PU3QdpWqjTHglYtTKZAPt1NpWba6E/ixTXsk
        ZjcU/kaTojdFWLclSq/eeVa2eX7mhCPDN9cH2hP/A9c6IydcgqlyeoWLvYTI7uE5tdtf7fy5grybh
        /s1prHKRLd6ALBj5nzMg4B/uI2TGSNyZg9S1289knmiGolkel18BhnWlEjdTC0AwhojYxCqe27ULD
        OsnG1rLmkK3an4Dri1VkEcdIZQlGn1xn+jKk34hYLFO6ms0VSm34s1C3H86TM7uAmhjxoAULJ3WML
        a6G5Hf5w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOoFj-00Bk2s-0a;
        Wed, 26 Jul 2023 23:49:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org
Subject: [PATCH] x86/APM: drop the duplicate APM_MINOR_DEV macro
Date:   Wed, 26 Jul 2023 16:49:10 -0700
Message-ID: <20230726234910.14775-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This source file already includes <linux/miscdevice.h>, which contains
the same macro. It doesn't need to be defined here again.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/kernel/apm_32.c |    6 ------
 1 file changed, 6 deletions(-)

diff -- a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -239,12 +239,6 @@ extern int (*console_blank_hook)(int);
 #endif
 
 /*
- * The apm_bios device is one of the misc char devices.
- * This is its minor number.
- */
-#define	APM_MINOR_DEV	134
-
-/*
  * Various options can be changed at boot time as follows:
  * (We allow underscores for compatibility with the modules code)
  *	apm=on/off			enable/disable APM
