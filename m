Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E13782A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjHUNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjHUNSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:18:39 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B864A8;
        Mon, 21 Aug 2023 06:18:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RTtMp5TDSz4f3lKX;
        Mon, 21 Aug 2023 21:18:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqklZONkve76BA--.48806S3;
        Mon, 21 Aug 2023 21:18:30 +0800 (CST)
Subject: Re: Fwd: Infiniate systemd loop when power off the machine with
 multiple MD RAIDs
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        AceLan Kao <acelan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <433392a3-5ec4-cd63-fa5b-58e24deb56b9@huaweicloud.com>
Date:   Mon, 21 Aug 2023 21:18:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqklZONkve76BA--.48806S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1DWr4kWFy5ur1rAr1rCrg_yoW5Jw1Upr
        1UZFn09rsIqr47KF4IkF4IgF15twnayws5KryF9w4a934rtFyxA3Wftry5Ja4UGw1F9rWD
        Ar1qv34kWFWqv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/16 17:37, Bagas Sanjaya 写道:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> It needs to build at least 2 different RAIDs(eg. RAID0 and RAID10, RAID5 and RAID10) and then you will see below error repeatly(need to use serial console to see it)
>>
>> [ 205.360738] systemd-shutdown[1]: Stopping MD devices.
>> [ 205.366384] systemd-shutdown[1]: sd-device-enumerator: Scan all dirs
>> [ 205.373327] systemd-shutdown[1]: sd-device-enumerator: Scanning /sys/bus
>> [ 205.380427] systemd-shutdown[1]: sd-device-enumerator: Scanning /sys/class
>> [ 205.388257] systemd-shutdown[1]: Stopping MD /dev/md127 (9:127).
>> [ 205.394880] systemd-shutdown[1]: Failed to sync MD block device /dev/md127, ignoring: Input/output error
>> [ 205.404975] md: md127 stopped.
>> [ 205.470491] systemd-shutdown[1]: Stopping MD /dev/md126 (9:126).
>> [ 205.770179] md: md126: resync interrupted.
>> [ 205.776258] md126: detected capacity change from 1900396544 to 0
>> [ 205.783349] md: md126 stopped.
>> [ 205.862258] systemd-shutdown[1]: Stopping MD /dev/md125 (9:125).
>> [ 205.862435] md: md126 stopped.
>> [ 205.868376] systemd-shutdown[1]: Failed to sync MD block device /dev/md125, ignoring: Input/output error
>> [ 205.872845] block device autoloading is deprecated and will be removed.
>> [ 205.880955] md: md125 stopped.
>> [ 205.934349] systemd-shutdown[1]: Stopping MD /dev/md124p2 (259:7).
>> [ 205.947707] systemd-shutdown[1]: Could not stop MD /dev/md124p2: Device or resource busy
>> [ 205.957004] systemd-shutdown[1]: Stopping MD /dev/md124p1 (259:6).
>> [ 205.964177] systemd-shutdown[1]: Could not stop MD /dev/md124p1: Device or resource busy
>> [ 205.973155] systemd-shutdown[1]: Stopping MD /dev/md124 (9:124).
>> [ 205.979789] systemd-shutdown[1]: Could not stop MD /dev/md124: Device or resource busy
>> [ 205.988475] systemd-shutdown[1]: Not all MD devices stopped, 4 left.

Without the problem, did the log complain about this?

Could not stop MD...Device or resource busy

Thanks,
Kuai

> 
> See Bugzilla for the full thread and attached full journalctl log.
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: 12a6caf273240a https://bugzilla.kernel.org/show_bug.cgi?id=217798
> #regzbot title: systemd shutdown hang on machine with different RAID levels
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217798
> 

