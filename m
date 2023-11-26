Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76AD7F914B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKZEhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 23:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZEg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 23:36:58 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8110D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 20:37:04 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28043db47ebso3956267a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 20:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700973424; x=1701578224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUr5q4+qs13WCUSgLDf7tiKfrKXQC51RR+s5njDX8no=;
        b=AaKMoxLP/7YIWIXX0cD7fgCDQxYibahn9pdkIF9F0i2PIs+jX8Pvsoqri0s/0dMKbX
         vOrcV8Jd8eL9afVxoFiLJX89TgM2RFI9UiQN1UzsdocujaB60yNjRc9tvyMlGlaHbH+p
         MdDr90yh1j25sdsHr6SjHM52qNaTMxbnA9+vIZpBBbNMkWMCMXx0VENudQwsUOeV/1CW
         LUnFMBjZ6FqfyoxCgVsOdBg6627JbKQg87MwVZEMZIGcnaN04heE+yqlk4lrIfE0NhyI
         6A3y8pTxOE5kE784tw/4HgjGhVz4J8YQbQVEX8Mc4Tt0GZewtV4QjrQiGJ2Uun2yF60l
         jwHA==
X-Gm-Message-State: AOJu0YxgfAjZHBfOlfK2iRxUsaDmA3MyQbM0PY3OB6y7tSTw5mYApiTP
        TeWxBBoKzsE4WRZeMObaUTxgnaRY/K/UgtDYq2gi20fVcRbQ
X-Google-Smtp-Source: AGHT+IGNoiS1sOieNCBWNbIpJ4kfmkmJ3QBD8RnD5bt6cNnCGcUSGW7PBd/OoXG6oi6035YFLS+bQTYTDD1VwCoyQLD1DkAb4eEc
MIME-Version: 1.0
X-Received: by 2002:a17:903:2308:b0:1cf:8c46:23e8 with SMTP id
 d8-20020a170903230800b001cf8c4623e8mr1935304plh.0.1700973424282; Sat, 25 Nov
 2023 20:37:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 20:37:04 -0800
In-Reply-To: <tencent_AEB0786A6F682DF96F6C94A4E8A2EDEACC0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba151f060b06bcca@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com

Tested on:

commit:         98b1cc82 Linux 6.7-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d59724e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103c62e8e80000

Note: testing is done by a robot and is best-effort only.
