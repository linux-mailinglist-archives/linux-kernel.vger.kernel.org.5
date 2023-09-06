Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384F6793767
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjIFItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjIFItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:49:01 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA92E58
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:48:43 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b88decb2a9so8504535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693990123; x=1694594923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJD7FHC2t1nFq02NE3AMgOEqkFGUcT0nwVaE8WPBzYA=;
        b=an5bExMCPwBti9cOx0b631N6jlEqFWBieWiuVIk4seRT9VRBeA/w6A7+7FhkhO+qKO
         L99csuDk304Gnps1AiUiZFiC9QZLJeZXJMVAF//6CzMmeRMAhS/1Rs/lbpfmPL3IoAEe
         eHY/DCx0yYJsoFCZ6syorvmYeYTRyk++2BwKWc4wghpGbsxqjp0ljYY4Rvzj5c5ccxlc
         iPCbH9vq9uEus8l3rhZaJ7GOWNdoJgp8RgBUKrzGD9MouMy4n/mtkc2M87dgHAKLwEFu
         VpbOTIQt0Anp3n+vrRztC2VCk66+k8ZJ3Qff+xuZUem+tdPItRzOp2GiVmeL6+ycaV2w
         sgOg==
X-Gm-Message-State: AOJu0Yz9vZXkCVNHYa2k60+/O8q2/IUN+q54DCOlcy4SWoxFAGZPPcwm
        4QgmfvGMlI12s9A21YAS8fT8gHiBQvl11vDcBuOC5mfaDgxJ
X-Google-Smtp-Source: AGHT+IFEmuteQcb5ZORovW/EtrBCErdTJuagxPX4Xs7pBEGvBBUDU3ALUlxX7FQ1FvC2YwrKc+vH7dbZ55qGolROwUKy/2V5u3Y9
MIME-Version: 1.0
X-Received: by 2002:a17:902:f686:b0:1c0:bf60:ba51 with SMTP id
 l6-20020a170902f68600b001c0bf60ba51mr5419197plg.3.1693990122774; Wed, 06 Sep
 2023 01:48:42 -0700 (PDT)
Date:   Wed, 06 Sep 2023 01:48:42 -0700
In-Reply-To: <00000000000044b47605ee8544b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008569d00604accf39@google.com>
Subject: Re: [syzbot] kernel BUG in __ext4_journal_stop
From:   syzbot <syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, joneslee@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-android-bugs@googlegroups.com,
        syzkaller-bugs@googlegroups.com, tudor.ambarus@linaro.org,
        tytso@mit.edu
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
Dashboard link: https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0

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
