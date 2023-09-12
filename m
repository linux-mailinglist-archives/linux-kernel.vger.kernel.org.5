Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAD79CDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjILKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjILKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:17:45 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDB268D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:17:41 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26b752bc74fso6463289a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513860; x=1695118660;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HY7DpSorxrkfJmOH+CwT7iChclD4psUg07PYg6KnRjE=;
        b=a3owP0epmIV3vhci+78bqmRJ1qEYm51gdLItCJzu05vpVEyQqvljJRFzGXJzU8PWiv
         Sac7f89iR7sgT798U71MxqLCYhW/OXKd2JdYXYpr5ItSSX7AaLz5rxsGQSLF6V1U6J8e
         y3Yet2OogegxkT84Z96rwWP75/u/C+jMzeBViWexBjLSnYwd8AoFkyOmTxI6K2WAJo0Z
         LVY1PKIbaiZ6McHNh819VVkD76MDlUXLsZR1HgrjyIIIQ0+tJhZa6ZNcRxIuaxKCcYG0
         s2BJM1kbmrkBh3IMU2pokwI0eDyT1b8REH3x/kYB/L3JoWB0PqZMJw/ms+PTD1yd7mJs
         AElA==
X-Gm-Message-State: AOJu0YxCPL+W/t5WngZVx4WMkNEoxBYs7Mt1SrGRZdDbHsJBhtujuIl3
        rSmE8R+5xyq6MBDx3Kbt3rJlSAqaaEoh2h4zXjtckAGolxFw
X-Google-Smtp-Source: AGHT+IFHaM/l+ezhbRMOgbt2kDm2MF38rZXvdiyr980HaM/iynb8ZU7cdmHx6OaJcCHqEKdaFjFW7nDNbB8YGB2EnqWEIlwISzC6
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d30b:b0:263:317f:7ca4 with SMTP id
 p11-20020a17090ad30b00b00263317f7ca4mr3179077pju.9.1694513860796; Tue, 12 Sep
 2023 03:17:40 -0700 (PDT)
Date:   Tue, 12 Sep 2023 03:17:40 -0700
In-Reply-To: <20230912083519.e2yveio72emi7rd4@debian.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd66f3060526c093@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_rq_map_user_iov
From:   syzbot <syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dan.j.williams@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricardo@marliere.net, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com

Tested on:

commit:         0bb80ecc Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c0be80680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba194e5cfd385dbf
dashboard link: https://syzkaller.appspot.com/bug?extid=a532b03fdfee2c137666
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e02dc8680000

Note: testing is done by a robot and is best-effort only.
