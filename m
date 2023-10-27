Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AEF7D8C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjJ0AE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0AEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:04:25 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070661B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:04:23 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-581d766cc15so2141610eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698365062; x=1698969862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=sCe0z28vk4H1pvLFk5+htNUBuvZMqc+oovDAdQJzMSlm5wx7K4/rGqnl4N1pALLJ7+
         /xJoeMxAb8kXwpg/Z+oW17rw3f7YznKeAoZQKOk8ho3/r3whK0xZ4Bop7IV+imICSWCp
         rzKhOTJuri3h4qlwOBIkji/QfGFubAG3QLdfKueIkEMQ6kkjIU7OGRl8P6dAsC4soSpc
         ZHYpjAP69WSZJxpPWeMB37kgZX9IqeVor87OjpW8e+/yQwZlvexi/+SN4hg47GR0gJt/
         lcuJkhIl5mzns8toc6BbXSYTo5SZ36UiXM5xncmixrMbebTfBHtcULhIsSDmxlpl4Nrd
         PcDw==
X-Gm-Message-State: AOJu0Ywr9IhpWVpMcnK+9HfXjukeruGvv6t5sEVrbZTYsm+Ibc6JRxin
        ISueEt3cJeoYIp8kYSZYaqVntsy2Sejhg40+Xx+m7WLVT+J8
X-Google-Smtp-Source: AGHT+IEhYy4WmIgAYbY61Oz31xMu3tqClBnDmpJ73tdRUv9x6pLGlmaWJFERZHNGpJ0dUxQgx3S8xKk8pSxA5xyu4YLQdh3cOVXN
MIME-Version: 1.0
X-Received: by 2002:a05:6870:304d:b0:1c0:e7d3:3b2d with SMTP id
 u13-20020a056870304d00b001c0e7d33b2dmr520486oau.7.1698365062075; Thu, 26 Oct
 2023 17:04:22 -0700 (PDT)
Date:   Thu, 26 Oct 2023 17:04:22 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000395a0f0608a76ece@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
