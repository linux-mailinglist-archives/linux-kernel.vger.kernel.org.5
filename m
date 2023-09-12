Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910A179C70F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjILGiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjILGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:38:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293610C1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:38:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C6bsh1077744;
        Tue, 12 Sep 2023 01:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694500674;
        bh=LvIsC+Ubd0Y6ukE8pNH2oxR+UXRLkRuzIWVci7LushM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MYgCpxsbK2Q6MskfoqYMSWgBSzkVLzEtofx6s4ocuqVsuP/+7CTXfVfYAGF4oMJ7v
         zsJMP9LQxhEvv0Gx0ucslzpr/+VZpai8GMmTdZ8kgL2k9j0IhuNYfWn2WgpQlQgmkt
         AbJk31j+iKihpoj300UvD42ljkRc6tUiv7Ot8dHg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C6bs4s031131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Sep 2023 01:37:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 01:37:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 01:37:53 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C6boSK030735;
        Tue, 12 Sep 2023 01:37:51 -0500
Message-ID: <d50e7612-0b17-0f65-872f-90e08bed9948@ti.com>
Date:   Tue, 12 Sep 2023 12:07:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] soc: ti: k3-socinfo: Fix the silicon revision misprint
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Thejasvi Konduru <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20230607080349.26671-1-t-konduru@ti.com>
 <20230607104304.iengykppptr3fxe6@reflected>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230607104304.iengykppptr3fxe6@reflected>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 07/06/23 16:13, Nishanth Menon wrote:
> On 13:33-20230607, Thejasvi Konduru wrote:
>> For J721E PG1.1 the silicon revision is reported as 2.0 instead of
> 
> There is no PG1.1. There is SR1.1
> 
>> 1.1. This is because the k3-socinfo.c code assumes the silicon revisions
>> are 1.0, 2.0 for every platform.
>>
>> Fixed this by creating a separate list of silicon revisions for J721E.
> 
> what we are doing is to add to the silicon revision detection.
> 
>>
>> Fixes: 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")
> 
> This is'nt a fixes.
> 
>> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
>> ---
>>   drivers/soc/ti/k3-socinfo.c | 33 +++++++++++++++++++++++++--------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
>> index d15764e19d96..365bc37793a1 100644
>> --- a/drivers/soc/ti/k3-socinfo.c
>> +++ b/drivers/soc/ti/k3-socinfo.c
>> @@ -46,6 +46,8 @@ static const struct k3_soc_id {
>>   	{ 0xBB8D, "AM62AX" },
>>   };
>>   
>> +static char *soc_revision_j721e[] = {"1.0", "1.1"};
>> +
>>   static int
>>   k3_chipinfo_partno_to_names(unsigned int partno,
>>   			    struct soc_device_attribute *soc_dev_attr)
>> @@ -61,6 +63,21 @@ k3_chipinfo_partno_to_names(unsigned int partno,
>>   	return -EINVAL;
>>   }
>>   
>> +void
>> +k3_chipinfo_silicon_rev(unsigned int variant,
>> +			struct soc_device_attribute *soc_dev_attr)
>> +{
>> +	const char *family_name = soc_dev_attr->family;
>> +	int j721e_lookup_arr_size = ARRAY_SIZE(soc_revision_j721e);
>> +
>> +	if (!strcmp(family_name, "J721E") && variant < j721e_lookup_arr_size) {
>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s", soc_revision_j721e[variant]);
>> +	} else {
>> +		variant++;
>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
>> +	}
> 
> I am not comfortable with if else here. Why not extend k3_soc_id
> structure to include the variant LuT? Are there exceptions to this rule
> (Say AM65x?), those would make sense to handle with a compare against
> the partno?
> 

Trying to revive this patch, I see what you are saying is similar to the way 
detection has already been implemented in U-Boot (drivers/soc/soc_ti_k3.c) if 
I'm not mistaken.

But I can't find any existing exception to this "family --> version" rule that 
forces us to use "partno --> version". Checked through all AM65x device TRMs 
available in ti.com; all seem to use common partno. So maybe I am not on the 
same page, did you mean something else?


>> +}
>> +
>>   static int k3_chipinfo_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *node = pdev->dev.of_node;
>> @@ -92,7 +109,6 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>>   
>>   	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
>>   		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
>> -	variant++;
>>   
>>   	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
>>   		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
>> @@ -101,17 +117,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>>   	if (!soc_dev_attr)
>>   		return -ENOMEM;
>>   
>> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
>> -	if (!soc_dev_attr->revision) {
>> -		ret = -ENOMEM;
>> -		goto err;
>> -	}
>> -
>>   	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>>   	if (ret) {
>>   		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
>>   		ret = -ENODEV;
>> -		goto err_free_rev;
>> +		goto err;
>> +	}
>> +
>> +	k3_chipinfo_silicon_rev(variant, soc_dev_attr);
>> +
>> +	if (!soc_dev_attr->revision) {
>> +		ret = -ENOMEM;
> 
> -ENOMEM? I dont see a alloc in the changes.
> 
>> +		goto err;
>>   	}
>>   
>>   	node = of_find_node_by_path("/");
>> -- 
>> 2.40.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
