Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628D75441B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjGNVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGNVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:10:35 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3A2707
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:10:32 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a4484a79a9so1054021b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689369032; x=1691961032;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zJqurE0xEnP/nVOk2z+KNDCGOxA0fyWEHezz5vMyug=;
        b=SARFjleUmq27Ats+kjp80D36XVFwn6wV72HoLI/Gj3lwvs048q0pH5PdvmDxbla379
         9gATAZWT9HRXR9v9XGANt1dpE82ENKbeeIyCsSZ2rn50Mh+xoGagAXLLl2axrtwT34T1
         Y1pHUHuEgGLH4gFUWx9+1mq/Edsu7Vo55amnjokk0ZrNIXd4I1MR0TjrQGfOHPfETi+n
         TlCpiOeaqDJNMMTzKYCRMcc1JFDDczv/2J7YyQB03734ys23Xn69XQl7FInFEzFEfkL3
         t3hLzC3kJOy8fr9/RiUvvfQ6ZyFNf6wm4bVQ2Bau+pxSrj9ib494iU5dlTZXjCPILiJX
         KgRA==
X-Gm-Message-State: ABy/qLb3WTydH/ToOvdQ8bZS0UFR5ElFoxlmnMPg4160GeMZVa+spG6q
        tfJP7W6zFKi76vhPBmu95zBMFF3+BO0yd9PdbU107xfV9aDG
X-Google-Smtp-Source: APBJJlHaMMk16Jd5tGRYCM9YjABjXQZcWNm+V52aeTzvMKuF8BIaCqyk2fsdY6DxFUwQIFJNnn1GRuvKPZveJxxSE007QqtbRKkm
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c8:b0:3a1:ce2a:4ca5 with SMTP id
 f8-20020a05680814c800b003a1ce2a4ca5mr7791880oiw.6.1689369032261; Fri, 14 Jul
 2023 14:10:32 -0700 (PDT)
Date:   Fri, 14 Jul 2023 14:10:32 -0700
In-Reply-To: <CANp29Y5yq5hTcJ=VRjSXe+Fg0H=xqj7ajhk-eYBPEPZE4kHC+w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001007be060078e10c@google.com>
Subject: Re: [syzbot] [fat?] possible deadlock in exc_page_fault
From:   syzbot <syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com

Tested on:

commit:         2772d7df Merge tag 'riscv-for-linus-6.5-rc2' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1429dadaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1d4ad381b2a4966
dashboard link: https://syzkaller.appspot.com/bug?extid=6d274a5dc4fa0974d4ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122ee67ca80000

Note: testing is done by a robot and is best-effort only.
