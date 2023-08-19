Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364978174D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 06:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjHSEEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 00:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHSEEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 00:04:31 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7492D5D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 21:04:29 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68927d7a832so2082507b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 21:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692417869; x=1693022669;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB4kkEtkr5jKn6ilhFlGQiut5s971YnQEWRoIE/M3os=;
        b=lPOt/Sqp9uJPxgxKf9AJQ6VIMkpIYob7p4stpJcIUXLwzBYMrh5Cv34HoAlLFBJd5Q
         V3tJtZgLF2/BO3CNbou8Q41zB9TEyiI/91N5RQBeTCf0xu2xLzruCaRhpBs5dXT4cf2C
         AOpyIYdIzox2gpOhPf0MCs3jj9wj6VmD76ug6RqHixwZxwjaWn2va9PyPVialUUNYgx0
         RHndKIvOMFdowcvGSGP9FxGbfC1QrNoCQLwknM0FqVT8GIDKvBXFmPusFC5NQ3SHyLD/
         RPrsAp66u/eHbMgOgfxdBSnG0eaFt2y2GMkdPQviS4JKr4e1BC/Gj8LyGpcdXg6B1lkP
         Qxfg==
X-Gm-Message-State: AOJu0YyqrBUQ+ogmVdWAlS82sMMzmOTRZACNfZcGgm9jzCa3gv7XjUNX
        XTyrpx4AW6KlQEATTQQ/N3kY0xrBJypcrg7Vhpwn0LaAFMAR
X-Google-Smtp-Source: AGHT+IFnEEP4BNhV2DvwWeJuHvGyWXjYQQYu3M0kNZGPZaU5L0VTNZTo6kLkYWc8qmNmAHzDltWvvm+25/tIghHEEtdph7zlzQbi
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d9a:b0:675:b734:d2fe with SMTP id
 fb26-20020a056a002d9a00b00675b734d2femr584446pfb.3.1692417869207; Fri, 18 Aug
 2023 21:04:29 -0700 (PDT)
Date:   Fri, 18 Aug 2023 21:04:29 -0700
In-Reply-To: <20230819022515.2269-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7e10606033ebd01@google.com>
Subject: Re: [syzbot] [hams?] general protection fault in prepare_to_wait (2)
From:   syzbot <syzbot+666c97e4686410e79649@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/netrom/af_netrom.c:738:41: error: passing argument 1 of 'prepare_to_wait' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/netrom/af_netrom.c:751:29: error: passing argument 1 of 'finish_wait' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/netrom/af_netrom.c:798:33: error: passing argument 1 of 'prepare_to_wait' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/netrom/af_netrom.c:816:21: error: passing argument 1 of 'finish_wait' from incompatible pointer type [-Werror=incompatible-pointer-types]


Tested on:

commit:         ace0ab3a Revert "vlan: Fix VLAN 0 memory leak"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=666c97e4686410e79649
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138bc6e3a80000

