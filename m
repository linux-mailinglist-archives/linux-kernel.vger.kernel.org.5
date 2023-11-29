Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071637FD62A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjK2MCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjK2MB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:01:59 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA810C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:02:06 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfd21aece6so41446535ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701259326; x=1701864126;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd/wlFqvZeIm71/Y67R79RHz9aukw7cSkjccyzPZPNo=;
        b=tcO2IFU/P8xkfeMCLFZgkcCmqNxetcL8L5hPWP8C/N4eoLA9jENulnWvOiH4skSsq7
         12b1pEgxIjMJ3IcNwpc8wHw51eU3CWjoAO7+f6ChbaS9kkfbHBqLu1enP9IY16Y8vC1g
         9++FTOf1eUJl3ekbCXmp2mrzSnV+cSHulNsnpuP72aDYwqpGrem46hjvjWFv6V9g2Lhn
         yBCVfeyJm66+KT8aaZYhBPsB1aw86RaTzrtPrUg0hbgl3LMuiwt+BL3je+SJjAsPsaPH
         StPuDg1o1BWXR+ttfXsGEUlkaU9dr/xCURWudpm7kcZ297N+rErY7DNchEYjhlCWots8
         SHeQ==
X-Gm-Message-State: AOJu0Yzk0hOpG1ENxZnuYw5bH1+SKuvI1CSEhPc3a7OmBT/OWiVX08Ky
        dnkXf20x7nTRPZ3ePSTORG87VDeHdAa4AuTzlKPfgQnQ7n91
X-Google-Smtp-Source: AGHT+IEU1Nc9WQVAlaKHpjhbRTx2TzMSuG16as/IRB6kcV2w+FfG5Y2NkqNvNuLp72U85sO/pSU6lGfT6fIImUBEu6RPIMgy2sT3
MIME-Version: 1.0
X-Received: by 2002:a17:902:7003:b0:1cf:f888:4da0 with SMTP id
 y3-20020a170902700300b001cff8884da0mr1050614plk.5.1701259326070; Wed, 29 Nov
 2023 04:02:06 -0800 (PST)
Date:   Wed, 29 Nov 2023 04:02:05 -0800
In-Reply-To: <tencent_851BBE2546BAA8BB4C33AA9E661BD54B2808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd28f0060b494d57@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (2)
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com

Tested on:

commit:         6e2332e0 Merge tag 'cgroup-for-6.5' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1109b70ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=102b18358d5797d8
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c686dce80000

Note: testing is done by a robot and is best-effort only.
