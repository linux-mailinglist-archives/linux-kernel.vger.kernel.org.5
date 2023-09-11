Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0301279B305
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376926AbjIKWUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbjIKOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:00:49 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62849CE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:00:45 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68fab681787so1922588b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440845; x=1695045645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFiDW2aCYU77+LIKle/1kqcetQN/ZqCuM0NDsZJWUyw=;
        b=cP09znnP6AY71ZOvT+dFzn65wWGFdyp0Oz/qkFytOTKjWVJztXSbq0i9EjERP7UStV
         Iwfmy8a68negJRvByC5muQroWiGd2+tlPS0f5VAM0S8vhsq2kCfRWf5krLzGZAezooEf
         Mt0kur/iMcSaFwpaxc93GMFkiJQtibyvuD1Hb76BxVJD9niexcJMAxOeKDwSwgritLcP
         CPcSS7NG8mHlTR/0ieyMzmfhxdZeD4ZM8tzF8l/yjT34OOIZxYZf0FDvFNDyrux+vE30
         UAfKYRc/ap9FNKkPNAh83JKqBzWQZTgfVZHBnKH5YxWGVC4xxy31dY9mTtgLzjXnPEXt
         a24Q==
X-Gm-Message-State: AOJu0Yynv3iZfOBxZ0RP52M0EvJq0oEwMkJDPwQLqRDmxDv9f2W7aUaJ
        HONpb3bQt/ZH48H/5R/dV1IeylmCv05rf/XqB4lqE1gLZbNJ
X-Google-Smtp-Source: AGHT+IGWQcvpB78iifcH6GxbTdtiBeBJmYQH2DiGxCiGKJB6IMfGBySo3SCj5ZUhJPpeLKPn4RxXPUzmVUvDOZ0eOrvaaCpdDlLr
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:4217:b0:68f:cb69:8e7a with SMTP id
 cd23-20020a056a00421700b0068fcb698e7amr610980pfb.1.1694440844961; Mon, 11 Sep
 2023 07:00:44 -0700 (PDT)
Date:   Mon, 11 Sep 2023 07:00:44 -0700
In-Reply-To: <ZP8VcUIXTjvR3z54@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a82de0060515c033@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
From:   syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fengwei.yin@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

Reported-and-tested-by: syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com

Tested on:

commit:         0bb80ecc Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1010b50c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f2a37749f07ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc72f8cc3a549119df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155d6578680000

Note: testing is done by a robot and is best-effort only.
