Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C07FEA76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbjK3I0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344841AbjK3I0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:26:02 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF510C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:26:05 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfccc9d6bcso9863405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332765; x=1701937565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcJ0EHeXNiOEWmhQ58W0Ffokl7+PlrrsO8NOzNfrkzI=;
        b=DzBbVAGlMxh/nnQ2cp/SAv0hfPhmO9/P3H6GzGx7DuFczN9BteQxQ8XNhKZ0KB2C10
         bYraqdex4TqBRerofeCPyu8+06+fwcHMxvw5RMghKZmz6dSTnFTpaqeLGP904+y1+9Jk
         akLj/bIYwId7NJ3dAX/WCufllFw6HbrNAxtdS0UhiWa2z7VnJQiaE3S3esvT61zRyrp6
         ZA2AsM9sWnmD13axztjgr4R4xsyT3WNglX+YPz39kxiVROWuNE7C9RVx4ngbdZUJntny
         tXQoZm2k4isAhpMn2ZR5ECeDPYVUWDVHkNajFNHaPvyGDB7Qt7xBmXj9jKvFhasaT0mE
         CK1Q==
X-Gm-Message-State: AOJu0YyHr4zyTTB2j6yR62UB4NyzCRndTXfh33j/kdyqs3sGOSuuOz2Q
        osZWc4ZmYV3ffR6np/aTd5GRETUVXCu1QEcLLSCgtg9tQgkLxvM=
X-Google-Smtp-Source: AGHT+IH9rcaAOFQByc3Ak1bLmZlNxMI+3295ZLVxvbEWZPTTgGPTs+3+0h6Gp773dmrE8FtA1AnzrDTyR+YovLt/m6+Y2pGWoEuv
MIME-Version: 1.0
X-Received: by 2002:a17:902:7447:b0:1cf:6b9d:edc7 with SMTP id
 e7-20020a170902744700b001cf6b9dedc7mr4325292plt.1.1701332765160; Thu, 30 Nov
 2023 00:26:05 -0800 (PST)
Date:   Thu, 30 Nov 2023 00:26:05 -0800
In-Reply-To: <20231130075546.1506719-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001cbda6060b5a675b@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From:   syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5347 } 2683 jiffies s: 2905 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0c364e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bf08f50e8fff9ad
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12485f62e80000

