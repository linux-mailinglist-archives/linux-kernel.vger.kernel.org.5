Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BC78DA92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjH3Sgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbjH3Nuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:50:39 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF661B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:50:36 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-56f8c8fd8e7so4256383a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403436; x=1694008236;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/HRsYywYCFSSgs6giJMSDBIja1tStcPg+N8tRD4U0Q=;
        b=ewIg5Jtrtb0z1Nofny4zIqP0VkoA91RoDA/Fxm8cS08aQ4Yo31ZirqQIB0qpVWUzFc
         qNJbkJziXyJc43twMChJi2LURbXFJMkKIoc1Zigyvk+ijdKS2eiUOfUNbf/BgeqHNKyd
         UAp4bAo7fTD7hshCNvLDTCctkzRV4+DJ+1jiZzhDYvPLWo8SbsHUojvrl+QXqUGhNALQ
         Lu0upeviQ0pg8RoGa34959hZXyix8+adGco+EhYNy29cafZWLwILlSo6ZT83FXjP8DqD
         n6VsP9E0sYjaMU+7NNBseyq/PG9Q5pOXLw3DvR+wpdMkF2owkaF2sf76Uv7Zem+E8iFN
         rQWg==
X-Gm-Message-State: AOJu0Yzop1XgpqzHgKrTFMbD6z5E0SssBkzMfURFBIUhOwCR36JZDIA5
        FcsoGnw3Ufl3pix1ag/RaCu1MQPv3HCl2nHRg1qcRHkX2NN7
X-Google-Smtp-Source: AGHT+IF0w+/YLjzY+/6JFic5lqjb3Ldh709CTDLzqDVegy2Ei1LvLdJZOSZCsmGFi8yjwJzdhQZ1QqWfQEgZz4MX2CT9A5kREGeY
MIME-Version: 1.0
X-Received: by 2002:a17:902:c951:b0:1b8:8fe2:6627 with SMTP id
 i17-20020a170902c95100b001b88fe26627mr646684pla.8.1693403436376; Wed, 30 Aug
 2023 06:50:36 -0700 (PDT)
Date:   Wed, 30 Aug 2023 06:50:36 -0700
In-Reply-To: <20230830105501.4373-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000496cdc0604243625@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in tcp_setsockopt
From:   syzbot <syzbot+1a11c39caf29450eac9f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+1a11c39caf29450eac9f@syzkaller.appspotmail.com

Tested on:

commit:         6c1b980a Merge tag 'dma-mapping-6.6-2023-08-29' of git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17b35e67a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2212484c18930a61
dashboard link: https://syzkaller.appspot.com/bug?extid=1a11c39caf29450eac9f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d88950680000

Note: testing is done by a robot and is best-effort only.
