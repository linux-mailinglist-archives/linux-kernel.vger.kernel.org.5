Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE67F55C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjKWBRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKWBRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:17:00 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE7110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:17:06 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be10675134so418066a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700702226; x=1701307026;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5oBx7EjQL2+FbBjMi5y16gf4kuvyAnZ3JgFtexzBUA=;
        b=kBCOZ3aD54Ou3C9xD4NpDi/Cs0v4bVdFFIIcIMhLIDbM6qGlXvUG0llOlsWZ844TmW
         RdlxVKIC++D7joVGS3cSOwofBz1lmDQktbUXOGenU83T2U2uYHr46k+TwwCzFfqwX0DQ
         3PWloLbSQlc9+nkZQG27sC4Ft2b3PQ2xmknoA97TZf/uOmgPFhpf4HOINsVXtMiPOM7s
         dLtiJfI1rn1S4+tdjSp3EsdMfGATgByxk2KSNWinEQ9jXSsvht2PI1WjfD5L5cxZvh7z
         ZKgqNs8dwlEN9Pgr2MuQQnJY34qOV4ey2bfWCMn1kH1lFwQTSUfvnT7Ifmedm53eY1TF
         gS1A==
X-Gm-Message-State: AOJu0Yzj6Lb3yuWIXs2pIuk/+8B9Ed6euPD2XirC2D8AEiXSeHmYg7RQ
        J9qMVcOqpHa2wz02kwKW1DbpX514dZ5ixBFYXe1N6BWBgL+l
X-Google-Smtp-Source: AGHT+IGXO5tqvvyFWeJuKfwoIvQQp80K0szbB+GMH4jb8p0owJcdFApPgUPNAO08rqecCguHLqOIIprIGXF+tKVG4F2v1Pote9Tj
MIME-Version: 1.0
X-Received: by 2002:a17:90a:bf10:b0:280:cd15:9692 with SMTP id
 c16-20020a17090abf1000b00280cd159692mr916159pjs.6.1700702226078; Wed, 22 Nov
 2023 17:17:06 -0800 (PST)
Date:   Wed, 22 Nov 2023 17:17:05 -0800
In-Reply-To: <20231123004834.58534-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000de140060ac798cb@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From:   syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        martineau@kernel.org, matthieu.baerts@tessares.net,
        matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com

Tested on:

commit:         c2d5304e Merge tag 'platform-drivers-x86-v6.7-2' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f3d6c8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=b834a6b2decad004cfa1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139ddc4f680000

Note: testing is done by a robot and is best-effort only.
