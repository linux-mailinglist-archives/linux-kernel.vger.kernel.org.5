Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A467623FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGYUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGYUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:54:32 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463541736
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:54:31 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a44fae8668so12496725b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318470; x=1690923270;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ejXN8AprGfR9AKwncAkWUXzG2HufstQa8B4GIZTWak=;
        b=kFJWmW30upRwjm3g8bK4SbzkM0kUdoEouOLXVeVTSU2QeAyJny3a9ng8vag591FXx7
         dbIVb3sCsVsGAEiUXjqFDwLecfP8DMUXEz4Dxa2SdN2+mGFQiCrOGnSm8h9rXundSViI
         uhPhRgv2nucWRlAQPVNtuxuNAclA1kwRdCkUjKyrcNBtTiQB6RqwiBqTBdGszOhwXGT8
         cQBsVMQVeXU2WcQoxrWMVIgWSDM+h7EmNNDiN4/B5XKWfrynjxWEadcWVamCFXrCYNA2
         N8O/CJhAxE/QTL8a3Qy8n/s95sIkj3CGjHOjWYY0XzuDAR3n5xXO91ORpMehbB/xP8Ox
         4JuQ==
X-Gm-Message-State: ABy/qLb7kI/WJ0Fm5ucYlchriEug/VjYgwkpoYQcLmxYI0R5zQxIonGK
        sPJravqJC0tMmU8sPbhURjnI9B59WIEuvKlcvMzF7pG3bY5j
X-Google-Smtp-Source: APBJJlEAhGZsDAw1eV8ttcoRM6LfzdrAit9J+xnGqJEmT0WVX486CF3ugoLM5oopuezFNBGg4HpgycFZVy3v4L2h6DDPN1vlcyrd
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1818:b0:3a2:6d0f:5b27 with SMTP id
 bh24-20020a056808181800b003a26d0f5b27mr90950oib.2.1690318470652; Tue, 25 Jul
 2023 13:54:30 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:54:30 -0700
In-Reply-To: <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000276a060155f0a5@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
From:   syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, khazhy@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com

Tested on:

commit:         6eaae198 Linux 6.5-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.5-rc3
console output: https://syzkaller.appspot.com/x/log.txt?x=13d77b76a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7b1aac4a6659b6d
dashboard link: https://syzkaller.appspot.com/bug?extid=18996170f8096c6174d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1339684aa80000

Note: testing is done by a robot and is best-effort only.
