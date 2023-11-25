Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B387F8838
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 05:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKYD4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYD4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:56:05 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B252115
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:56:11 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so2334089b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700884569; x=1701489369;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pjx1gmD8UUb67v1XJI521sFEEPmdEHNAtyfZUJN/zT4=;
        b=cktbVbLTbzmBBOF0tyL5Q0grIKQ6HPGBKqcUsDndIXOXCQGHsjNKAAE7f40Jlm4abh
         vv3WuQo7lfoNW7Z2kNGGpE2qDCrMZZ2yVl+bJ2LHXTiiKx8Qa7r2TlAXos3AWlWBxWPk
         Q0vPuTEbj/8QWsYyqthrDkblsVzWOnkryOigVWB6Rm5URZ/l6XJyagtlMNQwfGIOEF99
         75+PrIhcYJlkKUmAQVzE79TXoX89W1khSN0KcmrF3tzPNCpj/s3Z2betrt8utCDAFDfj
         BJTZVTXG0ndEetdFiJYw6AQPYTlP/rATrDsa6oX3jue8Ye7yREjoIPOlyJyrS4y8rS4N
         76+Q==
X-Gm-Message-State: AOJu0YzBFrv9yH5o+Sxaln13Nah1x+Tcf1ass/XqpmaCUyHLgLH9GFjg
        zIL82Q3z2yqwvEJdqY+J8gYXKvw+rUGsI3CoZ17LHZFYomSX
X-Google-Smtp-Source: AGHT+IHXe6M2k5xIJQHw0zNUOgrrRfNCAtBYZ34CMrCuisQXjGgVqkgzoyiSkIk9uNuTqPkxOOeURYuQASRYVtd8mLrFNR8SV3a5
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a12:b0:692:c216:8830 with SMTP id
 fj18-20020a056a003a1200b00692c2168830mr1131914pfb.0.1700884569432; Fri, 24
 Nov 2023 19:56:09 -0800 (PST)
Date:   Fri, 24 Nov 2023 19:56:09 -0800
In-Reply-To: <tencent_C74A927585770766383DEF373C96C8360E09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090aadf060af20c08@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com

Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116071c8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e8a3cce80000

Note: testing is done by a robot and is best-effort only.
