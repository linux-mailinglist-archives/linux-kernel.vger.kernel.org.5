Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1343B810CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjLMIwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjLMIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:52:11 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80476B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:52:17 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2030afe37e2so1585175fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457537; x=1703062337;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=lzKdXCOKl6UcYa1vL3G4QyXyrIQy7ZYjJtymTK3D9BFMigHtZuOcKpjC22ajfZX8fW
         wFzCTaaSsSpvd9kJTr9bEtdBwClXL0kD3L9raa9IEenn2wU7+jV+0a2bp6ppW3aiqxVC
         ZMaENXOhBIRqFST8v69pxAD6xPekeZMWhIG6dTqNrXs+Y87RGsRVeoD8v27q5GmYB5ow
         MBlbdyX8B5xvRCUQTc0lHZrMIZhRlqf64yx84DljZ47IKONdsTO0NqWpeqlBg3iJSciu
         i2KLGi2dBPrcUBox+z5b+2HQjTdB0XRBnXsDbmkU1CAK58HrWEN/OM+WOGj6OB/AY0jX
         iGOQ==
X-Gm-Message-State: AOJu0Yw1inkZqaBX8B8SUcBasuR0yOzdO2d+kqRiVrA0cCiYZiMtp885
        DDmdys0pXXzRS7yGWQxPBMfWrtTCkQKiD0AhOWuAcz6dzDu9
X-Google-Smtp-Source: AGHT+IGzn1vWQRWy4hNK47/fXNETo9pMF7OxRmF3w0I7jOqcRkx6dD72V7r0g1rmfo1M2lvpFsx36btyv4fDVet8vGSK7FV4vEgC
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5b05:b0:1fa:e120:4c64 with SMTP id
 op5-20020a0568715b0500b001fae1204c64mr8088036oac.10.1702457536123; Wed, 13
 Dec 2023 00:52:16 -0800 (PST)
Date:   Wed, 13 Dec 2023 00:52:16 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af990e060c604832@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
