Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320FA7E0F7B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjKDMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:50:06 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E88194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:50:04 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ef5310a497so4080681fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102203; x=1699707003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q7PNHIbrg3znXPOCFAQ4zKjQqmzL6eD7V8uVK545ys=;
        b=cdnrOVixV34vQ73Acbco5qjQVjRFAOpu5aGq8XLI7Fv9VOpoyYgcDgotWeexEIb/LA
         YeBkxsnsWgc6So0PgEesWmpzq69RjfHI8LjtJwR/aA4rgNWRZOG6W4ZcRo/asvSuleYe
         nDGjIhhv3gJKakQNW0RncYPNKXwB7yPCl70CSMeTaq5Gm9xVySB0Ev2eXU5VGuAK1G72
         2at6EIfxe3M5qcW0dzffuScznxcmJtclTXSsIrZ0yEccxgailWDxX1vPzm+3+kR5o8aJ
         ukbApltHV+BAD6YU/4cMKt8HvSeWYn3H1BLEgNTp1KxkQfbtHIMDUQjjFBim6xpVE9S9
         LkNA==
X-Gm-Message-State: AOJu0Yxz1eFfYkwlzYIrmo7RGpWpELS/iX7EwE8D9XyUnEzolHH5/OGi
        ke0pn6BDpoYrN2+cmrFSGq955VG0ivQfdqgin9nk2PYta9WJ
X-Google-Smtp-Source: AGHT+IH4KuGGDSwO1sfg+gNplZeQwa4m0Nmi3da7Ak6avpBccqMzFTEHL2aLAz1wM7erQdRnCcqM9bWx2aiippB6WKYq0D0UqGSg
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5489:b0:1ef:516c:4aba with SMTP id
 f9-20020a056870548900b001ef516c4abamr11593794oan.2.1699102203758; Sat, 04 Nov
 2023 05:50:03 -0700 (PDT)
Date:   Sat, 04 Nov 2023 05:50:03 -0700
In-Reply-To: <20231104112657.1312-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ad0220609530fc8@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
From:   syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com

Tested on:

commit:         90b0c2b2 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10124527680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d6f190e80000

Note: testing is done by a robot and is best-effort only.
