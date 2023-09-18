Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61F7A4795
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjIRKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbjIRKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:51:01 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606A18C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:50:26 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1d52b009f07so6849898fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034225; x=1695639025;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWbHqbPj0ZGe69thsLWQoc1OgQzLV4Z1cbQpEB4xnZ0=;
        b=APsbB5Kj+vp8LitEki1tya/DrxxKzYjfd9k8RZTZyZZqCu6JR7BskUtKzz4+GAp3dI
         N87gPuX0326s+S2ZJWK3fQhE1HSkc3EVCC6nK8Bo9CeAogaYZ6fw26gthe5MrRS9lSdL
         oCMeHmeEAK900a+saK0lO5/QQSP0KkPcyn1a8Z5DlmcQVFUbUgMyMb6IyM2EJ5PCkoOP
         NRrQqfrUVU+AA+MxjI43gsSMUnKhY1nA+7jvDzTlX4fCjxTXTPQN+iN47oSVWaLq9Gr1
         rSi/oHK6drH2yjGY3l7FlIdVGJsypTjhEZLN4e+G/hhZxbFq2RX19F0O7m0Ays6Y6OM8
         JErw==
X-Gm-Message-State: AOJu0Yz9vH4WRIbvekH/Zz9wnL2tjK6S6Fwv6MQw0LwE9ZwyuH4uSfqn
        ZXMeL03pFCxqa3/FhjMzbzl7U/qQwFH+AQ3At/QILkB2IuEs
X-Google-Smtp-Source: AGHT+IESpDsEOqV0iQQTS4UDq9Kdy9qvwkJ98bVJSn8YUlMxcfzdjNejwzXBAfDtFWVGegbbq9twKfz+r++Qxw4EFO2K+FUmrlcz
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1b16:b0:1d6:bdb2:c7e1 with SMTP id
 hl22-20020a0568701b1600b001d6bdb2c7e1mr1990478oab.11.1695034225512; Mon, 18
 Sep 2023 03:50:25 -0700 (PDT)
Date:   Mon, 18 Sep 2023 03:50:25 -0700
In-Reply-To: <20230918-adrenalin-extra-64562065d07b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4d77106059fe890@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in setattr_copy
From:   syzbot <syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com>
To:     brauner@kernel.org
Cc:     adilger.kernel@dilger.ca, brauner@kernel.org, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
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

> On Fri, Sep 15, 2023 at 11:51:54PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    3c13c772fc23 Add linux-next specific files for 20230912
>> git tree:       linux-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15b02b0c680000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7149cbda1664bc5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=450a6d7e0a2db0d8326a
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b32b4680000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cf6028680000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/eb6fbc71f83a/disk-3c13c772.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2d671ade67d9/vmlinux-3c13c772.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/b2b7190a3a61/bzImage-3c13c772.xz
>> 
>> The issue was bisected to:
>> 
>> commit d6f106662147d78e9a439608e8deac7d046ca0fa
>> Author: Jeff Layton <jlayton@kernel.org>
>> Date:   Wed Aug 30 18:28:43 2023 +0000
>> 
>>     fs: have setattr_copy handle multigrain timestamps appropriately
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1419f8d8680000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1619f8d8680000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1219f8d8680000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com
>> Fixes: d6f106662147 ("fs: have setattr_copy handle multigrain timestamps appropriately")
>
> #syz unset subsystems: ext4
> #syz set subsystems: overlayfs

Command #1:
The following labels did not exist: subsystems:, ext4

