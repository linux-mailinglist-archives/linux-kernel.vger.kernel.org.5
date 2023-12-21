Return-Path: <linux-kernel+bounces-8279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1A81B4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA8A288A62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40956BB47;
	Thu, 21 Dec 2023 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HomG0TKz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FB6AB8F;
	Thu, 21 Dec 2023 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu/CqHfUK46ymveeixBOuqSPcQaqgEOapwoRPXn4DTRTP2LHkXoJTxr7bbuFTx8k09nlS0DsUvmx63RPzhNsvcWK2geQy5N3/Scp5C8zyv/Ep6QfC7UVFdOLrdLJgLwF83M4r3G3u/pzO+OBZLCR/v/3DZ61JVQkpAr+4Sn8vjIWyLcda4F1gSbonn5oauFsSgy6UHtsOhvOgyrD1ue6PZp8wBPk+tI5ss+5zwXkIxYZraKO/P3Soo1GKo2kijWYHjN1Rx5AOXyCxgnACelfexkGXwirsKgf8GZI5EWUPlC8J3tWv+2OIM2616MppYfuC+8iNuza6pD4mBqr6a/1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B+nNvRUbBLQ1T+ned3ArZopoI416/HSZgKSIjPr494=;
 b=TgdZbYtkRjK9qeRhSPqigLBALst0nOg4IfYn/81B1ebBi5OGTywzL62i/Tv/grKuARKlz6LERLlbtw+BJGo2NouaKxUReu7WgZ8p+4pbsiMbxpLAbabD5dHeSwdFQzwTr3d2l2idoo2bb9bXJRICq6o+YhcrNvZ98510iw0ImLowEiZttUR7wHyq1DLjFvG/zLT/3+pEFwVgnAb7zQkp4K2qzsBsAb0nrxa+xgJVfuoM69K3mfJ4Dq49Nm+y1YKiNjTzUPs4FlP550C5GF9M5Ap/xlGQs9iLXEbLEc1e/vj8cK8IFK0E3UKLEAZmffjSHLRW7CgTKR3owOR/gvQh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B+nNvRUbBLQ1T+ned3ArZopoI416/HSZgKSIjPr494=;
 b=HomG0TKz9Ad0dI8oGcUFxLkuaJEstR5NkZ1KD0OdlPyqsH/0EIz+b9MBw6v96AqUYr0CQ6ifZIn/N9d19eKT9O3j8W9C9qOu5Y+YRMd0xHGI2gs9yYWyhsG1y/QZaIYFKRU2s09ZDnAZZlqtYliL9/anLn5+9zrAL1RCy0+SpG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 11:24:50 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 11:24:50 +0000
Message-ID: <9bfb12c8-2a38-407c-b9fb-22888c5bb8b9@amd.com>
Date: Thu, 21 Dec 2023 12:24:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ina2xx: Add label property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>
 <e5373897-b868-4b6a-a140-19f80a6cdbb3@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e5373897-b868-4b6a-a140-19f80a6cdbb3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0218.eurprd08.prod.outlook.com
 (2603:10a6:802:15::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fa5a7b-e755-4369-4066-08dc02177199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1cTZBsCXPjFVW16Hvt+dxvEo83vXD1UROKkNa0+N/Xy4jSjLOA8HCAP+IWBOkAP7F7PPGZB2/Tgf4xT+m9ikAT/9oUOgx2cGr1sbkYkNesqw8btAnvejqwpj10NrHHuprE2GWb+1kBRweOpe/XeavqjQx082Z8b3S8pcNrLdG66Ey2Lwt81gCdsfOBEPD1MFMMtmyvMPw/dbNjiy8z3oSEo8rJizN8MKnxViMUGZYpec1Ae0n0PHSK2VU0TmyqgJCsKthV3i+zdmzwAs32SMFEsuoDwBU4/Sy0wngaXc1QVLTtayvybpKfwqb0Z1T56DpNqXSmQENjglztRDEeDt7gqZ355TQKxSHRM3J0UKQ7YOCF535bZENxI0R9hMlfXD9GqEUqWmNDJeUuAEfCeB2VL6nRXavE94mT/V8mBS4Q7qZpKo8hfPCk/NQpe2cauS162EsTU02HzHSoORuG4VpT0heeqDoFQHPyvB6FUcCdrFUJtxyOLGZY2F3j1nsjvj7Nf5FfPJVv3Ztj4VMQkbnPSXL8SerAIUljnY9hLGLszIahl7D7CG73+uxDfy44M/20Wu9kyUAXoPma045QpMkRs6lPdUwBe+ghyPr9L8g8nCJa64Zp3FdNfAnPgOT1uqSJa69AbynJzxN3VlbWh20A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(4744005)(7416002)(53546011)(6506007)(6512007)(8936002)(8676002)(478600001)(26005)(4326008)(2616005)(44832011)(2906002)(66946007)(66556008)(66476007)(54906003)(316002)(36756003)(6486002)(31686004)(6666004)(86362001)(31696002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk5KZ0wxZkI0dmR4dVhPZmplK3JzU0J0OG41eDZyYWNIeW1uL1ErSnFIV2o1?=
 =?utf-8?B?bXdwcGtKOERXejRIZTgxQjdNclY1a3JYSlNnTHpJTHMzZjVpcXk3VEFoQXBJ?=
 =?utf-8?B?aUZWU1h1UGhKcnpWbXpid0dBcVRaTlFORmt2NnZRazBtdVZqOU9mSlg3cCtD?=
 =?utf-8?B?L1JjZlZmTWVWbnpsclNIaThHYXVhYU5UeFVEa0FBWG1FQndtTU9JZ2c0Q0Zv?=
 =?utf-8?B?aWNNZndSMW1jZFRkdVBwSVhKZnp3SDJDOFhnRTBndXNHYzRWdDA2NW05UjRl?=
 =?utf-8?B?VmFOL2RkMEVjMXhvY05vZTh3dnYzNFdNTnBzYjVPUWM4U3hwY0xCOUI1YUE2?=
 =?utf-8?B?czRnRjdPUkRFNlVmNjQ1S3BVUlR5Wmt2TjZHQjRSUExyK0RrVDZ5U1c2Yi9C?=
 =?utf-8?B?QjdRaEl5cTh2K29sQzUrUEpQMnkzQWVMcnZNcmd3VGdiQlBTRno4a0VVYndG?=
 =?utf-8?B?L05uMVlxUEU4aDRVMzdmYVFNSE1PR09aSHBzdnZBNHZ0VGV3Wi9GTWZkV0hh?=
 =?utf-8?B?dzZBV1JUek93QWdmcVoyRUxZcFJvaml5UnZNSEdielJjRFhUVHlKL0tyTnpF?=
 =?utf-8?B?cUJxUllQN2prU2pacGZZYk9Sd0ljaktUc2JJam5vT3hwK01zMDBNNTRUTEMw?=
 =?utf-8?B?RnVORlNjQk4yOU1od1Vvem1qZDYyVkdZKzVmQzdqdXdSb25jL21DbUZDVUlq?=
 =?utf-8?B?Wk5XN3liWW92OEpHdUFVYWxtWTQ5dmpmanNvdlBTSTRlZDloeXdFcCtMSnNx?=
 =?utf-8?B?UEU5bksvNCtPYTc0M3lPRnJHZGpQVDJLNUUrYThRcHR3RVo2aGdlcjFscWJt?=
 =?utf-8?B?RStBdEtVQ25IcVNoZ3krUWpGNXp3eEtkVFRYdkRORFBMMDNkN0NQbXhtcmo1?=
 =?utf-8?B?VVNRZjFBV1RCNjFXVVNnTHM0WVpVK0QxdldVc2thTVAvM1crZGRUU1V2ZkFW?=
 =?utf-8?B?Y0FCUUVOYlBwSE1vZ1A5VFhWcU1tWndTVmpzU28yT1dsMThXZ3JZRWUrVW8r?=
 =?utf-8?B?dUMvNGdCU2lYRGhuMDVMcDZYWjRoZFNlT0MveVpSNk52WUFLZEN6cGk4TDZr?=
 =?utf-8?B?WGtwZlREVkZzMDltQTZxNDg0VDltZUdMT0N0VUZpUjJsV2dKVzhteHNCVFRm?=
 =?utf-8?B?eHJaVkcxS2l5RngrSzZKcTFJVkFHekVkOERuVGs0VFNvMDByRnB5NXBOZDlk?=
 =?utf-8?B?cS84RVB4c201TzhBU0x4Y2dsOGJ5R244QnZsWHVRRlFhUHpGZ3Y4WmZkUWpl?=
 =?utf-8?B?ak9uZUhoNklOR3MxT0Vhc2VxZzJkWm90enZGRjI4MDV1aHk5YWZQWjN0TDRt?=
 =?utf-8?B?WjhKa0VoQVdkc3kxeWpXY1FtVk1EU2xOTTJXVEc3U0pjalgyL2tNUmFZa0Ro?=
 =?utf-8?B?dmtPNi9yTnVqS0pSTTNmV2YrYUwxUU1ld0p4ZnNXSDJISG0rS3AwelU1emhC?=
 =?utf-8?B?bWg3TDRmMGlxcEZKL1VFM0pSV1lJWk1aMWhSM2JieE5ac1ZLbXJxeXFnUFk3?=
 =?utf-8?B?V01UM0hZOUR4WE1IbnJwS0NtNWExY1lNM3RZQ3YrbkM3QWNiU0k2NEYzeGwy?=
 =?utf-8?B?NlpmVlFBcit3c3M1bkFETVVkalA5SVpsd3BaVFMxVjJzVEgzMVFPWFV6N05w?=
 =?utf-8?B?cDZPOVowR1lzRHRYeUFwNGVSYWdrTG8xWjc3cVRiQlVscTFUbEJ6cXNVNXBU?=
 =?utf-8?B?MGphdUxFVXA1N2wzcjNwVlJ5U3ZzSFV0WTlMS3FOSTNBcFhIYllyeFF6UlpW?=
 =?utf-8?B?d1J6QllhcDJmVTVwSFJrUW1CSlNHUWRlNU9WNko1MXBpTUpMR1JyS3hnUWdq?=
 =?utf-8?B?Skl6emxhOHJkNjVmOG1kVmZVekJEdFJ5RStpeDlMSXlTSDB1STQ5U1JNU29x?=
 =?utf-8?B?QW1RZGU3K0ZzWERwc0F2dDR2T01sc1hsY0ZKekg3dGVYRDlCYmhFdXdxKzd5?=
 =?utf-8?B?V0ZWb2RKMHpnQTBJUi81dHFCdzVjMVlwRUFsZEdWMGRGTzFTWFNuUG44S2Vo?=
 =?utf-8?B?OVNDY2xqb0Y1ZndKWWlkTEszRU5PRkxnSkkvck0rSE1hNlJNVkxRUjRwL1BM?=
 =?utf-8?B?bjVobWVnWkx4V0dvc0NxNTFmb244RmpabHNJM2Q0SkdGS3EyT2NrdzhWMDJp?=
 =?utf-8?Q?+go45eeME3e4Go14hqTJvDKzz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fa5a7b-e755-4369-4066-08dc02177199
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:24:49.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G31xgFMBj8Xcs/sgnZMs+IRzAnK4Jzge8kgbGeTJgnJoJe4EhjXrlgYUZzTM4RT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256



On 12/21/23 10:06, Krzysztof Kozlowski wrote:
> On 20/12/2023 14:12, Michal Simek wrote:
>> Add a label property to allow a custom name to be used for identifying
>> a device on the board. This is useful when multiple devices are present on
>> the same board. Similar change was done by commit ffae65fb1ae4
>> ("dt-bindings: spi: spi-cadence: Add label property").
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> zcu102 is using this feature
> 
> Is the driver or driver core parsing it?

I see that functions to be in hwmon and iio cores.

drivers/hwmon/hwmon.c:820:   err = device_property_read_string(dev, "label", 
&label);

drivers/iio/industrialio-core.c:1914:	fwnode_property_read_string(fwnode, 
"label", &indio_dev->label);

Thanks,
Michal

