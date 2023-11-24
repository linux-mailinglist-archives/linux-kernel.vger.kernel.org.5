Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48017F7716
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbjKXPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbjKXPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:03:00 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5A1AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:03:07 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c19a0a2fbfso1959468a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838186; x=1701442986;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdOGYRw72XNJqmdPubXE3DN830RearWPfGL+ky1culY=;
        b=Y6URr5aczekmUNO8lYt0BBcNAAfFyVOtZ/RQX6f36aWHi99Ij1um+vGrlj7wgzErVx
         A/6ZFQfoZgUZP36WpRitAIddB69yLctzo9VVb/74nz+mHnj7syN/dzV5mNaqBN738p9x
         2jr0vYVam9ePUIzfjXnvuts+3AekVMYxkYmNfjc6dg4hcYYanTonMxq+Fr3YiItKStC+
         dQbkMlfrhteB47vi+GyaD1Tutm1WRgeqE/0xUhgDK7xBmowrmNuJMNMsX6Qia4WE98IY
         omLDiKZOtJEC+/rI+L1nFRVZwqInC0P1UgQ2dc2WCCr1u02hgx8XagpmSqGAlq+vNlt7
         rqcA==
X-Gm-Message-State: AOJu0YxZayWsauzooJue+L7x3A35TKEUB6h4uncJGSeEt3SzfGS37dN8
        D0OBcGBmY3qRQPl3K394BenG/lputMj7lgCCWlf3f43Dwe71
X-Google-Smtp-Source: AGHT+IF/OpCjhF/WWI5/IHCmdz64ebIxIlZdyR8GxPdJXc2tF7B4AjJYFdaK8E6F44vImX4ZB8se0iKG2x374ePup4X7r0EXlqZs
MIME-Version: 1.0
X-Received: by 2002:a63:4c:0:b0:5bd:d756:86d2 with SMTP id 73-20020a63004c000000b005bdd75686d2mr426223pga.10.1700838186595;
 Fri, 24 Nov 2023 07:03:06 -0800 (PST)
Date:   Fri, 24 Nov 2023 07:03:06 -0800
In-Reply-To: <CAG48ez3AazYzfJCFgu2MKSoxMEpJXz0td+rbeCOhsM38i78m3A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eebb5d060ae73f1e@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in pipe_write
From:   syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jannh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

Reported-and-tested-by: syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com

Tested on:

commit:         56c486e6 fs/pipe: Fix lockdep false-positive in watchq..
git tree:       https://github.com/thejh/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128b880ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
