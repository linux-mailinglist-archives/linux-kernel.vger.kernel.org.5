Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B584A7E7FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKJSAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjKJR7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:32 -0500
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392317AAE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:41:53 -0800 (PST)
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso2093517276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598512; x=1700203312;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsnkgbEpdDg3Y5saSEgfuvwe1w9UKcXGPzoLtYvvCII=;
        b=TJVA7zHpr798xAkIYffvAn1Twp/GEkNmiS89z81hjOK6YxIFJAikOpTZm7SsnWR1+J
         puqL8uctvBn1nR4QKRdMv80ecHjKudp+xIya7lf8j7GKCDh48YII+t/60YkVEA3+Kt1g
         CWf3TcrnuiAoIswJREfIq3gmCeI/SAI+tMgILQular/m2F02ZHFjmsqmMFIA4/twR996
         owo6sff9o+P+plaGbdPkbrw7Z8zrIcOFIGhI1SeZom4TtzMnGkRFrd+KgiFuRUO7HT/O
         lF7Q0byOW27cYUpxCr0P5MFg0yyr2hXF4fcNysy0YJVwESmjo2S53rjZIEJGLLo2vnx+
         KhJw==
X-Gm-Message-State: AOJu0Yz+lJJtz/cJ/vdqryqnxYQ661RC5b4re9oCfof5I10uYuol7OT3
        IV8pV9vGyGQDfDx0ugKdZNTfUnv88uUoQ2KKTgAMIRo6QPDW
X-Google-Smtp-Source: AGHT+IEdpTBO4qTa4KvQcIgYPxx3a5G26MB++9SyDxN1pG+orDMf+51ab9zMwaKOfB16KLTEjpW4emeBwt6qo+pDoj+YxiAmUH2n
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:791:b0:68f:d9fa:8585 with SMTP id
 g17-20020a056a00079100b0068fd9fa8585mr1018820pfu.5.1699594383830; Thu, 09 Nov
 2023 21:33:03 -0800 (PST)
Date:   Thu, 09 Nov 2023 21:33:03 -0800
In-Reply-To: <20231110044426.109448-1-kdipendra88@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082be580609c5a7af@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_bpf
From:   syzbot <syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com>
To:     kdipendra88@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com

Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a0c3c0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=44c2416196b7c607f226
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15592737680000

Note: testing is done by a robot and is best-effort only.
