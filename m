Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAB75FD09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGXRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGXRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:20:47 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F9E76
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:46 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a1e6022b60so10322311b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219245; x=1690824045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jjikWmr9FsKFO5O1AtxhVTUjXG2I5Qke3uz5AVbRGY=;
        b=Hc7ozrD0jwxUpshPvPz+wFu20oefFvW/YBBeSQg8sKTIztkCqt8q3fUPmZTON9mDhQ
         v5dCBeIkaF7qhmD+FMJhR+eNyuIRj9I8DCsfkmEH0lHzE/jKtuMgJ3POoRg0a6anQjqd
         CVcSoQ5NpAmeKPgrnAEa7NHfE91jxYwzzOtTLHzmr8YvzushWJPqwchgxg2rWyY5EC0n
         RWhXOsFlXgUFfPf5L2X4weAAhYsV20QspPcN5AFIl3OZLlA2Cq0YwwwjBouawcIQOCYA
         K4g7R4STsk+oH6LBf/TRi/hwTKRfqY3xK1EktLtu0QuzC0TFLcxoDpsuaYDx1scP0LX6
         k3oQ==
X-Gm-Message-State: ABy/qLYMqMg2Zw14c4yHs0ulupTl4/EasSoJboG7Yb96RlRfXVlEiAv3
        6TX2YJ6q1kLXVm/L1qpiKoNkRZNnvRnHEqNpcBfI2s2Ixi/+
X-Google-Smtp-Source: APBJJlGNrlcAkikspfqaXegtQje/gdLFHH41Sfqg3J9deU/xIOfiC7rK5IxmHznQSyVncseLGB9s/gSmn2HTbokqPrRS8hoXjQMs
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2019:b0:3a4:2943:8f7 with SMTP id
 q25-20020a056808201900b003a4294308f7mr20378188oiw.5.1690219245817; Mon, 24
 Jul 2023 10:20:45 -0700 (PDT)
Date:   Mon, 24 Jul 2023 10:20:45 -0700
In-Reply-To: <13125.1690215929@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd577706013ed580@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From:   syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com

Tested on:

commit:         0b7ec177 crypto: algif_hash - Fix race between MORE an..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157554a1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bccf8d7311b80058
dashboard link: https://syzkaller.appspot.com/bug?extid=6f66f3e78821b0fff882
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
