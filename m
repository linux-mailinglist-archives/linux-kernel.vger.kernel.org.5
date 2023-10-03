Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980A67B5F02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjJCCTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjJCCTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:19:37 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5EBB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:19:34 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af83e7478bso659400b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 19:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696299574; x=1696904374;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSCwa9O7C69qs9jC/KCMMATl1O+va+8ssXqOeOaOqj4=;
        b=GW7/d93fuokMAD+xYFWlpNASs8spIBWGBeH+DraVjzvV5Y2xCyyM6Vq+unILuzq8FB
         UuifKhYx+fe09EWkaLC922kPnzfJ5S45aFcOSLIqvtjGWWfPdGDhqidU6If3Q1D4adxr
         07MTM8hyJoa4nvIi1u1X81q2flUm+0BIiA4N2zscDNBKwQeKvmE0kRiJHVMphQNZ4tt+
         K9VnE15rXgmAPSp7U+yN4xED75LX73bH8rkTyaIShoGFUCZ2nJfxMhODWo2Fg3sxn993
         MKd0GBY8thpDrPiT9pkHLqdbLXHkcpSiOm8OD3iXN8qhqL8wnmntzpmOG1yb6qiieyMc
         /Oww==
X-Gm-Message-State: AOJu0YxH6BqR/kHLRBC7qMcQtiCVWYnvQPf7pMB8ifSQTL7TM7NDxA+h
        dyBsYkBwP5OdksOhdF0QzL9kZ9VnLggnsxT6fCdUZEhv716x
X-Google-Smtp-Source: AGHT+IGMcq0BbRra36NFLQk1oDnyK2gOJGsA4+4sjqfOoS0M9JJfbemrY9QQ3GdF9LeIiRZ6SvhkZBGVPW3U48fwAfkGB2erCNJS
MIME-Version: 1.0
X-Received: by 2002:a05:6808:201c:b0:3ab:858e:2d6e with SMTP id
 q28-20020a056808201c00b003ab858e2d6emr6053572oiw.11.1696299573807; Mon, 02
 Oct 2023 19:19:33 -0700 (PDT)
Date:   Mon, 02 Oct 2023 19:19:33 -0700
In-Reply-To: <039d664c-b25e-4d68-80da-ba460ea7f269@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000878f0a0606c68568@google.com>
Subject: Re: [syzbot] [io-uring?] general protection fault in io_get_cqe_overflow
From:   syzbot <syzbot+efc45d4e7ba6ab4ef1eb@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+efc45d4e7ba6ab4ef1eb@syzkaller.appspotmail.com

Tested on:

commit:         163521f0 io_uring: ensure io_lockdep_assert_cq_locked(..
git tree:       git://git.kernel.dk/linux.git io_uring-6.6
console output: https://syzkaller.appspot.com/x/log.txt?x=1674879e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=efc45d4e7ba6ab4ef1eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
