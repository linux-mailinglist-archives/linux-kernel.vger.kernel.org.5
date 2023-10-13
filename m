Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D11F7C846F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjJMLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJMLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:33:36 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9678B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:33:35 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3af83e7478bso2993316b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697196815; x=1697801615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXqWc/cHmadEWcnJDDsti3G4RKEvCrMHk7ivJT7z1zw=;
        b=f7Qp8fN2yQRBNgklCeU2d4oqjBTxTElp1eMiN/9RogpqlsB9f6WaSRiciOJWBncako
         KdjpZsQG/Pe2D92iUxyDJJ63oYcwWIjPxeMUN4N+D39Fti27QDkI/TxmpHCeQRXkLWJ4
         7vkqZ1SP503nQS79giiDyLoeZOwQm+t8hf6rpkabneFW884N626OP/A0CgKS2/SBkKMO
         b4Fy5P8esgjNZ+gZygX1SFs98md7bwOMX4eU4Ism70O8vlX8wx6LqakkPsW9fxqI041H
         my+Zk92Dp1+tEWFniCzUpN3rCMCpjkEDmeklSyIWTvjbbnp+Da9Y8DkPPxUtVwgt7p/2
         QmQw==
X-Gm-Message-State: AOJu0Yw9idGKwcIhat+ij132EDueLKZLpLy0LqeaXQECIZB+T43AXTEg
        JYole/uZDKeupzAPjlSAlXnA7ja//A5N86QDxJPDBkCAFqW4
X-Google-Smtp-Source: AGHT+IHF1UEraYIT3cxkGk73asZUjey4bVetTuoTgGIddPoNcfNdl9fjLmm4CGJ6ahMoERxf9QOUrpMgZaBaufLC3RSHvkBP2Coo
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a09:b0:3ae:7044:fde0 with SMTP id
 bk9-20020a0568081a0900b003ae7044fde0mr13448508oib.7.1697196815122; Fri, 13
 Oct 2023 04:33:35 -0700 (PDT)
Date:   Fri, 13 Oct 2023 04:33:35 -0700
In-Reply-To: <20231013111054.1411-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047894c0607976da4@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in wait4 (4)
From:   syzbot <syzbot+8ee0140c3f5eab8a8d4f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+8ee0140c3f5eab8a8d4f@syzkaller.appspotmail.com

Tested on:

commit:         9d23aac8 Merge branch 'net-sched-fixes-for-sch_qfq'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1306549d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf3a5a067019ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=8ee0140c3f5eab8a8d4f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b589c1680000

Note: testing is done by a robot and is best-effort only.
