Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8964A8096EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjLHAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjLHAGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:06:11 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAE71BC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:06:16 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d9aafe6575so2008115a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993975; x=1702598775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=fGBWbOpFQa9apKm5Ln8ttOBVkzh+3DT2HFNBpkVctI5lmoWNrgPeyB5ic7TJZEAB0k
         sPFgHqeFC10Tn54hK6/z/mj6cpI6XTv5ixuugpqdldtUumGqhAQ9LZE/Kv9+F40WFblG
         H5YjTSuidRDJW6IeGLzIjoWKyYJMlCisC+D1HuOUuS+oB6zaw1/5GEZqhZoUDeax2N3B
         JbuNhm3zAcnuQGyrmDHVV/uUp3XehrBVnhhxyoktjVLNoPSvsdMaPOkMSoaKNtV2SJn7
         m7yG5OzPN95WnMs5yCPCteQtasoJDHUK0ASzJIkB2CH/f20Fi5kNZWgoK+EAqxVN0oHv
         bMLw==
X-Gm-Message-State: AOJu0Yy92YG0yvGxnkxpUZuHv9PW3Scxt4n+6TOVNP7aBgZ+/tNb3W6H
        xU/LE8fNLJ9YcGyEGE+333upAKNqD0A5L3TmrOR2SjE5+CJF
X-Google-Smtp-Source: AGHT+IGWxJ5jW+luuxEuFZEbdM0vgHtDD5vlSaULaFryrlciMSxtVxHr6p4K1syh1eOgtuEsqIoGvQAA/sWnkA5DO2Ja+joiDA1J
MIME-Version: 1.0
X-Received: by 2002:a9d:6015:0:b0:6d9:da80:7f38 with SMTP id
 h21-20020a9d6015000000b006d9da807f38mr1315510otj.5.1701993975545; Thu, 07 Dec
 2023 16:06:15 -0800 (PST)
Date:   Thu, 07 Dec 2023 16:06:15 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000528587060bf45af6@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
