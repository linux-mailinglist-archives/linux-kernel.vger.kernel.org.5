Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9C7BC091
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjJFUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjJFUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:42:28 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC66BD;
        Fri,  6 Oct 2023 13:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/IBRK0uTecvRa06rCkzOPwmrrCKCe5piU+VlHA/qxWqBoJWnxiuXIsOEJU0oI14eRSwXWn/94xOoiXv4YA9G964m9PrK5/yZplkAEyldlA7tKUcgdO7jItfkTPpMlSLkqv58w0lEkFDWvN2PB+iTIG34Ol/dbKFIOJKqpZn7dXbetAECV1XLBQiOvh6ImHhVSQFrtJelyJYCIcgK16PvkH70xV9EDS3p6V7QV9q5kV1bxkOQHZnntGZL3dypZAX0FbGEiXRiI9r6qOCG7WCnK7UJQ+BeaCI9tXCj09koNnLENxhV9wVOd6KJPmZ+QGVs1hEnLYhP/97gtYZx3Hv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oOZHVcqEta62Fn/crVWf1b/byqz5RcCADjOGXL0RBE=;
 b=dcU5NkfWJPBzlVti2gN0eXfj5c1DH1KtJrTjvoOKANyOYjOVnI+tYaHuB1ryijeOKJXMuZKoxgPgPwDLaHqlTI1cJYwn+ImLOxSyItbdWOtT2VQKOGXbAwR1pJbSoArE7cjH7K6un59Q4iL29l7LWCVtoSa34MyHxX8ab5jO30vAxxdsJ8c67cbKviM9iDucIgisNoURZ3EO/z7+/2SEkL7/uZeddIBqo2wz4k5gRiqQ3SPO92qBnCOeAZeXe6EAkVnz6zaKQp5kMnVLxdqXV+z70DCx8jj7vcgKMDFwf5EaivKyUFErBQZwAeEnn03ER9aby7KVc46MN9Ka9G7hOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oOZHVcqEta62Fn/crVWf1b/byqz5RcCADjOGXL0RBE=;
 b=FuBJ+hgLH8lzvNG7U1J2gKwxpZyi+sjGovNXMnguXz0cCZZLLRTuqvmyNfIB/OxI/FyMQz1J95xq+8ZoLbTOJ11Dg6Th4r/xFUY5XNwyB/v9V3P80gEMxHklfEdNFqivzbAAzbw3yghvcvGajt+DJr4B/N77GzsnxQBrno+Qk58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Fri, 6 Oct
 2023 20:42:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 20:42:19 +0000
Message-ID: <fd2309d5-ea56-abed-5c3e-a8a038b07d9e@amd.com>
Date:   Fri, 6 Oct 2023 15:42:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 4/4] Documentation/x86: Document resctrl's new
 sparse_masks
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Newman <peternewman@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <7bbdf55ac6f909a6701915d99d79c8f9977bd0b4.1696493034.git.maciej.wieczor-retman@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <7bbdf55ac6f909a6701915d99d79c8f9977bd0b4.1696493034.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0046.namprd05.prod.outlook.com
 (2603:10b6:803:41::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: ca827a8c-5d9b-405d-7c6f-08dbc6acbbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLMHSfHuzgHNNH9bxHC2fbxpChMRkbqa30At5eZFgaKFlGMtNXIPOkX1VhSAxSUi011zGYqvUcJpVXVgpbGFBdQgnjkrKn6EIBTpQAkDtfkA74GrZrIuqEfTciLVWTWaVrIyJelOw51rPnY6rN34MkV6ukJwWfl6VINUYnAE15pa1jOhlbw9V/kbdsocppALj4McX1z2VQutFFbx7Btxi5ECp+p1WvWGYt7wzb6fsIlrAcNV0/nfMgzN4EW4vGZcnvXXtA0GndmdUM/f/IE9sempPvKzP6u0yKHZYvT7x8ZFFimiytYLpT78FyQcAWOfj2aaOaLRQTBOLt8PTQCCoVXFLoiHvcsXBiMvW3QkZPLEK1OAfgE1g+YZ4/EWqR9eFg5hHrsvsD9AdM8viqusSoyA82ddKXmBgRCTXp8ftI8NRfwlKkNpVSEUAfpSMUBs5ug9BhVIICQ0YqCztHKiqdlJlreoEwQfdu3doVe2aDgk9R1/HkonTzSWCcViRbu0lY546yhjJgAMfigeQPC01MznzdjpZ3OEybBQG86D63phyPGpLeJ9hUVjkOWIrrlzhYf0Tafu4M3+7nssXTlJiPivh45MMllXJQJcYeB+eAUDeoDKxBdC5JNmz1F9b80hRygraTEXUSaQUq5utZBmp4kyU6YZmqqx0+wV8X5pafI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2906002)(83380400001)(7416002)(31696002)(38100700002)(921005)(36756003)(316002)(66476007)(66556008)(6512007)(41300700001)(110136005)(6486002)(66946007)(6506007)(478600001)(2616005)(54906003)(53546011)(31686004)(66574015)(5660300002)(8936002)(4326008)(8676002)(6666004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHFIWTNWVklBa05qQ2ZkeU1RRlN5Y0lnRm1XUmxpNTIxZ1J4QW1iUURBNERq?=
 =?utf-8?B?RGpTM3hHMHpXQXBaZkNieXdieXpxM0Y0MEY1dlJVNTRmT2xaY2htYjIvVzRa?=
 =?utf-8?B?bUxJY3lDaXJWbkdiTDYvVFg1YnZwU2ZUTXNEK1UrbmhRS1JmRm5SRzBlMjZE?=
 =?utf-8?B?TWRIUHQrdHJVWVQ4Vy91VGZ2cWlDdUo0UTJhT0dhNlJLd0t3ZXRZdStxUGtO?=
 =?utf-8?B?ZTE3MW1vVGk0aFVqaFgrVkdraEFDWVhHMTFPWFhISmg5OHVULzlDSy9WRkp2?=
 =?utf-8?B?M3llOGdxZFd0bkROa1RMQW1sVnlLTkN3cG9zc0NKSnkrRW9MWCtWbEhTYnBO?=
 =?utf-8?B?clVhM1NWZm5ydGxsaFFzQ2g3UHVSbEFkTWo3WTE4VHVvK0NDSkdyVmJZRHVp?=
 =?utf-8?B?dHpTczVNQTVvUExuQVNyR3pjQWlEVlkzUjBIUGc5Z3JoQXBTc0wyanRsNUcx?=
 =?utf-8?B?TjlJZEhoZElISk8xTVNKTVJvUndqZlNlTWZtT0xOekxlc0M3VDhXY3QzMDNX?=
 =?utf-8?B?clFxbFFLS3ZSbHlEQ2sxVzk2RjNFNEJqQ3MxU0VFbVc2WFplSGowcUd4dWJv?=
 =?utf-8?B?SjVwSm9YbC9MT3R4UUMxaFdHK3BNbzM5Q240b0t5OEdTRVpVVkcvTFRwNER4?=
 =?utf-8?B?QngxMWpMWmoydzBLeGZjYTk5bHJlNHVWaXYzcHdYb2lOK2tvQlAyc1hNRWRi?=
 =?utf-8?B?YXp3Qkplb2dQT01pSVNNUjFUL2p5ZXNFNDFNS0NOSEgrNGszK3FXTUhKUno4?=
 =?utf-8?B?bHlZS0tTbXJrZ1laVmN3MzlVbEM0NzNTVi9aUW54Y1c4dm5UUnVYTjJpRENq?=
 =?utf-8?B?azdncWlpamJ0QmkrQkRKY1FXNkp6YnFBalE0SklhSHdLZXArWEk2QWRZdzBV?=
 =?utf-8?B?OWhLVEZyU0ZkcVhiNXpDWS9WZVI4a3FIc2VtTm9teHoyQ3V4alRqdktmbDZ2?=
 =?utf-8?B?bGpVZ3poeDZrbjBMTi9lR0F4bU5SNDlVSks0N00wYmVnem9oK2U4bE90QUlV?=
 =?utf-8?B?cDU2d3lGNEgyQVZ0MmE1UlEwY2Z2NDRzaFdHZWF2R1g1dk9aWXZ2dmZ1aVQ1?=
 =?utf-8?B?REtESFBPTFlUeDBhc0JnRDZSckt2NkhqMHZGSXRvUEVxRmxvTU5hdjUyMTRC?=
 =?utf-8?B?L0hsaGVEZHMvNnhlNE1najU4anJ4MFZ3Wmx0VFVOVlROMEVOSGJnYmM3cmJr?=
 =?utf-8?B?NG5sZW80eStvYWNnT1NVSGFjSXgrR1dvUGlvS29FdW5rQnlmOVI0clBDeGk0?=
 =?utf-8?B?c2lUN05tNE1pNmhpMGZoNHBXNmh0blFZY1c0YXEwbVNWN3UzVXhuckRaUDlv?=
 =?utf-8?B?SnVNV0Zxa25pT0dGWCtnUkJ5eDN6ZEE0MUx2WXNuSVRBT3pObWgwbHJSYitP?=
 =?utf-8?B?UGY0RStlVTBld1JqOUJwTm1QelN5SVd5QkhHMUdyZ0FEa05pMHRkb1YxZXVx?=
 =?utf-8?B?b1pINHlidHpmV28wTS96ME1NR0dpcjhZNnAwS3UySVFlRTNvK1RIYmkrajdH?=
 =?utf-8?B?Y2dPeUZTczF3NDRhZ01TUEZxckdobGoxQUV1RnFDampvT3I4VGVTS0RVWlpS?=
 =?utf-8?B?Q09pbVBtQm1oV3haM28rQlNPTHJYRkN5L0dMcGpTZzZPMlZXVDd2UlA4WDFO?=
 =?utf-8?B?ZXpuSDQ0MVZqZkoyeVljd21pdXk5dlVNMGw1YVFXUkdSK3V6cUo3MFRoOWUy?=
 =?utf-8?B?SkFNUGpoOHN1cnRrR3R2cjRab2NqZktYcVp3aUV2LzF3VkJNZUNZdjh0QUY4?=
 =?utf-8?B?cEVpS0xjbHNVZkp2b2pXSEVRSFJlWkNBQnA0MGpWMzRpdGkvVEEwWjRHa3hH?=
 =?utf-8?B?Z3J3cDBNVXhiTzlmKzUyUU1sb2Y0WkVIbndjVGp1WnBWWWJHR3B6Ry9sY0tV?=
 =?utf-8?B?N0FVZjZQeWJHaW1WTGs3VDZ2MXVRTUxIbnJwZnArY095Y3pObExscGYxZ3dS?=
 =?utf-8?B?cXNOSWJOQlFibXFzSS9zdVpaYzZ6TGtpZjd2R3RCYXRGendOaUFpUjFvWmNH?=
 =?utf-8?B?QkhPMDFPckRZQ2NTMHNMZlVNQ29uTm5hYk9tRXBBQTJQYVdOQXMwRUNPUUxn?=
 =?utf-8?B?L3Z2Rk4vb1hvN2FReU5Na1NEb3pFdzZzQlpFTnVyNUZKWDFyNmxKVGFQSi9I?=
 =?utf-8?Q?yXIk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca827a8c-5d9b-405d-7c6f-08dbc6acbbd3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 20:42:19.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZXkokP/V5L/PqZ9YBFL5ZhC4TSQQN2VdSbZixsn6gn/1+MvBxb2WEgCZ2dP8c2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

My last comment didn't make it to lkml.  Could be my mail server 
problem. Commenting again.

On 10/5/2023 3:15 AM, Maciej Wieczor-Retman wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
>
> The documentation mentions that non-contiguous bit masks are not
> supported in Intel Cache Allocation Technology (CAT).
>
> Update the documentation on how to determine if sparse bit masks are
> allowed in L2 and L3 CAT.
>
> Mention the file with feature support information is located in
> the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
> are the possible outputs on file read operation.

This last paragraph is not clear.  All the information is already in the 
documentation.

You can drop this paragraph. First two paragraphs are fine.

>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Otherwise patch looks fine.

Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks

Babu

> ---
> Changelog v4:
> - Add Ilpo's reviewed-by tag.
> - Add Reinette's reviewed-by tag.
>
> Changelog v3:
> - Add Peter's tested-by and reviewed-by tags.
>
> Changelog v2:
> - Change bitmap naming convention to bit mask. (Reinette)
>
>   Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..4c6421e2aa31 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -124,6 +124,13 @@ related to allocation:
>   			"P":
>   			      Corresponding region is pseudo-locked. No
>   			      sharing allowed.
> +"sparse_masks":
> +		Indicates if non-contiguous 1s value in CBM is supported.
> +
> +			"0":
> +			      Only contiguous 1s value in CBM is supported.
> +			"1":
> +			      Non-contiguous 1s value in CBM is supported.
>   
>   Memory bandwidth(MB) subdirectory contains the following files
>   with respect to allocation:
> @@ -445,12 +452,13 @@ For cache resources we describe the portion of the cache that is available
>   for allocation using a bitmask. The maximum value of the mask is defined
>   by each cpu model (and may be different for different cache levels). It
>   is found using CPUID, but is also provided in the "info" directory of
> -the resctrl file system in "info/{resource}/cbm_mask". Intel hardware
> +the resctrl file system in "info/{resource}/cbm_mask". Some Intel hardware
>   requires that these masks have all the '1' bits in a contiguous block. So
>   0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
> -and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
> -of the capacity of the cache. You could partition the cache into four
> -equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
> +and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_masks
> +if non-contiguous 1s value is supported. On a system with a 20-bit mask
> +each bit represents 5% of the capacity of the cache. You could partition
> +the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>   
>   Memory bandwidth Allocation and monitoring
>   ==========================================
