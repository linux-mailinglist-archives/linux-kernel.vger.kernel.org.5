Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747FC771442
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHFJ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 05:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 05:56:24 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836219A2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 02:56:23 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3b8b73cbfso6604540b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 02:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691315782; x=1691920582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uza0y0Kzd14TMYOhGSeE+RCXcVYtNoNe47ws5FwMzAY=;
        b=GoyJiGUQ5+RHlxBMLwbqBNF2CDJQtX/e8BDH4zNprSif/xmjzifqUn19uLCyS/56Yw
         m4AKMUwZzNrWnh/na0+vjxebKJykQfgfor8Bc2pebT4zwQF88iHn4YTENckdhpipjl3C
         Hu1jY6Y7TkL/7gbcOOiT4438dJEfflwSQgtg5ScGjAYpJg7EkTf4TOl0Xg2x2Cq3gtRL
         UjtaRd19eLs6yLJX/UVKrC56Zzcr5Mi10zCyL++E4VxoSqFyZW98Uytc1gvesaHFGAe7
         dyC7AslNK9srfVzo3FriWIDoIMz32WkbU0YD/mXP4OBGqKp8uR2vKBxv4YwQXalQ/6X6
         kV6A==
X-Gm-Message-State: AOJu0Yw9LyKZGjVdA97bOc//46DnIztgJJVGAxbx0XY/gcMHvvZ3t6CO
        uHChkBi16xfqrv8TGs7nICOR3f2i4LDdtOUIpVUPm3rcGYXK
X-Google-Smtp-Source: AGHT+IFa6jp4m7d9b9dFUnIcO2mFtKRk4LPFmGWz1YxpZpyooRzx9nUuBmBe8zkImaktAdYBdMK+ZeR4/sqMmu3PWc5syt7HNzrS
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1508:b0:3a2:4d1d:2831 with SMTP id
 u8-20020a056808150800b003a24d1d2831mr10298636oiw.3.1691315782564; Sun, 06 Aug
 2023 02:56:22 -0700 (PDT)
Date:   Sun, 06 Aug 2023 02:56:22 -0700
In-Reply-To: <20230806093506.1754-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c430406023e2496@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_lookup_simple
From:   syzbot <syzbot+57e590d90f42e6e925df@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+57e590d90f42e6e925df@syzkaller.appspotmail.com

Tested on:

commit:         bdffb18b Add linux-next specific files for 20230804
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15589f13a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf5fc5e1e5446f
dashboard link: https://syzkaller.appspot.com/bug?extid=57e590d90f42e6e925df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
