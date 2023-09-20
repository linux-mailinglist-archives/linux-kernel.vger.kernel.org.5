Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E3D7A71E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjITFWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjITFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BCDE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OX+5DgL5L+DB7XZdBwxF1pwtxEcW3b8yHimwNmQkOpo=; b=ARBb1QXsZW6yqaduKl4ez0JHar
        gvxxwUAo4kAzoYh8DJAZvYiWfQYaDVTGNmyyd5G//JeJ6BdQw1mvdSYVkl5uINRbBHhxZLR0kkbOy
        //QDlldJmSoqOyWvrHCOg4Tz/93iw6d+9eX0h8wsdqG0PC2PTbWDzYH/aNJ7um82RP1x1ua4GNJmS
        JEXYFubkGfNM5BHYd2AvT/ETCOKfCc1IXxvupJ/vr9Tm5Vu337dRy3/3ja91zYJg9bsLGr8THIJmz
        6087bbXgj6zJG7zEhmRDe1lhMZTT2UpD0hur3ygUZmNz6/thB4Q2V8y5P8RTAl6PNdcfdWrzBP3E8
        GHxuY7Hg==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipei-001tym-0H;
        Wed, 20 Sep 2023 05:21:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 07/16] xtensa: stacktrace: include <asm/ftrace.h> for prototype
Date:   Tue, 19 Sep 2023 22:21:30 -0700
Message-ID: <20230920052139.10570-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use <asm/ftrace.h> to prevent a build warning:

arch/xtensa/kernel/stacktrace.c:263:15: warning: no previous prototype for 'return_address' [-Wmissing-prototypes]
  263 | unsigned long return_address(unsigned level)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/stacktrace.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
+#include <asm/ftrace.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <linux/uaccess.h>
