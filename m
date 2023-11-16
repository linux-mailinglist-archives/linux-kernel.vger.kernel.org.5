Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A577ED9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjKPDMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPDMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:12:09 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1242199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:12:06 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc23f2226bso4328995ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700104326; x=1700709126;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Edz4vPmBSsi0sP3Hzde/fxO52eKGhenZtX09G8kfOso=;
        b=W1FXPfTfK6v53ZwY0vSHNSqDKC4w9H4mrN+FPYm9pI7Z4vW2q3WbIdqcQEjvGXMJQO
         2AnaPWZLnBs0dyV8Os4xGUFHeONMNOl5jzIx8E4snRhwVzUMCSMxVHU2ZStqq23bzMT3
         nfawXdndlhK9Q1qCW52Juyyx9pXBiGJM0eBmtZ6hyNIcIgGnxV3/z1aj+A+H6RLdGodh
         vapwqk4zhJvhHNksx0+yOu4BxH6nfxH1FS4raK+7MjrW2aQvB9TSFAGhalK7YjmF6gBy
         3LpswYLxOfvnV0Cy2rq6Ga+TUNFafbozKymvag0QCzcDjQCEwlrf5/wC9WDd83ZOUlAI
         DWFg==
X-Gm-Message-State: AOJu0Yyvu1q3OtrH9goPY6f6JzrGPoBR1sVVwcUFgsFMI6Vxb4bD7jA2
        apeGYYX6YGZaCuF9Q2F79sn1/F9PlhGyNROFZm5uNr0Sl8df4XU=
X-Google-Smtp-Source: AGHT+IFKhWFMK+/80HkRDeKH4ZQmkuGC2QpkF6VPpsLkuPvsdx1IRYCV5lILasdHwem/08nGGoqdUqaoFmjiJ697Q7AQERrIU9Tu
MIME-Version: 1.0
X-Received: by 2002:a17:902:efcc:b0:1ce:15cb:630d with SMTP id
 ja12-20020a170902efcc00b001ce15cb630dmr1958402plb.3.1700104326273; Wed, 15
 Nov 2023 19:12:06 -0800 (PST)
Date:   Wed, 15 Nov 2023 19:12:06 -0800
In-Reply-To: <CAGuQ_7hOGTm_gfXh5zvVovyKCz1Y0f-hkQ8WmzRfh5SuLvHx4g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072e1c0060a3c62a9@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mazinalhaddad05@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/drm_modes.c:1323:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1350:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1422:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1441:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1460:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1475:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1490:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1503:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1510:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1517:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1535:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1578:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1601:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1622:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1631:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1674:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1705:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1730:1: error: function definition is not allowed here
drivers/gpu/drm/drm_modes.c:1787:1: error: function definition is not allowed here


Tested on:

commit:         c42d9eee Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104e9338e80000

