Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E74787D52
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjHYBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbjHYBrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:47:33 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0A1BDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:47:31 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68a43131e39so544087b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692928051; x=1693532851;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yL3CxA8tkredETolFyabWDYx09slvthywe8GQXa4Z3o=;
        b=F3cTcAmiwEG0TbNhUxIIZQxCOSv8CFkq5WvpKrILf7fmhQ0h/8VEzZh2gjoIfskwR9
         t0zp+W2xyYtTnlvWWvWJGMCf2uXlO42p4YNwxMSk9lVFRGfk4LVGmu2L3Lzh8Ll8shhV
         ZTxVTc7ZFCneNlOuQlNiQg3EFkxYIt2GtpAtZtXkGZUwWhkjSdP28LXME6iaqCWhaMc7
         vrYXKwr14SnykJaURXO5EY6xZiQUrYCmMD4UhVQ/ieHBysY/AKHf1bHm/yhNgLt4QcKq
         J9nyOSyi+8+GlTvThIQngK98JBq7wiv/bFkjEh/K0sSBeumDpqBz/1MPOM1ZuIIkyupx
         WHfg==
X-Gm-Message-State: AOJu0YzhovyKs1K5mDu4Rqcb3G5ZnmGIVnvnVVkM9pPOPOs3KmRHkQkV
        mS1HjagdD8mKrZEHsP8B0wpvROFjdR9woEdLmcUZmTQenqwF
X-Google-Smtp-Source: AGHT+IHg3bDM5yKFOpPTzd7kkvqQoXbDuznp//mZjuaO1aV0GJPmJQ+Bx0uMRcAb34HUuxUo0oZ6iIfylc09D1Op6ph0vpyQHdTX
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:14c1:b0:68c:585:905e with SMTP id
 w1-20020a056a0014c100b0068c0585905emr205773pfu.3.1692928050960; Thu, 24 Aug
 2023 18:47:30 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:47:30 -0700
In-Reply-To: <8680b259-528b-32a9-73ee-ce6a6406f13d@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ba17a0603b5871e@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From:   syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com

Tested on:

commit:         5c13e238 f2fs: avoid false alarm of circular locking
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=121bdfcfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ff9844b1e911216
dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
