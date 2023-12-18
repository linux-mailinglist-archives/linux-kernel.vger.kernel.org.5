Return-Path: <linux-kernel+bounces-4260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B438179FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA88AB238B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B11DDFC;
	Mon, 18 Dec 2023 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="PTWbJQVO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F71DDD1;
	Mon, 18 Dec 2023 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jStMFX73cD97xFPxIrdQp89I9v0u34b5xz6y0HqparRMAUD1TsCvqLHTjIhiGAU0vw7KZZn/H87viy9r1gWitsnRUXOJ7lHH9TeLPmTI0A+447U+XKpmfjVdyJ1Q6cF/+22ucCSaI/9eYCfLEilfPv69xv+3PVHTDBj33KCm31vHDzINy9V6bNBLqtvlUjPAVN1Vw9H8lMVSM0xP02r6tomLKOAQ9EDcnKzzg3MGADbIg7moznPN7DebaQmuywZFCNx+5hRay9/SD/9IR5Wr/BC4XbAIQt9NOK2wIyRQhEvI7qqxyPDVPrQukCpSrcn2rMWY22pUO5GWjquxtjvDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB93x7vdTjpUXrdZKCaI3J7dENKkZap4iQKE+9IHBAY=;
 b=CodT+P+hQSgmacwb0YOjoPgGVVftWbgYCaTpFMKXNfiTBUFScCk+cSRFV0JBLLL6TJEB6K/O5Y10QeWxn6K7Ul3eztWsLuCj2bfqLssGcV6MBKOLFJqLhfeYCPJ1DEgSo5wpD1cIgGgbfnXtHLhMeCqJEvLgadwnHhR+IlbiMMvAD7KVgInY8A1NA50hDPZdHgAfSJYcMkaeTcp/wuFyzwYpfhR/tZvuY7h3a6fGwhqhZX4ypKcvm8gCWqwcWF49VAa8FFumIYJVkDkfbxNZvAwyG1TDSIiuybsWjewzO0sezchhKKh7tdNhO4hXG3LJXe27o2pOcvgHVTAAu9s1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB93x7vdTjpUXrdZKCaI3J7dENKkZap4iQKE+9IHBAY=;
 b=PTWbJQVOdYDIHS7sS1KcOlz8o2O4FsqPo3KC3bHeeatt4EgyMO4eLOROY+E6c3s9y61YiLOe5zaYqWNoQ5kLFhuPPlWHm1NutNW9/OKCIiZJC//GPOgt7s2KyRD4cJEl6j41kH/+hSFOfEshcWthhdeziZx+FJcMFe6r/LTqLFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
 by PH0PR22MB3103.namprd22.prod.outlook.com (2603:10b6:510:14e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 18:47:42 +0000
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821]) by DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 18:47:42 +0000
Message-ID: <d03e3dfc-ba3c-4474-8094-94c5557021f2@phytec.com>
Date: Mon, 18 Dec 2023 10:47:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] *** Add fixed-paritions to phyCORE-AM62x and
 phyCORE-AM64x ***
To: Andrew Davis <afd@ti.com>, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de, w.egorov@phytec.de
References: <20231215191838.1925082-1-nmorrisson@phytec.com>
 <9f86870c-88cc-43ea-800c-3a05482953aa@ti.com>
Content-Language: en-US
From: Nathan Morrisson <nmorrisson@phytec.com>
In-Reply-To: <9f86870c-88cc-43ea-800c-3a05482953aa@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To DM5PR2201MB1515.namprd22.prod.outlook.com
 (2603:10b6:4:36::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1515:EE_|PH0PR22MB3103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a356312-15ac-436a-3059-08dbfff9d0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjAhmIH+hLo4MWm5qDyDvxNiz4XbXh0f0OTemAGm1a/ZfnDiJztLsomOPmxj6XcKI1a4Rbe6B+1mnCGi0h2W6QYTnl6O4f958jJsAKJ531ETfY64X7PEER5RZmpED2HEuqSwCYkX3iwFKMxUlhpGnHIp1WqkzaI9MWDZlk11S0B8VpDgbtQJg6wupr7a+lEwXVC+tHIJs4za6OHmNZuPrEm3FvYGqjGg/3ZHvJsjoIpxKVy6wtKVicsZs2HaLsBk1mceoab5vOil6g4d0uV1GMpDycM+Eca++Z+yP5ON+DgoicHm7VTF7uFRTLOI6S+I/TZUC2OJtLJu/QZE6YVZzVzViGu7HQpYD0LHD07p9FGEnjFVkrRjis55W8jm4NXfTrKud2m1lga8BIsOCWR4/QgilCWHi7O+lwdkmnEli+2PvcGEmYbD8N95ttwydwuLI8d4LYrY9k45pRHP/AJqYubpvBSBRw498fqFOrmvucWy5QrfAy7p2bVFrCpg063zqnqFxiHQnIqgb6oOmIvdOpkvq5tDLVNf9Cdad7iP2tV3aW90GXEOz0yipSseLHljpWtmjEo547o5v2iBiUMR4fB8ysBSVzUQ3O5+ecoF2eTcZU/IjzjRYuLJNjDkNruKI0JmvIx0dmzoJJKBiIx7oQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2201MB1515.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39830400003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4326008)(7416002)(8676002)(8936002)(6506007)(6666004)(6512007)(53546011)(5660300002)(66946007)(66556008)(66476007)(316002)(2906002)(4744005)(6486002)(38100700002)(31686004)(2616005)(26005)(478600001)(41300700001)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFjVHk2cCtKMXMrNCtvV2xaMEpnbmMwYnFZbTNUdjdYd3V3aWlOeW5hNG12?=
 =?utf-8?B?eG5FbDQxcjRENEVTL3RPby83TVk1Y3BYVzFtd25CWXFYWXRXV0UwTE5ldlJQ?=
 =?utf-8?B?Nko5MlFVMGpQUWpWVXMxRDBSZE5NSGdkSkZHRWY4eWdwRUExbFRqZHZUNEY4?=
 =?utf-8?B?c2FLc2pURFV5VXBOdVV3ZTRJUmYxbFF0cHY1MmQ0aEhFNVBGMkl1OHVRMGlN?=
 =?utf-8?B?akJqcFo0OTNLck03SzR1YTd3S2NxLzFlNnQ0b2NOMGZuMy9ud2ZLUmc4aVUx?=
 =?utf-8?B?TDMxays1aTcvTHFmb01hYVU2SVg1TFBCNUVPZDdGWURROFRYSmZ0endWNnF2?=
 =?utf-8?B?NkZWSmZVaXl6YUxLaWdxcVlXeU1BbGNVY05KL2lUbEtOUG9EWGZTdnlDTjYy?=
 =?utf-8?B?djdvaCtvK2JRWGRFN3F6NzNnNEFCMExJYW5nSEEvVGpJc0w3RTU2R1FUbEhG?=
 =?utf-8?B?QWpTeXAxTG9tZk9QcHNkUmhzanNMVlZZOWVLTDF2dEFicGUzb1IycVRYVFQ4?=
 =?utf-8?B?dU5wMGRIVFVDbE1GUUZybEFHbm40RE55RTFxVzFXejJiR2szUFBYcVRjU3JT?=
 =?utf-8?B?blp4UUpEQ25tR2VrUU1SRnNtTTJHUzhtckpoMmlIelkzM2Y3NjlJbkVOQU1W?=
 =?utf-8?B?ZGF5eW1tTktXUTFsN1QxcUdCS0dMTFlxRHRjUnY2MW5VS25pYUtMNERONkhX?=
 =?utf-8?B?UkJBNlpnanl3SkdRSjAvUHNOM05sUlQyRE5qVnVQOEtMbE5waU9YUnM0MEgr?=
 =?utf-8?B?amRzYnJ2d0VmSU8wODI3YU1KQ205Z2IreVRXTEpidEpRb1hCMFBiaHp3dTEr?=
 =?utf-8?B?bTlMY0pIc3dHMkVFc3RCdlZtM0lsdENOcE9vRGdxK3Y2MjJHWGhraFA1NDNT?=
 =?utf-8?B?WUFzWGtGekc4eHRPUXlEdlkraGFsNVlPaGo2NEpLb09rNVhodWU0dUNpaEM4?=
 =?utf-8?B?ekZCc1pkVnlncUw5N25hSHdNaUJqYnNlTlVMcmZOZ3hYZWl5VU45NTU2ajhY?=
 =?utf-8?B?OGtFOVJncE02dmJKaFdlaG8rbVI4blh3aW1iUmRqNTl3YlNLTWsvT0lOUDVs?=
 =?utf-8?B?akFOMnR4eCs4Q29FZWlveVpsSXJjRGJOeEkzMHpSanF0ZVR6TjY1cU0rbUVQ?=
 =?utf-8?B?YXJjdDVHd2Y0c1lPM2Z1OWNmWXR5L1h4M0V5QUZ0VmpaL2ZSMWdHOG5UR3NV?=
 =?utf-8?B?RTVEZkJjSHNUN3Q1elZvQzE5MnFOVTJBQythQWZBVHl6dTVObTQrbVh0NGds?=
 =?utf-8?B?U3I0bWNWVDdwaFozWU9zRVlaVTVxRzhDVFR3K3Fwc2RBSHFVWU43aExDcTRa?=
 =?utf-8?B?MW1CRGlGd0RObC81cjI5SHhzbk5XaHZZTTRkNkZvazF1dHh6NDMrZDdkQXpw?=
 =?utf-8?B?VEtLc2hYK3ZRbmFHSVREQ3pLbzhvajcwYVd5emFsZmMrd1hscXE4eE9oYU91?=
 =?utf-8?B?S2ZadUVOeFhRQ0poSmtkMnR1dmpnS0QvWC9PM1dBZWh1bGkvdkxwelBzRGZr?=
 =?utf-8?B?SFhDbUpPck1KMVliL1BQZ3dwS0FES2ptTnlmbkl5RFl3Yi9aT2I3N1E1STBh?=
 =?utf-8?B?dm9yVHFVTjF2QkV3K21QSnN6eGdvZlcvQm1sUHZLanAvMkYrbzY3aEE5cndE?=
 =?utf-8?B?bThiZURvbjYyRmYxL3BxMU9Ma1l2MlRJUXhPU1I1M2ZaRklYMW4vQ2EweXFJ?=
 =?utf-8?B?R256MXN6cmgyU3hvWTliVHY3YUE5MEdSSEk4SVo3cldhUHR4RFZ1SHQ2c0NQ?=
 =?utf-8?B?c1hsZ2Y4QlV2alZyc242Z21wVG9WVTZ5bkVzZkM1WSt6NER6UjdNUVJYWSts?=
 =?utf-8?B?WjRCNmV0RDR2cUpUQ0hJbnVIa2xwK05wQkk5eFI5czQzQ2dEWkZnTTJRWlYr?=
 =?utf-8?B?L3hXTXE5MmFJQ2lTYlFDTllUdUUvTFM0Z09UTEFQRVcxTDJFNnJWR1lMT3hr?=
 =?utf-8?B?MjJNalhtVFc5SkpPelhxYWF1WEJ2Nmg2UTFlYXhqQUhUUGhSU3BRSzQrdVEx?=
 =?utf-8?B?YVZyaFBRRGtiTlZkN3dPNnI0Y28zUnd0MGljOG9IMzJBanF5SGRPSXowUGw5?=
 =?utf-8?B?U0tGTDdZRCtockdyQmV2b09zM1U5b3dNZTJ4ckNvdlRNbGQvMHFiMXp2VExT?=
 =?utf-8?Q?O4Om8guL5MY1tYTStGOoOM8CA?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a356312-15ac-436a-3059-08dbfff9d0c3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2201MB1515.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 18:47:41.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8DeoB9hykyhW788bbTBf9ejLFGl8ziZmnLJ3dKtUs2aJ4jWUzO4cGsdrzC70xb6vfCqGGXHn0D4VAJdEINOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3103

Hi Andrew,

We are adding the nodes directly to the device tree to match what is 
done in other device trees, for example: k3-am642-tqma64xxl.dtsi. You 
are correct that this could be done by the bootloader instead though. 
Why do you prefer having the bootloader add the nodes?

Regards,

Nathan

On 12/15/23 11:20 AM, Andrew Davis wrote:
> On 12/15/23 1:18 PM, Nathan Morrisson wrote:
>> Add a fixed-partitions node to the NOR flash of the phyCORE-AM62x
>> and phyCORE-AM64x to enable the bootloader to fixup the partitions
>> during boot.
>>
>
> Why can't your bootloader add these nodes?
>
> Andrew
>
>> Nathan Morrisson (2):
>>    arm64: dts: ti: k3-am62-phycore-som: Add fixed-partitions to NOR 
>> Flash
>>    arm64: dts: ti: k3-am64-phycore-som: Add fixed-partitions to NOR 
>> Flash
>>
>>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 6 ++++++
>>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 6 ++++++
>>   2 files changed, 12 insertions(+)
>>

