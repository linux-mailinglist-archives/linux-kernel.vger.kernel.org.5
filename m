Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01A78B0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjH1Mpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjH1Mpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:45:43 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D9107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:45:40 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26cf9b8f209so2569285a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226740; x=1693831540;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/ceIpXVZFrgxVjBUvVH/NEAlnCpB7YAjfUkblc/3cM=;
        b=FrSPlv1CEjqH0zQUD5MDqOKiee2Jx3Nm3Sjos1Hb8YBnQBjK5IoQbMK+kxSK+mCG6O
         wOPP1CTeumvKky57ehqGPiWaPacB+uyizUASBNLu/KAStjqhCp8xIQMGhrZc53nctPIX
         XmLEIAISxOgnMbLB/sWd3isJHnGoHqbyodwmAtbt7p1nWPDmTVSPQ5T6pJFjeNs/iRU0
         2jnYz+qTDXnT8AE1LZttFxgXbLfDpiVtOHa7obDcW+3dcJRYQiPKTyBolIdFoSKHy7FN
         3bxeUaj2JjcX5AEOy2/RQ9l73633iA9w3y/NLu55ZcH9thHJ44Vj0HNVP4LGRS8ugFLE
         ogLA==
X-Gm-Message-State: AOJu0Yz4U+/BLJUraNZQu2qaIdJQZdqjrNXYNz0S0BpWtWQ7kWr01/Ot
        KvYDS7jK6UcZ/19ysNcQCRUelppWJDCxjy6DuQX5qrwo0M09
X-Google-Smtp-Source: AGHT+IHTGJOkybd3N91QptPVnUV8iZqdibUTWWNTiUmwktoEukDDEVGQINorX535zDzqLPbwS+GOpEFetmSeDYF6LbiZg4AqCZwL
MIME-Version: 1.0
X-Received: by 2002:a17:903:22cd:b0:1bb:cd10:823f with SMTP id
 y13-20020a17090322cd00b001bbcd10823fmr8954521plg.5.1693226740000; Mon, 28 Aug
 2023 05:45:40 -0700 (PDT)
Date:   Mon, 28 Aug 2023 05:45:39 -0700
In-Reply-To: <20230828120159.4032-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005caf360603fb1218@google.com>
Subject: Re: [syzbot] [ceph?] [fs?] KASAN: slab-use-after-free Read in ceph_compare_super
From:   syzbot <syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com

Tested on:

commit:         2ee82481 Add linux-next specific files for 20230828
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16f4022fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=2b8cbfa6e34e51b6aa50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107f7affa80000

Note: testing is done by a robot and is best-effort only.
