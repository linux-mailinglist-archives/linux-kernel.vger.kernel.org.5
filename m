Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C27F8E23
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjKYTo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:44:58 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7CB3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:45:04 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b38b3e433dso66283739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941504; x=1701546304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zFOfzzm7+x12sXeVeQwqDu3dzGCDPPPB+fZft3ol3s=;
        b=hxDg0qDttlZDCNUdlvIzSAgZ0mxrMXa4FzI30MFFJr2V6QwfeUUvM46N5ur7XXtUcl
         h+pFNBQZ3do3unXaPWXg8cgM8hAVYpj+qfbupDoNe+/MeDFbwlZjCjQPXHzbQwWbX1dc
         JAKfyFnLypuiFLOer+/sIf4JERWh3BbEcuN4hJMsCgmf8NTUU1YJlKXEXo8Z87ZKpb3d
         9mhbFLrwb5XMjIXrNTgz/8XEPPOl8NHCIs6ntOSUT1p/v4JbwQsv8HGTY4Ii+8bj/bKf
         YwSAnZ9WR81IDZE+TxjEZtzrmRCyrlV2lhuueqqTQFbOzn+Mebo/6W9syK29UTS4sjsX
         3Lww==
X-Gm-Message-State: AOJu0YwJogBL2RwCnVpY6RZTpeaP9ouxU66/TDIlUBQuLxjLpiD1qT91
        QBmOfcz3CGxMDHszb+llEfOf3FLJbyy6RKZxN3XJ9mo1tJJw
X-Google-Smtp-Source: AGHT+IGy/jille76tRuHatrHMaPg0FZSslMdhHqT9yNBrbiA2KEi3FhpZSL3dovGyPgee+Yiv11zFDwqux9IItC/LYzdXYPE19or
MIME-Version: 1.0
X-Received: by 2002:a5e:9919:0:b0:792:f7c:b139 with SMTP id
 t25-20020a5e9919000000b007920f7cb139mr339557ioj.1.1700941504253; Sat, 25 Nov
 2023 11:45:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 11:45:04 -0800
In-Reply-To: <18c07e01a4c.220c832d175971.1254981088507972317@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002518c5060aff4e27@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

commit:         8872a44d lock
git tree:       https://github.com/siddhpant/linux.git lock
console output: https://syzkaller.appspot.com/x/log.txt?x=168d9a08e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
