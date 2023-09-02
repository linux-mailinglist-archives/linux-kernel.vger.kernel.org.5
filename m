Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405757906EC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351938AbjIBJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 05:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjIBJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 05:18:34 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D812B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 02:18:31 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a3ba17c7bso3477987b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693646311; x=1694251111;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY5WdLq26hZfmmxrZSw5pg7otXAjHaTxdoIMV1ei65Q=;
        b=QioBejxPSn7c9N9f5sDvPYhldDdm0L6oQt5avWmS31hAIXwXScB8xuvj/+NdlhQboR
         ziK/Ak/dL4Xy/zH2WYjPJ0+OtljGT0TUP6snrbCtTGU89ChQN7xffYX4Akx/M3VqQ6G6
         QggPzGKd9jZZtAl0MykROj2gZVBLI/HMc11YDv2KE1JFlgOj0ilS/Hqmk6UUPdycWdaz
         N2ci8R9S7WD6Wwoj5xPZ2e7I0SBQb6IzsQ8/uxlsGP4ZfR7nXUNnco4+UKsnjpphkme0
         TL8ZE81yZx27QElmaKnULX/QLyxKyhwZX2dmM0zGdU5bmDzHCStkBS1NOlmKSVO+4WhK
         Wfhg==
X-Gm-Message-State: AOJu0YywyR2Z8LvMnQjO6xL5+zvOYbypOwLhYvb4JWcEW+4ZMzZNxW/Z
        rcxXc7wqUpn5YO21y/zZUdmRolLNWeZS4YZMfjp+JWKRBoKa
X-Google-Smtp-Source: AGHT+IG3WfkHlACddXZPlCJFF4WA9fXMlT/P1uz8uvuyXjlXG14isFMR/28jNDlKRZwqPVH0BAGxUUaisMOmCiqnk3COsIzjJIQi
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:22c9:b0:68b:ee34:972f with SMTP id
 f9-20020a056a0022c900b0068bee34972fmr1967948pfj.5.1693646311025; Sat, 02 Sep
 2023 02:18:31 -0700 (PDT)
Date:   Sat, 02 Sep 2023 02:18:30 -0700
In-Reply-To: <20230902084848.5181-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be767106045cc22d@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in dev_uevent
From:   syzbot <syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com

Tested on:

commit:         0468be89 Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=143d4f50680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c33cc29407ed9ff7
dashboard link: https://syzkaller.appspot.com/bug?extid=5ee79919ffe91d629b96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13e9be77a80000

Note: testing is done by a robot and is best-effort only.
