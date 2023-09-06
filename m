Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3879375A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjIFIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjIFIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:46:59 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8010C6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:46:48 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-56c3a952aaeso3086145a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693990008; x=1694594808;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=KabGgIdYcEJOAu9LpqdMR9Xfi4MM1yOXAISSdQFeF1ueK8a3mbR/883WhsLqS/uPJ9
         liF9R3DT21jwO7C1bTMaBYVYFClOvU/sFy7Zis3Bc/kBwGClUj8FzDeqg9tJqCYrOpa3
         iGvPFDtdGj//4mv+nroM/evexyjTkhIKhVjZYh6b8ZqVOh1h52bFnJjEpksB9L3m16AA
         G5X/ywxuMLz0SQbRTctEhxTmrrp0miPG4QizBvaQF88ZzgXrCOy1Hh0NMd8uPQcZ3AfZ
         DRUT9j/4mlDPj+xU5STqJrKcIVNWg55arkA3a3LqL+T9x/JYug8+MHkXxdwtZZ0ezfyL
         rsMQ==
X-Gm-Message-State: AOJu0Yz45pQkmPYt1/HFxLdDeeM5hORM4ra2GDawydByBQqdr+LkmlHK
        XefA6cK4SOs9FisfJLX1x/PXbIzSKmyo74lms/Zoxl04moB8
X-Google-Smtp-Source: AGHT+IEFMOLh1T2xs1astZ5dXqyIxaln1m/XHAlDreu7OlpLkCxeBGfc94pxv+l04VMdB8jR916vxEYBQbJu8sSh8qDP5euhEKFm
MIME-Version: 1.0
X-Received: by 2002:a63:9306:0:b0:570:275c:7431 with SMTP id
 b6-20020a639306000000b00570275c7431mr3244671pge.11.1693990008181; Wed, 06 Sep
 2023 01:46:48 -0700 (PDT)
Date:   Wed, 06 Sep 2023 01:46:48 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0daee0604acc811@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
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
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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
