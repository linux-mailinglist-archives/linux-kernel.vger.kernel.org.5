Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC576C388
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjHBDbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBDbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:31:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870601990;
        Tue,  1 Aug 2023 20:31:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 486445C00F0;
        Tue,  1 Aug 2023 23:31:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Aug 2023 23:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690947099; x=
        1691033499; bh=Te8AisNjEFEr13EgIgUJYL4Wz/sQ7ji3HawsxLNYEIE=; b=N
        cfzZYQwRFF3vuSFIvsZLsLaXuzCh8eHRi89U0gclAEen5PTbkOvEFBPoW18LXnSn
        0wJgyRVlJczhXGD0KiMX8BIlYiaXxoFrh0XOrN+TFRDAvW5fFTShGrNwG1HQop/L
        o2FLh5LgSDEr3sIok7YMa6kin3JQG2qlk7Uzz8+g2TvsDy1r/dHt1+irgSkAy45z
        fHL7hZABY2fsA8+J/ox2agRahYtgdRLqlFcPV65FVR63L2B4FOinBR/JTowDwzFi
        vvWCG8JmxqxpbnyWq6ZzHZXHo6owWTJLeAcBMHQBF16bjrRxXASszs41DegKUAo+
        JlnZ5VV7SISxJDT4cMxCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690947099; x=1691033499; bh=T
        e8AisNjEFEr13EgIgUJYL4Wz/sQ7ji3HawsxLNYEIE=; b=sJ9naP0T/wpSpWY9A
        tj9EX4p2kfBmPaCop7BgBV8igIS8jHh0nn573SMfhDecO41imb3EqLMqsHppiWoQ
        V/TfR3trrFoyU20x34/d9UAABzZIN5NSUttgvl2alQGxS3kqp1FI5oCINYqWcEeT
        yfgCpd1xBNPPhWoZju+bd/LDh7xA+nA55Vq+uuVmzy3qTedDC0zfVeEgz4zwcw54
        I72QWSfN0C5TGbfDBfSzPRNMA7EVp46MZ5qQEZcpBpk0Jp4/MK6p1nXAkRjQfq6u
        tpLv/7dCxMtdmrcdC8ga9huBFwkj60TsRX9mmoA4l/5rquXO1H3dVelIs3Wykve1
        GUlTQ==
X-ME-Sender: <xms:Gs7JZBtdqF7aPzXmxPPRgcbBILVg8qJK3wt6F3aGbzdUsVtdmEVwwQ>
    <xme:Gs7JZKcCMBiNS4D0OJxGjEf0yK1DG39MS8JIXf777kn2KVpINuSl_cJVvp8XzZGoz
    HnGt5iDi8f3f3pABA0>
X-ME-Received: <xmr:Gs7JZEyDJ6pgA5fkkexNZAgurEZwPgcMpe5N7B8ciA08HVY-D3QfBxMV8mDwoKuoYVNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeejgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvefhufgtgfesthejredttdefjeenucfhrhhomhepffhushhthicu
    ofgrsggvuceoughushhthiesughushhthihmrggsvgdrtghomheqnecuggftrfgrthhtvg
    hrnhepueffvedtteevieegudeileetgfejhffffeeuvdduteekudekieehgeelhfdtveev
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdprhgvughhrghtrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpeguuhhsthihseguuhhsthihmhgrsggvrdgtohhm
X-ME-Proxy: <xmx:Gs7JZIObvCko3QTtdbr7LWxLBkyFnn6cZ7J1gFen6DQYctmW7MgsZg>
    <xmx:Gs7JZB-tDWyoeVUPZl36hmf3aiRvdPpduWwBDOvxLdzxiQVfq6c8Sw>
    <xmx:Gs7JZIUs10ZQBK1InlsB3JQx177GuwtaaZBF0ID_yOemWcNZ1ez3GA>
    <xmx:G87JZBw_I1VZSJ0Zc0jkwgK1k-n4CykJemF9INp7DSjriAsS94030Q>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 23:31:38 -0400 (EDT)
Message-ID: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
Date:   Tue, 1 Aug 2023 23:31:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
From:   Dusty Mabe <dusty@dustymabe.com>
Subject: XFS metadata CRC errors on zram block device on ppc64le architecture
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Fedora CoreOS we found an issue with an interaction of an XFS filesystem on a zram block device on ppc64le:

- https://github.com/coreos/fedora-coreos-tracker/issues/1489
- https://bugzilla.redhat.com/show_bug.cgi?id=2221314

The dmesg output shows several errors:

```
[ 3247.206007] XFS (zram0): Mounting V5 Filesystem 0b7d6149-614c-4f4c-9a1f-a80a9810f58f
[ 3247.210781] XFS (zram0): Metadata CRC error detected at xfs_agf_read_verify+0x108/0x150 [xfs], xfs_agf block 0x80008 
[ 3247.211121] XFS (zram0): Unmount and run xfs_repair
[ 3247.211198] XFS (zram0): First 128 bytes of corrupted metadata buffer:
[ 3247.211293] 00000000: fe ed ba be 00 00 00 00 00 00 00 02 00 00 00 00 ................
[ 3247.211405] 00000010: 00 00 00 00 00 00 00 18 00 00 00 01 00 00 00 00  ................
[ 3247.211515] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 3247.211625] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 3247.211735] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 3247.211842] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 3247.211951] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 3247.212063] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 3247.212171] XFS (zram0): metadata I/O error in "xfs_read_agf+0xb4/0x180 [xfs]" at daddr 0x80008 len 8 error 74
[ 3247.212485] XFS (zram0): Error -117 reserving per-AG metadata reserve pool.
[ 3247.212497] XFS (zram0): Corruption of in-memory data (0x8) detected at xfs_fs_reserve_ag_blocks+0x1e0/0x220 [xfs] (fs/xfs/xfs_fsops.c:587).  Shutting down filesystem.
[ 3247.212828] XFS (zram0): Please unmount the filesystem and rectify the problem(s)
[ 3247.212943] XFS (zram0): Ending clean mount
[ 3247.212970] XFS (zram0): Error -5 reserving per-AG metadata reserve pool.
```

The issue can be reproduced easily with a simple script:

```
[root@p8 ~]# cat test.sh 
#!/bin/bash
set -eux -o pipefail
modprobe zram num_devices=0
read dev < /sys/class/zram-control/hot_add
echo 10G > /sys/block/zram"${dev}"/disksize
mkfs.xfs /dev/zram"${dev}"
mkdir -p /tmp/foo
mount -t xfs /dev/zram"${dev}" /tmp/foo
```

We ran a kernel bisect and narrowed it down to offending commit af8b04c6:

```
[root@ibm-p8-kvm-03-guest-02 linux]# git bisect good
af8b04c63708fa730c0257084fab91fb2a9cecc4 is the first bad commit
commit af8b04c63708fa730c0257084fab91fb2a9cecc4
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 11 19:14:46 2023 +0200

    zram: simplify bvec iteration in __zram_make_request
    
    bio_for_each_segment synthetize bvecs that never cross page boundaries, so
    don't duplicate that work in an inner loop.
    
    Link: https://lkml.kernel.org/r/20230411171459.567614-5-hch@lst.de
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
    Acked-by: Minchan Kim <minchan@kernel.org>
    Cc: Jens Axboe <axboe@kernel.dk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

 drivers/block/zram/zram_drv.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)
```

Any ideas on how to fix the problem?

Thanks!
Dusty
