Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4773F751D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjGMJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjGMJVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:21:01 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DAD1FD2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:20:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1pxZ4XhLzBL4kD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:20:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689240050; x=1691832051; bh=G9hZ118y49/e6QnO3PWztTQoN47
        CAeEbEM8a42o8+jk=; b=aApArLaxvsRQM/visnft8ugfJFLieIicyfUTbPFs3AM
        5umvnATtP2SXfDRxgQiA5uJid+f7EipxMk7IiMOj1GsbpoCz8DA7qBh55m6NL007
        P1BFCD769mfsq66lpJBWbRn3R0nvB5BehzZJGwaDutImJxbLrDT0iqITrnqkDjXC
        4k7hisK6CtUdCSljv+lrJ5fCinAwnTMKqodWpfIM+zOB37XM7aWQHplG5FAKAX1y
        Ssx7B2yQxkHX5RkNDx+Pqz1RS3d8oUfhGEOpRTSQhI4K4rqhUw3mPDQik4ySnoFa
        7e5OUS8ZQB3M3NRRVFaPOosb1ZsepxigG5ytw1QW2cg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OK4JxWDsPvJc for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 17:20:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1pxY62g8zBJ96K;
        Thu, 13 Jul 2023 17:20:49 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 17:20:49 +0800
From:   hanyu001@208suo.com
To:     tglx@linutronix.de, peterz@infradead.org, vschneid@redhat.com,
        dwmw@amazon.co.uk, akpm@linux-foundation.org, npiggin@gmail.com,
        pauld@redhat.com, vdonnefort@google.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] kernel:  convert sysfs snprintf to sysfs_emit
In-Reply-To: <tencent_48D17833D10F2D6A2DF87986804C357D2506@qq.com>
References: <tencent_48D17833D10F2D6A2DF87986804C357D2506@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ef672732fbb865f338d88db89fc11062@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/tty/vt/vt.c:3942:8-16:
WARNING: use scnprintf or sprintf
drivers/tty/vt/vt.c:3950:8-16:
WARNING: use scnprintf or sprintf

./kernel/cpu.c:2920:8-16: WARNING: use scnprintf or sprintf
./kernel/cpu.c:2907:8-16: WARNING: use scnprintf or sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  kernel/cpu.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ed65aeaa94b5..1a9634236b54 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2904,7 +2904,7 @@ static ssize_t control_show(struct device *dev,
  {
      const char *state = smt_states[cpu_smt_control];

-    return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+    return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
  }

  static ssize_t control_store(struct device *dev, struct 
device_attribute *attr,
@@ -2917,7 +2917,7 @@ static DEVICE_ATTR_RW(control);
  static ssize_t active_show(struct device *dev,
                 struct device_attribute *attr, char *buf)
  {
-    return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+    return scnprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
  }
  static DEVICE_ATTR_RO(active);
