Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28A7E8E20
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjKLEBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLEBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:01:06 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F12D7C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 20:01:03 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc323b2aa3so31938665ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 20:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699761663; x=1700366463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdzPO3+iuZjHRjLOWPyU/gBht/6rWYDdmDcTq53hEzo=;
        b=UDPkuBljteSKhGomXSn1LAbNU5/CebLwanH3d0FCJ3ZhlT6tGHLubdwI3cdbgLqMr9
         43tEV5HBCznomjMuGvVkKLCZlbt0cq9FITQP62tLPz/2zQXzFwYJtbbB8FLmBK4+5hnF
         XEzNToVMAGDs1accA/RO5Pg1QwX0jIo+lqb91r54gRRaSAjhRvmMhILP8yD0o3ldG2k8
         ima+aSij2akV2NKB0AAPixiMmE/IhFZf/fJL05kAMNsRtYzr1UZEQXYpZNF8lsCMfaXg
         gDTqKxBitSvVEsTRKLmwmc4YuPQ/s1IfhB9Tl7+T6ytm8P2oSWoSbGaFcWEuLUPmxnaP
         Cfow==
X-Gm-Message-State: AOJu0Yx6HiyTVJ/GKNGxjw3H19juxApp4p9+UR9GFXMRzLTJc96VZABE
        ZGvrSbCpAnCoAx5utp6eanOpiY32RbNhYEVtVtgc5xws8rEQ
X-Google-Smtp-Source: AGHT+IE6E96+atZ7jQUYeUQW9zcu3q5epr1eZkg9F3LhA5EksJQ7hTzPXPyBWW0plKDPqcUkk1+QjbQs731d7jflHDalRcGQhmjj
MIME-Version: 1.0
X-Received: by 2002:a17:903:428a:b0:1cc:449a:7f4d with SMTP id
 ju10-20020a170903428a00b001cc449a7f4dmr910778plb.12.1699761663259; Sat, 11
 Nov 2023 20:01:03 -0800 (PST)
Date:   Sat, 11 Nov 2023 20:01:03 -0800
In-Reply-To: <tencent_E95DB2DDFA99004F9F0DE425EC0DBA921C07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000243b750609ec9a90@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com

Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17aced04e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12185f38e80000

Note: testing is done by a robot and is best-effort only.
