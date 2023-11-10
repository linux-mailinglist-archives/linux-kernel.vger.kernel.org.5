Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3207E8197
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbjKJSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbjKJS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:09 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE452F36B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:25:05 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6b243dc6aeeso1851085b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699615505; x=1700220305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S69SySV4t3v20UfQhfxcKtmq9Az4t+4vKaCb8J3vBms=;
        b=LLVjH+R/0Ch/9vzdpn2XO5nQkmynZHvf+mhwOKfxzeY9mQoHhCXdst2C8WsRrzvKox
         eTqnSGD8Z3ZSNcpxI0rrxrPrbd/wZ17tI+ZF38I50F/vxfFaP3sKIQKGpBHipb2JYl8l
         6DKusvcwVp6XPO5BjAjEjNHhGPHXXoYsK4o6ihZNwIoG4uvTjE2hGYpOmqzEhk743eBg
         BAILxFB/e7eCYJdghfknlfu8en+TqYqOcCu4LavFxPZU19OQshBtzXifI9CgxZtCg5mI
         hkCpq617L+nqD5vTB7Hsjk/m/AjrN0mok+qB/9ASrbBJziO/puqOirqMWuzTU1IUCddX
         hlxA==
X-Gm-Message-State: AOJu0Yypnnnzsg5z6h7MsCZBOieYq4FnRi1Ys+gOok6pNq7tborvrUsf
        WRFEF2R4IrpABsJU5DXmKk+5Juvu+gJK+JxFA7Lc4bmkhIVpUUE=
X-Google-Smtp-Source: AGHT+IFY+Xe7wSPSJJ+Zks0T7gg/RTnNscxHQhFYdnk1wn3xTuEgyNBJrVICVHForHQFapBf2u4rpwXlkvDUrQHOULPrCMfLCIrX
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:bd5:b0:6c3:4121:578d with SMTP id
 x21-20020a056a000bd500b006c34121578dmr1110745pfu.2.1699615505380; Fri, 10 Nov
 2023 03:25:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 03:25:05 -0800
In-Reply-To: <20231110110726.3060048-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073fea30609ca92b5@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
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

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com

Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17929338e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c4f8b7680000

Note: testing is done by a robot and is best-effort only.
