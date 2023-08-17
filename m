Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C5777F6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbjHQMpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350941AbjHQMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:44:36 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754E2D78
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:44:33 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26cf409f057so784328a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276272; x=1692881072;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny0smNHenu3x97DmKY7hFmfzJN22RLqNxDzAHceEP9M=;
        b=Mbr1A6BuT6v6/FkfnV0W3SjBAEyb04GKN6eNhU3sJ5mpy/o8EbA0Sv02rTRYoXxN/S
         kV5o4SeGLhOX66TlS11b2Claph901Ds42+ul5LA1K9BpeIWjGtjJok5kz3Usd9rYBUka
         /Rgttgkk29FbqovhPQsUeLgJRonbwwS9NyMrc39spJ3hDk80+HD7YnuuWJNOxzJQojPI
         e/xXDNi5H/rveNMupL/6iLvViiwCpQjgPU+hCe6I94Ld2XD+qKVkYf3eP3fjaOGxKeH/
         pbmDpRUm7F1ik12D+CC1qjBH3oAl5LrJK5jEUtLTEbFCCfpGlgzH2gekTBKQvckceRtW
         qkCw==
X-Gm-Message-State: AOJu0Yxi4XYz1aamqHy3s3JHwJ7xJpEZpFvHzXQPChwAt7HHsIJYb0mo
        3wMLq9YKDxx143LiCD6sUOrp6IW4kyAIcwHRMCCncpPNNlL9
X-Google-Smtp-Source: AGHT+IGORfqC1FYJJZ6cR9X3skmrQ5sAZ5VziGQLEY2pMecwK5EMr5IIrW+Oiz9UlG7I9sxgJ61FSOG2khhIiRR8GVlYnrx6P7+r
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4394:b0:263:3437:a0b0 with SMTP id
 in20-20020a17090b439400b002633437a0b0mr982059pjb.3.1692276272502; Thu, 17 Aug
 2023 05:44:32 -0700 (PDT)
Date:   Thu, 17 Aug 2023 05:44:32 -0700
In-Reply-To: <20230817105445.1877-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000159f2c06031dc6a3@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in schedule (6)
From:   syzbot <syzbot+77195ae75047f1438785@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+77195ae75047f1438785@syzkaller.appspotmail.com

Tested on:

commit:         a785fd28 Merge tag 'for-6.5-rc5-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ec1d9ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=77195ae75047f1438785
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fb4440680000

Note: testing is done by a robot and is best-effort only.
