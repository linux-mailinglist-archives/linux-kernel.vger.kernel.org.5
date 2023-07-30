Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AEC7683D7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjG3FXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3FXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 01:23:48 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1C1BF2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:23:48 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a5b891b4e8so6305686b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690694627; x=1691299427;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeyaJBQonYES2sPjVYfvUnHi8qOjn4ED2xJMnJTBG5g=;
        b=ZapNXL4DUM4XiD30dqsddSEOZcBNRBhEJyp2tFLLVd86KCYmMz1HGr+8pfaFUyml3Z
         jTcx/6CJRuMuUEQrAAvwUi6K7HjNOFAZFkkBUp02xdAhgVOmw0ERm4tSU2WNOfcUFK3+
         KMxiLAxEwY3m3mbSutbg5L53QJbMuIqoH/VaBq8n3fBsrz3Ccko6YdTdLs/fXkE8qW6g
         joW/KNbTNp1pOcWRVpS//oM2I0tFCNpPfJ3DhKPbvAbt3yCPIfu/gYWkVoXsc+qsDzFL
         NEd02hoTUsLGhrgqs63JVaDN49Ynb5Jw6UBz6ClLXTeF/GgeMIBmVOKy8Ku6/oVbITqF
         pxMw==
X-Gm-Message-State: ABy/qLb4Kfvq/tfieHtx1sXyDqIgtcDhvZFI/22Z74bG94qtMn0u2kwP
        1/MJBiZO4TsoFvHb8aD/6YdjL4FXsAZVKaRXtxqX2pGTAZnL
X-Google-Smtp-Source: APBJJlFaJ5QFhSu4ayU1SfbcwM/jHXQyu9VKftY7fuZ1QwNeacC7VW3XNiqhozQu2G9KxZqo2XZH/7WHN5tS/Toek+c3PzbNSyCK
MIME-Version: 1.0
X-Received: by 2002:a05:6808:219a:b0:3a3:efef:5c74 with SMTP id
 be26-20020a056808219a00b003a3efef5c74mr12320994oib.8.1690694627465; Sat, 29
 Jul 2023 22:23:47 -0700 (PDT)
Date:   Sat, 29 Jul 2023 22:23:47 -0700
In-Reply-To: <00000000000055cd8405f84c5386@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b19f990601ad84fd@google.com>
Subject: Re: [syzbot] WARNING in class_register
From:   syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>
To:     dvyukov@google.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
driver core: class : fix slab-use-after-free Read in class_register()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371

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
