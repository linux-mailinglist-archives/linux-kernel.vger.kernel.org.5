Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC82E759C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGSRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGSRL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:11:29 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266610CB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:11:28 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a3df1e1f38so12056390b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786687; x=1692378687;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiK3UAz0+c77ryW/gb9cMTyS6vAEJ/XrFX6N9k9mOJQ=;
        b=BTno8eItKMtqE+gR/Zyhn6ESXETmRrsrfwqVfwv4CGKlrxZwzKsGpo2Qni+nwC9m/l
         6PIMRRLnV52fzIitURKeiP8ygt8wYGKhrdHXCQgWWCOjDID+WNzt+kx2lfhoBYM2n+ta
         mmQEN9Q/4XT730/zMAPqdrcvrBH3NB/VTkXRxu05D1wZNAuviHpfjz1WokFui2eA0Awt
         D/0a48dJJR/v3IMzAjm2Pt0Gyr96BtESSMZ4sX093hZhLuzq51W6rs5rOLbrdJ5TIqB8
         7Ahzl8wHjTNCpYjCa9+BE1F5zckMI+pGLY2zdkOY3P5f7/NxTlwyxOYS7b46spGLbj/D
         yUsQ==
X-Gm-Message-State: ABy/qLZKMbX1hRqDWWwoX1ikwUyRWKWusLQHJ8zOYk9MtMFUGoNRy+yH
        i5VNk/aDQSmYRtpBoN4BZF4Oo0sczkUxsG0Ah0Ryw/Ogk2F2
X-Google-Smtp-Source: APBJJlGqZ3iWxxXhT33LNAjfh+QREvkhQDEruriIX1JMirS2inBiRbWmSWpri4JcCeIQNkkHGF5KNA+oUFrsArjTbOfZC6ur6PVu
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15aa:b0:3a4:48e1:3116 with SMTP id
 t42-20020a05680815aa00b003a448e13116mr12661379oiw.0.1689786687593; Wed, 19
 Jul 2023 10:11:27 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:11:27 -0700
In-Reply-To: <20230719170446.GR20457@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042a3ac0600da1f69@google.com>
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
 low! (2)
From:   syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>
To:     dsterba@suse.cz
Cc:     bakmitopiacibubur@boga.indosterling.com, clm@fb.com,
        davem@davemloft.net, dsahern@kernel.org, dsterba@suse.com,
        dsterba@suse.cz, fw@strlen.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, josef@toxicpanda.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jul 19, 2023 at 02:32:51AM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15d92aaaa80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b2d66a80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214348aa80000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz
>
> #syz unset btrfs

The following labels did not exist: btrfs

>
> The MAX_LOCKDEP_CHAIN_HLOCKS bugs/warnings can be worked around by
> configuration, otherwise are considered invalid. This report has also
> 'netfilter' label so I'm not closing it right away.
