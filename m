Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D503B7A71E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjITFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjITFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3329118
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9RDLrFWJyVC7v0tIEBUg6ZLVQEM25lEHLTr8hB/zzyw=; b=GAC2VprHJCnQrsn9TMAD+nz823
        KSRCb8cb7Vnd74j/oih/8KTT5stxbf7QV0uGnRJkvc9Nouu/hESJORih3zI5xndnP5tc8OZyUrciM
        rE56yQIVLRWQwMwcxhpjXCb+XD+LGC/LPvABD4CmGFvOJZaDyBxWofK0VhiXXvK8tn9e14oehpQwg
        B8ujO+en8uZlLo2REtLG0I2F5jcIVfXWU+Xx3YJb8FovFgzoyTlvNbn/JozdVhY4dfxpcPje4WBU5
        7tDSmIG09DDufvPOiXlvWUzuRnOB+MXjIdVT67lZbSacMjfRMqyqjAszrGQF5zSJUfYbunhPZTdEn
        5ooHxT/w==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipei-001tym-1D;
        Wed, 20 Sep 2023 05:21:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 08/16] xtensa: traps: add <linux/cpu.h> for function prototype
Date:   Tue, 19 Sep 2023 22:21:31 -0700
Message-ID: <20230920052139.10570-9-rdunlap@infradead.org>
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

Use <linux/cpu.h> to provide the prototype for trap_init(), to prevent
a build warning:

arch/xtensa/kernel/traps.c:484:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
  484 | void __init trap_init(void)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -23,6 +23,7 @@
  * for more details.
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
