Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5447C5217
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbjJKLba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjJKLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:31:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534189E;
        Wed, 11 Oct 2023 04:31:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59ZJ0pD6z6K5Wx;
        Wed, 11 Oct 2023 19:31:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:31:24 +0100
Date:   Wed, 11 Oct 2023 12:31:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
CC:     <minyard@acm.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <jk@codeconstruct.com.au>,
        <matt@codeconstruct.com.au>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] ipmi: Move KCS headers to common include folder
Message-ID: <20231011123123.00000394@Huawei.com>
In-Reply-To: <20231010122321.823-2-aladyshev22@gmail.com>
References: <20231010122321.823-1-aladyshev22@gmail.com>
        <20231010122321.823-2-aladyshev22@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 15:23:19 +0300
Konstantin Aladyshev <aladyshev22@gmail.com> wrote:

> The current KCS header files can be utilized by both IPMI drivers
> (drivers/char/ipmi) and MCTP driver (drivers/net/mctp). To be able to
> use them in both cases move the headers to 'include/linux' folder.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
Not particularly important but I wonder if
include/linux/kcs/bmc.h
include/linux/kcs/bmc_client.h
include/linux/kcs/bmc_device.h

might be a cleaner choice given that you are moving them.

I don't care that much though so up to you :)

Jonathan

> ---
>  drivers/char/ipmi/kcs_bmc.c                           | 8 +++-----
>  drivers/char/ipmi/kcs_bmc_aspeed.c                    | 3 +--
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c                 | 2 +-
>  drivers/char/ipmi/kcs_bmc_npcm7xx.c                   | 2 +-
>  drivers/char/ipmi/kcs_bmc_serio.c                     | 2 +-
>  {drivers/char/ipmi => include/linux}/kcs_bmc.h        | 0
>  {drivers/char/ipmi => include/linux}/kcs_bmc_client.h | 3 +--
>  {drivers/char/ipmi => include/linux}/kcs_bmc_device.h | 3 +--
>  8 files changed, 9 insertions(+), 14 deletions(-)
>  rename {drivers/char/ipmi => include/linux}/kcs_bmc.h (100%)
>  rename {drivers/char/ipmi => include/linux}/kcs_bmc_client.h (97%)
>  rename {drivers/char/ipmi => include/linux}/kcs_bmc_device.h (96%)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 8b1161d5194a..d29a8505d6ed 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -5,15 +5,13 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/kcs_bmc.h>
> +#include <linux/kcs_bmc_client.h>
> +#include <linux/kcs_bmc_device.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  
> -#include "kcs_bmc.h"
> -
> -/* Implement both the device and client interfaces here */
> -#include "kcs_bmc_device.h"
> -#include "kcs_bmc_client.h"
>  
>  /* Record registered devices and drivers */
>  static DEFINE_MUTEX(kcs_bmc_lock);
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 72640da55380..3dc0dfb448f5 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -10,6 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/kcs_bmc_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -21,8 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/timer.h>
>  
> -#include "kcs_bmc_device.h"
> -
>  
>  #define DEVICE_NAME     "ast-kcs-bmc"
>  
> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index cf670e891966..bf1001130a6c 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -8,6 +8,7 @@
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/ipmi_bmc.h>
> +#include <linux/kcs_bmc_client.h>
>  #include <linux/list.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> @@ -17,7 +18,6 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  
> -#include "kcs_bmc_client.h"
>  
>  /* Different phases of the KCS BMC module.
>   *  KCS_PHASE_IDLE:
> diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
> index 7961fec56476..160553248a93 100644
> --- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
> +++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/kcs_bmc_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -17,7 +18,6 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -#include "kcs_bmc_device.h"
>  
>  #define DEVICE_NAME	"npcm-kcs-bmc"
>  #define KCS_CHANNEL_MAX	3
> diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> index 1793358be782..24df7144a189 100644
> --- a/drivers/char/ipmi/kcs_bmc_serio.c
> +++ b/drivers/char/ipmi/kcs_bmc_serio.c
> @@ -5,12 +5,12 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/list.h>
> +#include <linux/kcs_bmc_client.h>
>  #include <linux/module.h>
>  #include <linux/sched/signal.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
>  
> -#include "kcs_bmc_client.h"
>  
>  struct kcs_bmc_serio {
>  	struct list_head entry;
> diff --git a/drivers/char/ipmi/kcs_bmc.h b/include/linux/kcs_bmc.h
> similarity index 100%
> rename from drivers/char/ipmi/kcs_bmc.h
> rename to include/linux/kcs_bmc.h
> diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/include/linux/kcs_bmc_client.h
> similarity index 97%
> rename from drivers/char/ipmi/kcs_bmc_client.h
> rename to include/linux/kcs_bmc_client.h
> index 6fdcde0a7169..f6350c9366dd 100644
> --- a/drivers/char/ipmi/kcs_bmc_client.h
> +++ b/include/linux/kcs_bmc_client.h
> @@ -5,8 +5,7 @@
>  #define __KCS_BMC_CONSUMER_H__
>  
>  #include <linux/irqreturn.h>
> -
> -#include "kcs_bmc.h"
> +#include <linux/kcs_bmc.h>
>  
>  struct kcs_bmc_driver_ops {
>  	int (*add_device)(struct kcs_bmc_device *kcs_bmc);
> diff --git a/drivers/char/ipmi/kcs_bmc_device.h b/include/linux/kcs_bmc_device.h
> similarity index 96%
> rename from drivers/char/ipmi/kcs_bmc_device.h
> rename to include/linux/kcs_bmc_device.h
> index 17c572f25c54..65333b68c0af 100644
> --- a/drivers/char/ipmi/kcs_bmc_device.h
> +++ b/include/linux/kcs_bmc_device.h
> @@ -5,8 +5,7 @@
>  #define __KCS_BMC_DEVICE_H__
>  
>  #include <linux/irqreturn.h>
> -
> -#include "kcs_bmc.h"
> +#include <linux/kcs_bmc.h>
>  
>  struct kcs_bmc_device_ops {
>  	void (*irq_mask_update)(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 enable);

