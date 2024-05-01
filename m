Return-Path: <linux-kernel+bounces-164876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DA8B845D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CA22839F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4AC12B71;
	Wed,  1 May 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l8sES53+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497510A03;
	Wed,  1 May 2024 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714530444; cv=none; b=igSlpwyehDVbNubQl0KA+QAbjtqNubhIld2Rpxdgz1WAqYjqp7v5NIdZpl/HICJiE6lTITAbu5wmtp12tzb1CsKQAb/N5YFoRLJOg64eeRxEjdNAdje2pqIPL9ukhtTdXD4HdkL/+SQtyohGQW/qHpbn8tlAfcun6/gfd1i+Tbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714530444; c=relaxed/simple;
	bh=FRsGkPHSoydqvdyIJ0MAzb+gXp7P2C0gjeuRsN5UjrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQgxlgfoFxPwHUR7OlDp6g8DkSMNIfVF8cpbRVsnVMgxD0cdyUXOYchqE8sb33GabSFyYL9q4TFf8GHbJ067iKDUvAml2v3gL5YhLXKou2mw3K/LPvuoio6FIUP3kefH4oZnG9ORnktTgk1DPnQJnP+r5u0AoKXLPg7q/gzAYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l8sES53+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4410ro4A010509;
	Wed, 1 May 2024 02:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=7fjKpIV
	CrG16rPBfMRo3DetkYGl8dg4mfjzHivxICDc=; b=l8sES53+3JznQl8ZRRyH/mU
	BQiTnakv3qSEZ/RU0aOiA9GrGT2eox2L8ROC/rEeCpwCeJ2dBJ9cWl0lithwkIS9
	N5be88KxcjQHPYWu/3+AbttBUZ50sOFFlGdAY+HMtYh+j5/rff5vAwWhkONwlbBs
	sHwuRcrt3yPCLyYvyFN+O0iOj93OPsYu4gst10ndZCWH2Ti+RgugowYT6Tf8SDrp
	WMgI99+t5LcrNwvGZ8NyfdcR8cf9vn2Vh7WJv3Xi6BKX0j9Kd3RKadgGwuPIpOxf
	aZE9UdiJo1wvTpEmtEVXCv6LcFqW+QhDZwKvo8Ulo7wSphDEmU0+AGFnuYDtNMQ=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtv1htg3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 02:27:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4412RIKV007727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 02:27:18 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 19:27:16 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <brgl@bgdev.pl>, <warthog618@gmail.com>, <linus.walleij@linaro.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] gpiolib: cdev: Fix use after free in lineinfo_changed_notify
Date: Wed, 1 May 2024 10:26:12 +0800
Message-ID: <20240501022612.1787143-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1cbCZhYTMPGdyBrm88lZGUsnNNseqoMn
X-Proofpoint-ORIG-GUID: 1cbCZhYTMPGdyBrm88lZGUsnNNseqoMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_02,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=980 adultscore=0
 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010016

The use-after-free issue occurs when userspace closes the GPIO chip device
file (e.g., "/dev/gpiochip0") by invoking gpio_chrdev_release(), while one
of its GPIO lines is simultaneously being released. In a stress test
scenario, stress-ng tool starts multi stress-ng-dev threads to continuously
open and close device file in the /dev, the use-after-free issue will occur
with a low reproducibility.

Here is the typical stack when issue happened:

BUG: KASAN: slab-use-after-free in lineinfo_changed_notify+0x84/0x1bc
Read of size 8 at addr ffffff803c06e840 by task stress-ng-dev/5437
Call trace:
 dump_backtrace
 show_stack
 dump_stack_lvl
 print_report
 kasan_report
 __asan_load8
 lineinfo_changed_notify
 notifier_call_chain
 blocking_notifier_call_chain
 gpiod_free_commit
 gpiod_free
 gpio_free
 st54spi_gpio_dev_release
 __fput
 __fput_sync
 __arm64_sys_close
 invoke_syscall
 el0_svc_common
 do_el0_svc
 el0_svc
 el0t_64_sync_handler
 el0t_64_sync
Allocated by task 5425:
 kasan_set_track
 kasan_save_alloc_info
 __kasan_kmalloc
 __kmalloc
 bitmap_zalloc
 gpio_chrdev_open
 chrdev_open
 do_dentry_open
 vfs_open
 path_openat
 do_filp_open
 do_sys_openat2
 __arm64_sys_openat
 invoke_syscall
 el0_svc_common
 do_el0_svc
 el0_svc
 el0t_64_sync_handler
 el0t_64_sync
Freed by task 5425:
 kasan_set_track
 kasan_save_free_info
 ____kasan_slab_free
 __kasan_slab_free
 slab_free_freelist_hook
 __kmem_cache_free
 kfree
 bitmap_free
 gpio_chrdev_release
 __fput
 __fput_sync
 __arm64_sys_close
 invoke_syscall
 el0_svc_common
 do_el0_svc
 el0_svc
 el0t_64_sync_handler
 el0t_64_sync

The use-after-free issue occurs as follows: watched_lines is freed by
bitmap_free(), but the lineinfo_changed_nb notifier chain cannot be
successfully unregistered due to waiting write rwsem when closing the
GPIO chip device file. Additionally, one of the GPIO chip's lines is
also in the release process and holds the notifier chain's read rwsem.
Consequently, a race condition leads to the use-after-free of
watched_lines.

[free]
gpio_chrdev_release()
  --> bitmap_free(cdev->watched_lines)                  <-- freed
  --> blocking_notifier_chain_unregister()
    --> down_write(&nh->rwsem)                          <-- waiting rwsem
          --> __down_write_common()
            --> rwsem_down_write_slowpath()
                  --> schedule_preempt_disabled()
                    --> schedule()

[use]
st54spi_gpio_dev_release()
  --> gpio_free()
    --> gpiod_free()
      --> gpiod_free_commit()
        --> gpiod_line_state_notify()
          --> blocking_notifier_call_chain()
            --> down_read(&nh->rwsem);                  <-- held rwsem
            --> notifier_call_chain()
              --> lineinfo_changed_notify()
                --> test_bit(xxxx, cdev->watched_lines) <-- use after free

To fix this issue, call the bitmap_free() function after successfully
unregistering the notifier chain. This prevents lineinfo_changed_notify()
from being called, thus avoiding the use-after-free race condition.

Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d09c7d728365..6b3a43e3ba47 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2799,11 +2799,11 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
 
-	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
 	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
 					   &cdev->lineinfo_changed_nb);
+	bitmap_free(cdev->watched_lines);
 	gpio_device_put(gdev);
 	kfree(cdev);
 
-- 
2.25.1


