Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F617AF39D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjIZTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjIZTAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:00:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79150DE;
        Tue, 26 Sep 2023 12:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyHAu7WGqo7voAo5L3p0BepWQnNMs3XFQeyP5lpQI/aiGDPPj2RaipCicbScl1G/SUqaXWPilpswMuCTXxRd1q/xNHUdOCCa6ewxsCc7aCwkwfrBhrHoLhI1U/7YDYCnrd8cfcwSP6ok+nuMPsJbqXd7n7Bt4z1FdTWMmxf7DVuIr4ftiKUiAMXeoGsIQIqE+NgSssYibbZN/SJasIbV1y4piq0aQIbAB0PmBJQrhZgq8k9WuamFh5VDonXhGjlrAaYp0w5/rnvWrNqNaLDmzMkXZiXawouEvpMxjpEM/SIMxt03Y4ChR8XWHp+6u7kOW18LN8vmo2RuZCRbM9hQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45xN5Yc0dAF2ZBr/OuYxk3vWhTTQUeXWCctLvwfycOM=;
 b=OVJm59Yzxl7wEwSenJDDhy+Z1M0QbISd2PEtHEgf5TPR3pPPQLVenJKMcKUgOOe7ko6mneT9vz0V9iDEhIiWg8Qp9i67bZVcE5T89hxVZjOu1MHB8l2a0jJ2U3zahsy5GzUh9Iko+FbInZUjGx0lFamuPdcqxQm6wPm4nxrMqM8QkAfzwzIOccfIVv14TEJEkDwwJoi2HJSsG6H/09fXI7VJGwcb2ff/8/8LyU6uvu7hTs/4ZpZd/Xda4bw26wlKdSMPFy6AyPmtYpJSPir4NglwRceoGoYQzDvnRp/l2P/pmYxsvExGzeeIbP8RTUEEgvl2bhlR3UBq5inn8lXXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45xN5Yc0dAF2ZBr/OuYxk3vWhTTQUeXWCctLvwfycOM=;
 b=Jn6AggZlSdtRYK4bNhRXRkbTO7zsI3EmYGWMvrDzfX1i78Ffc2OmmMMmon7mRl2wX4GJy6v5Cjvm8HKPlabg2BhrX265flRzfR8u1A0BCROdZPrtN3+gtUjh3wkqRJrTB1dOzg+a2eUeHDOKrpC1/mktmS2DH8QRauRXZofgZIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 19:00:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 19:00:40 +0000
Message-ID: <560710e3-ce47-db07-e81e-3abd61e6ffbe@amd.com>
Date:   Tue, 26 Sep 2023 14:00:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230829234426.64421-8-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:5:120::36) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8837658b-2004-4743-66be-08dbbec2e0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lG3Nr3IHVSGVI7PKMVSZvn98+1c/R0XCjpj5vAkk/Hb8QjSLMkuYSjCP9Pwqe9c9EEgsMlarWhc6DVqIv8xnt42VwKrs9cHvVC5dTSL5MENJC0yQJZ3E6v7InfHbZhrOjDEqzbnTnYMoq3qVUf0g9U/633HW+Nybm6Qrw35TlRHbzJO12Lp/U8RJFcwaWWdGhp4rfGfgbVgREqsv7jDoyuWOlhaqbobFQNoXjYDZqWIhHHeJYd0pgAdV3WdNcuOnc9LsPWBD/ajJ23OIvWIexfoDFiFRXCpnEtWpVBKl5PdDOmK0G5nItJBPldDCEzM1in3BILrIJMXlgURNDJhfalY+1b4YZr74qztvCrRrREdFMeC6vbatOFw/XNPiYmC/dCicuBmu+zg/5eBGFam1DDwrZHTT2XveTapxd+oHTqFp1VvR9ZFHdJIhXllImJzYLFXL3DibowqITCa5KdtKd8gyVIZYwr1GxUs9npsl7IMEByruJGGiPEBFCVsLMzX1hzoM0jpInyFSXM42p3rHiUVFTcBrUmlHRMLnY438W/4HNK+rxN6qc7rhmum3cUEkkaDZWfY1BdUBGArkMYMMVONWICgwoo7+9corW6RWknnQjQzplQiKXX/0w1rkJAeK3A0m9rDewIJVdmZXvOBAGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(6506007)(6512007)(53546011)(2616005)(7416002)(2906002)(5660300002)(3450700001)(316002)(31696002)(8676002)(36756003)(41300700001)(8936002)(38100700002)(54906003)(4326008)(110136005)(478600001)(26005)(6486002)(66946007)(86362001)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxRd0Y2aXd6ZTBwL0l0aUNWQVFyL0toaGU2NE9pSmw0NitYRUpCeVg1Nm9C?=
 =?utf-8?B?QWVPRHc4N3o2UHE5ZUYvZWNyaVlpWVNHby9HblpFVHVBQ2RsbXlKYzF5aWNi?=
 =?utf-8?B?c09JbkRBclQyTno0L2p6ZklNOWg1azRYZGlRdXh1dUJrSjJud3dENWRMSUNQ?=
 =?utf-8?B?dW03VTlJWi9lWDB6N0J5OEdPNlBpNGVEQXhhaFJaNFU5elBMTXA1a08vbkZL?=
 =?utf-8?B?WWV3TEFmZkw2bFdBUTJkR09SUVBwZm9ld1IxK1N5Y09MdFpVL1JNYy9wazF1?=
 =?utf-8?B?ZTMzbGl1SkJRSWwyOFpYbjZrMEFjTno2R0t6aktNdlhjd1BMcjlmZXlDT1BU?=
 =?utf-8?B?Qy9zWjYyZmJ2T3NreWhwYVU3cmVUdkFwTDNEVHVzUnhNL2RwZmR2eXNqZE9o?=
 =?utf-8?B?dlRVMkRiMkQrZys3WHFXTWV5TVloajArM25aaGdlN2Voem15bHFLUHRMUm03?=
 =?utf-8?B?aXpXcDdxWWdOeUU5T0JHMWQrYU9xOXY1L0ZYaUF0YU1uVnZ4bDFCTGZZQ2xs?=
 =?utf-8?B?TEJMZGNEdW9jUjU5QzU5STN1R3F5S3RnZUdEZzNXR0xSS0xCWXRVNW5pU0tk?=
 =?utf-8?B?SmM0SmlhemExZkkyQ0FUNjNWUFdEUENHNDBnbjBsRldpbnU4Z3BaNTNrU3hO?=
 =?utf-8?B?L0dBbnRTaGxlNnR6THQ3U3Y0bVc5M0NzeDFkMHBqbEpTNEdLNERGcjFmeHky?=
 =?utf-8?B?NG1zUHlhdTRib0ZnSXN5ZVk3RTBabnVSU2xEUXA5aWp4WDVuM2xEQWNGZ0V1?=
 =?utf-8?B?KzdhbGd4ZFFzZEV1Si9sSmhjVjBDOStrWkFYaUZxcC9RUllBN3VFT2NUNkI3?=
 =?utf-8?B?U2plUFgxd0ljcUFvS2NkK2JIMWo0aDhvcUJMaEV1Y0FRTjR4b2tGWC9zZG1Q?=
 =?utf-8?B?NlhVd01uTDR5T2xlcFNNZjZXMjhPU0ttTnZtUkJndXROakJEYU44SjQrQVZ4?=
 =?utf-8?B?NDk5NzdTbHNSWW9GWDJBNGlicTU4bFh1V21XWkJsaUM3QUlFUFZQZjJVd0RK?=
 =?utf-8?B?K2lFWnFaTXp1aUJVblA3SEdVbFBvZ1k3TlZDU0ZWY0FpdkxxV1drcktPaWRB?=
 =?utf-8?B?T3M4S3IveWhscDVVMlFibHBVQk1JVVg4Q3hING1GWlZyN0FCS0gzWnJTYkti?=
 =?utf-8?B?d2h4RVpWOVpUVjJrNnRIWEo5RmJ2NjR6NXZOV3B1WXBCUEFXUTBXcVB6Z09t?=
 =?utf-8?B?NUlHZkROaFRiZVpQV1h0ZHFacXBPUG5Va1ZLTm1TaGViQjNxRTRHajVjMGFI?=
 =?utf-8?B?bHI2RDl6NUJmQUFYdW1RREVpMXNOak42d05DZDA2TmcxTGRpOVpjY2k2aXhW?=
 =?utf-8?B?NHEwM3ZwM1ZIUzA0bGEvL2dVbVR3akR6RUF0enRaZFFCSjFHeVhJcXJiWmJj?=
 =?utf-8?B?UjRNdk95bEk1eUw2b0lxU25IQ2w2WjRUVlBEbWcyeTIzNVdwZGxsWXE4cFJm?=
 =?utf-8?B?SW5nblhLS0x6SWQrRTY3eUF6eGVJUlZvelArMzB5eFdUelRJRXJYYzF1aUVV?=
 =?utf-8?B?VVJDYjh3ODRjR1F1VENiSjdNMEczaDROS2gvWDBkTERDZzMvU0VrdW9sT0xD?=
 =?utf-8?B?QzhRcEpKa09BMjRZTFNKS3NRdGtEZ3ZkV2ZVcGRSc2drVm1XOVNBTHFqS2xS?=
 =?utf-8?B?bzlGNm5lS3VNV09zejkxWTRYQ0NYSGEzM0NYa2x3YzJvK1lEWTJqdTE2YVFl?=
 =?utf-8?B?MzBmUEk4UXVHNTJtMW0yaGtocGhLSlBwTlJHRVdVZ2pmMzR4V0VhdjQxYStk?=
 =?utf-8?B?Szc5SEFFSFF1S1FEejZxaVQ0UFBjMTFaZWJyczM4OW5QWGlBOWxsRE03OVZn?=
 =?utf-8?B?aHJORk90Y29zdTh2ZVhTakFzN2w2cm1lWUVUZ0pFbTVrWHc1NkRnVDg1ZjF1?=
 =?utf-8?B?czF5VDkvYWlsMC9TY09SSW56VTFiR3FzRTNNaDB2K3BvaHlraEtkUlNZa3d4?=
 =?utf-8?B?UEtlaCt5WjB0Ylg5NHZ1bEpIUmZTcDBHUUo0YVZXMSt3bUhRRnFTK2htcUg3?=
 =?utf-8?B?ZTdhR0wvZGY3dGkvZkVzNTE4N21BbHBpLzdMWEZCZ1R0MVlIVDNTZmtPaHI5?=
 =?utf-8?B?VG54Y3JDWTNjUTY1NDBnWkdBemRjbmpzNmlVTE44TnZTVG5ESGQ4OUR6WjJI?=
 =?utf-8?Q?L+Yg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8837658b-2004-4743-66be-08dbbec2e0b6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:00:40.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p228UbHsR2sAcM8Pa7TmdC/j7riGI/czKym2IxESbGY+o1cIsDFWQLGgqb2je0VE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

How does user know Sub-NUMA Cluster mode is being enabled on the system?

Do you have any information in /sys/fs/resctrl/info?

Below documentation does not have any info about it.
Would it be better to add that in "info" directory?

Thanks
Babu



On 8/29/23 18:44, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..407764f43f25 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -345,9 +345,15 @@ When control is enabled all CTRL_MON groups will also contain:
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> -	This contains a set of files organized by L3 domain and by
> -	RDT event. E.g. on a system with two L3 domains there will
> -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> +	This contains a set of files organized by L3 domain or by NUMA
> +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> +	or enabled respectively) and by RDT event. E.g. on a system with
> +	SNC mode disabled with two L3 domains there will be subdirectories
> +	"mon_L3_00" and "mon_L3_01". The numerical suffix refers to the
> +	L3 cache id.  With SNC enabled the directory names are the same,
> +	but the numerical suffix refers to the node id.
> +        Mappings from node ids to CPUs are available in the
> +        /sys/devices/system/node/node*/cpulist files. Each of these
>  	directories have one file per event (e.g. "llc_occupancy",
>  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>  	files provide a read out of the current value of the event for
> @@ -452,6 +458,19 @@ and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
>  of the capacity of the cache. You could partition the cache into four
>  equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>  
> +Notes on Sub-NUMA Cluster mode
> +==============================
> +When SNC mode is enabled the "llc_occupancy", "mbm_total_bytes", and
> +"mbm_local_bytes" will only give accurate results for well behaved NUMA
> +applications. I.e. those that perform the majority of memory accesses
> +to memory on the local NUMA node to the CPU where the task is executing.
> +
> +The cache allocation feature still provides the same number of
> +bits in a mask to control allocation into the L3 cache. But each
> +of those ways has its capacity reduced because the cache is divided
> +between the SNC nodes. The values reported in the resctrl
> +"size" files are adjusted accordingly.
> +
>  Memory bandwidth Allocation and monitoring
>  ==========================================
>  

-- 
Thanks
Babu Moger
