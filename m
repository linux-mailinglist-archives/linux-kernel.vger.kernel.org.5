Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487CC789B0E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjH0CpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjH0Cof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:44:35 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A381A6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:44:33 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26f533e6ec8so2280118a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693104273; x=1693709073;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IleuBz19w6FrNKwHxbCbgKqIFydyr+BjtyorAH5alzE=;
        b=Pa0Tjp/5ka9oG2c9nAXpFTExV7DoNtUCDxbbAa/h82Yru9rA8f0mQeYY5imG6eMtwv
         /xdV8AVSea5U4QDdZmUGQYrwisNBAizmTP5Jcaya2Lk9+x0+g2bJDc1cF37Qxd98/KGl
         6TRaYW7btxwR6CODkKX/E7caGZ7I9Zp963VD6KOQQoW/IaANos6cTzknc3CEZLWPgDVi
         H5hfY5l7oZsv6hoqLQJxru6sMtk+J7HGWOapOaNy7IJXrkuYSMB83zOdqj6qoISjCGhu
         dZdF6rC+i6OrtseJjMYXrFz8FIANQNizw+T1J7ARd54SDm1GwcHHF4GBralxXNc21du2
         PGNw==
X-Gm-Message-State: AOJu0YwSD6zGu0WQkRdtoAL/SCTzW8fKW0BsHmAg3RCGdg66PBLyW2BH
        cPqlBMeMoVO4pL7aWfcIWbwe2VsDNSKW8RJLBttkxgJ2RF28
X-Google-Smtp-Source: AGHT+IF52saLigqT4e7mJY411S3a5S5usU1DYBhmA06ZPD78yYBsMh9WHp2OilqPEm08awvrivjLL8jhkw8c1dIaRyF9of3Q2EaI
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d48c:b0:26b:2001:54f5 with SMTP id
 s12-20020a17090ad48c00b0026b200154f5mr4642622pju.8.1693104273497; Sat, 26 Aug
 2023 19:44:33 -0700 (PDT)
Date:   Sat, 26 Aug 2023 19:44:33 -0700
In-Reply-To: <20230827014138.3473-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca23b30603de8e22@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com

Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1032fd40680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1496adb7a80000

Note: testing is done by a robot and is best-effort only.
