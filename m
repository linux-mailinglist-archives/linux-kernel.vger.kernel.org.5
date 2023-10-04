Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F557B7A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbjJDItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241767AbjJDItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:49:51 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6298A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:49:47 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dd8e6a7a86so2618983fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409387; x=1697014187;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJD7FHC2t1nFq02NE3AMgOEqkFGUcT0nwVaE8WPBzYA=;
        b=cz4CIJSORDj+s5Iks2avkUktVfFyoZXnYK+Uhxj1l9O9ZFrEckTx5cXwC37sGxpZNE
         IU4ld9HY4iz6QYswWUvGny2DWFxL1fwsTKhluFdlc8fux3OcFNT2jdcdrC4Sq7R0lrp5
         l69QC2KIHJ1ffha4a2kfuZ7uBazt+94shS6qzD5NgbCLLgzCZmbkpAmrdqrkimAScMb5
         nA5Wt0/eiKwktRuHGI1PDWRsf0nkwGwTPbPFxrK1kWP8an9/k3Xg8tSIssmnj6HxopoQ
         Cq3KUHH+YWuXZy5LhaJgRMP6vu9kzl/0Sl8refX1uwaBiEXSJStCi9a/yLaaXh2eBM/V
         PVjw==
X-Gm-Message-State: AOJu0YwrGP1nvVpKsRHW/y05cNE7w/55VzNdmzTOJcOJbb4sPJ0JpHQI
        U3bld2xFrYbjXIwFWtQ6PsN3t0hCr2pyV/REXtWf1bRdVeWO
X-Google-Smtp-Source: AGHT+IHtUFO/WSJBjU1ad7VNNKoqGajNhMNq6oFOHZ8+UcLugsmcwyogvwgix4toX0W0IlAWii3VT6Tv6vbISXuAuhGikbb+eISp
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c792:b0:1e0:fa9f:1536 with SMTP id
 dy18-20020a056870c79200b001e0fa9f1536mr785234oab.3.1696409387111; Wed, 04 Oct
 2023 01:49:47 -0700 (PDT)
Date:   Wed, 04 Oct 2023 01:49:47 -0700
In-Reply-To: <00000000000044b47605ee8544b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e99a3e0606e0169e@google.com>
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
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
