Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588127E1824
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjKFAUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:20:45 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4502BB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:20:42 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b3eba1fc32so6344143b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 16:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699230042; x=1699834842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZQ78xmx/1eRfl04UsY8L//cVD5boCST8JLASCkpPAM=;
        b=t9C6hwN6R8q22+orByfisGve6zUH4hiJV6PHU/FLAUZ7UX7jYqWP4NELMgoGws4fBk
         BQRtkf4oorFqNeBrhQ+u3puwhyra+jxeOi/Qyj5/7/+TvaiSmg86E6EmQD5kZSbfVXyt
         f8ZA19HjdLMxUJaqZepdpSSmNqLgdIbXKn5CPwn6Jd9unHx5HumgsdYYku8OKfaT3VRj
         +3RKh4lpS8fF0gZxuHkNoU1XcRlK8XAKnspOUbUkPkg8N1TzDgsLmlJvl+V/J2f2gyN3
         wuReokZzGMVi1kzaeG1+37gigbvwz67ctmePCa7bLazTJQu2OoEVF5Mv8acyVKRVjgCq
         EYig==
X-Gm-Message-State: AOJu0Ywd6bkyu9lhW/9y9Ej0KmOnBbbtv2NiquHC0a49HmlvAXI01LmR
        cT+4jFTI6uh5pU7M6/ZpvljffYClvBQz36WpQajPckjnQFA1fiA=
X-Google-Smtp-Source: AGHT+IHj57wW+sCPUol7vmw7gJAPCqNkuxKdYor7AN3c9KjaHJWT6sbIKpj+fHnGzz+gjX4B4+8drv8bJmx4YYugta1DJ3QY/o9u
MIME-Version: 1.0
X-Received: by 2002:a05:6808:aaf:b0:3ae:2ba1:af6a with SMTP id
 r15-20020a0568080aaf00b003ae2ba1af6amr8868889oij.8.1699230042171; Sun, 05 Nov
 2023 16:20:42 -0800 (PST)
Date:   Sun, 05 Nov 2023 16:20:42 -0800
In-Reply-To: <000000000000e7b62806096c7d67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e304b060970d3be@google.com>
Subject: Re: [syzbot] [PATCH] null pointer dereference
From:   syzbot <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] null pointer dereference
Author: yuran.pereira@hotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 drivers/ptp/ptp_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..5b36c34629a0 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -173,6 +173,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	int enable, err = 0;
 
 	tsevq = pccontext->private_clkdata;
+	if (!tsevq)
+		return -EINVAL;
 
 	switch (cmd) {
 
-- 
2.25.1

