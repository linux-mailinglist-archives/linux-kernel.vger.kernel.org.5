Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B87F912C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 04:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKZD6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 22:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZD56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 22:57:58 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5F0E9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:58:04 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c1c48d7226so4278992a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700971084; x=1701575884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNM3geBiTvsSCLVDO8SNGMTfqVipU2lAwVgS7lv/MjA=;
        b=Mp7J0wf82wfowE7G1Hib1EbNtluzpuJItv9QLacLnLK/7c4cqi+332wSz7fapQEGRX
         nriGg0gQ8FYmL9eeH72lt9ufDeuon+94kpNSOd5No3uesXJt4Auk2lcvGZHYHUrv9uVL
         Kktl2OYwmxb4q9IJ8kblRZUQ6N3xr/bZEi/49LzJ3Omlzi8QiuRGH6BUV0LPUBo0I8iy
         scgQc2i8UTHiysBPhczQZGUOGnLRWkz9vnrQj7pywIZzQWbZRjfb0Xv+GIEgAbXZYqNf
         JCZ0q6QUrsHGumOl/3cuHs+VN96jvuIK8c2211ptesCIO+T/6/5BsS45xBFQ5UAfjOeR
         s93g==
X-Gm-Message-State: AOJu0Yw85/OLSBPXklb3I+JM61rduxoRzvQZUL9vN2dtJ5N1CF928S4q
        +LVaGACEFGSK45hZ9MmTB8l6uFgDtz1I5jfqiR+ThLhu0qHA
X-Google-Smtp-Source: AGHT+IGQKjIx3lti/FODLnKyzRR8j0Np0wQxk1JlxKm9qA+ozFwrDluUxlw5atBc5uGDdzjprxpRcBB90wXm8pbBaW7J4/YPOzsV
MIME-Version: 1.0
X-Received: by 2002:a63:f902:0:b0:5bd:8130:d2a3 with SMTP id
 h2-20020a63f902000000b005bd8130d2a3mr1279044pgi.5.1700971084505; Sat, 25 Nov
 2023 19:58:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 19:58:04 -0800
In-Reply-To: <tencent_F212DD467B099FAEFC2ECD4C9227CFC6C306@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043eaf9060b0631ec@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

syzbot tried to test the proposed patch but the build/boot failed:

drivers/char/hw_random/core.c:506:32: error: expected expression before '=' token


Tested on:

commit:         98b1cc82 Linux 6.7-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1627b408e80000

