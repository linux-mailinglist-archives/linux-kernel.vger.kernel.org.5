Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8537DFBD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376597AbjKBVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:01:12 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065A18B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:01:06 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58404a66c5aso1725756eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 14:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958866; x=1699563666;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3akbAaeDQhmo7EY8P/uFG9UYuqoe/RK3dvyN4ijPUU=;
        b=J/HoAmqXDN128wC+iDFROYspd3J3zTbAc3nXqVbn/VWMSuRuxT7rc24ytPphlz92rc
         8G3Y/7q5JQH/wNJWFL/FXNNEMcGxmy2K9zuL4cQ7f+WuLssmJU3jZ4yZRuK3Hej8PE0R
         NT9PZLYUPVhlYkr743WzEgHi4ev5+HOdph0HFj1gBPX4b73Z9at+ORR1VnMkbdUS0Non
         3+KzI1iyAmYx7pXl/i2M7iN5qQUieJuAxh+PtHhBu71eRNZ8iQdVsg6L7sojNWUSWZ2N
         hT8J8+2L+cEm1pfKKeCVkHeCfpXeWM8JEi7tSt5C4NWNQxXBA+2oxi/puXV9v8RuNVu6
         Mt+Q==
X-Gm-Message-State: AOJu0Yz9zqX09SviC6HbK7GuwijTSIvtUsK5PR8K0fzGvgv7PnIfN6MH
        vpKhdYWl9FO8GxZqQ8voDPXX+2xhm5wte5Iy75JuZZynwwt0
X-Google-Smtp-Source: AGHT+IHS5ITKeDshp15022Q5NsKeNNfSxiawlC8Fsi8sClQf1CsYNeuZg0HbDwVmY2qtOT8CIIzvD/RYzhnmMohssjtEud3kQaTu
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c49:b0:56c:86f2:ae14 with SMTP id
 cm9-20020a0568201c4900b0056c86f2ae14mr6354236oob.0.1698958866251; Thu, 02 Nov
 2023 14:01:06 -0700 (PDT)
Date:   Thu, 02 Nov 2023 14:01:06 -0700
In-Reply-To: <b0a20256-be00-48cf-8ec3-981c3085a80d@app.fastmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b60651060931af78@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_brec_find
From:   syzbot <syzbot+5ce571007a695806e949@syzkaller.appspotmail.com>
To:     glider@google.com, jeremy@jcline.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5ce571007a695806e949@syzkaller.appspotmail.com

Tested on:

commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15b7babb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce19195e0af08b14
dashboard link: https://syzkaller.appspot.com/bug?extid=5ce571007a695806e949
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11428c7f680000

Note: testing is done by a robot and is best-effort only.
