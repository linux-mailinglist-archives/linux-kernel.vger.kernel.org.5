Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BDC78BDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjH2Fd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjH2Fcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:32:54 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE63109
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vqq90M._1693287151;
Received: from 30.25.201.82(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqq90M._1693287151)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 13:32:33 +0800
Message-ID: <f95551ca-6785-3d3b-18e4-9846323b1d87@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 13:32:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [syzbot] [erofs?] WARNING in erofs_kill_sb
To:     syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        brauner@kernel.org, hch@lst.de, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e5e02b0604080b49@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000e5e02b0604080b49@google.com>
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



On 2023/8/29 12:14, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14f819dfa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9678e210dd5e4a5f
> dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

#syz invalid

since commit 4da3c7183e18 ("erofs: drop unnecessary WARN_ON() in
erofs_kill_sb()") merged ahead of

fs: open block device after superblock creation

so this issue only existed in some previous -next versions.
This report doesn't impact anything upstream.

Thanks,
Gao Xiang
