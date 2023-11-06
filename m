Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD27E25CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjKFNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjKFNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:38:06 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A54BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:38:04 -0800 (PST)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-587ac1e8eb1so1680275eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277883; x=1699882683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rePFmrzDp7ouZufr7ywDsKCov5BI8lKlbKV5hiLAmGk=;
        b=FtTMfLVhKYegmwbtLleBcfsGDtqed+SWqSJyIcD+oWxOyjc2qjoo1t+AS/GtfK7es2
         1QMwikVbhNigmq2VRXywYggKJsVm1Rs7j0eu5rqbr1ZGp65PzliBA9IBlQ4v2iXzaxDu
         plhY9q6R+dCvoJLKsHO59IcACfUfMCotVv+CrJ3auOuykmAu97RiAQI3VJv3ZQ6OoPVK
         5COM1KLHmg+CSX1aRE57AMrTs9zNIb42CFUE6gDz/1sqA2NjHmJPPGu0z1XNOp/JokUe
         TBE9gecQrGvzbl76NWUbRjZ8F2s10zXkfD5Xh/7jjw0qSEBwhcqxVJhaEpV5t2oZK39Z
         HNaA==
X-Gm-Message-State: AOJu0YzpuJH6S2t/HyU/5cj0B0oRgppvmYM+kj/j9CPOENql1q7FirC3
        iCO3pU+OVqs9JD9aaxv8tEtAP4foU8HasYGvnbaQgs/8AV1z
X-Google-Smtp-Source: AGHT+IGhh1egxf33/8jyC2NnRhURDHarj2Xc2RqKSR0k/SoFyW3sFBp9R4TzQ7IOvtdJU7BSOKPUyjv6D3djs340uGlZOa3mApGY
MIME-Version: 1.0
X-Received: by 2002:a4a:cb0d:0:b0:581:e0bb:fc32 with SMTP id
 r13-20020a4acb0d000000b00581e0bbfc32mr10019355ooq.0.1699277883398; Mon, 06
 Nov 2023 05:38:03 -0800 (PST)
Date:   Mon, 06 Nov 2023 05:38:03 -0800
In-Reply-To: <tencent_E146F1D2D4464049842EEEEEE24C8EA7C306@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d61d906097bf674@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1034b717680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e86de086e9dddbc6
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172c71ef680000

Note: testing is done by a robot and is best-effort only.
