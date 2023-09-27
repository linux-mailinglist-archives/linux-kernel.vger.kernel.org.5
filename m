Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD57B0F09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjI0Wrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjI0Wrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:47:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA5AF;
        Wed, 27 Sep 2023 15:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsFYWn+BpGD3dzXQmk5ydr/Gdf97f0lOGuYwMw+V0BmhlAvQlJvux6oZn5WsTYB2apupshVxn1iJ/JlDgH1XAsq1Av+M8bfqIUi+jg0zXHTGrFRMl4J9VX9/SF78VeKwXX9IpJr6IHgUfU3/ZGYzKMKUU71s4K83SQMgHCbWFFIcwPZ7ajFf4w8zd2460NbF5Tlt208NWslFvboAdRrOUFESxhCivMsZS3le+JYYlGOPCJC9az2WxMpu0UHbMLiCcybk1t9+6YhpyH/vgL13QiAyp3DJGaZlJPtKj+ek5eVR0k0y83jDQ44F+k6J1ujJlFbPWpRqo2y0x9pvrCtbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X5hPzDi/KaGd7fTZ9Lx7f/caJPP6Qf46ZD4uev1/JM=;
 b=GoU9lDoPcZqdV+XpevP4jaG2zycTha5LEbOQRpk9RegpoHcozuq+VhVZSQBzqVo76eGO2gPCijpdxKHWU7g71m5rhULa4Ayw8baw/ZC1iKQyZEfOw951D5/ei3ECOnJfXfdjDnXPZPmOnWJVMK2RsuQRmlPMuJlwkKi+maeZycxXeFiA+JyczdO0sn15rnGSVgYTfiJbrHmldU1Ez7PL9fk5nvmFBKlCve1fanDq/Dk2JeYDVLXXWgUaauOberb33shBqbEKMVoH4Y73KoUgDMjEcFgheoTfRklzR63K7GA+/YjJaZSRf5x4FdYm2HoL4sVoHqwh8/r605lbXpAf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X5hPzDi/KaGd7fTZ9Lx7f/caJPP6Qf46ZD4uev1/JM=;
 b=ObDPCOa7dcw0mDBMHhm10hRvdwJBLzb6Nztw4rPOWFOumHC4eL47jUL2aNQ70pOI+6aH/To4x5ansjO45x1JxxrCdHun0AAnnEafgaeEdDlCTe3l4JWZoOmhmPNdmF98GDOwSx16MbCLR2uD1Eix+m7hClWifxsDedGH4tnEnvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 22:47:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 22:47:45 +0000
Message-ID: <17079b9e-4efd-4258-2b5f-afc6d3ae2c0f@amd.com>
Date:   Wed, 27 Sep 2023 17:47:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 3/4] Documentation/x86: Document resctrl's new
 sparse_masks
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <308c92438288a45a12330af83aa0088a31f60343.1695371055.git.maciej.wieczor-retman@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <308c92438288a45a12330af83aa0088a31f60343.1695371055.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:806:d2::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e81082-d15b-436c-eb6d-08dbbfabc3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udTsBfokG2HS/afUdhPU6hWlRq09Qlcz9Buom99JyAqIUinJ/LYL+JJMgymIHSru+QK/SnjRDK4MlTTLbMrK213bb48zlfYtuq7+69UDRDxF3RaAJ9ju1Owb+T55Me0pe9eBwAXtLPXF6j7SWnr/uu4pqVcI8QDLlsKHLaVgP4/33+MMtXgMkFwCAoHz7WMdeZaCgWNZHmk9hW3oUda0RwA18LsDOKTVX83EM3JjHAB5Y/XkYdKMDvPl+iUiigS5EYlNalXMRWfIqKBZXui8F7gu6tYbrx888pIyjaHKN5WY/bMpsd/nVIFQDnf+SZdZsxmNADjkib4PXBuR3H6z/36gvKYZw/+8mVtuiRxhacH5i7DmgcQm42pFGW8dw/Qc+dV0sRRVmosg80//kqWwmTMFLhv/cbKl6fach+bdBfYJcFQir07c7x5JM1tSi+qDgpWSnwINZTZ/bjhIeAyavI8NJqJH/T+QBYLjdNgeTG20DVzs4ZJO5UggHz7kZxThcj4ijUI9f/DGX2ik/Nkga1JvsCm3IguyWuILSFwvs6qoQDaMRHT93guzUnA22I3CUpyXjPlmMbzzUAKBR57sk/Z/UQIjkfCJ9z8kLFsTkql/bmFz44Q0RlwFn1dWxfrjOfcsbeb0h5pSXIJ8MNIpH84+pMlLSwHqqm0PKt5Zxjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(5660300002)(8936002)(8676002)(4326008)(921005)(38100700002)(66476007)(66946007)(7416002)(66556008)(316002)(83380400001)(26005)(31686004)(110136005)(31696002)(6486002)(6512007)(6506007)(53546011)(2906002)(2616005)(36756003)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VMRTRwenZkNklQR1M5elVOd0tuZGk3ckZMZHdEdUVidWRia040QitENnI1?=
 =?utf-8?B?Q1J3eDJCNzZ6cVRTdXlTSHN3ZGIrK0xTTGVjRHdNSlgwYytDdlZkcjZhTkQx?=
 =?utf-8?B?YlRZRUZYQzFrOXA5UWJJN0dCSTRhWklQQTYyL1pHTWtwS2VXT25EUGFQdzYr?=
 =?utf-8?B?ZS90eTRLYXdBV1cyZkJyUzd4QXRRZ3RrbzBUc0dUR2VmbjJBRmVlcHluYnI3?=
 =?utf-8?B?Mk0rV0JDdG9NTi9Od3RVTUNhNlVRZ09saVdrcVRqanJiL2tTMDdaVXhDNkxa?=
 =?utf-8?B?SkhDM283UGdRTkorNGUvUDZXZDA2V0RlWWdGejVZTXhXb1NRbCs5SUNFeU9Q?=
 =?utf-8?B?ZEFndzJiaHlnWGdid0lTNmt3cTdDbTYrWDdKRzd5UlZLQ2crKzMya21MVmhv?=
 =?utf-8?B?eHFGUVRMWG90Y1VxeUpKY25ZcFYweGVOcC8vTXN0bmgvTS9GcG9RQ0s0VmhL?=
 =?utf-8?B?R2ZZM3JSVExIanduWURIcElERWJydm85RDMzdnZsZStOdGdFSkNVenQzWm9B?=
 =?utf-8?B?TktIbkFjNVJwYml4YlR6cTV1RXdnS254VDhMSFhzOXhWd3VDaEV4VktKbENV?=
 =?utf-8?B?alBtTXhJeWJSam1SMGxmRVpLWkVVOURHQmE4a3ROdXlNc0FiRm1jOWdtUEND?=
 =?utf-8?B?d0hKNXFUT1dXYUl4bFQwYUJ2NVpLVDdBaW0zanYvakJYZURUR1ZTSWZCT0k2?=
 =?utf-8?B?eWF4b2dTSUhRdTlscGlBM0RGbXpuejZsR3pSRldkSXVINm9NN21Id3RWb2hK?=
 =?utf-8?B?a2tRSUVzN3ptSUVZcm9nZndXUno0blo5ZVBxbVJkUXZNMElFSzkxakFRYW9K?=
 =?utf-8?B?dFlVeUQ2MTFhNURpRDNYelBNcVVrSGRwUkM1djh5ZXNKVDlaQlU5YzBvcHhP?=
 =?utf-8?B?QTloMkRHVU1NWkV3azlVVXVwOTZJcE1vOU1mNUFJQU5vMXZ6QVU1dXMwWUN3?=
 =?utf-8?B?aEtxWXUrd1lERkJFOWVMR2VwVkNrT0ppdElxalhGUTVTek5yeDI5S0VDckR2?=
 =?utf-8?B?ZURYUi8yYllXUkpSR25aRW9veWVWaUw5ZUhpQ05BNU5rQmpmSitSNlVONW0v?=
 =?utf-8?B?a1lCeFJZMGlBWmI2S2JjSFBrVEJTYnFZMTVpdmQ3d0pmNzVwcW92VXkvdWpw?=
 =?utf-8?B?c0dnNHR3b3JQSGVmaXFHMjRVM3ZGSEdGRURnUkd6cEFzMVRoWURWVE1LNFRn?=
 =?utf-8?B?RktzU0RJQU8zQWFFOTg0MGVIcXY5S25yNS9JT25TVUZhM0VRVEJBb2NSUnZS?=
 =?utf-8?B?ckwzd2VaNncvcDM5YjVEN1hqUjZCa25aMEhNZHUrZURlaWhMS2k0bFZZMWNQ?=
 =?utf-8?B?Y25oWGt5RForR0M4ZXpSS2FlR3Y3T3hIaHRIYkNZdFkrNjNkMERrTDBFUUhM?=
 =?utf-8?B?NW0yR1FwdTJUNkhOcUJiSnlndllwa3VtVzRRc1YyemVMeVRxTTg5UVhSdnhs?=
 =?utf-8?B?MXN2WmdEK1ZDTXo1bW94UGdvcnQ2bGFKS2tlYUV5TVFQREJDRlRDZWIzSVQ0?=
 =?utf-8?B?WWtYY3FUWlNwK3o1UzUwLy9jRVlBSWlvYVA5K202VUZXMkV0M3NUbWxWNXBN?=
 =?utf-8?B?Ykt4Tjg4dGlhL3FPT2Fxd2k2cndZZThtekhqYXY3VjY0YURCZkZrd0ZHRy94?=
 =?utf-8?B?dVM0dDhSOEJvL0JlVU91ckphenFXd2F0bzZFRmhCY3J3VjF4dG9ScStwUHlr?=
 =?utf-8?B?UGNFSkRWcy9Dc3dRTitkdVFGTEJMcDhQS1lGN0w3MzdmbjlCclNzT0pWVFhC?=
 =?utf-8?B?UEgrdWJkU0ZhakJ1OVNUYk1INTlIMXlNU2hHNlBpaExFQ0Y0YXlDS0Q4cU9p?=
 =?utf-8?B?aGQzcW1mRlVUUmI5UDhNNTQ3YlBoY1ZsS01McWk5K1hwK0J2TUkzVHBTa3da?=
 =?utf-8?B?a2NzaTFIUlIvcmNTaERLNXV6L3RGRHhtMFJtYllWYlRseEd4QTJaM2EvRjNZ?=
 =?utf-8?B?clRaRWIrbm5kRTk5SWIxWUVLRXZuWFFBMHBhNCtON0FnQWllbHFKczB4N0wz?=
 =?utf-8?B?THRrY2czSzZUOEZhbjY0dWp5VCtEdThBanJaUmlaOWlmK0oxU2lUYzRVNm8z?=
 =?utf-8?B?NjFHR2lrdXFvQ1REaVdpR3RXUWlBek94MjNIZTdYSEMxWExvei9QYWt0Nmh2?=
 =?utf-8?Q?gR5QPyH/2D6hImvBbQenLIfSI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e81082-d15b-436c-eb6d-08dbbfabc3bf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:47:45.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NIkJwH+yNfnAqedV2JkOktQWJjlIKsxrZbr7heLElgo9x2Lmv83Sbf7sX+h85FC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej

On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
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
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
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

This is little confusing. How about?

Non-contiguous 1s value in CBM is not supported

Thanks
Babu

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
