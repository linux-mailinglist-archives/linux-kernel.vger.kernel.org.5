Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033717EAB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjKNIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKNIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:20:12 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486301B2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:20:09 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c337818f4cso5728067b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699950009; x=1700554809;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaFKPZH7VjWqQv2CWEX4CJAc8poP4JUOMzXegwAT2J4=;
        b=fik3W82UQdAECmuJzTHBXN78Grm3SzPFjsgVb1cPHjQ2SZFIyllbxyzwEH3Tv9kQOP
         pV0CbRK2mfKb/3hrmFfQO16GP4nLrjWeXcSvgqqM4FlirYJrbjolBMsqCTD+fdcskEj2
         EPArxnZhesxYMI31VQHaOqgKFVfgajJTBgZoOW6b98ml/SPAdrrw5pe7LWGtuAGiFAN8
         pwKeDYCQ6Q1CYXI55WFvsf1K7GbIFpv5iDDb6JnRBc2jp4ZPXyjTEuzAv4QILv6CvkJW
         NrxM8S9lMU0Ng5zO3WSIq5OZqdDK0BNeG16b0+9ckoyKZwomsnOykdahJBmYyfnhYYTW
         XhSQ==
X-Gm-Message-State: AOJu0YzQH0Jaye80+2TcDxhIwlL7xeXU4EYjIwIGy6jim4qBvGKB5xCp
        1QbwUXasoOm0Okc/v1Oz6bENgl5kB6vXC1cPXbeTWD0hosar
X-Google-Smtp-Source: AGHT+IF6O5l/U1wocspLpRSMStWbvjKpiJr1h1yDcxEDALNkCkol6107VEKBTteRXN7SiYB+UX2teXRnSC0udNZzVDCnoPI/tDsu
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:26cd:b0:6c5:efa0:4fdd with SMTP id
 p13-20020a056a0026cd00b006c5efa04fddmr2255916pfw.2.1699950008799; Tue, 14 Nov
 2023 00:20:08 -0800 (PST)
Date:   Tue, 14 Nov 2023 00:20:08 -0800
In-Reply-To: <tencent_E64189996EF96EE0CC9AA7DB86C512F2C606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006917f3060a187469@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com

Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137b0270e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1142f82f680000

Note: testing is done by a robot and is best-effort only.
