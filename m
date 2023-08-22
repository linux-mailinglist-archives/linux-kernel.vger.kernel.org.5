Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5590C78425B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjHVNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHVNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:49:29 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D6618B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:49:28 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso6745895a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712167; x=1693316967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZu7/0tQl9lJSJvWDtw8NuZa34ZIyovvFEjPAU3JiMs=;
        b=b3MMLXqUOAQ4eOkN+Wve7m6VpNWN5w1LyyYmsHC3MyeThW1IFK+b+8T8fPkAbFGtfs
         fBJB3SNVMRJLeLm9DLOQzC7TbHmBRYlAucCdsTXnQe7OHyEQFb7GULZtlw0I/1gszQ59
         RRgOYUXl90h9DTxrt7NlIatjkjBApw0bmHVEaU1cAt5N0dWnJx2BZm3XBKgmkhxmkuPs
         sutnFUcFV9ZtoBqrPJCPojrwKMYmlMHV7H6phajRBb/pZJTjZRTr1RBSyi+/2vtfdOO1
         Rc21bL+9nkt1y4MdQ9ko4h8sOHKTAPAK9w9RfLrseQm4XknCJwIMZDgisnaRxmtxG08S
         aJEQ==
X-Gm-Message-State: AOJu0YyhayBqmsRcuJBXkYOhPAGhxdvZK4O3DMfeDE2RzsmJ3hfOq++C
        6WFJCA/y7YZOKlnHKNg8ilpyGwyrTQGeRLwcbSYCvyK6rSw/
X-Google-Smtp-Source: AGHT+IFBJCInUYeTJV4iHf6oBYzCaJYBguOBKf0nhcvaa2KWNn2PIGp447h2BGhAAw5ySboKC4nynpBfggMLkQJ4IgayD8witW3n
MIME-Version: 1.0
X-Received: by 2002:a17:90a:a58f:b0:268:38e3:34f0 with SMTP id
 b15-20020a17090aa58f00b0026838e334f0mr1858244pjq.2.1692712167734; Tue, 22 Aug
 2023 06:49:27 -0700 (PDT)
Date:   Tue, 22 Aug 2023 06:49:27 -0700
In-Reply-To: <20230822115844.2776-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007706520603834323@google.com>
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in input_dev_uevent
From:   syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com

Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=145b7ab0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=3a0ebe8a52b89c63739d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11501ecfa80000

Note: testing is done by a robot and is best-effort only.
