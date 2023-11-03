Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6657E0313
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjKCMnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:43:14 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0783
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:43:08 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3e82429edso2725841b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699015387; x=1699620187;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lbhu31MhA1YXeNnLYux6abJaN08Cd7UhA01GSJ2GlXg=;
        b=p6+Fa8qvhydQmpWEHgJo8yi9TwBy6PxjljiyAINHIwNPaApulXVFUmefJkz2EVM6cR
         XZ5Nle3oAB7pSVbf69SwtJQ+4jGJSwfiM4UC7DqKKklVLEcc5DEtGJq5mPCh2Ff1vkoR
         76Pd5M+eG4/OZYF29ybN0yM3W9YuOXzO1AasQRi/FTcX3pmmmOGnuRsQU5/UWGmmXtRX
         XP2hlNY45vfFEcGqSe83vrS+WofIP/+qpSYxLp1cJdLD/3LtPKxaJFdl7++FS+EZ6uOf
         /8FpC6zBS3KNDsoQ+L/bgp+sQbubTrXLbpudReyy1YUv3c0cum2LO/YN+yBUZBtFI1wn
         IquA==
X-Gm-Message-State: AOJu0YwIrq1qAgKo0ItjgZdQ9HUYSp6XYe6nfmaZVFveiNFn10sVK71C
        zcWdmh0xjkY8Ad7GQoO5P6/rtC7kyQEdRCfg/7MHX5n6y5cz
X-Google-Smtp-Source: AGHT+IEZR/pdbk5JvYUwK90x+VVK0+JdpBeaQFLRAIE3FcnswVcHp7SfSJfY5xO1bPFCDxx2VFlD1cW6tFPdFkYHHvBoYLOH5BUD
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1801:b0:3b5:9545:cbbb with SMTP id
 bh1-20020a056808180100b003b59545cbbbmr76260oib.5.1699015387512; Fri, 03 Nov
 2023 05:43:07 -0700 (PDT)
Date:   Fri, 03 Nov 2023 05:43:07 -0700
In-Reply-To: <20231103121804.1421-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4069f06093ed844@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com

Tested on:

commit:         8f6f76a6 Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=161b7da0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d92e85443452007
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c40987680000

Note: testing is done by a robot and is best-effort only.
