Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BB79C6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjILGKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjILGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:10:05 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D2F26BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:09:27 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5704127d08cso5632519a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498967; x=1695103767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqrHipoMWs9MHsi4UQNaP0bTt2o6/+cmPBB6NZB/7YA=;
        b=Z4YliVdXY2d/QwHcrss8rkKUgovrzEokBg2byI+vPqjS8e2UV85PRMlo14+0oBu+00
         qslOv1zmTsasaxSbym3BHJHUrijhvoE4hLUETQ/ZcBneM5VOI65c3SpDBlfMvlCvsKME
         td3dhS1aJcCbX74FpZTt9PsmhBx3+18d1K1qV5yj+irxF5zwN17vn+gEUOW5L0F2d1Tf
         tNjk9QeMhk4ln/zXWfD3dB+A2trb+NB8gJIAGiUdstCl2xsj+IJS24Teek1NAbVte/D9
         dzxSPlw8YxZM1Uw8h5LwI3FThy5ZRBdWAx5ehRV9E0FO8uO+hiLyzRr3was2KlZBA96o
         Wlsg==
X-Gm-Message-State: AOJu0YzLgivPNUjsB2Yvug94hLWk9WCsDgBQERrzGhyiCR1eV40oFvom
        4Y4GHZIUXSIVnZIolHfycWFBga6KO2OY9ToqHX52F0Z5JIby
X-Google-Smtp-Source: AGHT+IE4PjjCGY462cT5AHLS93AAFLKaG5PcWiruMEQmfbJAUQ3YqEKvc71RsU8lkseCM4h85rCtlKw5KdANOiPynHUPS0nZDzRj
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:91b:b0:565:ed29:8244 with SMTP id
 ck27-20020a056a02091b00b00565ed298244mr401945pgb.3.1694498967366; Mon, 11 Sep
 2023 23:09:27 -0700 (PDT)
Date:   Mon, 11 Sep 2023 23:09:27 -0700
In-Reply-To: <ZP/3hgDCXeceE9uU@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005b37006052349ad@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
From:   syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com

Tested on:

commit:         0bb80ecc Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1574bfc8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba194e5cfd385dbf
dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ad2dfc680000

Note: testing is done by a robot and is best-effort only.
