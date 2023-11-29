Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC77FCD95
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjK2DnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjK2DnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:43:05 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D451710
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:43:11 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfc42c3786so40141835ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701229391; x=1701834191;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fvZnHWUdex50YsbQQGY0wLb3jvwy4VEmNJc65/xnSg=;
        b=hcMyKiDSXX2ZCtR8CfeH46njlEBIwBEj6luLqamxv37FpUxcB+yRBtXcCU52xIyqSE
         yhmlUTI9xSiZoEW/mtzvV4MzIDqMFu3jLDj+I2BpUqmfnaINY02B0XekoZGlK2q+YMVr
         pN3HWGRMVPYLH6qnU7NFDM5uSAxYdOTIm+KIQz/kaQsPNxqE/84vTdOeLmoIBI/I6+U0
         r3Y5hxh94tcoCQ3ty0fLa+9aeUdRD+0ir/9MNdBbQJCn55+b+OwpDYSKP17WSQyIFaRK
         YUw1Q0Amq6XxShgMSsz+/7IT5kgfLnR+a2Q7vHVc64FVpn4pGF5H1KDdJihlAe+UzYbN
         xgXA==
X-Gm-Message-State: AOJu0Yycn1R7x6ZHFkGFa7ovDiq5JX/4O7m6pc2hHoM45I3ygan+KEIh
        QX4Izn2GDhC1LcFF808lDnYNmD8NNlxJK9rnZ/rttYbSGJNH
X-Google-Smtp-Source: AGHT+IFJMWkEEjZQX/ogxL/LFGmJWEKuE4Fdh31HHvHtLnyCVatN1yIW23RI8szBMVAaYhHGMJkqx/j2hiVMZSpPD2in9E+MuWn4
MIME-Version: 1.0
X-Received: by 2002:a17:902:7582:b0:1cf:f876:5efa with SMTP id
 j2-20020a170902758200b001cff8765efamr959708pll.0.1701229391077; Tue, 28 Nov
 2023 19:43:11 -0800 (PST)
Date:   Tue, 28 Nov 2023 19:43:10 -0800
In-Reply-To: <tencent_99AEEDA6CECC79B26F902CE56F74966CE90A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089692f060b4255d3@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11250ac2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=102b18358d5797d8
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1751b70ce80000

Note: testing is done by a robot and is best-effort only.
