Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C480BC64
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjLJRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjLJRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:31:01 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624DFE1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:31:07 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb0a385ab8so8053023fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702229466; x=1702834266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48caGdxEgGoMogiZb+MQIv4KaPHTLZZi09kYsBIRD2s=;
        b=G33sX48OkFnecdl/HL7Z3Fr9LzggjvxD0b9Lv3uN68lonYOS84NVhaWXZKjERFgVQm
         SqXx8Ts5MvWnBsnF40+jAPVw2RglujpGZ2ojCb3b4UeDz29ACkgqfFB84aMy8ux43jtB
         Q8ZVEfTt60Clz/WHgojhTrQ6cF12jvrV89iRPzEwmIFXJMlZ+9kIkAZeUNVjjXtMxz3n
         ZLsdmwJo5FhU1tDx2QnzTdb4P9eImcPb6a8bjw0OnCdswIv8M69atnTu2Sw1fZmuKpj7
         IRj9vGZhzYrVGO9wV0y9w1C+CZ6GNx0dtJWANDSbutoij5FW4VLNKmQFq3AXE4vZmyRc
         5KLw==
X-Gm-Message-State: AOJu0YzGn4V7Y7W2YoNUlZabWMGqUUiVmNo0xRrOn5YKyVLxpRGSZBJ0
        Bpzl6Mh3DERbM6zbHkttSQR304EC1dzMF/xbDw+u8bfBDBpL
X-Google-Smtp-Source: AGHT+IFzTYha5Fy7rkEwGm2gSLPN3+3yoF0+BLJOPHJJftO639+rO7O+NY4c6tbHIqbrQB+ry6rRb61J9KzKdM6RMhM+TOk3AvY1
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5b16:b0:1fb:1a88:a05b with SMTP id
 op22-20020a0568715b1600b001fb1a88a05bmr3340614oac.8.1702229466736; Sun, 10
 Dec 2023 09:31:06 -0800 (PST)
Date:   Sun, 10 Dec 2023 09:31:06 -0800
In-Reply-To: <CAEf4BzbRzb0B-Wy-fZ05bUHn5UXXoiL5yO2yP_CKyciCFf9yWA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ef46060c2b2e04@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
From:   syzbot <syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com>
To:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com

Tested on:

commit:         482d548d bpf: handle fake register spill to stack with..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16064fcae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=4d6330e14407721955eb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
