Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585F7E81A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbjKJSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbjKJS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:39 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331D33669
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:19:04 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso21201195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699618744; x=1700223544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJcrSIEyf3a/od8s7AKgQm2RNo3sQGGJtcqVwy0MY9o=;
        b=emhRYjJ8QFR1EBzuNM0mBwzS8V81mzU1xM+zeV7Dh4ViWkPcIMafB7BSqblL/Qvekl
         DmT9DJJeLOsJ+URbRJc4rO+Z38NVYOU5q7qUp7ZKAFRvWEDmPLW8Krg1WrezG1ncjezF
         Eklwqw+86pfmLyhuRMAVqpROtCUONXtvjUPhb6qZxfXnv++1h4ma3wzJxdh6H5+oNhOg
         6uPIDLWYrFLC0yG0POlBUACOqp2booN2mzkPRn0hUQI31jybHk5OUT7K4Mo+JozPGhVx
         QjHgGAX0zKD6wtOLDB5U6avkzTvagcp3CFeKRvVfjWRUEvKYdg+awc+HIv/G2SI7aLiY
         FOdw==
X-Gm-Message-State: AOJu0YwEijUtWeUG2ZguU3TIHJzD7FPaSosORvbqs5+F9+FiYx6U09h1
        2nxxu+mMqkyZDfrHOIKKBoteGseRsQ/EL2ZGvBMB5GahY4iC
X-Google-Smtp-Source: AGHT+IEwNa6F7EmZY+ObuS7IZ2xQynOCCqJG0DAdi65Jn+u/lJYN0+qqtznd8faHQB6yvbOYZyyoeFHCVKR46H8n3iGubp9lRzVF
MIME-Version: 1.0
X-Received: by 2002:a17:902:f7d6:b0:1cc:2bff:fe61 with SMTP id
 h22-20020a170902f7d600b001cc2bfffe61mr1141101plw.3.1699618744316; Fri, 10 Nov
 2023 04:19:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 04:19:04 -0800
In-Reply-To: <20231110113921.1500-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000823e060609cb53f4@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

commit:         89cdf9d5 Merge tag 'net-6.7-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=134a93e0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23acfdc517d41c71
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1536cc04e80000

Note: testing is done by a robot and is best-effort only.
