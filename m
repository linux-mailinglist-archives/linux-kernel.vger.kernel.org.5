Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E87EBED3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjKOIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:50:18 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E710F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:50:15 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c19a2f606dso3378825a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700038214; x=1700643014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=aePu8F+wvRaeV/RNI6UcFMufqZUiipAVD3u38JjdqGycn8bjNFNmCiF3RzCt8xwO8n
         p0UMg7Q4YKQEAXc6+kAiLJXCNjmobOz6scGLnMIr809ySMCGngMsATDLaBPdEFIPJAfn
         QiZcsXInJCHoWOtGshym64vny0hP/t/8rUT/Zym5YSPwW4gjhGh28267EP6SCO09scST
         vWgrKdg5ZRsTl2DsGtcJdQEve5FB78mj56fWBdlAQW92XX+XAomSDOlAyAdZ8fECoTvZ
         x2b25PpyeRzbbEkxGCEbz2SJ9mbaKpvg3WlqZqrW4g8JJyZFzfX+9mR4pCL+HRnFJY8w
         D5Hw==
X-Gm-Message-State: AOJu0Yys5pwsHk8eS+/GgjHADNP1ls6u9CVaBul3gzugo1GDcrwRlUIv
        bcCc0U1SAkzf2i2h8SMPJ6Q54s0SEDTfGUBg5Xr2mGXkbGas
X-Google-Smtp-Source: AGHT+IFUJ+Vym4OCXmONbmxagAntdPkW/KmU7Wvov6LOO01+7a6hUu2vKKARqr9sXhI//jw8FapxCsgSNNL1ljrINCH0MWGV4VRs
MIME-Version: 1.0
X-Received: by 2002:a63:2022:0:b0:5bd:9cac:f993 with SMTP id
 g34-20020a632022000000b005bd9cacf993mr1135510pgg.5.1700038214642; Wed, 15 Nov
 2023 00:50:14 -0800 (PST)
Date:   Wed, 15 Nov 2023 00:50:14 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e375e0060a2cfd2b@google.com>
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
