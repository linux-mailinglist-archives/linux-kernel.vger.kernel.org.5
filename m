Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186D97F616B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKWO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345782AbjKWO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:26:58 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A3D4E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:27:04 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc281f1214so9479745ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749624; x=1701354424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GN5qYReHA7+3HZIUiyBId29+dQhRN6/2Els8qd4jr6U=;
        b=olljuBOXYCzDh/lTwixu1JUMtcZTmFmfy400X0tRlwv22/GGcgrLhL5C0M0p3n5dRY
         EJF2FXIPR9OAI+S1XQYsrAvloiVGFyO106NHpCNdVCobCKLKQswJt48ZxeEEy9GNmk2D
         1L9EgCDxMY4wtGbB0/PnUK19GnJStj72JKaNfFXW5z7vWtJtwQSNv/whJqDET0j5V2Ju
         sfCDK0299GqMaHkQ0gBUu0BeEUF6PYDE30aZpMqQjgllb/aa7WcYyUgQyz2lwzvkK1b8
         ZsS+HRbjN3WJ8umtciOpSOPkrm8LQWGWCK1LSxPTvHiE+Uvt9FClhhQYsXHCJyQN3r+r
         SdoQ==
X-Gm-Message-State: AOJu0YzOcNNVJaibu4cz/3tuLVATQukmPXHP4Bpwo0NcegxRSVGbdNPN
        auriT2JSizH7YbS+sGxyti7doAH7FGwQ10Xhn4v+Ckk+tuJd
X-Google-Smtp-Source: AGHT+IHCUS1HXK6p9Kl61dbC+Ux77qGA9nMw4rs8ziEgp9oSqnY0lTmBb2b5SysR0PAKSwiFXOb1lTdsMV/F4PhjgLMl38KWjAiv
MIME-Version: 1.0
X-Received: by 2002:a17:902:d2cc:b0:1cc:41b4:5154 with SMTP id
 n12-20020a170902d2cc00b001cc41b45154mr1596234plc.13.1700749624137; Thu, 23
 Nov 2023 06:27:04 -0800 (PST)
Date:   Thu, 23 Nov 2023 06:27:03 -0800
In-Reply-To: <tencent_93DC466109A02ECE6EC20CAE67D5C6CCD206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032dcaa060ad2a1ec@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com

Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128127f0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106f8c4f680000

Note: testing is done by a robot and is best-effort only.
