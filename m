Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D647D2A57
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjJWGYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJWGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:24:29 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AD041DB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:24:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 392606017108E;
        Mon, 23 Oct 2023 14:24:11 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?printk:=20printk:=20Remove=20unnecessary=20stat?= =?UTF-8?q?ements=EF=BC=87len=20=3D=200;=EF=BC=87?=
Date:   Mon, 23 Oct 2023 14:23:59 +0800
Message-Id: <20231023062359.130633-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following two functions, len has already been assigned a value of
0 when defining the variable, so remove 'len=0;'.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/printk/printk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e0b4dd02398d..38031fd87f34b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1669,7 +1669,6 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 	prb_rec_init_rd(&r, &info, text, PRINTK_MESSAGE_MAX);
 
-	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
 		int textlen;
 
@@ -4188,7 +4187,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 
 	prb_rec_init_rd(&r, &info, buf, size);
 
-	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
 		if (r.info->seq >= iter->next_seq)
 			break;
-- 
2.18.2

