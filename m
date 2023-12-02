Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D57801D6A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjLBOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:55:58 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C3102
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:56:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8b286abd2so740471b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 06:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528964; x=1702133764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nu5xLdLOLeUMpry7HT1oxjIq+0DkqL24uDVpCnJXOHU=;
        b=CMYFTikPYJecBPsvWyp5YU1iFBTDPZvYIA8kN0sSw2ciVmH1JtWubEg0tD8NFeN5Vi
         zpUWwC6CtXwXfqhjCs2Bo3jwxvoTKi1AVACnuwtKT0tpa+iU+6zIz/UWCZfovXgCDn4J
         aybCX3QxLDY4X/7SuzOZiYNjkyM/n9LYq2Q3TEC7dJPbHEtvw6RbXsEgkT2nJ3ZG5h+z
         3ftT5khErH/YP9/g/ZUgK+a1bzUYQC9qdu8HUyW+k2/ggukxBOZwx3gYvapXmFaSybOT
         uQPeeePbQwnmJ4+JNeLsJLav22lJ4jAXhWhYpY4Tz4tvNtxWZpUEPzQ1biNsywE9Bwnc
         Ii4A==
X-Gm-Message-State: AOJu0YwJ4wh9UE6IgW+HMliTOmnuZHkYbhkH2Y7/VT5uH1WULGacOa2S
        3FMAtypGTxGhgY2/hlt6ID8AjCGyCMq0/r8eytJulF6N7Gb7
X-Google-Smtp-Source: AGHT+IHCaaicQHGkcJ9gewQxrg9Zx+K/8/06nvLqQ1tRUvyVjVoCAee8lRno5uUJ9zOPWaIEeG0tubhqY/SSq9LRkA2GZEvuUaK9
MIME-Version: 1.0
X-Received: by 2002:a05:6808:189f:b0:3b8:9b14:756c with SMTP id
 bi31-20020a056808189f00b003b89b14756cmr699004oib.9.1701528964701; Sat, 02 Dec
 2023 06:56:04 -0800 (PST)
Date:   Sat, 02 Dec 2023 06:56:04 -0800
In-Reply-To: <0642446f-ebd9-429a-a293-94840c765038@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008424e2060b881511@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         7453d7a6 nfp: ethtool: expose transmit SO_TIMESTAMPING..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1632f254e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94286555cac4ea49
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d5552ce80000

Note: testing is done by a robot and is best-effort only.
