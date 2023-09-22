Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A97AADB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIVJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjIVJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:19:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4F19B;
        Fri, 22 Sep 2023 02:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJJAoI6D7jFCt9PjKrIrfXYLPLluRymHVELvr4T4qam3ORF3UCiLBdY9ht9FyWV3O3M0OqBUjNBP/McbubNGXXAfS/lISKwYthXMXSQiOmiqV9rwvj9Z7PWG2GBmBt3mtR4VXJDFzmWiZYy1BqKQ0++34rj5KuZ7lHUNPQMwGRFjMxBXq2pF7bnI6iXOYi0kUdXhZcwOusf2H040FNqmFkAMNfGgUW6T2JLRAVOXtCpekoQrrP6XOwuiXMW+ywY3nhqKB5MGxlKOJAgrpdNSsXKziUSr5UPzMRVZjZLrdVOPuciDocC3YDuiqbajG3xOOKrbZn5jSSDR5DAnVZMXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LXXuLBFY3cAH4cOKAjrgvLg4tbk5lmnAjDSFX6FNdU=;
 b=F35XzQoY7FmC0Fp8tXLcjq62AjYiFr43sJ8rwyJ9j8smf6hIpHZSuWmQR0s7nY76K+lxPwHo1ThqqxkXYKncfU3FXN8v9f4lYCT02U3XdqI7REmaAmACYrtGPawsiAn6ay8KBeWI5CeyGZfTOy093zAtsJevE+DAZoH4Ysum8anTdGuVp1jobOGgiXvdF8G6gjhMH9SeH3enKpha8xq/HfS22zjKn+tfZ5BfelSz+ZrnDyjFm3TNOh9ISNvmwEK6Tqd0sknylpyy7LEGQ+mzIDFP6ykeMJKGt1RuApaF4djt5dpVD4OQu6TKgp8/auKYFdfgVEN7p6Z25dMcM8Okew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LXXuLBFY3cAH4cOKAjrgvLg4tbk5lmnAjDSFX6FNdU=;
 b=gg5/7oVN9MK1cROqdNj15xwnQ5L36t2/UePzDP3P3AlnIxrgL1qVNBaNTbqsUUuNaRggdQFKnL29vRp9MlXAt1wT01NJUqYT8DpR0UvxqpecOMctWo6LkZfyUmOISa0ZoqDO1ddlZj63K3uteBurIbezGTi5j7teZSsk5R0NCiSPxvTK1k5r2bN0+HPqjh/bqTYtxviBXpMhT/m6D2zE2K9werEBSHgbcI5cRk5SBgD+yCuTQjJnuDchPGXLzNFsKgrGsS4axS/JNVtIC9l+ZIPMvAnmFq3JjtWf5/RKTugsVYd2Pm3Ghc4C3uJ1LdoPk+hS+Ekf9kIU/PDZUGc8xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Fri, 22 Sep 2023 09:19:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 09:19:38 +0000
Message-ID: <ba9fd9b3-8a8b-6085-ab86-e91d8ab5cb0a@nvidia.com>
Date:   Fri, 22 Sep 2023 10:19:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230920112830.377666128@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0031.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0121e3-0485-45e7-a9bb-08dbbb4d0b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWDxpsz93IPpZmnM4TBdJNkfpg6o52P4NwQBLRAxlLFY3kR+WBNLc8wG4JIblhuum3M2inHQicNXATMPHka0xoQ8EmoybvIiAt+cjU4dEqV30QU8aeUl8Fk1uRthZQCxfvRve3n5X1jPxraAviHOfVwnX3cnCRcVo0U5477MigqHQuWTy7BYqChbH9ofbtV4DDz8ULe0yG6lpnGYlCxJeeJT1rKsAx0HMdYusiJU4pZl+C3l7gVMOfzHJO5T8/ks9B1qZUbc3HZbI3VC6iQaw2WYa2dtiBwJtb/pS1sXAAvYbgRhfnK0kxOivvXcLe3aSKOobExrZue+Th5FgW9CJ+ChR2e+qT1M/ciVucbadRiIHjPVv1pMf783mEZ+XfORpoRj9mU0sNsX49ATOPi5+em+dhOhCbU7zWROtKKn1UHvryPsmhnpc5QZf3iRRRKo2oUrJLkP8xoLzY15fJriQY3HfLVdMn4Le2D1jRhFOBz2OGfkwZGWggIiTW79kGeeARKsDoFH5kvW3GZ0Sa+U/8hz/EfjBIVHVNERoR2Kx7HYZzhugrI9CLmqS7pWsx0grfSEPt2PxmpQCwrJLQVNKel1+hw0uTZ6QkRw/YQbI64Ax43IF4MwUQpLT9LahuNBNWVxmox/BVw4ObmQGBCAPBAdnYhn356Qs56p945YSD/1Y1CjY4Z/tjddsGCg2TPS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(186009)(1800799009)(451199024)(5660300002)(7416002)(2906002)(316002)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(4326008)(36756003)(31696002)(86362001)(6666004)(31686004)(53546011)(6506007)(478600001)(2616005)(83380400001)(6512007)(966005)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNCVmYzazFYTmNkeENjWUtTdzJOYkRkNmpmSnZvYVl5aGQ4WTNtR1RSRlBB?=
 =?utf-8?B?K0h4YncxTnFJUXg4OThPd21wZm5zOVl5ODRDRzZpampqWWhuTDJ0dHYwdnRB?=
 =?utf-8?B?RjAzYkRYTHE4MWZ2c3BCK1BVdEFCNW5XTkNNZGFDSXFNNE9TOFA5R1Jwemtq?=
 =?utf-8?B?VExndG0zOWZDOEhVK05URUhCaDBrRFpXYWQ5UkpYeHlENUQ0UVJvOVBZTGg3?=
 =?utf-8?B?eDYyMlBHN1JVQzlPVlZsK0FrU3ljNFArWWwzR2swTGZmemc1MVJaNngwekla?=
 =?utf-8?B?ZkhnWUxDaWM3dHE3UUE3aFBmOUxhQ3NjRzZ4Q0x0cW12UjFFU2o4aTE0T3ZG?=
 =?utf-8?B?U0QzTVZMQ3dueGhhT0ZzWVB2NWY0endFZ2NOamlaK1BlcFI3a1Y4RVYzN1dx?=
 =?utf-8?B?ZnVvUmdNL3RadmZmNWI2UEVpN00rYkRFeTV1S0ozMlVWTGZrVVJCWUkrTVYw?=
 =?utf-8?B?LzBmcmdSYWljZGNsN0NYcW1FSVg1V2p4aTV6YXRLclp6cjE2dFdPbncrcnVr?=
 =?utf-8?B?NUdTcEljc3FIUndUNzMwaEpnRjZBeGY1NFZGdDVRT21YS1U2M3p1bE9scWVG?=
 =?utf-8?B?VW1nMmNIa3FCd3U2VkI1dE1TNXNhaEJjRUltZUlsb2JvbjBENDNTcFE5eGlM?=
 =?utf-8?B?b1NDMTJvZzJrRUtOTFUvMThaOEI4SWwxdElrYzhaeW5Ca2tEd1dvVWNSdDlR?=
 =?utf-8?B?Uk9CeW9wWWFxdW5IRWVGS2FZMHgvNzZOSmFYN0xXN09KL0tlNlJpRXZVRms3?=
 =?utf-8?B?WnVYZjY4YjNkU0RudGVZVGFndUd0aU1nNWpqYSt4YTdTWmh1MzFkdDVSb0Za?=
 =?utf-8?B?bTA2RlZQZ1pYd1NTWnpjODRKajJXMjFTcEVzZ0JCdUwxN3AzdWRxdHVRbXh5?=
 =?utf-8?B?QTdiN0pCbFhkUFdpYTE5S1RUUnN6MUt5TFZsN2gyazJsQWF2MXVGMlFXbG1i?=
 =?utf-8?B?bUVIVldPQitKSGREVWxWSU9BSWlzRzRVVUd1Sy9iaWZrK0dkcFhYSWQvbnA0?=
 =?utf-8?B?ZVljTHVveVBGT3Y3ZHFGMk1PRTdkeHpUU1ZvWXVyYlBvVTM5Mm9EQjlTa3B4?=
 =?utf-8?B?djRwWjVQclBueU1WeVIvWHRaaEx3QmNsUmVqT2wvWVFKaUVKc1h3d3VLNGVZ?=
 =?utf-8?B?ZWVacHdhS1dMRW4wOW52RmEyV3ZoNjlXV2cycy9YY0d4RmJxbHYwQVZnR0tz?=
 =?utf-8?B?L0xKTndjYXVydk1KZ1BTTzMydm96bzBVVlFxVTFBdDkxalc2eXpsRmlUSzlw?=
 =?utf-8?B?NVhTQU9KZVpXN0NZOW9HQUhYbG9TT0I1amdFQzhTVzdNMTVyMDdjUHBBMy9t?=
 =?utf-8?B?SDRZKytSYjFNY21FdTAyTnlHRmtsVDR3S1lTNWs2NzFIK25zS0x5aU5hd0NW?=
 =?utf-8?B?Y3IxR2p1YUc0WWdFZTBmeUpjdHk3YXY5VjNST3FrVk1LRHRhTnp2TytLWHdt?=
 =?utf-8?B?bkVTbklyZlh1d2VMdFV6L2RSZ0c4NW9vWHFNNENhOXRRZWQ1NFdpWmN0dHJG?=
 =?utf-8?B?NkgzK1pFWlFLVUxQNS9yOUJXckpPQUgwY1VSQVcwa1BaVkNzNDJZQ2Z5cHJ4?=
 =?utf-8?B?NnFSenYzYzFoNTZBcjVhS3RsK1MyVXphT1VWVFY3YjJ5UmhheWdCYUdRVzQw?=
 =?utf-8?B?dkNyZEp4RlpObkZ1Z05OYWJoVml2K0FtdmVlMU12SnRqSGdkcHR1d2xnaGw1?=
 =?utf-8?B?WUNwR3dSS0JRT3RuTFNZQk5ncHYwSmZRbWRrZlJzTGc2YzY3TWxaY2MyUlBr?=
 =?utf-8?B?eG9XR1h1MGJWOFF5cWd0djZiS05xd2dOL1NVSk9HT2kxQUIzZ2tPK2tncnBk?=
 =?utf-8?B?Z0FwMTNTZDlrbGM3MEJ1WFJ3NFJleTBqQzRyMHJ2Ky82VWpjdHJPU3VlYnY5?=
 =?utf-8?B?Q2x6RnhDVWxid1hmbUZlajFNMHd2S1c4NUcwOHAxUmE3bmZWT1RVOS84YUIy?=
 =?utf-8?B?RjE0UU5SN3dicC9RV2Z6MHQvaDZFQlVCVXpZTEpHK0d3emYxSFVMWG5teDJH?=
 =?utf-8?B?S3lLK29IR0s1ZW5QTnZsK3FVbVdmWFFSdFFZY01hbGRpZ1pueml4TXlOamVM?=
 =?utf-8?B?V005VXFibEtCNm4xSmVVQVJXS2ZzaTZiYlZjRituaVJjdHBKc2dsa0F2TWFP?=
 =?utf-8?B?WkprYldqZzczbVBkTGJLMU5VcEhmTjhwbDM5UlFoT2tXVGZibFRwRzBzVGVi?=
 =?utf-8?Q?aqRtmgRoIGnwMHxunEMif168HHMlGqQgzNSTYd6WJk7z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0121e3-0485-45e7-a9bb-08dbbb4d0b3d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:19:37.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjAifMXSkThzzWtg0ABY6gWdm87d/BFqVU35YxqqBUj9Pq93mBBuJ1xVV3xcgcJSOYa7fNj6OEST9ix0ZlP0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 20/09/2023 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

...

> Rob Clark <robdclark@chromium.org>
>      interconnect: Fix locking for runpm vs reclaim


I am seeing several boot failures for ARM 32-bit Tegra devices and 
bisect is pointing to the above commit. Reverting this does fix the problem.

Test results for stable-v5.15:
     11 builds:	11 pass, 0 fail
     34 boots:	28 pass, 6 fail
     78 tests:	78 pass, 0 fail

Linux version:	5.15.133-rc1-g634d2466eedd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Boot failures:	tegra124-jetson-tk1, tegra20-ventana,
                 tegra30-cardhu-a04

Jon

-- 
nvpublic
