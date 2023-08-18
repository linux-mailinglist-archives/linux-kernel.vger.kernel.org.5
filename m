Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BC780D54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377586AbjHROA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377633AbjHROAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:00:43 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B07C4481
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:00:06 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bdba3f0e73so11952225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367175; x=1692971975;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puOR3Md3+bJFpGkHRLOph4XPxHMWnWSLQNus15kLbnM=;
        b=bD2UmegQPcoQyIoWVIG3PU3mdM885PRWBTVMr+XMsa+Mkz87SjY4yMfSjw+2s75EUK
         /0H6AFzfXaiKSJNZRX2kTmOZVsl4u2V0w6z1w3oI4cEyNJkyM+94XjuKjaOEmdqDfjxT
         +1H7kZ1nC7cgYy9qdECoV6LodeMjVHn9VWuxUMMgTjstFVcwUxhQVSjM5Cy/yd9m4NaQ
         OJC5+27A+XaXXT0/0QigrPgTuLn/60UtzkPu7XpO6Q7UOWQtvNaytqagwGx7zylrKNcK
         YTDhD2Up9qJZa8/lWihOxXknEeVtbt0xTKEZmxblImtaDD27/p04mu+NbYQJWGpB8Ue3
         +weQ==
X-Gm-Message-State: AOJu0Yysjq8bDFToaT2zxIUsNYngA1EKwMMkMVVCGslmv6Yen8k2rDWm
        5cYinVgjei9OYdd4e0kjTENTKv4N2eG9qqUQ6IM7/uI/GWIm
X-Google-Smtp-Source: AGHT+IHrM6kkL3CMMAeBCByHgpLlH40+lnOSXumfx5zhDpkB8EhWocTIpnDIp44RdSe8nQg5HijjPUxvMq1BwtqLsaEb5iyodPZ9
MIME-Version: 1.0
X-Received: by 2002:a17:902:dac2:b0:1b8:a92f:2618 with SMTP id
 q2-20020a170902dac200b001b8a92f2618mr854208plx.10.1692367175195; Fri, 18 Aug
 2023 06:59:35 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:59:35 -0700
In-Reply-To: <20230818112605.2075-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ea5da060332f0fc@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: rcu detected stall in
 wg_ratelimiter_gc_entries (2)
From:   syzbot <syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com

Tested on:

commit:         ace0ab3a Revert "vlan: Fix VLAN 0 memory leak"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1742e46ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=c1cc0083f159b67cb192
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113c5e6ba80000

Note: testing is done by a robot and is best-effort only.
