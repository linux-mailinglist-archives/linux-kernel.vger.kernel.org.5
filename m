Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F787F7326
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjKXL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:55:59 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83B10D7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:56:05 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6baaa9c0ba5so2330482b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700826965; x=1701431765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY0TCr3195BSgmksW3cuNcZ2fU8zsdBU1q/GFbf+BHI=;
        b=c1LCdxYTqz4rbSj5eQLmGx4vIUNi0+1DAM18F45pFjkyY+B4AE6Ldtqs7GMnQ+sFTc
         eojMyXlR2HoAgwdyi9g9rhtqpcoeAIKPvA1IIAge7/YOjg5lu0PlyHYIJmAiHNkrOqFU
         TrngNEUJW9KFon23GMekxH0rr+viiMIS2RLtFk/vZ21hx/lRoW4bLjanNuwgqX/pRfMU
         S3MBQdMAWpOklFvHyGExF458Blz+JHlhJJS9t0eAfhtDjt8+5+ver14lGflGf1l2oc0k
         3V9spQe15pSiD/VZgc6V1IJQ7DqS8bFNjfOiErh0m3bOKVC8xjtSli6mjuyj1mCvVr9e
         G4CA==
X-Gm-Message-State: AOJu0YxLV15pqhTTPp9Ydkre2vCdKGuQJdufR2SbLFPug8Cz+U7KZv88
        wMMSUjQ18QKiiXuGgSq1R99Rm7LcdHn7eBP7K34CuFjW8TiS
X-Google-Smtp-Source: AGHT+IFjSS5InYP35WhMfdg+bxrqT6gvSoE5f56ohdmdnS/bnPlrIzawH1FRyxdVBozslxgmvyFK/NDDeBlTJmPOifl+egJuZlnr
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d27:b0:68e:3c6d:da66 with SMTP id
 fa39-20020a056a002d2700b0068e3c6dda66mr669272pfb.6.1700826965229; Fri, 24 Nov
 2023 03:56:05 -0800 (PST)
Date:   Fri, 24 Nov 2023 03:56:05 -0800
In-Reply-To: <tencent_ABBB2A33F49E801B384B7B1BC02538BA4A08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000164559060ae4a32a@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
console output: https://syzkaller.appspot.com/x/log.txt?x=170a9544e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1476a4d8e80000

Note: testing is done by a robot and is best-effort only.
