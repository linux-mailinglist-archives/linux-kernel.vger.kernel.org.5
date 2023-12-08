Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367EF80A8CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjLHQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjLHQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:24:59 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4691BCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:25:05 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d8770b512dso2713003a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052704; x=1702657504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NADYlLeKES7cbeGMNjbEMFy02hFJfzOn/DYe4MvOsgE=;
        b=ciIIatKtN29u0HD/AzQRSUu5cUvFSvC7MwWlLEgpSQFbXTvOYpFFZKX/+rdnGoJD1z
         5XcblKI3u38CQXa3Jks0LvUTUwHj/qmnfevuw08/fkFD1iCPVhNt8b7nhVGInx16yEI2
         88jaVK4+tdnnGaRhCjFrGwvpNvtcXNSmqkgdWwk1oRr/ksjJ2Z9CCp2HHdUYQH3MYS/G
         JKo22NJ9K+22URNhJWZirmmVwLgx5D+eKghRqnirXqd1zLT0aOULMTrhZToEi1Uttcv5
         E+aRVEyfTneBIyDwcUgw6yaRZ6CDWOHUrYhcs4wmlsL0nDDVdsHLjQmHYtSx9XE2Cah9
         AzFA==
X-Gm-Message-State: AOJu0YzB+r1RDcxP4rmPrQuyhYSNvK+9voyRipW+JuMKEBhbgeANgqq8
        mfgzlJp8k7v91UYOkH0vqmeKRk3FL1Nv31YqxlLTcfoyzgnf
X-Google-Smtp-Source: AGHT+IG6BRWUkk2Xgdw5Y5u1fvjiNqnAGM4BCsPGuuj8F0d1CjG69JFxybor2IxzWlk0HV3RHkoYu1DqOVLlIZSYBq25sasO6dDP
MIME-Version: 1.0
X-Received: by 2002:a05:6830:438b:b0:6d9:f752:1d25 with SMTP id
 s11-20020a056830438b00b006d9f7521d25mr201674otv.1.1702052704621; Fri, 08 Dec
 2023 08:25:04 -0800 (PST)
Date:   Fri, 08 Dec 2023 08:25:04 -0800
In-Reply-To: <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d91934060c020627@google.com>
Subject: Re: [syzbot] [efi] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com,
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

Reported-and-tested-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

Tested on:

commit:         ecbfc830 efivarfs: Move efivarfs list into superblock ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efivarfs-list-corruption-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=147a4fcae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62dd67b72f86455
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
