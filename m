Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832E677C4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjHOAyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHOAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:54:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3A199F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692060837; x=1723596837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wa2oHfXRftcxHxBOjFnVzXBzDhYJ+wdOZipXcfrdD/o=;
  b=cI43zzgXXlZH5pE9VCXsRVZ8k0suUhNAYgeC2dOEUDcTsM1o8vcpGIIJ
   BCUZ5fEVFv49NR8/TOZFwcpIksMTpYycLIpDVzJ/urAj0rIU3CcaQ7YhU
   LJXKN82p1YqNmBIvNg7uEIFqwL0hzniLk85VKEjkOdl35KSV6DZ7FiWEe
   6EdtZ40V9nlP7JM/r7eBeHrxoCV7KCO7AlA2jFjXf6oHH/V7MMv9I3dRr
   7/GSA2Q/0fvm6gYIN7GD49AhL+tbhYaAxiUl8cir344aFZOvqLPJPpAs6
   VwXa8W899SNS5FOFeQrf9lemdodTAFhqNyHHF5bko8kPSsNd55VMhJU3n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357136057"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357136057"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="799015215"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="799015215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 17:50:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 17:50:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 17:50:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 17:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/xWLlKi5WYzXRfiFDs7t+018W9RSkT72t9+Z6ZrDgcNG4DcYWXJzWxPGXu5b6/B7642N28tWqNtnFkem4f9FTWI7OgIYD3aJbPWYgYw1hhSt57qv5oaR1tIgxxczYV7XDV80hJO8aI1HTvc3iLT7V1GQep+oFoTDtN5tRwiBrF0E5u7DFg48A3Gtc91zE3vZ5REKIEp9yTMPbwU+fYxwrNam1zDaI2uzgol79UQ6SNfDKageZy/1dQHB2h1cwVUGrv0XMNcRsMUkzDxtfxTZynfITeY1J45BjBqFgTxUFbme7pFepo1NymjAjcT2PNdK8TYI4kgVERAnVndC4W6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbq49rIGvfwPuvtosom5AvkGYRMXbgUL7e6CW6gkTV4=;
 b=bqlFpl7QiIDc6828lBgBI3i1T4b/Mtj2hmJgYQGpaGhsHVU+R43sdchQC8MTjMlBQNEUvVdBt79+a9GF2KeGy1dkgVyrWSiYu2i+C79RIUJE+VJSgsrIm9cQwPNegNqh1xOPcTfj+dGLIHrW/7/shXVITjFT9uRKan5Lhqu4F4J9SU9Z1OUlKw1ld7/KtbzERbXBOIrYEFby40wdjvFgTNZKN4VHB2eoUovLCdnJAUjMmw3dXvXu7KfsYBVuSzHio6RLZgA1yRSDwaNwtcRD5GkE1cyLOVL+asDUuC4Vv+wSI2qcQi76w7U45vrydvfCXANguSQ1v9buieaPSG9Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 00:50:34 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 00:50:33 +0000
Message-ID: <beb61f8e-636f-a0cd-73b4-6294f90092eb@intel.com>
Date:   Mon, 14 Aug 2023 17:50:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-5-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: ba374c26-2096-46d3-c8e2-08db9d29a11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0Z0FFFst6LZ4kqDaMWmz/RsIzZi3oEqH3AbmDFDYjAmb3yoVnkZ4tJUaKqyC4rF/pTzYUSNxdyX1ISB7QCW02yN4G7bqXBLowdFBD/HvjAhq7GqioOotcSVCjAsRC3CoGOxd/W9Twz0tteJRQhhGklv690JJW4JFu4+WU44EVsmRbAUiSsl6+ust0tpWg0Dx59MEZ2Mwm0BlqtsARSjG2Dtj2nVz93TLDSyh0Gwjqow/dugHl9n4Z4FCrQcj8mML2SjXBGRyoklf72S93s4SEKr6n9a9+Lf6UmDop5t7PogmjbOzcI6MEYk5lKeCVb0P+jbhQ18JodnKHhpnykGVLpoD2z5C+9kFtrEIcDchS0RHU8X46X44cB4oG7n+uIXyVxyjZ9Vb50OICJcFjTJi9qC1O9QjzzkYF8IFQPX6JUaoKDfkk64hHbvPHwYlj7yMwp2ddPhyFLO0tTd6n1LgKvARUQBCZJE27hlEzrGRQWPEEjKrJLfzwOWB+oztUH7Kjfvntb8LpQQdq1TCWniIuXE75xP+lBpUpNTFGs58mVC2bQluk4QQuCkFE8vLCEFcgOYJGy+L2gQrHFd+L7rIebpVRC2OuFYUhJ37A8xvQT4t5UyEg1cLFTUyLnxfE+pF9ia/3fZ9WJBFSb/vq1Q9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799006)(186006)(451199021)(82960400001)(478600001)(8676002)(6666004)(8936002)(4326008)(41300700001)(316002)(54906003)(38100700002)(66476007)(66946007)(66556008)(83380400001)(6506007)(6486002)(53546011)(2616005)(26005)(6512007)(86362001)(2906002)(31696002)(44832011)(7416002)(5660300002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJlSlVVTkZmcEVyVjY3SXdybm5LRnkrYUcwK2VXSzdsVnRtQ2J0RnZkYUQ2?=
 =?utf-8?B?cEhJcS9HWlVnWWdnd0NlenkvVWhzaE9aNmdNN3ZsT2VWbmtZem10UTJFSWtL?=
 =?utf-8?B?dWhJR29abnFDWnRmSmJlTnlMb2M1QitDRG41TDAxNDJjZm5ZS2pScEtTbnhj?=
 =?utf-8?B?clBrYzBuTGNCNGM2Vy9lcmNaRWlSNHFHTlBJMWgxUk15Y0hXV0w2TGx1NWtG?=
 =?utf-8?B?VThHLyt6cFpJME84L2hRZ2NuN1c3OGdnQldzNzZSdUltWkxMRXVGVUxlUlhw?=
 =?utf-8?B?d3pOYTFPOTV1aTBLUVhxYXVGZnBzbWduNFFGZ0lzdUM1M2FSM0QwQlpxV1F6?=
 =?utf-8?B?ZWg0MVp2OUkyNTNxWkUrZVJwNlNkVSt4bnpreGNLL0hFN0VrZTZsWWwxeWdC?=
 =?utf-8?B?UTNFZHI5djlQcFFRckRyUmE4MlJqN3JLYXJsUWxhdlUxampmQ1Vmem9oSE04?=
 =?utf-8?B?WDY2RzZGZGd3aHU3aFhiUXlEV1VnNVBJNmk0WjhUSk1LMHpkTlBXU08xcUw4?=
 =?utf-8?B?VzJUR0ZkN3NTOTZucmVJbzhLT0JpR0RKM1d3WE9aWGRHRERFeXl3SjVXRVlP?=
 =?utf-8?B?QmVVVUcrVHBnc09lNHhxd0VzNGtFci9XR2VOZmR3UFQ2MGlRN2NwQmtMeGJy?=
 =?utf-8?B?NUpNa0ZaeWxCUHRmd3dLKzFWc3Z4cXdMZStsY1Exd1o2Yk9LVXAvYmRmcWpt?=
 =?utf-8?B?OXdUQlplbU5RV3dVYmhPZjlwREpVYXZUcVFVby9QdVorYlJFNFVjUTBQZFp1?=
 =?utf-8?B?ODE1UG9Pa3V2cm1jTmNKQk81V3hiMzBsb3prVWZYNHY5YjY3SVNBbXFESmc5?=
 =?utf-8?B?OEMyRVRSVEhHZXM1ZXVmSmVITGFSYzJUN05Bcm8vQUpRNDE3Wk93aTdDeVY3?=
 =?utf-8?B?czA4TW9sYXVXUis0eVpDMWVNOEh2RkFNdmc3Tk5UN1NpSzFMampueHdzbkpy?=
 =?utf-8?B?aXRCOVh6ZVR1ekZ5NFZjeVN6VG5Pc04rcC9EVHBCWWpvb0xhV1RrSTY0K2Vu?=
 =?utf-8?B?ays2MVlwVU52OHZEUTVRY3h1SHlEaWdEZ2p6MDMwbUMrYTBNVndoSEZRdGN3?=
 =?utf-8?B?cjhqMFljVDdLRDZadXd1cGNiYnllcDgxWEFORlhTREViendCZzFUYTJtbG5q?=
 =?utf-8?B?SXRaVGZ0V2hyRlBzZ1pwTm1CaWkwVW9VNFdMeGhYaWN0Vzd3eDBJelpKMDNT?=
 =?utf-8?B?Vjc3ZjlOWjJlNnRzMTF3OFE5LzRYN1Iyc2NTa2ZRQVlaS3I2VDZHcERXMVVm?=
 =?utf-8?B?dlBOK0ltNm9PNXN1N0pTaUxQdVFHSTNXZnVWNWdZcE03TmQwa3FDcVNHcHcv?=
 =?utf-8?B?SUVQN3pWMi80cW91UUEyK1R0aTgzMzhZZkNqWnVMNFIzb1d2LzMrKzBLcHBD?=
 =?utf-8?B?YloyeFVNK3Vqc242TlJYWTFBamdKdUh1ZndPa1ViRWtSL2c4c2tadTgwR1M3?=
 =?utf-8?B?cW5yYTVjWHFJckgyRktvck8xTzFSZGpwaFlsTFRSQ1NUVk1LM1RVc0UwMTV1?=
 =?utf-8?B?d09DSkFyRlNYclovMUVGS016MGxHditRbXhGaFpITXhWcHBVS1pOM29pMEhh?=
 =?utf-8?B?UU12VlZmUUhGajNnUEJER29VOWUxdk95Y2ZoZmFBcTllN3FiVjV2ZkllTTdW?=
 =?utf-8?B?Q0xVRU1VVlFZU00xOUJmTnkzdnh5QmU0OFVoamREQVo5VFh3ZFBWODloMmtI?=
 =?utf-8?B?cW9sYm1JVzFqSkg3WG5vVWhTMUFhckpNdjV4emZKelZoSWcrNThUWTRCcDdH?=
 =?utf-8?B?RzJiTXVEVkxvcUdDZTY1YVBsQkpuRGJ0QU16d2tXV29PZ0ZZWDVPNFhPKzd1?=
 =?utf-8?B?dCsyK3hWZmRzbWo4eXdwZjU5T1RaZU83czVNY2VaQjhxN3hEek9ac2lnbjVF?=
 =?utf-8?B?a1JJcDgybDhrbW4vT0NOdTBqd1k2VTh4UE1TVWRvOXVZTVc2WlVHZUhQTXpq?=
 =?utf-8?B?N2RRRHUyQmtVa0xlYTZ6RnJUb0FWUFNVZDUwYU1UN0lLc1lxaEpaRFFkZTMv?=
 =?utf-8?B?bU44RnBobDBzem1MWHZKaEM5VkM3YkRObmpDMTBvZGlocHBBQUJaMkFWYkhw?=
 =?utf-8?B?RVRDby9CNS8zL0ZzdFFidmhWV2d5RGRUOGRCaVFIa0tVKytTSWFScXNYUFA1?=
 =?utf-8?Q?N5sCJTxSYK490n4y+HZjpmkZf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba374c26-2096-46d3-c8e2-08db9d29a11e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 00:50:32.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phqb8BBhtEs1GzDIwdQ0y/FEhonesCFnUpXTs70PoTuI+LecOOhCtKiEt+BvJxqqWz3589c9OBNfYqz9xF8fHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
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
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>   * Moved kernfs_activate() later to preserve atomicity of files being visible
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 +++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e7178bbbd30f..7c5cfb373d03 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3189,6 +3189,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>   	return 0;
>   }
>   
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> +{
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->closid, rgrp->mon.rmid);
> +}
> +
>   static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   			     const char *name, umode_t mode,
>   			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -3254,12 +3260,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   		goto out_destroy;
>   	}
>   
> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_destroy;
> -
> -	kernfs_activate(kn);
> -
>   	/*
>   	 * The caller unlocks the parent_kn upon success.
>   	 */
> @@ -3278,7 +3278,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>   {
>   	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->closid, rgrp->mon.rmid);
>   	rdtgroup_remove(rgrp);
>   }
>   
> @@ -3300,12 +3299,21 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>   	prgrp = rdtgrp->mon.parent;
>   	rdtgrp->closid = prgrp->closid;
>   
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret) {
> +		mkdir_rdt_prepare_clean(rdtgrp);
> +		goto out_unlock;
> +	}
> +
> +	kernfs_activate(rdtgrp->kn);
> +
>   	/*
>   	 * Add the rdtgrp to the list of rdtgrps the parent
>   	 * ctrl_mon group has to track.
>   	 */
>   	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
>   
> +out_unlock:
>   	rdtgroup_kn_unlock(parent_kn);
>   	return ret;
>   }
> @@ -3336,10 +3344,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   	ret = 0;
>   
>   	rdtgrp->closid = closid;
> -	ret = rdtgroup_init_alloc(rdtgrp);
> -	if (ret < 0)
> +
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
>   		goto out_id_free;

Is it better to change "out_id_free" to "out_closid_free"?
It's not confused to name it "out_id_free" because only closid is freed.
But this patch introduces new "rmid" free. So it's better to rename the 
label to "out_closid_free" and it matches the following "out_rmid_free" 
as well.

>   
> +	kernfs_activate(rdtgrp->kn);
> +
> +	ret = rdtgroup_init_alloc(rdtgrp);
> +	if (ret < 0)
> +		goto out_rmid_free;
> +
>   	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>   
>   	if (rdt_mon_capable) {
> @@ -3358,6 +3373,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   
>   out_del_list:
>   	list_del(&rdtgrp->rdtgroup_list);
> +out_rmid_free:
> +	mkdir_rdt_prepare_rmid_free(rdtgrp);
>   out_id_free:

s/out_id_free/out_closid_free/?

>   	closid_free(closid);
>   out_common_fail:

Thanks.

-Fenghua
