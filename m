Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD4761DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGYQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGYQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:02:27 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B410E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:02:25 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a483c86b74so11065886b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300945; x=1690905745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYrN+166SJjRTzPRLQqH1H2WZ+LKvtSBI3v/6mM3uCU=;
        b=hrChsG2j3aO/+MZvFsd+AM7/Id1v2rKGK5YC4oZJ72e2vh5u4MmXnWN6fMuIPU6Zeu
         vC0IV4sgK10LAQDp+HihpgVi6mzxeQKGRYR/T7Epg9uXjnWdydoCg20aRI56QEweboDf
         VF68jZ9MmO4+MuKgAXA92ODu96KOv9mUUxDQ/UdWkv+/XjHsGZhKRm6/qZVl3/zLGVEI
         rAWqI4D8K3NVFYHzC2MUuMiawy8xA/uIw69pImznQPACYQunx+eDC2CQiLE6UdfxOCu3
         SqK+gJ5ZXJ6ewTWdTZpTDFoPI05KGj5DTA9uSRHPx6kx1pc8NecKwz6n8VT8K1VMSM/0
         FxxQ==
X-Gm-Message-State: ABy/qLZD1B+QlrylNc6zo9/O1d7fBFjRrUJRQeTiGhFYeXx65ZYnawWs
        bVF6yrZeCD7G86fo1czKw3cG81Li58ScpUdy12ZZbdnRgcEx
X-Google-Smtp-Source: APBJJlGXkX52G4eXyHWloF4CzCkRRIJE2m4tcBzyC92qEloDbaeV+IlGYdkjXcsjD5bzKsqPKNjZ3k70G1Mkz2BGwHGW0DFNLB8H
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2025:b0:399:e5c2:f7d3 with SMTP id
 q37-20020a056808202500b00399e5c2f7d3mr27685378oiw.7.1690300944879; Tue, 25
 Jul 2023 09:02:24 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:02:24 -0700
In-Reply-To: <104261.1690298950@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000621765060151db5e@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
From:   syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com

Tested on:

commit:         b6d972f6 crypto: af_alg/hash: Fix recvmsg() after send..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11736cbea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cdac84c489b934f
dashboard link: https://syzkaller.appspot.com/bug?extid=e79818f5c12416aba9de
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
