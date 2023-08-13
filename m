Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24077A5A4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjHMIpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 04:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjHMIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 04:45:30 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A6F170C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:45:32 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bc4abfca29so42729325ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691916331; x=1692521131;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH9bz05wCeO9Fd27pXjnuchQZ0GzdRw85dg7YRZNvP8=;
        b=cUWiShF6j7ZqQROrRcEowp0gJfHse73Clhf2MbRjl9mngdha3z6H7e4iP2MzjbirlH
         khCfS/KlE6dTZejQ6giXfSOIufSkxeLon7kS7FJE+8jPKLFt5Nv6ZHYqukDhUR29OLvh
         2Fw/sxvRPnmfdVc5eIradx/iyVmGpEbPvMVMs79daUnFzk6ZxIYDKVMevLBNdLAwIxzO
         QZ41WrE7hZhJMoYoKl6D40tm8PqK8IaX9UiheEzXY1HbqKSluM2wx1xcV4hetk2KKqyk
         OSPzzkPxW2PvIWevoZnNpfZ1IYPGuXzFNbm6UnMrBv0pG+LHOzdIBmijXhbD/SsBNFkv
         eG7A==
X-Gm-Message-State: AOJu0YxfOJ6Fg1w/E0F2Q5ozDrZt2baQvx1fdVpxi7u2g1Ta5c+606Dr
        /CTy3y4DFjYGJ2CvD2+fylFAt8XxdO18sqZO1OkDeUgvmJT4
X-Google-Smtp-Source: AGHT+IHit3TMxOOT06ZSRr0eSg/HRueYz48Xlk/iAg7b9Go6nPhMm0p9+2ofnFlwUz8bG9SfPn3oHjbJ/IYfv63dTEbKXYpMI/Iv
MIME-Version: 1.0
X-Received: by 2002:a17:902:db04:b0:1bd:df9a:4fc6 with SMTP id
 m4-20020a170902db0400b001bddf9a4fc6mr164664plx.4.1691916331553; Sun, 13 Aug
 2023 01:45:31 -0700 (PDT)
Date:   Sun, 13 Aug 2023 01:45:31 -0700
In-Reply-To: <20230813074848.1185-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee9b800602c9f77f@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
From:   syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com

Tested on:

commit:         f8de32cc Merge tag 'tpmdd-v6.5-rc7' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbc127a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156fae3da80000

Note: testing is done by a robot and is best-effort only.
