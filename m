Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002E8064A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376613AbjLFBzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376530AbjLFBzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:55:00 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB7AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:55:06 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb28b4b7e2so522393fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701827706; x=1702432506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8dp83lM1IIJFurPSroopD5z21Bzz6Ac2go2PeL5p0k=;
        b=veNxeuniTppGJcblTqlxSkzbvRPcHu8UNE0bzEBG0/aAKu1m5sa+b5fSPn/dcuS0mJ
         Vc0yxOeHkBvP9Wy04HpbTmZAfQ/E66WJUfdA0N6aoWWwa+tDHA9dsyJq+O1tlCwjszBI
         dsQuSs/Z0gV1dyROq7z3POFIvnvfG8VNq4RGC/+DBoQJasnWF/7FT2XZDSUaa4cJBzbn
         4dbDWXdm/OdGv9lWDiD53KdJL42paht3z20/tqxLx72ZEUHYT7lrnPrLEy652sX5nOlM
         rKhEU9vIXfgzNqEvFmoruT6x79OFCneyM8l1rGfhBYZ48AuKdOxUYqW5CKLPa/oSdt1G
         9B8A==
X-Gm-Message-State: AOJu0Yw2HPxD7EVaGxjhQGSw70l6bENfizCEJuqHpzXK/FJW3GRCayvi
        2QmAqEncAEnPvs6sXJBJ8t20+EvYD8EE86+sx+idmaMVdiBw
X-Google-Smtp-Source: AGHT+IHXSVqLR5xneNM87qvNNflHTgenWtCQHtof7NfsG0TfyM17gKkLCv/arSK3qx5LI38TzXhN340VIA5bOKWA+IDckfIm/W0+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:808a:b0:1fb:2a24:f0a9 with SMTP id
 q10-20020a056870808a00b001fb2a24f0a9mr183754oab.1.1701827706267; Tue, 05 Dec
 2023 17:55:06 -0800 (PST)
Date:   Tue, 05 Dec 2023 17:55:06 -0800
In-Reply-To: <tencent_8F9E041BAF4BC41B1C2558BA38BBE233E808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6adfb060bcda391@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com

Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b6743ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141ceb9ae80000

Note: testing is done by a robot and is best-effort only.
