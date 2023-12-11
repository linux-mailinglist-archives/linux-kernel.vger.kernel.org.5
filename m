Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0080C100
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjLKFwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjLKFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:52:02 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F1136
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:52:03 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d9f5369586so4026248a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702273923; x=1702878723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WT7iDGdK0blwHXTs5IIImnVNU6r140U3iqqk2O9768=;
        b=vCoTr2QhjR6m1nmWiAcB+ISTYswrbWWTBGcCfgz8qfLXmqai3CFKHAjTxynnuAXoFu
         NYNj41W/RSbmRw3d0wHucNFMqatBQIodIDeeHuoplmnMiYrTeMcG2XKdW4Vaux1bPHRG
         atA8ikvUXWSQM+XlFLApWNJLBuVvlNv5KbKPgnyQpAHoKMYgl990fBgIewWmIV5VHAGC
         /3VFwhJ1wQ6Xn03cqqWmrZ3qGXqnQwKLatShOy6WGRk++8NrARCHiwLm/+MGSPOR3Uu/
         s7DzHazmvCsAWTE5BcGs246ZmoQBaHQZCrgmKhWXlmTsd5tRJEdDFwfZ7ivggK1lXft6
         TRlg==
X-Gm-Message-State: AOJu0YzrBitnJxxeicurwarkq/VIf2YV9lePXZZfKUAofpRAKErNlORj
        a927KFCA+iLMDwBi5l+V+mhI5ChFY8DJ0PMs7Wn/+oNPjcSiGAY=
X-Google-Smtp-Source: AGHT+IGopFZwBqsMs958pJaGpXPXFjAdXC0klnaLsejjLDJwN+p5wUrGojVV6ps8oF0PlJwZT4RqoawVgWxP4xF9xnW7BQhdqKBk
MIME-Version: 1.0
X-Received: by 2002:a05:6830:43a8:b0:6d8:4cf8:443c with SMTP id
 s40-20020a05683043a800b006d84cf8443cmr3723005otv.7.1702273923168; Sun, 10 Dec
 2023 21:52:03 -0800 (PST)
Date:   Sun, 10 Dec 2023 21:52:03 -0800
In-Reply-To: <20231211051540.1882463-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000803f0f060c358866@google.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+006987d1be3586e13555@syzkaller.appspotmail.com

Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10325ab6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1654f06ce80000

Note: testing is done by a robot and is best-effort only.
