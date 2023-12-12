Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233F80F5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjLLSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:47:59 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889DBCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:48:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b6d023424bso9709976b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702406885; x=1703011685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V30quyR5nGG+cizKmgiyN1Zpgpbs071INd1z6wgamVw=;
        b=Mv9gTMqNyG7ElS2pTC4XL5ldNbGoBim5yvTzFIR6bSqkXYa0oRIqxQyyED84mVyGlI
         9tS9ebi7tqaKIMnzEaM1+2tJinII1Fk8CVRK8XKTQ1gZBcHJdYturxfS5lL/fGHPp31d
         Bu2jaH10EK0Zrrb+eLND/T3nmkt9++EraJ0PJG7rZfidHKrYKh5n6eobLkrEEzSeWKwG
         Mn5szA79cDFUtP0bDbrvLWfJMm8V9v/EhH9v+QPqqWSwrMBXwspkbzbHue7OqH5SPQZJ
         cP52jE2CCErZnM3lF/d2xhFjCtl1rI3peW9Bg1yYYOrJ4w2TFDAIHLyZ27PefLr1VbCm
         01Hw==
X-Gm-Message-State: AOJu0YyM2ZPnfEUTK/9oZSHOxV5CS0PmOaHQ80YNFGPBQIn9M0pj2n0I
        iSPx+xQsdRCTKCC8zStY+cgsVs3AtlBEXADPDyvN6dDhgxD+
X-Google-Smtp-Source: AGHT+IF0RMp6mqDl4UC4Mb6dkWfTYFGSTCRAcl+WqGjAX8OoZOC4Y+bn/EWshvRW1AhUdftyPrF5qyfOY+5WZ31cqMuZld8ix2Vs
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1817:b0:3b9:f195:ee3e with SMTP id
 bh23-20020a056808181700b003b9f195ee3emr6668046oib.8.1702406884982; Tue, 12
 Dec 2023 10:48:04 -0800 (PST)
Date:   Tue, 12 Dec 2023 10:48:04 -0800
In-Reply-To: <66e9ef2c-baba-4484-be9d-4abbb930a7bf@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4857b060c547d5d@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         26aff849 Merge tag 'bcachefs-2023-12-10' of https://ev..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=110579b6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68704e9af8d2dd7b
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1059a15ce80000

Note: testing is done by a robot and is best-effort only.
