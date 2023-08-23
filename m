Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BED785917
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjHWNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjHWNXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:23:15 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EFAE7E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:22:45 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26f3bf964feso4129048a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796891; x=1693401691;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkD+ET12GvFFq92I3vBMEeqpb/MjJII6UkACFiaNiGk=;
        b=M+y0evJMZjGiNa/9kiL/SBLp+17TXas54kwAVq+PzP5g1D/j0iGKEfJuX9cOlB68Tv
         s7PzQjBB/za1ckjTKFByqGIuBdWjp1VNGl43r6AAvF/6zd9OEnwAB5TV1sYJ1N7YRNIp
         Niy00A47oWV62c1yCX5h53AACBzR+CnrfoHcOWaqgkZ1OnItNpfFqG8CtLLO/7zX81w+
         XQYzs1KmIBpYSPlTWLc64rhWUbQKRLGGqrQ0zv2QN0gbgH4LV3T+syRvRdhuEiEsPFya
         WhB3DpOHJAMwJp2nUFkWB0KLrpsWg0mlncckma16kxUX9YRlVlbpn9hSCvkiZETGZRHq
         eBqg==
X-Gm-Message-State: AOJu0YxEhYx/79m1A4KNaRD+liDLCyKtJFxNc+iu4Qp+OleEEE/FDrod
        gEBcp4zw1ZLK5Mjfn6Wkgvndo28ihNhQCXTdhXwRNN5bw7OS
X-Google-Smtp-Source: AGHT+IGBFQL4/YKfLA3ElUTS+VySEuP29IPeOxhdUY2Mm/BE4S5kN0W9gwiTrJViGYASzkYbMjKpWimrPOEBmaX688p8FlIJHuM6
MIME-Version: 1.0
X-Received: by 2002:a17:90a:ca16:b0:262:f6f4:7173 with SMTP id
 x22-20020a17090aca1600b00262f6f47173mr3243007pjt.5.1692796891540; Wed, 23 Aug
 2023 06:21:31 -0700 (PDT)
Date:   Wed, 23 Aug 2023 06:21:31 -0700
In-Reply-To: <20230823124507.2837-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065b3f2060396fded@google.com>
Subject: Re: [syzbot] [batman?] WARNING in call_netdevice_notifiers_info
From:   syzbot <syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com

Tested on:

commit:         d44036ca net: dsa: felix: fix oversize frame dropping ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e4c10fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=f8812454d9b3ac00d282
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145e0d90680000

Note: testing is done by a robot and is best-effort only.
