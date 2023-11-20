Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E757F15C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjKTOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjKTOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:35:26 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688A137
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:35:21 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1b9860846so5956194a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490921; x=1701095721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=WbiQHY6ijfuBCRx9ECBEg82E7GuB6uCxMWdXKCYaNvGbyW+kkYAcTNv6UHwf2rCWst
         vpeUcbP78L3G00sSP/sxw26ut0J6ZIteb5RMrFIfkLjusGlIxKwEuFHhpJu85Hte2Wmb
         z5mWuTkIW1fuI8qLVMd73XJ3uATmzUoBALb69WL+VX7Zn8ELRgvEAEwYm1D3+DOx0xVE
         wKEB2ZlVAhanQmsecflqjVTocqz724a1ZCCGNB2gWBa1m0M2e+A0Va3pxO4DMIGfmztB
         iqOQplDV1KuNx4nvU5tYTVT8PdkIihdcQZZvoZCTCl+mIXvHkCZAe4cql1/GVHyj1Gx7
         MLJA==
X-Gm-Message-State: AOJu0Yy368XOahb3oLNfQNFWlK8kuPtLY72aZJPKPhpDU4TkXsgwCdfc
        Qtp/pZjCHEg6c0qVjvWWAlRER1rThN0niRGnKLAbm0fGR8sH
X-Google-Smtp-Source: AGHT+IEzo56JbmoqVwXpNg8mySCpYTtfjo3yW4Qe9XqQZVtkbrSYD8LRgMtcpz+jO1iIYLRpugHW71s2+YOd//5V4KN6QrJvxIwu
MIME-Version: 1.0
X-Received: by 2002:a65:6897:0:b0:5c2:1816:24c5 with SMTP id
 e23-20020a656897000000b005c2181624c5mr1598710pgt.10.1700490920919; Mon, 20
 Nov 2023 06:35:20 -0800 (PST)
Date:   Mon, 20 Nov 2023 06:35:20 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000490858060a96651c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        jose.abreu@synopsys.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        nogikh@google.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
