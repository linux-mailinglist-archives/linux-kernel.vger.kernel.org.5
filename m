Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0E7E4E47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjKHAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjKHAwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:52:08 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3DE101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:52:06 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d30af2399bso8301656a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699404725; x=1700009525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfwHW3L0bIpD4ONa1LZUh7k23zc2aXO/LvIUJYEwzHs=;
        b=uYINCXQSDgrVGh956Xx9hSjNgfYsCtspNc/4s8LPqvaDGJiEez6xr0Sfj+A52fse6E
         TUdY12MA7SKpvCWa3I06gzqx2pidYKLJNLyZr7SqR+nvXxIHQK8D79QKAdBRdSCLVyXJ
         H5A0CgPGIlfjT7UKRGgcjdQtrQELc3wFs48fIcCj9PeyGzhTZkGe4DRe4EpzOjK3oEyZ
         irU2iGu2pSLd5W8oy1uKGL/gC0HmD3f2R/5WaFz7B9pHx3Cp6wTYmBqtq+F+S8qC/JsP
         WJnMOBHaEt27LwJmtljntweHe9jQdQGfe4HaNa+bzreutr1O7FHwQ1AZ/MeFzHQJrtUu
         r8oQ==
X-Gm-Message-State: AOJu0Yw48MbHzImom89J368GHhp7IKcQGkI7LNOFMwAkkXRkHtU1TXE6
        EAI7DWG0OXN2YVZX8Fsk9TXa5kX0vTYB17ZvdG/rbM1jufpY
X-Google-Smtp-Source: AGHT+IGRY6JgD+lpzYeLkEjSnhiqTXZ/gOrOQUNR4DMZO4rb2qjyqW+aYS+bao2N1ii5JmeGgUaCCVxDMgtIrxVh35gktCHmzYcR
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8291:b0:1e9:c362:a397 with SMTP id
 q17-20020a056870829100b001e9c362a397mr130982oae.10.1699404725619; Tue, 07 Nov
 2023 16:52:05 -0800 (PST)
Date:   Tue, 07 Nov 2023 16:52:05 -0800
In-Reply-To: <tencent_C325838DE11216DD9C5DAA192E4FCA0DD207@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000014460609997fa2@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_mq_start_request
From:   syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com

Tested on:

commit:         4652b8e4 Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1629a00f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5316ad879647e3c5
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107e3ac0e80000

Note: testing is done by a robot and is best-effort only.
