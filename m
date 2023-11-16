Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E9F7ED8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjKPBoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPBoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:44:07 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FB182
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:44:04 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28016806be2so1255335a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700099044; x=1700703844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ut1ErbjVxvdNcxjiFmCC/7kOFe5nVv8MVNesus1QAbE=;
        b=mYaRSBlaoKcCvZPbhny32gBmspMHPAnrv4adz6jopyaFeFHhGuZS/p53+JFAb8UgVP
         bFJpSJhSe2Xl5gBZcJgSN/IR3gQBrUllqljEmeBR+jQTnCgoE3sUW3d5HFoavuHgGwdO
         Q3SwB8cxtwQ3w9nBOYqI9gFX4VWHmbx0HXH8/M9ubqVPyKgL7pDb9yp381npWk66Y83d
         PC6p9/733dj53S7AHJSH0R+BntqktCEoEvryS9iq5vpGLjKBpuwMY8/gCX2FFBwkGhg/
         rtRGgtw4aFruZI/ocaWV/aISO8nMINiDfVJ7bqYvzDsFz6r3F+M1OYkAUindAWcdUakW
         z2Og==
X-Gm-Message-State: AOJu0YyNVbZc+2SUVjruk3xuBhAEkbSZcspvGv+E6eJUrBQlQFAMA0/U
        pBSr2Fv6rZmgd43Gzav51KLRGEPqW2mu2YkXCrYsFQuTFv2186g=
X-Google-Smtp-Source: AGHT+IHRCrso+qJQoM+TazDcySzzd3rTDNQjGiRZcIZ47wpEC0wGFbXYA9yBQRURH3lkhgDzp9ATdBEKSY8iFXRFG9u/r4if9RB8
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4f87:b0:280:2830:90c0 with SMTP id
 qe7-20020a17090b4f8700b00280283090c0mr70688pjb.4.1700099043953; Wed, 15 Nov
 2023 17:44:03 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:44:03 -0800
In-Reply-To: <20231116011445.3441058-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000991113060a3b2778@google.com>
Subject: Re: [syzbot] [squashfs?] WARNING in squashfs_read_data
From:   syzbot <syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com

Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1083f000e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
dashboard link: https://syzkaller.appspot.com/bug?extid=32d3767580a1ea339a81
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f75468e80000

Note: testing is done by a robot and is best-effort only.
