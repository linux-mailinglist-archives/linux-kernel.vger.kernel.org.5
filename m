Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902A78B162
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjH1NKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjH1NKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:10:42 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03589D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:10:40 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-57013c62b3dso513436a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228240; x=1693833040;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oc06w91cY12qmTGeNtUkOERVJxQ83BqS0uQFIViv1Jc=;
        b=WzIv/XrQcabpkvWVfeTVleHYmXaSfTeaCno7mW7iCusmY3VnxyYecfkSIHl2sm2ClW
         xYGqW6W8s5ZU0xZZmjDYggWdbBRg9CdYNbzvrFoViVWT2c7k21tbzUaHP+k5q3JpzDnF
         mxxvINdCQbHMrSDMiiYW/YltJpURPhnf5coUc3xoSnADZkOdir5ZP+/Fkots6o//gE6c
         feIIovKznXyIgjwHbzOBe92lDfY6qbXPI3Vyz6+36M3BQWHzm7ICpjjizHscChmctCHM
         FF6zNL5cJ2LcYb0sqxMzS9uJDnDhyhslYom22uv9KNiyTHOqWzsLu6gtMiDxbPsCyMVG
         gteQ==
X-Gm-Message-State: AOJu0YwtshslHY9fsCTD/meyFqQh8BWNsxaMzLnWx07TZbbb6S+cvvrZ
        5IDKsBS3icJ9qE1Sz0unKbDmosYJQ3Iy7L2xy3NnD8k6u9oz
X-Google-Smtp-Source: AGHT+IGB9UoGY2wa+Kdv++iy4RD4+HhSd6nxaP2y5kCHnIW/pyLgYAe6WY69VQ9kAgPwxd14GvuJHRWf5bkHiHkWkgtp3PX2Pq92
MIME-Version: 1.0
X-Received: by 2002:a17:903:41d0:b0:1b8:84d9:dea6 with SMTP id
 u16-20020a17090341d000b001b884d9dea6mr8888637ple.12.1693228240146; Mon, 28
 Aug 2023 06:10:40 -0700 (PDT)
Date:   Mon, 28 Aug 2023 06:10:39 -0700
In-Reply-To: <20230828123545.4106-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c717220603fb6bb6@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in nfc_register_device
From:   syzbot <syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com

Tested on:

commit:         2ee82481 Add linux-next specific files for 20230828
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1329b6ffa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=bdfb03b1ec8b342c12cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1384729fa80000

Note: testing is done by a robot and is best-effort only.
