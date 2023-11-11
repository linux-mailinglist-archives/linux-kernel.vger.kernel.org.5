Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4097E89A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 08:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKKHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 02:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKKHlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 02:41:09 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C847111
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:41:06 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc2be064b8so27811545ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699688465; x=1700293265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iaux92PJYZTL0kp1IwDlCOwvY0ZFwenHEfGoD4BOQs4=;
        b=RFfNq9Xw7W7gs9zyaFnaxRIvKKtEL3IJpzFcejCYKbQiHJSTzX8EwMumHkq7+FPZFu
         r8IE20synaj3jUUN0XBsXivEhMezL2QTrQ0LqAAi7jPXiMZA0WDqqvJr4mQmt8DcdXkk
         LidSlnRC6dI1eip4GBU5x43suQIMCDaRUbL7hMC3hUGuLmC/J6I4QSKS2AA4AtbEuA3T
         /AxqL3qpn1WqlnxPd8zwYaRG2yf1LDDY3iQ7RUvWDfv8MbcsaIMPk6Wd5CLIwrKQ1MR4
         020Fm5z3MFbbIfp1Jkfpm+IaDjIbps1iwCh+hvRrXLlNwA/VTytxKyEiWCuotmNpJoSU
         fp9w==
X-Gm-Message-State: AOJu0Yz2px0tkjkjnmpGhCVzEVnajk4YV/kWYuCZPbMv5YA4Ym9pDfzK
        epBbBE/4A9YpB1CDzFziGLZ1NZw4W2W9aW1kKv3+rRmXgxY0
X-Google-Smtp-Source: AGHT+IHQWifihUiNyVnvsKs//g/oiz4HVTr9Kl7hnFONToJAY+P+vFwYU+axvlEQvkjU4QJKOVTuqfprUw+ahRiLcfzryPRNAfe1
MIME-Version: 1.0
X-Received: by 2002:a17:902:70c8:b0:1c9:f267:1661 with SMTP id
 l8-20020a17090270c800b001c9f2671661mr1196913plt.2.1699688465591; Fri, 10 Nov
 2023 23:41:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 23:41:05 -0800
In-Reply-To: <c124498e96926ac872888f6aba09f9b9@foxhound.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003874fd0609db8f57@google.com>
Subject: Re: [syzbot] [block?] memory leak in iov_iter_extract_pages
From:   syzbot <syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com>
To:     jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com

Tested on:

commit:         5a6a09e9 Merge tag 'cgroup-for-6.7' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=126ba588e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=492c9379bc08e464
dashboard link: https://syzkaller.appspot.com/bug?extid=cb729843d0f42a5c1a50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168693e0e80000

Note: testing is done by a robot and is best-effort only.
