Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6E78B06A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjH1MdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjH1Mcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:32:41 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED71A5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:32:27 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c0888c175fso27188805ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225947; x=1693830747;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLyH7W0K8kNxWpLkDiNNKkO/58lfmnVRI6ErzvKz/I0=;
        b=ZfEvXqCl1nW++ZBewMaYs5hm/BXJexQnyCJNXgZ1CqPE2DMMO1JCvqvwYGrkCLKR/h
         pMqD2rx45j3izsM8GT3WtDaIR/c3RantxM6AuApwXB9Cbn6emO3JNS34a7Y5sGfdi8Mw
         hSLK58K+YmEYl3S28ybdiwHScL/AaJ3rXnc/U4splxj+bOsHblN1cU4GtBCCmGY0J0aF
         nshNY5yGi5wegp1Si14Nto3sdEUJ3KE2AGGh7zYGM2weV57YB7mfxSg1MGdur+ZNLbIX
         2yr1rJ+TkXYRoWGDaWhn2EDXF/j+LVvmYOHKiLDwIh5+vYP41OVXc2HpMJDjPcpCJ39f
         7X6Q==
X-Gm-Message-State: AOJu0YxYg1Gu5WEvHLDnkboPAOsj7HL18ePy6pMcxLVktBO3LdEB4T/S
        zkV+qpeJPsno+8iYmGCvWbLZ5f6vPspSLQ2nLCi2WFfSm/5G
X-Google-Smtp-Source: AGHT+IF6hEQpSpGla+YzdQqTVOejJ106fA+NokgxXyr+IMU0DR2lba1Orh4ayoS/SjrtxxNV4B/1ZyqftXo+MyRlrSp8JLyqBSnI
MIME-Version: 1.0
X-Received: by 2002:a17:902:e801:b0:1bc:5182:1da2 with SMTP id
 u1-20020a170902e80100b001bc51821da2mr8892078plg.11.1693225947359; Mon, 28 Aug
 2023 05:32:27 -0700 (PDT)
Date:   Mon, 28 Aug 2023 05:32:27 -0700
In-Reply-To: <20230828115734.3980-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001defee0603fae34a@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super
From:   syzbot <syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com

Tested on:

commit:         2ee82481 Add linux-next specific files for 20230828
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15d40cdba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=5b64180f8d9e39d3f061
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11718c2fa80000

Note: testing is done by a robot and is best-effort only.
