Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ECA7CD6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjJRIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJRIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:48:45 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7658C10F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:48:43 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e990f0629cso8881656fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618922; x=1698223722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=IBmaxfmDt814lNhn4ep11sPTZ6wgnmHuZtvRMGYlTpiVf03UZWt8JoSGKpD+t6kRqh
         rMYj8S+k3Dy9rPEo/6cxlpdnLpqbVLOk0y7tlO58t3C3O1UbTS6o6/Je8eLzC8CIbcKa
         prMb8Tlk9eI0FiEJ9kKOYrHTrDIQrWvt6fEQxMwZVQY363xAc6L3V8W2N+q8sPARlp0m
         46ZMZa0JTxt5r1dc9derV2vCBs4rujjMMWoRw0D84lYLGNdHdWwrSxWPHIl8LSSAiX1D
         JzIXxrjRxdiNmIbQ5g2ocCWMmldf0B64PKQmjDA2ML4HGbG1j7urt3/13pazUfAOG4g9
         P1fQ==
X-Gm-Message-State: AOJu0YzxjnApnMVJIGAem9kWQFCzUN/+zmmiOrW+4UFMSm/zufu7rBM0
        UGicaHV16uqBh9OsZ74Jc/jNJJo+AlwUuoabv9RcZhuj1gje
X-Google-Smtp-Source: AGHT+IH5KX39Zu5WRNgK3VKyydT+0tvTjeetKkwDFus95ScBRPsXK3zjjJxvbV/6vxL20IQCDEZ9FHkNsLjuYTS+6mTaNsskXrjM
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3046:b0:1e9:dabc:9d6 with SMTP id
 u6-20020a056870304600b001e9dabc09d6mr2212109oau.1.1697618922448; Wed, 18 Oct
 2023 01:48:42 -0700 (PDT)
Date:   Wed, 18 Oct 2023 01:48:42 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d62e9e0607f9b415@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
