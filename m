Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505E7F90F1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 03:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZCUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 21:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZCT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 21:19:58 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A011B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 18:20:05 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfb21853faso10930285ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 18:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700965205; x=1701570005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhW0rd9+s2eAc7n2R8fuPsPsb3CTfE3Ob4lN/nPwpm4=;
        b=gwjJAm9dX2e/r7IwNBFK69SuadEuTrX7aqUL2oPu8NUEDlSVLNySlaTAHWjAgi8y8Z
         iZoYymWWbsvFe+1c0bURKlhxKiFY3TQqkCj+rXkY7kSQVGWccahG8yW0/DrMgVS4vj/I
         l9Xd4U3dwY9RdQty2tjBigDIRLHIEprOdUaL5KiktMMu8VhHUJatn1pKu7lgkZJXjW0+
         iEgFV0GfRTlu9peWbbX5mAkGMoiYgin+upIj5+DeNMyKlstPPzoXDaIjgETwhUpeUJUR
         eeIRQp2Nus2WGQgnpqFpjn+B9E0NiOufI2xtVo/wtN0t0WVpcTPhYGRAovM4QXLlUAdY
         5qmQ==
X-Gm-Message-State: AOJu0YzuOY7I9gH8+8ruZJPWca+qo4/wWKiFw0VkUZhVRiJta+lMclTF
        og7XFVYYZLY2TqTPhKkBcnHqBoYhTLcgGxwJcf0V01ndB6OY
X-Google-Smtp-Source: AGHT+IH3MKPTCzcdATtY7G6ADgda3QJXCZ2bXG49+8r4gCnVl2yY4lJDqIpKldGfSHEis8V6Rzz99sN7OtHDxnVtLP8EC+sCvPb/
MIME-Version: 1.0
X-Received: by 2002:a17:903:183:b0:1cc:2bd6:b54a with SMTP id
 z3-20020a170903018300b001cc2bd6b54amr1786448plg.10.1700965204845; Sat, 25 Nov
 2023 18:20:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 18:20:04 -0800
In-Reply-To: <20231126015722.882-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf6dd1060b04d2d3@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com

Tested on:

commit:         b46ae77f Merge tag 'xfs-6.7-fixes-3' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=129d420ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f9fd9f680000

Note: testing is done by a robot and is best-effort only.
