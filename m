Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A075D968
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGVDYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:24:31 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328F3A9C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:24:30 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a426e70577so5406718b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689996269; x=1690601069;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uMpkW9PNFASXIVqr7+hyKcuKffGwOiHEGnUez/1NMk=;
        b=ly9hzAgJdfeTD18rAH5Ua3O/ejRlhyuyyb4jhW3VnX4KPOhsPPMO/r/RvDdW5L7VBJ
         +QDBX2Tx1LoqJf18eM5PLBmiQy0hI03RkiMFjilqXaObMKO3QHrF/cEud1U0dZNXBihI
         frNIl4iFzpfPMfRH6sQ50UH5Puas3ILzFQjbU++vFPGYrPCmJUpEpFvBBEWOX5tmCo0v
         qskLwuMYUDWe4HaC/Id4FOZcCWK6kyvJQdNoHiJfApqoWqgQK58vlV6vLnxRUELVGA0l
         P3rAU0DLFhJ8isQJPAd5a7U1hthMgoPzYm4Hcvf2aLGgNp3HCWHJGgWDvjDccFd6SEM3
         godg==
X-Gm-Message-State: ABy/qLaSJ8O0RPi+Y2SloOyEJ3tjDrNkQ+/YhuORfqxW7xs7VAVujyNS
        72HCduxyY9pS3mxEw7sgNG6XNN/sDH+sWRNWmPylrvPBF5pd
X-Google-Smtp-Source: APBJJlHEbKiDXIra9MxuYQ8JaBpxr3BvA6/03IGYbI5D2xGBTkrcpveOFaNsEGUp7xNyzvZbRAiTUtcs9o+UIl3mgKABtr42F0Wr
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1818:b0:3a1:f2a4:3d7 with SMTP id
 bh24-20020a056808181800b003a1f2a403d7mr7781629oib.1.1689996269483; Fri, 21
 Jul 2023 20:24:29 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:24:29 -0700
In-Reply-To: <20230722022436.599-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000507c8806010aebbe@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
From:   syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com

Tested on:

commit:         03b123de tcp: tcp_enter_quickack_mode() should be static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11086ae6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=14736e249bce46091c18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eb6176a80000

Note: testing is done by a robot and is best-effort only.
