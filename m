Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A81752487
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjGMOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjGMOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:01:33 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5EB1FF7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:01:32 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39e94a06009so1248819b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256891; x=1691848891;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8JB6PpnduINUlvaK+TWGfb4wz1t8n/ViBmSGBttATQ=;
        b=Ky1zNW2sLosJV3ebRNcxflacdlZv8wfpXfudtzLgU0HEC+qZevDxEMjFPsP4iyIucb
         SYYN1lZHT1gAblUea0Btfd/w1mDWQdPyuDOH1qdT3ad3Ltt43GRUOKyiQ5/ZXpMG731q
         PXW6BbtUaS7sCC5iYx1MJjLkq81cqX8fRYtlC3iYs4d67B8kwfUpDqqBanvb3egqBtDt
         6oyBmzRSq6s4eb4MkgdJo3SuAyomRsvG7cUlyh51LcV/KbZ0TXKt0chkeCksyAYyNj9a
         G7VZnpsej23ZjX2IqYQJwqdMhTI8JBE4i0o8zWu7krD+bZ6YVmX+5UxyluNY/tiuD7GO
         VAaA==
X-Gm-Message-State: ABy/qLbyBZKV/gh06mIOFs8pGUu4adll1UmmQR3Pefx/1qSH7Jp3Q+wG
        vmZyPa7i37TVO1OdPhpVpwaIFwaXEZ1WkfZGpgQG1k3Likzz
X-Google-Smtp-Source: APBJJlGro6fXLqgxq7Tk9BOZ4RYklQo9WFMCitJoc0Gc40XD++PUDcI4zuTQkECfZFi+oJUydmPIbQqkdcVGo9IZ24gEpZGpdFo8
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1394:b0:397:f54a:22d6 with SMTP id
 c20-20020a056808139400b00397f54a22d6mr2088248oiw.9.1689256891445; Thu, 13 Jul
 2023 07:01:31 -0700 (PDT)
Date:   Thu, 13 Jul 2023 07:01:31 -0700
In-Reply-To: <20230713133230.398-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2f8c506005ec4e1@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From:   syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
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

Reported-and-tested-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com

Tested on:

commit:         e40939bb Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127d29a6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
dashboard link: https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dc6ed8a80000

Note: testing is done by a robot and is best-effort only.
