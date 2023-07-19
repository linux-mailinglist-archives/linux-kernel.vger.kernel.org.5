Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913175A2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGSXw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSXw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:52:56 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A8C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:52:55 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3df1d46e5so378263b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689810774; x=1692402774;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9gJwVZwzQg0baOMHo3naKFdZASs/9RCrT4IGNjRFMc=;
        b=NOhXaLR2elGuzuSc4GehWH4ZxSdec5ImUj4BMc6pcmx19R2B45niUAdtO02msLeZ4+
         N8p0rnfQcm0UGky+DE3/D5Tq7Mt9PT6Wahfbf4VFT1m2aYrcYECCyoK+ToBfgkeXBBY1
         NjaAVtj2Fkfhtv4rUzbi7YKLNCqyxBx5e1EBObtPWOf6q+zBATOjoo1ehDLycuB4x/5n
         zDUjnBIJ+JftJLgLjEQbysQqJYQdX/AXkh7JvCHnp8EaCia9S85hR9HkpYJZJDsRT6oi
         HvX79GAiVkdFoGSJC5N4aVUVXSpnM+Hmu9SXeikzu0Rk6ZszGUgY3XSGIDBdc4Yf1KyO
         jfmg==
X-Gm-Message-State: ABy/qLZO8fDkfoI0+/k4BaUUvbsJChvry0v0MN6qxyMGURp1YV9feews
        vQIjXYBjATuAdbpb7i8WylXn9VQrz0qFoKl9xntYv+xEaOrn
X-Google-Smtp-Source: APBJJlF3aS+sqsqnzDE8uhYbIzzKieuKgZfPG27IJi0z++r3NRFpF4nI8tTNRI4l65VIRweYXLw4hXHCqKFpqjH2f6jRroFGM3d9
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3011:b0:39e:b6a2:98c7 with SMTP id
 ay17-20020a056808301100b0039eb6a298c7mr7704963oib.8.1689810774760; Wed, 19
 Jul 2023 16:52:54 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:52:54 -0700
In-Reply-To: <1fa2f7f07ebff31ddc24bbbd9ec47cc9@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7a4210600dfba8c@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com

Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ccebe4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144204aea80000

Note: testing is done by a robot and is best-effort only.
