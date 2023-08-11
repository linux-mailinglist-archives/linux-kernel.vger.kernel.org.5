Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2ED77907D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjHKNLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjHKNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:11:34 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B83A8F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:11:31 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso3553145a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759491; x=1692364291;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85i9+xl+xM5AuqjpBE7xe2qIMsQEToMtFqeiJTlbC6c=;
        b=cfeyIzPzNYnth1TpRzLUNd+cYdjY+x5Tx8ZnrVez+hfevwoQkUPJKSfmAGiRoPVoAu
         Ea5yvxBCHN4DKRc+9hKkrXUImBC2XmjEbUZUZ5lHTyol1nrgj2F7E+w8p+4mOw3ZyD0U
         PASPISYjpzVjGwxxjVZB30j3PLv3pDUBd1dANTss2b37uo89jbK/bBK8NKBI1HKItqGy
         DOy4kUyYdvImNU8MPoALFllouMxDMFm9hOu+dVjOfANPSsTOs8VY9aSUsHnrKvegFrPN
         XT/FA2gNwyy8bjg9dI5itGE7LZ21ht+/8FpwWN3fj/QPkLnYRFX01lZnaXg8hgvV35DI
         N4VQ==
X-Gm-Message-State: AOJu0YwlZH6hmZUObLFseuli/6buwrl49J8nXr3mbgbl/iUpKDVMbDPi
        yWF4UNhKKK26OD2Fa+1pCm137RqXVwbbOQSj81Hz85gNGt/+
X-Google-Smtp-Source: AGHT+IE6mlpOJnrQYygGL94RLN7nZBqIXwoLj/2fLMhBjffAqYtlCaP2RhL+Vdgavypmlox1QgfnsdLW044EoCryJciWsqSMmjVU
MIME-Version: 1.0
X-Received: by 2002:a17:90b:612:b0:263:3727:6045 with SMTP id
 gb18-20020a17090b061200b0026337276045mr417243pjb.4.1691759491089; Fri, 11 Aug
 2023 06:11:31 -0700 (PDT)
Date:   Fri, 11 Aug 2023 06:11:30 -0700
In-Reply-To: <0000000000004f463f05ffe76731@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000830cdd0602a573be@google.com>
Subject: Re: [syzbot] [usb?] [media?] WARNING in smsusb_start_streaming
From:   syzbot <syzbot+a7c205f9c1168e2f1dcc@syzkaller.appspotmail.com>
To:     duoming@zju.edu.cn, hdanton@sina.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 6f489a966fbeb0da63d45c2c66a8957eab604bf6
Author: Duoming Zhou <duoming@zju.edu.cn>
Date:   Mon May 22 23:59:32 2023 +0000

    media: usb: siano: Fix warning due to null work_func_t function pointer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122f7a3ba80000
start commit:   d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=a7c205f9c1168e2f1dcc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dd0d94a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ea4fa0a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: usb: siano: Fix warning due to null work_func_t function pointer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
