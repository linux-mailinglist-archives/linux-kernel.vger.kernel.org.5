Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2463F7579A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGRKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGRKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:52:31 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5AE52
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:52:29 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a1bcdd0966so9023995b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677548; x=1692269548;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2QM1yah3uVkGC4t5KiFlBJ2cFE5RZilyg0EMmsvX3A=;
        b=ECuD5ads4JnzAN2Z1rzrV9Ci/7HsE2/D3xXn0qY9eku9QW5d7H7oaB9JAtawAZAhyY
         xrp2AhgNo7TWhwkq4Crxdyv6fwikh8kEHafdfudhoHLVpm/gc7JaP3w8iskB7jWo3FlT
         2LdZA0UBGU5DUrcdKgQ8gwzD133Prrl7n+aIu8f58671QCFHlbBAINWMwLVeMmdKxRbb
         xCunIKaWSsSvTQxwO9sGXc9lulZMXS5cZyYGJXnxOjhx2t+3F5GYhr+iBcl2ehGmxDOx
         n3QBzInxtFcehmCoCzt84IPEjmTY9ZZffI09FJq8ggU+lStESNxamfm0fYQz+usur8wZ
         4uPQ==
X-Gm-Message-State: ABy/qLbZ5+PUZ/mAPWxz9lx4sZMcy0yLtp0EgcvHs+j9VYEkuOi3Ii5/
        VO9qTvW4bR7u/KVLPpQiFUZiWX5zu3wZ03/Ojy10h3rY+kqJ
X-Google-Smtp-Source: APBJJlGsJruhP1uK0owQZZvIvv32VUo7YjLIZEVZs0mCZa+xqRsBlP9wMkTOwNruw5Q9vKdFHGiWin71sDDy/vuUv4DtW5QkPlLc
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1785:b0:3a3:6f6a:17b5 with SMTP id
 bg5-20020a056808178500b003a36f6a17b5mr21371824oib.9.1689677548525; Tue, 18
 Jul 2023 03:52:28 -0700 (PDT)
Date:   Tue, 18 Jul 2023 03:52:28 -0700
In-Reply-To: <20230718102921.247-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000109c7e0600c0b6e1@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in vfs_setxattr (2)
From:   syzbot <syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com

Tested on:

commit:         e40939bb Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a6448aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
dashboard link: https://syzkaller.appspot.com/bug?extid=c98692bac73aedb459c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1464348aa80000

Note: testing is done by a robot and is best-effort only.
