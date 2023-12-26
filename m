Return-Path: <linux-kernel+bounces-11504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCC81E760
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EB61C21E76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1D4E628;
	Tue, 26 Dec 2023 12:22:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849C4CB50;
	Tue, 26 Dec 2023 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Szv6h5Cvpz4f3lfh;
	Tue, 26 Dec 2023 20:22:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 21FC41A08FC;
	Tue, 26 Dec 2023 20:22:42 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgA3jUuNxYplBmM7Ew--.30470S3;
	Tue, 26 Dec 2023 20:22:37 +0800 (CST)
Message-ID: <2ace9fdd-bd91-d755-fb06-1de36361c347@huaweicloud.com>
Date: Tue, 26 Dec 2023 20:22:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop
To: kernel test robot <oliver.sang@intel.com>, linan666@huaweicloud.com
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-raid@vger.kernel.org,
 song@kernel.org, zlliu@suse.com, neilb@suse.com, shli@fb.com,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <202312261217.c5597bdf-oliver.sang@intel.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <202312261217.c5597bdf-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3jUuNxYplBmM7Ew--.30470S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWDuw43Aw1rZFW8CF17Wrg_yoW5CF18pw
	4rWay5GFs5JF1kZF1DW3y8ZayYvF4fJr13XryUG340ya17Jr9ayr1SgrWYgrZrtr1Yk34a
	v39rZF15Ka1vg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAkucUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2023/12/26 14:24, kernel test robot 写道:
> 
> 
> Hello,
> 
> kernel test robot noticed "mdadm-selftests.06name.fail" on:
> 
> commit: 4d060913335fad6f1d1f0816859c20aae823851c ("[PATCH] md: Don't clear MD_CLOSING when the raid is about to stop")
> url: https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/md-Don-t-clear-MD_CLOSING-when-the-raid-is-about-to-stop/20231211-162010
> base: git://git.kernel.org/cgit/linux/kernel/git/song/md.git md-next
> patch link: https://lore.kernel.org/all/20231211081714.1923567-1-linan666@huaweicloud.com/
> patch subject: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop
> 
> in testcase: mdadm-selftests
> version: mdadm-selftests-x86_64-5f41845-1_20220826
> with following parameters:
> 
> 	disk: 1HDD
> 	test_prefix: 06name
> 
> 
> 
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202312261217.c5597bdf-oliver.sang@intel.com
> 
> 2023-12-24 10:19:28 mkdir -p /var/tmp
> 2023-12-24 10:19:28 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sdb1
> 2023-12-24 10:19:59 mount -t ext3 /dev/sdb1 /var/tmp
> sed -e 's/{DEFAULT_METADATA}/1.2/g' \
> -e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
> /usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
> /usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
> /usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
> /usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
> /usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/01-md-raid-creating.rules
> /usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
> /usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
> /usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/udev/rules.d/69-md-clustered-confirm-device.rules
> /usr/bin/install -D  -m 755 mdadm /sbin/mdadm
> /usr/bin/install -D  -m 755 mdmon /sbin/mdmon
> Testing on linux-6.7.0-rc3-00014-g4d060913335f kernel
> /lkp/benchmarks/mdadm-selftests/tests/06name... FAILED - see /var/tmp/06name.log and /var/tmp/fail06name.log for details
> 
> 

If MD_CLOSING is not cleared when stopping, it will still exist when
assembling and mddev can't be opened anymore. We need to clear it when 
starting. I will fix it in next version.

> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231226/202312261217.c5597bdf-oliver.sang@intel.com
> 
> 
> 

-- 
Thanks,
Nan


