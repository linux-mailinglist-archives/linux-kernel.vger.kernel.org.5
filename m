Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06777AEB95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjIZLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZLie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:38:34 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED071DD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:38:27 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ab724f59deso20291442b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695728306; x=1696333106;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqjNUjbgQBaxA/bGT6Fak4CThLgwy73xP0IragFb2gA=;
        b=Za0jxRSfEb8PqCFAvqyKIEiLCOf7bbYyp9YW6rddouqUV95S5XouPnDUA35gWbsON9
         oUnZNETMV5EEPinDhoYRyHXs0y08gJrAgjB5NS6GNOewuBjjaPJvPeEeqLa4ghILSGI/
         A1dIdYJVUZbytRSAvGnQiYQRifQHqgE+L+s3a1rkB6vmkvnXmhQbN1EexRR+rDEKPYc5
         BofuNstO0O/XTP/bB2upwFxAnGAbiPI2lOt+eZ6G1m7WBxiz3Nae/ZMJIDFreXgRCkW/
         QdWukEoiwUo4MHe5nUaXaNWfu87NsvjH34dVy8LJ8CCrKrxE5MnuZ8fs+WMUdUMS0gq9
         ScCA==
X-Gm-Message-State: AOJu0Yz5aR9KLt7l3VDC4L92uFHJirlzig8Cf7rcBh5/sZLWpA9AExFh
        jGAGmieBW6lnjiTEQdoXmnXbcIxxX3C0ELN9J3NjDow+05G6
X-Google-Smtp-Source: AGHT+IGXJyU771Or6X2tbErfFhv9nDNWeOw0Zh0a3eogulbG8i/8+5CCrBKH07+YEinIJWo1qY8oUbbOvEBBd6Yi/jQHUYnwFHkq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a2:b0:3ae:2024:837d with SMTP id
 bj34-20020a05680819a200b003ae2024837dmr5307655oib.8.1695728306757; Tue, 26
 Sep 2023 04:38:26 -0700 (PDT)
Date:   Tue, 26 Sep 2023 04:38:26 -0700
In-Reply-To: <20230926111348.1208-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c26700606418357@google.com>
Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+893c55305230e719a203@syzkaller.appspotmail.com

Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11c6d11e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50b6fcb179f758ed
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dd0012680000

Note: testing is done by a robot and is best-effort only.
