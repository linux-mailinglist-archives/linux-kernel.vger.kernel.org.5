Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8A7ABDBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 06:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIWE1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 00:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjIWE1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 00:27:01 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B908819E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 21:26:27 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-57b637d9e4dso3615373eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 21:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695443187; x=1696047987;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+urzTS0c8qoXYHkWWE5inZQMq8BUkH3T5tVlj4SJuw=;
        b=bwL1F0I8vV2Q1LDFPxABdR6XS8nr2v9x7dX7xUOeZ1q4Ym15JksBj7fFeomJKU/n52
         d5/fV7gd3CcHixw5x7xzj2pq8QjCOJ+vEPHUYXrxeDdub/+VezQvGcyGj5h4OtvJ8NK2
         X86w0UENZQdVjCeTBxEBkuxJKCfALaVGn63YKN+Jo51MFHiSgRv14arB5NrYyjEVDG8U
         rP+ZvLS02Xu4yoI2YtoZYn/i2fjLq9nJmNf9uGP8ztcQXAPQBiivNl1Bz9//dphT/8LB
         X8p2fL8jvfrXCYzqR/w0RcF0uxg56E1JNZObieG5Uw6wSKd8q+v/JGAQ6InmC/Pd2XH3
         Fi3Q==
X-Gm-Message-State: AOJu0YxfABhaI5uXLJtW+BYNRjZ3UUc6WLIG0GoBaJyErYLLZyxTGWU7
        QdDBkXbcpDEBN1QfZYPULOF9KB60fVch9Dn456rOUzrxftgq
X-Google-Smtp-Source: AGHT+IG9A9wXCa7gBMcTNsA0cX94sAKGnP7/9l0kt/HvDjq41JnyaWoMbXQBCwU9/UVq4eEvgF/5kk14OxoP2EyXuwCNPm8clScY
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b2d:b0:1d6:899d:6eed with SMTP id
 ds45-20020a0568705b2d00b001d6899d6eedmr564132oab.7.1695443187031; Fri, 22 Sep
 2023 21:26:27 -0700 (PDT)
Date:   Fri, 22 Sep 2023 21:26:27 -0700
In-Reply-To: <20230923040320.1384-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6665c0605ff20f6@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com

Tested on:

commit:         2cf0f715 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15916ee4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a02f0e680000

Note: testing is done by a robot and is best-effort only.
