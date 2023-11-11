Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61B07E8806
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjKKBzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjKKBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:55:10 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3E44B8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:55:04 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc56cc8139so26383375ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699667704; x=1700272504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aspa2mhxF0fBfh3jAck0YtlYOuE9qBW9renyIeoOW/s=;
        b=CWzHK64jDS6PtE665IpBtR0k2ROKjEwdeS3Xpke8+Le8YWpLhpwXyyANPc5ewhgFBH
         S+unodCV/cGq/z+R14T+89+Ka/UqQR/lUAoBd0C8IYHGqmnKSOAp71SS1Rp/kV+/Kmvl
         hlGUo3hq8WmmDnhjB/aNJjWnEAhzQsw1lB84cQr15hnY8HTiy9zjAB83We8tGySy1lQM
         hAYkvQbwCzf4YIeLjYGKSQC9SuS7TUiY/HCDvGsQ7xgpQ0hL7p7cQkXFtw0de4I5Aqvn
         a1uOlaAiEUtfKmd8KxPauUFsNjY036mnERLWWAMc+bX+Cx8VnS3RoXSUj6aGQ8z+yIiP
         vwlA==
X-Gm-Message-State: AOJu0YzYLcWY0pNDHjatxQQaP4btKUaUeh1n5obfjOBqzemOz27o3Gx0
        sAY1Nq9IQKCULwUo0RIIMq+5q6Y5lpjqmxvZOa4u9TKBVQkU
X-Google-Smtp-Source: AGHT+IGn5KIS9w0IV0V78XntWfRTp7iBgXg5Sol1/ae9yu4iyzfMKoiU4nbBlJaoXU+O5Hp89rxxeSa3S9WxRU9v8Pc7x8FTzhZ1
MIME-Version: 1.0
X-Received: by 2002:a17:903:485:b0:1cc:6684:4ee0 with SMTP id
 jj5-20020a170903048500b001cc66844ee0mr201420plb.2.1699667703991; Fri, 10 Nov
 2023 17:55:03 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:55:03 -0800
In-Reply-To: <tencent_A840376B576326D193688362096DE3B44405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb95a30609d6b93f@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/disk-io.c:4934: undefined reference to `find_qgroup_rb'


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1263c55b680000

