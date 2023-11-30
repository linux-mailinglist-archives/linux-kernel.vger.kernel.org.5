Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C797FE973
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbjK3HBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbjK3HBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:01:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9412A;
        Wed, 29 Nov 2023 23:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9zu2RE3aXyA0p4qWJp6wn7nLjV+PG5yQvbFEu1pKevkDKixDjjVPRNnnYplzfVGQfYc/uRkThZrn6ZDikSUSut1uXT3BqtRLo5uKiihkwnt3rGSrKJ+yR66uTxFXdbsf4+ZKRjc9GvJS1hJgcreMJrdYh4XXlJd+RmULKfqDn0gGAvDh9p/W8LyMMR0MfPhncz6D/TwTgawfK/3t8czlQZ4njpmB9H1UYFzvm5ReGwQaKUAX5JJ81uJOvbkGvqVD131LoBRPhFJHbVN+EjO6ZH/B1MaFUpRcQ+v2cxWcsvmzkxQVrOr5IEiCBNIpwssfsbL3q3qrzLsACST0TUfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8xrItMk2BZesTGvpW1RzJ1AAmjeJKijznfxjIl8rMo=;
 b=JxLMG2mlL5EJ3xAan0tWF7VhM7POOkxSCUN1dYKeqy7b/TkjYi1lMz7Ihec6eBsXF0B36mlgBMamxwF9lfkcn2ZtKfh2OrRgp+JaDIpN2LZM7+IFrC4ea8nGvRP5p6v5ou88k6R41MkylST/M7XOvcaAdHiceSSSerlTqVa+YcL6JRhoRV+TkOr/GcnhNIJOUC6tzHi/DxeERPqT10x4/F7blSqQYWs0hMu45Acy2VlzQs1a8EsSEpR9EpfWJOZ5pvp74MpRT/JolYoZvzlH4Nym1symX5whIeqiPn6lFNqZ9YMzGeOXAdykJzgTXfYoN9qf9emM9YVlZS5EwDitZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8xrItMk2BZesTGvpW1RzJ1AAmjeJKijznfxjIl8rMo=;
 b=JhTfWmnOC9TCdti/duUwAA6bMMVmGIpbihdtKOTkyNqOJZn3XAJlgrV5FiwEXI2qVNDeW+suo6SNUPKY0aPC2XK4ABxYhYhAcvTsVeczc8SB+4M8I0LFaha9aH0xuk8vlK31pa5FyuTEwgCxJFwcLxCU130iaAwCV3PR2uxcFxoO4HK/9xE7F4O0v24QX7tNhVXADFp/B6+1DqlG5gOOmg1lPk+RGft6XDXJda8i1pm8o8NqVDfasMGo7deXI6CTUnZ0UzhOBH1GAsgKjR3RztcUI15zeFz5UF7b+2/NF2zdLpBAkbvjBHxBc2uUHmXhEV2N/HNCxLKsDY/kQlo7Ww==
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 07:01:52 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::7d) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8 via Frontend
 Transport; Thu, 30 Nov 2023 07:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 07:01:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 23:01:41 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 23:01:40 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mst@redhat.com>, <hch@lst.de>, <jasowang@redhat.com>,
        <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 0/1] virtio-blk: handle block layer timedout request
Date:   Wed, 29 Nov 2023 23:01:32 -0800
Message-ID: <20231130070133.8059-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a94582-39f7-43f4-a1b5-08dbf1723b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNuE0PviXOCdE0ybFuniw7eg6fmbI03DxuJXFK8R2uiyKYnysUyMZqwjUAan5ff29SnDHSACyUb34X8ZpuY2aJ4pZ1qzeZV/XIisHLYSymtKAUAFIu5oI2IIFwrlgN7263mTs/BYkLLUR6xHjQEwN8en+ooO08tGV/21KnxqNabYfC6x+0sUKkGof4xgGJ5rHcDk+yURRsp+HT75FF4Qu8lAiS/aV/zmE1kcNmZZGPM/FIufpI/t1vjNNn7HdnLpkmYmvwZ0t41exPVPyewenXFXaXrXeDgnxlfAOCOZtAuNJn6EfJnC+UY5UK1UZ9W3N/AyoMBKd9zdY8izNZdh5nsA5OltxCYCohJcdtc/yxFhAcoVNw0BStpqV4VOGcyBfltqG2hGc+9X5muxgeKvrmqWf7QahoK22MDFOtAwVIc0GPvfSzxQmfbMNXWcz4Tmdz4mF325ONikmUDQvuhPU/qkEnDYW6sg7Edl9ZmBd13NYkcdlhyKXTmSzkmBaactln4RkYn6dPLDYAm4bOF3XcL3Xcnyq5vBok4Dkxdpm1IxSBuOzv85wCwwyWY9YREtbjAlQCa2TA0Tq+ugoV5NF+Wu41I5NjCaPg8MJK1lYZjVPyhQUqdkxUT184sCMZYQ2ErtX7dpm7rzM1sTZ5IzK1LwePceH3KoazThdSia6Z5CcB/7JD7Ra5KoCT/XbHQ6dZ2fI9L2uV6uwTipaU2OMPopEk+JP6iN2Rc+uYLy7bib7dX+48I+a1ckWOHkMFppz/XZYJ7O/TLtpRxOJkh1POcu5Hl9AqmvvgzHcV4WqP8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(16526019)(26005)(30864003)(83380400001)(336012)(426003)(40480700001)(2906002)(202311291699003)(7416002)(1076003)(107886003)(2616005)(47076005)(5660300002)(66899024)(36860700001)(40460700003)(478600001)(7696005)(6666004)(8676002)(316002)(356005)(7636003)(41300700001)(8936002)(4326008)(36756003)(110136005)(70586007)(70206006)(82740400003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 07:01:52.1237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a94582-39f7-43f4-a1b5-08dbf1723b0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current implementation virtio-blk assumes that request will be
completed by the underlying transport. This assumption has lead to
problems when virtio-blk driver is used on the real H/W where device
couldn't complete the request and driver ended up waiting for it
forever in the production.

This implements a straightforward block layer request timeout handler.
It completes the timed-out request in the same context if the virtio
device has a VIRTIO_CONFIG_S_DRIVER_OK status. For any other status
indicated by the virtio device, we halt the block layer request queue
and proceed with the tear-down sequence. This ensures that applications
waiting for the I/O can exit gracefully, preventing problematic devices
from receiving additional I/O and potentially causing more issues.

Without this patch when a request gets timed out on virtio-blk device it
leaves the application hanging avoiding graceful termination & cleanup.

Timeout handlers can be implemented differently and we can apply
different teardown policies, I'm open if anyone has better suggestion
for teardown hence marking it as RFC.

* Below is the test output on today's linux-block tree [1] with patch
  and test script to trigger simple timeout and trigger teardown
  sequence that follows following sequence :-

- Load virtio-blk module with io_timeout=10 and timeout teardown limit=2.
- Run fio randwrite with multiple jobs (48=NCPUS).
- Enable fault injection request timeout.
- While fio is running it will trigger request timeout handler because of
  fault injection.
- First two timed out requests will be completed with the time out error
  without initiating teardown.
- For third request it will initiate the teardown by issuing teardown
  work, that will perform device teardown sequence.
- Make sure all the fio jobs terminate gracefully and fio will run for
  the time we set the timeout value i.e. 10s.
- Lastly remove vitio-blk kernel module to make sure we are not holding
  any reference or pending resources post teardown.

Any feedback is welcome.
 
-ck

[1]

commit 20d713ea3192ca6735d669ce583a7d2183bd2f81 (origin/for-next)
Merge: 2cc14f52aeb7 668bfeeabb5e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 27 09:11:54 2023 -0700

    Merge branch 'for-6.8/block' into for-next

    * for-6.8/block:
      block: move a few definitions out of CONFIG_BLK_DEV_ZONED
      block/rnbd: use %pe to print errors
      block/rnbd: add support for REQ_OP_WRITE_ZEROES

Chaitanya Kulkarni (1):
  virtio-blk: process block layer timedout request

 drivers/block/virtio_blk.c      | 122 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_blk.h |   1 +
 2 files changed, 123 insertions(+)

* Test script test-virtio-timeout.sh :-
----------------------------------------------------------------------------

setup()
{
	echo "[RANDWRITE]"		>  /tmp/randwrite.fio
	echo "direct=1"			>> /tmp/randwrite.fio
	echo "rw=randwrite"		>> /tmp/randwrite.fio
	echo "norandommap"		>> /tmp/randwrite.fio
	echo "randrepeat=0"		>> /tmp/randwrite.fio
	echo "runtime=1m"		>> /tmp/randwrite.fio
	echo "time_based"		>> /tmp/randwrite.fio
	echo "iodepth=2"		>> /tmp/randwrite.fio
	echo "numjobs=48"		>> /tmp/randwrite.fio
	echo "bs=4k"			>> /tmp/randwrite.fio
	echo "overwrite=0"		>> /tmp/randwrite.fio
	echo "allow_file_create=0"	>> /tmp/randwrite.fio
	echo "group_reporting"		>> /tmp/randwrite.fio
	echo ""				>> /tmp/randwrite.fio


	./compile_virtioblk.sh
	modprobe -r virtio_blk

	echo "--------------------------------------------"
	echo "Loading virtio-blk module with io_timeout=30 timeout_teardown_limit=2"
	modprobe virtio_blk io_timeout=30 timeout_teardown_limit=2
	echo "--------------------------------------------"
	sleep 1

	set -x
	lsblk
	ls -lrth /dev/vda

	cat /sys/block/vda/io-timeout-fail
	echo 1 > /sys/block/vda/io-timeout-fail
	cat /sys/block/vda/io-timeout-fail

	echo  20 > /sys/kernel/debug/fail_io_timeout/probability
	echo  10 > /sys/kernel/debug/fail_io_timeout/interval
	echo  -1 > /sys/kernel/debug/fail_io_timeout/times
	echo   0 > /sys/kernel/debug/fail_io_timeout/space
	echo   1 > /sys/kernel/debug/fail_io_timeout/verbose

	set +x
	dmesg -c
}

teardown()
{
	modprobe -r virtio_blk
}

main()
{
	setup

	set -x 
	fio /tmp/randwrite.fio --filename=/dev/vda --ioengine=libaio
	set +x
	echo "--------------------------------------------"
	echo "device should be gone from lablk"
	set -x 
	ls -lrth /dev/vda
	lsblk

	teardown
}

main

* Test result :-
----------------------------------------------------------------------------

linux-block (for-next) # git am  p/virtio-blk-timeout/0001-virtio-blk-process-block-layer-timedout-request.patch
Applying: virtio-blk: process block layer timedout request
linux-block (for-next) # git log -1
commit 8f4403d78557ea6393948f8d427be0dc98e4e8c1 (HEAD -> for-next)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Mon Oct 9 17:48:50 2023 -0700

    virtio-blk: process block layer timedout request

    Improve block layer request handling by implementing a timeout handler.
    Current implementation assums that request will never timeout and will
    be completed by underlaying transport. However, this assumption can
    cause issues under heavy load especially when dealing with different
    subsystems and real hardware.

    To solve this, add a block layer request timeout handler that will
    complete timed-out requests in the same context if the virtio device
    has a VIRTIO_CONFIG_S_DRIVER_OK status. If the device has any other
    status, we'll stop the block layer request queue and proceed with the
    teardown sequence, allowing applications waiting for I/O to exit
    gracefully with appropriate error.

    Also, add two new module parameters that allows user to specify the
    I/O timeout for the tagset when allocating the disk and a teardown limit
    for the timed out requeets before we initiate device teardown from the
    timeout handler. These changes will improve the stability and
    reliability of our system under request timeout scenario.

    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
linux-block (for-next) # ./compile_virtioblk.sh
+ dmesg -c
+ modprobe -r virtio_blk
+ lsmod
+ grep virtio_blk
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/virtio_blk.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/virtio_blk.ko
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/6.7.0-rc3lblk+/kernel/drivers/block/
+ cp drivers/block//virtio_blk.ko /lib/modules/6.7.0-rc3lblk+/kernel/drivers/block//
+ ls -lrth /lib/modules/6.7.0-rc3lblk+/kernel/drivers/block//virtio_blk.ko
-rw-r--r--. 1 root root 641K Nov 29 15:19 /lib/modules/6.7.0-rc3lblk+/kernel/drivers/block//virtio_blk.ko
linux-block (for-next) # ./test-virtio-timeout.sh
+ dmesg -c
+ modprobe -r virtio_blk
+ lsmod
+ grep virtio_blk
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/6.7.0-rc3lblk+/kernel/drivers/block/
+ cp drivers/block//virtio_blk.ko /lib/modules/6.7.0-rc3lblk+/kernel/drivers/block//
+ ls -lrth /lib/modules/6.7.0-rc3lblk+/kernel/drivers/block//virtio_blk.ko
-rw-r--r--. 1 root root 641K Nov 29 15:20 /lib/modules/6.7.0-rc3lblk+/kernel/drivers/block//virtio_blk.ko
--------------------------------------------
Loading virtio-blk module with io_timeout=10 timeout_teardown_limit=2
++ modprobe virtio_blk io_timeout=40 timeout_teardown_limit=2
++ set +x
--------------------------------------------
++ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   50G  0 disk
├─sda1    8:1    0    1G  0 part /boot
└─sda2    8:2    0   49G  0 part /home
sdb       8:16   0  100G  0 disk /mnt/data
sr0      11:0    1 1024M  0 rom
vda     252:0    0    5G  0 disk
nvme0n1 259:0    0    1G  0 disk
++ ls -lrth /dev/vda
brw-rw----. 1 root disk 252, 0 Nov 29 15:20 /dev/vda
++ cat /sys/block/vda/io-timeout-fail
0
++ echo 1
++ cat /sys/block/vda/io-timeout-fail
1
++ echo 20
++ echo 10
++ echo -1
++ echo 0
++ echo 1
++ set +x
[  464.285445] virtio_blk virtio1: 48/0/0 default/read/poll queues
[  464.293352] virtio_blk virtio1: [vda] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
++ fio /tmp/randwrite.fio --filename=/dev/vda --ioengine=libaio
RANDWRITE: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
...
fio-3.34
Starting 48 processes
fio: io_u error on file /dev/vda: Connection timed out: write offset=2181410816, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4479356928, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=313679872, buflen=4096
fio: pid=4045, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4772716544, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=105332736, buflen=4096
fio: pid=4000, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2928922624, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4838883328, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4589166592, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=5146509312, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2520354816, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3324887040, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3058372608, buflen=4096
fio: pid=4001, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4034, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=3189833728, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2009739264, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1963376640, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4359561216, buflen=4096
fio: pid=4005, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=298274816, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1827557376, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=402067456, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=5360013312, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1807507456, buflen=4096
fio: pid=4044, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=3999, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4042, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=3963465728, buflen=4096
fio: pid=4002, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2294935552, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4134977536, buflen=4096
fio: pid=4007, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=5277339648, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=169168896, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3403808768, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2951380992, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2899501056, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4529233920, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1837285376, buflen=4096
fio: pid=4003, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4012, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4009, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4010, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4008, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4564606976, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=212725760, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1962016768, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1700605952, buflen=4096
fio: pid=4017, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4013, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4589961216, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1288470528, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1131532288, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3486863360, buflen=4096
fio: pid=4023, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=3674542080, buflen=4096
fio: pid=4014, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2965827584, buflen=4096
fio: pid=4015, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4076720128, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3765477376, buflen=4096
fio: pid=4016, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2116341760, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=119099392, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2960650240, buflen=4096
fio: pid=4018, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=3803418624, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1891971072, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=63213568, buflen=4096
fio: pid=4019, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=1702731776, buflen=4096
fio: pid=4020, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=1342504960, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1720606720, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2498568192, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2751967232, buflen=4096
fio: pid=4021, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=150994944, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2458804224, buflen=4096
fio: pid=4022, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4024, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=5106069504, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3151101952, buflen=4096
fio: pid=4025, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2127577088, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3512651776, buflen=4096
fio: pid=4026, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4321529856, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1877729280, buflen=4096
fio: pid=4027, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2883231744, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1158828032, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=2076794880, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4819566592, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1326583808, buflen=4096
fio: pid=4038, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4006, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2812641280, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3819180032, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=307916800, buflen=4096
fio: pid=4011, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=3831308288, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1140715520, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4298055680, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=398614528, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1207713792, buflen=4096
fio: pid=4030, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4028, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4043, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2714513408, buflen=4096
fio: pid=3998, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4391649280, buflen=4096
fio: pid=4031, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=103710720, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=121716736, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3203006464, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=635932672, buflen=4096
fio: pid=4032, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4040, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=2235961344, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3987615744, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3183620096, buflen=4096
fio: pid=4041, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=706084864, buflen=4096
fio: pid=4035, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=732864512, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3141156864, buflen=4096
fio: pid=4036, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=1853272064, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3174068224, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=4283023360, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=1962606592, buflen=4096
fio: pid=4039, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=180465664, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3477286912, buflen=4096
fio: pid=4037, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: pid=4033, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=4288196608, buflen=4096
fio: io_u error on file /dev/vda: Connection timed out: write offset=3106217984, buflen=4096
fio: pid=4029, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out
fio: io_u error on file /dev/vda: Connection timed out: write offset=3785584640, buflen=4096
fio: pid=4004, err=110/file:io_u.c:1889, func=io_u error, error=Connection timed out

RANDWRITE: (groupid=0, jobs=48): err=110 (file:io_u.c:1889, func=io_u error, error=Connection timed out): pid=3998: Wed Nov 29 15:20:50 2023
  write: IOPS=111, BW=438KiB/s (449kB/s)(18.8MiB/43930msec); 0 zone resets
    slat (nsec): min=2585, max=85232, avg=11030.13, stdev=6110.05
    clat (usec): min=24, max=1759, avg=437.53, stdev=332.56
     lat (usec): min=29, max=1776, avg=448.56, stdev=333.61
    clat percentiles (usec):
     |  1.00th=[   38],  5.00th=[   46], 10.00th=[   61], 20.00th=[  139],
     | 30.00th=[  196], 40.00th=[  326], 50.00th=[  412], 60.00th=[  453],
     | 70.00th=[  537], 80.00th=[  676], 90.00th=[  906], 95.00th=[ 1020],
     | 99.00th=[ 1565], 99.50th=[ 1680], 99.90th=[ 1713], 99.95th=[ 1729],
     | 99.99th=[ 1762]
   bw (  KiB/s): min=38539, max=38539, per=100.00%, avg=38539.00, stdev= 0.00, samples=48
   iops        : min= 9627, max= 9627, avg=9627.00, stdev= 0.00, samples=48
  lat (usec)   : 50=6.44%, 100=7.46%, 250=21.25%, 500=29.12%, 750=19.62%
  lat (usec)   : 1000=8.70%
  lat (msec)   : 2=5.46%
  cpu          : usr=0.00%, sys=0.01%, ctx=4094, majf=0, minf=1004
  IO depths    : 1=1.0%, 2=99.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.1%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,4908,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
  WRITE: bw=438KiB/s (449kB/s), 438KiB/s-438KiB/s (449kB/s-449kB/s), io=18.8MiB (19.7MB), run=43930-43930msec

Disk stats (read/write):
  vda: ios=7/4812, merge=0/0, ticks=1/2030, in_queue=2031, util=99.76%
++ set +x
--------------------------------------------
device should be gone from lablk
++ ls -lrth /dev/vda
ls: cannot access '/dev/vda': No such file or directory
++ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   50G  0 disk
├─sda1    8:1    0    1G  0 part /boot
└─sda2    8:2    0   49G  0 part /home
sdb       8:16   0  100G  0 disk /mnt/data
sr0      11:0    1 1024M  0 rom
nvme0n1 259:0    0    1G  0 disk
++ teardown
++ modprobe -r virtio_blk
linux-block (for-next) # lsmod | grep virtio_blk

-- 
2.40.0

