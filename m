Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048F87D2391
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJVP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:27:07 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C618E
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1697988421; x=1698593221; i=jwollrath@web.de;
        bh=ntqPbE4vDZPQlbrCHL9ur/ZKLtznoTm3xj0azKoAzGA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=OhZVHEGS22w0Rh/AydGJfbnUNHU7UzPL/zE/+LqRN7TE+4XYNIZ/JdeDibJMXhRq
         8SDqVf4VWOsgdPvdocpA0+iY1oLXDJICYHe1u8V1lZpu3GYAHu5DE1kj5r06zzx2O
         K3Zopl9Uk2nF9OWV20qZAhwUL1Qf4iquoGPnm25L6SDxDrYYbDa5Zi4xDqzqpWZ0r
         /tBXcDBU8IcobHPuGIV9mAIqdmt3Ujyk28XHQ4+QiuSf9MZLxvqoD5WAllrMz+zSP
         elSCxG2Kxw/1sUrbLFtbS8Ftg9i/m1hVGEGqhLtz79nGzKQhU3ojV/x1dIdAE+8Jj
         J90Cc7Do5GyMsvDIeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mayene ([178.196.174.8]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuKH-1rD40m331R-00KvLP for
 <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 17:27:01 +0200
Date:   Sun, 22 Oct 2023 17:27:00 +0200
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-kernel@vger.kernel.org
Subject: Oops with v6.6-rc6+
Message-ID: <20231022172700.48c515cf@mayene>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NYfe7hsqnN6CfEHSKc/plLkAIMVY5KF2pG891oDJquNLuqZuGAm
 IndTaye0RXv4TksiSA7L2pBdtJUkLMIVubtzPxvHWd3hFY6JVhKPpWzF1ETNIJAgcamv5yk
 A5ItT/wa1r+rKzI8HyuR7pv6vhl+wWSHrjdcMyrAehGZW1NwVeoI5oHqH57QPxceB3LpBV7
 3bNgWXM4ir72B6Q9d7Omg==
UI-OutboundReport: notjunk:1;M01:P0:819xazhbaSA=;XvbJrU+6FTsdkFQPArsrEpZW6UR
 KEcWNbBefjiiY+rX2YBeYRmPcgR0LFZcMEq7bwAeWWNrqkFU0gyMGBoZKpAwN7PFHaUc0g5Vv
 KpvNxGzCPDoFvq09MUd0OGzVs7prL3fVph45uu+Fhm7k4zF7tWeE3O9reLYwadCMRCJyeqSoS
 4mI1PR7fxoW7qCRlkK0GJkUk1dZ4+Ztz3U89mwRknyU2+P2o9CNzGR+HZyh8p8+x24dPMWOWH
 wdn0Df7OGNlr4+cAYRIvlb6Uk308Ksl5YilRVpJSG3elXoUGJ3O8CdZxfVEDgUlsbzg5bjNu1
 ApRAiSnoJ0rtChNSY4egPocOlfvzG9M58BmcY61tDG6CxOc4Y8xaJUfJPHvsJaJLRdwDErsGE
 voA0d+rxYXKLoQxxD7aqTjhBpZjE3BVTfO4FPHjtOYVkTTBWgLSWfMpgayMpoPzAOwJmd4U8k
 eQBLfqYpQd+eN8hITvMuzLuHvSX4l33ULjUwUe63MvnY//FHEggumjFr6n5SKoY8Ha47p5wvo
 CgO11y0ChZ27/XamkVXfZm5xVBVhnWkm1ojXpP/GQoz06u5FlXKOM4dOvI6yfciQ7W3rfeMBu
 dc3dlBQ19pZR4ehf/FtKl96MXjknZ/b71ikgUaCst46hVw3RAf5bTYURF9KNPvXfuSD9c/UDm
 g47MohCn0GvyRaPvLCCtaesFSnyYqHcFJPCXdGhABq6Kf9RhNkAAKrN3Nj3xEzdaCLA61NQgP
 dX6P36Z0GsRlbS186xEoWHxZgYFBox7HDdMnh/sNSVzb83aJD2iyLEfLvFCiPATgtEuzhkMAe
 gVW4Kg6wPv353v7X0qojl6tV6TJz5VTwIC08EDSbiIElOnWPMcSf/DmO3ZhYpGZTePab7uSsn
 6Ay0h6+44MiwAbprBnOEp3oeFYvSSyK6th9/DsAghHqWgbgbl0hzLnmBhvuF6ZKHPLH62h+eV
 MvuJPA/vlgGEPuPQc55b5T8PYds=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,

on v6.6-rc6+ (git commit hash 1acfd2bd3f0d) I got the following oops:

BUG: unable to handle page fault for address: fffffffffffffff8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 343212067 P4D 343212067 PUD 343214067 PMD 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 2 PID: 13243 Comm: colord-sane Not tainted 6.6.0-rc6+ #9
Hardware name: LENOVO 21K4S07400/21K4S07400, BIOS R2FET31W (1.11 ) 08/03/2=
023
RIP: 0010:klist_next+0x6e/0x150
Code: 18 83 f8 01 0f 84 84 00 00 00 85 c0 0f 8e ce 00 00 00 48 8b 45 00 45=
 31 ed 48 c7 45 08 00 00 00 00 48 39 c3 0f 84 cc 00 00 00 <f6> 03 01 75 7d=
 48 8d 7b 18 b8 01 00 00 00 f0 0f c1 43 18 85 c0 0f
RSP: 0018:ffffb8b907f6fcc8 EFLAGS: 00010002
RAX: ffff9c0aaba218a0 RBX: fffffffffffffff8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffb8b907f6fcf8 RDI: ffff9c0aaba218a0
RBP: ffffb8b907f6fcf8 R08: ffffb8b907f6fce0 R09: 0000000000000000
R10: 0000000000030680 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000246 R15: 0000000000000000
FS:  00007f12a5c77940(0000) GS:ffff9c10fec80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 00000001cb102000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x181/0x4b0
 ? srso_alias_return_thunk+0x5/0x7f
 ? exc_page_fault+0x11c/0x130
 ? asm_exc_page_fault+0x26/0x30
 ? klist_next+0x6e/0x150
 ? klist_next+0x1f/0x150
 ? device_match_devt+0x20/0x20
 bus_find_device+0x75/0xe0
 scsi_seq_start+0x42/0x60 [scsi_mod]
 seq_read_iter+0xfc/0x480
 seq_read+0xd4/0x100
 proc_reg_read+0x59/0xa0
 vfs_read+0xaa/0x370
 ? srso_alias_return_thunk+0x5/0x7f
 ? __do_sys_newfstatat+0x4e/0x80
 ? srso_alias_return_thunk+0x5/0x7f
 ? __fget_light+0x99/0x100
 ksys_read+0x6f/0xf0
 do_syscall_64+0x3c/0x90
 entry_SYSCALL_64_after_hwframe+0x4b/0xb5
RIP: 0033:0x7f12a680fa9c
Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 d9 cf f8 ff 48 8b=
 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff=
 ff 77 34 44 89 c7 48 89 44 24 08 e8 2f d0 f8 ff 48
RSP: 002b:00007ffd3ea95490 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055c0b2164cb0 RCX: 00007f12a680fa9c
RDX: 0000000000000400 RSI: 000055c0b214f4a0 RDI: 000000000000000c
RBP: 00007f12a68e8600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000246 R12: 000000000000000a
R13: 0000000000000a68 R14: 00007f12a68e7d00 R15: 0000000000000a68
 </TASK>
CR2: fffffffffffffff8
=2D--[ end trace 0000000000000000 ]---
RIP: 0010:klist_next+0x6e/0x150
Code: 18 83 f8 01 0f 84 84 00 00 00 85 c0 0f 8e ce 00 00 00 48 8b 45 00 45=
 31 ed 48 c7 45 08 00 00 00 00 48 39 c3 0f 84 cc 00 00 00 <f6> 03 01 75 7d=
 48 8d 7b 18 b8 01 00 00 00 f0 0f c1 43 18 85 c0 0f
RSP: 0018:ffffb8b907f6fcc8 EFLAGS: 00010002
RAX: ffff9c0aaba218a0 RBX: fffffffffffffff8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffb8b907f6fcf8 RDI: ffff9c0aaba218a0
RBP: ffffb8b907f6fcf8 R08: ffffb8b907f6fce0 R09: 0000000000000000
R10: 0000000000030680 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000246 R15: 0000000000000000
FS:  00007f12a5c77940(0000) GS:ffff9c10fec80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 00000001cb102000 CR4: 0000000000750ee0
PKRU: 55555554



Best regards,
Julian Wollrath

=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
