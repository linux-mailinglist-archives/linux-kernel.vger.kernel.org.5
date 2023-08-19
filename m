Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46BC781691
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbjHSCKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbjHSCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:10:36 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDB422C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:10:31 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bf56d92231so3529185ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692411033; x=1693015833;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj+JQtkIXd53P8Cpr7OphiVyMguO4HSQpjW6cyHuHqA=;
        b=Qn/KfC8Mv3JElqxnJOi2GitvmfzjXkZyT5CLBQhl7EeuBba2w4HfDc0OsmAXwMsCv0
         CB00yu/HjVDWWrv/FtDqJlrGREipyzw0VtnYMUY/cXpu0QHq1wvjhTtUmfRIZQqiAWj3
         rdaPF60jAXanM0kcPcbX2SjoPhS5dyOBlLYlbMANufL4cFkwZZVe6AxhUfEGAEpQcZxB
         sTomPXIWaaWfccHB9U1TYT6dUFRUOkD3V8PM8vUzvombgg1nhQ7KBf0CsqVmC2u/Phv/
         iKq422ngpMxPf8HX2LEDjubPiNe+4/THGQo2o7W3CergCKnVMt8ATEGAd3R4Soi7LdvZ
         itVA==
X-Gm-Message-State: AOJu0YynARCq1vDVp+KaLZO/aTqaGQ0ldJ3BsrHyEhdtXHF4Lmmi2yFB
        fYdsbeCCDjlCRJyk0cWqeVbSb0yuAPxuwPSQ5FNVqVMdAw9u
X-Google-Smtp-Source: AGHT+IGZ3i/+Kx845aejyFMs4ule9aNJpp2FGHzjup0ctNIXwc7957jBsQfG6F0oYTJKXvn483L1PLXno1K9ZVhSukzuXYcIHu5w
MIME-Version: 1.0
X-Received: by 2002:a17:903:1c4:b0:1bc:7c69:925c with SMTP id
 e4-20020a17090301c400b001bc7c69925cmr349051plh.10.1692411032876; Fri, 18 Aug
 2023 19:10:32 -0700 (PDT)
Date:   Fri, 18 Aug 2023 19:10:32 -0700
In-Reply-To: <20230819014631.2196-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dbd3606033d26fa@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
From:   syzbot <syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com

Tested on:

commit:         47762f08 Add linux-next specific files for 20230817
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1738036fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed03cf326b3ef94c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf54c1da6574b6c1b049
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1400439ba80000

Note: testing is done by a robot and is best-effort only.
