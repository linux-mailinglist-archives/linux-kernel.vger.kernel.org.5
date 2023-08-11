Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE777962A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjHKRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHKRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:33:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F1A8;
        Fri, 11 Aug 2023 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691775209; x=1723311209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KEOLHaGyvqRD/01pgxnk9OG4JlpCUzQ3lDTg3pfm9EU=;
  b=VZ1EkLRfCcAk9Oz40Y6broXtN7bfbR3ukTMJPH2x4kCU8YUKiThxDozR
   hZ/y2HmQfzoxeD9RtoJ9PXF8hUyu8Vdbfz0jiAsHLCdvX9zub1lE5w1Hn
   TXvLYsy0THBRS6pmvwsRXxCAOcK6CRWMXnwRes3baZIsOLTtKpw3lA2gE
   2/iW4PKXO2xOd4y5qQSAvpFIC54Gz4xgq3q1FVGnCqFpmQfy8XF+W/DOa
   UFjQzA8t0CcDO19ftIbcPwb5ZSzW9JFddubvbWTPE6CzRnTA07kEhdmOy
   LMuaMvvIQ1XhdPrp1yJvQpE6q8OKJuqhSkX0fAJ5Kj1tjM/pvHPwr2vw1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="361867252"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="361867252"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="767737139"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="767737139"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2023 10:33:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:33:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:33:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgL7x8P8b1yrRrJOFwmlnMkK6vQq3f32XpBpHg7o1QiM+zvho6jnRMTxuCF3sjORqyza9pMyCFVFSDiFmQnLynN1EbhATa4E5WF+x4ik5k0mJcCum/DKwP7mIwmksmcRAs/LCbe4BYciE8N41Z7LUVFO4l3Atl5vZIVwb244Y5DSSe7MvyxQkf3CH/Pv+DxI1mVzsg9W3URHcRNYQyLj2MknQGTpCZzdXGleQn9QDkJN1vNbLTMBIbJhZ3CIZ4AASx70qzauA/4ZmuHZl5sB7sx/bUD4+le414X63kFVEf/xqHs01I9yAilt6rolXu3j7wINHWKQ1tHqAB0/LguuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwvUk8IzCSpTO+AlNUtYCk5AgWV5cT/mIppTeqplccE=;
 b=SY0VUZAuWy8da8Uo6vzmzwOk0QyGq6ndM0ixy13aSv+PwdPMbaGvsGYQfw8MXoVH444ptzNgWcdvCttBa5izT/f0jJcM9tIgl/spmViIrgg+ussv9DzzGKFGpA+Qic05zTaqEqxCVvMDpUHTnas+GNFotYP4J+v8CQbi645bDqYdsACsy28xJZlkbmUWk09j9LUp64wQ/WDhZLl6pBQTD+rZbxYgxzGkgXD09T6wHszYbk0kqi9MvRUNZAZ77TPKo2Qs21KC7X/6DXcmK1JRAx5Dq7HHQ4iQA7Z7XWqx5oftDXnWSmr/LS8TXini4x4ZbPjEX8dpnz28CBv3FLpN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:33:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:33:20 +0000
Message-ID: <f6ffd978-7e3b-2dfc-1860-80046f9a7a1e@intel.com>
Date:   Fri, 11 Aug 2023 10:33:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 6/7] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-7-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-7-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 659cc0b0-1339-40fb-877f-08db9a910e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27PeR6b/cN7HkHOeT1Jr2jfMuDTI2FMdLhZLtEG5TOCewXTCuZxpbAA59FmtETgfXuTrnVqPfGjx70FCsUXM3yvAkRe+72N3MS8ULaXBGq8fd+IdFlHcpJ9jpKemSVJBVqbj0dMEAzy2bFAshGqxJbJPz7zO+bgTkvm1h2LiuMnngcTJuq1lYakwI/7Scxu0SHohcuquH5QLXeBH54SXKj/5MOZk+mQfvRqO9YBcJhCDU+WXaYXVLBap6Xvt1JBi3eIkcPfTUPuZjnUOUHmlL8lbD7dbO34Q7ZV7V6lLJM8smBcjn4e5qkg9WkfUrjvZvkdRy6NH5Mlp/5VcyosoCwLTelNRllBd/VfQTQJjjXx8vzPwja67TA2tuhTZzg65XgALxtP+5zw1RmXO/vGTWlOJppDXbRLdgHEuv2OjjBrPDfEQyr+4vwzpWWicmLI76MQWr6XDcZBFkZG/5MVi/VuhrzQd3YEwT4w/BUwjSyLUYZa++6Ig1crxydeSQxMsbTl84Cd1iXaElEfQGqrkBLOtgtXX4QTFCg5GU36sqhw6CRI5sVd3AAxj9cYNUDTnlVnwazGNjIUPwIazLikFuGYPJyTefLlNTXTSFwBzls2xs184aYwy3BTPWfnZQuimJaA9uza8/cgAMPbqNUAc1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799006)(451199021)(186006)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(110136005)(4326008)(8676002)(8936002)(44832011)(6506007)(6486002)(478600001)(6512007)(83380400001)(2616005)(26005)(41300700001)(53546011)(2906002)(7416002)(54906003)(66476007)(316002)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE13eW5ER3NqTm1tVldmdE1MaTVqQ0NxYVpzY21Ca3RrVUFrRWM5NW4xMVN6?=
 =?utf-8?B?NHlFZ2x1YXY3ejdhYjFwdjBUWitVQzFhbmNpeWxkVThYd1RvelVaUEtxdUtT?=
 =?utf-8?B?K2NSU2J2ZVd6RnpLZkQvL3NGeDFJd2djT1l5TWJlQUNXd0Y0UTJCbk1ONUd3?=
 =?utf-8?B?WDREcmtPakxCU3VLWUZhK1c0cE5haWwwSEVlS25iTVJTQ0pvcmw0VkRoWk55?=
 =?utf-8?B?UEN0UFA0MFdWZW53THRWdE51MGJ1eVk2Zm9jREtUVll0Q05UK0JYOU8vZTRR?=
 =?utf-8?B?NEJlYWpOTW12R204bjdTQ3FHNEdMSmhlbERiNHNpYTBRUXNNaUJpR1laaWRi?=
 =?utf-8?B?R2tCWnBOOTJqLzQwRXk2RTh4V2t1YmY5bkdEN2oyZlRvN0xuN3hQQkErSGI4?=
 =?utf-8?B?S1B5SHAzRHJWa3kvWVN6N2V5cXN4Y1d2VW4yVTUyR0NnQjd5M2JoQjlVU0Z3?=
 =?utf-8?B?TzNuSktsQ1pBZGpzV3owdDl1ZTFpQlNyVXFlNDBIMlphMHR1RHE3YTl5M3RM?=
 =?utf-8?B?UE5XNEVaSTFHV21tOXdmd3lmeC9mdnhRemRybDJ4bWJSSy84cFdMWk1yWXln?=
 =?utf-8?B?a3l3QW8yblJ1Mld5b0hsdGs4U3VYSFdWV29Wa3BiS0IwOVJCUk02b0t5djAz?=
 =?utf-8?B?SjA1TGVVSXQwVWFJMFdQUjR4a1l3UmJnUTFkQ08wVFJoNisxZEtkNE40dTRD?=
 =?utf-8?B?YlhqbWxGSWY3d3Jtb0tmOEN4dkQ1VnQ4V3hiemgyTDVCQStRZkpvMk5BZFkv?=
 =?utf-8?B?dUZZS3hoS0hhY2hXbk52eStUamE3bVNNQlozYm02dk1xU2RvT0MxbmQyMmNy?=
 =?utf-8?B?WmRwRzFCNlFyOTB2RGs3M2VBSTdvREFLQnp3NXorcUR2V2xNVWtlQzBzM2k5?=
 =?utf-8?B?eDZSdVZBR25Ed2FzdjlPUE1OTGdpK2FyMXljeCt0aWlLaEVzY0pDTGdwMko3?=
 =?utf-8?B?VlpoRVdmeTJwSU9JQXp2MmZIeGt5YitEeEJlbFVNYzhmNUdrQkdiVWg5NFFj?=
 =?utf-8?B?MVFZSkhobDBxNmY5K3VaTFpIK082UTBvdTlVOGd3YmtISSsvLzRxai9iN3U0?=
 =?utf-8?B?blpLbnF6aVFOVzFkSHpia0xzc0UyUk1JYlJWZ1dBSlE5c0lUUWttVXRPSFlN?=
 =?utf-8?B?UThLblp1emtrbFFLeFd3SkwxOFU2K3RZakZqbWZuQ0h0ZnlXN09DTklhaWdS?=
 =?utf-8?B?YytzMzNGTkFZODlNc0JpbTZnZGsvME5wUWpJUThkSTQ4WUNnVVdCcGIrbktE?=
 =?utf-8?B?MUUycEVZWHg0a2RoL3JDTDBMVkd3UEJSelpwbDFSK0UzWjBucjB3QmViWEs0?=
 =?utf-8?B?OHFaajdWNWJScEhDdHNueHcyRmQ5KzVHVEtEeDNUNnVLZ0hoODhuTnFJY1oy?=
 =?utf-8?B?SVZqOWh4RE9HWFZVNGEyQ21lUHFyKzR6M09IY1lOZEgvaldPMlZWRk5JaVkz?=
 =?utf-8?B?bk5VVWNkdncySVlDc0N0NnJrcEczYmdvWUg2RzQwV2k3UTl0TGowQUdWbzN4?=
 =?utf-8?B?VHR4TTdoczJFVGJRQU9zTHM5T3VMNE9VUzkzaitnK0o1L2ord0Nwdy9JcEVM?=
 =?utf-8?B?VjdZdExBSnZBNk5FYkpwM1djcXNENUtHcy80OVgyUzVqSHBYZ0JIZ1NWZ2Vk?=
 =?utf-8?B?RzA2akxCVFdhcEpTZ0Nob0dTTlhWYk1kWm9nb3RBS3NaTkkxT0VlekNOcVJH?=
 =?utf-8?B?dEdqQ2NLS0gwZE4yWWlSdDM4ZGxNQTZVZHpKZk5pc2ZjUi91bFAybXVBZC9a?=
 =?utf-8?B?M3dwMk5sN2N0M1dkaUFtcWVwc2ZHWFl2L3gxTVVHR2VqSmh1YjJFelViY3Iy?=
 =?utf-8?B?cGhWM2VFS1BlT2wra250SCtadVBCVVByaVhJQWtTSjltcjBGcHNiT1IydUh2?=
 =?utf-8?B?bEd6T2ZxVVcvZm04ZFY5NWtjUVRJYmdzb01IMmF4REkyREY3UFdxWExYcU5z?=
 =?utf-8?B?ZGZLbW1TQkJGUUVCRTBSOW50RFc4Q2NSNjU0eTF6TEd2Z3lQYjdPZENPU2dv?=
 =?utf-8?B?ZDRadUVVV3d5NHZEV2dVTmxuQ3BSNWV4QVhDZzQxdVo4WHpScDBXaldlU3Jv?=
 =?utf-8?B?VjRaRXlhQW9CRUd3UFprQ2V4eWxGdS85VTRkRC9NV3hhNnNSTTlrTW5jcVNK?=
 =?utf-8?B?OVpKTkdkbU1DNGYwa0VVYzZGRmE3ejcvMmtoRkRhcDNZSDIvQWNMVXAyYnNP?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 659cc0b0-1339-40fb-877f-08db9a910e7d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:33:20.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHNH4EZhLOTGTyT92leDb27lCDkBe7YfwwnThPFYMRfU/e4rPZtsiS6MmHrtS13p6W2N0peZVi2cyYlHw2KjfAP9iojhZSm0ZPe81EgP/2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..4d9ddb91751d 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -345,9 +345,13 @@ When control is enabled all CTRL_MON groups will also contain:
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
> +	but the numerical suffix refers to the node id.  Each of these
>  	directories have one file per event (e.g. "llc_occupancy",
>  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>  	files provide a read out of the current value of the event for

I think it would be helpful to add a modified version of the snippet
(from previous patch changelog) regarding well-behaved NUMA apps.
With the above it may be confusing that a single cache allocation has
multiple cache occupancy counters. 

This also changes the meaning of the numbers in the directory names.
The documentation already provides guidance on how to find the cache
ID of a logical CPU (see section "Cache IDs"). I think it will be 
helpful to add a snippet that makes it clear to users how to map
a CPU to its node ID.

Reinette
