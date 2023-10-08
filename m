Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC27BCE4B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbjJHMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 08:05:40 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57117B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 05:05:39 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e583e9f7c0so4031438fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696766738; x=1697371538;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BgbXmBkrk89z7Tw2rKtbyuWcQuQv4/I8rmTGqT6+L0=;
        b=v8AXaZLHS0P+srhF7FzRTaaj0v377RhVfaaOrYE+urG4/7ARxfo6FsYnYNOwMmmB7J
         zhRnlZmgzFTxyRF2MnenRZwxzOtrwWNZSMWUCy5yDxFhB/gP6Yg/JutMQwUq+bknYFWp
         H8/2FI+UGXIvNtIbZPaUBkCCcoqZiSgeGORNICNXSNYF5uG4RfYL+R+vw6bYhIUXBJBs
         k952beEs9fi/xVDPUA6NnUlNqMW/pq9s9V7RngrA1j+IzGGjCe38odMRbNWqpEtB7dkN
         2d7uc1n4rayzSN+Tjwr5YL7N6zy9eb5CfnqAyW3JQTIcRL9P2C520N7J7BD2ml+3D/Aq
         CPwA==
X-Gm-Message-State: AOJu0YzEgcS6mWshZyEC9tYwFHv9KZFXDOa0ZAFsls1QcZ8Dwvrxt/md
        Hp/LjqCCAXqvrx9gFW5DopY8Bd/KDJA782uC5+kF9T8u1IQR
X-Google-Smtp-Source: AGHT+IGo/lzwK/46DNXDOmuZ7bT+zXyOa2Nz/erqvpqtco5rr3kBLYKduVeojTcZHs/l9nEZBJAlMEG5GZZGUKJY4i0+zqVN7ieD
MIME-Version: 1.0
X-Received: by 2002:a05:6870:956d:b0:1d6:c007:ff90 with SMTP id
 v45-20020a056870956d00b001d6c007ff90mr5320293oal.6.1696766737573; Sun, 08 Oct
 2023 05:05:37 -0700 (PDT)
Date:   Sun, 08 Oct 2023 05:05:37 -0700
In-Reply-To: <20231008114035.2078-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8ec770607334a74@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in clock_adjtime (2)
From:   syzbot <syzbot+628d3507228ad7472be1@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+628d3507228ad7472be1@syzkaller.appspotmail.com

Tested on:

commit:         b9ddbb0c Merge tag 'parisc-for-6.6-rc5' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=125755a1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9246be233cb6c74a
dashboard link: https://syzkaller.appspot.com/bug?extid=628d3507228ad7472be1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121d36e9680000

Note: testing is done by a robot and is best-effort only.
