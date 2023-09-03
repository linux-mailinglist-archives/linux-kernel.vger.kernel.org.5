Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602FF790A54
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjICAHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 20:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjICAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 20:07:41 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F6CDB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 17:07:38 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26f51ce1a11so263725a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 17:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693699658; x=1694304458;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg6pqu++IxHzeRbjS3YG7DsJsM+IOEPhcargo+fZmXs=;
        b=mEM1OrASQNglCIIWJhQjT975kbArkaKIbqOJWwIr3k5sf7Bvdkapa95GPkAj6IzN6i
         SlUjdxMYUilvHxu1ywaZpnQSXhuGd12Vq5rV7bY8DntB2EHNDCrsFoB8JNxipOnh9a9F
         T7vl4P1JeaSI1hbzoQRMedzSvu8k1krAwhkmY6qzwDBEN3aK7pKrJhjpubaiXHM7asZd
         hUP/jFBV+w1btF4XlicC7tx/M+ghUUaxpb/GsTQ28FDGveyry5q5x55UyPhzBQkYG8vh
         lXD9soKf/RDzlV8WHKEdKryrSDvX2kxeuBzH9kWEPB/R8lRcouGxiemxOy73Lxkf5iZb
         V3tQ==
X-Gm-Message-State: AOJu0YyZ61knBahylU6JpLOb8kE2VL/RMgLW8+8LbKeHV1753k0IoYwg
        TEvzolPLg6sFc09prImEBDL+ISGwsTB4MLZ7kF4exycrTXL9
X-Google-Smtp-Source: AGHT+IG5G/gy7FPq8z2yQ3mxRB49IuyO6/EAl5gAkXTkeB2b2rnQ1Q5GoLgo+el6LPTkV9OUFgyTk+sYi6q/PAqQGTKuxpqh4VN3
MIME-Version: 1.0
X-Received: by 2002:a17:90a:fd92:b0:262:f6f4:7173 with SMTP id
 cx18-20020a17090afd9200b00262f6f47173mr1569195pjb.5.1693699658062; Sat, 02
 Sep 2023 17:07:38 -0700 (PDT)
Date:   Sat, 02 Sep 2023 17:07:37 -0700
In-Reply-To: <20230902234444.5249-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079a09a0604692e94@google.com>
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_test_super
From:   syzbot <syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com

Tested on:

commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1049eb67a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4940ad7c14cda5c7
dashboard link: https://syzkaller.appspot.com/bug?extid=629c4f1a4cefe03f8985
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e85198680000

Note: testing is done by a robot and is best-effort only.
