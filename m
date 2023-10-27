Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6A7D9CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjJ0P3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJ0P27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:28:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968AEC1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzYd2vvcFeuVO4JK4qg/zKIeaU4s73T5WFIHDdg0Bxvw42hdMXXk7pzg6TaQE2/E49mkorC++jehGOuEFHZGrE6yRZMNmgRoFnVWHje6JWrNJ2jGVypdXLDfQdErdTFThllERKeQpyPjKw2lVLpskVelUga5u8OVQL5QE9l1XggyZi6e5MjI9Gt0WbUXUnvhr/BGdiEW3xGy46CyYqcsO/6/0MrMod4ymVCZbRLPxG7vI/RxONCwDjA6JG4K4sebA+6wS6/Hbaej57njUanvFUrBmzItNHz9QrgIqaBHWzGV8laCYrz/1XM9uMoeAW9uHDsYsNkru0xVK8kBD6blbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtbOVlXbosrTtuuTZ7N8irtajcdeLKvZNATHCl8fr64=;
 b=Z8LNMdUVfbBpkDt+yJAI/+0O1MmcEsHIM19/DAP914xu8cEIWHK7U+1VedSP7S1I4CgcQ4qouUnUk0Qr0dUXikfmqu7BbCKAGiHWAwizNmPjqoalPU1lJQmoE7IxfOhkj/jUTplmZ2R53OKUzbk1Asfo+pvAhZKy3WsxlMdIQIeBISotZkxx6sTkNd/9Ua9CqFfp/DosNttK5+GLdVHhBd5ckr4xAgXbPLtyrX1oPK3dtLMPI+/H6mv+CINKaIyKGpExl1SQokex5zCPkjMtpEaabhwmGBXsC4p4KXaLpU/Ejb9JogfD7YU67kJjpM5buu31qxQnFfy/Up8A8RZLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtbOVlXbosrTtuuTZ7N8irtajcdeLKvZNATHCl8fr64=;
 b=Lrdv3qU2MloMZ6g/uLTqm6b3toSSmUkrry94/yJRjuy6JgqwNu3wMsXrftDfk8piKVQL/CeA4rx13YF/DpQDa9+WARJNzAZIwUNm3BVQDUNdLFl5EMbZDTVAmiHXwczwswb+zzIo2+bWpvn4M9yhewHQVKi73vMmdTQIMBXsna0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 15:28:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 15:28:53 +0000
Message-ID: <3ec97548-1f91-49d0-adfb-4f8051ca9a97@amd.com>
Date:   Fri, 27 Oct 2023 10:28:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ASoC: amd: acp: add machine driver support for pdm
 use case
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        arungopal.kondaveeti@amd.com, mastan.katragadda@amd.com,
        juan.martinez@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <20231021145110.478744-9-Syed.SabaKareem@amd.com>
 <4d5a4c67-2f4b-4111-b98b-ef575543fa6e@kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4d5a4c67-2f4b-4111-b98b-ef575543fa6e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fec81c8-1949-46e4-331f-08dbd7016d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43Q8tRZUaZSDFQ7gihyJ69+DIocLJJizfS/Cv9Mq8j0M6UYHHqbEUygRdNo2/sR+z1pZ+gD4WX9tYDIWFccibgsU/K/WR5CsPIZstVa4L1BAjhPUteXxDyKtMFdCEmmAD/oLMM8BPMRqAyuFuXS8o3tKtsw2LwCiQ/GxGhFSRmWCrdGZ8bQigsl8yyIqLfhg6ynE8JyyfJufriEAnpMsbcftoI03Y1O8nV+DtfTtfUSrGAsBJQNDOV18992+bbioLJjrSZTvWwjE6oCozwe2m1hGzqzhPmWi1AJsYClpWMu0r0ezLf0TYWRjxM4xiWhPAsGpQgPjnjeSWIqdMhfxsA5JCP+jNmqJ+XrcGFRAo7aGQdCN7bHpe4icu8yFTpKFuPqa5Ws1Sji0C2U5wqGZshObAiTjshUuWKtHX6kg81vSFW6w6/o30j3SbgUbNSEV594Ibh1Bii5V49zOTg3yiP3VfXtmibNMVE5V64gs2E4CRmjmFe2tXZFrpk/F2QdDRtcfQF6bjRdki6il27lYaLOHhpmf+Xdg09sP5QMbaMtvMvBZqErp/Z3Es7TLXgGfDnRQix6ZjTwzOszzpcT6qCJC0GyjIRUxdTtbLmvDiAJLJiNuId+mXylxP3GpK7YqIG7U9oHNR+85Qa+sn2EOAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(31686004)(41300700001)(38100700002)(2906002)(6506007)(44832011)(5660300002)(31696002)(7416002)(4326008)(36756003)(86362001)(8676002)(8936002)(478600001)(2616005)(54906003)(66946007)(110136005)(66556008)(6666004)(66476007)(83380400001)(6486002)(316002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJQNzRkTEovZUlRbEEvL2pNK3BDRXMxTkp5Mml5aUU0cStWcVhjWDVUbXFB?=
 =?utf-8?B?L0p5VnNyMk1pbnhMS2kzOXRlbFZQZzVuZkx3ODZ1d2JpUXl5Qi93QWw0aTVx?=
 =?utf-8?B?alg2SFNQVlVTeDB6cU50aWFLZ21zWEw0Znk2VHkzaEpqVzNFbmpKdzRUK2NP?=
 =?utf-8?B?ZEdmUkdqODR6RkxhZDd1YXVGU0o1WmdiSUE2MDJHR29wUXQxaWw2MExWUHFR?=
 =?utf-8?B?ZXBjUkdzL2lBOENXTkY2bGcyVnJ6US93am05V2VtZ1pwNkdxUEI2SFhqRmhh?=
 =?utf-8?B?R0FyT0NSS05jZHRSSklEcW05cGF0c3dFeldxSk56Rzdia0haLzk4ckxtMzhi?=
 =?utf-8?B?bVZVVEh6S1VyMTNQdWtLU3B6VWJiUFhEaGFzWEpRYWRnNnFkUWVsa3hEUDhi?=
 =?utf-8?B?ZHU0U2Uyd2MrZGthUnFGbHVWSjdKU0xTbFdVMTgweGt0Z2dRMFJEVlJWbER6?=
 =?utf-8?B?bUVzMnFvSXdiN0tWNWp0UFRvQ2VaeVRvOVRGdHN4dlBPNTlYaklxbHY2NzlI?=
 =?utf-8?B?SkJZK05UZzVaVmNVSFFDalpvU2FaYU93MnVLMW55eUlDcTFzM2tUMG9TMnNp?=
 =?utf-8?B?SXdkK2czdllwazQxS3ZRMUYzUzNVM2ljbmRCSUhxOWdId3UrcnZXYnF1S3VJ?=
 =?utf-8?B?UXh3UEJJMDRNTnhYYkpmeTNhbThKT3ZGaGh4NkZhRnhiV1QvOGd3dVcyWnNq?=
 =?utf-8?B?UHU2TXF3Y1hsM2JGS29zVTBHenovcW9xV25tdjVDWFljWlZ4VjUreS9uczg0?=
 =?utf-8?B?M2EvV3EvTThMQlZGUEN5UHJVUDJTSks2RThZUzJjQU5RUVJ3dWRJQWNTeEpH?=
 =?utf-8?B?WVp1czhxM0txcWdhQTY1TGo4S3NDb0xSc2N6YlVYaXo2WjlzOVpEOXNHdExi?=
 =?utf-8?B?ZUM4NXpMaWZqK2phdFlTWGRITTd6Tmw4MEt2c2JiUC9iVDE1WVZXemhkWWcy?=
 =?utf-8?B?NWM1QlVWbnlDT3J2eWtjVFN2ZkY3QlducjR2WllqZGF3WXJSVEw0cmpoNUE5?=
 =?utf-8?B?TXRURU90ZVRwR1N1VkthTm9hSmFvOEJ0aDhqaUdMMXk5Rmw5dkF0N08zeE1v?=
 =?utf-8?B?N2VKQXRNSVQ3NUtrWnRUdnhhOUV4K1RhUnRGY0RBb2owc2JaOHV6Tzd5MnA1?=
 =?utf-8?B?TkV5SG9BOUs3Y0krVmpaRFQ2RUFQZGY3ci8rUjlNTitlNDJuTWVFc1A0blpM?=
 =?utf-8?B?NDl1QUZZcU9DUEQzbkt4ZUpUYTBJRWc2R0RGbnpxdzZIQm10M1Q3cTNzVmZG?=
 =?utf-8?B?c3RQMkhRUVpiWWlyeHJHTm45TlJsUWVyWDdNbjJtS2s4cnh2UnBaSHdEc3RD?=
 =?utf-8?B?Q1RMVVZBQml5dmFWQ3lMNDlpUjNTRHBTNGtvOWtuVGIvKytrMlB5bXM4TjQy?=
 =?utf-8?B?bFpWYUI1Y0VhOGdEZ1kvb216OUdDNWt0Zk8yMHlCRitxMWVtNmUvaU4remR5?=
 =?utf-8?B?Rll1eFpqLy9JQ1JJcVQ1dW00OTI0NXZjTG95UXpIak55SVd2U3BzampKVEJi?=
 =?utf-8?B?UFhBRjNSUEVHMlloZ3JjZHNla1EydUorSjRMekI2bXJaVmxYMU04Tzk1cVJM?=
 =?utf-8?B?eVNpNUdDRE5NTkEzWkUxUEVRWDRya1hyUjFKb3kwRXNPQ2FlTHJiUlNOTkZV?=
 =?utf-8?B?VXduZDdYcUF3YWF3QjRVNHlVV3lEWkc1ZmR0aW43T05NS25rcksxNjVSTSt3?=
 =?utf-8?B?NnhiaDdXcmkrQXRBaXJ5THpWUlptSUR1Y3kwL1h3SmJmNTRuZGl3aHZVYzlq?=
 =?utf-8?B?ZkJMSnBtWEdkV0VNZ244R3dEckl1UDFYdHl5OG5qT0UwVnY1M2tYU05qbTRs?=
 =?utf-8?B?SFQvVkJzeWYvZmNIR0tCV0FpeHBQZURNRVdSQXlsYkVaT2dYcFFHdTlRZzQr?=
 =?utf-8?B?ZmVUMXkxczU4bklDNk5ueFd5YzI4bWhQZ1hQODljZXBLY21rNGt0WDhHSmpF?=
 =?utf-8?B?YmtOZE05S1BSbkxUOXVSK2JDRGJQWFdNWVR1c0EzSEthRXBpeGVPQlpydGNW?=
 =?utf-8?B?VFJiSzFiNWI2cmROQ3J0UlI1OU5Ram1qMkhKYVVvdE9MQjVSWm03TXc3eC8x?=
 =?utf-8?B?aXVGa0VWR2RlUEZtazUzZWhkV2cySllhVHllcldWK0t2WG5BTWZTOVA4QWlu?=
 =?utf-8?Q?8+B2PwqN0aVarbSoaV7zp/LuE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec81c8-1949-46e4-331f-08dbd7016d48
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:28:53.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GrzFqG411qxpjGQCpTZGC8L1+guKLUPppUbG4UhXGCD/0/0T0ZW9u58Ea6nGOenhm6s+G+FOwN8plmgErJ3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 03:49, Krzysztof Kozlowski wrote:
> On 21/10/2023 16:50, Syed Saba Kareem wrote:
>> add pdm use case machine driver support
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> ---
> 
> 
>>   	dmi_id = dmi_first_match(acp_quirk_table);
>>   	if (dmi_id && dmi_id->driver_data)
>> @@ -214,6 +221,10 @@ static const struct platform_device_id board_ids[] = {
>>   		.name = "rmb-rt5682s-rt1019",
>>   		.driver_data = (kernel_ulong_t)&rt5682s_rt1019_rmb_data,
>>   	},
>> +	{
>> +		.name = "acp-pdm-mach",
>> +		.driver_data = (kernel_ulong_t)&acp_dmic_data,
>> +	},
>>   	{ }
>>   };
>>   static struct platform_driver acp_asoc_audio = {
>> @@ -235,4 +246,5 @@ MODULE_ALIAS("platform:acp3xalc5682s1019");
>>   MODULE_ALIAS("platform:acp3x-es83xx");
>>   MODULE_ALIAS("platform:rmb-nau8825-max");
>>   MODULE_ALIAS("platform:rmb-rt5682s-rt1019");
>> +MODULE_ALIAS("platform:acp-pdm-mach");
> 
> Please stop growing the aliases. Module alias is not a substitute for
> missing MODULE_DEVICE_TABLE.
> 
> Best regards,
> Krzysztof
> 

I thought the way that this works is that top level ACP driver (IE 
acp-pci.c) will have MODULE_DEVICE_TABLE.  This is how that module gets 
loaded.

Then it creates platform devices based on the detected needs for the 
situation and the creation of those platform devices triggers a uevent 
which due to MODULE_ALIAS will get appropriate other platform drivers 
like this one loaded.
