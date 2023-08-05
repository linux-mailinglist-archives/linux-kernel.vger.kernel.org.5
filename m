Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54386770C96
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 02:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHEAL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 20:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHEAL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:11:27 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B004ED3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:11:27 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a6e180e49aso4382853b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 17:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691194286; x=1691799086;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn3M8Epds8OYnpmLS9DDk57Fayd/BdiSGat2rI6pIXM=;
        b=EQBYPkgqgoaKUF2nbXzUdnSMXNzy9NVJov3yoM03CklsC8owxIBkBZuvqEhLspNjtt
         QRAIAOHt2xcUQrAf8ACH3ULvDwWREYhGQ8BzsvPO71KW7EdZku8pL4T4WtSkk+7dPEG5
         xnIy+Hzxd7RerO4IknDKLZ0+D7IARYwaz3kb/6+GPb3rIuavTXhTNjiONQH5ABQu7wv2
         0zgaJ+I4vRQWtkHa5oMNG2jj2QsLIJFVQTKI5aFbnrBDakvSJk3ZS2lvFn0+Xj8hqXVL
         xKMV1bvQOauHkL2kjubf4C5ArJuujSOV+c3DzhEgZGVYkfqjSr2ZFqJq8T1J5bMZJaq+
         IkYg==
X-Gm-Message-State: AOJu0YwB4f/I0q3KlkYKTndK6JX+LuCQq712vfHQQMwE/XbNWFnihTgR
        T7HigXW/nrtYiR7Tlt3jYHkjHx+2OZMqS/VdXietJ0kNz8A5
X-Google-Smtp-Source: AGHT+IG/32c0B/NeIlnRXIKwz/hO00XDMi1vvoIEwTWSvLu7DOGNYVI6pluFjfaFYD5TmIn7Mo4xMx6owZeBrYtc1osYsYv0//3z
MIME-Version: 1.0
X-Received: by 2002:a05:6808:309f:b0:3a7:3737:60fd with SMTP id
 bl31-20020a056808309f00b003a7373760fdmr4921811oib.7.1691194286441; Fri, 04
 Aug 2023 17:11:26 -0700 (PDT)
Date:   Fri, 04 Aug 2023 17:11:26 -0700
In-Reply-To: <20230804233428.1642-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b08a42060221da36@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in test_bdev_super_fc
From:   syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com

Tested on:

commit:         d7b3af5a Add linux-next specific files for 20230728
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127ac313a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=2faac0423fdc9692822b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146c855da80000

Note: testing is done by a robot and is best-effort only.
