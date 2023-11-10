Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4F7E75B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjKJAKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjKJAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:10:16 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EA2B780
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:05:16 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc385e90a9so14037345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574716; x=1700179516;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=Geg7PayNHaYS9eMDawtfJnwdKAwjUWrhWAuGtt+aPmCP3jitlaCsuGrr9RlHX5pgQa
         8+/W0S7JBjXHvuPGMFchVMAGZNwbb0WS+x5zzdSBJ5ZrT9fpUtEF9ckLRnRqg3W5s8MY
         3eyz8rDhJFVEpzO/bORvX02mAzTpImRjusVWaBq6imi8u/E+RG74Nmo0O4umYxdqq8t0
         rP7icMBij6PvqwvYhI+sDpnsRvDyn8/xXjpgSR3OH2X/L6b9FvXAmgERUK3gbTNTHl+H
         HVLCr0Q5nCn55c1ujSbm0GlINIW+KoGxyf36CYK5szg6vGo1Z3uCi0BW1DVL/tZAJiHm
         d4Dg==
X-Gm-Message-State: AOJu0YyXKoJ/3fbROzCRcHCxT4aHGqgavPUEWjEOZnyg/FhP22C+BFDq
        HVcpj1W9wA4mIQ7WYs5aLIoDFi7OO9AFJvnKC2jjAV9XU5Iu
X-Google-Smtp-Source: AGHT+IGBM631v2Yb6l2C+McH1ynCRRYuc7oa7oAxmdY4RNSzMJmzHuzcOz0wVp6GO8A8ZVsQ0c0i4TnbqXvI2OKV9vPysAKg1WeY
MIME-Version: 1.0
X-Received: by 2002:a17:902:f541:b0:1ca:8e79:53b7 with SMTP id
 h1-20020a170902f54100b001ca8e7953b7mr994032plf.9.1699574716092; Thu, 09 Nov
 2023 16:05:16 -0800 (PST)
Date:   Thu, 09 Nov 2023 16:05:15 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003900b50609c113c5@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
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
