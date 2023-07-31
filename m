Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9B769369
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGaKse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjGaKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:48:32 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF40E6C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:31 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5a7e981ddso7752852b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800511; x=1691405311;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky/sP830eWJV50H3z/4LZ5uLKudZ70Qr3x68OTtWejU=;
        b=M7E8LC+fEP+kD1gs8fGaBXqUr1rUkF9CVLgqFCZND2sLJGsNy/wQfFYdM6Zuv+il1h
         PtTKyvIMbjBIoRfLpysLwhGT0u2UwO/m3d8FJL8aZjaLPcdQuX8w1POCKUrgkhIYDoYk
         a3yLGAz3M4uP2RTjQciAoHVu/7DAzd08rKayDd1bL7S/tYKDIkOso8ngJuH/mTw9+LO8
         bJqEMpgQNSlisyiwBO39i30ZY8SCs66pYGoewY3jlm97Y1o6bDXtKzm0TFRMbzsf0Z5u
         +tkedqBsTWw7TPORMTxutrknihdLCuCYtH76j9YUtt5G7PFU9udEc2u/7C6Nu1Bdfpxq
         +G0A==
X-Gm-Message-State: ABy/qLbT1L5Lq1SCJEbM/A/oykAmc4ThJkP8bJeg5mveU59m9tT+iyE0
        LGdbEJgRmh1fYTUY/oGfryHuwOE5sY9IFd3JnfMnWk3JanGP
X-Google-Smtp-Source: APBJJlGs/4Zt3Z2NNEN7HrPlMpmsw+x0J0dBk4XKuVn2Y2taql2V5+mTt5CoFSD1N0qiUlbPBbLRdz2s9KPuE6c3Sk0+gEbQSzWg
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3014:b0:3a7:cc:8447 with SMTP id
 ay20-20020a056808301400b003a700cc8447mr14866547oib.3.1690800510995; Mon, 31
 Jul 2023 03:48:30 -0700 (PDT)
Date:   Mon, 31 Jul 2023 03:48:30 -0700
In-Reply-To: <20230731102250.1389-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8144b0601c62bd7@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref
 (2)
From:   syzbot <syzbot+6699abaff302165de416@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6699abaff302165de416@syzkaller.appspotmail.com

Tested on:

commit:         0ba5d072 Add linux-next specific files for 20230726
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11a7fef6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33fb77ef67a25e1
dashboard link: https://syzkaller.appspot.com/bug?extid=6699abaff302165de416
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d639dea80000

Note: testing is done by a robot and is best-effort only.
