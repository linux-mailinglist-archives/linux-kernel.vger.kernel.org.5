Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDCB7904AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 03:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351483AbjIBBlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 21:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIBBla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 21:41:30 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F51702
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 18:41:28 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c0cfc2b995so33880805ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 18:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693618887; x=1694223687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o26MWTEXA2uTxy7vbMCgaXLErCQhk1dWJAGb/LcTFAE=;
        b=I5Lg1m/5nL7lpXOLvls7h1LGJ/FK5iwQ0BCNpJBAyiaRWV3BRC51t5qj4z98eIseuK
         AnB9eiAHDNaX7SrTmVRmi9wQOJkOU5IEvRII4hpbSTRJujETuwG7EuUgzAMjz1hZTWNX
         W3G/dTMF6dYG2VVeq0/RjhUgIASXeGVS3ofQkXf0YatEF/VPntxGPSLg27jy1KnnkrLK
         7vEk7iHYjwgIj27LIS69uvQtfeqGEtQQ7oy8J5n1SjAfzwPp3p3GKVzxtJ+ET4D2IAS1
         TBvYohaNOexOil0D+SRJGiA8nEOHfoQHoN5/hCEaPquLySmSkkw05IXb3xzScD6H+MXI
         YPoQ==
X-Gm-Message-State: AOJu0YzNWVCSAS6xxO0OxWc3F4gQr4x2GJNdWRE+XVcI6kPm4Un5QzMu
        GR6In+VLgKbpG9vJ1wLESgje4nVDdfHgNcizuK/MfGq3adUO
X-Google-Smtp-Source: AGHT+IG+8ksClbOVR2wTU1+XunY4BcScp0MeBMaZh6Rm33ze4kn/lIenvG3+3vG+sRijFIQl5alxsxdxtreUqxLq6rAAJkSFdHjS
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4cb:b0:1bf:4e9d:8fc9 with SMTP id
 o11-20020a170902d4cb00b001bf4e9d8fc9mr1518243plg.11.1693618887616; Fri, 01
 Sep 2023 18:41:27 -0700 (PDT)
Date:   Fri, 01 Sep 2023 18:41:27 -0700
In-Reply-To: <20230902004227.4988-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e6fcd0604566075@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com

Tested on:

commit:         0468be89 Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11642f9fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b39898680000

Note: testing is done by a robot and is best-effort only.
