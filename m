Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3BF790AB8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 06:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjICECj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 00:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjICECi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 00:02:38 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813A13D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 21:02:34 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a3de043b7so324310b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 21:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693713754; x=1694318554;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3msNeUFNbF3cRToU0yDwMk0B7gcrzdfEFzDsmVzUzk=;
        b=e754fSYWNvKjz22t8uHpNl4GNQLtZKAgQOBksAY9ktbzFR7hehWdaEN1x4sE7GSAPy
         Sg7PuIA1KUqVmaj6YdJuVrB1ffPueVhNGW6nScv2M46PFUNIn4uRZ895vVLfpI4Ke0NJ
         YAD4aISvYHvytlePrISrz3dCC8fp9lkIrAwtJEn+/t+wBoHntG9IhY7jVixbCMKELfpm
         xznhUP7udlF3B1j1gDhiHjEOrsjEQVjOWJBoZcK+KlDyKmd5alG/a2R2v72nS+9alJYB
         QuCPCcbi5ZGL4lQUoMSrjOQCKeFpnKAIC3xsF3H9jwBzprQFProJ8dvuGldlUvqCbKuE
         jCxg==
X-Gm-Message-State: AOJu0YxCOuCztrZ+uE4bQ6GkWEbpJ9BNuEPH8D6lpoSnWCAeObtKxQrB
        9RpJgigkhyWYVRXgNMs46wx75F89jp3JCgM3w5rQletw8MfI
X-Google-Smtp-Source: AGHT+IEFQP/Bu2MAd/1TwlN6CVsuR5e/LulDsH8cbkv04Mmgqo0mu6zW8EFMyD1h6pEus/+Rx+R5cQBZCwQmb0GnXydj9uKaYyMU
MIME-Version: 1.0
X-Received: by 2002:a63:7e55:0:b0:565:f6ce:9ade with SMTP id
 o21-20020a637e55000000b00565f6ce9ademr1290320pgn.4.1693713754282; Sat, 02 Sep
 2023 21:02:34 -0700 (PDT)
Date:   Sat, 02 Sep 2023 21:02:34 -0700
In-Reply-To: <20230903032002.5421-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ace2d106046c7627@google.com>
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_test_super
From:   syzbot <syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com

Tested on:

commit:         92901222 Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1547bf38680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c33cc29407ed9ff7
dashboard link: https://syzkaller.appspot.com/bug?extid=629c4f1a4cefe03f8985
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
