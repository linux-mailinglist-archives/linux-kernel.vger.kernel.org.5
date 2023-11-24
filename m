Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E27F69A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjKXAGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjKXAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:06:06 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295E10E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:06:12 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28079cae9fdso1403496a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700784372; x=1701389172;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=rOSf99YvdlprQ9dkXXZsDHEJT1w5OZCl6QS+2WOsXYSlrv/H3wDeXuYDtwz9Fw1R3b
         9bwvO9j+C+aA0+VipXingEBIMrqPOjhy0znokbeqzrG5sthn6al1bemP6z2OvJHvBVbC
         0SRtts51CuE7SFSWrtqHUX4/9QxIcqCQV+qphyTrrZFnxEMVIdUxArKGdH+P7Sq2RG5S
         gSktNTPrwc/gGBhtA3n/ua3gfG2AT236c0C71A17lMagOX3RTzyw0TQSso9sOTkse4PB
         8JBnHBMeBWMTsftkpA4tpZxE6BT4wAAHF6Y4gZE5Lo9fWhID51a3R3cZbfbZlccFH4yv
         KeHg==
X-Gm-Message-State: AOJu0YxcCzGOq4kC1SKUD5XhJfq99JKqhpflnEoVvvkMJUDeyaR50g+I
        meGBQv2erMhPeFK4IRcaS6Q2++uqu7DLQ6H59C3ZsSqWFvKL
X-Google-Smtp-Source: AGHT+IH4WTBky6ydAmsIf8sWYpziUR2At8/kwEH+H4BuxT4x7gw6xHBkO6awptlXoHP15FAo0eZsGGO3X6iZK+6d7mdP0LEzTNDv
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4a84:b0:27d:9f7:74ba with SMTP id
 lp4-20020a17090b4a8400b0027d09f774bamr252386pjb.0.1700784371825; Thu, 23 Nov
 2023 16:06:11 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:06:11 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000528278060adab82b@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
