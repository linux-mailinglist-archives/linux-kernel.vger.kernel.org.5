Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6137F911F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 04:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjKZDYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 22:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZDX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 22:23:59 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505DF111
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:24:06 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cbe14087c7so4255770b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700969046; x=1701573846;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4om8HHIr3fpcmb0N0+wx5Qs+XBHcosQLmB/AkFJRRzA=;
        b=dzrIBlyosmhgxT5VGyi+83qarPfA8enrVfKdWh0fVsKaktdv/e7bHOnZ1cWuLIj2Cw
         Je0cif53N5mALXXXDk8iazNf+Rbi/k2cvK9vEg0gfSZcywAgLQRymyL+sUizU6usAZsW
         2qk7fl/mmtgKnMAgv/mLnia617OiQz99sP6IjXuJIlJ4QID62gfqrX0fRUAdpxEZdCYZ
         dmpIv/T3Xwx4DdTwJrL16N1tf17Veehn13bc9TlO2m6nTDKsQKfVGpBxmpDq09KWfZKb
         1NV0synR1sUhKmOUslG+K+7MzwDpG2HaXRl6xxRzpHwl0lphmzTWMryvDbp97xJ21KCX
         XXRw==
X-Gm-Message-State: AOJu0Yxz8XsBqYHK7T1FPhY3N6lyS7PtIMLpfCZqHemoDmAbLwb0KtS/
        uZtuhjtIw4LACCAvAm34zxQLUDPkaFsWNvwnw7ymklv35MJ3
X-Google-Smtp-Source: AGHT+IFb0XEynZ5+Z6M02fL0nh0IBRPqeY3Moua5nhipNqAAXQ6nK6rl7K0CMFBKTQ5NEcsH18FLee0MaBv7biqNyOoy9+4lDh7B
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d24:b0:6cb:7025:992e with SMTP id
 fa36-20020a056a002d2400b006cb7025992emr2034943pfb.0.1700969045861; Sat, 25
 Nov 2023 19:24:05 -0800 (PST)
Date:   Sat, 25 Nov 2023 19:24:05 -0800
In-Reply-To: <20231126030321.950-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0a9df060b05b763@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com

Tested on:

commit:         090472ed Merge tag 'usb-6.7-rc3' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13959724e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3813bb4934ffb745
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1191a4d8e80000

Note: testing is done by a robot and is best-effort only.
