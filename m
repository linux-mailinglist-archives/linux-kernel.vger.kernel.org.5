Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3A776A87
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjHIUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHIUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:49:26 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A46100
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:49:25 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-686c06b9338so233153b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614165; x=1692218965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiO1UYKz1KmGz5vyEYa20p8Kf9nv4M/wBjQ77gRnteM=;
        b=UX/ffT0j/7rQ7ZgDCPdHbNUQ6FRGEhdcYyZp0xGvZihwPUBPvgUINKuQjFKmXjD2UW
         fr5FWnvkpYyNlWlO0Pykas68s1IT57kMCv4/VG9p7F4yeFaWeVVyfQ7jrrlWNbp5a0QQ
         GaoFXdHI3KKgy6xBxajRmI+3Ly1EMQw+1QUZPMnelc1wR9X/Tn+dxM8Oi0IGzVt+OOGY
         qgcZSuScbADKXzq3Sz9x44pcnG2SQlY0RQ1sPY+/DNyjUkTfPYb6qCdau4dJYVa6UtLV
         IwPv+QgbpDAsVt/1NMSykSyWgX6N+9RS2lalFBicsDzH88RJEtiON5du6rfP18kugtRK
         nyhg==
X-Gm-Message-State: AOJu0YzJlt/rb/e0hXhEIuYrHRLAsdJfeSiPtdPKUxxAcAl/A7P1Rbg7
        EyGo2o1/p2cy9cq+QYnlLtLfL5vvb8vm2X/U9tIRyB+AnFu/
X-Google-Smtp-Source: AGHT+IHM/PSrbeg1ZRWPQCHIWQxkAXmB84lw1plRrMW/1JwBCTdX+F8fk/Cvw8TeA/TVHtTefHpEhpbCSsRcdC5cgVKcXAmvAm1x
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:c8a:b0:677:7731:5edd with SMTP id
 a10-20020a056a000c8a00b0067777315eddmr162506pfv.0.1691614165376; Wed, 09 Aug
 2023 13:49:25 -0700 (PDT)
Date:   Wed, 09 Aug 2023 13:49:25 -0700
In-Reply-To: <20230809191118.30721-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ca4a20602839deb@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in hdr_find_e (2)
From:   syzbot <syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, astrajoan@yahoo.com,
        ivan.orlov0322@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com

Tested on:

commit:         cacc6e22 tpm: Add a helper for checking hwrng enabled
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1107f5a5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=60cf892fc31d1f4358fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e4f5fda80000

Note: testing is done by a robot and is best-effort only.
