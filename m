Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B978BE06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjH2FtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjH2Fs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:48:29 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A70EB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:48:27 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55bf2bf1cdeso3963810a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288107; x=1693892907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gwEIF2EmigB3vu2yGt1sEg0o0eTe5yv5EvUUhaGJTs=;
        b=DIQ15e/h2MRb7FyMWHoTZXy8v9nRB3ib8aZBc9B61UyqQ5sQoSF+q/YAxMX6ybwKYt
         Lxzf4sqvLK2URiCM2+oCTg16WUQOuruR7Pm1yltIkFFxYuqqD/CWdsWhdqhFsNOoL56S
         KsaVlxBT/etRKSjlgii4rtLHh1FOHb37i9zOa14cSL/YCypKOMnKOMXRHvmi+PQzaLP0
         KkOUFAZp7CpEADsCCv9UNnuryQ98TB3zFTwIiPjtT180wTwBe6onzH43Msksc0Bxc1+f
         a2xTaEgnm8U+kbb8RhmW6A6EMvkdXl+WtacAPBpZ7/FiIFmJJhHdZ5v9masD2442Fgdd
         eTbg==
X-Gm-Message-State: AOJu0YxawDqUXcXt0sk2sHv8bU7ueaev4WmxNePbmXxhsYck2lpNGpab
        DzrxxxbvXmOURjeq10lbkuLBswu/xDDbdxTrcHbLq7M06Kd8
X-Google-Smtp-Source: AGHT+IEyqAvfV7+QogzHzJ04lPFfb4sKg6crf0Qo+J0LZKobRJxS5DVzddjFuI8uliMGL0D2PdYxSfV2ksQSGEoRaf2CCeLHaqFN
MIME-Version: 1.0
X-Received: by 2002:a63:36cb:0:b0:56c:3775:708 with SMTP id
 d194-20020a6336cb000000b0056c37750708mr4501181pga.7.1693288107160; Mon, 28
 Aug 2023 22:48:27 -0700 (PDT)
Date:   Mon, 28 Aug 2023 22:48:27 -0700
In-Reply-To: <20230829050825.4177-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000213bd70604095cd7@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: use-after-free Read in btrfs_test_super
From:   syzbot <syzbot+65bb53688b6052f09c28@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+65bb53688b6052f09c28@syzkaller.appspotmail.com

Tested on:

commit:         2ee82481 Add linux-next specific files for 20230828
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=177c0650680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb53688b6052f09c28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d70c13a80000

Note: testing is done by a robot and is best-effort only.
