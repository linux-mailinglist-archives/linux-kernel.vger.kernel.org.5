Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB17B871E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbjJDSBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJDSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:01:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8129B8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7BKtwr8J5f1iHmITU5qdBaVaBlsGfHqepp7tzb6oxYavk2TwX69jPDFhhvBqeeCCyIDJOZPY1HDBgfJsm8BHgQgNCnmpJONN0rs4F6N9gg6KWmZMif00Z9B8sAg0OWqfKqz4ffwCsgf9aPUoLhcukoo1Q3f4puabry6ZgM33wz2vZET75Dp11SPrdCiynj2TxZwMJfMSZDdFsClHsTfGGch28S+dfYgMODKRg8ApR0uXaog3osglDPe/QbY5LWt0rEsKNlMNAgqbYKoGD2osKRb38UU3Eb8Fui335NvosU+6navpCa3+VM4MrnMZ8qkIjk16Wy+zRJnD+eEhXY9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MafkfVJ4qBpKRGkPvEeYe/wotmitCJn2Fupbiz9Hy5E=;
 b=J0hHI6/gsLgwV5U5a/0ucu05ZRr8KYGlKBUvMLh+9n4zmCj2HKdtwG8NMmc4Kt0xduyj7w/dZJtIOuZ9Uth+lAsQkRMlckkj8dP/fOuA8WeNmQ/q75NZd6LwB2hYqaiKWjy4c/RcnGOAAb+FQcdByGYbvCC3iXd8+h239WZ2aekQDx//OVrfXht1VCkhMQfmFkKEf/sQVwEuv8Dr99Qmhxs2HBcxoWZMXNlYkwrPRO3OY9B/DgSDdw5xPaHkinWtyic2aeFCND+Tc1W3TBnNKf+H8AJYvQks+e7EvXP1kzfJvKxSJ9bZB0kf3CAT571Omvm4itrZytJboakTdpu4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MafkfVJ4qBpKRGkPvEeYe/wotmitCJn2Fupbiz9Hy5E=;
 b=I4c9PwoXlWMyjNKl4LsgUx+No1u7jCYVpr042k9uvQGFR7nFVZ0Myh0NhLhd2N/Qddxn0k9H1SrEZcOgdnWk1u3Ccmdk3PBD+zCU8y4xYGNcOS01U+RehQ66CW8WgZYoy+9aE6WvpF2AF/6FwF4AjjIxgs5ktpLlsbTLOiOKDe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 18:01:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:01:10 +0000
Message-ID: <64a2b373-2859-4412-8858-9a99d7e646f5@amd.com>
Date:   Wed, 4 Oct 2023 13:01:08 -0500
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 04/24] x86/resctrl: Move rmid allocation out of
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-5-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20230914172138.11977-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f0fe62-5901-4a35-bdb2-08dbc503e400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byoAVs0bsa7aU0WZKwqw4GC6T4XuSLEboGnIN7gsXbEbMsi+42Y2TPTBvXas1uM53aE1VUeOvquxvsBBDPZUOknJG2hhHX0HrOkE4fzwk0fEbpFd55IMF4x4kHsyrzCp87HLLxvrmiDEqb98VSNymHoltzqTNvp7KKodTEINGz8+SOcwaLwjjT4qWGmKW48iRXmneNgp5VUiAwQ4DJtZ/8IgT8Kly5GwcKIivpgLgaQyV3omFxVmtSKq77ZBNC1v3vLgwvLymmZxzhDbIzSv7RG8hnDPRfIZ0PRPv0B6aZa53OfoOcLanp4XGFB0eQr1N4QkJU/qZwhWWvqOFrr7x+emMKGRUHvWafSI0ohZariYJWXI7n7DibKfdAqgoP4mEtGf/3/y7/s6B5em5+g8dFRMUuIE//dslCxBKEvpoKAtcBJtv6JHucgsCfnTMzDLsxBKC8dhnhkkajplM6FnVRnejzEWy28IGD06Z3JldtVCpQgZH2XwhsjN7sm2waipTTbMPlPS5iCQ62byTQuwxQ6wtx923rol7Avh20Oz9LmJ4YbfhGhWtgZE6UnC2HlJTAxNq/SN/FOao4RjHQnKH93gjwFpcje4oNLFlE5S9/htpE4rQBICSZVh4SG9TAn4xJysI6MZd7SzB89xlMcEsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6486002)(6506007)(6512007)(53546011)(7416002)(83380400001)(26005)(2616005)(2906002)(3450700001)(316002)(54906003)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(41300700001)(5660300002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtWSHVJbUtJSXpyRHlnRkN1QVhSS3RndnhuaHhxS1VsR3FtWFNEeCs2R3R0?=
 =?utf-8?B?Qzd2M1dPTmc4YXlwN1dxMS94RkFYUUx0S1l3V1hsLytPa0pmNU5XSUNXM0xC?=
 =?utf-8?B?aGF6SVFxdncrS1BFOGovRW1seE01ZWNSdmozbWw0RnVpNzRweS81aWlWa0k2?=
 =?utf-8?B?cUJ1M3QvUHdmaGpqZ29FRkxjZUlrV0tsd1hJZVZsMXRYUVIyRjd0akI2VkpX?=
 =?utf-8?B?dnVmU3NzZjQ3Zi9xS28rZWdIaUxmSUlqSWQ2Nnpac3dydVJSQkNWenpxdzdz?=
 =?utf-8?B?TE5STWwvRWpsWHZwcXFaRmcwYWVKYzdzTFNvalNqSm1OM3lUVlE4WDRLY1ZQ?=
 =?utf-8?B?alVrY3J4eG16cmthci80a05KUmF6RU9qNStwc2UzYmVWUnMwaEJDZnNGa21t?=
 =?utf-8?B?ZWZKeVFBdkQwKy9iSVJtVFhrRVQ4dkh0ZzNlS2FLS00xbnRLQjQ4ZGFmR05C?=
 =?utf-8?B?QlpNVDNLeVZEZ0FIT2FXT05sY1lEclpaby83cmZOVXloTFZ3cFlhM1ZtYVV0?=
 =?utf-8?B?WVpYODZ5OE9Idk9LSE5wZUJhTnozc0lXQ24ralNFUUF6aTRvUklnc1kvdllM?=
 =?utf-8?B?OUh0eG8za0FFSCtEOTlzd1FvV0Ivb1FWWEdtbnNNYmVjVW1ra1ErSEdRV3hX?=
 =?utf-8?B?eTdmSFBiMUp3NnhrSGVDS1FidXJXRzIrcFp2ajhtRFNMekg0NjJMOEV5UDIr?=
 =?utf-8?B?WHpmTnNIajJSN1d3U2dvQ2owSVlydTFwQnBpcEtJZERoU2gyNzl3K3RjOXZa?=
 =?utf-8?B?Y1FYWEd5ZU92a3lmSU5uZWh3LzVVSFZ5QTFPbzYwb0FsV3krY1BST3pkUzJh?=
 =?utf-8?B?SmdKVjdyOXdxMHErMUdDSjM0WUpPY3IvT1RxSi9kRjZraHJTcXpjcVVVeVhU?=
 =?utf-8?B?Szd4OUdhUm91UmFWaVNWbDZvNWlPMjdMTCtreFBVc3M5TzVGeTdrUWlrQjk2?=
 =?utf-8?B?eVB1bHVVbWhDZEpTM3JWNUgwZEtNdlNpZThjdXM4WHNzK0ltNkVxRlRQRk0w?=
 =?utf-8?B?TWU0bzZXRHk2bHBqSjYvNlQ4dW1lNTVaMEQ4Mi9ra0sxMHdyQy9WbDBYNm9J?=
 =?utf-8?B?U08vYk0vSUN5MG1MQlN1RFcvTnVNWjM4eFZmajBCNTBlOHpmY0poV2x0cWky?=
 =?utf-8?B?NGNUUkNDSzhyTGV1WmNRR0RoUGdoZjJxa29GYmhvVGtSL2FFZDRIcGp3RkJS?=
 =?utf-8?B?RmpBVjhkOGY3K05FUDEvZWZHR08wd3U2TUY1QllEQlNEaGFmR0RNdFBTcUho?=
 =?utf-8?B?akV5dnFqR3VIL3JDUUFwMHNlaTRoQWFhQVhIVXMwNUdNT2IzSDZ5TmUzeXlr?=
 =?utf-8?B?V0xYNkdDRFlRSlpWaUN4VURiM2FCOFdObThJUFBOcDNsS3o0RVRBeDY0V3E3?=
 =?utf-8?B?YkhGUUt6dXh3R0p1WENnUWJ4VWFFZ2E2UUloQ1F2S1FiWmlvdml3NGxGZXUv?=
 =?utf-8?B?Q25hcDFCYkVKemNSSEJjWnJkSUthY3o5c0JQM1pPQnJSZXFoM0tJYUtsUElI?=
 =?utf-8?B?U2QxRlNUaGZiMndvY3d0bUdEckN3c1I5akhRZkdCWXpjVU96Ri9nRllrdVJI?=
 =?utf-8?B?dGgraGZSa2plTnBCaVJaVG9VOTNaZmlGUGdlK1RpWFVxa2xPR3FDOW1YWUtq?=
 =?utf-8?B?U0gzZUZUbnlPRjE0Q2VYNE5sd0lvMFYxc2FXUHgxN2UrMlpJUkJmVHpONEVQ?=
 =?utf-8?B?K24wUW5tR0Q2T2kyRlFSZU5kdlVrYUU0YjUvbkF2MWhMU1piRFhQNHpBUEFE?=
 =?utf-8?B?ZGtXejRpMDVJZkpnRnRrckRuaTAyc2lkYlhmK2ZCb1VWamtIbUhVWFlHNi9R?=
 =?utf-8?B?OStxcURsSVNFQVpGNWZwQ0FwcXp6bmVLV3F2OHFVT21rVlNNWWt1aHA2UzJh?=
 =?utf-8?B?eldubHVqM2pxQVJ1UzllNWtWZUxSYVdaSUl5azVtakNVdmltN09XY2NsMVQz?=
 =?utf-8?B?WW5jMFZwS3ZNQ0RPN0h3c21OaDdzRDBOUk9sL0dnbnJQaThjclN6eXZ1Q0RD?=
 =?utf-8?B?dU96RVUwQkFHa084Wld1Q0NKa3JrNnhybUVrUUJ3RjFFRWtWVWE5RzJhS2ph?=
 =?utf-8?B?ODdQbEFxbHgxaGR0cC9hM283YXUyNmMwcXFwZ281TGUvbWZaV3R3Rk1aZW0z?=
 =?utf-8?Q?ShWI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f0fe62-5901-4a35-bdb2-08dbc503e400
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:01:10.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6f/AhmpqRUY4tsfpekuPQHwFvyoMnf8WTDH3HXtwslNnEyzMsFHq66h+Tg7Wy03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/23 12:21, James Morse wrote:
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
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Moved kernfs_activate() later to preserve atomicity of files being visible
> 
> Changes since v5:
>  * Renamed out_id_free as out_closid_free.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 +++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7a7369a323b5..d25cb8c9a20e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3189,6 +3189,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> +{
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->mon.rmid);
> +}
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -3254,12 +3260,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_destroy;
> -
> -	kernfs_activate(kn);

You should not remove "kernfs_activate(kn); from here (only the last line).

kernfs_create_dir is called in this function.

/* kernfs creates the directory for rdtgrp */
 kn = kernfs_create_dir(parent_kn, name, mode, rdtgrp);


There should be matching kernfs_activate.

> -
>  	/*
>  	 * The caller unlocks the parent_kn upon success.
>  	 */
> @@ -3278,7 +3278,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>  {
>  	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->mon.rmid);
>  	rdtgroup_remove(rgrp);
>  }
>  
> @@ -3300,12 +3299,21 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>  	prgrp = rdtgrp->mon.parent;
>  	rdtgrp->closid = prgrp->closid;
>  
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret) {
> +		mkdir_rdt_prepare_clean(rdtgrp);
> +		goto out_unlock;
> +	}
> +
> +	kernfs_activate(rdtgrp->kn);

I dont see the need for this. There is kernfs_activate  inside
mkdir_rdt_prepare_rmid_alloc (mkdir_rdt_prepare_rmid_alloc
->mkdir_mondata_all)  for all the files created.
Also mkdir_rdt_prepare already has kernfs_activate for the files it created.


> +
>  	/*
>  	 * Add the rdtgrp to the list of rdtgrps the parent
>  	 * ctrl_mon group has to track.
>  	 */
>  	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
>  
> +out_unlock:
>  	rdtgroup_kn_unlock(parent_kn);
>  	return ret;
>  }
> @@ -3336,9 +3344,16 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  	ret = 0;
>  
>  	rdtgrp->closid = closid;
> +
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
> +		goto out_closid_free;
> +
> +	kernfs_activate(rdtgrp->kn);
> +

Same as above.

>  	ret = rdtgroup_init_alloc(rdtgrp);
>  	if (ret < 0)
> -		goto out_id_free;
> +		goto out_rmid_free;
>  
>  	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>  
> @@ -3358,7 +3373,9 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  
>  out_del_list:
>  	list_del(&rdtgrp->rdtgroup_list);
> -out_id_free:
> +out_rmid_free:
> +	mkdir_rdt_prepare_rmid_free(rdtgrp);
> +out_closid_free:
>  	closid_free(closid);
>  out_common_fail:
>  	mkdir_rdt_prepare_clean(rdtgrp);

-- 
Thanks
Babu Moger
