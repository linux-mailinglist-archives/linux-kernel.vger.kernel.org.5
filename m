Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C517EF225
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbjKQLxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjKQLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:53:09 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F598
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:53:06 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3130ba31so21599215ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700221986; x=1700826786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YerPKKRCZ1M0kZwrZRjWv8wIY7JMsl3Ed91+3ZumFFg=;
        b=W5VyTpzQHOJS5e62zqkYagFA1kf+cibKrNZBWLD6XK+zM6apkW9Ld6HqPfpHKzvN87
         cNpbCAUG/zzJ43LpqSrcytuD8O+uiHjq9a+oa3S5XtvzsRkbhmZmqu5keAtbEIZKCOMA
         xrf6RtPYwOJ5ro9x49ne5goxntP2x82fSFDLQsMnEu5KWKnNBI2+wjWHIPXaZ5WnhX/M
         Fgd8qHz+8tEG1tsgE3BNDE7UkQMBCfjYmwvD74QeNHBeo6OrqzPCOxjJXC0sVdxFDmRe
         t8g3Cnj/MMGv6fZvM1Pb48rRiALsUCA+i5ITOlB6d3Mra/7iavymOtRYIV87ZGgTZasq
         PPbA==
X-Gm-Message-State: AOJu0Yy7NF+s2lrEixCAHqHiHr27LI04YHbywUgFB0x9MIm7eBDwi+tT
        jr90kkjUoNpL8QynnjBHEmSnVzhLna8He0VgwY684/8J9xMS4LU=
X-Google-Smtp-Source: AGHT+IEsBzbMrf1B1vT5mYcVwMYZq+aJwGHaGayYOSFIYzpIbgoCUcCvjnCFnMJaR3D/nIpphPAjo8uZWV/3WN7elVcZW/ORexsP
MIME-Version: 1.0
X-Received: by 2002:a17:903:4296:b0:1cc:2f2a:7d33 with SMTP id
 ju22-20020a170903429600b001cc2f2a7d33mr2855432plb.2.1700221986097; Fri, 17
 Nov 2023 03:53:06 -0800 (PST)
Date:   Fri, 17 Nov 2023 03:53:05 -0800
In-Reply-To: <CAJjsb4rUe+sOAY_rbUZuyHFKQzmo4TGvOhZsHF_T+8zjw6CBrA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000854f03060a57c719@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in cgroup_free
From:   syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com

Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10621a14e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69e454cdc811976a
dashboard link: https://syzkaller.appspot.com/bug?extid=cef555184e66963dabc2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
