Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBCA7EFF7F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjKRMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:23:09 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90BD5D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:23:06 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b99999614bso3028075a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700310186; x=1700914986;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5OrRiyzhWh/CfLTQjVQQd+EQW4J2b3mAWeWVv902Bw=;
        b=sIKH/K/6bRYgK4a42mUz8xuW2lFyRXWQsGjdUzrP+JgDFlVH7Ohu0eVEeVJCf/uwke
         u3sgtqp8CdLqrlMJwycCGfDiaD8+Txt4uNxmcQ9i15CGAqCsPU8zN4bGY3M7SeWmYA++
         w12kh+/1YrIFmO+1oH3ndbAxCY6N0nySN6/e9QiWjlfw4T82aDd8MjdAnnxbkuKeRXSV
         4WW5nyo/h7gcJYlP3ke1dvaRtvI/iKkWSmnLeX3EII35teMMVwcJG9ew0sZVHFT/dMmh
         Y4g50dh/06TZWQKabvTqM11f8izDgGZO/sTeZucHPaIsZDYDleTsPMXGknaEC+l0+VKR
         Eh2g==
X-Gm-Message-State: AOJu0YwYYiDW01Hi8f0WAP06lqaPHNAnuoR3MRH289wMuC2KyKN9K86I
        pSyC/uc5W8sJku+Tl1MRcV/MJwNmcP6MR+kNLxggwIO6gWqd
X-Google-Smtp-Source: AGHT+IGTgnKijKCtd45DA/LMoFfvl7w3JNYbLt3lCfm9qNKd9Hf35E3dK9yRdYPAqa9S/p7DZzWvDvbhfWZqwVFQ7AMzYgwvj7A7
MIME-Version: 1.0
X-Received: by 2002:a63:1709:0:b0:5be:3925:b5b2 with SMTP id
 x9-20020a631709000000b005be3925b5b2mr427646pgl.5.1700310185840; Sat, 18 Nov
 2023 04:23:05 -0800 (PST)
Date:   Sat, 18 Nov 2023 04:23:05 -0800
In-Reply-To: <tencent_E563A5A44C176E777386C7D365A365497C05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a29a75060a6c5096@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com

Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f6c268e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16363458e80000

Note: testing is done by a robot and is best-effort only.
