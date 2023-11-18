Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BDA7EFD19
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjKRCHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRCHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:07:09 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F6D6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:07:03 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so2961666a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700273223; x=1700878023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbw9RDTyUifBxomlYchIdc09HUL7QJSk0Z1pya+osvc=;
        b=hA1m49MftDFj9ltZ1qRMELxP4Xv+Vk/70o8UpWld4Poie/V61MEzkI5A+oiw5fckMj
         vm5iUGJj6BcWZpLvuCUB0wXLv/4B1EdxBlniTFn/90iDXTO2Apvhn7ybQKM1i1LIB8NH
         EVTFVLpTwN/oDEAQTqV70ayl1FyYnoXYi20VPPrcbtcIAkupLGZd89AeTotcUHqOukZz
         YVJLcYbH9ORvvnR5gW/BNagppy3PFsNafYE27PqyNv0xgFrdNpBnkDpidT6smhn9kpcR
         umzmZo3pQF0dvzwpts6UPBou2xovK7cXn70JjOWFjaUftCnuHvqkCjiVGjhN5KQKu/cP
         pghw==
X-Gm-Message-State: AOJu0YxsFO3Z047VwkR44i800xTA0Q9g7Wf61dMr2I0QtS73RHOpinG5
        jOgOnVFyNv5aH6APhFdNCdCeIvldLjQQa+ry4wqY2fkcPaQS
X-Google-Smtp-Source: AGHT+IGnJRu5V+gdCR+4yvwKfkAi8U+BKw8TA0A8tvP9QpMh9ISe+Y9h62FRRP4GrnHF1flM5PyIps4AwEiWCt3AQeUpTjmH+pWh
MIME-Version: 1.0
X-Received: by 2002:a17:90a:62cc:b0:27d:dffa:b374 with SMTP id
 k12-20020a17090a62cc00b0027ddffab374mr295377pjs.6.1700273223477; Fri, 17 Nov
 2023 18:07:03 -0800 (PST)
Date:   Fri, 17 Nov 2023 18:07:03 -0800
In-Reply-To: <20231118012439.1685-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081b046060a63b57f@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com

Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ace3d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15faf610e80000

Note: testing is done by a robot and is best-effort only.
