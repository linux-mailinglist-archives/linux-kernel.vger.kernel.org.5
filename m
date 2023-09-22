Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB57AB987
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjIVSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjIVSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:45:36 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ACCCE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:45:30 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d661636928so3630795fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408330; x=1696013130;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHvNmYe/7oDClcplq/l4st43cibTO0++q9/bZ4CRfVg=;
        b=hA35T5szPub7FAK7Vs4/v2lSn7PxQ1Co1+dVH7+qi9Q4Uu/TLbUI1jvCM9pjne6EPU
         F+L8EqiQi41gE/xHRxcamIvYR/nMn/+2yi7NSc3vWIK3YOgdjxkZKcbNRA2iX3OEsZXh
         rX7OUfHKdS2SSIem/uCWRgXHwMKlLGJMary88hmOwjv1Mc4ciMfqEMKHbDMqvx5D4tLz
         DFIsZFWAMvoVuK18snx3+/PqLQePkkQbHpwpe/sqbgrdZPmtf63XtjET68AoVS9kzJhS
         BBWjlBC5nHUiVZ7mVo9hkvdv+4N9Bu47SZphcMwgGWG8jc03/Nb/CSHf11neklsXEBfD
         5WEw==
X-Gm-Message-State: AOJu0Yws0b+lPIEJ1h0JctlT5/3xENGgkdpnwT9UeceV+IoL78tZjcP1
        RDcKut2KEqFjJpcaPQZ6v56q6mANesvqh2jyS7smeJqoYVt5
X-Google-Smtp-Source: AGHT+IFiASI9I+d8YTUCo6Y0vNaIA/fxB263Ct4bKd8VHzbQGqJwkImy0blDArhh27yCdEN8Po8MmPHoyJQnS02bMBtbXz2usie9
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a899:b0:1dc:27f6:79df with SMTP id
 eb25-20020a056870a89900b001dc27f679dfmr101638oab.2.1695408330133; Fri, 22 Sep
 2023 11:45:30 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:45:30 -0700
In-Reply-To: <CABNemfqP+=-ttkMwLWTQfoio9yQvHS+yBe6n7CJ0jBoWpF907g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004456170605f703e5@google.com>
Subject: Re: [syzbot] [mm?] linux-next test error: WARNING in page_add_anon_rmap
From:   syzbot <syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, w1s2d5@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com

Tested on:

commit:         7fc7222d Add linux-next specific files for 20230918
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
dashboard link: https://syzkaller.appspot.com/bug?extid=6ccbcd15a17f3e1cde38
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
