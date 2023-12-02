Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F76801B00
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 07:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjLBGZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 01:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 01:25:57 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550221A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 22:26:04 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b8b1e2c0d9so334250b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 22:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701498363; x=1702103163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kiIGIXfC4hdGM7E7SKzxLIpIZnpLaqp3vPdVl7mm0w=;
        b=uX9BDTRw8fpzb1EaBJd1nedq7wNDUBfNw8UPte3yjdyWdaTqUhhaHGnnR7jhBAp3gn
         d6b7nVsQpCp/oj89+B8RFWP3JNYlnrNVWELWcI17jKusYcxwGB0DTdyZZj/OikLHn3KG
         wszSk5tYDn2V2ZuhGVsqE2hIXMPirPIhapZTcw2SuUok5SWWdrvT00UIO4apyMIL8jLD
         BOztoQpoEoRYyu5TtbD1egsp5pUXT2CJ+kZ0O8twl2ziDXmkeH4Ck0B9Ci0Var4XL3ez
         fzybv069W1nAQZno5yDEqm6qwUTAJrW3MloUFaIm7t0g4pERvpo1NnMUH70nxGawpa3c
         27Dw==
X-Gm-Message-State: AOJu0YwDpdPGfV8kp5QADgec6eBfa1GR+YzLE6E7ZAjLqS5J9OJ2xGN8
        yDS/xB6TV76VtTXXj9S4t0+I7ljuP7Cw7ZI0uvmNWH5skKee
X-Google-Smtp-Source: AGHT+IFa+8LSMYpbs8x5Rk500DXm/kbAsIpJMEGcy9hBjSxETfNRsF7tvlAwCxmvHUuw0spDNW918Y9vpOHGk6z1MlRI9OhqA9Hl
MIME-Version: 1.0
X-Received: by 2002:a05:6808:168a:b0:3b2:e2b6:75a3 with SMTP id
 bb10-20020a056808168a00b003b2e2b675a3mr376495oib.6.1701498363733; Fri, 01 Dec
 2023 22:26:03 -0800 (PST)
Date:   Fri, 01 Dec 2023 22:26:03 -0800
In-Reply-To: <tencent_FDD15365E367E96523A72445B769D77D8605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e6c6f060b80f586@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From:   syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com

Tested on:

commit:         994d5c58 Merge tag 'hardening-v6.7-rc4' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159d7eb4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6e67ac2b646da57862
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c45f62e80000

Note: testing is done by a robot and is best-effort only.
