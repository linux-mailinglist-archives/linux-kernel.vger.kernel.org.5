Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A980B3DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjLILDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLILC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:02:59 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA910E0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 03:03:06 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb36840642so4779939fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 03:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119785; x=1702724585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvy4N+xBFdWEhX7gts5zd9HDZEkBme/lPMrmQcBrz/o=;
        b=hlvmByBeZiyhyhFQITQOuC4lUPEfT0fj9lUiskCSb2fpKyuWpY926hlqviO9tQFRJR
         Jb05X/aD6Lx1tmXUApP29QjWTJrzq1HCzYkSM5+l109Vl/OoiDim/iusybQf2oW/pNUl
         HeHj04q40ws0mJHLOS+FTEE+ZS2r6Hw1lxYBzMTjDZj2oJBZxkfNkiqJ+MMi37YPHBGE
         XZu7g1qBMKtAxs7DU+kBEvBXzTyXvipHvJktjQM1HILY6SIO2FtAIJJHoNUGp+Y53NxS
         +TzmYTrDiGpGBEyaYHJPvwCQ1ocZk+joupKpkVnF4Gx5VB2zw202jQXxDjsv4g641+LX
         NBVQ==
X-Gm-Message-State: AOJu0YyMNwdNeZQ7HBBqKmxMNaGNzJsa2TSPTzF9HsvQyiA6TcVWedT6
        B4awNgQTSdbt3ZsQvX6CW+9jpExL3f8NS4G6JYaqdXzda0M4
X-Google-Smtp-Source: AGHT+IEs0ucuoB+Vua4GGz+6FYGyUS4H62F2AXdK3glUw83TVYPZn3nRZM4ohhxr5G5d2oXjPCGxdjFiwSoAXtL3dE7q9onU6yH3
MIME-Version: 1.0
X-Received: by 2002:a05:6870:70a0:b0:1fa:d9e9:2cc with SMTP id
 v32-20020a05687070a000b001fad9e902ccmr1568837oae.3.1702119785471; Sat, 09 Dec
 2023 03:03:05 -0800 (PST)
Date:   Sat, 09 Dec 2023 03:03:05 -0800
In-Reply-To: <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002da54a060c11a5ad@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         f2e8a57e Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1714d166e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a0b898611ad691
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1330e596e80000

Note: testing is done by a robot and is best-effort only.
