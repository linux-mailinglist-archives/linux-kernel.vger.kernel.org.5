Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F57FD5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjK2LmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjK2LmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:42:01 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB8D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:42:07 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-285a1155076so6127001a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701258127; x=1701862927;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjPA4/c9WZ5F20R0UIB2Kd3JkPUDLADtTQZRXgPbEls=;
        b=hntP7YHth2EWu0l528AS2OCSb03QjeCFGJ6u/r0DEsMdNViJfw5MUeU++G85TSIdR/
         2FQIHrscMs5HCzE7y7VK0eEl7sATutgDpS3zYc7kER5OVlzRsd3SttaWE6VM8AAgr1zV
         cbueAvmNS1/SxnBWGI+MxVfjc1dHJ0Ih9a+jCBPFYnwWCcm2J5GA4AotOcmQId1DfeKS
         4QWHq4z3u/5IIbGVjIfCjDEc6bCImwB97gtoPxn9pLHPe3TzJzwwHrUGtRYuo03KamCt
         jWc/O1Bt6+AYWh2lIiTaE5TF8SycWFNmdeNsOZWg0pmTnEBbVLlaZRtEhg3iT5aHnbqL
         XA8g==
X-Gm-Message-State: AOJu0Yw3UfTtK3SvoX6h5S08UPsz+tk5wI5Uf7LLn0Rc7IJd7aekJrPm
        0tnW0WIkfhWsl2pKIUE32y0OuWg2N8J92fu4asv73V8UhaX+
X-Google-Smtp-Source: AGHT+IGbTN6xrle3YcbjSc2dUkUNdkT+KI44D8h/5Q5ENIpOrNqCRlZlOPhp74t7acqNCThMkM2zuB6AQt0YMxOb0C3zZQRUpPR1
MIME-Version: 1.0
X-Received: by 2002:a17:90a:4614:b0:285:71b3:7b41 with SMTP id
 w20-20020a17090a461400b0028571b37b41mr3815999pjg.4.1701258127230; Wed, 29 Nov
 2023 03:42:07 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:42:07 -0800
In-Reply-To: <CANn89i+6BuZA6AjocG_0zTkD1u=pNgZc_DpZMO=yUN=S1cHS3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000584f41060b490648@google.com>
Subject: Re: [syzbot] [net?] general protection fault in page_pool_unlist
From:   syzbot <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>
To:     almasrymina@google.com, davem@davemloft.net, edumazet@google.com,
        hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com

Tested on:

commit:         f1be1e04 Merge branch '40GbE' of git://git.kernel.org/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1333cb78e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abf6d5a82dab01fe
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f8efb58a4db2ca98d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174c37a4e80000

Note: testing is done by a robot and is best-effort only.
