Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1FB809C43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjLHGPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjLHGPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:15:14 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBE198B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:15:05 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb01440c98so3090711fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016104; x=1702620904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAYaka19fzadhhJCcke/ElrnncSM+zcW6MKUKNnChPs=;
        b=Ro7hjkzbsOW82aSij8WltAeLlAwRAUJrvjnLDdZp1gE2HseG1SBdpUKYeMLgE+rxEq
         DIrpSjZvOTtUo0j8v011BExhBRQmqx4Dr0bzabOwZFV1ZeMMOK9ciZc2XXACRwQhvAo4
         19VvXtlXih/BCzetE1nUwkFQLakcjaYWORMWyussDtfaWgGMUA+1FRj+8rfjgq5JI6sB
         5TUfzY634g+xZRSSIsBjdgdaCwyfU70DzqFZktafpQThDF6gN0EHbSGHA1U60qpWq3Gr
         NJHgQpcSDnk1NQOFvQ4CVX0V6mmUPXREAI5qhKzImEwa+XHt+wmYpaqIth82+aSZKKon
         4Pgw==
X-Gm-Message-State: AOJu0YyAhssJDBs7gqw//xrGaQ+R8bD4z0ApVjdGPuADsaaFi469SC+Z
        5LfSicXTjHAv1DO8OBctrclaJqDNBHM3Jw1AA21pQiUf38yat+U=
X-Google-Smtp-Source: AGHT+IFzj1jgubhDs2Yg1fdBdhyvTUTDdOxbhQce2MifjA5om6/kSwXjvLV4k8JGOhGeQtk66lQ+/p2uTA4qB74pnHzuIo3kT8mR
MIME-Version: 1.0
X-Received: by 2002:a05:6870:f290:b0:1fb:1e69:53ff with SMTP id
 u16-20020a056870f29000b001fb1e6953ffmr4488270oap.1.1702016104509; Thu, 07 Dec
 2023 22:15:04 -0800 (PST)
Date:   Thu, 07 Dec 2023 22:15:04 -0800
In-Reply-To: <20231208055640.1895881-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fb809060bf9814a@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file lib/radix-tree.c
misordered hunks! output would be garbled
Hunk #2 FAILED at 57.
1 out of 2 hunks FAILED



Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149841cae80000

