Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3969E768320
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjG3BSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3BSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:18:21 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D99171F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:18:20 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56c7c54c25fso2888072eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690679899; x=1691284699;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZjtALMLSNw1lxd6Qk+pdcG3vT7SGnL7WdwedoqBaZY=;
        b=Rpf6FsbRGL7/HoduaThjJJO0mN9CCvLlKoNu6QO9s18cQg4b/0BcbYKn9PPW2ndYFZ
         dN/qO5A6aHTZB4JwnzOsE2aANUD9rBVHTk+8J0cDQPA9PXurq4LdVwsFcFzi4zh46sJv
         T0/S6Sx7QPp3Cmqz9HtfsUoFJfTG9ZIpnE10Zxkv/1UdmLD+jPMLsC60gT5oQNZ2X5k8
         xBiJZlODUR0EJMcp4PZMH4joQgv2X1DFplVdQnKqgsutdbAK/D7bKekoO6WKj9VO9/XQ
         WTlOHEBwcOIQh6PzjPK2bSGgbKmd6D0cpOfcHfyYhHkcBxMEkY7wI84RU3Zi7iSSWiLy
         GBIw==
X-Gm-Message-State: ABy/qLbNw8ITVHxLF7vV9lYoe0XYET0ugslkAMeBYVrLbX5LN+pjfECn
        77y3mnKGQOAEaf2/uz9vJQoit2MmXcZ8k5eB7QEb589ynp3I
X-Google-Smtp-Source: APBJJlFVng8FQlQRQgnBP5V2f+o93SAPea0s+LbHaol2urfHrEF9KXr+k99uILv30b0QZ/PAD+JQrktozHSENFQQ2Ktk537nvKNK
MIME-Version: 1.0
X-Received: by 2002:a05:6808:210e:b0:3a2:945e:874 with SMTP id
 r14-20020a056808210e00b003a2945e0874mr12203633oiw.1.1690679899645; Sat, 29
 Jul 2023 18:18:19 -0700 (PDT)
Date:   Sat, 29 Jul 2023 18:18:19 -0700
In-Reply-To: <20230730005526.1064-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8ec570601aa1636@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From:   syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com

Tested on:

commit:         3f01e9fe Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1208a829a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87ef4ae61b35aae1
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dbfef6a80000

Note: testing is done by a robot and is best-effort only.
