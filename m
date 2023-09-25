Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE57AD7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjIYMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjIYMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:23:34 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD711C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:23:27 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c4e6affec4so3799878a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644607; x=1696249407;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iNcZ5zijc+BDIEdK/BtEaL1weMF5ViVNMuCSLkrE8U=;
        b=mDLJYXVbPWUKA5jp4g+q62Fo39WVCtUnbXGOrAvKs5ccHTRRICjtyv+AOZqvQcJt1J
         xHOHozI1J/v5hYVwnN/0+LdCf6hXrQCiF1fR9/aUOkGWnbdggQd5zTD4xBP4aFAAPUzx
         EPMmQumOA2GJzlZs04faCJbyyYY6ApuHwa8xY+djrIUmIAKvzIpEvJ6ioObwDZOKyXLG
         g0vMsbXpAP7zRv08j0wlS8+GWi7KSmRQgifswCQvoYXpugnD5MDdLVrvOtEo3s+C4NHg
         HwvL0kYH3j/rdAQtiIXNXIVVMxas5iTzxBpl33BXVJLQ29ncT3kR2VpcI7yFJGBhBCDl
         m0SQ==
X-Gm-Message-State: AOJu0Yw1J4sLZcy84mN6oBNj+veO+TcN9VlxmiHPudS++C5uPF0KjDQu
        3FrTN4BUKpZYSY1ATUwGvIfjhnOCW4ZLthT6vrskCrJxC71U
X-Google-Smtp-Source: AGHT+IGyvkjQ9cO/mdkwkaJhSs/gzVNcCXR+B/0vKzv6khVTaymurIySK9R4s6enJuxt0G3Rl4W+vIkxKeLKiVEKc+FtfZINJ8ja
MIME-Version: 1.0
X-Received: by 2002:a05:6830:468e:b0:6bc:6658:2d3f with SMTP id
 ay14-20020a056830468e00b006bc66582d3fmr2108410otb.1.1695644606985; Mon, 25
 Sep 2023 05:23:26 -0700 (PDT)
Date:   Mon, 25 Sep 2023 05:23:26 -0700
In-Reply-To: <20230925115457.1144-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076fc0706062e0619@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com

Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1690b7fe680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133c9afa680000

Note: testing is done by a robot and is best-effort only.
