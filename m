Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01897C4217
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjJJVLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJJVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:11:40 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F198
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:11:35 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e5a506de8fso343380fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972295; x=1697577095;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZWvcvFWT3P94ESec92OyEYUrt6Ss1wkXtTKq4rDYxM=;
        b=hJkU4dGPQaSeqdcC1ZeRgMu1QTR4d7u4W34cg5KwVrT54I7olbIeStAnGavXPTQcyH
         HZWCq5MGGVRmFLByvbd08QEmktvGH0r/zo55w6KauyaeCYZyD4tIY4ctfKwl+UXGimdL
         IUwZJ6u6wrVBYUk0+U3VYkNZaK4cHIJPEtJQxCOc4stOIlH/s4YB0Z3r00Kpz9qSirXc
         iEIiB9dQ3X5RI/ZvHmztak27OoRGeZKv4ksTHurN4PMZ5rpq6LFW3YmcqF7bczbo+NKF
         bwVZXELaDMa75OAzEXoeWNiZS+bkimWW6EwpJjWsNkAszpXLri23jveTDjGUekLmeSTy
         1iPg==
X-Gm-Message-State: AOJu0Yw/4pNl5AaB7E7sXe2kk9PXxkuqEfKd/e8gA3KphCDcn7ayPzLj
        lidEZmSae2hXiaqlu4ru40KvCW4jmDr5MMbYLFGGUub+el5B
X-Google-Smtp-Source: AGHT+IEip8/WB1KxD/i7SHZr01hyD5rCMbCsYc9ryFGNuYKojxiyUdRD1sIhFjIPArPGKDz+S+ZWIZzEf6rVWxHmkHDUZdRTKIGt
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b79c:b0:1e9:6d19:935b with SMTP id
 ed28-20020a056870b79c00b001e96d19935bmr1140796oab.5.1696972295375; Tue, 10
 Oct 2023 14:11:35 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:11:35 -0700
In-Reply-To: <0000000000003ee3610599d20096@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc11d106076326fe@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
From:   syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, nogikh@google.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
media: uvcvideo: Avoid cyclic entity chains due to malformed USB descriptors

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=0b0095300dfeb8a83dc8

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
