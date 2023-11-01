Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54937DDDE2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjKAItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:49:18 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C75EF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:49:12 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ea01dcf2ccso809353fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 01:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698828552; x=1699433352;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=QyR2pKyTPTyKsmwPjy3vQefHvEXb0a7gAxjg2UzXMQ3iak7rnQwkOD8d/lYJlXdD7I
         QbFivKxLxZy0F6ZylctDf/3nFCyGQHXrmAFcjefjmV6vefBdRgsHb9jlf41rb+dig7tL
         k3enhClekucvF2cKi/lO8VRmmoled7YokKUDNrzOa0heo1qqr+mbX6I9E1kpStjE4r4E
         iVv5oxYmVdbzXQdgaiigbpDgZcuPFv66Uzc2s4m4XJ2mnngn5mK/rtjXbKsxtRT0BgAk
         +CjN+jhJzX0r7n+CkQA5KAOrbEOhe7CJn1GfaoOwVWt0HQnCAljjKE9FqMi9Pe3EjqmU
         sJdg==
X-Gm-Message-State: AOJu0YzEUrUhyyDDrwn6zwUkZ8saUvbWLz9vlsiIOG52AcYkFvr6w1EW
        FyBWZ58/MiUHKYEs0gLguqVdepv49gGcT3lGz3RErxVFZpHC
X-Google-Smtp-Source: AGHT+IHcunDBTKsdG6HwYObTbjW7yGSIe6O+NrfxyuISaXIumOCLSA0dGIIBR7P65cCYIijfOW6pKSYaHy1p0BDbBWsjpQmK0Rfl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1f06:b0:1ef:afd3:813f with SMTP id
 pd6-20020a0568701f0600b001efafd3813fmr1126528oab.5.1698828551901; Wed, 01 Nov
 2023 01:49:11 -0700 (PDT)
Date:   Wed, 01 Nov 2023 01:49:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ed5bf06091358dd@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
