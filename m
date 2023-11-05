Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67897E1209
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjKECGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 22:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKECGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 22:06:11 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1ED9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 19:06:09 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-581f08e76abso4044254eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 19:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699149968; x=1699754768;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTR1AQYSDmiiSG/XIHPQy8eQovCmLbh+8mTiH5UWGLQ=;
        b=ElfMzrCZECPa7fObS2030MlOfTxvO7ubeWeofT7ebPXukL1TKpc2gkirBhGcnaIUdG
         2mEDbHod9GxbDsRzAIy8NbQ13PCBp4c6taEA3gd1XlxL00IhSYCc5aQLCJlUpfHHpGdN
         4jhFG9hlnWfDKuKsqzwL80dXJlsqsBwD3d4Frd2CWZgiKr4o53NSTEDtfOzlo/k+KolS
         tEpVxHxM3hmEJ3jD1R9ERR3vZOaBna3kZ6Rr84c0Q2suCNPC4zFz6JDlc5PbaV2uJbr0
         6XTRNhN9a8LgtIWzwfITp8dktLkFt55ozHmGmH06pwtQR4TJMdPyjcpzoj2gPk9C1jwt
         1KDg==
X-Gm-Message-State: AOJu0YxMJwr/iORkMy1k/eu7ajjKHDXi4ipYVIHioZMspMBWgliaKM/o
        omC0yfpJkCvynCxDxP3kg7LR0Xdp7i/ZE3LyI6ks53VUASdv
X-Google-Smtp-Source: AGHT+IG85D4UEx6u6k4GNov4APla44DJpvo31aEUCnyRzS5XiiKe8F3ffLPkfmrkVzarRLUSpk4Fz4BN71iCiLGnADLZMwlRzT1z
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15a8:b0:3b2:e6d7:637f with SMTP id
 t40-20020a05680815a800b003b2e6d7637fmr10641930oiw.8.1699149968598; Sat, 04
 Nov 2023 19:06:08 -0700 (PDT)
Date:   Sat, 04 Nov 2023 19:06:08 -0700
In-Reply-To: <tencent_C16C882E596CC49668E85AECB6CD307BC60A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c6dec06095e2ee6@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1391e40f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e86de086e9dddbc6
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f749ef680000

Note: testing is done by a robot and is best-effort only.
