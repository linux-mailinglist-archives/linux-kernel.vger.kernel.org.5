Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FAB7DA6C9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJ1L5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1L5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:57:07 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910FE5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:57:04 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ce37a2b2e9so3955612a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698494223; x=1699099023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55/ZxQ7vXJOzYxzPAaT5BWQfrBnwnhAvHjCxioTWPX0=;
        b=LDkzXmXKs24Apy4K9Q1Z1mTqlvyTLKyNIAD2VenawkNpTWSYgiYbAI7OdbdPqmIPOU
         qFj3IvwQrh8QF+s+gxX74oDQCrBVcuHnTIy8ToBzLTSjbVcBbq70saaqI0RwB0eqj2c+
         2jIJ3wG9rsM5Atz2bopPeGxITljW8R7LbF6XzMf2bZDsLQTZEe8Sde7u+Hfbgthi9V7i
         wfQeplVZPstW8dmmtG4ikIwr/WAqhuUK6MBhp747LZ8DB9jia6GZQSn6crcE53Ny/g+K
         DUrVTPfJD0lRN0wYtHQT5/W6RmpKpEm/KO6fPTbgatavWDcXsJhBH04W+qoksluc8ool
         77fA==
X-Gm-Message-State: AOJu0Yw/CFkq7WRCbcE5qvVP0wHScgkWCQUl0xTZEpkmILsAiIKw1t2C
        Cfy1960gUmmCy0cDriIsQTBuciAuFibXUBYzxX3q9+QLs+XG
X-Google-Smtp-Source: AGHT+IHdc3niqkJvCSD73NvwzfvitOGJnYpdUsLk4MxSZ2kD8DUPKy0dq6nfemd6WTJW1f9q//rDvJafPwqz0gjsyd4tfkkbIxBu
MIME-Version: 1.0
X-Received: by 2002:a05:6830:336f:b0:6bd:c20:4215 with SMTP id
 l47-20020a056830336f00b006bd0c204215mr1318421ott.7.1698494223751; Sat, 28 Oct
 2023 04:57:03 -0700 (PDT)
Date:   Sat, 28 Oct 2023 04:57:03 -0700
In-Reply-To: <20231028113238.1092-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc201f0608c580ed@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Tested on:

commit:         20305791 Add linux-next specific files for 20231020
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1751ca8d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37404d76b3c8840e
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121ad9eb680000

Note: testing is done by a robot and is best-effort only.
