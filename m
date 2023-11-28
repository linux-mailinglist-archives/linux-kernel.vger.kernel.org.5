Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448357FC3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376293AbjK1TED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376280AbjK1TEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:04:01 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B1C3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:04:08 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfb21853faso44099055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198248; x=1701803048;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Soo/3iHm+6mblpa+RrJXPAcJmPL66q1/EdR5kVewYNI=;
        b=v9i9aY58VKWhzpOEGeLtjIwVpCGw8vGeF2UgwCa0BAxmR2b8reXTvaIlb7Wq65cECP
         LAjGBt6MdLh7p7mF9XrA+WdCmbolfIhhu9IP76AUpW9z4IOpDTnqUJCuDT4o7IkP+U1K
         wt26jLiH+oUrKxofHsIOYRtJgohXEz4cBxZIlAxGvfPktAc0yPeYFzt3jjd0hhhbPtIQ
         AtLOGtn7BMwnuL2VL3pXiqSwnV1urtjbPQIPSuLUOh2vursJQrdAWrGloXlTqNGWkRvk
         tgpRUV2w8XJiYdwcaqopMR1mSI5xoBHSZAFnYmYLlunN79dSpthFsS2dcGw0YvX9n7xX
         NuUQ==
X-Gm-Message-State: AOJu0YysOQ38y+ACRfmMIJYIcFlYjydU/K7A9YsvqHYffgNTHsDPeg0C
        /t4Aw5aPEJEE8NBTUHqS9E10jYR9xizAkM9XcDGUsRVcY9kWx2k=
X-Google-Smtp-Source: AGHT+IF0UCt2ReWAiVZ4zmGFCmcY2rOdgoW+Wm6xACDqy3msLxVg8mp2BpYn8JB8UEefNRoUOR4DoxdybqYjcgVcr2d4cSPypUVy
MIME-Version: 1.0
X-Received: by 2002:a17:902:da92:b0:1cf:8df8:3d07 with SMTP id
 j18-20020a170902da9200b001cf8df83d07mr3606264plx.13.1701198248300; Tue, 28
 Nov 2023 11:04:08 -0800 (PST)
Date:   Tue, 28 Nov 2023 11:04:08 -0800
In-Reply-To: <CAJjsb4rwzVmWT4P4q4kruh=G7P0PR2bTU=gq5EdZvud4bEnL4Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048575e060b3b1572@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_symlinkat (2)
From:   syzbot <syzbot+d123d9a1df4f9a897854@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d123d9a1df4f9a897854@syzkaller.appspotmail.com

Tested on:

commit:         df60cee2 Merge tag '6.7-rc3-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15d4abd8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de6eb5d4f6ad62ba
dashboard link: https://syzkaller.appspot.com/bug?extid=d123d9a1df4f9a897854
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
