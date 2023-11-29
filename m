Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3277FD167
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjK2IvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjK2IvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:51:12 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB91707
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:51:18 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfccc9d6bcso45196235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247878; x=1701852678;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=oNTe1KJSISMjJ3ZpIwDTayL7YDuDKb3LbC7TEBZWiKpBvfupsPybe9KIW5OBVCIqvj
         g5xRP9P1ERkoYfJJopGvl9VrL6PATeXjUpYUAB5zpZSABxT4JDTkjcIKSugXZXTz9UaC
         KAFceCCjX2L+/8wKF9ze2yPGzLbGW73ooGDyMWJW6pSZH5fTBwQhQ9vCgRHmnNOx86pJ
         3IugjaTKvsjbRzcbXzhJnVqjV8A9TkbJU7073eZQaMu1LzZil8CwX/ByiHODPmppfWPy
         mco099LP3u1358piO3C+6+3gh59WTdFLcJcPnNhgo6ANuWHu+VZw/IfWHcyfcDghTvpw
         SeoA==
X-Gm-Message-State: AOJu0YxGRQyuuHz6+3lJq17qZ4Ebg09QW35ImZmDHuAzjznQLL6uyEbJ
        3MykYsOgQOf6w81yug836usW9LgEAgTvhUvVPuLdXs+deGxr
X-Google-Smtp-Source: AGHT+IF1MYdBNjdusmKFxsuZ/Nr/VSjghO6WRZ54GK864hsFL2YuTIprEZmQCeIMEbRyAlQzutP5Q08V4iUeTRqpO76M2EbgqcvB
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68e:b0:1ce:5c2d:47e with SMTP id
 l14-20020a170902f68e00b001ce5c2d047emr4297801plg.5.1701247878586; Wed, 29 Nov
 2023 00:51:18 -0800 (PST)
Date:   Wed, 29 Nov 2023 00:51:18 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a6a45060b46a377@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
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
