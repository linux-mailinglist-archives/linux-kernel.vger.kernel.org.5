Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE967EFF27
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjKRLCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRLCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:02:08 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B311D51
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:02:05 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c7c6ae3855so3559347b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700305325; x=1700910125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/G9MDj43wUhImESb0H/DvIEOQLWC8spdxyzLEDf1Ld0=;
        b=MmWW2gmLcTDoewKtZ36RYOp308+Q1gv7bweaxFI3lEdcg3o+4i6LIz68pxaxtTuP2S
         qLJDKBKsnu8tAbPB8ItqehLQYm5x6n/ZyEnDmd2E5eE2x7dKP5FfD/8wiNbkWxgOv9xZ
         ogl8DYSfwWW9oQ3uOlo/VMFml+7HzzIws+LKuBfRVosfZMOsPOVKoczz17T52RdK2TPx
         I4q6FpozQNKEFcvvl5ufF/c794/+7wP1lQGlC31rTjOu7mc2lOdn0rQAFkz/ifHsoR7D
         CaIOrPgoDCDURa16RuxtGchjNDnFsR9V9uaOlpHkPr5j1/vIh48Zs9WFGm236bZaDzub
         22Mg==
X-Gm-Message-State: AOJu0YxRrA2ne78PjmgD30wTaFXt2SpUFNN5KRr8U1qcfYHL6nstN4sC
        Rf2pIhjd3b/U23IdIHP7wnF8ZZ91c4chbDfWFhV9nIWc2jdE
X-Google-Smtp-Source: AGHT+IF7EHF93KVGadxiABFtkcYEfFsiqplT79689UhAfFlw9OOb8HkmYi1JfQnwG3MvNuS+E8BuOG3sL5osmIT2fQw4CxVWxrjM
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:140e:b0:6bd:f760:6ab7 with SMTP id
 l14-20020a056a00140e00b006bdf7606ab7mr622154pfu.4.1700305324753; Sat, 18 Nov
 2023 03:02:04 -0800 (PST)
Date:   Sat, 18 Nov 2023 03:02:04 -0800
In-Reply-To: <tencent_C06FDC2D996D409534E8DEEC96CC7079B20A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e44b55060a6b2e41@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16548fb7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146fe350e80000

Note: testing is done by a robot and is best-effort only.
