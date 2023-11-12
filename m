Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE02B7E9155
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjKLPJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:09:07 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD9E2D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:09:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b9a1494e65so3257501a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699801744; x=1700406544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srdz066tvvTdM4CmNeOwelm2biHAQtgJiKmsTshSsQM=;
        b=PTp3+q7tnP8UOLRZOLTP80Riu94rOlRlf3TYbdcsQfJdiKbG/gHF0Wb3q1dgDWZXqo
         C2/HXA9HeFnlnzTC2Xen/AerZeCjRkjTlK9BWUoD0OazROAds4lJNZPaNCVrOjsZOdtL
         lSJuN+WyMovw7RU7qjMP9K9vAYpuuEsm4UXywBHw0jDoUJvu3YaoJQ3vTAW+90UT4GBM
         PB3pqRJ3gU5feS6jnAtYQmR3/G3mNmG7BaL63Vdnsw9/8t8leISoujLHUWCu+LJN5VXq
         RCDvOmSQLh2WwTNnJiwwrnLCJ/Qecw+vJixkGIsX2eqIIwbC9T0ezl1fQzkvA6oUXnSo
         c7fg==
X-Gm-Message-State: AOJu0Yzm4UwcsOGFYpwa0Tbk3qtw+kpTIsymBNXk14hwfD0arVMlc5Wm
        pO3WWn9U+pJiJhTx053SlAIcfx3S09B2NJVCmqIlRvGkuGM9
X-Google-Smtp-Source: AGHT+IGs5Bkh6t4mkKR/0xr7IdzglfJ6hUWB8xmVEG9vXFMRG6t/rR+LHznVq6ba/NS14YuOHKxykcNXYixm3z/LZbZCrCy89uco
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:523:b0:5bd:9b7f:b08d with SMTP id
 bx35-20020a056a02052300b005bd9b7fb08dmr1552203pgb.0.1699801744211; Sun, 12
 Nov 2023 07:09:04 -0800 (PST)
Date:   Sun, 12 Nov 2023 07:09:04 -0800
In-Reply-To: <CAOQ4uxhnY+hzfCA7A2aTfVKsveR9g6Hn=FbFrjFuXs8w3sYX5Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000271e420609f5eff0@google.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From:   syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com

Tested on:

commit:         97d58994 ovl: fix memory leak in ovl_parse_param()
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12394b97680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
