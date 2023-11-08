Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD87E4ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjKHCJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKHCJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:09:08 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93798A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:09:06 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9949499edso8093537fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699409346; x=1700014146;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDaCRNynaFrwNEahv1zBluxIy63yXdGYNgm7H9CLqjE=;
        b=jeJLg0cBB7rdM53gY13gwL/NQzT27ONRCFv3rL3+HnebWTg55Rx9d1sSY4oU/JZJ3U
         pX9xRi9gRlbtJlaEY3EJCXvtxK2++ZJ+NUkou6f9pE/dVMUrrNRXsDG0fyMDMrdvoino
         yrOzEamzLbkPbT6CmqbU/LHgfAcJ4AGDRaUvrbAa0ijcLr+M0mNW8fT0cZCx6VU8v2uw
         xmtNr5nqGLd8dhrlAvNiazs3SYZpR17+JGka0ttZ5MYtGHVNtDEwsjN5nYK84QjtpLH1
         +VcwX8JRIPWi6lLcQztdMg07k39qB2pPh60ag9qGmDsUmf2n5V4KnAdmLYNyaesJWJKM
         HgPw==
X-Gm-Message-State: AOJu0YyCOyD2dpJHcThO1stgoOt+klGGXssNSJzDi5Lp4nZGGpP5N4Eu
        6AjiEuzz+IuLsB2yR6oGjWqz55Y4RCtQC/wksYhIAvH7F01Y
X-Google-Smtp-Source: AGHT+IGJldWQ/Lghj1Kvr7E2LaXyw9/2WX6xnyrtBjSSrkTzGXkQoDRWXFnvkj8esevadZUnddvX7BcqXn1ORhX03eRBMnsdAnkr
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a1a5:b0:1e9:9a4a:4576 with SMTP id
 a37-20020a056870a1a500b001e99a4a4576mr251637oaf.5.1699409345972; Tue, 07 Nov
 2023 18:09:05 -0800 (PST)
Date:   Tue, 07 Nov 2023 18:09:05 -0800
In-Reply-To: <tencent_D46F8895D0EB56EF92CC4078B66CE02DC50A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006510b406099a92ea@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1400e647680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5316ad879647e3c5
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a5d81f680000

Note: testing is done by a robot and is best-effort only.
