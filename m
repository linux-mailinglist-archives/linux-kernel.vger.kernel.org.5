Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698BC7EAAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjKNHBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:01:09 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA635D43
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:01:06 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so6332469a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699945266; x=1700550066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCR4Q3fKVxu2AdFzk7XvFBQsxAoGWg5LrAXrHNTUeA8=;
        b=LyY2K6o8qp5iyRJTI5u1FRERtEVx+LH9HXDdz0rHK6VHQNR992uIX4THrIvCOfQUHz
         ScvQZly01KP8dZf+Xe+dZjzKa6SKulWHpjXNEmx0h8EXGD9rVI6Eg4T3d3wOzLPtMo/S
         wHzLuGY/M/G+Zd3qu2GkrpMecCP7gbElcMxkgKBHmFoispQg3h0H/UV/eF+2itcrHpV4
         ifuSt8eeRVkareTru2Rm53YKm19aFD5IGHOVq3O6QFbtndR+59M8cO+KtZYs++lMN6SA
         Aqrh9tZtgrrO4pBJWGQTRpiyQeZLyA+Uxjz0zKpObDqaM56rH7uAdyRuOsClAQj7t24Q
         1g/g==
X-Gm-Message-State: AOJu0YxkLPazuH/58OI0IcV1/6aHG24Or1QeE27HQk7nI/Poq9hKqTtK
        AF11zm8A6Aukkg00Sus9FOAT06HlGQl237MQrKOAigRUfzs3
X-Google-Smtp-Source: AGHT+IG570ElRdror9b2ECV+fYINfoaZwF1/MaTFwIrZQOmI3Oaiiz4edSrjOnyUcJkFd43d+wAkhn2G2LzzGvKVcK+x8mSZ4Bev
MIME-Version: 1.0
X-Received: by 2002:a65:6842:0:b0:5bd:d409:16ef with SMTP id
 q2-20020a656842000000b005bdd40916efmr330234pgt.10.1699945266143; Mon, 13 Nov
 2023 23:01:06 -0800 (PST)
Date:   Mon, 13 Nov 2023 23:01:05 -0800
In-Reply-To: <tencent_4E6E9E451B0D4B3A1B7425A7BA7BBB2D3308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9e973060a17594e@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com

Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12dbf797680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15986fdf680000

Note: testing is done by a robot and is best-effort only.
