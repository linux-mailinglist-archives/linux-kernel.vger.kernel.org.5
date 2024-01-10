Return-Path: <linux-kernel+bounces-22427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B46829D92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482C31F2757F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD144C3AA;
	Wed, 10 Jan 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oHebcsDY"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA24BA84;
	Wed, 10 Jan 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbkzbR7SCslxTQeV+O4ZTUnLuA67icx+NPTnPaKJnERYSQZyjMu+6gNjIM10Kgw9/JeEenp1P+lfYgnnyGkY+Gto8G06HPiaWDe8VHvtA+kdeVnuJ6uYKag5Nd8txRJAQUCcdiP6PJ5m782/n4OiOQcgpbtAkggKz2oEw+8qnYKeGYAjintFm6xSZjKf/wQ1YGC1eFoB3hARAD20fd1/CnI9L9mPWNjTyjjmDRFlTcpYxWOsakOYbWlusYEkbXyvTPRAmAkYgSgYWraezkDlRrUZO0wemLsLsCcx/qkQL0TfcyIWSCuxmMfyqO7YNF9/5jE3loZYn8cff+rMUHSufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i26VQi7tvdFvLpYqrbpgQrIcm9m0MiDhhG8UhG3V63w=;
 b=OZdnitX/OeroHzAzJKkbaCfa9Ogw/8c3JLHWiPU0mUGoIBzPnCzwzHF3SeVeORK5G/zLkZZl2GGeoQ5QN5p6e4y9nXx671sd0i/nY9e+43EBYojA7V2h+UDu3J95oZFezrkJGA80Dt6cdEgrbNh7H6LCw2OxfXGFNglBD7vYn1kbWglV+uohY2zJlJm10M/Z8gyogSj9Rs79y7oeg29TkD49rbiqt83XBz+JLiJud7embw9I7IWqVwLAHV3CAGGwG9ALsUJMTS8YMp1BXePm8HjUil1sOx/0JAceoqt1NknsYv+S+yGRMUA8lyRWTDIKpKIk+t1ZucXosi6vE9a/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i26VQi7tvdFvLpYqrbpgQrIcm9m0MiDhhG8UhG3V63w=;
 b=oHebcsDYtPMyLtzO8EOMmmo9YGyrCWNsgezakhUD1ZrkYkqEYz6S0DD4+shd4iAW1v6HQ08L15Z3IExdhcPYwad+0C8KjWIeie9cNo34utQRB07km2MGrNTDLTGUtpVIBRmQ4Ymk2Q2qViTKlSIxM4Th/MiVPByIfTuEQGiIufo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 15:30:00 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 15:30:00 +0000
Message-ID: <cc53d5e2-b9ef-2c48-6c94-0b279f11263f@amd.com>
Date: Wed, 10 Jan 2024 20:59:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v3 0/4] Add support for downstream port reset(DPR)
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Sanath S <Sanath.S@amd.com>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240106165723.3377789-1-Sanath.S@amd.com>
 <20240110143127.GO2543524@black.fi.intel.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20240110143127.GO2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d06eafb-dc87-4749-68d0-08dc11f101e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jE1LUthz94YrpDLZMt3UwfqTijl0ibB3l4ypIzp8Aw/dlL7pncIY3AR5vdXKD5x/F9CbrBVRKojmrcfLnKQAOm8BakVGdBBqBqu/JiwLvdY69YKrw8jFc2SWBpmTRr6eVWn3YmcGC8PUDsxCIEQcK6BYUrQX7k9NYO/ZIEbaxKpDIn3jQPX8k4YZk79PBr8me0m+1h4jtMqosyKreBGoL0mDuBLXZVlYRCgoFUAGqEICbNXZEQHexgsXnSL8z6+YjMUzdQhQak8mbDcyAZHgDM8brizznnJegadaiKJg0ulcxTRDfQWpz5mAfbr/tdU2CNCFry1NkNbLLtOHkxlWvcMWm/qNjl+bLs66K/A+gKs3ADaM5PbgHabE43QkV1OvvZNvWtABRpfphoHZEVT+7Yr2gtZbhCySYpm8KyNviqi2E5jV0gal+vbTsFYn8rOEH1oCjeHzJKaQMM+nySUeCGjsi45TBEIqf3gm0R7qPv0rsiDdHOXMymOtoDJYGSFHl+XI77iJd0bzUYHpJ6pFrUzhxsrp/+IuMIZ3k6CCuxf6OrD0zwiIk/nqc93tMIDEf9CaJ1kk0jIk158xESGzNo5hu/cvZRJt0z1mK2wRRLjl2Hr9EOW0rDjtuvysiprurOLcdS9Bv55Ck6dbbOq4UQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(4326008)(8676002)(8936002)(6486002)(66946007)(66556008)(66574015)(66476007)(316002)(6636002)(110136005)(26005)(83380400001)(6512007)(53546011)(6666004)(6506007)(2616005)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjhLRHhybkxuVzFFbm45aDFqdWNhSnpBT2JoblowY1RzNFNMb0VENjR2NGNS?=
 =?utf-8?B?NWNLMDRUUS9WcHRNRHVWSHlNSU9QeTZxOXFvT25qWkZnbDdqWTBqTHRpdVU3?=
 =?utf-8?B?WjNsL3c5WEZpUnF6VzBDZUZuMUdHTVRZMFFVZ3FqcTVvNDl4T3RzKzlyc2Fq?=
 =?utf-8?B?MTZyOW9ZSVplTzZRNXNGNVdQR2lJcVNBU1F0NXBvQWtyWHVEdStVVm8rbkxo?=
 =?utf-8?B?NVdEOFl6OVNZYkU4cDJZU3MzdFk1WkdoY3JURUJ1RjRESXo3MTZDZDkwS2hQ?=
 =?utf-8?B?dFZBY1Q4SVl2TTQzakZnMjJOZWJkVUpKa0xGaE9nY1FqWU1XeHdtTGNac1NW?=
 =?utf-8?B?MTV5b2JEdHhkT2YrNUw1Mi92ODZtbXlqTnNnMENNd09ZU2lhZE16YWtFTmkr?=
 =?utf-8?B?aldBbEVKZHZXQlRnY3R4MGZFZk52T3hTNG1ocVh5N1R6R2l0UTQrbWtGQTEv?=
 =?utf-8?B?NXkxTXN4bjhhelozbko1WExUSHRQKzRBRDhnbDU4SkllL2IrelpCbjJXVnh2?=
 =?utf-8?B?TVg3TmI0ZXNoeHlML3ZybmtMYVIyWXl4dC9Wd2tUcDdEOVZYaDNyNThFY1N0?=
 =?utf-8?B?TEYyVmVaL2RkMU9HTEFHS01naUI1bTl2OEJJNjU3ckRxV1R1TVdyN0lVK3N3?=
 =?utf-8?B?T1Fzb3VZMTFxcXoxRndaTlZpZnJVMFQrQzQvVmM3QVphcDZrY01sV3k3bUtM?=
 =?utf-8?B?TUYyZXNaVmtkOEVKYnUyaUNlenE1dE12aU9FYWpOeHgyUUUyL0M4M2d5V1ZJ?=
 =?utf-8?B?N0ZrTGRHT0hwaGF2M3ZMdDZWMmxZdzJFZEc4dXRBNm52YkNLLzhUYkJCaEpt?=
 =?utf-8?B?blVSSkZpeHVQMFNIazE5YlNwczZIU1RTRUthRFdGdXl0bzN1aWNoa00vLzRK?=
 =?utf-8?B?WkJuVXBjajRoK01meE9UeUFSOHkyaGY3emNyN0VjTWsvYVhOZmgxT3J6dit2?=
 =?utf-8?B?VWxJNmNCNWhHUE5qSHZQa3p3SjJtNytwVDI1b0hzOEk0RXpkbkJoODM4QTFV?=
 =?utf-8?B?cnpmSi9QN0RvVnJPL1NjK29vMmlCQ3JzNFVLSDhaSmlmN1FVZ05VRTJxbFNt?=
 =?utf-8?B?VXl0OUUybnlUNnNpbW9rcGtTV0hoRkRMTG5CSlQxcHNXMzNKSWxpQXlCYUo1?=
 =?utf-8?B?aUs2SzczdTV6VGU0clZQU2ljTUthTDh2dXUvdWtuMWNiM2lhZklRM0ZTUnF6?=
 =?utf-8?B?UUgrSUt2SlZOb3Y5QzV0Vk5MNW1vblZzSFYyNWxTY0oyT3FoenJ4Q3kzcVlE?=
 =?utf-8?B?cFdPcUtrSkdXNTllTUJPNUIwSWJuWXRWNlROUmtzSVlqRlVCQ1Q0cDR2Qjg0?=
 =?utf-8?B?M25wK09jSkZjTHZ4eEdYdEhSM1M4TENxcHdJMEdJS1k4SnhPZG5hOExDemYr?=
 =?utf-8?B?U1JmdlM0S1MwV2NFd2d6MDRnUXZkQXN6dmhwbnk0RHRNTGVFNkhJZnlsU01K?=
 =?utf-8?B?ZThBNk9pWTdac29wbjJmRFJybkVCaHJSREhEb1Q2amdkcksvY3ZaUmw0MG5n?=
 =?utf-8?B?ZFAvNGhCQ01kMnJCR0l0UzVaV29uQU5YYVphaE1XMEpSenpoV1Y3MGNXVmgy?=
 =?utf-8?B?bW5YUGFQREZWdkZUQ3gxNnFIZFQ4K3NwUDhPSUVwZmRaTCtBRmkyU0FMSjVN?=
 =?utf-8?B?ZTRGLzIyMStLd2J3cGlTRW1PM3owVnVaY1NYZnV4MlZGVGE5eGNLMytnVTRz?=
 =?utf-8?B?MXROZFpsZXI5R080NUNVczlZYkQ3cWZlNzZucXNDY1VQQmFMV2ZUUExtUFV0?=
 =?utf-8?B?ZHZZZ0UydzRXSHNYVDNuMTdNQm9ISGFMd2YwaXl5S0oyTHM0bTI1R3AvMzBS?=
 =?utf-8?B?RGZyazgxdjBVOGZUdWJCZ1AxSkorWlhuTG02YTIyMGFib2JxNDRRMEl0QWNw?=
 =?utf-8?B?aDM3RjNZUGVybEpjc0h6dXdyc0FoUVk5VnRvYTVUKzlteEI2aUlENi82dG1P?=
 =?utf-8?B?Visxajc3UGNPZFJVbGVxTjczNXZCTmxUdTN2VlJ0NUN4VWlRYjl6c2Q2QU4v?=
 =?utf-8?B?VUpjaGwwMW5lbk4xVGxPcFVaYk1lZWZ6aUQzQkNBMERrSEtuYVI3eWVpT2s5?=
 =?utf-8?B?MXR6L1E0OS9uRENVL203TnM0VG13WXU2cEtwTWFzbnBScUQ4T2RJcjNPbktp?=
 =?utf-8?Q?Xs/nA+1Jgc9SA2YeTUfbDpL5E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d06eafb-dc87-4749-68d0-08dc11f101e0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:29:59.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHf5DGP5STmMBRwD+ll3rMAAd2yP+1i5l0P3YFN389i5oOWSRrtoKnUC3aWlfeq6CdLYxoJbtvkQOG27zqdyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853


On 1/10/2024 8:01 PM, Mika Westerberg wrote:
> Hi,
>
> On Sat, Jan 06, 2024 at 10:27:19PM +0530, Sanath S wrote:
>> Tunnels created by boot firmware results in incorrect PCI resource
>> allocation, which results in failure of extending daisy chain.
>> This series aims to resolve inconsistent tunnels or paths created
>> by boot firmware.
>>
>> Before:
>>             +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
>>             |                               \-04.0-[07]--
>> After:
>>             +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
>>             |                               \-04.0-[07-62]--
>>
>> This series also aligns with windows behaviour of performing a teardown
>> of tunnels and resetting the downstream ports using DPR during the init
>> sequence.
>>
>> Changes since V3:
>>   - Remove discover_tunnel() api before resetting DPR.
>>   - Add lane and protocol adapters reset in tb_switch_reset()
>>   - Addition of tb_lc_reset_port() for TBT1, TBT2 and TBT3 routers.
>>   - Addition of tb_path_deactivate_hop() api to help suppport path
>>     reset of given hop index.
>>   - Addition on new patch to store and indicate host router reset
>>     status of USB4 v2
>>
>> Changes since V2:
>>   - Perform DPR only for USB4 routers.
>>   - Update kernel-doc and return value to -EOPNOTSUPP.
>>   - Limit delay range to 10-15ms.
>>
>> Sanath S (4):
>>    thunderbolt: Introduce usb4_port_reset() and tb_lc_reset_port()
>>    thunderbolt: Extend tb_switch_reset() to support lane and protocol
>>      adapter reset
>>    thunderbolt: Store host router reset status in nhi_probe()
>>    thunderbolt: Teardown tunnels and reset downstream ports created by
>>      boot firmware
> Thanks for the series!
>
> I will give this a try on our end too to make sure there are no issues.
> If things look good I will queue these for v6.9 after v6.8-rc1 is
> released.

Thanks Mika :)
Looking forward for results at your end.


