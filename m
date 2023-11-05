Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C07E141F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjKEPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:41:17 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EBDA7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:41:13 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3fb625e3bso5100195b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 07:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699198873; x=1699803673;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gElMvZ90E9NrLp0DJcJVCcc9n231HGrU6vRzoKnEB/A=;
        b=VPBtIg7V5Pd/le2lY9X1I095M7mVw8Plf7OpsNKyEnT5lTOYJYQRNozS5pN8x3WriO
         h7757eUb0jNQavWBoBVRxi8cJTnOwFE/rLoETP48hIe7GQdfI0qPr7B5wpKFPhco6/e4
         PDiCrEfo+tGOyXspADfi0FqOBKb2cnddD8mlopHAslYitf8F2ufHp2ectjXOpjoMLVQf
         g0WgiPiUtiBQTgaBszlhYjvTkf8IMB7NBeZFP9HsN+7Irzo6jsIOALZtBNDY17vN9c6h
         ickX4hP0Fd/WCg+6ZZW+dUJewUuIvCOTiMHkU0/o3c21MR0oWSvs/cbVnydjm3TgHFRx
         QkCg==
X-Gm-Message-State: AOJu0Yz+xf1Xn27LHcBFu+qUcnaRHlOYlArMyyKLj+1FYhDKu0k9b+eY
        f1pXlFkpEUh0PFtWTJn9CQpZG7lUFWacR6dXtxOUIMk43iue39s=
X-Google-Smtp-Source: AGHT+IGn66kd/YTMEJxsyJ3jUbynVvUNebw9b2Xd5uzL2exAy6ad+Zp/9Lygk9KdMOmOYglJDeTY8gFPV0I39s5rAAk2EuHBFZbX
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3609:b0:3b2:e15d:e560 with SMTP id
 ct9-20020a056808360900b003b2e15de560mr9159182oib.9.1699198873222; Sun, 05 Nov
 2023 07:41:13 -0800 (PST)
Date:   Sun, 05 Nov 2023 07:41:13 -0800
In-Reply-To: <CAK6rUAP-bopjVvGxevFKHEgVhYPxQMD-b2TGsmf81QWSYsirvQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dc45c06096991ca@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rgrp_dump
From:   syzbot <syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, osmtendev@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com

Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=176d137f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3093f0327aee8b7
dashboard link: https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c10097680000

Note: testing is done by a robot and is best-effort only.
