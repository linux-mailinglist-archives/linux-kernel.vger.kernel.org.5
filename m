Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1583A7DFE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjKCE3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKCE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:29:10 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F01A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 21:29:04 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b56ed16b98so2252746b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 21:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698985743; x=1699590543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awKvXfPj53fr1y2JlI6YfK+6Rzw/XidESDXgCWW4ivU=;
        b=nztwdw7pWLOhOB3vvuqrlGEjnO5ZePSP/kQmMvGehQ+1Xno2hmnur54q1rcw4t4aIi
         h2RYpNhnfeFO8E5n1bnqhUpeSWh2hRjV0wBufh72SljTBM5AYgAgVnVm07vwU8rOUzzL
         O2YBor8hf8gzdZd81EOOlTRrMZY81kR8RMBafQT6UxVbQN+30QO68nwb80SZYFhT5LZA
         8PVdcbXyxkTV8NXjuQf0SoH/A2IYfat4ZTNpg4Ogr5Uba5ZLfJQbpN5/SopFuHl171NE
         g5CRD6K1wU0/9ebqc7qBs7cXU9LDiPKHzjc+qZUjZJEVnxDBGKZd2DdbcM2RCDUb/Hhu
         X2uw==
X-Gm-Message-State: AOJu0YwQ4QIaIwlzv0WMG3vPOFUsOApxBgo+TW5ORKx+J3tz5nm419j+
        IVN928q+pLRxd+B84xmuEj7lrKAeI8nBzn1iRnq49KO1TU5rNs0=
X-Google-Smtp-Source: AGHT+IFtBDpG3aVqFa90M+uYGinCmy7xo4GNVbNS+EsAtyWZPRGghliquGoe3PU+NaSOP/RcjsJpZEuYZwDYsvfzZMEjmnt5P/DW
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3295:b0:3ad:eae0:3317 with SMTP id
 cg21-20020a056808329500b003adeae03317mr6296912oib.5.1698985743329; Thu, 02
 Nov 2023 21:29:03 -0700 (PDT)
Date:   Thu, 02 Nov 2023 21:29:03 -0700
In-Reply-To: <20231103.105742.1620986275332026541.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5af55060937f193@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in virtio_transport_recv_pkt
From:   syzbot <syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syoshida@redhat.com,
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

Reported-and-tested-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com

Tested on:

commit:         bc3012f4 Merge tag 'v6.7-p1' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1155ea23680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d70e93d6569aac97
dashboard link: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1431d76b680000

Note: testing is done by a robot and is best-effort only.
