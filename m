Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2778BD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjH2DlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjH2DlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:41:05 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00135110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:41:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VqpwQ-e_1693280457;
Received: from 30.97.48.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqpwQ-e_1693280457)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 11:40:58 +0800
Message-ID: <e318cb75-510e-6cec-d35d-f29d920468f7@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 11:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
To:     syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        brauner@kernel.org, hch@lst.de, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f43cab0601c3c902@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000f43cab0601c3c902@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/31 15:57, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13018b26a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
> dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b490c5a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139a9c7ea80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5efa5e68267f/disk-d7b3af5a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b1f5d3e10263/vmlinux-d7b3af5a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/57cab469d186/bzImage-d7b3af5a.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2cf2189f623b/mount_0.gz

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
