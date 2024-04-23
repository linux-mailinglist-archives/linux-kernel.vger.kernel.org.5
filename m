Return-Path: <linux-kernel+bounces-154575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587B8ADDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3782B232C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D926AC1;
	Tue, 23 Apr 2024 06:52:06 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31AF505;
	Tue, 23 Apr 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855126; cv=none; b=bPk7fiS7Udf+QI64Q2RSsUY5eVpEeergyDGMJQcZlYw6RyUzTYhvj5z7n0sKGniqMqDX+g0ZAA+uMglCpG/xj1TFPAl9Xn4Plgc2KC5+ZH0CEk5YKdEbgr0A9PECuL4/YSPVlBPcX9cCRTwlQ7gkcXh1Q/hlU8lfkGRCTs2SZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855126; c=relaxed/simple;
	bh=wPJZRJaZa+GCyYVm9DO8lDBYF3+2RLlEdSqReRZ88ys=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YmSOGpCXywHIoRVv3z26fNxe2Txbi5z3l4SnNvNFSjAxajmj0hzMUhBaZPNCR/+u53HrynehzcXON6cHj3BO6ry6bZntDHqyp28ed3LyxDQwFPpjD6sU0eDbTUiJxkpxmgqnYjVaDT+7FFgT4hPmNDsEAms3Uo9eNbfC8yRtDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VNt816h5Mz4f3jXn;
	Tue, 23 Apr 2024 14:51:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6A98D1A016E;
	Tue, 23 Apr 2024 14:51:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6HWidmJzfqKg--.36698S3;
	Tue, 23 Apr 2024 14:51:53 +0800 (CST)
Subject: Re: INFO: task hung in bdev_open
To: Marius Fleischer <fleischermarius@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2c9182cc-9d7e-0108-90bc-5e66da966bdb@huaweicloud.com>
Date: Tue, 23 Apr 2024 14:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6HWidmJzfqKg--.36698S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43ArWfuFW5CFWxZFykuFg_yoW8tFW8pF
	Z5Kay7Xr18Wa4Dua1Ika4xWFWrWrsxXa1xGrs7Gry8AFnIqwsIqF1Sywsxt3yDKry8CFyU
	XF18Z3s2g3WxCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/21 9:19, Marius Fleischer 写道:
> INFO: task syz-executor.2:32444 blocked for more than 143 seconds.
>     Not tainted 6.9.0-rc4-dirty #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.2  state:D stack:25264 pid:32444 tgid:32417
> ppid:8232   flags:0x00004006
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5409 [inline]
>   __schedule+0xd23/0x5bc0 kernel/sched/core.c:6746
>   __schedule_loop kernel/sched/core.c:6823 [inline]
>   schedule+0xe7/0x350 kernel/sched/core.c:6838
>   io_schedule+0xbf/0x130 kernel/sched/core.c:9044
>   folio_wait_bit_common+0x397/0x9c0 mm/filemap.c:1283
>   folio_put_wait_locked mm/filemap.c:1447 [inline]
>   do_read_cache_folio+0x2db/0x520 mm/filemap.c:3729
>   read_mapping_folio include/linux/pagemap.h:894 [inline]
>   read_part_sector+0xf7/0x440 block/partitions/core.c:715
>   adfspart_check_POWERTEC+0x82/0x710 block/partitions/acorn.c:454
>   check_partition block/partitions/core.c:138 [inline]
>   blk_add_partitions block/partitions/core.c:582 [inline]
>   bdev_disk_changed+0x891/0x15f0 block/partitions/core.c:686
>   blkdev_get_whole+0x18b/0x260 block/bdev.c:667
>   bdev_open+0x2eb/0xe90 block/bdev.c:880
>   blkdev_open+0x181/0x200 block/fops.c:620
>   do_dentry_open+0x6d3/0x18e0 fs/open.c:955
>   do_open fs/namei.c:3642 [inline]
>   path_openat+0x1b23/0x2670 fs/namei.c:3799
>   do_filp_open+0x1c7/0x410 fs/namei.c:3826
>   do_sys_openat2+0x164/0x1d0 fs/open.c:1406
>   do_sys_open fs/open.c:1421 [inline]
>   __do_sys_openat fs/open.c:1437 [inline]
>   __se_sys_openat fs/open.c:1432 [inline]
>   __x64_sys_openat+0x140/0x1f0 fs/open.c:1432
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xce/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f

So this thread hold 'open_mutex' to issued IO to scan partitons, and
such IO never complete, consider that you are using nbd to test, and
nbd doesn't handle timeout by default, I really suspect this is not a
real issue, and this looks like nbd server side doesn't reply to
nbd-client.

Thanks,
Kuai


