Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E240376855F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjG3NCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjG3NC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:02:29 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD141B4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:02:26 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a5ab2d2b3bso7316412b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690722146; x=1691326946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3+xX9E6P6Lf07taF/YiDpnu7cq3lZOdD7lzicgvWJk=;
        b=XhJcyer+Yfurfyj+XLQXqOqeRwG1C+PGwqUoBUN3Lo/n3PIEKJ+3P4cXRqw6ku1/Lo
         TKc23CPL2T0sFFRc8vwMfDiceUfU+NdUHA23kc8A4aY3E0VjYSKf+mY8Ne9dydstkGLm
         r3+PipVI/S7S9WIUMaPcW+713ibccLIbK6TnVZLfO65wlEAy+rf8coi25M4YayKCEDsA
         sv3hOcX3YDM5Na6d00oqcMYnlNxlxNZLp5/bo25qiNZpuBR+gkYml2ez96Kvs+eVfN+k
         EYXbNmh0SHcWtCxHq6MFWXkIu6DUzIVSyFKRHbg4NMe0cZoLWulaevSmKHcf+SyeDEMR
         drkg==
X-Gm-Message-State: ABy/qLZ1AfySrJetxZR/cEngeO8GIzb0mDX8iCbgyzrnE1BTWTJ08dWI
        tECsUBrpXpzNPtmQGMB3jc/mIWtM9MBORECospWAiTQte0bf
X-Google-Smtp-Source: APBJJlG96CVIIsihm/Fxb7X6S10L+GaNCemgOioeKaGsHP2Wv5x5f9CCNO3XQlCS+4eQFs5HR/lTgkjruv8CsTQDzH8Rtei/qQSy
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3099:b0:3a1:e58d:aae0 with SMTP id
 bl25-20020a056808309900b003a1e58daae0mr13498872oib.3.1690722146261; Sun, 30
 Jul 2023 06:02:26 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:02:26 -0700
In-Reply-To: <20230730115619.1280-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1204d0601b3ec90@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in rfkill_sync_work
From:   syzbot <syzbot+9ef743bba3a17c756174@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9ef743bba3a17c756174@syzkaller.appspotmail.com

Tested on:

commit:         d31e3792 Merge tag '6.5-rc3-smb3-client-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11f0f67ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bdbc68bd11d47f3
dashboard link: https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101a1d31a80000

Note: testing is done by a robot and is best-effort only.
