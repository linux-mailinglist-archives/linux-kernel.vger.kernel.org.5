Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936247E0267
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjKCL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKCL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:56:13 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F570D4D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:56:07 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-581dcaf04e6so2361001eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699012566; x=1699617366;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAFasOOoVaXy9wh2cbwgbuxuqROU0gWb1XaVBMn61Zk=;
        b=MGkdLKQr0eY62wD1BUBGVMbm4cJr1FLAWVnbFQMypd5G/TngCWUY8FNagtN0ksm4W9
         g+EjIVGZpzBb695OWIRBgSHsN3B0hxenYBUKOWYYekb0olFrdVCMaxGlwsNXI7mguZD0
         mBf9IBP9bnh59jzy461N2NCz5GxR7tmH6efOnBoQgY6LcJRrtGBBo3pJzrsdItCiljcG
         UFtcIvx/2/TzCP42XtHa3Obf4DY2957nPm/j2X5BcW74c86C9fecHf+f53ECXbpCh7gq
         jLXbLDLrcs94sJobBnxHPZkasnuy37hJiZlZW+8pj4iX0Nj6ZGb5Wzu1w8Lx6LfFX7+0
         MvZw==
X-Gm-Message-State: AOJu0YyKqkHZtKeREtXWcNlxs6Kl4TqSWZm7jl7DPrBODknLlr6aTNJE
        i1TU8rmKFkhFjdoPzl+iou0oSD+JolTyqVWwB1HQEqImGsct
X-Google-Smtp-Source: AGHT+IFoG5hnjYgkqPI0jFgUiezmVlKKvxgNxiY8qjpVEI4JDwleFWhVIfRNFwfGHsJG3BPHBEdIzT8FDDSXdohSRpBLaa8tLgSo
MIME-Version: 1.0
X-Received: by 2002:a4a:e1c8:0:b0:581:f31d:9664 with SMTP id
 n8-20020a4ae1c8000000b00581f31d9664mr7076194oot.1.1699012566557; Fri, 03 Nov
 2023 04:56:06 -0700 (PDT)
Date:   Fri, 03 Nov 2023 04:56:06 -0700
In-Reply-To: <tencent_C32CC16DCC9600E83EEC5ECC707B066C480A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007facd306093e30c9@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121de6bb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e86de086e9dddbc6
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158b353d680000

Note: testing is done by a robot and is best-effort only.
