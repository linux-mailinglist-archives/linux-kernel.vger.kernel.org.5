Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C87EA8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjKNCYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNCYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:24:10 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD9197
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:24:07 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28047b044c7so6656806a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699928647; x=1700533447;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2huZFQ0aKcjZsFA0pZu383iRuElX1QEDMK4wXqgLESs=;
        b=faA2DS8/Rhf3TnUAlaUqSio1IGHeKmm2lXsprVB6pA9fF4Ql5gPyFsUkEosFt4FIHj
         PO8DHlLA9wfPxWkGng64Gv1NXYVPaDD/fPapkZGIQFom2LXpVgGzNQRmZHev4lA/Sp5A
         bSqEkSUpmFED9kQ3NZYNe0Wg9zbvilFJucx2Pv9cjHZx5btdnXtkytBqIze76mtkjvNU
         KG1eBi3WFyvJfMQS8kyTXx0O9XyCtfqwuz3tL4//WOQmdk2EC+2QXNdBkqEOCWiZlQW9
         njJhhNuujEDeBRW6gm845pqdptYRaZQxxSrj3jLcr/Cq9vplqAqGnXkmAdPX0bywWTHe
         289w==
X-Gm-Message-State: AOJu0Yzc9p0wEnnanOY6SOw4euXl2VZQDdIWsaRJAQDAkS8YJCuU8Znd
        fiOY6nI+z1A5xuh/CzAjsOhE2PoPXo3XNTlvDARx2M8hnriT
X-Google-Smtp-Source: AGHT+IFDnPDprdL207Xsq6va8QIaIfz/tB80rn/VzU8LleiKHm8V5RjKGEZxt8lUgbGM5xZOlVVV7hLH4i8RLCaaTqmEjbWoKHFT
MIME-Version: 1.0
X-Received: by 2002:a17:90a:17ad:b0:280:c97a:bdd1 with SMTP id
 q42-20020a17090a17ad00b00280c97abdd1mr2534372pja.6.1699928646921; Mon, 13 Nov
 2023 18:24:06 -0800 (PST)
Date:   Mon, 13 Nov 2023 18:24:06 -0800
In-Reply-To: <tencent_D1F5A5B90D9F92385D8CDDB91914CF868D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024b554060a137b4d@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=150f2170e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12214020e80000

Note: testing is done by a robot and is best-effort only.
