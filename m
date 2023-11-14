Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FD7EA985
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjKNEbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNEbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:31:07 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A71A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:31:05 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso6439193a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936264; x=1700541064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9ET5Gngj+IvIl9Ss0rfcSW+dy5VDOPh8mcyFDYCA+g=;
        b=e+tGBuVc6mFG9uIMZYbuSdeWGZa5mTwVWznf9yFKv/Zopds4Jkp9UKWt3kNfi/CeU0
         XT6kbudDRBk/LGrC75c7t1DD9FDTNrG8bWhsdg+4lYkd5EG/il8uYvyeXMmz1Otcl5CX
         gB3q1LoDwgw+sgew8P9WyW7u6ktSKtI/pK86ifEyAWrSUqE4Z+fdG+va/Z2K3Ta8+ToO
         W7PGZHrFxTNhyWOgi2oIWcin6apcJHNPCsKmFfjryMQb/0SfHvlEzXgr3PahMI8jqec9
         keD4bhU4XnZk1YHxR4WSQC4M7vX0yISOmMii8kDA3ZOF7STeWwd7aDAf0v4W8DOFase/
         58hQ==
X-Gm-Message-State: AOJu0YxnMAMSlUK8Da/S0MHIZLL3FThW+nGI+bbafCr/hlo8fS0pUIRR
        cZYOpqE5iDj4Xoo9zE3Wi55thDA7ubzPzJ8q8iUONlgSw9/t
X-Google-Smtp-Source: AGHT+IHQJjqF1iCdgmhInIEeMMk7Bjk2pj4fDUpvLojScwNJ6knGdU2PMQnZaLSZkNYR97Q36iVwybzxidwxQOyfn9Viow+rqkW/
MIME-Version: 1.0
X-Received: by 2002:a63:1d53:0:b0:5be:1908:8f61 with SMTP id
 d19-20020a631d53000000b005be19088f61mr284042pgm.0.1699936264156; Mon, 13 Nov
 2023 20:31:04 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:31:04 -0800
In-Reply-To: <tencent_38DDC0DDA319044FEE0D83258C8DF9126207@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a8016060a15416c@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16f91eff680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10923b0f680000

Note: testing is done by a robot and is best-effort only.
