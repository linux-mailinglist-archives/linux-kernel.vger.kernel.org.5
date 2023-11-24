Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2C7F73AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKXMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjKXMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:22:00 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355FD46
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:22:06 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28525981a55so1827940a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828526; x=1701433326;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGlpKjyHdXJMCE9jse07H/sdycXI5usF4UHXTjoyZFc=;
        b=M6fEDB85hnoQiStED3Wt/GUpa96r56AShEyCJpnzVBTUnd6W1ucXv6AJZPJza2OX+s
         RbYG+OxuuAnt4XbKOowkicnPR0yQLHwyjofmXwKTxvVLhe60liNY0GDibpl04Y1HTwxJ
         +9kA132qR71hlgeEep94t2QxDyDeREZuRVaYWqK1kqFHKEpEXF/TcydPwfjShbk8+SzY
         cJWn/yRgpFhZGKNDJHY/ZnYsa0HO3j7uIflrnL/Is9ZDGWww0iA/6CJKH4HZ002TQ9ZD
         eWuB3n+MsYjBXDSuYMBefFrWtnvYZMOvi9DrK/UsrdTH8nZc2WFhFfw7T0z3cY4xWoEK
         cw7g==
X-Gm-Message-State: AOJu0Yy/HfZ++n1iG7FBbZTZHWSEzF+rMq1+vWIwGkl5IDiHZRkCquvy
        w1fe4YqQyrOpsd7yhuiMcnAMler5RzLVvQmqRBoysrFTAxcL
X-Google-Smtp-Source: AGHT+IHRm4hlj5J6myoUjjyXeB6itEYPBCXIFOcX4fhilEZNjQa6RIGv3+4NckYbdVXyjhrnbN408pCHzdKZfyimE4JKYQq3bLjT
MIME-Version: 1.0
X-Received: by 2002:a17:90a:ee8d:b0:27d:2cf5:7eb1 with SMTP id
 i13-20020a17090aee8d00b0027d2cf57eb1mr529225pjz.4.1700828526423; Fri, 24 Nov
 2023 04:22:06 -0800 (PST)
Date:   Fri, 24 Nov 2023 04:22:06 -0800
In-Reply-To: <tencent_38DDEF5DB0192CCFD60D8BA5AA8DA1924107@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000243722060ae50083@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com

Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17a2cff0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b4f40ce80000

Note: testing is done by a robot and is best-effort only.
