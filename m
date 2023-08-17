Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3AE77F65F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbjHQMYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbjHQMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:23:28 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD87EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:23:27 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-56582095936so6509057a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692275006; x=1692879806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGbZ42KJuszN6+znGtziq7vAvk2s8k1Zzls97iGx8I0=;
        b=OaxHEQFs7n42GlCYTtVC7RtNqGZhL+5KH2fGCqcChVZTXwrBIAtelK4nVhhNbmL+Nm
         ufkAzM6V/C2afOvGr9CNJOPK7xsA4uxbU6uvuZ1saI1xLJNSFPamZ/PvUNP7M1lzvFm0
         /7Q2DxBBD1ChYYoxcecbaqev5okQZ4Z1GWsyVr/DNwMTrnpAMe8u/C44lkV4561whNZG
         884pp6FXXkx0qUPR6VP51/qGc4iTnVCxCZIKvbnGfjpsEt/6LbxUTi8tslqFxcz3o0X2
         y7DRQ4goeAA9QcsRJXIRFXyxjvorWicJS0QTo+ppcHWuB5Wsgr20g21xbGr6xl8KJP2D
         noKg==
X-Gm-Message-State: AOJu0YwixV6Thhncj/VsHc0+8+wTO4N7TNi9El6IXcLIoyR0NhubLSOf
        pxdknIRGfLMDZ05Qnlk1bEcyNYqSPLB++YR9SZDg7PcctPNl
X-Google-Smtp-Source: AGHT+IFhqhW4XAw0K3gwjljAQX1/IWftQHMYLN3nJfIbYLyIFLX+/OyBHM9AV+ub1bvx1+9BIkREVz1Z+ZIF1n6/ZcEVQkfVeAgk
MIME-Version: 1.0
X-Received: by 2002:a63:77cc:0:b0:564:1f95:71e5 with SMTP id
 s195-20020a6377cc000000b005641f9571e5mr1007806pgc.2.1692275006736; Thu, 17
 Aug 2023 05:23:26 -0700 (PDT)
Date:   Thu, 17 Aug 2023 05:23:26 -0700
In-Reply-To: <20230817104922.1822-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3901d06031d7aaa@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in
 sys_clock_nanosleep (5)
From:   syzbot <syzbot+43cc00d616820666f675@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+43cc00d616820666f675@syzkaller.appspotmail.com

Tested on:

commit:         c1a515d3 Merge tag 'perf-tools-fixes-for-v6.5-2-2023-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=155e7d6ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=43cc00d616820666f675
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124a1b6fa80000

Note: testing is done by a robot and is best-effort only.
