Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B267817B7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjHSGtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbjHSGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:48:32 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A710C8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:48:31 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68872e445cdso2182001b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692427711; x=1693032511;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peSpcBLb5oFSMY9CgHZu0esveRm0G4K9NijAlYhPqAg=;
        b=l1fkXQKOcGzrWS8GGxMS0E/b/zNhjzaikHE2uP1PsrCnBXPLLbc2me1AA0QM/gxznK
         bt+Gu4lce30OxbypDgzMpwERKZqzDOPWpcNRQ18n4WUPch+nWTIk2bBckUEAhcwpg/JL
         9AxPtmGPY2bba9RdWi/jd1Pw54bbXoWleOkdhs3OgUCp2kUgTmGCQuxuBe/DjpQmVDk+
         yNQvoBVBHZj3sXeYaMVBRVKgm/qY0dF8Kp8OnlmwXd9JFXz2XVN98CXL2QDmq2s+OmPq
         tntzCaPCKxrM0952QPUszPgRB2nxgrLziWURg+hbdeyJd8xLqLhm2syZ9RNQIp6G/RgI
         VqSA==
X-Gm-Message-State: AOJu0YyaLtTkklSVMpDUx+F7c7/OJF/rIC7VO6Oz50fx/mlVzgoyhGq3
        /5duEY5yNx2baqNhh+EVdwVyuNPVcrh3pc2qmeFuk4hLTfmI
X-Google-Smtp-Source: AGHT+IG3aDtFp4+PMRgSNdut3+3QQt59r7J6fUO4IVQun9rf1saPUj9jjKK4bvAkjf7psENNMOXzYoDLhCVOVv0RPcp7KyHlA1v3
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d18:b0:668:85ba:7164 with SMTP id
 fa24-20020a056a002d1800b0066885ba7164mr885271pfb.0.1692427711382; Fri, 18 Aug
 2023 23:48:31 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:48:31 -0700
In-Reply-To: <20230819062743.2405-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b8b0f06034108ae@google.com>
Subject: Re: [syzbot] [hams?] general protection fault in prepare_to_wait (2)
From:   syzbot <syzbot+666c97e4686410e79649@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+666c97e4686410e79649@syzkaller.appspotmail.com

Tested on:

commit:         ace0ab3a Revert "vlan: Fix VLAN 0 memory leak"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16463d37a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=666c97e4686410e79649
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14730040680000

Note: testing is done by a robot and is best-effort only.
