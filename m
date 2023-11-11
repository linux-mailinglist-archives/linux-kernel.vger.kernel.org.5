Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE37E8958
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 06:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjKKF1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 00:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjKKF1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 00:27:07 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7711FD7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 21:27:04 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc591d8177so29173255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 21:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699680424; x=1700285224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DO+Xci56fkYIHu8bDuX3RcBBxUklF4BWAD/VEQZL8Hw=;
        b=SSgBcz4/P4ZC6ANnNOlAPdDBBbVwB55E+ao9zXgGufgca4BDGv45avTRB3fjVa9adN
         HSfiMFZTZCJSjOt98+2CKUA6T5KjJgtRSd1RXl0DKpt4euw8wbcYAxr9x3uO2Yo7w8Wq
         SgSSy3JWjUEHB9LNVgLN+JVhr5mAKmDxXfytDYKZoDc9XYuTtZfaLFhWm/uF4OqAzQYg
         u4EGW/Ja7iw0HmbqXP2KCikbI+JNliOVzTiBZx9YE26hrH60RiNVyI3jljqrWJ92LDXp
         nxqbSLMCWH4dXhxCaVyBuZFr5Kjs/mlFWrHhebFuM9Eqj5U9zvyEEqGJbi7z4QTXxmxl
         8ltw==
X-Gm-Message-State: AOJu0Yy0oY/uk1DIMt0Dh4782CcGRI01t8czPYai6raMkaAj9M4keb+X
        Qxq3CfdgX/D/MuRR8BUdroP0GKrTcXksk0RhfCVB2y8IDlV8
X-Google-Smtp-Source: AGHT+IGdv9AS5mOKLTPJ5VW+sde9Mizw+ia/sRrx9+bkTsekuCMgmU/xPeHSUJh8Nr/Vli4aHMDk2E9FsgsU5sPFUpe2he4pLJfQ
MIME-Version: 1.0
X-Received: by 2002:a17:902:9f87:b0:1cc:2549:c281 with SMTP id
 g7-20020a1709029f8700b001cc2549c281mr347211plq.13.1699680423813; Fri, 10 Nov
 2023 21:27:03 -0800 (PST)
Date:   Fri, 10 Nov 2023 21:27:03 -0800
In-Reply-To: <tencent_F30036224B00740776CD66FA3C47367E9609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4aadc0609d9af97@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com

Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13fa93e0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fb5fdf680000

Note: testing is done by a robot and is best-effort only.
