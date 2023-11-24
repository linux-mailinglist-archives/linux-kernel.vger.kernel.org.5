Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E37F7990
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjKXQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjKXQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:41:14 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6A1988
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:41:08 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c19a2f606dso2027009a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700844068; x=1701448868;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf3ri9xrbk3Wo2sorjp+QdDTuPFLBKHNR4Q6yiJudT8=;
        b=rlNMmm7tEN3JgLPBO5rxuUWuI3yDchNqCzssahvJL8tZRz3U4umxdxsfdvGUSOjTgn
         GEfPTI+x5i/s1RiYIKAUozZvtMvl8fVF+OhAR9pcCUXyvSHuWN6ozHXb3+aphq4djqPs
         kis05JU5G229r/+SAPO91ZfDK6oOZ1iQFhekwkoF2gQfpyv/5XzR6gwxjbnTu+OJV4PF
         tucdiVSAbYMvGG5MG5YDRvyl1qIraDdALL8ENll7Z6S4HTXEJFgQmB1dHpZ8DPsyHOP2
         s0e1PtJjKAbqD/mfgUNASX69TJRZkyYSKuUGDy0vKslESYNiZbHmiYjLtYfMBfW8FCsM
         JAsg==
X-Gm-Message-State: AOJu0Yxf6syMklBOLqp078ZKiPaHFBSXP5Yixlys7TbqQ+tg5g/LkW9U
        pD7ubyYZ/w5AY/WDssqzk3kDS0IQz+MM1k4ShmqpTwwMS2Vs
X-Google-Smtp-Source: AGHT+IHLEITRzJFu9n2TX4LcYq/P2lezy8iiyCOTkf13yKoPE9EVcIP2UuQILHm4ztno9AlxVKk5LpEajnms8bro1J+d6/+Xo2h6
MIME-Version: 1.0
X-Received: by 2002:a63:5765:0:b0:5bd:3e1c:c163 with SMTP id
 h37-20020a635765000000b005bd3e1cc163mr544373pgm.1.1700844067709; Fri, 24 Nov
 2023 08:41:07 -0800 (PST)
Date:   Fri, 24 Nov 2023 08:41:07 -0800
In-Reply-To: <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000796831060ae89e3f@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in __kernel_write_iter
From:   syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, jannh@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com

Tested on:

commit:         573fd256 btrfs: send: Ensure send_fd is writable
git tree:       https://github.com/thejh/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1461aad0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7d33e2c9b952629
dashboard link: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
