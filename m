Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9919A80E0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbjLLBEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjLLBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:04:00 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1CDBE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:04:05 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9fe44d7daso4325857b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702343045; x=1702947845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Uo537yi42lGKUzhjT6KApry/dN/nRJBXPwcU4D/f4=;
        b=pUrM0c/DXGwgv3PegOTbexxFd8G3Ga8Vo6lyLjkIFSiQPh9JVzPLBDzv5hORCFiafe
         PTE3OA4suA21MfKeLx3aHqNl49TacqQhKMwLWaXc+/8mw7mEsXlIGlk3tCWcJdjRQeDH
         nTVv/JlY2nVNf90Ev9hhGgMwqpvMX4JDD4T/mypPd0JtSyYB/tvj7t2LVstqnkZ/NlLa
         TvFWjIMMzAMJx00t/ItozkFm3hO0eJz9XM+J8SxyOS3Qu356ZKAahJzV3dumIlcH9vqk
         H9D8IsC3Md/GHWMfVoMx67eZ1gaFDFyNxoX8xdxkMkb9lnzNOGb/V5d1w46yI7Rl0aFO
         /hAQ==
X-Gm-Message-State: AOJu0YxfBX3qZdArAtuDN1yfjukBWJc+lPicL4RPhlEawpPzTGv/SUwL
        GQMjBk6h5hGuq7tqtcJzry3NugMUc7sFVHFvKDKa5JCWo5Y4
X-Google-Smtp-Source: AGHT+IE0bQapw9Sh3D9y1YyilvTjP8WEXh6XOQiEy0mKYQ+nLY8NsQhE9GT0uxeX+RwchUc0jSJeWeKEwvrOnXqwYL+zvdP/+pP4
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1786:b0:3b9:db5a:cfee with SMTP id
 bg6-20020a056808178600b003b9db5acfeemr5053516oib.2.1702343044965; Mon, 11 Dec
 2023 17:04:04 -0800 (PST)
Date:   Mon, 11 Dec 2023 17:04:04 -0800
In-Reply-To: <tencent_5FBE6E042F496EB89494EB7AED4ECD84780A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b2ab5060c45a0ca@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From:   syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com

Tested on:

commit:         bee0e776 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10fd0182e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=553d90297e6d2f50dbc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cf16fae80000

Note: testing is done by a robot and is best-effort only.
