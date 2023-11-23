Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755197F55A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjKWAvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjKWAvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:51:38 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C961995
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:51:05 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cf6e930886so3805465ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700700665; x=1701305465;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfaq3AGm/sS947+EXYZkYbQDgCTkoeK5QjpYHRGeaQE=;
        b=of3WrgbmOIUiOf5MMMJozaQmiYxC/GIrgVkSpTIUVkhHPVtqDBL6We3jwuiS+Ywq62
         11yZAlfe8O95aZl/2QP520pz1x9Qtn6zuG/2rfwHEEh+3inZSixUJviT3Ef0ZT8dnlha
         Br4+Yi/D0k5raopCjlzwV28kXBYv4lYC8VZ7lGUnqjWJHft1+x4zQM0ojQbNTm98ymJY
         EdQIfSPJw47ZqOSaI9/z6w3gx2TazfmHkFKjuULpyjQJcQxu58EPVoIn48KV6M1nveGd
         X03/9vTccXyS95JYrfrcjmgJwvM5tDpDKG24Id/6Eq+ieown6joKxSBxXaOzhMbBphjq
         sGzw==
X-Gm-Message-State: AOJu0YxpkGdaF/P3pMpFbkDP8oje3RZh8vM+UK0zw26anuKfTs51kzWI
        km7bh9aF1yBzljd8mhtKTSmIdNiXwf6C2e2Hnjfd3zMzxgkR
X-Google-Smtp-Source: AGHT+IHNEr5gMdS49EOKTW7KIMbyCzSLuZCXXqA+iEwJCfZrK8tyshnPTdNLkZ784dCLq9Em/RATfkY3EhtkvklY2BxYCEyoLhfI
MIME-Version: 1.0
X-Received: by 2002:a17:902:b487:b0:1cc:281a:8463 with SMTP id
 y7-20020a170902b48700b001cc281a8463mr928981plr.7.1700700664887; Wed, 22 Nov
 2023 16:51:04 -0800 (PST)
Date:   Wed, 22 Nov 2023 16:51:04 -0800
In-Reply-To: <tencent_1A577926DC937A2360297AE3B6C454D76605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000000099060ac73bb2@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From:   syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com

Tested on:

commit:         c2d5304e Merge tag 'platform-drivers-x86-v6.7-2' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1756c634e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=b834a6b2decad004cfa1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d59a34e80000

Note: testing is done by a robot and is best-effort only.
