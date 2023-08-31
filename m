Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C275A78EC66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbjHaLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjHaLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:45:32 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2893C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:45:29 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-56c3a952aaeso726709a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482328; x=1694087128;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEhCZ+hzBSDxixeP/pH122e53chFOGI0MMiJZJqxqBg=;
        b=DjJ0wqDIFG5tDQnWL1JF19u8PzG9/tjkxBuamhaBozjuZH1Q0eS9vJMHaWl9d7Q4OT
         NblEIcdZMxc4kJIWvrcaFuGeN1yw8AxaatEe3eDmDR5Wp4CINnzI8VF3zFFgyqMBKYVB
         1aCATajxRQAXUczGF8f9Q3uOT3X1jdE+i9Magl2pngR39nM3/oumkkxyXJsvCc4q0Yg/
         mDG93o5anZynsKVXXHQLmu/Hv4cVqQYuwC4Th2Vodo+X1wutBk8XLhSKQW2UuXaxUkfp
         2nH6p/obkXwcZcHSUGY0MgZ1Yrk1nnfYGUXkHdnJIR/bBylpKs5pTTCgLo7DYRJzswTd
         JQYw==
X-Gm-Message-State: AOJu0YyNodg6+/TNa6FCQpTC09pmpvFVGQmwWvS59WRdnQU8sLl1xi8K
        ger4bRrCePhH3bHG+ugOs7qRWSS9ejj6oVDHNr3YuZQyfdE4
X-Google-Smtp-Source: AGHT+IEHpXmFygAYsyw6Nx/VvMhODcoq4YpQl0PGUZKOIsSezXSXvBjgO1veXYFIfRFUrUzXDsbLqo6zJGc+uCdNXeqxvY7uX0G6
MIME-Version: 1.0
X-Received: by 2002:a63:754f:0:b0:570:275c:7431 with SMTP id
 f15-20020a63754f000000b00570275c7431mr620676pgn.11.1693482328616; Thu, 31 Aug
 2023 04:45:28 -0700 (PDT)
Date:   Thu, 31 Aug 2023 04:45:28 -0700
In-Reply-To: <20230831110322.4608-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a178f50604369403@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in pwq_release_workfn
From:   syzbot <syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com

Tested on:

commit:         a47fc304 Add linux-next specific files for 20230831
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1440618fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8294f0401243efe1
dashboard link: https://syzkaller.appspot.com/bug?extid=60db9f652c92d5bacba4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103f1bffa80000

Note: testing is done by a robot and is best-effort only.
