Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADD7EF42D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjKQOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjKQOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:12:11 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC488D4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:12:08 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c334d2fd4cso2386680b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230328; x=1700835128;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY+KedCYVj7LIbVkQ7Bkett0tOrVwI+eXcIZPLv81LQ=;
        b=wFYAr4QCvzN/HmKVvMsn0nIUlY2Ghzh0H7IwRMWoX1l6Zu3nmkYBNMKitJ+oSiV4P+
         A9WuYxgfMiJ4duBjYYzOGYhcMobzk1QEEUQe7g2P7IUdzdDXiSg73ded2UuAbBwpULrj
         eyqClJjHqL9eGmyJwwyuYJ8qUMgkdQ3CmM4OTfb18AVMY1xK7rZeWex5MJ9X11JmYkf3
         6d5VfDQEAtLBb142rwVzo+qRhel1/vdP9Fa3WRP2KItq/bnjF1faiGSPRyPPpfBn+ueo
         1noF9JLKE/2cS45mq181eGg2f7qGWkq4ealZPAplIxudiXRi7f3jUNDuw95cQGEmw4FP
         GQzw==
X-Gm-Message-State: AOJu0YxOZaVZSYoMH1HAMMWjrz+mU6vg39JwaeETS2tQbK5LkAia4LE7
        NZHuXaNBDjkvi90M0F4jvXvI5e40MCGPgQQe9A/PnNivZqoMgwM=
X-Google-Smtp-Source: AGHT+IEzH1kVXjtUdU9nuQOX1yUCV2JyqAAMPdcsx0aO8tWatnLGmQxqHubzlPLfBLvWnULZ0fcqdL6t8PEMGRfk4zYcyes7WynF
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:81c9:b0:690:2ecd:a5a1 with SMTP id
 ft9-20020a056a0081c900b006902ecda5a1mr4693412pfb.5.1700230328413; Fri, 17 Nov
 2023 06:12:08 -0800 (PST)
Date:   Fri, 17 Nov 2023 06:12:08 -0800
In-Reply-To: <CAJjsb4rmXhLyOFpNwQy1kh480Q7p=gvTY5HnhF-b=Sf=VijYKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2f318060a59b8d9@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
From:   syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
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

Reported-and-tested-by: syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com

Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13d4baf4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69e454cdc811976a
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
