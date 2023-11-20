Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CD7F15EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjKTOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjKTOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:41:09 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55372129
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:41:06 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso5404360b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491266; x=1701096066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tjUJp8Sg3kWvTzD1jq9goTlaYE3WNeIcHkxWrBMoQg=;
        b=ki1lBKmmJlzdcBrbWuY3lN/TxjomfcqdRRIlaGeXMr/PvN8SJDwx3N0T0/U+u/upSI
         lan4jauEGOAwBT6Me76RAIL5WGUw9bw4Fx3ft/PdqQlc9LW62MI/UuM7fmhB6KBUTF6X
         S8EJE92J/SJZqml1xKG4qm9oWifT1hYYP26AL8KgGyWtCd2gHvga5yr8JDLHuAPRLRfZ
         eG3fTflD0Gqq2Xi4sAiiGcHWEg32E0zHkAEGkBuECul+K6HyiQ6S586RsXMyJma8lGJE
         nbESAsxeHfpfBpfNz9tFL6cd/8sHqNdiYMu3zb/8svnIZ1syxkLODU0fZabuHkHJMWl4
         eluw==
X-Gm-Message-State: AOJu0Yz9pEyYAFI7XCjut+ahpVrHk/ujideXnfcZd1HpekBNK/2w2/dm
        t/FyMXObqulx7PGWghglpFUDzfm1ilWSL59Lt/jZAzvBx/Tx
X-Google-Smtp-Source: AGHT+IHjI7Sji/1Ilye1YKw9iuTKxtkwfk+Any89TgCtFSmDj1JrgFypRe4LFIeoUpxdeEfjhSusl8JJjW61vbcQtd59GY8FYswX
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:9a1:b0:6cb:8c38:98fe with SMTP id
 u33-20020a056a0009a100b006cb8c3898femr1300199pfg.1.1700491265867; Mon, 20 Nov
 2023 06:41:05 -0800 (PST)
Date:   Mon, 20 Nov 2023 06:41:05 -0800
In-Reply-To: <tencent_ED66D63C7D36FA97CA372E4AFA744777FB09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8938b060a967907@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com

Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134d89b8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150dd4af680000

Note: testing is done by a robot and is best-effort only.
