Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4E7E04CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377792AbjKCOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjKCOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:37:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E003DD43
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:36:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMNWR15lTz67JwR;
        Fri,  3 Nov 2023 22:32:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:36:57 +0000
Date:   Fri, 3 Nov 2023 14:36:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 02/10] ipmi: kcs_bmc: Include spinlock.h
Message-ID: <20231103143657.0000046f@Huawei.com>
In-Reply-To: <20231103061522.1268637-3-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-3-andrew@codeconstruct.com.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:45:14 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> struct kcs_bmc_device defines a spinlock member but the header in which
> it is defined failed to include the spinlock header. In the spirit of
> include-what-you-use, do what's necessary.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
This is fine, but whilst checking it I noticed there is no
forwards def of struct device or appropriate include.

Still that's unrelated
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/char/ipmi/kcs_bmc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
> index fa408b802c79..880d835fb90c 100644
> --- a/drivers/char/ipmi/kcs_bmc.h
> +++ b/drivers/char/ipmi/kcs_bmc.h
> @@ -7,6 +7,7 @@
>  #define __KCS_BMC_H__
>  
>  #include <linux/list.h>
> +#include <linux/spinlock.h>
>  
>  #define KCS_BMC_EVENT_TYPE_OBE	BIT(0)
>  #define KCS_BMC_EVENT_TYPE_IBF	BIT(1)

