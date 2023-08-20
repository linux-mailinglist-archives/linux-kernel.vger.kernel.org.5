Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B9781EFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHTRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjHTRVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 13:21:12 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC51FD4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 10:16:38 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f51613d05so328717a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 10:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692551798; x=1693156598;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCSk00jAApWamdTfi1WTVOGP5cs400bLmhiOEbCKesk=;
        b=cFnvAKoeCjFLkIFketwJa1kf9a6XAMEnL129h+OUHNFGnXU14LbOsxWxSl/ALOiE5D
         aYc60CVtLoB+T2aZjkCEBZLUMN+gL+7T3TLA3kt+cc53mCE7oCDUf8UcogwU0xsjh3SL
         R46fBgWYoBvSlco1MnX9hD3to8enhOrxsIJMCKyY5VysD2xFakqopTaZV4XZ2TXw4jXC
         BN2o9QFK3aCrZltrcM+8ndvvVp6Apzf8FNxTsFBMdaSexjxp1AUYLg373VIkXI97avxe
         hZhRwHYeltpQBdNzoveLDMjs+D0GylsuxbbzfVa1P5TzhJE4whK3VvZcdKSGGvYKG7jZ
         E5Ug==
X-Gm-Message-State: AOJu0Yw0mwUSG1jQa0vxOdUNFbDRXoA1Iyc6EYxwg/ZxRPG9ttDYyqxA
        Q1sSAlNok23qAzHFx0J/L4jRNWSjDNgOWO1sr6LXQmdxPNs2
X-Google-Smtp-Source: AGHT+IGbFyIS9NDNfSrv5ROBrZBSPZIn7XTQBYjYL7hVeWwbUyvw2yfdQ7peX/lgKHMqNK63IFqFy3dwHdOqk0yKDRy9FVbvtwws
MIME-Version: 1.0
X-Received: by 2002:a17:90a:e38f:b0:268:3469:d86e with SMTP id
 b15-20020a17090ae38f00b002683469d86emr896563pjz.1.1692551798085; Sun, 20 Aug
 2023 10:16:38 -0700 (PDT)
Date:   Sun, 20 Aug 2023 10:16:37 -0700
In-Reply-To: <20230820163131.205263-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0609a06035dec44@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com

Tested on:

commit:         706a7415 Linux 6.5-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=130c1e5fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
