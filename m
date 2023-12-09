Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD180B392
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjLIKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:19:57 -0500
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F012E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:20:03 -0800 (PST)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58d76712504so3157242eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 02:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702117203; x=1702722003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzTKkayoaN26UAkjoOlMDL5VfK6M0KZqgpnzmdfUgck=;
        b=sbdg8J2u8miqRlktkawFp5WImxCO1frIdaLSivWTswhOK5kd6AEYd4YtI+3GupE+o1
         44aVdlf6Jzt3wQtHgaKf53ZB4Kx8XeA3Pgr/jTC7UZCKsF16CJzAo72a6enIm5OAQRhL
         RkMqm8XmeqoLE/wWMDaEpwDEUthV+ZVXOaf637D6yU77bFEHKebmVj5PYvqc/U8uu/6J
         Ao1EAB5PHcs7SpCYHRqS1RTYVpdQYEVEtNm07cPfuifQ6a9jiEtvC6Yt5NZU5sWXTFqq
         99H6jOEsFxrb+cEtYkTn4zvVWc6wcViUL5ln6H6fYbch35ZrN5R2ZorocP3fUlNFlq5f
         WaXA==
X-Gm-Message-State: AOJu0Yz/vBDEO1yn3nmQj+53ppH/rrrbAdfMt1JfqVw4xo1SUIC7viO3
        Wgo58ADjd7OkzxqzzDlW9PIjRf03tZ4zpr9+VLRnMZK+ByE5
X-Google-Smtp-Source: AGHT+IEk926lM5pj/9LbooEoD3qXdZbKj4Vj79uN+R/s5Tnixbsp0bpX7U6paOZtjG/0nJtrWkQ9ZXqn7OCoT5Sag8emrp72f4kV
MIME-Version: 1.0
X-Received: by 2002:a4a:dfba:0:b0:590:8aa7:1e1c with SMTP id
 k26-20020a4adfba000000b005908aa71e1cmr739667ook.1.1702117202886; Sat, 09 Dec
 2023 02:20:02 -0800 (PST)
Date:   Sat, 09 Dec 2023 02:20:02 -0800
In-Reply-To: <f8bda66b-bb17-4bf8-b97a-4f7f0788d28f@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e8971060c110bcc@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         f2e8a57e Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=117f5cf4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a0b898611ad691
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134888b6e80000

Note: testing is done by a robot and is best-effort only.
