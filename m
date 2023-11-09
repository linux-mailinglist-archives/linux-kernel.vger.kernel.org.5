Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F107E72D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjKIUaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345212AbjKIU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:51 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184944691
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbfNVueaaDAIpADI/khGuQmqwSNj+VBlZwvOur6LfIOIVo6OxUsyDplx9gyH8LjRGOVe4WkOYxxyYy27hJUmGhPL835X/bac7tDiRoEIbd0tFw178gMbG33vV/LjYxhpQGEkrp0oopuslLY8wGb0zFY8D84MFJcesFImy9leoqH7QKTi6ZpJL9akwGkliLCJaUnwnjUf9J0dCfZuzsF8z+y/Q9VCK5Uc6h+hFp9mm7rgZlVpQDaFrkwe7fmrSQgA0nApb+skLpOp2o1/iRLftQk7kbMQEpGRSBZPcdvuORUApMTacya9HZ5Wx3CYWo8r9w1S5v+xUy3cS2uF5ZHBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFR5yjWPgNb/03B3FY6SpOWaAcf279e37BpW5Zj//B0=;
 b=lfIR5iWu4yxaKQsxys6KTADIpe7QyHuv17LTO7+IIFrxT7H8JPDanbo+YZhoB5Pd09XKFQp6DqO1oYtkP9sURZGNucvFwOYVXR0LPV0Ya0sriLD8kSZBICg5iwPuAEiToMVNlrTLu/X0mYv83AhY/eUeRB3uCw44Lki7TMH95qsfKu8XAgcNuwMPAnuWpEt5b75Xc7H7xuMLLWRrYpLttDg6i50nUY4BT9qKhbw9qhMq6DF//0dC0B287qhjcNsEBtl5Hj7UNJguyzKqtXd0+flYfAoDsYRL0xXepQiO4LnsJa0uHjE0m5oJsUPbjgP8igZKlL2kC0hR3mnq+XwASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFR5yjWPgNb/03B3FY6SpOWaAcf279e37BpW5Zj//B0=;
 b=Jv7D/jROVlg8k5xgpVvuIYqHw1dNB58WM9KhCJhWauZgFM+l0Gt60JEW27XND47yyGhd3hsPQwBiTF30Y4fJRSrjBM4eLOkT0I8kj67PW/nCNVlO4b0QQySlZgKwhsRdvhYin0ZmXjGP/BvweBBJJIl5fku5TmHd1jGMJHUql4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:29:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:29:24 +0000
Message-ID: <ef995760-40d8-4cb9-9d51-0b9fa56dd3c5@amd.com>
Date:   Thu, 9 Nov 2023 14:29:22 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-5-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:806:125::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bc4f09-0998-4d39-4495-08dbe1629049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFzMcFQvMPS3a6lv5zyNEc8q0w2T1kAD0iQsDSEWM4fDtZVIhZxKmMIteOtv0OWiKKGpXmSJQn/GW/o5cJMUaEM3G3gRXETtTTKjz+GitApnRXGA3PCkXIJfUMXFiXZTLyonoRBWEx0oLheuXtDMON5VT65sYR8zSWwavD2uvHl1d8J3NK+nCPZ9PJ4Bnhcy44vPqukFhGW44NDJVsBaH4KwkeFSD9aEjmkSMwx7REgYQseMLBuVEfv1bPWIIoFAUreQfa8F/zer5MtWUvIW4u0fkHtnSVD0kLiMMreHjSN08lOiFRS+pM4w6g4cu1DHIfCNPXBXt2dvO0DF8wichlsyMWmd4+rYIUhumxtT4JryzuMaZ4b88UlmK3RSK2SACqSUAek0waD+AnhaacWU9ggYufHcu8A5XTXXm8KafdJt4TJ6A3O4KG/zSeaJ2N+gsCBVyPKWvKSfljC3bT3rSdTVtOsLUIEuWmAReXOLl//Tas+8LyNcD2Hzmrv/z/42pCcgnkWweRZzDDqkP+AB/FyELzH5b311krcb+UmRL2wV1l8KZ6SOghAD1euKqhZ+V74j06oac5IJ+PJ/u8xvc9ctHDQ7do+rJNI4FPC6WaPoskXsf5f2F3sIjlryMay4PEswjm7SjcMpYkBrgXTsww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(7416002)(5660300002)(8936002)(4326008)(66556008)(41300700001)(54906003)(66946007)(3450700001)(6486002)(478600001)(31686004)(2906002)(316002)(8676002)(53546011)(6512007)(6506007)(66476007)(26005)(2616005)(83380400001)(86362001)(36756003)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGU5a0dYbytIZDVEb2RWQ0VGaVlXNnQ4TVVZdk9TeTAwRXBqam50YTlLQVhN?=
 =?utf-8?B?emE2T0tOVGhVTmJsSUZGVVNLcHR5ZTJYemhLWThyaDBXS1ZxMGsreXpsdzJr?=
 =?utf-8?B?dW1HL0M5MWFwbFl2aTBvRUdEcW9Vd2J6UGQva3A5SGRSTGt4Nm5LemxQV3Uz?=
 =?utf-8?B?OHV4Y2xadUx2bjRuUXl4RDJ1S2UzOEJ0a0dQY2RSM3hUYWp4U2pGMnZNQVhj?=
 =?utf-8?B?OSsxYnNZMm04ZE5aczRNRDBTaFc2VjJiVXFxcjhyL0hnblJDZVpGVlNqeTd4?=
 =?utf-8?B?Wmk1MkZCajR2a2lKd2tjN1dNalJNekN2bXBGVFpaSDIwNi81NFFnYjh6amlK?=
 =?utf-8?B?R2RpMk0wS3dtNnVwaExCYXR4bTNCWU5MMWhmZlRtam1ZamR3WTg4NndBVFBK?=
 =?utf-8?B?RXZmRjdUS1gxTmxRamtWOE1NdmdYSzZDM0k3QXE2WDQvZGpTb0JNV054TU1J?=
 =?utf-8?B?TFRlTzVGTFYxM2lPdjJReWhRSExySFpxdjMyWmZhajJ2Q2pLMXdPTUw5cVNw?=
 =?utf-8?B?c2JoNlczME5NYWdtbmhVMmxSQlh2cThXck51bXlJUXRyelNCWk0vRGQ1a3Bm?=
 =?utf-8?B?SXAwUDI5NVFQUU16SW9rcC9iYnBVUTlhQSsyNWtFeG5vNUFnZHBhZitzYVVi?=
 =?utf-8?B?cTN2SmRpVHh5NGFmV0VKNjFKT0hOdURqeVNtcWtHbEUwa2o1WmRtUVdCRHE5?=
 =?utf-8?B?anVySnJudmVzck44K3lWWnpsRS9HWUZwUUJkY3lSWFI4WGRJbURLcXFkSXRj?=
 =?utf-8?B?TUx6ZWcwbzhjeVVyZ29Vbmxsb2JBZ3NHRkNwYzgveU1yRmQ2cmYwa081cDRR?=
 =?utf-8?B?VlBTUHovc09zRENRQjNXV2JCN0Uyd1pHeUtQNXBpUnVKcThaLzB0VXliQnRV?=
 =?utf-8?B?amQ1SCtXS21UYzlTdUtYUHdSMy82blcrRWMxUHluMXpoL1MrWXYyYm1FY01t?=
 =?utf-8?B?ZWpwS0pIM1loSkg0UkErSnpUbEtHT2VQakVWTFVtWVcrZ2hKemdmZkFsMEtN?=
 =?utf-8?B?OFo3aCszMFpYdHVzcmNrd3ZxTzh6SzJWZmV4Ni9PbjhLaDFwS21DNFI5blEx?=
 =?utf-8?B?TmNic3ZCV2g5QkJpZldKQ0dqb2RJanJHUFRQaXo5TjRSY1VmeW1nVk1VazNT?=
 =?utf-8?B?M20rNzVKRm9LRmswTWRXaUxKQ2kzRGIyM3pPS1NTVXJHSWVBbDNMOVc1ZTZZ?=
 =?utf-8?B?M0NtZEF3M0U0bkFuOWZITDRLUC9IT0JoRjZmakxBNXVyVGVlUTRTcllWbXVq?=
 =?utf-8?B?YnJBRGhiaThjNStHM2xaU0daZmNOeGFvNE5HWGtldnR6SWM3WEcrR0sxeEcr?=
 =?utf-8?B?MjlqdWdWTU1qaERlSFFpYUxCUzc5NzU0cVB1TDRydUo3UmF4QUd2c1BQcHpj?=
 =?utf-8?B?T3FUT3JwdGZDWUZIRHQxSElrK0F5OFhkazZWRnE2OUdyUE1jYUdST09GUVh0?=
 =?utf-8?B?KzlyU1dOQ0NwZ0QrbzZuaWF6UDV0d0svZU1YN3E2bXNMTFJ5QnNyTzcyWE9W?=
 =?utf-8?B?VTdVb2lKRmRxbk1MYldzckZaSXdvcndMTFN5NmJmS3NHVWx6Y3E3NU1RS1Q2?=
 =?utf-8?B?bXpVcGNMVDA1aE5VWVptRFhUR0pCZWVQVXBWM1o1MkgwQlF4N1UzOU9uVHBR?=
 =?utf-8?B?eEFibXowS05GV2lkTGdsUnFCVTg3eFNwZmJFM3p5b1JPcGQ0dk10Wi9ZWDZJ?=
 =?utf-8?B?UDdEb1Y3K0pNUDYwVmZZTXV4VGJ3ZXdIWG9jWHV5RkRsQ2lWbTBsNWFIbkNY?=
 =?utf-8?B?d2FYbWl0c0IrN1c3dXE3M0s4RjlWcjB3eEdyZGVGazlOWmU4MTRQd3NSMXJi?=
 =?utf-8?B?bjhoeXV5WUJ6R2xETk9xbUxkL0lJSFJuWHNsZEdHMFFIQldzbVZJR3llYTJH?=
 =?utf-8?B?Z2ZNODIrcm4xZ1c4NkUwZTZlQk5uQmFqc2ZxYnM1K3d0aUhPNnFtdFQrcnVO?=
 =?utf-8?B?Z09PaG14NUxRT0JPOW5HTFArZXl6bWV2N3ZZclRtdnNyNmxUdnJDRFUzUXdi?=
 =?utf-8?B?TmVSOC9rcXFNdlZEY1F3Y01IQnhzMndQOERWbUJONm1Eck9nUHF6ZWFPdHg5?=
 =?utf-8?B?RUo2MnFVbjVCVVZzbFlZZHl3TTAzak15MkEvYU94RFk5SmY5VVJWTHBobUh2?=
 =?utf-8?Q?Tgj0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bc4f09-0998-4d39-4495-08dbe1629049
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:29:24.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4XkvoUA11YWs4S5TTrQJ2D0p3mmKALzqnsnL9UEfsyf0ZtyuVY86+FUa/IVjnm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> RMID are allocated for each monitor or control group directory, because
> each of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
> 
> MPAM's equivalent of RMID is not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
> after the mkdir_rdt_prepare() call. This allows the RMID allocator to
> know the CLOSID.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Moved kernfs_activate() later to preserve atomicity of files being visible
> 
> Changes since v5:
>  * Renamed out_id_free as out_closid_free.
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 +++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1eb3a3075093..8fb0f56f64be 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3317,6 +3317,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> +{
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->mon.rmid);
> +}

The check if (rdt_mon_capable) is extra here. Not required. Otherwise
looks good.

Reviewed-by: Babu Moger <babu.moger@amd.com>
