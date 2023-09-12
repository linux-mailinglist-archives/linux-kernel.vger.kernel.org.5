Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0C79C673
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjILGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjILGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CBE79
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zbrCXhzd7dlCdPFOGh4V6OMqKmmy+kOxT9jov+gCma0=; b=ywyBmmXwKLgz3qQ5pPKg/H/4xA
        U/xnt1ZJiixSHgnC98pN5zrrATpjZEwC+HL8qOXw6pNH4rPeliD1oLFQRel6rpa6Iwl4u6+78VAnO
        eQiWx2l5zTZRdcN/1pIaLc3lNgmX9QHoWUSO3c9H6KCmqKaSi16H0O73FZ3q7nr95fI9ys+f0fxUO
        YoNOmNHOywvtoXMUwxtn+FNCRqgqAcWRPO/tBq7qcaYaavmqzkjDs2jgDII7EME3cHt/JWUlIiG8q
        eZrNmsqGZNP0bSfyEFkxK1gyjkXGBKuE6QbigSHs7jEmw3cL0p2Cal6bwKk+SdHgiFSVlRF8esrov
        z9Pu1khQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfwZT-002Fgt-1s;
        Tue, 12 Sep 2023 06:08:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] pidfd: prevent a kernel-doc warning
Date:   Mon, 11 Sep 2023 23:08:22 -0700
Message-ID: <20230912060822.2500-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the comment to match the function name that the SYSCALL_DEFINE()
macros generate to prevent a kernel-doc warning.

kernel/pid.c:628: warning: expecting prototype for pidfd_open(). Prototype was for sys_pidfd_open() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/pid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/kernel/pid.c b/kernel/pid.c
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -609,7 +609,7 @@ int pidfd_create(struct pid *pid, unsign
 }
 
 /**
- * pidfd_open() - Open new pid file descriptor.
+ * sys_pidfd_open() - Open new pid file descriptor.
  *
  * @pid:   pid for which to retrieve a pidfd
  * @flags: flags to pass
