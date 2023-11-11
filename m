Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE37E88BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbjKKDCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjKKDCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:02:10 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C74204
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:02:05 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6b6f4c118a9so2612722b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699671725; x=1700276525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9jmJ7vtILvW5Bu4JsBMcm4CthTppMk6zGeMu/ZDO0s=;
        b=gLIbnyu9TXVRw+Oo0PMCqwIKKavNxvZSek8RaTEtGJHJq6rzM4vq/D9HrnPL7xnuKh
         qHfcpiz3ExIDA0+VSvLW61WWfEcsplgn/BRsFmtZ8pcbBRyugvW0vo3cdaR2JyNTMngm
         t3P0SN9FGp9x2cDjoO4LxV378nfYe7bEUWyy3NFo1W9hoYKlgm9kstA4Lu6Vni332A6T
         YYUn9oE4VktEWScDKkCP9LzV+05vBuCOS8J80TSpG6RPQ0gahgRrrC1MT+nCAQfuuFkI
         7v4ThQJ88p+kLzMMOoDxV9/n8Y4z6QtsCYv4sVOkXUxKXVC5yONaInk/jWicpdcPELPS
         6hmA==
X-Gm-Message-State: AOJu0YwsFKARo2SNSJh+IXDUv3pxmlou1ZTOdV5fgWduHTSFykfvy5+G
        y4sQa/Wt6BDcNz3/3v1Sgk0LmIAa8TrZEgc9mC8MKM+K0Exi
X-Google-Smtp-Source: AGHT+IHz6gCjQEgVol8OZonb4ZBbxzpBelGeiz//Vk4U60W3RTW4YNJNYzMwSQG62xH84vLXSmH5kFbyqVdSXDRm1YTXkL/+BpqO
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:4519:b0:6bc:8df2:a536 with SMTP id
 cw25-20020a056a00451900b006bc8df2a536mr245432pfb.1.1699671725404; Fri, 10 Nov
 2023 19:02:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 19:02:05 -0800
In-Reply-To: <tencent_A2614970C3AB4447D761576DC6D73362A305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d7a5f0609d7a92a@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/qgroup.h:432: multiple definition of `exist_qgroup_rb'; fs/btrfs/super.o:fs/btrfs/qgroup.h:432: first defined here


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cc7338e80000

