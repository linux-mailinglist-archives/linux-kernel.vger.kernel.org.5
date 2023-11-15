Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FC7EBB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjKOCnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKOCnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:43:08 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D2CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:43:05 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5be3799791fso5468453a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700016184; x=1700620984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW8ywFvmu7dO7/0506grRtr4QU17MZsAekhDpiM1viU=;
        b=H3ZWZEytnwuI9Ss6KxVBDRjJL4uPPQpj1dmSWVfFXQPp7dS38AKbHCk/HjKdqbpLFw
         SQK97Y1f5G3QMp4696B1zP8ORKCwH5+Vhi9sJyCiN5IE6p7VodSzuENKliy3Yk5COirL
         WzSnXnICEznPlLlPHDXWN0JVUuhvHfyytw03EiYTB2vmx4NjelC/ssHU3KiVheDrMFrU
         QPQq4RfNsWb+6diEtvR08PayGH7wMaj5CwO8lWmij14SSu0SmTD1jCnLueAm8HUc8HtZ
         n6LS3FTABM8/UH4TdBDdq/P86yXIiNPEi3dXm6nYa3AZ8sQJ7OjAO6NQn4W9pHg7qIzK
         qYmw==
X-Gm-Message-State: AOJu0Yz+4fbq3t0ii/Uf/1Lc4eNPD0R0VZFUBIvM4Z1Nx5EeAr1bKQiy
        vKCzMelwTKNVnprvLyJdMBePN6mkQIMhfK4xMO7Z2fFISCm6
X-Google-Smtp-Source: AGHT+IH+VvsrzT/tYPkSnMdpbY8OWklTNIw+NMo3t+PVjsvzmPBBL2NjQ1w7yonBgxfzjxgVBIYQDykBhby4nBe3i1R1+mkbQEVB
MIME-Version: 1.0
X-Received: by 2002:a63:1b60:0:b0:5c1:589d:b3e5 with SMTP id
 b32-20020a631b60000000b005c1589db3e5mr1062085pgm.2.1700016184578; Tue, 14 Nov
 2023 18:43:04 -0800 (PST)
Date:   Tue, 14 Nov 2023 18:43:04 -0800
In-Reply-To: <tencent_9922EDE6CFC478066DCC2CE56E8095D0E90A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb59e2060a27dcb1@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com

Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1639ea50e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10560014e80000

Note: testing is done by a robot and is best-effort only.
