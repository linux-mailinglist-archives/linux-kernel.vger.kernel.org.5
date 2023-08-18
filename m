Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6F7814E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbjHRVuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbjHRVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:49:32 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833463C35
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:49:31 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bde7998451so19808915ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692395371; x=1693000171;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htaUE46w/jpYC6GT7fp3ZjxKV5A/VMyj18jALNrVscc=;
        b=Q+DQxrUcj+viX1ifktVXg7hC4xNUy79eoelSaze7uPE4hCO2czGkDOo+/kEWBVeGhW
         3KKA/uEBd62r5UJ3tjvZWp7y1rTXiy+8vPLwna0/WyPf8NlC0jqwYRSbelyXXJQ7pcB/
         cYDe4/w+j7H25ATicZ9Jat4ydh/u5LAPxDydp9cSyOXCXDhqBpXKRCYJWzWVmDFBt30N
         bzGzahwle05pGqdrWtSn/+eM5qYYNxCkH26Mi2SBJfRW1D1YxrWFQsYwveq82a+7inPT
         wjfbutn3DNRNYCHdFF2/i3bYviw9nTdDMwYwHD8hlxk1Y+K2xkCMAjtVZv9/kybcNepL
         2ksg==
X-Gm-Message-State: AOJu0YwWDq69tOqGX92ifAh/OlU01LLNIHto4paIKn21F8aM63AoQe31
        U82BIViFPNwguYBMHHqlTroy912bNe/a54jLxKRhCswt5Rno
X-Google-Smtp-Source: AGHT+IEopbrZK9WaQ3DK9uOGyDRimniWVNSjuyIQEZW05tCpOq3HSBrweE8epEmU42rAUfq9ZdMzCGUXU4KTs7VqsrNiciOWveJa
MIME-Version: 1.0
X-Received: by 2002:a17:903:22cd:b0:1b8:9533:65b0 with SMTP id
 y13-20020a17090322cd00b001b8953365b0mr131968plg.5.1692395371136; Fri, 18 Aug
 2023 14:49:31 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:49:30 -0700
In-Reply-To: <ZN/fVHbQA81Zk0Db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea8eaa0603398076@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com

Tested on:

commit:         47e4a92b f2fs: avoid false alarm of circular locking
git tree:       https://github.com/jaegeuk/f2fs.git g-dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16b569efa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
