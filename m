Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746947F8835
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjKYDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:46:58 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76121720
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:47:04 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2859447a409so1215588a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700884024; x=1701488824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZEHhIkuSsHHzlY9JwQrpGqrACOWsSZArtqpxmV/D2c=;
        b=VWHC4UdPo1agGI3/0WLoQ52kG6Qi1TGckgh+dtE2TzcEvbgu/zfoYJDOvUUVoj45lF
         C1Iid/WbQMzkpF3pwoUoDZ0YoEY/ZJVac3jHrH8LV+WwfWiC8mgzeLCQULkpT4W6MX0x
         J14z9wjCpxVpQMRY1Yn4yP2sRnG04/gdTlykj8Az2WY1B9lnQ5qbEqGnNbtuGoe0s+hN
         GT3vA99iRFJTQh1n23FMmbZRjbJ+B0SyJo0UQaDicgI+/FnS4aJb69cQjIjRFo4So57V
         DL8FRsDlFAOz25BTpcyQ2Vp/++tzXYlVNNYoGXELzNp0be7wvQfBa2hZdWlcgx4pbfhA
         GnIA==
X-Gm-Message-State: AOJu0YyDH2D3KMIBWcTeTv8X+vWnXaKO0sR9upcFXpXLzQT7gNV6Qqqu
        rmBB/froTvyvyRqKh5Xwm91TpvkM5TdXwN+TNEhvSNdNVjs8
X-Google-Smtp-Source: AGHT+IGgkO+hVCy0kU9nQabumgCslbj+GgXYG45LSmbQO2EBv4Sog3W7b9vV/FPQBy//LtI58R+MbY1mwJjxriliYGfl8ZvyXpjL
MIME-Version: 1.0
X-Received: by 2002:a17:90a:1109:b0:280:37ee:d2ab with SMTP id
 d9-20020a17090a110900b0028037eed2abmr942948pja.1.1700884024302; Fri, 24 Nov
 2023 19:47:04 -0800 (PST)
Date:   Fri, 24 Nov 2023 19:47:04 -0800
In-Reply-To: <tencent_148DEA923ADD925D92193DCF888DACA5B807@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012a2ff060af1ec36@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com

Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=138d5d9f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144fb6d0e80000

Note: testing is done by a robot and is best-effort only.
