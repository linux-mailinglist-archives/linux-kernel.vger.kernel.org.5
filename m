Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD1768513
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjG3L1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3L1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:27:23 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F34E7A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:27:22 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9d8b76be5so6862124a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690716442; x=1691321242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iZ0euyhf3cxTHoSvXRmLk1hGHNPN+FfgZk8tEqnMAQ=;
        b=Ah56abdwmORqN02IkkzZn007UrrD0Hi/otzlI65EHb3/MvRGLFWEckpV+b5/2/XMHo
         k+lNCflEem5vwIwYcHVyTFIRZlxoQZh+eYIf6V9pB7yDx70mn3OHHH2dmgasvx7N93My
         JoIoJSQRnnsSXUSLHiKCix5e0+KkgUj4+nhz2bHIwtMUc1h4wQhT/pJycD93NkD5Mjju
         Z4Ag3O/Z/RcT2Otnfu766IyiyZAf0o1oTp5KV9JIVCR/KW/3QRv6DO9uD070wbMiXAaM
         0XgKOIpYK6IRSm5qs7GQhF7Kwdnun4amHWcOnDFaYyiBd7i5ZbR1UUzFpCkQnneEM9fg
         fdMw==
X-Gm-Message-State: ABy/qLbacadwDnbtVUUGzc1GwBsg5j6XOrv1qffIoWUj29tPIOgegWzj
        9/jZCByeYX3beQSdD7iU0DaC2mVy6uVZVy5SWiANn3fjs6D0
X-Google-Smtp-Source: APBJJlGH39mGatRRe+OrB1vfflfuHBjvic8knbq0JlrEEynWLKJZsl77Q8FnRKzDN2NkvslABuN6fYUoACuHHsXGJgfKpqQbU7+x
MIME-Version: 1.0
X-Received: by 2002:a05:6830:14cc:b0:6b9:a31c:368c with SMTP id
 t12-20020a05683014cc00b006b9a31c368cmr8579557otq.0.1690716442152; Sun, 30 Jul
 2023 04:27:22 -0700 (PDT)
Date:   Sun, 30 Jul 2023 04:27:22 -0700
In-Reply-To: <20230730105902.1226-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f354120601b298ab@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in rfkill_unregister (3)
From:   syzbot <syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com

Tested on:

commit:         d31e3792 Merge tag '6.5-rc3-smb3-client-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=141df2d9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32bbbdc67cf060fa
dashboard link: https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17dfa639a80000

Note: testing is done by a robot and is best-effort only.
