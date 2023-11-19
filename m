Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3087F03FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjKSB7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 20:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSB7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 20:59:06 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67FA7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 17:59:03 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c415e09b2cso3942783b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 17:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700359143; x=1700963943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toXNAcDFeHNsgcSgCSrOe6MxcfAHmBjKEtuAMrhdkHo=;
        b=EDS/0btGhRbFvSeZOQUwAZSLvTWDbCqBpys74/qLOqKd1+75BpuTzjsdx3hD2N+OTQ
         j6mWA1teO26wMNsxn46P8/1D1NwMsBo1xmfW/iWQlQdiHrow1PYJfLmHolLVpWkJ1gaA
         essLcamCxC/42Z6jM+k4BP/n58InbGDH0f5DTWnwVaYqh4W7LKvTrs5DI9CI4/jRRvL7
         oLRv94aWJ3sI0LdMWBwgFgbtAY1/Tx5KlE9lDMBsCZSKfS7UA+0jU3rRf0qeXBEFDosM
         yfxe7/6tuLSO5z3+y6z//86KFYLqgdZ7VzDJc21mjljIQstj1dTE9nAuVEMKz+hbiNhx
         P8Xg==
X-Gm-Message-State: AOJu0Yyg1PykwWJZsaPHSL8IKuhw9q7Mqz92y7ROpr+dRZG3fOUaRhDx
        rCvsPiqD3rnRLm6FvkH0byKVth9yei+toucMZwJNtCUgtZwW
X-Google-Smtp-Source: AGHT+IG6lM/IvgGMLlPo/hk8nRob/V4Kt4FIr7lLmsSm2084dLAxfxxF6p9RXJijJo26MgEDkLpMLKV2VQRLiPRZIVyxz0GPko6r
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:e07:b0:6bd:2247:d2e5 with SMTP id
 bq7-20020a056a000e0700b006bd2247d2e5mr1131580pfb.4.1700359143076; Sat, 18 Nov
 2023 17:59:03 -0800 (PST)
Date:   Sat, 18 Nov 2023 17:59:02 -0800
In-Reply-To: <tencent_85864D49802EF66EDA0CBA67C346E592F406@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6b739060a77b675@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com

Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b3cdd4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1529b384e80000

Note: testing is done by a robot and is best-effort only.
