Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2887EEC34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjKQGYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQGYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:24:09 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C78FD4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:24:06 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c16f262317so1913770a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700202246; x=1700807046;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqcMZfLIeM3VOt9NY0lVd7rq9STgFm9IoN1p1GCcwDU=;
        b=Ba+R6ij5W+JAJE+bYMpPjBgVnU1/yw84TGGWHEX1fU3wMfcJ8W7L0sH5SuBNNpN15Z
         A9AQHEMTTYRSNMzsiBI3jppp97TWAYK5zMpSTZed1oeulzO1DD7DAuKOZi1J5Lhu+BH8
         z+hduIzC3dy8iqgqwk72FiYqDAwYu8CrY+UI+9FMvBMXrAUoaYVG+Cl+aFqodq1+v2Uj
         UKQ/JVNzSm8JDR6BHx9yVH8QI+8iXcNURwcSSv3WbipQ727rOpZgHqWvN3j/kEykNLHo
         rcqWCFeRS9qZY+iynZ3WMESQTdk7ZWAow9Nxy+rYqzY9JZMBAdTpzqKFi+36I6dgSbk+
         O67w==
X-Gm-Message-State: AOJu0YyPC9RWGA+Ph1PPk49gZzl/a9krz5HIKs6nmkO7GQG62sm8ZIka
        /+HCPkttfm0F4crCATLjbZ/D58eMwquZhIAj2rrMt9qLNuQl
X-Google-Smtp-Source: AGHT+IEta5ytzR5JCBScBFHS1EBVRd5GV6udCI1M8FpA7Fbi3V545uROjMZrK7OALHNTnTC1TtbLceXmmuxMX4zKtTh2z9xAB8nq
MIME-Version: 1.0
X-Received: by 2002:a65:520a:0:b0:578:a62b:56ec with SMTP id
 o10-20020a65520a000000b00578a62b56ecmr889786pgp.5.1700202245752; Thu, 16 Nov
 2023 22:24:05 -0800 (PST)
Date:   Thu, 16 Nov 2023 22:24:05 -0800
In-Reply-To: <180788a2-b714-ebf3-962c-8aabdeff0c45@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e78e3e060a532ee7@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com, jannh@google.com,
        jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com

Tested on:

commit:         b85ea95d Linux 6.7-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e7e350e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fffc11e84313b7c6
dashboard link: https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1586ca14e80000

Note: testing is done by a robot and is best-effort only.
