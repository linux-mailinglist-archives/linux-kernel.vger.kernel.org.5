Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338B27E5FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjKHVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjKHVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:18:07 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574A7213F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:18:05 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1eb43ff49b2so113037fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 13:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699478284; x=1700083084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyxXCXobhEYeqpQPjkfj5+53V53lG5RGnqEZ8F4ZUTk=;
        b=hYJYQb6t4dAVMyrLX9ZNB+az6QYNqSyaE3MGdToIOFg8NrjA5zloERCoMCCA95A2jv
         t1PtUdAEztDRqsuR0GsXFyA0BKemgV1ZrOSrqDyDVU17zMnyoFZKzVGVxzKhD3i9/X10
         Hgwv7euwFFPwXSIbT3BJZ1cK6iDNBoCGZBqW+RtFJYNbWJa5kK76jqV1ta7Q+A5Wk7u2
         GQERfYEvCdnfJOjhPgpsPeZR/DC/gEhMxlb2fsG17JR3gKOs5ygYayzxAfxxNTPHTi/Y
         tfRFaftv+x9amVK1AKFv667OieGmXvm20f8XzECf/Lz+wX04rjAh1cBk69F+nXevaZL8
         0cfA==
X-Gm-Message-State: AOJu0YykvXKAtiL75xANDabQBqavjrHZGp92J6BK17cKjBGMRgZeOdkt
        eCcmxr1haPixJVgtlLcfLz3gQs/aBXksQnpM6EP1EccwYCd8
X-Google-Smtp-Source: AGHT+IGNtPzOriGiQQk7C01UsTOUwMEx/R9olkgDecyABABOSJUkhpMGjCF50m4CvqCl1wqpICz9K4DJVTFk0TtNdTvT70tl+t4y
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1d2:b0:1dc:34ea:1a6a with SMTP id
 n18-20020a05687001d200b001dc34ea1a6amr1308277oad.6.1699478284780; Wed, 08 Nov
 2023 13:18:04 -0800 (PST)
Date:   Wed, 08 Nov 2023 13:18:04 -0800
In-Reply-To: <0000000000000014460609997fa2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ca930609aa9f86@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_mq_start_request
From:   syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, chaitanyak@nvidia.com,
        eadavis@qq.com, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d78bfa1346ab1fe04d20aa45a0678d1fc866f37c
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed Sep 13 15:16:16 2023 +0000

    block/null_blk: add queue_rqs() support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106414a8e80000
start commit:   13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126414a8e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=146414a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1465bb08e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e7881f680000

Reported-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Fixes: d78bfa1346ab ("block/null_blk: add queue_rqs() support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
