Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D977E886F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKKCqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjKKCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:46:07 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3A3C30
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:46:04 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b79f5923b2so2737548a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670764; x=1700275564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLuKyTgHwmdkzm3uU33dVhpcgOL5MuZHDheV4D3usNg=;
        b=ajwGrp0NdggsKNgOcv4Xe09QDXsmQBN8bypkUG5xsfoYF+4oiTW3X2EPcn+LcaOS76
         H/Kftg/bWEp16kx58xu0xHDCNiFwjIpY0xIJ7Ss+z4FIVolQMRSs3VfUJLmeGhml0ler
         3FWfzHQrQLCDoykMj4f0N2zjho45aOv4TzMZDbTD9qcr2uXWrTRSeh83S9Q3Uffk+g+u
         PSlhmlspUmKhA1jkk7Dyf1QSXsqm9VbN5CJdHquDDZrmWe5DqSit2TYEtgK9Y6k+e2JA
         Z02A9qqdimvuZole+QnsmkxiWv9xpvSX1iLTy6yGWjcGrfgTz4jhBZD9lx7CVVdSqEZT
         hOIA==
X-Gm-Message-State: AOJu0Yx8LPPlkybwNKjRPC+MglT4QzdIn1C1lAgQ80XKWF86xbw29Ar1
        FYzrG1wrSLvTsh/+nN1F4OA/biqsn9N20HLsLWfPNI/rqWH/
X-Google-Smtp-Source: AGHT+IGxYcMvQs/617V9NJaeHrYbU2i20Egsc3Zl7HLmz+ZjEEUz/Lf8WG1Jk8wqlWMdk5ygeH9vlt/oSaGhol+I5FUwTjyu3YtT
MIME-Version: 1.0
X-Received: by 2002:a65:66cc:0:b0:5bd:d7fa:bda5 with SMTP id
 c12-20020a6566cc000000b005bdd7fabda5mr264549pgw.3.1699670764041; Fri, 10 Nov
 2023 18:46:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 18:46:03 -0800
In-Reply-To: <tencent_7F898D8FA5B10DA81205DDF3DDBA1929CF07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000203efd0609d770dd@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a8c3c0e80000

