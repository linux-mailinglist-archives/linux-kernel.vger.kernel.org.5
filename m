Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1F75AFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjGTN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGTN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:27:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0472D79
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:27:30 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-78362f574c9so33634639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689859635; x=1690464435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq7dHUeD+Xg/tMSj+YLwfJ2caZRXOmmvG1cR5ZPGm8A=;
        b=Tc135+5ZinqDRf/Bhdyx/BtYNsMQjvCJ5rASuyucyDEkD4ems4r4v2MtkPvRDDdYc2
         kCwti8V/HKVPBOW/SYaNJzwp4qMg49QcEhiXGgym+XP6rKo49mxMQ0bZVeAhbwGYwAnE
         h/FA8CNRySBf0XLwfjgIqTG+sbFnS4jc+2RGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859635; x=1690464435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq7dHUeD+Xg/tMSj+YLwfJ2caZRXOmmvG1cR5ZPGm8A=;
        b=e/Gzc6oNMdSYKn3KZNdYe46wxFnYV9bdQLXcbI9ak0sdeOoLsckeg9WmZblhL2XY+t
         E2oAQQ5/wTDAmcq1dNAHg0XiKDmCe5lEGkWwqBzagRY2WgwQfn9/GnX2B6lZKJ5ySeu7
         SZV/Nz5TS4huOZqKtXxm2uNOafd7l/C+n6ZnzlcNFim+k2CSb2Kk2v7aiJGJUFwiv93W
         zrfBw2BIA2AbKnrSCtuW2VAc36/rQWyNr4r4CZCHQfQ+ECV701JiCdt/h6H4LhmdM1Gc
         QwwXyWjIQXxDvWCZ4brGcVn8kR8N9TP+rUM5nwqjUPJbyI77EadwBXqm0n1yrrqJitvI
         49kg==
X-Gm-Message-State: ABy/qLbGLgikMMUuH5OmOeZft066TicV2VDbhjUbyC5X3MWUtmTgFSf4
        UcHa7kC8lrdl0KY6C/2YHWj5FA==
X-Google-Smtp-Source: APBJJlG2tTjykjLc6oXMJS1fb3KCcg1yffV1LWPPQqNtREvqQZsKQ/3ZLAWNKu6ZiV5N/eImx4cfJg==
X-Received: by 2002:a5e:a90b:0:b0:783:63ac:25cf with SMTP id c11-20020a5ea90b000000b0078363ac25cfmr8231109iod.7.1689859635559;
        Thu, 20 Jul 2023 06:27:15 -0700 (PDT)
Received: from localhost (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id n11-20020a6bf60b000000b00786ea00bdb5sm326933ioh.2.2023.07.20.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:27:14 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:27:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
Subject: [BUG] Re: Linux 6.4.4
Message-ID: <20230720132714.GA3726096@google.com>
References: <2023071940-suspect-ominous-4a6a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023071940-suspect-ominous-4a6a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:06:39PM +0200, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.4.4 kernel.
> 
> All users of the 6.4 kernel series must upgrade.
> 
> The updated 6.4.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

I have been consistently hitting the following splat with rcutorture's TREE03
test on 6.4.4. This happened with 6.4.4-rc3 as well.

Happens at:
		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)

So likely RCU boosting is failing:

The full TREE03 splat:
[   54.243588] ------------[ cut here ]------------
[   54.244547] rcu-torture: rcu_torture_boost started
[   54.247643] WARNING: CPU: 12 PID: 166 at kernel/rcu/rcutorture.c:2227 rcu_torture_stats_print+0x5b2/0x620
[   54.273082] Modules linked in:
[   54.278336] CPU: 12 PID: 166 Comm: rcu_torture_sta Not tainted 6.4.4-g62813c2d2a36 #1
[   54.288540] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
[   54.307525] Code: 00 00 48 8b 05 3f 6c 46 02 e9 4a fe ff ff 0f 0b e9 02 fd ff ff 0f 0b e9 09 fd ff ff 0f 0b e9 10 fd ff ff 0f 0b e9 17 fd ff ff <0f> 0b e9 1e fd ff ff 0f 0b e9 21 fd ff ff e8 0b 54 ff ff 84 c0 0f
[   54.331276] RSP: 0000:ffff9fef805efe08 EFLAGS: 00010202
[   54.338374] RAX: 0000000000000000 RBX: ffff9fef805efe88 RCX: 00000000ffffdfff
[   54.347738] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
[   54.358923] RBP: ffff9fef805efe30 R08: 00000000ffffdfff R09: 00000000ffffdfff
[   54.368209] R10: ffffffff94e59280 R11: ffffffff94e59280 R12: 0000000000000001
[   54.377367] R13: 0000000000000000 R14: 00000000000002fc R15: ffffffff93514000
[   54.386739] FS:  0000000000000000(0000) GS:ffff9c901f500000(0000) knlGS:0000000000000000
[   54.397130] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.404585] CR2: 0000000000000000 CR3: 000000000308e000 CR4: 00000000000006e0
[   54.413884] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.423118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.432192] Call Trace:
[   54.435634]  <TASK>
[   54.438512]  ? rcu_torture_stats_print+0x5b2/0x620
[   54.444904]  ? __warn+0x7c/0x130
[   54.449221]  ? rcu_torture_stats_print+0x5b2/0x620
[   54.455737]  ? report_bug+0x171/0x1a0
[   54.460935]  ? handle_bug+0x3c/0x70
[   54.465874]  ? exc_invalid_op+0x17/0x70
[   54.471336]  ? asm_exc_invalid_op+0x1a/0x20
[   54.477092]  ? __pfx_rcu_torture_stats+0x10/0x10
[   54.483472]  ? rcu_torture_stats_print+0x5b2/0x620
[   54.490029]  ? rcu_torture_stats_print+0x28a/0x620
[   54.496565]  ? finish_task_switch.isra.0+0x7e/0x240
[   54.503261]  rcu_torture_stats+0x25/0x70
[   54.508686]  kthread+0xe3/0x110
[   54.513141]  ? __pfx_kthread+0x10/0x10
[   54.518330]  ret_from_fork+0x2c/0x50
[   54.523356]  </TASK>
[   54.526500] ---[ end trace 0000000000000000 ]---

Also other issues in 6.4.4, I am seeing RCU failures with TREE07 about 40
minutes into the test. This warning indicates that an rcu_torture object from
the rcu_torture pool is still allocated which is an indiciation that RCU is
not working.

[ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9

However, if we are to believe the '9', it appears the object did made it
quite some till the end of the pipe array but not until the free pool.

The full TREE07 splat:
[ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
[ 2169.489413] WARNING: CPU: 4 PID: 130 at kernel/rcu/rcutorture.c:1584 rcu_torture_writer+0x7f2/0xd80
[ 2169.504064] Modules linked in:
[ 2169.508957] CPU: 4 PID: 130 Comm: rcu_torture_wri Not tainted 6.4.4-g62813c2d2a36 #2
[ 2169.521735] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2169.540908] RIP: 0010:rcu_torture_writer+0x7f2/0xd80
[ 2169.548542] Code: 15 8b 62 45 02 49 8d 45 e8 48 39 c2 74 bf e8 85 03 08 00 41 8b 55 f8 48 c7 c6 d0 f7 e0 9d 48 c7 c7 d7 7b 28 9e e8 ce 29 f7 ff <0f> 0b 8b 05 9a 48 45 02 85 c0 75 97 89 d8 87 05 8e 48 45 02 85 c0
[ 2169.578445] RSP: 0000:ffffa645804cfe20 EFLAGS: 00010282
[ 2169.586793] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000ffffdfff
[ 2169.598069] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000009ffb
[ 2169.609359] RBP: ffffa645804cff10 R08: 00000000ffffdfff R09: 00000000ffffdfff
[ 2169.620717] R10: ffffffff9e659220 R11: ffffffff9e659220 R12: 0000000000000017
[ 2169.631918] R13: ffffffff9f166b60 R14: 0000000000000000 R15: 0000000000000001
[ 2169.643365] FS:  0000000000000000(0000) GS:ffff8b3a5f300000(0000) knlGS:0000000000000000
[ 2169.655249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2169.663207] CR2: 0000000000000000 CR3: 000000001562e000 CR4: 00000000000006e0
[ 2169.672806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2169.682194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2169.693530] Call Trace:
[ 2169.698054]  <TASK>
[ 2169.701786]  ? rcu_torture_writer+0x7f2/0xd80
[ 2169.708853]  ? __warn+0x7c/0x120
[ 2169.714088]  ? rcu_torture_writer+0x7f2/0xd80
[ 2169.721066]  ? report_bug+0x15d/0x180
[ 2169.726125]  ? handle_bug+0x3c/0x70
[ 2169.730948]  ? exc_invalid_op+0x17/0x70
[ 2169.736238]  ? asm_exc_invalid_op+0x1a/0x20
[ 2169.742047]  ? rcu_torture_writer+0x7f2/0xd80
[ 2169.747907]  ? __pfx_rcu_torture_writer+0x10/0x10
[ 2169.754175]  kthread+0xcb/0xf0
[ 2169.758407]  ? __pfx_kthread+0x10/0x10
[ 2169.763501]  ret_from_fork+0x2c/0x50
[ 2169.768420]  </TASK>
[ 2169.771445] ---[ end trace 0000000000000000 ]---
[ 2169.777698] Dumping ftrace buffer:
[ 2169.782470]    (ftrace buffer empty)
[ 2169.787241] ------------[ cut here ]------------


I will continue to monitor and debug these but since I recently re-started
testing stable (my infra was down for a long time), I don't have any
reference for when these started happening.

thanks,

 - Joel

