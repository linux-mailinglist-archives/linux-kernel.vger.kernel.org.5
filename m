Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8857B4A77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 02:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjJBAxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 20:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjJBAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 20:53:30 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED12A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 17:53:28 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1d6fdbe39c8so32740511fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 17:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696208008; x=1696812808;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYejMHysUi3+DaDkhBEJmPK0KyhAhGgo5Hb2frT/cYs=;
        b=wqJJy/uAxIp3MPiaVnhMTa6awlL6hu1OBDEABH8xM7iKfYxb4Onbquc4WqTAzhYEQN
         2q++CzqsX3BUtHDfYGGKTrGJSwk4f6fuoFRzbsiHawlOWF2HjuFBU+3I5kqzdhybCAl0
         OSqPP0RTGHbSztU0kxfRKE4pZZV4EAkrBM3EXdtdCKBCllHgWj/Sl77aRnNazYuFA4dY
         EXF6u+LdCI8MmfMtt/adKEegQJjRHZ5xABNXA1jhSi//HBr5PJukLnpzfk/KHX87T+pw
         H2erZLk6QIU73f0ifTfXRP9tg/5FSR6CxRJapqrQBc2LM6xGzen1hyIDVa1LmCQY1VxF
         WqGw==
X-Gm-Message-State: AOJu0YwjoLR9xkLvVhuIeHGORWHwlWPpaleU7K1wChiKykr1fB4CauOH
        wZ+6NxcPStqM5mgEjMoiXHtBptDgIu41dquB+RUE/CFTdBuo
X-Google-Smtp-Source: AGHT+IFbI4Sr4P/YvQTNVo5IAaVN7Gycq3WjKI8iO9eP+FlRo/A/vthZ3QKhBiBPa51ZOIixsgB0LGodFIe9gRJCF1zRdFtasdWf
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9552:b0:1d5:901f:41bb with SMTP id
 v18-20020a056870955200b001d5901f41bbmr4244392oal.8.1696208007947; Sun, 01 Oct
 2023 17:53:27 -0700 (PDT)
Date:   Sun, 01 Oct 2023 17:53:27 -0700
In-Reply-To: <20231002003015.103-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c76d330606b13337@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tls_encrypt_done
From:   syzbot <syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com

Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1281458a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100ab82a680000

Note: testing is done by a robot and is best-effort only.
