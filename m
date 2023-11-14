Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ECE7EACE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKNJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjKNJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:19:11 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD0132
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:19:08 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2801b74012bso6591303a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699953548; x=1700558348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4P5zriqq9zl057m/BWfVOzJfaI/sekxPSXqBh15LVY=;
        b=djEZMe9VNsyZvACx7pnYdpqIuvOqr5hjVPZW+VVqwxzElBRwnV17wl20iLsFTiI0+Y
         5lgJSlrDGaf/pf/20gls6JR42tfTquMg2eqFRQfv5dULVeaWHxDFGSKvQSbUgFgdxWbi
         w71YblWaAYnsOEJWanXkp1Kn55XnJVeQ0JdIR3KD2hQAdLH+rMwX0Pvkia+T4qpcky5D
         U2hUTTGAFsYoD1fvFnxZh6Gz7cnaz473IbEFZ8NnZAVDC4ZcLw9JgqPoX4mREs/o2YR7
         nTXX2JsNU3CchQV9sTj7Mv6US/daEOAWdcjLdguPo5covRLMNsDwHwaiagW+4KSVPhjo
         W+Mg==
X-Gm-Message-State: AOJu0YyUwP28Gl4J+oRycC8rSfQrlHWt1pWc3Gr1rVIlT7UbfXj4xR0U
        Fqe1QJyknfWXT9HSbSMu96fjBgIwXkFLKqHFOgBeaHKvHJd3
X-Google-Smtp-Source: AGHT+IF2TpQGa5xW32lZ23zjnRkeNTwpVAZj30XADoY9wmxhp/YBbu+pZsdQLDCZ0FOrLOK8BvvlV/V4TGl+8xi4HLxheSg3SHUn
MIME-Version: 1.0
X-Received: by 2002:a17:90a:4308:b0:27d:5688:23e8 with SMTP id
 q8-20020a17090a430800b0027d568823e8mr2618033pjg.4.1699953548215; Tue, 14 Nov
 2023 01:19:08 -0800 (PST)
Date:   Tue, 14 Nov 2023 01:19:08 -0800
In-Reply-To: <tencent_B296DE36444A84758D766566B63D7937F809@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000604eb5060a19473f@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com

Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16dd2f97680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1258c947680000

Note: testing is done by a robot and is best-effort only.
