Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4407F0607
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjKSLvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSLvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:51:07 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D960E6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:51:04 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6bcefd3b248so5137513b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700394664; x=1700999464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tU5dSvrjaHQtoWtMf8sdTG+BHyjDSYJGLVdkiH0j5SE=;
        b=VZxzWZuI9ncgIJeJN2L0bcwfQdy2pFubRHWTjhYpUmR5nE6LBRzUWXnTQl/nf1KQqR
         CuCCgESNSBeTWEEpDU6I9Vd47B8eSANAsEOOJrW5dAa/TDeLCGtdFOFnUcmcWJwE3CKd
         z9cDUaXuDMs2BgImAe3TgvenHztjCBXagKRE6/O5Nao4rHvSipXEulCEXQSZLFaz30fR
         4CXvQklmql6dH9EAYFr15OKNb1nqE7qSklWhUJmgftDelo71roBlMkc5gn5ZQbMVF1NZ
         3ayNKPIMpPP+96ZomeCe+k9hOaaqeJ2SA/+37tN4lKsiq9RVMVWI1cPOA+RyCPRU/5JD
         ylfg==
X-Gm-Message-State: AOJu0Yy3auEC729q04XSJquw4VPYBY1MTsdLwViOp6JcalZZ5cTcNc25
        NRdfZ0sJsdbtodKm0Ewb8L2REzTX7HyQNejL2Z3KAo4fMvV5nyc=
X-Google-Smtp-Source: AGHT+IEAbE9gorxjnh0XB7polwhyioJvOD5cK2sT5/unE8aR8o47LfqrRFzuhzK1MzFpEAsSJ6LHheUP857rB4NMGYpESLl/gIHY
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:308f:b0:68f:cb69:8e76 with SMTP id
 bh15-20020a056a00308f00b0068fcb698e76mr1094909pfb.2.1700394663763; Sun, 19
 Nov 2023 03:51:03 -0800 (PST)
Date:   Sun, 19 Nov 2023 03:51:03 -0800
In-Reply-To: <CAJjsb4r-b7_MjEVkCofJqSQ2+02830AP=vbmBK0D1Z8KzcfWfw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e96588060a7ffb37@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (3)
From:   syzbot <syzbot+a9850b21d99643eadbb8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
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

Reported-and-tested-by: syzbot+a9850b21d99643eadbb8@syzkaller.appspotmail.com

Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11a72214e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a0f7dcda113cb99
dashboard link: https://syzkaller.appspot.com/bug?extid=a9850b21d99643eadbb8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
