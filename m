Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6BD7F466B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbjKVMkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjKVMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:40:09 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5619D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:40:06 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ce5bad4515so81045555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656805; x=1701261605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqi9O7B5mFpoyfW4PBZ5Xbrxf66jlfmb2InamS+hwLE=;
        b=V3G1JQphII1aprR7tFgee4qHJSgD6LexbSLeOImXSktMa0HT/qSVo16Oy3XpnP12Tn
         0VVWmpla0VI4qx1p5juQbY9TlcKzl0piDBnHPuDOvqHZSqvFRo6BAzuD9sYGtRH9w6wj
         +dV3UASLm3UuGxcGis1aDbuUQprqEeVTIEk+wj0duEAz/NEPmUUX3NkZCrwGEyfkt6QK
         fSHiQ4I8doYbNm0iNTH3BGuxpMLqhzJfpvECefeLg/gD5JfukAIjtByz3KTcl+sOKGTP
         II2p36gzCmQTPQKI/q5p4PfXZrOSnhjStkaVWGuRY85TVgl8jKm1IOlOsqYHWfe5Y92x
         thQQ==
X-Gm-Message-State: AOJu0YyoL0fFUZjNm2zYf+4YyyyVgr1PubTEgVrytygkeOuTun1BOZig
        RnxzQ+2JimbU4cznioZbUOtuJCZqvCkTTkun7RIjVzC87dyr
X-Google-Smtp-Source: AGHT+IFLIf6SW90mlMrjJaQQbGB7AkakKTC68Qcqc3Yr7elJ0H/vjvneYcdQsou1/PD+HLPrT2h43xt/dB9Rh9r/6MaRPRIwgS7x
MIME-Version: 1.0
X-Received: by 2002:a17:902:eb42:b0:1cc:37d1:905d with SMTP id
 i2-20020a170902eb4200b001cc37d1905dmr477853pli.11.1700656805744; Wed, 22 Nov
 2023 04:40:05 -0800 (PST)
Date:   Wed, 22 Nov 2023 04:40:05 -0800
In-Reply-To: <46b0a2d8-aca2-47ed-9767-365f001fd6d9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca9a0e060abd04d7@google.com>
Subject: Re: [syzbot] [input?] WARNING in bcm5974_start_traffic/usb_submit_urb
From:   syzbot <syzbot+348331f63b034f89b622@syzkaller.appspotmail.com>
To:     javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com

Tested on:

commit:         c2d5304e Merge tag 'platform-drivers-x86-v6.7-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da4b14e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=216dd1782e9f27d4
dashboard link: https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1074c0d8e80000

Note: testing is done by a robot and is best-effort only.
