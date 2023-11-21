Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCD7F2691
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjKUHoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjKUHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:44:12 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0AC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:44:09 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bce5140a2bso7046779b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552649; x=1701157449;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1paySb1+ztsc72snsBioRzTdhcCnKTQx+dQOhjqcX+s=;
        b=BD6TTBBUNN1opbNMHWRbnOFDMKeg3Ww2rUDKuzYhMc8EIsvTL0yCiMh+zuuOVWiyxQ
         /jmmuZ+rQdE5n1jSGseV1GLbxzl3D/01i2KVWy+CTuX89UBK8tgDZnqs8/NaM4ok+yvZ
         SFk+26lc8RLOMG1uDwG8kWsUioB2t2eqEXbSDGDyjhuX/N7gzBaNXUltgJSomH4nJ+Wl
         KURvqTqYe+9TU5D2/NK2ChsLGFH1nqthCN8+cMYbgp5xPsaQex1srSdmo19ybL7AZkDi
         jpGTCiDCeOaZm8tbLCJv2pzq9qkBrWs4Rzz6Yk2mFrHoxr943bBINnw2WZic6hTgTaD8
         jf2w==
X-Gm-Message-State: AOJu0YwbFuuj9V7L3cXK1W3xBvKHAA8ik5LXfQtMsT49o+nAhT57qi3F
        DsFQxtU6HYJWsl8PrIunZczfP23UUxGCocAkR0+IchzWsANMBRo=
X-Google-Smtp-Source: AGHT+IEqQFXMNqTsGj3ThXWFH1RzAOK3bQIj5iSY4zPI9Y9JOR38PHYGLMFvJoM/tX6/pmLC9PxuKs9bY4RGZLCdVlcbZhlJEX3A
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:140e:b0:6bd:f760:6ab7 with SMTP id
 l14-20020a056a00140e00b006bdf7606ab7mr2897780pfu.4.1700552648954; Mon, 20 Nov
 2023 23:44:08 -0800 (PST)
Date:   Mon, 20 Nov 2023 23:44:08 -0800
In-Reply-To: <b7be3f26-2e6e-4fd9-3b38-1fdf0da2a1e5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090317a060aa4c450@google.com>
Subject: Re: [syzbot] [net?] [nfc?] memory leak in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com

Tested on:

commit:         07b67795 Add linux-next specific files for 20231121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c090f0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=824289224986e9d2
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141f0348e80000

Note: testing is done by a robot and is best-effort only.
