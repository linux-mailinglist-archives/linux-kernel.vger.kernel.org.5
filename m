Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00A7E72C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbjKIU3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIU3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093F53A98
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/7ieW/VLojyXjAAgIBX5athOV/gG3+ZhHzm/kG5UwOhOjRup7dWcQt5woA96vpBrEr6DjjvSuFs5uQ1HQbnMkOFkRB8LK3y2gHnEOI3FHM+6XODJzfVw9DvRA8KYbx3AZ03exXBavDAZgPnv55lfdcoKXa+DGcovkdFf1ysFjpvQOGjHrh9gQ5gaGpUohazunJhM+CAwDs6derv+UtYafeNSuIrsBGydfSpiKczotreEWArohpmtMrpXhmecVCvG/pSk495q58vRn+7W3lJi+O2gSGa+RKkxxm5H5Wa2/jR0VX2jw55uqzUTstZ1HKLoz/ai/ygasVH0sTuDcFr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QBo6vmNDL6pIzRWv/+FNpUh16lQM4lG4WisTpaLy7I=;
 b=llaFr6NCy4GXsYVyu9Mw9kDMII/Hq89QM0S3W8CtkuXEQWkTzdRPVBFwPFTXHBmEsr6J8ZQwJWZoKt0WNKVeAUV7ekdnRqcQornMf/ndDxDIWLyLNADrJTr08AZ3EhYZvI5yGXVwQtDXht0Aax9yc0HDjc2CgaPq05eSZDKr/9NXjegaBMCVb/jr8qZ+4QglY7EKGVAF/Q7x/qx3zUOovWIQ/dSIaOGX7MUnbUx+gy/IwSSTj6FHWSPTYEhYObL/63h2xDzMUZZfLTaBBHf2TthDr0T8xVjIAPBGN0II3Pkd6XQh819iC19yilBioXcwFaiGv+ElqJ5BWBKfiwwf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QBo6vmNDL6pIzRWv/+FNpUh16lQM4lG4WisTpaLy7I=;
 b=2IEFnzqz3xWhfYb1dV3DHNLjaohS4OwX/EIsMjiT3lY+hwR3DPBtndbGS5ySTEL0Epidy4/TQk8Jul743sfaQY/DU+0Fr1wsXr2Z6RPNhHVyp/qbnaW+mjEh3x0bL7b3HjJ5yJky2Pd4kn0tH8WK7CrJIlO2GIf5jpT3d9AeAqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:28:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:28:57 +0000
Message-ID: <2180a2a6-a61a-42ed-8a9c-5f77d10dc1ca@amd.com>
Date:   Thu, 9 Nov 2023 14:28:55 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 03/24] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
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
        dfustini@baylibre.com, amitsinght@marvell.com,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-4-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:806:125::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 535cba18-3004-4167-e008-08dbe162803a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05G2IiIhVFtpIeA5YQ95TEEWrvPnHEH5Vvb8A2Rt02P7XvJKHKETHIQT6xpRVn2fOzkGT/uZe5NTHMQD26EaUG58dPQ0r+J/nH2zYYn9DDOmMF4b0ivy9q4Ai0YjNmcOCH/GB2kOT8tiFcyHqZt1PqvTRvrc/JeYIodmcFSGeqIsmBxys3BZRTBcr88gyIAluMplZBhJ684/Y7s3jCAWMBCTSjdiQsREZqfBIqu30zxuwxpNClIov4exPdtOFZ6LfddakB+X1uLOatLPTohwW3BxQ7L5OMx+5Y6WiVueVuC51/oi+ZizDR0WalT0GtaodgkUyOaZWpmfcJi70VNYxnXok+UOYxtSFqF82fJg7FlblgorcRrBGPxkdp0k270vMFaUDcfvB7bVtj5WBKk9Z0vI2kBG9U46n4t17wgh7Riv3g/eByroQQKPFdlSiJNYPVwaF0h/qAf/TMX2aPsjQ3N9FS2gl+kdLAxipE+i+qpZXf5gUI4FYAbhpglUTvTKe79T/NTOzTKyMOBEJAb1bbHsS+WI99WQ1Y+l4Q9uvx7JnCPvpRebQced4olX6gBU+F2eafBBZljOT8vBVIkrcE9HePw6+f1pbHeRYAc4ggfuZF55U6WJDRm33vAvMcjS8BNAMEYQXGngjYc8WOE/YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(26005)(6486002)(478600001)(7416002)(66556008)(66946007)(2906002)(66476007)(66574015)(316002)(2616005)(6512007)(6506007)(8936002)(8676002)(4326008)(5660300002)(3450700001)(54906003)(41300700001)(36756003)(31696002)(86362001)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm0wK1ZEaVVyUXBGY2FXbFczd2JUemRYZDJoYVlRaGI2Y25BUGt4bVVYT2do?=
 =?utf-8?B?MGsrOUFnazM5Z0ZYYVJHV1FOQTJPd25iMTlrQkp4b2Q2NFlSZzFaUEFtek9p?=
 =?utf-8?B?eFlLQ1ZYM2VDck84a3hPdkxsTnk4ZXgwTGMxZzRYTEtsRlphVzBhTTQ3QUJF?=
 =?utf-8?B?Nk1uNUFqbGVIMjc3TGN1WDNNSis2UzBMSTdsWEw0YWlXZFhMNUM5V3ZzUzJS?=
 =?utf-8?B?U1dTaS9mSkV5NmRSYnRwUDA5UHQ3Q0Z3OWlPeWZUWkh5WU4xbEJ4U241TCtv?=
 =?utf-8?B?NGFrUTI4SnM4VXJJOTIwUzk2cEQxUDlzV3JuRjFMUWlKM1ZYK0JnSWZpVlp6?=
 =?utf-8?B?ajNKMitibGY4Ny9RQnVKOHNLQnF6OHRaTm9BaGNNSDZBSG5EcUNsRTdlSFJF?=
 =?utf-8?B?TWs2K1MvUWFuaktVMitkRkFzcXRwQTlKamVQTUowaENjVzEwc1JFQlhoNGpI?=
 =?utf-8?B?WlFwNmhjT2JSZk5FbURRWkI3dlpuQko2d2Zac1VkcVBuY3FkM3EvdFZyRzg5?=
 =?utf-8?B?cUxWOG51dzF6Vk02VitUYzlrdmFlSzhmS05hdGYrUmFuQmtmdGFRUmpwanUw?=
 =?utf-8?B?ejZJVEJZc09XMHUzblNSZ0xveGcyaXRBMkRGUG5qK3RJcjZWa3Y2QmdsWkUx?=
 =?utf-8?B?ajhoL0I5UmZORzNvSjBoVTJNN3ZrYkJpUExFbFE3bU9mc3hEa2l3ckhneDA2?=
 =?utf-8?B?L1lKa3ZCS3U5QzBQS0k4U0F3dTJlWnNxQkozTDFXcVlBQ2V0S3BLR0pEMlcv?=
 =?utf-8?B?VFpXaDVtTmpWQ1F5RTFoWjJYWmlyaXVmRGx3KzBOZktNOEdNc2lGdkNHT2d1?=
 =?utf-8?B?WTdYRlNnT0hQWXZzNDVERmxPUmlHTXVjVjZDb2NLNW5ZenlZMVQ1Y2ZLRVI4?=
 =?utf-8?B?T3RJWXJMK3k2bU9ncERWWkZkbFRLdzBRcUY1TjNiRXNmVlJRUW5kTERzNTJQ?=
 =?utf-8?B?RVpWVzRHVHptRHU5MlJ3TUtDRkU0OWg0Y25aRXU0MGdLbXA5SzBWcTk5MWZy?=
 =?utf-8?B?bEF0TmYrRENqNlBBWk1va0lHS0JhSi9GM0xpbHYxNm9ib0djbUV3TVpYNXJK?=
 =?utf-8?B?TDRkSFpDOStNVW1JcHdmN2QxMnJERG1iZTk0OGxYWEwzdlVXeEJBdFV6UzRs?=
 =?utf-8?B?QlEvY0lKck5ScEtsam1BUHNlNnpoREExWUpPYmVpWm91ZzU4aDZ5cGFVUFdE?=
 =?utf-8?B?Z1lBVGRpdjRRMm85Wld3WU5KNUR5eGszNGxEMUFLUS9jZ25xYjRRclFuQW4r?=
 =?utf-8?B?N3hlVUErdlNoSVNWNjIyMC9ucmtScGNrWnM5YzBRbWo5VGVGS0lJTStsNWNF?=
 =?utf-8?B?S2c2bWxXSFMxQ1RkVjI1WUdrQzBoOGJoZXp0cXloNG9NeDFxSlRxMkcrQ2ZP?=
 =?utf-8?B?N0ZQeVp2V0VleS90NTBUbVlyaC8rOEQ2UzI3MmJzTDVsWTVNbGJTaWJUNU1G?=
 =?utf-8?B?S3lxYXM1S0tPOVVQZVJjcTRhS09QUGd0ZUVhL3N2MHZua243UzlYNEZsWVE1?=
 =?utf-8?B?ZkYxaTV4NFZHbHMvanFXejRYdzVtVHZ0WVEyYWFKc2NjaUtVWVJMY0cyMDZS?=
 =?utf-8?B?a2hqQkN3NHFTaVNmUVhOZ1dqY3hSbldnZ2F0MTdpc1c0VEFrZ1lRc0hkdnNk?=
 =?utf-8?B?VzZNTjhGdnQvdWlVRzlYc1owb2MreEZ4TnFjQnF6YnFLS1NDM0h4aEtaeDhk?=
 =?utf-8?B?ZksxZnZBMEo2UXFLOHhnQTdEU1cwRzdJNUpyTWFIRDMyMWJYMGRyVGUyd0VY?=
 =?utf-8?B?bG8yRktSclhzZ0g1UnVjcHArV3Z2S1RBM3U4WUhmWHgyTDRxeStya3BnQ0FR?=
 =?utf-8?B?RW1XU3hWd3QvaXpkVVA2MVpUS2NlZVFGalp3aExSOG5GMU8yU2JkaXg5WDRY?=
 =?utf-8?B?YUZCSUpibGxaMThXVFpYTWNqODNhaHJueno0OXJhTDBKMy9GOHcwTEJOeW4z?=
 =?utf-8?B?OGYwVEN2Rk9XMGlGMzRBMmtqakg2SnYzTytadXpBTUtKV1FMUCtmNmxUN09P?=
 =?utf-8?B?NGxncXd2UkZBSURKMXdad09OakFHRWlnVDRTbDBrL2w3ZnZXckNxd0l1NC9D?=
 =?utf-8?B?VDF0VnNvL2tyeS9YS0N0QW9rZUx1djNYUXU4U1VZQUVHM3VPajREYXl5SFR6?=
 =?utf-8?Q?P7OE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535cba18-3004-4167-e008-08dbe162803a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:28:57.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DLpIolBBZaJpoHoCPvxEFSkFZbT+4KcMeii5Koqm3DlSY1+GspdiYXxjT2a6wFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> When monitoring is supported, each monitor and control group is allocated
> an RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to
> allocate the CLOSID.
> 
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> Move the RMID allocation and mondata dir creation to a helper, this
> makes a subsequent change easier to read.
> 
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v4:
>  * Fixed typo in commit message, moved some words around.
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 +++++++++++++++++---------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..1eb3a3075093 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3293,6 +3293,30 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  	return ret;
>  }
>  
> +static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	if (!rdt_mon_capable)
> +		return 0;
> +
> +	ret = alloc_rmid();
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Out of RMIDs\n");
> +		return ret;
> +	}
> +	rdtgrp->mon.rmid = ret;
> +
> +	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
> +	if (ret) {
> +		rdt_last_cmd_puts("kernfs subdir error\n");
> +		free_rmid(rdtgrp->mon.rmid);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -3365,20 +3389,10 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	if (rdt_mon_capable) {
> -		ret = alloc_rmid();
> -		if (ret < 0) {
> -			rdt_last_cmd_puts("Out of RMIDs\n");
> -			goto out_destroy;
> -		}
> -		rdtgrp->mon.rmid = ret;
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
> +		goto out_destroy;
>  
> -		ret = mkdir_mondata_all(kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
> -		if (ret) {
> -			rdt_last_cmd_puts("kernfs subdir error\n");
> -			goto out_idfree;
> -		}
> -	}
>  	kernfs_activate(kn);
>  
>  	/*
> @@ -3386,8 +3400,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	 */
>  	return 0;
>  
> -out_idfree:
> -	free_rmid(rdtgrp->mon.rmid);
>  out_destroy:
>  	kernfs_put(rdtgrp->kn);
>  	kernfs_remove(rdtgrp->kn);

-- 
Thanks
Babu Moger
