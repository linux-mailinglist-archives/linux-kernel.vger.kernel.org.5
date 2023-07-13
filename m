Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5C751B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjGMIYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjGMIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:24:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE53C1E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQolX8qBKebZShbIt7oZQXWr5DhwmOFIof6zcrhw7cZ42TuWOU/bVO/aRjA/t6fPutMUm0MDmunUqSARBpho6yuRGVoGa/JGLWroy8TU3C6rp8qzsQ3DUn0JkkfgB9601WkFD5MniNDW68n7Ss4PuvogL/+JHY6+El22H4YDZye3CHZ0Pb0mCjh62lErypac5+OynoKZSYh9aWf78/Ysn/nCKmHBoZ6uwB8SkLM3GzYkMbPKx9XKqrf4eNUU+X3LU173PRb9ola8fe6mI3goRappd3OpWU7b/lIFjofz8JcE0sEc494Vft7TzPFcCYJbBpyyUpvHSYPAYHl8Se0+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoj4WiEE3DwP8/N3bZM0fkuXe1WoGm3w9LsKLj1MqlU=;
 b=LnnOEdsLeL+Va8lF8axnc5UgBNvPReid3iwNpBPKhNhl8uwQ3tEAznpztgIcBbcoHcHa4W3z0xJHGCji9CQPt5yE/J+hEeOhihzIGIQcTo2+KjF13rVGTFJYKv5NMFZhdrDCL6cC6x6VJr+1URm84zdWQDZIqJnM36+rcZcKQjOwb5uJmmhxnDkc6OsDW/aNCU0cIF9wTeplG4OiEGOtCVgWj06jWMeh5C4R/HBwnY7jt4blK57H1LoEhN+jTNE7LQ9gZY34xXJ3Dt2c5jpO0/eftfKC5DhGrAuUcrsnyKj/SUderW2T9y9bf4xTNJp7kkeuopo+oduvX2Vh0nqZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoj4WiEE3DwP8/N3bZM0fkuXe1WoGm3w9LsKLj1MqlU=;
 b=q0KttmxNRCggk5F/Klx61ledPG1BCBbt2HEx1EXspfAXGYqTO34WN5YP+OsjkcZzuJBzfkw51hP7dZrP7GLW95qtVEpG+Rc1k75LziQ3XEAQn451sz4GXkvxLh+pXsTqo8e8jTVhD3N1McbQhU1xWxv3Pbs1zi2xL1AJ+uavQWJ0rOvqOkNZ0w3shBZxYeoMGLHCXVIkHPHH5k/RBLpKsCi+YNqqKZO72O+e3SKYtELz0uFo6PawMqrHVKrf0QhNHu3l6etnl42Ow7lakXHJkWYZfQTwfbmVGQLFbWaokooywdVNbKTKKhR/8OHEq1MlRoyomJFzvRSQ79VpYKbScg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6349.apcprd06.prod.outlook.com (2603:1096:101:10e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:14:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:14:32 +0000
Message-ID: <67103218-8f89-f4ac-81b7-0d5c54a59220@vivo.com>
Date:   Thu, 13 Jul 2023 16:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 09/18] mtd: rawnand: davinci: Convert to
 devm_platform_ioremap_resource()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707040622.78174-1-frank.li@vivo.com>
 <20230707040622.78174-9-frank.li@vivo.com> <20230712140953.30b5309c@xps-13>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230712140953.30b5309c@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e53f0a7-db94-476d-80e3-08db83793026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBZH4l67znvCuq2EFMd/UgvYqZ+JvoQJXYg/hVs6NBtY8GaKgGpOxr8T/R9/F1407iIdZ1CLJCtBSBUtarS+JdUzFwDPbQx4jFVB5wvrxavwdWJAVh3PFsXnFA72A3gLmhXid2uoztii6BOJFWNaM8YR5EpYBZfhLxo8Y7AXCcn6rF27NQX7fVp6jfSJbl5BnnJwkTCCbPq0uhFnKxuIHS26sa3JtfJbQEXSV6uNxQOXJpwt536HtbMUaYAHAFlv1t3BUVHD42aceE5GlGlLyoWuPl3vgw7zy6kAPfxJR7TDBxU4PoeptRleoEMTScaewSkZsAAw7JHcqcpXHqfJfXuzCIBDvzr4OyI/L3InFrahcy4i1c0+eT0BCQ/X9uVcuK4KgcxUNe30o9Ngg0SMACC8fUTTrq3GTw9gM5k6EdtA1IfbeJ7JFYcfpZ7CIgv4KBZkig/hT7nmRXOa51Aa2f5HyAyCC4HMBMqdcIciCp4FKP3bPjReuxpm8XjhBGQFe/h+N/kexIDaowP62und420BLPHmxcXEpd3Zw4y/qSz9kusPFwYzfQtOu5FbUkKg4w+Jc1G1KBP328gMBwkNpVy10OsMtQepqcfZAaFFBz41MaOIPTcxmQ6SODFWb4HJC1zRRlp2kx2kCp3JWsrEfHdbuXJUCReyegWsoTKcKINr0aP6ilIyeKmAdTI60hmo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(8936002)(8676002)(83380400001)(36756003)(38100700002)(2906002)(38350700002)(66574015)(2616005)(31696002)(86362001)(53546011)(26005)(5660300002)(6506007)(186003)(31686004)(6666004)(4326008)(6916009)(66476007)(6486002)(54906003)(66556008)(66946007)(41300700001)(6512007)(52116002)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmQ5bUJLQ3R6SEd1NmNMNXk4TDJKTVhlOGxGYm5XejNXOFFnQnNIRWU3STNV?=
 =?utf-8?B?QVVobWlwY2U1UHpOa0hRM09aRWZIVk9jNU9CTXVqMU03alc0YW8wcklxOWFB?=
 =?utf-8?B?WnR2Wk00V2tHbGVmQkg0cG1wa0MwV2VhR2VpeDVkdGI4MUFIUFRpZkNZY3Br?=
 =?utf-8?B?WkVVU1E1Wk1rSXdUUkZiZXlDdnFjQmxmV0xBcHJRcVh6SUJucUtNN2N3Y3l1?=
 =?utf-8?B?N3NyU2V2TFRQa1ArZm5pc1lFNFBSY0JIcklkNkZQR1RjV3VGMEhWV0NMQ3Jr?=
 =?utf-8?B?YkcyMFZXbUNuN29XNkoxSm1PRE85VlE0ajJWQjZ4TDd5WUd3aGJaamxyODBE?=
 =?utf-8?B?VnZQWkJxOGMrWkdPZEErVTErNEF0eitiQkRNa0FxaHJId2lXaTZ5cm5GUW15?=
 =?utf-8?B?VkFSUGhkOVFXbWIxRkxLeThNUFlYSzR5SHAvUW1TWW1CaVlWc2NJVTdGVDdR?=
 =?utf-8?B?SFMweVMvNlY3Y0ZxMktOazRDVkMyUEVDV1VPL1dVOStJZUlYV1JZUVdyRGlZ?=
 =?utf-8?B?WnNCYjNqK0kxNGxxaFhsY2JPWXBEWjJpU3NhUkxVMy9ucThxY1lBMll5ZVZC?=
 =?utf-8?B?WTE4SDdpMDhnekZhdE8wOHBFMGgwbnZmbmYwM2oxL1dxL3dqdUNUUVdxVFYy?=
 =?utf-8?B?QjFXRjdTTWkzT0FXMm5pK0dzdmVyd3M4Z3VpMDUyN05PblYrb3NBa3lGQURV?=
 =?utf-8?B?UWNKTlhldk5VeFo5b0huaFlTZDVKdjZkaGIrY0xkZFJjMHdESjJnWDNKYTVI?=
 =?utf-8?B?NnF1Rno1M0ZaUXNkb1ppd2k0bUk5Q2tZdHd6VHd1WVNueFg0VWpPR2IwU0ls?=
 =?utf-8?B?ZnB0b3czYkFyMjNZSVpwZTRYVTE3cWdwOFhydXRzRGdEQUhHOUdBczRxN1Nj?=
 =?utf-8?B?eDJ0alRHaTYzd1ArSWNTaytpUFJkNXg0cHhDVEdSdjFLVG9lWW5iS2U2OFdn?=
 =?utf-8?B?bko0aWtxa0x3TWRGdGdTNlA1eldQVWVsWUZ2L2NTa0RJQnZRMkU2L1p2T2FI?=
 =?utf-8?B?ajFMcVI5bCtzTDNSYkNFUFlZdlJ4bEovS3lZbDRHL1VlQjNoRlU3MHlMYzlv?=
 =?utf-8?B?WU01REI1TDhhSldSb3dGb1VOdHE0T1VwME1XY2NuSXVOTHhjS0F0RkhtUFA3?=
 =?utf-8?B?UHVsMmwzTDJHSHcwUEVEZE9xdEhsREEycFBQcVZENHExOXhXUjJJTTFoVnRi?=
 =?utf-8?B?UmFYTzVCSkF4SmxTRmJ2Y3E3Rm1CZXZ2MDR5L1BYdXpZL1dYSWk1R0dybFdn?=
 =?utf-8?B?WEVCYUNGanU0N0VUR1l6eEo0UXZ5RDd2T3RpUHE5K0JUNjhGVlhhK0VGdy9i?=
 =?utf-8?B?eGFEWGtBK29JbzZNUHh5K01kZHEvSytMZGhPQWtiK0NnV1dIM01LNERIb0dG?=
 =?utf-8?B?QjE1NGMzT3c4MGV1MDRybWtaSzYza1NGNTluQ3ByNmxTRkZLclBUS2lQUGo5?=
 =?utf-8?B?SFBFcU91RXBnT0F5WnVhdU00RkV2NTlzcy94ektiT1dNR212bjFxRFBBd213?=
 =?utf-8?B?SVBURmw2a1RLZFN3TlczK1A5R25yM08vdGFCUWg5ZDBLR2RMVXU2SHd2Yzll?=
 =?utf-8?B?QUM3eEQyWFdrc1ZVOU9xQVBMMW9saW52UERtL0dCSUpjOWJDb0dYVHQ3Q2FP?=
 =?utf-8?B?MmU4OGdXNCtPeUtZbXB1LzhPd2NBb3dUdEp6Tk5jWmNFN3hFTVNYc2d4bGRr?=
 =?utf-8?B?WCtXdjNia2M4cXpQalVhK0hYUE1PMGI2UEpyRkpvbFlYbTVRa084TVhDTmRY?=
 =?utf-8?B?bHZTME9nT3ZBSFk5VWdXRzIwWWVRckRSL0J3RXl5S3JPd0ZmZ0pZYjBDaXJU?=
 =?utf-8?B?UngwWWxaTjhQR0V2Y1F6ZFVwTWYzdThyYkQ1bUg4ZVFOcUtlQVRWM3UyN1Ba?=
 =?utf-8?B?bnFvYTFJcFA2d2p6UjVsSDJpWkp4N1hMZDluYndkMDNzWkNvUW1xa05rNElE?=
 =?utf-8?B?dXF3UWdKWGp5Z2VaSm83RGx1TExaVmtCMUpzK1FFK080dXUzUzUwNm15QWMr?=
 =?utf-8?B?ZDhOcDVtWFVYc0FIME1NWmRVME5YZEJTcDY3RTVYSTBJTUt1TVo2eFQ2V0lj?=
 =?utf-8?B?SUlIaUtqaVluYU01NnppdDFUN3NFTHh4aExXZzFRcGFNOHh6TTF5QThoOUJ0?=
 =?utf-8?Q?w6K7pmi5LoH1/x9UIAdva68eF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e53f0a7-db94-476d-80e3-08db83793026
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:14:32.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHVOh9CpaapwQsqR97lEJtECI+Zqxz2Ioq9ixOm4sM4F1E7mER/DL7h190J9dEhNqxJaSjWbZeaPmamKTfB44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6349
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mique,

On 2023/7/12 20:09, Miquel Raynal wrote:
> Hi Yangtao,
>
> frank.li@vivo.com wrote on Fri,  7 Jul 2023 12:06:13 +0800:
>
>> Use devm_platform_ioremap_resource() to simplify code.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   drivers/mtd/nand/raw/davinci_nand.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
>> index 415d6aaa8255..2db1cd1d3d03 100644
>> --- a/drivers/mtd/nand/raw/davinci_nand.c
>> +++ b/drivers/mtd/nand/raw/davinci_nand.c
>> @@ -710,8 +710,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
>>   {
>>   	struct davinci_nand_pdata	*pdata;
>>   	struct davinci_nand_info	*info;
>> -	struct resource			*res1;
>> -	struct resource			*res2;
>> +	struct resource			*res;
>>   	void __iomem			*vaddr;
>>   	void __iomem			*base;
>>   	int				ret;
>> @@ -736,26 +735,24 @@ static int nand_davinci_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, info);
>>   
>> -	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -	if (!res1 || !res2) {
>> -		dev_err(&pdev->dev, "resource missing\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	vaddr = devm_ioremap_resource(&pdev->dev, res1);
>> +	vaddr = devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(vaddr))
>>   		return PTR_ERR(vaddr);
>>   
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "resource missing\n");
>> +		return -EINVAL;
>> +	}
>>   	/*
>>   	 * This registers range is used to setup NAND settings. In case with
>>   	 * TI AEMIF driver, the same memory address range is requested already
>>   	 * by AEMIF, so we cannot request it twice, just ioremap.
>>   	 * The AEMIF and NAND drivers not use the same registers in this range.
>>   	 */
>> -	base = devm_ioremap(&pdev->dev, res2->start, resource_size(res2));
>> +	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>   	if (!base) {
>> -		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res2);
>> +		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res);
> I believe this is the only use of the resource, I am in favor of just
> using the regular devm_platform_ioremap_resource() helper here and just
> drop the reference to the resource from the message.


I guess maybe you can apply this patch directly?


It should be noted that devm_ioremap_resource is not the same as 
devm_ioremap,

here is devm_ioremap (devm_request_mem_region will not be called, and 
there are comments explaining why this interface is needed),

which means that we cannot simply replace it with 
devm_platform_ioremap_resource.


MBR,

Yangtao


>
> I will apply all other patches, please send a v2 only for this one
> once improved.
>
>>   		return -EADDRNOTAVAIL;
>>   	}
>>   
>
> Thanks,
> Miquèl
