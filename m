Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239168078C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379382AbjLFTl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjLFTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:41:22 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47FFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:41:07 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58daf9b195cso1938411eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891667; x=1702496467;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOkf3wcGPa8AkdxtJDVwQzuYX0z1XRxqQZ+YbnkesBs=;
        b=MSCX6CJQvSZ2iG/P24qIasl2jpQMtTdNHPWDad4e9f1mS73hZFh+MuAB70O2oh3xVj
         VhxHG9+EXly3Tr0aEnFGEEKfxjsx5QB0o0QAsPr8/meumYvOOTJfxDis35jvyHFZ/fi/
         lNxDJpJ7Eawr+lSpaNC5LfIrMBw9CvIM73KSKU/L0L8jfFx8CrmgbInWRVPXROB5b5dQ
         OW9tiPH/yvPhM2ZvxS2WIpoEc8WJVhTU1XyGVL1usvZOZDbKwb9TE7Uveswh7l9Ftlwk
         xRMsshh9XP9x1FAhAfkbJWL1FkpwQKVM4NfaPmsO8HVT1D1ZGjFU+raK6hc1BbBUHkFm
         RRpg==
X-Gm-Message-State: AOJu0YwsPjlEQA3eL+7tUFD218PH9/Hk7D4CxLdBnLd9QtdU8TwHRrpc
        h07vK0bZRrtP5Gd8UPuFHYMLMyslfGfJ2RL7EyCSd+YCiZMt498=
X-Google-Smtp-Source: AGHT+IFxs/WjsVq4MxRZKxNGPVwG0SAi8vyr4ENmDxHg3BQFaVjs1bLCLeuAPWgHVNT1eqNhWTSh3sZi6PLFwQt4v2LjyEMc20jJ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14cb:b0:3b8:37f9:4383 with SMTP id
 f11-20020a05680814cb00b003b837f94383mr3752647oiw.5.1701891667319; Wed, 06 Dec
 2023 11:41:07 -0800 (PST)
Date:   Wed, 06 Dec 2023 11:41:07 -0800
In-Reply-To: <CH0PR10MB51134D414F3002960A5BCEB99584A@CH0PR10MB5113.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046e71e060bdc8879@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From:   syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com

Tested on:

commit:         41f87dea kexec: select CRYPTO from KEXEC_FILE instead ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=12f729ace80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3513b9514190e290
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
