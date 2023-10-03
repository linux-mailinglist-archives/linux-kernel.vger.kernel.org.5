Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5787B6332
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbjJCIGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbjJCIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:06:41 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93850AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:06:38 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c64edaa361so725766a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696320398; x=1696925198;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3/2NqW9mmT03VqQNExZ1WshExaLoGoulxK0Isrbhfw=;
        b=bYMB/xeee8h6dq7IzwfPjlTWVF8EaoEGHQ+yXK3EWAAnw8H8v6mP/FFtWCWXwFeNpC
         uGrooJ409MmF1iDlpjgu5jtLzGMXGAGmBPkYyNysCSs5lBwREJaI5pNSlElR4O6hBQAR
         45c8uG8+JbhCet/BAMbXmfqhuRlNet8PdJxYf/VW7tAlqcCaX2o/FYNFmmCkzjmQG1BZ
         9ovD/fRXrwurFDqk6AAQVf4ZiWgM3IKJKx2IcMmfLILg+XKRnOx3GNRy0oZqFnm8bCPw
         lcDX69SrlJU04FzoMdR+watwZakHTV9pt2/d0bpIztmW3kd+etyL0Jfm9JSfEJAn094+
         Sz6Q==
X-Gm-Message-State: AOJu0Yzgl6xTiViMFOBIXNDlrVUhAyn0zFZoEPU12FpGFHOmmMXHA88U
        kN1yjhyTakAbQIseUQ63qjrHOl9kSMqUCyt6gKqDP5TKA+2P
X-Google-Smtp-Source: AGHT+IHvp7PrTwxGiy8U8miYCuYFgnGiIsw0EIZoLoqOGVXyX4sMUzTfWVSkKU/1qrUSX1Sdo4ECGlic4zPUSXnlRVMYOfZUCHDK
MIME-Version: 1.0
X-Received: by 2002:a9d:7c81:0:b0:6b7:3eba:59d3 with SMTP id
 q1-20020a9d7c81000000b006b73eba59d3mr4004601otn.6.1696320397970; Tue, 03 Oct
 2023 01:06:37 -0700 (PDT)
Date:   Tue, 03 Oct 2023 01:06:37 -0700
In-Reply-To: <CAOQ4uxhgWHoauPKUDfmuvu9uyMC23gkKVgi98R7XgX6s+fuh7w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf12400606cb5e6b@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_encode_real_fh
From:   syzbot <syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com

Tested on:

commit:         c7242a45 ovl: fix NULL pointer defer when encoding non..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11f4879e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=2208f82282740c1c8915
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
