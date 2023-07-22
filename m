Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445B75D94C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGVDDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGVDDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:03:43 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D63A84
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:03:43 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9d8b76be5so5262162a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689995022; x=1690599822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8Oe3TGTljBalJeDFwqyq1ZSvfeLmYQ5l8d2D3I9tuA=;
        b=CbwNao+BTT9QiLwFnVJipqUIU8K7OA5fmL/YtNNEVTvgiBIYY6zPTvg+47Lb5LLX5r
         WlwXhpttA1hoPB//hkzRAQVkQrKsGh8mQPlfKlKpJ3ijmN3N8s2S1TRYbCcSXygglQ6+
         1MqTi5g2+VwZSeJ7MjaviK89O77kJ5L7ymykCE3QQY5AFM0kxwAD6BcMDzqQeOSBdf9X
         73jbRz/RtWWctljjp0I+9CBqK90rm5M40o9vAm1HiQjd+/UvyAHZGTOu6aWWvizHPEQA
         hk5+FrtjJPTYzj/3Z1KomLMdSa9tk+9FnocubFVqY9wNI6NDCgy/VZ4qAFyDI3/BXtdm
         4m2Q==
X-Gm-Message-State: ABy/qLZcugoQV0ccEV1BRVzqIwqmJw1pp9a1hpN/IbeUh6AUTpTOmfOM
        IM5k1Vq25o1W4m+2hLLmgGSl+4SZJjTJM5tpLkBk1Vfo5pvz
X-Google-Smtp-Source: APBJJlGFFZ2bisBOnJdbP4Jz0QWwcEWaC0EPJdh8lFNmi1OdHPtbDqhnkRLBl2p1AXH5ys98CSsuxWVisLhPwJaqkDBv7rW0X1Rc
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76a8:b0:1b0:3bfb:885f with SMTP id
 dx40-20020a05687076a800b001b03bfb885fmr5170945oab.6.1689995022390; Fri, 21
 Jul 2023 20:03:42 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:03:42 -0700
In-Reply-To: <20230722020419.540-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb5d0706010aa05a@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iommu_deinit_device
From:   syzbot <syzbot+a8bd07230391c0c577c2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a8bd07230391c0c577c2@syzkaller.appspotmail.com

Tested on:

commit:         2205be53 Add linux-next specific files for 20230717
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11975a06a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=173c0f005722ecc3
dashboard link: https://syzkaller.appspot.com/bug?extid=a8bd07230391c0c577c2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178a1e9aa80000

Note: testing is done by a robot and is best-effort only.
