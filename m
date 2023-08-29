Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9478C5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjH2NeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjH2Ndj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:39 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F24B10A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:33:34 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-56fb25fdf06so2920089a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693316013; x=1693920813;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLOlQGj/8AjYy0iZLC8CLk+UzIA8dvcDP2aqvU4OpBE=;
        b=HcyN3K+Ja0Kt8UUr8oOBK2mpiJvX7uFT9TB6c6ix1Oy11lTx07GFpncOCtStSrZ/pK
         zojflKwnM0dYy8yG2/X3unh5twFgae3SybOa78IVSmEaR5PlvMqoRuDs2VX/I27Rmzqr
         qbWoAj58IcihcB/bWEiTuckhHlWk1G58/XoI6pijs4IJb6cA8zfcxKoB+jb3k6RAjQSf
         xh1lOOutY/zWu+yHBFkm8DWFIcxF8dcZ2PkCSL+9JMkVksHJdVfU9c90gJW3XCkX8gb2
         go2/Mk9Dr4ABpybKs6jo5h49HyPAx3aM35PItUt1/RPX3iWP0PrM2NIhz0fmNdsGjgtn
         lI5A==
X-Gm-Message-State: AOJu0YyHUuUgjPBgaF/aJHRpmlM6jg2kPASXhLGLN/73P/wg+pRGO3+q
        +tN9Ps0FIKaDenGhyOcs0AwHzfT6SfU7VjQlwVI/ACiQGMMJ
X-Google-Smtp-Source: AGHT+IEBBJtjm0brhV2WKPY9jGiw2W7iw/TcOY8M4j5MElSdgLX4no3DUU2hmn1nFpZXIj6snSEjn4sgfJi0OBduyX8zJPmGWw2Q
MIME-Version: 1.0
X-Received: by 2002:a63:8f50:0:b0:56c:6b2:95bc with SMTP id
 r16-20020a638f50000000b0056c06b295bcmr4552003pgn.6.1693316013692; Tue, 29 Aug
 2023 06:33:33 -0700 (PDT)
Date:   Tue, 29 Aug 2023 06:33:33 -0700
In-Reply-To: <20230829124922.4237-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d1dd506040fdbcb@google.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_close (5)
From:   syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com

Tested on:

commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1469ebb7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9678e210dd5e4a5f
dashboard link: https://syzkaller.appspot.com/bug?extid=e46fbd5289363464bc13
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12df4c8fa80000

Note: testing is done by a robot and is best-effort only.
