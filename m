Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44880649C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjLFB2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLFB16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:27:58 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7441A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:28:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9ba7bff47so3295049b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826085; x=1702430885;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ySauBYp0pXzqSF3h5YZYqJdikNmojNceW9Ms4nmH48=;
        b=aXuZohbYvqnfmKNg/Xs1vj4a+7Ql3FRWowcgwVuJbOVsauY5SS28uUKeMMBX7pK2XD
         MAYtZJ9YC/sRuYD5Zem4HZWIRcSM+1RfpXiPOL3YZgWFowCgKn7WJYb7VlwN22sC7KRV
         xAjB8ltInfooJacqiOpNY4Kq8f1qHkeHseoTTvPoBM/WQ4HJmHD5MQw0rdwYOSbiF+Gr
         RQrDcr82tVunvcPwR3wyeQrijO3JCR2ljY1ZAtCwx898k9dkoR7wGoVEyk+44XIwhhIH
         WU5bySAuizWeyB2ONoM5m+b1TxOZaw6qr0Mh+MbOIwO2qyHEorc13WtZD1uvQXRjQ4nZ
         czEw==
X-Gm-Message-State: AOJu0Yx3tEl+kuAZTOE5ZFvmwX1GR8uSThW1Y5FAp88nmq5Tizb87Ch+
        3YEOgNaskL5k8geMvKP9cLr4GOvXcoh1Vi7MdEEswX1NMue7
X-Google-Smtp-Source: AGHT+IERo+uS3K5PcCNLP0zvPy2IvH185FonEs/HGwm+m6q13cU7lDnfz/RiiSjaBSIUmpp2rN0ho2Cm9BzujinCS+f+Q1Hly+Gw
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2009:b0:3b2:e2b6:75a3 with SMTP id
 q9-20020a056808200900b003b2e2b675a3mr171604oiw.6.1701826084931; Tue, 05 Dec
 2023 17:28:04 -0800 (PST)
Date:   Tue, 05 Dec 2023 17:28:04 -0800
In-Reply-To: <20231206005340.11534-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004310b8060bcd43a7@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com

Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1577c0d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fa938ce80000

Note: testing is done by a robot and is best-effort only.
