Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3B7CC1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbjJQLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjJQLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:17:38 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65861B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:17:37 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9f6006f9cso5002847fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697541456; x=1698146256;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85vJeC4bnhch33/BMxPKUalmZds7NLqZ/QAGHU8pJig=;
        b=KIxPDA1QXte3I0YfEmdMlEUwPPlRCX0O0BMp0trOTN9Q22WKW9zvdxkzGrAvBfAP2A
         jlXbks4T2Oml8TzgENKXvyWTstjxHuNUWLPxJ48FlCD49JKYFXEUllHGPAIjCEXgSadN
         77ji0rWC+1727btGqrAZ9oRQGN4ghJBFp60YWMZcUTefkwTAGf50qVvdG4n2Xzc29v/1
         CBh5AxDEYbc5IVxdywW14Pa1x0f+XHF+3MeLOyFxIWt7S7oTHJx+opQhIy4/h/w66jv8
         NwjcVtXygwL6VdvI+UmqvR0kHenCI9lzflgGJj9ytsVbISh/5X0xhc1Xgm+kNvMI28/q
         XbLA==
X-Gm-Message-State: AOJu0YzO4NKB+qxRSdlOaQ/KZPPsDamsJMqBumfdiwia6nOh0oPk0YGm
        BvGCDUt3ISSoMx7bI0puRHYD6gn3F12n9+9Tta7oKeN2p4f8
X-Google-Smtp-Source: AGHT+IErHZ6coDRfh4DPiAsMNE7Nvzh1Rx8zx+iz6km+so5+ogkf3j9Gv6Ethr/IuMuInqoIhSzq6cDlzzbvx+YydjTBOON77w6Q
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3a32:b0:1ea:1bc4:d06b with SMTP id
 du50-20020a0568703a3200b001ea1bc4d06bmr798113oab.10.1697541456778; Tue, 17
 Oct 2023 04:17:36 -0700 (PDT)
Date:   Tue, 17 Oct 2023 04:17:36 -0700
In-Reply-To: <20231017104539.1939-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085dbb40607e7ab96@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
From:   syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com

Tested on:

commit:         213f8915 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11583ee5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2b0838e2a16cba
dashboard link: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17da2e19680000

Note: testing is done by a robot and is best-effort only.
