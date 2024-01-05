Return-Path: <linux-kernel+bounces-18059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD987825806
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9941F21F26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E62E824;
	Fri,  5 Jan 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYPAcKnW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518B2E829;
	Fri,  5 Jan 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVGJoipE3UByKP68jML6L3l+o3tUylZOkJUkxUnankXphRHCoPg45yHMlNurNWyd7OsU6T+xKercOczEPELr34elAbs0BGy+Rg6ziIv9jQEiiV2gFXWeHGhYRxjmMIm1y4QMKAxQHMMlIWdOgLoXPG6yf0hcKaQ2KnYjosBUT3Th0qhAAoVIdhMxUjyck31kz4uU+iPGfh7vTXrYrxr78o/7qs1GtQV4kQ3WG5biQ8aaDkLPEm8XZxz6eCsZauxcue2lizogFrcwK3lLOFi7YCXt9YjntjNosWF89BCMOP4vs+PXL9ezKS61vleBx23oSUWHvYyhByPqOcDbg0geyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywX6WySuLQYs7bVuIBIt3dSFhjUz5eycYDZS5q50HKs=;
 b=YVSjKcdMk/ZlIEo5hMUBACP2uGe6Xo6b4mjTMWO4AwqHOvoLgKtz7c8qXCPdmDRJuRGrnW79jmIU8CgtnDG9JdlHPKj14TLeT4oGdd6BOjnoPyUUbVIltWfOyQy19CW6S5o0kUFJW0prwzFPxXvsgKeLB4sqyPAo8kc1OjYJ+0NYJCiXMNrLs6tb5lHQbUtxhXa2q0QJnd2TRbDAvm/XT4lBUxJIrc94/9ybNz87LTOcY8h1gH3EgDzLMnQ6FNUlcdz/XKcd9i6TDSw9S7OnLUjZMzOgrthSSoymmpuQ2ZpUUvmSGAcre/AVYwJOJ8ChO8Xr5drxnjcbVUEIckltwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywX6WySuLQYs7bVuIBIt3dSFhjUz5eycYDZS5q50HKs=;
 b=OYPAcKnW0j0+6oxlWAsN3dfnYmVWpg/LmSq0qQ7I8PAn+KUPEEUUHk+fTyu6d97zACS3Ye1oyArwdRrylhmY4zZlsH9iji/Ytsts/QmbHwUmvvSXCzjo1EhtqFndaW7YmwafCVMufhySV0hogo+MTTKsc7UmfWwWTZ4YVV4fq72od/kKmRMO5Tj4nv7GUoR8ZeCXuTSD5QMnkkxLRoLEaX2njwsb17E4qq9sF+oFIIV0g/tsGLKBD8qKXrOrxflJ1EZBuKZl7yEv49C+IVZa4hGHKdtfs4dug7qyvQCYNXWlp+S89eHGN4mPmxgUMtfq51qFgYV16NaZzTx7AHtKNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.14; Fri, 5 Jan 2024 16:23:07 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fb84:50ef:dbb8:1ebb]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fb84:50ef:dbb8:1ebb%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 16:23:07 +0000
Message-ID: <5bf8a4d9-2a83-4503-b041-09c45207fe0c@nvidia.com>
Date: Fri, 5 Jan 2024 16:23:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/21] 4.14.335-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240105143811.536282337@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240105143811.536282337@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a745f9-dd1e-4fb5-aabf-08dc0e0a99af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	39aGAkM+0/p37xJfScLZ5sLLhCXx6tzD/kbB/XhxsA9kIvu/v4qfYPDtUD/FytDRAQ/l8Uz+Z3+Tv0aIL7p2iUpQk6oWpuUAkeExN93oj6Y98XTvhec70tiWwD6Pce/9KgwIsIHEXPalvMPvHAOOfsrUypbc9VXk/xgR2rizCGjjj/5pQ0x7I45JFv7O5UqvCeLajtAGF7KZ2hwNEqcyg2ybQn8YPoLsqEjXe0b26QItx1hckdtD+I74vgOzoRDsfQjqscO3GWOMCTkclFhZe3tNfpECN9Ln6olVZavBqJdtm2NgXdUu7Vz9ctBGdEPLc8n8mi1VOBrslPs1OaOIuxqRogn1OQ/rcBHFppNbinhco+MDI995dl9I4zdo8euv9XKCKfwFM2lBxi/sKc3BiNONwaBQZAoydu6xNh4nMH0Vk9bO4GZ4Spu/yHAaBgMWYqTF0RRANe/e9DZEBmKgOxiN3aRHJFuwzzpqW+a3UyRbrttpt4IKgDHRhYe/GMVHLyUIvO5u/3E006k5t6yJsztUFwlGv6V8khNPyKHSlU/+2dwxsGM317uQbA0ErFvAAhrnAWpaj+6ohorUHYBbce0iBTtu1qZy/7eBMu3lz4KaABtT/gLJq9yz1xSSvGwF/+sd2Xh7bvm6iG1UsFTiR4S/aRbfUPBVglPVu76Nb0JxD9m1OoiDqyyNI/KRiSL6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002)(36756003)(38100700002)(41300700001)(6666004)(6512007)(6506007)(2616005)(6486002)(966005)(316002)(478600001)(66476007)(83380400001)(31686004)(66556008)(66946007)(53546011)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjRYR3hPakNXT0FKWlJmY1N3Y1V0NVl6SHdWL1NkUU9EWEFHbThucllJV1Vq?=
 =?utf-8?B?djJBY0VGNmNVd21LL0F4VzMzNHFqWWtvcFh0c1FHc3M4dGZ6aUVsRWZLQjMr?=
 =?utf-8?B?Zjc2eFErNkRYWHZmNHoyV0lUS25OemdMY1NsTStHbDZrQ09BRlV0bUY1WEQw?=
 =?utf-8?B?UXUvb0JjK2I4Rm4xMUh1ZzRIQy9LdlljZHdNL2RjUHhPdmpUOStmY3RtcG9P?=
 =?utf-8?B?a0ZPTUxRWmdmeHlyNzNSSlVKb1piazA5cTVsMk1mbjQzM3VwTlJaZWd0WHdw?=
 =?utf-8?B?Z0RwRGl0Z3puQkpRaUsyZ2RvbEJTYyttUUVjMTVWL0tJL0hGTzlGL20zZFB3?=
 =?utf-8?B?TExZVy9BSnlad293dk8zbU1TdDEwV3lVUzVZU1JxMnZRa3d4emxWaW91UHQ3?=
 =?utf-8?B?MGVvdHZESStodURndjR4RXBoNmExbUkxSUM1N2YxM1BmczlJOUhTaXhveFEz?=
 =?utf-8?B?dTRBVm8zUmwyYUUyaG5HeTBUVkpOT09Xc1U2NmlPUTh2dmh5MG0zMm56cXRD?=
 =?utf-8?B?bDBvT2F0VXFLSm9iTlZ1ekdkaTJwVHU5WXQ2RWhoRlRTWlIzeVJzRGlaczlJ?=
 =?utf-8?B?Vm9MZS9LS0wxalFUREQ0b0RxUlpLU0ZDb1VVRWF0K011VXoxTUswbkMwUXR5?=
 =?utf-8?B?UXB3VU5OOUE2ZW81UmpCK083OXZUcmI5Nkd0NlBuRzZJa1p0WUw1bEpSSjdm?=
 =?utf-8?B?K3dIMUFYL2R3Y29QSSt1MWxXQUN1YUZIczFKMm94Q3lnRE9WR1ViYmFqTGt1?=
 =?utf-8?B?c2hYUWx1bDdpeTJJcmdZQTExcGlRblErNndCakc3ZjdGUHVFWmtrYVV3Nklv?=
 =?utf-8?B?V005WVdSOHBIZU9BT3JwNG5PenEwK3YzNWVOaDFIOGtYcnArRG1jQit4bGcw?=
 =?utf-8?B?VUJ5YjdiTjduRE1paEh5blNuOGRaaGNQem5DUDJSSU1QbGJLQmljcmtHVk5K?=
 =?utf-8?B?ZXFhYS9aZlR3QTNONURrd1JIU1R3TExDd0ZsbDVxNHkxZ1pNZEg0dzhudWNn?=
 =?utf-8?B?T2M3YVRWWTJoTHByaXJ2dTJtaUZqUEtYbjdFUldlQ1NuS2pCVGswZy9zejJM?=
 =?utf-8?B?ZWpNUk9LZjI2V3hDZzhGSk1KSnJmNWhWVCtqR2hIb0xhM0k4WXJPRHUydzN5?=
 =?utf-8?B?SkwvSEV1Zk5lZithRzJBTnVZTGw2MW1vOUVSL2VMUmxKc09GUURyOGwrRVhH?=
 =?utf-8?B?dktMbDltTWVDV2l1VEZDRzQvNUdVSnFrUzNETXJnbTZzU3YwWmVwMnhnckk4?=
 =?utf-8?B?RlM1aFVEQlRVVmJveU5EUEJRWjdhSWlOdUhPK3I2ZHdOR3pTZ0FwZ2RZS0dC?=
 =?utf-8?B?dC9tS0JPbUJ1WkxDNnVHT1RJYmJyYVh6enVKKzNoQUVnS3Y1L1I4aWc4WHRp?=
 =?utf-8?B?OW5ld2UxbE80bWRpT0NQME1zeERLOWdMZHpReHllUVZmVlE5by9HVGpTNjJv?=
 =?utf-8?B?OWJJUk1HRmV6bmdzUXpLRVNNeWlab1NKSytnY2hYaW5aOVJ5TUp6ZUZmWkRl?=
 =?utf-8?B?WXJMRUNzMVJCdVNjTTA5aW1RSmR1eHpjTkhLalNvcnBMZnNiSWdKVUFPZkhi?=
 =?utf-8?B?ZlBhRUEyb1U5RGFXTE9FcURlVmJLMEVxb3Arbkk2S3JzZjZydjV2WmlKMGh0?=
 =?utf-8?B?YUYyeTBseUE0Qk4vcTBOekRJMGl2NTNackFmRmkvZkJHWTNIcWJTUGxXeDVP?=
 =?utf-8?B?SFdvbXo3OWppaWpoNGRKakpKTjZlL0p2NW5LaURSQ0VRNFFUNy9ZaUR3VTlU?=
 =?utf-8?B?TzBOUGlhcU96VW5IblVSY2lQWjlwSXU1bmFjWGZMODk4OCtiaEhkajZJNmpx?=
 =?utf-8?B?TVR1WSsvYldLZG13MldFU05KWWl6ZDFuNWhLZlBPZk15Y0txUE51ai9ueXBm?=
 =?utf-8?B?ajJHaFBkUjBDdEFLVGN1OWdQWXZSVHowMkJzWFBobHArZDZVY3NoYnQ5Z0FS?=
 =?utf-8?B?Z1AwWm9jNEhQdWhsVTBzRlVpRnhwelhqR0tlSkZuSmsvZ1J3dGN4ekNvQzV4?=
 =?utf-8?B?TW1zSXhKN3RBQWtyblhJSWgraGg4NUQvNks2bmFrenN0ZVRTcCszTzRJMTdI?=
 =?utf-8?B?UDg4OFEzQ3c3YUlCcVVMaG5JREgwOW9Hdlc5UUs4eU9NNlBpREcrQWlpWlkw?=
 =?utf-8?B?MC84eFNhOGRaNjRvWkRJcW5NWDk1V1ZnMDdnLzBmQllQZXdLdEZISUVvVWZL?=
 =?utf-8?B?NlVBSDd4RE5CL29acGorcm4rcUdrWHNYd2hZMkxuSnNTdGVhTnkzVFg3bU9a?=
 =?utf-8?B?aFNJT3lXYWtNOTJsK2wzNXFXQmF3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a745f9-dd1e-4fb5-aabf-08dc0e0a99af
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 16:23:07.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDtp/dJarfNWwBOd9MWWtZkZM4BeDAGn685/5IemWTER840FcOpE6UAkpcEv3Ufr8uRAPtj0qpQr7P++GF8JZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

Hi Greg,

On 05/01/2024 14:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.335 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:

...


> Alexis Lothoré <alexis.lothore@bootlin.com>
>      pinctrl: at91-pio4: use dedicated lock class for IRQ


I am seeing the following build error for ARM ...

drivers/pinctrl/pinctrl-at91-pio4.c: In function ‘atmel_pinctrl_probe’:
drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many arguments to function ‘irq_set_lockdep_class’
    irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
    ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/irq.h:517:0,
                  from include/linux/gpio/driver.h:7,
                  from drivers/pinctrl/pinctrl-at91-pio4.c:18:
include/linux/irqdesc.h:250:1: note: declared here
  irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
  ^~~~~~~~~~~~~~~~~~~~~

I am guessing it is the above commit.

Jon
-- 
nvpublic

