Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75D7BFA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJJLth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjJJLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:49:36 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E394
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:49:34 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af603daa10so9062614b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938573; x=1697543373;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMiyhZ4XvOraAHeeebtmWvN0nQevffSjlXA5nq+c7eU=;
        b=mmTIG37GQ5/WsGDm8qVxlfkCdq4mDpSgE+NvR6AO1UlAwn/pzP7WB+CioJlKcGtAmF
         q/vMcX1qM4fhzFr7MC+FQBc3F0PqfcUBbu/4am80sGyKamv0kkzpn1xAkfl8C/EfNK81
         q96q/UKjRnCX/RtdKf+gL0ODvFMcjPpsKUxnzTVnXgTCgJsDEiCggwmqcXqhlQI4NlEe
         fp/Pj7A/QVAQur5jqg+v0Na7eSkUGAu1UmhBLmyZtglx0pmZpk27fTcttPC04X39nYZj
         mBICvgXfC9KVrH3HHJatyFzc1qvxcS/QTXYOnWbK8QVHsKYJowHjmdMwe4k7y/iF/pOy
         3+pQ==
X-Gm-Message-State: AOJu0Ywp8plgfjnDwRjpzCKIFKFTuXLbHFPIsAutc9bePyhIeFuz3Kx/
        J9mzDwOfQTfQ2gw6ciYfHrwQJWjZHXLd7CJVig530EfpQ5+h
X-Google-Smtp-Source: AGHT+IHKPI1z1y4ZmuXva1Ht6sMY+XGIwlcJXWadrKvh2+/5oBv/ukHWokSGQ2dxbepx0VytkUhaxssMF27jIKInvBX68qCqDpRq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:654b:b0:3af:c707:8c9b with SMTP id
 fn11-20020a056808654b00b003afc7078c9bmr5635310oib.4.1696938573714; Tue, 10
 Oct 2023 04:49:33 -0700 (PDT)
Date:   Tue, 10 Oct 2023 04:49:33 -0700
In-Reply-To: <20231010111343.2257-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e45bec06075b4cc8@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com

Tested on:

commit:         94f6f055 Linux 6.6-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=159efc7e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b8c825e0d5f3f72
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15784cde680000

Note: testing is done by a robot and is best-effort only.
