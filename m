Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E97EA8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjKNCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNCsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:48:09 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF1D4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:48:06 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5bdd8eee498so4622063a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930086; x=1700534886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxCHsDZObCWOlGt0YQ02f0F/UHs0eYbRAb0cYz5QBw4=;
        b=Dk2srvpwdAjbQHE9qFZc0Tnf9WxezsDaA2f3gNWodZl8Ey3Vq1pXhC+0Tp5Baq2NWZ
         /NzRgkfb8av3SsjYnbl77bhdMXfJXa+AxTAJ2EPS6n0BqyXMJZ4dTbcJuHIFPI9dqkmY
         ZWrHSrgdufe/5VWJBa1vmUcs+h+1DUpNA9jVkh0PC1LxH5l+0kC5+rOdq6xWCJm/6xqp
         +t9zgKHLT/I4WuxAjq7Junyq71mSSPMBDK1W5zXmgAGyCJMj+Oc1FAobiDI65x0aPqb6
         TFoAF9wVgkyUz3YXqUdmSK1he6St8EcEIW5TIJawc+rC1gf5V7muIqEJxaam2v+MRsHY
         k7mQ==
X-Gm-Message-State: AOJu0YxZGd1d/jmwGu3EfxAjfMTULTa7REXC9qOtvO74X6AQcCCQ95xH
        0cFF9jDkZsk4uMWp21IkY4SxKH9SmvrN1HMptLl6yRPbbWTG
X-Google-Smtp-Source: AGHT+IGwJZhP0FtVl7QsDf+QuFT8JU1HF2UUYPnAhKRn5rh9TBMapmd0QUBMk+9sTy+HVfpY70zSi2/UO1jB7fcOiNS6HwzMDjEW
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:492:b0:5bd:d60d:f60e with SMTP id
 bw18-20020a056a02049200b005bdd60df60emr256532pgb.8.1699930086465; Mon, 13 Nov
 2023 18:48:06 -0800 (PST)
Date:   Mon, 13 Nov 2023 18:48:06 -0800
In-Reply-To: <tencent_D54C2575BA89BB6D33159ECD1B3C4B401B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f268b8060a13d0ae@google.com>
Subject: Re: [syzbot] [autofs?] general protection fault in autofs_fill_super
From:   syzbot <syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com

Tested on:

commit:         4bbdb725 Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17a6c75b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=662f87a8ef490f45fa64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bb3be0e80000

Note: testing is done by a robot and is best-effort only.
