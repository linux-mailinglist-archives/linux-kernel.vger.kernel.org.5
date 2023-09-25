Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160657AD499
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjIYJfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjIYJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:35:25 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625210C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:35:17 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c4ededcba7so1831412a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695634517; x=1696239317;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXYTV27b/N8e9iQla3A3UJA2EkuMETgjqWyl7SSeebs=;
        b=Y37TPkgpyfUYUZ3Trd9JDlB9EfShTuPONCauGEUQRDGi8Dxk4fcUUqomT8VnDdeKI+
         MCGtPePXj3Co6VD9+68TiFbPsv3GRHBX7feMaUguyW0J+Nhw/Zu1BlUbkD9EOdHISe2o
         ohQM1eRA9xlwJEJMLefNkj9WKJdJCxRoPo4jB8r6gijgjJreKhmEJciLKbW6mjBL81HZ
         olY2r2zY7Zl7zocd+0b44GFE3RvY+zVCFtUxIKpQkY7mST1ZG9/8c4bEcbl23xJWllnG
         k4yxCkbA5548DISetcBO27XFM+Nt/i2EmQsBZTRilaLHLrqEcAtY0qtXBEzy3tgkYco+
         aZgQ==
X-Gm-Message-State: AOJu0YzkAH8vkzVrCcBVB/Rk/9saaz9q3o4UoMWZwPTBt8NpEaMUWC+D
        OBbS05mlLkLM/Jxb8n0O/jYNIIgmaZovcI3ARsjujlUlxPHL
X-Google-Smtp-Source: AGHT+IHDz9RoPAb2qZE9UPgDO/asesN/srR+GdA9z0sEGZ2bsprnsSEAzagQU+tQqe+y6Xo3Qy7f0U9VW6CgE3VRMxffklSI5wt0
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3147:b0:6c4:e41c:6e6a with SMTP id
 c7-20020a056830314700b006c4e41c6e6amr1087261ots.4.1695634517333; Mon, 25 Sep
 2023 02:35:17 -0700 (PDT)
Date:   Mon, 25 Sep 2023 02:35:17 -0700
In-Reply-To: <ZRFOI/TUQwJEw5/s@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000131d7c06062bad29@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
From:   syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com,
        djwong@kernel.org, hare@suse.de, hch@infradead.org, hch@lst.de,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, mcgrof@kernel.org, nogikh@google.com,
        p.raghav@samsung.com, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com

Tested on:

commit:         ca5e3ec4 iomap: add a workaround for racy i_size updat..
git tree:       git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=16d98efa680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
