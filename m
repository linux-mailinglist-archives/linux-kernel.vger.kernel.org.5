Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203327EFE3E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjKRHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjKRHSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:18:10 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54150A6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:18:06 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc56cc8139so32575065ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700291886; x=1700896686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKFqfBCVL0pgIxSCr9XNigXEMTkeJ5LzOrV0Y1DN3IA=;
        b=AHPknU3RA5MPHCUtzKa4bVy+wQQiESkUunvG8r+69mpTaLU6508GegD7iFTu18bVTt
         dYw3SS91crcwVWGJrPnZeMTFZJlqdaF7vcw6kxf6kzag3GzhzV4AP4Fyv6NU5S4OVEti
         IG40QGaNm0jxCEq0HCrRiC6TB1B9QvxIhM35tBTvNsq2MvvQ8fx9TcOi8F6Y9RCYzbAz
         6djoc1pKuT0aiP7Iny/0lZ+LBcCg0aq52O8k8WjSWvMURX24jph5cDm4qLZLOqya6KUO
         Gty3C1H0xQLJKLprMa6LxKMGfDal5Fs5Ac1DTaSNNY3CjFtYlPb1AraRRIGK2lUuv21p
         i10Q==
X-Gm-Message-State: AOJu0YxdeCqoMDY0zZzfoGtr0F3XQHrzyp4kiA8JihMha6KivCX3C576
        D7/zZvMCgcIoVsvEm/ZapnY+mzUJ9JZ3QGtLo+A53sjD46YB
X-Google-Smtp-Source: AGHT+IFZefHuLPndTNA/BT7evmQV0clLewi4zxZTUbzoEEb3sKyNatMVwMgUGZopM2VArswndEa6ErbTF7zSa5dbP60rhjMV23+M
MIME-Version: 1.0
X-Received: by 2002:a17:903:2684:b0:1cc:166f:91c8 with SMTP id
 jf4-20020a170903268400b001cc166f91c8mr371466plb.1.1700291885892; Fri, 17 Nov
 2023 23:18:05 -0800 (PST)
Date:   Fri, 17 Nov 2023 23:18:05 -0800
In-Reply-To: <tencent_065CC990AEDDAEEA8CB0A7C806E012E74606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df8ce3060a680d69@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com

Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10163458e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b06fb7680000

Note: testing is done by a robot and is best-effort only.
