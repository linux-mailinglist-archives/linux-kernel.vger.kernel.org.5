Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9E7E02B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjKCMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjKCMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:21:10 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F413E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:21:04 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b56a1374afso2645697b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014063; x=1699618863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c84zPJ+s2Dh2bIn4Arbfu+7t45KKVVrdkzXj7SRvjPs=;
        b=LiBTWDrneeCJfGFe/iCjMctYykyz3TLzXLL22s81txYqLbK2uCALkAVnkFzRlGyN30
         Kq/KKRpvTWX7YKF2ekourcG39QhHP+nJPMS4gj6MIWXkD9Bq5tgTcyO4/btsS1tWAVjj
         WA5q5phlqWGt1YwNYW2ZDDsNua0D5/DLoJ1Y1nejWMZ2GcheQDOkN/3W/8K4tuX1GrlB
         svUtcjTCRbADSM+mS9ADaD/n1bP1QDPOu6UB8dg7AiJuZNA+HRP94hJnyDVdz/fnLQJp
         CDno+kt9WgA1GYWhNjiEt5IkEWgVVwDPNR8wTgh4XAsx11ukMeSxkj5MI99iLlPEgCzB
         xFSQ==
X-Gm-Message-State: AOJu0YzbD5axoEgyqorXbbXsaz+PwIorpRivO/p66ffCOyaJN1xRYk3+
        9HhMiu4hCPVPu93NTPO2qmz56yHz8v1ZUaUO1OUXT0oU13VY
X-Google-Smtp-Source: AGHT+IH3L4CTkXdMf2LJ0DuGhPUdIZyw3ZJnko8vVwyWpKuqvoiCWHRF4cbLsb2FxNb8c9hqXTz4gInjVQ59OAnj6BGgrKlZXldT
MIME-Version: 1.0
X-Received: by 2002:a05:6808:114c:b0:3b5:6462:3177 with SMTP id
 u12-20020a056808114c00b003b564623177mr4095213oiu.10.1699014063794; Fri, 03
 Nov 2023 05:21:03 -0700 (PDT)
Date:   Fri, 03 Nov 2023 05:21:03 -0700
In-Reply-To: <20231103120103.1304-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdaf5c06093e8951@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From:   syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com

Tested on:

commit:         8f6f76a6 Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17f42af3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94632a8e2ffd08bb
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1700153d680000

Note: testing is done by a robot and is best-effort only.
