Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05507E8F68
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjKLJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:58:07 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBDA2D49
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:58:04 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c4d0b51c7fso2167736b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699783083; x=1700387883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BLJxdXugk9q/rwyYn0QAvn/5Zf8p3qcEZzsQtDw9a4=;
        b=gWnQge7HRRhH/0sGpvXA3gzuxLJYhPCQgIClara96Y8f2LfdpkDstuzXEl2CjNLcTI
         rKV3QZ436tVQQGQW5do9Fem1JYo2TiUPErsSzbE9qUr61t6uKYs2gqZyYcdmYe6tEuyF
         hpijyvQ1yVI1dgqa66E2qgqquJyvOXPJ1Erp2/d0bgQTeJ3tOWAozWiz1nvWa4ZA6MO6
         Jgm2/fB5RLHTljRkM8Vh6H2erPoqMPOo3YE2UJGqvjYxnHeazTmONAalShEMN6h0ZfUz
         CucnPsQ14hFguYoGERBCSZuPmp8v7fKD89pEjAFVg9HeZYc2Xwl8kIOHGsRYNJY+uoq2
         KGVA==
X-Gm-Message-State: AOJu0YwWWicZHfcEZZzJ5j9fD154vlFU+w3rlDP3FvncM/Hy2gK41ifb
        GLUMH0khOAf2lteNG7NnsgCDPJx2S9LW9eur6yyVkteJqavb
X-Google-Smtp-Source: AGHT+IFDRz6qMs61Rc2tFfNK9HFDMmr738nin/r72bSik1grxCK8YZ6ptqSm9cFHwTO6dq4iERwbVrkcmwHm45OGOnuCWZjlcEeX
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d91:b0:6c3:3489:6fd6 with SMTP id
 fb17-20020a056a002d9100b006c334896fd6mr1223382pfb.1.1699783083708; Sun, 12
 Nov 2023 01:58:03 -0800 (PST)
Date:   Sun, 12 Nov 2023 01:58:03 -0800
In-Reply-To: <tencent_A16EFC2D856E689510EA1AED2ACC2C785A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e657b90609f196c2@google.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From:   syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com

Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11830270e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d85f38e80000

Note: testing is done by a robot and is best-effort only.
