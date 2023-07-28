Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A6766103
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjG1BMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjG1BMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:12:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0603AA2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YwjMXrlmohJGv2d3xIQLvbpFtXYP5IQTL3JwTffYMDA=; b=EwbfeJbCiIw4QA0xQjzThFoSr0
        6eKHGBru1loTNamc8QCaBjrbnUHnu7Y93ONZX7/EogQq0O885sMVeuCVdepPcvRBu2ESeVYioLUrz
        klK1hzwcY8Wi3pbmVQR/XZokDBLghppr6ZTUA7I0Aybs3nhfsSwZEaLebP5UUVX1/eiMHrO5xaY7w
        vbg+Dm0HTf+lHauiwg3wbYb3gC660RMjuQhZ2ylDLBP2D5U5xMZoSGeivUdo6WNgVJXXJrA190EyQ
        i3+zO/sRORFqPrJK56srKfyk3yVnRa3ZlA86fVrgL2iOBiRab+Yif+JhOJyAPo6RX2cb8jwKnNKGK
        BUUiP4bQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPC0m-0016RS-2e;
        Fri, 28 Jul 2023 01:11:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        Sohil Mehta <sohil.mehta@intel.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] x86/APM: drop the duplicate APM_MINOR_DEV macro
Date:   Thu, 27 Jul 2023 18:11:20 -0700
Message-ID: <20230728011120.759-1-rdunlap@infradead.org>
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

Fixes: 874bcd00f520 ("apm-emulation: move APM_MINOR_DEV to include/linux/miscdevice.h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: x86@kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: change the Fixes: tag (Sohil)

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
