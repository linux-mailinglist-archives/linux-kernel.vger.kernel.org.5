Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851B77296B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjHGPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHGPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:38:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FC10DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:37:55 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FboLE052026;
        Mon, 7 Aug 2023 10:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691422670;
        bh=FMHqZNEApmRwna7Z7k6VSvYjm3zUkpCE3DjcWAg7vQo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JYYUJmyTQ1YL6uZFTrf3l3EBWIguIj8mycPFEXFvIIoi69+tyOu0IohHpTIavS/9S
         Jq2NOtCCt5JJw2T7Nvo3zzs/gCOBEqUZCTXRT9YXls5xEAGDbvWfSir6J2rbqOETuy
         U/2r2BtdyhDL+RnGE2wZC0lM26s1fnVEmxyZg4ik=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FborK107002
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:37:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:37:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:37:49 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Fbn9K029221;
        Mon, 7 Aug 2023 10:37:49 -0500
Message-ID: <08ff46b0-09e6-fd04-afee-99ccc1d9274b@ti.com>
Date:   Mon, 7 Aug 2023 10:37:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] reset: ti: syscon: remove unneeded call to
 platform_set_drvdata()
Content-Language: en-US
To:     Alexandru Ardelean <alex@shruggie.ro>,
        Andrei Coardos <aboutphysycs@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <s-anna@ti.com>
References: <20230807111534.12392-1-aboutphysycs@gmail.com>
 <CAH3L5QrdF3fZDKV4FvsO+czgWyWNxKZE3yaxP7C94o0oyLZ6HQ@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAH3L5QrdF3fZDKV4FvsO+czgWyWNxKZE3yaxP7C94o0oyLZ6HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 6:57 AM, Alexandru Ardelean wrote:
> On Mon, Aug 7, 2023 at 2:15 PM Andrei Coardos <aboutphysycs@gmail.com> wrote:
>>
>> This function call was found to be unnecessary as there is no equivalent
>> platform_get_drvdata() call to access the private data of the driver. Also,
>> the private data is defined in this driver, so there is no risk of it being
>> accessed outside of this driver file.
>>
> 
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> 
> // also adding the people listed as MODULE_AUTHOR
> // the list seems a bit short otherwise; no idea if these emails work
> 
>> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
>> ---

LGTM,

Acked-by: Andrew Davis <afd@ti.com>

>>   drivers/reset/reset-ti-syscon.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
>> index f0dd7ffc3b72..23f86ddb8668 100644
>> --- a/drivers/reset/reset-ti-syscon.c
>> +++ b/drivers/reset/reset-ti-syscon.c
>> @@ -204,8 +204,6 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>>          data->controls = controls;
>>          data->nr_controls = nr_controls;
>>
>> -       platform_set_drvdata(pdev, data);
>> -
>>          return devm_reset_controller_register(dev, &data->rcdev);
>>   }
>>
>> --
>> 2.34.1
>>
