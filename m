Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387D7D4ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjJXLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJXLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:33:40 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406FB128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:33:38 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-581ec87fbf9so5782462eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698147217; x=1698752017;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaTYNHgdiwduDFwtKX8AKfZd4H2At1jRAj58FEqtE6U=;
        b=k0urgjRuhkUfWl8Ml2c9S6jGjykNlu/c11keBIXJ29VyIQ76/EKzfQO5eE1PxkF9WI
         BX5PROqyUiIedgDb6MUlk4/pqwKmHPmlFlJ2QiMuqavPVJjonZfdfsWyQttUeJMdBkuv
         LeThMHTnEoBu9x7sqcAMnsuHjr+mnOohrwuB/nCx80TXfAZuZgntJ4ixgMFPwq2Gbun2
         0diTiSLrQRobp8OH9HDD3YzuicJ+IfRatqAkK3DWRyM+ZoZaFXXMl5Zx7fQnFHcd0860
         DRV+ZguSu6tWMda408sOlytN4PEFE7dfzTOj868xRi7QLpF0YvQmmd81xxqTDKcTktNM
         iPRQ==
X-Gm-Message-State: AOJu0Yy6Vt1lwYzroJkunnAEFSV3IQmdn/WLz3te6Y8IqPS0YhtGn69Q
        fw23dvS5SpNp2NQY42l51N0ybuWjgtwiju6k+zfyesxx1ANJ
X-Google-Smtp-Source: AGHT+IFrYne8yLXL1ET+WDEDBf+xt2QE3KSP6eaYTev0+3X//lE9caLhReORSNgQSYQvG426Ztv+91cF7SCblZK1pglJi/jHxdmk
MIME-Version: 1.0
X-Received: by 2002:a4a:d389:0:b0:56d:72ca:c4dc with SMTP id
 i9-20020a4ad389000000b0056d72cac4dcmr5258612oos.0.1698147217634; Tue, 24 Oct
 2023 04:33:37 -0700 (PDT)
Date:   Tue, 24 Oct 2023 04:33:37 -0700
In-Reply-To: <20231024111520.1986-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aefcc8060874b51e@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_rfkill_set_block
From:   syzbot <syzbot+f93d183bc91522d90de9@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f93d183bc91522d90de9@syzkaller.appspotmail.com

Tested on:

commit:         d88520ad Merge tag 'pull-nfsd-fix' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=159aaf83680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84ec698011085fee
dashboard link: https://syzkaller.appspot.com/bug?extid=f93d183bc91522d90de9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ed6f33680000

Note: testing is done by a robot and is best-effort only.
