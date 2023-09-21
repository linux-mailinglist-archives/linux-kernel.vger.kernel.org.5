Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9197AA5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjIUXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIUXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:37:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65362118;
        Thu, 21 Sep 2023 16:37:25 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNarOx004967;
        Thu, 21 Sep 2023 23:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZF1HOHJ4+0Oiu5uMhASsG4TEE+xc+BWii/tNbIg7Pb4=;
 b=d6zf153tTax/HRIf/By3yDijC/Gl0nRrPNbwWQJIvXgRt9Imi6SXpAYmJRApnvSXLqtm
 7htbDxisaoflxyAp/Yv3bFmZIDvg+kqeAnBrE8N231d219DgtlrLZOcOuYBom307qoFd
 JjDU6zUB8iP468naEYcHj0XVkc2+DAYj1fFXn5xgCGwETY3aGjkN3IwRwTMlDxKaSc8P
 hHCEywk51nR5wv0gksq6N6rElskI/cXkUxsGfBjWC+kWFH7AavduOAiI1hngzAo8EZdP
 7RBLggc6IeTLoMVtVIDVmiz+Ci8o1krc+iHh0GarKlYdMjdMwN7QT+sX2VjgE5N6IrPo yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8tsaeb8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LNarBN005003;
        Thu, 21 Sep 2023 23:37:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8tsaeat0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LN7uvC018819;
        Thu, 21 Sep 2023 23:32:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsnmrbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:32:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNW5Wr58523930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:32:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEDE658053;
        Thu, 21 Sep 2023 23:32:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 877DD58043;
        Thu, 21 Sep 2023 23:32:03 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 23:32:03 +0000 (GMT)
Message-ID: <2ab26484-3abe-f741-e7b1-83135dd95d2c@linux.ibm.com>
Date:   Fri, 22 Sep 2023 01:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next v3 09/18] net/smc: introduce SMC-D loopback
 device
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-10-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1695302360-46691-10-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zIhV9e4mhmF4hie6dKx3yKJxR1YToHfe
X-Proofpoint-ORIG-GUID: cop2xSjkCrGpfJK39vCeLC53zjPjq9Bq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210205
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.23 15:19, Wen Gu wrote:
> This patch introduces a kind of loopback device for SMC-D. The device
> is created when SMC module is loaded and destroyed when the SMC module
> is unloaded. The loopback device is a kernel device used only by the
> SMC module and is not restricted by net namespace, so it can be used
> for local inter-process or inter-container communication.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/Makefile       |   2 +-
>   net/smc/af_smc.c       |  12 +++-
>   net/smc/smc_loopback.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h |  31 ++++++++++
>   4 files changed, 200 insertions(+), 2 deletions(-)
>   create mode 100644 net/smc/smc_loopback.c
>   create mode 100644 net/smc/smc_loopback.h
> 
> diff --git a/net/smc/Makefile b/net/smc/Makefile
> index 875efcd..a8c3711 100644
> --- a/net/smc/Makefile
> +++ b/net/smc/Makefile
> @@ -4,5 +4,5 @@ obj-$(CONFIG_SMC)	+= smc.o
>   obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
>   smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
>   smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
> -smc-y += smc_tracepoint.o
> +smc-y += smc_tracepoint.o smc_loopback.o
>   smc-$(CONFIG_SYSCTL) += smc_sysctl.o
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 7eab600..bc4300e 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -53,6 +53,7 @@
>   #include "smc_stats.h"
>   #include "smc_tracepoint.h"
>   #include "smc_sysctl.h"
> +#include "smc_loopback.h"
>   
>   static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
>   						 * creation on server
> @@ -3552,15 +3553,23 @@ static int __init smc_init(void)
>   		goto out_sock;
>   	}
>   
> +	rc = smc_loopback_init();
> +	if (rc) {
> +		pr_err("%s: smc_loopback_init fails with %d\n", __func__, rc);
> +		goto out_ib;
> +	}
> +
>   	rc = tcp_register_ulp(&smc_ulp_ops);
>   	if (rc) {
>   		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
> -		goto out_ib;
> +		goto out_lo;
>   	}
>   
>   	static_branch_enable(&tcp_have_smc);
>   	return 0;
>   
> +out_lo:
> +	smc_loopback_exit();
>   out_ib:
>   	smc_ib_unregister_client();
>   out_sock:
> @@ -3598,6 +3607,7 @@ static void __exit smc_exit(void)
>   	tcp_unregister_ulp(&smc_ulp_ops);
>   	sock_unregister(PF_SMC);
>   	smc_core_exit();
> +	smc_loopback_exit();
>   	smc_ib_unregister_client();
>   	smc_ism_exit();
>   	destroy_workqueue(smc_close_wq);
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> new file mode 100644
> index 0000000..7d88856
> --- /dev/null
> +++ b/net/smc/smc_loopback.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Shared Memory Communications Direct over loopback device.
> + *
> + *  Provide a SMC-D loopback dummy device.
> + *
> + *  Copyright (c) 2022, Alibaba Inc.
> + *
> + *  Author: Wen Gu <guwen@linux.alibaba.com>
> + *          Tony Lu <tonylu@linux.alibaba.com>
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <net/smc.h>
> +
> +#include "smc_ism.h"
> +#include "smc_loopback.h"
> +
> +static const char smc_lo_dev_name[] = "smc_lo";
> +static struct smc_lo_dev *lo_dev;
> +
> +static const struct smcd_ops lo_ops = {
> +	.query_remote_gid	= NULL,
> +	.register_dmb		= NULL,
> +	.unregister_dmb		= NULL,
> +	.add_vlan_id		= NULL,
> +	.del_vlan_id		= NULL,
> +	.set_vlan_required	= NULL,
> +	.reset_vlan_required	= NULL,
> +	.signal_event		= NULL,
> +	.move_data		= NULL,
> +	.supports_v2		= NULL,
> +	.get_system_eid		= NULL,
> +	.get_local_gid		= NULL,
> +	.get_chid		= NULL,
> +	.get_dev		= NULL,
> +};
> +
> +static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
> +					  int max_dmbs)
> +{
> +	struct smcd_dev *smcd;
> +
> +	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
> +	if (!smcd)
> +		return NULL;
> +
> +	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
> +			     GFP_KERNEL);
> +	if (!smcd->conn)
> +		goto out_smcd;
> +
> +	smcd->ops = ops;
> +
> +	spin_lock_init(&smcd->lock);
> +	spin_lock_init(&smcd->lgr_lock);
> +	INIT_LIST_HEAD(&smcd->vlan);
> +	INIT_LIST_HEAD(&smcd->lgr_list);
> +	init_waitqueue_head(&smcd->lgrs_deleted);
> +	return smcd;
> +
> +out_smcd:
> +	kfree(smcd);
> +	return NULL;
> +}
> +
> +static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
> +{
> +	struct smcd_dev *smcd;
> +
> +	smcd = smcd_lo_alloc_dev(&lo_ops, SMC_LODEV_MAX_DMBS);
> +	if (!smcd)
> +		return -ENOMEM;
> +
> +	ldev->smcd = smcd;
> +	smcd->priv = ldev;
> +
> +	/* TODO:
> +	 * register smc_lo to smcd_dev list.
> +	 */
> +	return 0;
> +}
> +
> +static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
> +{
> +	/* TODO:
> +	 * unregister smc_lo from smcd_dev list.
> +	 */
> +}
> +
> +static void smc_lo_dev_release(struct device *dev)
> +{
> +	struct smc_lo_dev *ldev =
> +		container_of(dev, struct smc_lo_dev, dev);
> +	struct smcd_dev *smcd = ldev->smcd;
> +
> +	kfree(smcd->conn);
> +	kfree(smcd);
> +	kfree(ldev);
> +}
> +
> +static int smc_lo_dev_init(struct smc_lo_dev *ldev)
> +{
> +	return smcd_lo_register_dev(ldev);
> +}
> +
> +static int smc_lo_dev_probe(void)
> +{
> +	struct smc_lo_dev *ldev;
> +	int ret;
> +
> +	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
> +	if (!ldev)
> +		return -ENOMEM;
> +
> +	ldev->dev.parent = NULL;
> +	ldev->dev.release = smc_lo_dev_release;
> +	device_initialize(&ldev->dev);
> +	dev_set_name(&ldev->dev, smc_lo_dev_name);
> +
> +	ret = smc_lo_dev_init(ldev);
> +	if (ret)
> +		goto free_dev;
> +
> +	lo_dev = ldev; /* global loopback device */
> +	return 0;
> +
> +free_dev:
> +	kfree(ldev);
> +	return ret;
> +}
> +
> +static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
> +{
> +	smcd_lo_unregister_dev(ldev);
> +}
> +
> +static void smc_lo_dev_remove(void)
> +{
> +	if (!lo_dev)
> +		return;
> +
> +	smc_lo_dev_exit(lo_dev);
> +	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
> +}
> +
> +int smc_loopback_init(void)
> +{
> +	return smc_lo_dev_probe();
> +}
> +
> +void smc_loopback_exit(void)
> +{
> +	smc_lo_dev_remove();
> +}
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> new file mode 100644
> index 0000000..0f7583c
> --- /dev/null
> +++ b/net/smc/smc_loopback.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Shared Memory Communications Direct over loopback device.
> + *
> + *  Provide a SMC-D loopback dummy device.
> + *
> + *  Copyright (c) 2022, Alibaba Inc.
> + *
> + *  Author: Wen Gu <guwen@linux.alibaba.com>
> + *          Tony Lu <tonylu@linux.alibaba.com>
> + *
> + */
> +
> +#ifndef _SMC_LOOPBACK_H
> +#define _SMC_LOOPBACK_H
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <net/smc.h>
> +
> +#define SMC_LODEV_MAX_DMBS 5000
> +
> +struct smc_lo_dev {
> +	struct smcd_dev *smcd;
> +	struct device dev;
> +};
> +
I'm just wondering why don't use pointer for dev?

> +int smc_loopback_init(void);
> +void smc_loopback_exit(void);
> +
> +#endif /* _SMC_LOOPBACK_H */
