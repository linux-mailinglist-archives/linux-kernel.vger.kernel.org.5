Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790227E0D6A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjKDDNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjKDDNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:13:06 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FEED50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:13:03 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2f3015ce6so3835198b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 20:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699067583; x=1699672383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+iruCLiulGRb9h0ya8DCo5lat+C1W6ABcQGj1bx4A4=;
        b=ISHM+Tum9y4NumwpEYWhe4uCt4OmNWWcggX2GH4EKr9gijLiNN01o0nbR+edKnA3lv
         PHW9iOGpUCNjQf7yc6/EcfKQ/wyzh1qZZVVl5eUDG3/+Xkg99eEh/uKF832/MWH6TXLm
         +3lmwExIXT1qgWE1cveX7Xxnp1aF7rOhIfVKPK6R3HhLebolBvyENJySPYg6/vFvNAZI
         ISDtxcLjGXMI96csfVOzSxtzmjDHU+vCNAS6N+/NyAxEwYAZ9dd6coFeOJofr+n0J5tM
         xd9UjPnmAVqbChiaC312Mex4xfoBJzgzJ95+mh1ZWy6yMw13esfIoHqw/PvK/+pLIO5k
         jlig==
X-Gm-Message-State: AOJu0YwLzZR01j7AWl9Tg3zYQWoas9I4nt1CD3rGXBNWBy9VOv+p/k2s
        mNBi9pSZSOuubROMpoS//0vs9RX10VcKx2Y34iATfndQR83/
X-Google-Smtp-Source: AGHT+IG9mBInd0c7h5LUfgb7GSbovwTGvxGI058aIhE88eK4boJMyVyxeMxWsh2YhCIKx33wOzfHiqngETATpd1fyZ+eMaK7U5uF
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a24:b0:3a8:74ff:6c01 with SMTP id
 bk36-20020a0568081a2400b003a874ff6c01mr8962090oib.5.1699067583163; Fri, 03
 Nov 2023 20:13:03 -0700 (PDT)
Date:   Fri, 03 Nov 2023 20:13:03 -0700
In-Reply-To: <tencent_42EB25AE0D8292425D8CDD9119714FA30D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be741106094affc0@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=130c500f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e86de086e9dddbc6
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171e90c0e80000

Note: testing is done by a robot and is best-effort only.
