Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A980265E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjLCSqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:45:59 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED6E8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:46:03 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb2f8f7eceso410338fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 10:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701629163; x=1702233963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLCa/XGzGC+73V+4mDlZPATeIzNNpXWej9TaKHlQ4kM=;
        b=LAY+APQF7f2NvH96fGhqCiis2fsE3NDSqAiMukOyL0COOqactRw53QzxW7/PZDWmTR
         2oFDkNG10vxhteyQaYior4oAm/kW7bw7/8Q9WpugWoVaXow0r9scAOgBKqxfIvoGsqIv
         32cwhv7HfQRFE3pzwrtheX1LoPCI/lpy2c6Az8h1ijs/hdwNNob+2MpyJHpvYSozLimL
         r1/3mXHGg9421ZQ6rcQ8aWdofCx/pm7G3JOPNDSMqrqBUiUQEgS26FCmqYmdcb7M1CR/
         OCPL/91gO9geG9PLJimlLUtJe+qQz1NRXqs4FECxL5bGjij+Z2iF6+btgn5+uelbBU2y
         GoNg==
X-Gm-Message-State: AOJu0YzpoNUtPl+IKZ+Xtq4N2Tm+YO1LkhDQLaMojRpn8aOlAEnYNded
        oeXhJ1eiIrxucmWQI2oSllRqJvHqJ1dXyGIkKReyQkJMMz3R
X-Google-Smtp-Source: AGHT+IHnuFyrMLpO64Ow1BiQLZ9NYGB9COSZm/Nv5NybEYJDKC2JgXP8MLbqkNOONYuwRTX4OozlKaMZf0u2sYXXs7+eu6qNxGPq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150:b0:3a7:2434:615a with SMTP id
 h16-20020a056808015000b003a72434615amr1397610oie.4.1701629162840; Sun, 03 Dec
 2023 10:46:02 -0800 (PST)
Date:   Sun, 03 Dec 2023 10:46:02 -0800
In-Reply-To: <6b24a73f-095b-462c-8354-1cb606ea2f1d@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca6c7f060b9f6977@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         8470e436 Merge branch 'net-cacheline-optimizations'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=135600d2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94286555cac4ea49
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119eca30e80000

Note: testing is done by a robot and is best-effort only.
