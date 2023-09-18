Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87337A4ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjIRQ2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjIRQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:27:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E821AFF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:22:02 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230918135330euoutp0184067df039964d1e152fe0c3126ca6e7~GAqNRVzf12680026800euoutp01_
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:53:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230918135330euoutp0184067df039964d1e152fe0c3126ca6e7~GAqNRVzf12680026800euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695045210;
        bh=QyNZbmlzUImJ8eQcsA69RltUbDRiaT2o3+FeSg3Y62Y=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=ux4PBtW+vPLpSvtvyZ+k6G6ltkshoBkob5GFLcWZXVoOwKUL/Ixq3lwaIx093ze2l
         oFn7XwbGo2tJUKHyOBJfc2hlWVyMUiuqOp7R2g/b8OrSqEav3E2xaaVpdD9VX0zEsp
         f9oXygCCIgGTbGYSrlSMlsXc5xsXfZGVHlKt3/FU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230918135330eucas1p1e79551a21c02b30e9bd116ee91d0ef91~GAqNGY9KZ2626026260eucas1p1l;
        Mon, 18 Sep 2023 13:53:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.AE.42423.95658056; Mon, 18
        Sep 2023 14:53:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230918135329eucas1p1ed1ae2c216d203cfba0eac428a5f2369~GAqMwkZEW2416024160eucas1p1n;
        Mon, 18 Sep 2023 13:53:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230918135329eusmtrp10b02e680b0c7f9addad7c1afca0ad76c~GAqMv33DM0074500745eusmtrp15;
        Mon, 18 Sep 2023 13:53:29 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-97-650856597651
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.36.14344.95658056; Mon, 18
        Sep 2023 14:53:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918135329eusmtip1a11e796d64da38e379c132d7a42f41e1~GAqMixrzn2844828448eusmtip1_;
        Mon, 18 Sep 2023 13:53:29 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.18) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 18 Sep 2023 14:53:28 +0100
Message-ID: <ef88e8e4-c94d-9ad3-a130-8cd6b3f722c9@samsung.com>
Date:   Mon, 18 Sep 2023 15:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Content-Language: en-US
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>,
        Pankaj Raghav <kernel@pankajraghav.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230911133430.1824564-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.18]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7qRYRypBuvvWFmsvtvPZnHm5WcW
        i723tC0u75rDZrHs63t2i90bF7E5sHnMbrjI4nH5bKnHplWdbB5nVzp6fN4kF8AaxWWTkpqT
        WZZapG+XwJWx4fJkpoKFshVH2k+yNDDOEO9i5OSQEDCR2PjhLWMXIxeHkMAKRomXpw8xQThf
        GCUe/vzGCuF8ZpToX/iYEaZl4pavLCC2kMByRonX35zgipZNe8AIkdjFKLF/m2UXIwcHr4Cd
        xK3bISBhFgFVicam20wgNq+AoMTJmU/A5ogKREvMnLYQrFVYwFpi1YlmZhCbWUBc4taT+WD1
        IkB7V/+9AnYqs8BMRomTv2YxgsxnE9CSaOxkB6nhFLCXeDHlHQtEr6ZE6/bf7BC2vMT2t3OY
        Ie5XkljYdocNwq6VOLXlFtjHEgL/OSSmXjzKApFwkWjb3w5lC0u8Or6FHcKWkTg9uQcqXi3x
        9MZvZojmFmAI7VzPBnKQBNAHfWdyIGocJf42zmeGCPNJ3HgrCHEPn8SkbdOZJzCqzkIKillI
        Xp6F5IVZSF5YwMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDpnP53/NMOxrmvPuod
        YmTiYDzEKMHBrCTCO9OQLVWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC
        1CKYLBMHp1QDU6JfjoBuyecmt6bK6srzF+WMGERbDjUtCHF1eq84a1HaEWMbzWclgiVTxXhv
        bjn5lvvOeenU/oLrD+tvc2VJ9vj2LrTumrZ5Wd/j6FWce7N3GH69sP/WafFl1dzz2KWcZnxp
        uHOovzj1V//zFqbchobp/nOFwjWEWRbWcRcd/83ceVj+qPXOFfsE71mfW/x0+ZlAfdkd+QwR
        JtbBpz58FXitYcC03XntGzbR2e7MS7Y8bKvwWLzqa3tj0W67ZoHDnzetZu7snaYWzsjOefbJ
        ZuVXoT6v8j1l9z9f8LjDT2GJVmL94c3ae2/9teJ8umPyZ78j3FMPa8X83XbzpfPE7Q5/dV+z
        qv7ye7XM3I4rQImlOCPRUIu5qDgRAEcrJj+pAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7qRYRypBuumKlqsvtvPZnHm5WcW
        i723tC0u75rDZrHs63t2i90bF7E5sHnMbrjI4nH5bKnHplWdbB5nVzp6fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex4fJkpoKFshVH
        2k+yNDDOEO9i5OSQEDCRmLjlK0sXIxeHkMBSRokDv36yQSRkJDZ+ucoKYQtL/LnWxQZR9JFR
        YtuF06wQzi5GiZUb/zN2MXJw8ArYSdy6HQLSwCKgKtHYdJsJxOYVEJQ4OfMJC0iJqEC0RNdL
        Y5CwsIC1xKoTzcwgNrOAuMStJ/PBykWADlr99wojyHhmgZmMEid/zWKE2DWJUeLIs8nsIIPY
        BLQkGjvZQRo4BewlXkx5xwIxSFOidftvdghbXmL72znMEA8oSSxsuwP1WK3E57/PGCcwis5C
        ct4sJHfMQjJqFpJRCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG67ZjP7fsYFz56qPe
        IUYmDsZDjBIczEoivDMN2VKFeFMSK6tSi/Lji0pzUosPMZoCw2gis5Rocj4wXeSVxBuaGZga
        mphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBNU3tWplDx/us8zzsvdOcaljOK
        9p5bn1fcz9O9Q+yia7OZYO7PqlzOxalvtzBJl82d/ujyl/kPRVIbU954CW6ecKJf5OU9yY2/
        7pYFyEaYWap8jdzhpt0tkeymPS8lZPK09rurdSLTLBlup1i1s0Q939IRF10wcyUL14Eq7t2L
        5L1vTvvnNGfb71c3PrzqZFRrvxm43ytTWb6k0dNV3Pt3B+tJTkE9ee9nLTJrwls83+V92cA9
        hZUj7Bjf7qWS+xct2ZV29iPfrrANUfOENnhWf3e9VMbEFLzUzl33mlfrB/vrJt6iHrNXHTsm
        NuNPdKz1m6xKgw3nQ/bt/rN/5om22Qw1V/iEZcX/7FrbIaHEUpyRaKjFXFScCABMZjJnXwMA
        AA==
X-CMS-MailID: 20230918135329eucas1p1ed1ae2c216d203cfba0eac428a5f2369
X-Msg-Generator: CA
X-RootMTR: 20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3
References: <CGME20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3@eucas1p2.samsung.com>
        <20230911133430.1824564-1-kernel@pankajraghav.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping Minchan and Sergey.

Regards,
Pankaj

On 2023-09-11 15:34, Pankaj Raghav wrote:
> ZRAM can have a backing device that could be used as a writeback device
> for the pages in RAM. The current writeback code (writeback_store()) does
> a synchronous single page size IO to the backing device.
> 
> This series implements IO batching while doing a writeback to a backing
> device. The code still does synchronous IOs but with larger IO sizes
> whenever possible. This crosses off one of the TODO that was there as a part
> of writeback_store() function:
> A single page IO would be inefficient for write...
> 
> The idea is to batch the IOs to a certain limit before the data is flushed
> to the backing device. The batch limit is initially chosen based on the
> bdi->io_pages value with an upper limit of 32 pages (128k on x86).
> 
> Batching reduces the time of writeback of 4G data to a nvme backing device
> from 68 secs to 15 secs (more than **4x improvement**).
> 
> The first 3 patches are prep. 4th patch implements the main logic for IO
> batching and the last patch is another cleanup.
> 
> Perf:
> 
> $ modprobe zram num_devices=1
> $ echo "/dev/nvme0n1" > /sys/block/zram0/backing_dev
> $ echo 6G > /sys/block/zram0/disksize
> $ fio -iodepth=16 -rw=randwrite -ioengine=io_uring -bs=4k -numjobs=1 -size=4G -filename=/dev/zram0 -name=io_uring_1 > /dev/null
> $ echo all > /sys/block/zram0/idle
> 
> Without changes:
> $ time echo idle > /sys/block/zram0/writeback
> real    1m8.648s         (68 secs)
> user    0m0.000s
> sys     0m24.899s
> $ cat /sys/block/zram0/bd_stat
> 1048576        0  1048576
> 
> With changes:
> $ time echo idle > /sys/block/zram0/writeback
> real    0m15.496s       (15 secs)
> user    0m0.000s
> sys     0m7.789s
> $ cat /sys/block/zram0/bd_stat
> 1048576        0  1048576
> 
> Testing:
> 
> A basic End-End testing (based on Sergey's test flow [1]):
> 1) configure zram0 and add a nvme device as a writeback device
> 2) Get the sha256sum of a tarball
> 3) mkfs.ext4 on zram0, cp tarball
> 4) idle writeback
> 5) cp tarball from zram0 to another device (reread writeback pages) and
>    compare the sha256sum again
> The sha before and after are verified to be the same.
> 
> Writeback limit testing:
> 
> 1) configure zram0 and add a nvme device as a writeback device
> 2) Set writeback limit and enable
> 3) Do a fio that crosses the writeback limit
> 4) idle writeback
> 5) Verify the writeback is limited to the set writeback limit value
> 
> $ modprobe zram num_devices=1
> $ echo "/dev/nvme0n1" > /sys/block/zram0/backing_dev
> $ echo 4G > /sys/block/zram0/disksize
> $ echo 1 > /sys/block/zram0/writeback_limit_enable
> $ echo 1002 > /sys/block/zram0/writeback_limit
> 
> $ fio -iodepth=16 -rw=write -ioengine=io_uring -bs=4k -numjobs=1 -size=10M -filename=/dev/zram0 -name=io_uring_1
> 
> $ echo all > /sys/block/zram0/idle
> $ echo idle > /sys/block/zram0/writeback
> $ cat /sys/block/zram0/bd_stat
> 1002        0     1002
> 
> writeback is limited to the set value.
> 
> [1] https://lore.kernel.org/lkml/20230806071601.GB907732@google.com/
> 
> Pankaj Raghav (5):
>   zram: move index preparation to a separate function in writeback_store
>   zram: encapsulate writeback to the backing bdev in a function
>   zram: add alloc_block_bdev_range() and free_block_bdev_range()
>   zram: batch IOs during writeback to improve performance
>   zram: don't overload blk_idx variable in writeback_store()
> 
>  drivers/block/zram/zram_drv.c | 318 ++++++++++++++++++++++------------
>  1 file changed, 210 insertions(+), 108 deletions(-)
> 
> 
> base-commit: 7bc675554773f09d88101bf1ccfc8537dc7c0be9
