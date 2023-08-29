Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F478BD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjH2EOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjH2EO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:14:28 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C79618F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:14:26 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-56fb25fdf06so2531401a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693282466; x=1693887266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMmYsu4NKdKT2dfIhw2ed+qjd72AlV6/9p3jOZJCV0c=;
        b=cKd44DzjIDsir3/mtKEgaRXYrYLl9wXs9DVPmX6hub4buZIT7wyjefpypT0WHBKBAQ
         JbtIzcSy2VNvldmOVEX6rCoTLe4h4jdzacHYLXPY5ZX0zURbPpurjGLX7/HC9XuALu2k
         ojtXMQR0RABVM5pt5eiE3z6yqVaw+GMEGgWjzyiRg5ekTfCJnH7p7z42Ke3CF46peWjs
         qZQZ9x/ipUBqQCsG+ODXrOuCnvYYPSoQc3ToAqe+RJFBcXaM8N+OjssV2Kz+0pUBCeuf
         W0O1ps4fz6e/7GXrEmpqlbRfR7ICDkWrGASiDnP2e5LBWRFBpZbA3Nh/zoJHpoSCqoE7
         6bjQ==
X-Gm-Message-State: AOJu0Ywvv+DMiYYFMIKIetYkBvMY54Q6n9p3ILOnxdMXI+9EEd/SzIt7
        4LK7AQX1squCKWs24X0uCEvRTRHKzVpPkTB87YLSChrIlbkx
X-Google-Smtp-Source: AGHT+IFtO0IOJ9o8ktQhkQF9NokqITfV9+8HmmNkvrcz2kEEOjQ/Gcg24cNQXFJ7Qec9Eumn7CfWSXGerddI/rNUg+wYu/hKy8HP
MIME-Version: 1.0
X-Received: by 2002:a63:3546:0:b0:55a:b9bb:7ca with SMTP id
 c67-20020a633546000000b0055ab9bb07camr3831261pga.10.1693282466124; Mon, 28
 Aug 2023 21:14:26 -0700 (PDT)
Date:   Mon, 28 Aug 2023 21:14:26 -0700
In-Reply-To: <e318cb75-510e-6cec-d35d-f29d920468f7@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5e02b0604080b49@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in erofs_kill_sb
From:   syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
To:     brauner@kernel.org, hch@lst.de, hsiangkao@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com

Tested on:

commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14f819dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9678e210dd5e4a5f
dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
