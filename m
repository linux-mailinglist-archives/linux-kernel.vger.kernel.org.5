Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EEF7694C6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGaL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGaL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:27:30 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB06E78
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:27:26 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a6fa018561so5291931b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802846; x=1691407646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s7klyvXF2jAdbpNHJFgLd0bcKzYUqqeZQ44oClwlwA=;
        b=lnqpxQydJEV4W1CtwlAKRvjQmNlQ2T6ikta4KVXIAp6foTFqCmSAG1Nt9CzR4dgRhd
         /YRkhP3xFiO1UIXBCEKM45v7Ha586cSldM05hdb51agXPHc+b4yDLWwtOtd1QQjZ3ELd
         Ba57hL/J279tpl1eaMmZFN/SLrTuMXnEoKaq9910amckvF0Etge1siymIGppVm0tBji7
         DEkQNSReaXY3ye6W0OQDv2bBwue2A11wMAfo+30jagOAuKjyFRou9roApHPQbNMN6INH
         xtM+y5bWFAatv6zKV4tgLti7FBkEuSWdHvpj7DOa8Md16N3EA0pftIK+Zy1whdynG835
         M7og==
X-Gm-Message-State: ABy/qLYSp8kw417Yfdc4ZMJXV6ye7BiA4ihHvmRymAn4mu0Wr8u4U2WD
        uimFXJkcu8NErO5xln5COuoof3Iaa2vt7mcCVXhLewB/hs4E
X-Google-Smtp-Source: APBJJlEoMHC4x++cptZGyx4HIyX+tHqYvDI9l/J5T68MMPCTF6Pvp9QjTVXbrxz23zFo8+cs9GhEtTvWduYPkRsjNCaAX2hqXflh
MIME-Version: 1.0
X-Received: by 2002:a05:6808:d47:b0:3a3:e17e:d2f7 with SMTP id
 w7-20020a0568080d4700b003a3e17ed2f7mr18290215oik.4.1690802846020; Mon, 31 Jul
 2023 04:27:26 -0700 (PDT)
Date:   Mon, 31 Jul 2023 04:27:25 -0700
In-Reply-To: <20230731110130.1456-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005bb0a0601c6b71d@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING: refcount bug in xp_put_pool
From:   syzbot <syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com

Tested on:

commit:         d7b3af5a Add linux-next specific files for 20230728
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13353089a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=8ada0057e69293a05fd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10318fcea80000

Note: testing is done by a robot and is best-effort only.
