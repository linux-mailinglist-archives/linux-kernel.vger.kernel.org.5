Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129817A4640
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbjIRJnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjIRJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:43:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB71B1;
        Mon, 18 Sep 2023 02:41:36 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I8v258029351;
        Mon, 18 Sep 2023 04:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=tDYDrUE8KUp7GB4gAn7w0+RcJkFc+kAlLQPGRSM5MI0=; b=
        AmiVsjgACewQFGYadXqbHRvJlbelXRFxRlVmvCNRsb2YGLS8SQEqrv+wQCfGK7Tv
        3Tpjwxj+XQsOQs+mkJIKEyagA63dWvvHjSFRmpfmi0eth4QR3mzMeh/AJ7IaOcAc
        amNQhrQIiu8UpbS5kYsKTIl/PVXV2QNJ4RUt7dS2mo4BsIVCAUurwNOR+nGlRLYq
        SPIuwSJ/hm2QQBtYEyNfvVvo/lX5kEV+l5l38g8XK9dz6Nt9TqXyGs8zuiNMNfdw
        IL27KCxM2wYnZjFLYLCBQ2MW880uCtLN98UwVYAPIMKH6Ib5QocSahCJaWNqhzoP
        Uld65Kj81kskNCrla4aggQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shsmpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 04:40:53 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 10:40:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 10:40:52 +0100
Received: from [198.90.238.137] (EDIN4L06LR3.ad.cirrus.com [198.90.238.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1215B11AA;
        Mon, 18 Sep 2023 09:40:51 +0000 (UTC)
Message-ID: <b67c7c31-9d20-4e62-adf6-0ab0c678bed2@opensource.cirrus.com>
Date:   Mon, 18 Sep 2023 10:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next v2 03/10] iio: accel: fxls8962af: convert to
 EXPORT_NS_GPL_RUNTIME_PM_OPS()
To:     Raag Jadav <raag.jadav@intel.com>, <rafael@kernel.org>,
        <len.brown@intel.com>, <pavel@ucw.cz>,
        <Jonathan.Cameron@huawei.com>, <paul@crapouillou.net>,
        <andriy.shevchenko@linux.intel.com>, <lars@metafoo.de>,
        <rmfrfs@gmail.com>, <jean-baptiste.maneyrol@tdk.com>,
        <lee@kernel.org>, <laurentiu.palcu@oss.nxp.com>,
        <l.stach@pengutronix.de>, <james.schulman@cirrus.com>,
        <david.rhodes@cirrus.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <patches@opensource.cirrus.com>,
        <mallikarjunappa.sangannavar@intel.com>, <bala.senthil@intel.com>
References: <20230918080951.3615-1-raag.jadav@intel.com>
 <20230918080951.3615-4-raag.jadav@intel.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230918080951.3615-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pCPaWPCaYvDXkhq71Lq1IqHI-dv8mtpT
X-Proofpoint-ORIG-GUID: pCPaWPCaYvDXkhq71Lq1IqHI-dv8mtpT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/9/23 09:09, Raag Jadav wrote:
> With original macro being renamed to EXPORT_NS_GPL_RUNTIME_PM_OPS(),
> use the new macro.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/iio/accel/fxls8962af-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index be8a15cb945f..69e73c54047e 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -1282,7 +1282,7 @@ static int fxls8962af_resume(struct device *dev)
>   	return 0;
>   }
>   
> -EXPORT_NS_GPL_DEV_PM_OPS(fxls8962af_pm_ops, IIO_FXLS8962AF) = {
> +EXPORT_NS_GPL_RUNTIME_PM_OPS(fxls8962af_pm_ops, IIO_FXLS8962AF) = {
>   	SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
>   	RUNTIME_PM_OPS(fxls8962af_runtime_suspend, fxls8962af_runtime_resume, NULL)
>   };
This change doesn't make sense. It changes the struct definition to use
a EXPORT_*_RUNTIME_PM_OPS() macro, which leads me to expect this is
exporting runtime pm ops. But then the struct has both SYSTEM and
RUNTIME functions.

Maybe the underlying implementations of the macros result in "doing the
right thing", but the source reads like it must be a mistake.

