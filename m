Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E87E9107
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjKLNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKLNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:45:10 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335583862
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 05:45:06 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso3674008b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 05:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699796705; x=1700401505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWjilwy3ei2JMmBplrMuEmMSvPjKFecRGFZndim+p1Q=;
        b=nd/ovAZ2qhjCl0hwn2r6AhIAE6ppLhUqb2Kvccn6C2RND9LDT9c7GZMrw5AzpwDBIM
         YNUnkaxojbBnBipTfGv7Gyc8TD3wQM2Rr+JE4JNFwAgSB+6FDjEvFQeEpJS/JOJ7dx2E
         1ua39aYzQL1cO5+uu6zpcrkefdWsHl1VmTbeD6wXGZvTz3bD2Eu1PAMXkmg9fC9DMVOv
         rWSocyscSX8NZi9h/X4+1LIdUx/89b5Lc2MizY0e67SxWqU8vdRVMJjIFRDdVyXkH8zw
         we0g5tWuAEIjf/1uXJ3dGLcqT3TX4y85DOnLPgDT1o0UW+bKCLb2KkVtq1hTt4Ep6Iqd
         CiJQ==
X-Gm-Message-State: AOJu0YxZ+iRXsXDp66rWfVSTB6CFXjIXFgfSVIF6bnXEjHFE8KYHOuR1
        H5bEXMXk5uGiIu7mYtua6AiBWLPXeIxfKLvtTuIlzKsaeiUf
X-Google-Smtp-Source: AGHT+IHyQOou3WgvCQDwLJUWJwBTuQvumcew/x8XMghpHidvj+B/MwoXaAicooxZYrggZzAr6JfKKV7E7dpNzqa6Mwvt1ivdn1ST
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:6c8d:b0:692:c216:8830 with SMTP id
 jc13-20020a056a006c8d00b00692c2168830mr1712398pfb.0.1699796705645; Sun, 12
 Nov 2023 05:45:05 -0800 (PST)
Date:   Sun, 12 Nov 2023 05:45:05 -0800
In-Reply-To: <10dd4562-81bf-48c7-b2a2-42ea51ba8843@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d49a590609f4c28d@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com

Tested on:

commit:         25aa0beb Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c578a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ce93e0e80000

Note: testing is done by a robot and is best-effort only.
