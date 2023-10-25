Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A297D66A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbjJYJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJYJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:22:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82278F;
        Wed, 25 Oct 2023 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698225758; x=1729761758;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sDFaWvd5pY5nCEoVEDNiISkIRYApTgx41CkAYh2rWHs=;
  b=Qu9ML9S2pJ/NDJ3MCSmh6CTekRuR7ydfSAJkbEljhzpGycYOzLXuptfC
   dsgy70spv3Hj5mcTkNH1sjsjydZkty9glgLbz18Stk0YcT+9SKLixSfeK
   oy11aUK9VcBMr4p9j3HAf/uoxu4Z1u8G6TDgGHOt0dp6bgQ41tfGSce63
   RkqkTvyewONMG1oPJpRhyze458xdwcYD37gOb9WyAJiP7UP5d8SxzDB1L
   6/Qk4sZp9ECUHR8xODs68PSP+bIeW0sdpVXEhriNLnWe+yTitBZHyOnzL
   5jvzGJaPWHnjQCocgfLuo7CbK0BPR6I7iO040w/n6vPycBhLB6tU3Qj2T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453743492"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="453743492"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090153542"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090153542"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 02:22:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 02:22:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 02:22:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 02:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ5Jhr/oa6cSR/xQOk+G8afOl97nYyhTvvM7PvhvLhWwKv4UflYL0F8LclEFu4FUK/oF3/ioBSy/hivnrLOpJgqty4scCNRaXz+/U7Mn8nFIASY1BSzKtc5lb40rA7QbrrhTY/YQ9Hsl/GJcrAuc61KdIQIhuA98TDEGUMhN3KF/bob0Gb7nMdsFnLYT/4E5Tipqx/zsbSQ//8y3avjdxKOnHjn0GA7DFF6AXGytWKperRyA+8rid1P68XvEINwURC9i50Qz2FU6uOea8wWjNQZ4fjooXpIFPlrMK9Qm32qmKga9g7keGFGJMtpsMNkaYy9koGfTIKOkztl+I4keUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP/vmWGGIBiK/HT6VPpiLCKTkm5q6xD9JlwhSNJTj/U=;
 b=jfOFmgnBfHB6H2SEXtjhH5+LWm/51oHHYYbgpK7aE8ilfm/WdK3UafS1E5mmaxoSKEPsO29da80H6d1YlK/QsfwnZwt7j/f62DfUfBbmYQrMJ1dxSaYoopX6JguzG+Pp1Fq6yibumVlAFGMISjwjUkcFMvbhGRNczLO/AHRU4VNco/g+zVEVeXSYClWJVILIfUtv8tCgz3iI3ngcGhRpIwrDpOcN2uO0hrrLuhG16krSVHP5ty3TPpIaiFAGVwDrvFqYxjgncpDrm1LmCmnwRBHzcL4cRLXIIUQMZ7sccMD/DF/3A8USV4Maoh96ASdDoeXmTKQLmcMJ6lWLhTRNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 09:22:35 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 09:22:34 +0000
Message-ID: <74296600-6d91-4353-a9f6-fdb1ed724a59@intel.com>
Date:   Wed, 25 Oct 2023 11:22:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd/pds_core: core: No need for Null pointer check before
 kfree
Content-Language: en-US
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        <shannon.nelson@amd.com>, <brett.creeley@amd.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231024182051.48513-1-bragathemanick0908@gmail.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231024182051.48513-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 079e7b49-9777-42c4-06bf-08dbd53bec37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lN1rHNBrdRT7R683MhGD6C8MUMGIYIBBqlip+1Cy4SBityleO5hO7MBTQoQaz4YPebbZR6vdB1xj//MjUNbmkpAmyXe2PjlCXvFXMqXVCWenKiDhSXrALBZzCjjpc583Ltnm++Bh5kdIGfDLveIWFxwgiKA1Ikw81vfJB2rl27HfMiA9dd/vSCzZUIofgKq7heoDJAqjUZ+bt5e6Zn6v4hk+usZudU0p3BkYDbFwHRnT38I0StYX9E5DGddDwyg0s4gDLoJxNUG1/s+3fLNKnpwbXPOblGFMOOTuOypmHSW9tunIHQHO3lIwXU3Z1gdFzOx8ytKIqPZr/lrHZibYYwdZohp3wOnxROCNMCtgbwYUGOPgX5DlfupirUOUj8LLfdxdTh/NRA+kPTIZJPVin9iOMIiy96VwRS+cQQ9dIpgd/f5VKC6t7irr1b7z0CYd5Xn7ACR9EmqA2AxRGG8pD6i0VUgyZUWOBxoPhZyVrS+Kzbu+cDYvvwhZY7/Pzi9RtQtmYat1K0k7mf4DnYa/tA8KEVqgEs3pLW/zrJBqRp+Cbtp3W1EvGfPBw7o8be6llzscqPzaQS3/Stu7xIe0cdfuvsh3MVDyQElijzct2AQzFUKLBZNltqG/Ik3cnOacBXHe2wCweYV7oaBg7adA3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(44832011)(5660300002)(66476007)(66946007)(82960400001)(66556008)(478600001)(316002)(6666004)(6506007)(41300700001)(6486002)(6512007)(53546011)(2616005)(83380400001)(86362001)(36756003)(31696002)(4326008)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndWNkxQdEFxWGFvQXZ1Tyt5SndmSXRzOFJ1bjNZdXZ1M2dseUZRZ3hWME9k?=
 =?utf-8?B?bzJxZGQyQ241ZjE0ZW4xa2V1aHlxTHMrdGxpMTFDemlwMUlxNzJreWFSaGlx?=
 =?utf-8?B?RFRzejN4RkFZTS9QVWJPSEpKUW1FVjlzY0tueUVjaldNVkJBeDlDMUMwbmts?=
 =?utf-8?B?SXdaR0pFZUNNaXQrYk9YNEJlWHR6Q0s4OGl2eXd3OCtDY0tSb1MzNWhjMTM5?=
 =?utf-8?B?dVcyQTRlYTgrTVZ6UmQ0ckxIZEtkMzBDSURkVzdiRmZUeXBHTFNtSlJsOVE2?=
 =?utf-8?B?aXowbDZqYXJrWnpxdWtJYzkzQkszbDdSMmpmNjBnbE4va0pFc0c5RGZrazVn?=
 =?utf-8?B?aDBTMXVLS0xRYk1jWVF2UXRzT2YyMnRodUxpY05rQy9rSFVoR0xHcXFRUW5a?=
 =?utf-8?B?RVZHV25BdjB6Y2ttaVVPOHF6MW5kRExOanlHejJ4ejlkWDUvVlB4QVB4WVkz?=
 =?utf-8?B?WDZpb3M2ZzUwT213VDJUSUVpaDJBNlRuMVpXR29NWkhSNTg2Y3FDbHl6bmxm?=
 =?utf-8?B?OEI3UHFndi9xQkE4TDZWbGRVKzhsN1l5UnhERks4WXEzbTEzcE5VUjJmdnpq?=
 =?utf-8?B?T2p0UmgxeTJBSHVjUm9nZHdaWWFiTnh3Z2dGVWRZQk4xRXFoWTlZQ05XT01t?=
 =?utf-8?B?QzJYTU9EWGtYazk0REphanJtY0VjTnBkOThxVlFxR1dreFhzb3owOFVtSDV4?=
 =?utf-8?B?S0ZOeDBvL2JLZitBY2NiVGlhRUNoZi9mQjE2ZWUzZHBSTk5JVEtpUVlaclNh?=
 =?utf-8?B?VjZodTFaSGlsYkZiWGJLeUFRVHBsVlh0K3RYTWJWbnllemowWjJBL1ZaUzAx?=
 =?utf-8?B?VnJOb2JIbTFiRzFpSFZCL1BoQzZtREdyZ1NuVkxFNEQvN3VFcFB0SmNabmFh?=
 =?utf-8?B?RUEvMlQxa2Y4dks1cm5QY2VscGNEamFQR0U4TEUzN2h0WXA5OXRhYUNWNkRN?=
 =?utf-8?B?Y256Yzc0ZW1FLzJRVG5Vc1AzejlJNGt0Sm5saEo4Zmc1aWxCb3JUb1cxdnVy?=
 =?utf-8?B?R1pyQ3VucGF3U0RCSHRqWEI3NWlEaXVkdllOY2RPZnN1NDBnMTNOckI4eW9m?=
 =?utf-8?B?UDNhdDQyOU0vWURSZVdjeXhwcHAyS2dFVmVQbTRxVzhIMkJYMUlEYW1kdnpV?=
 =?utf-8?B?QWNhOFdOelQrd1B1akNpYnBEYjc2aDROVS9DTVNxUmFjRzY1a1hDQUs0QytP?=
 =?utf-8?B?N2QyVDF5b2M0dDVwdjkwcDljL1FvVmRjUDNlUG13WnMxbkRnQ29OUWxLZEI0?=
 =?utf-8?B?VFRPcDgyTStvT2wzWlNMUE52WHlHdlZCN01RdlhTdmNRNkd4Rnpybkw2ZzZ6?=
 =?utf-8?B?TThrWDVMOXJZOW1aQXhaT21mbFVOKy9vYk8xUFlHTG95T1I4aGJDdGFBKzQ0?=
 =?utf-8?B?ZUkwSkhLWWNsUDNEVjF4bnl4SFh5d0x1bjA3UXZSY2tyY1JNZ0tHLzU5aWFT?=
 =?utf-8?B?bEVCQXpxaW41b3Z6Q2hDcUY5Ly9wdGsvd3hqK1hweStHYnJxMzJzMjBuK3Nv?=
 =?utf-8?B?UHk4dWxNUm5PdS9EUGdjSEwzMXVXTzBtWGZLclFPQUVzcnBJdU5JOU5yUTJY?=
 =?utf-8?B?cWIxVGU3UVV3bFRlNjdlSHI1QU5haXA1OE55VTBMR2ltdzAzRlRweGJETkVp?=
 =?utf-8?B?VFBwSlpqaEtJb2VraTl0eFZ3UE1SZVVRT2poVUVmWmYxMFdDbSsyYTQ3dWgv?=
 =?utf-8?B?WllFVVlOUEx5Z210N0MxUnloUi9hY3RhMlNvazBwSG1CcWNYMUhrUHR1TUpo?=
 =?utf-8?B?ajB6a2ZGNkdxMVY1WWdDQUpyaXZYa3JUazBjdWJnSW0zRUVLZ3lwNld6bTEv?=
 =?utf-8?B?b2p2b1BDSFB5aGkrbEtrdkkzbWR1VVJWdkFQNmdSWGp1ZWsrQm1oZ2VvNk1y?=
 =?utf-8?B?YUQwQ29kS2JpeTI4d1ZFb1hDZ1FGa1hnSXVLTWkzSzFmT2taMWhxWDJnNE10?=
 =?utf-8?B?RFppeVNJd25mMm9vVktmSGJNb1lZdmdxWDNMSFlWM1V2RmtqU3ZuSmZuai8v?=
 =?utf-8?B?R0MrQVRFWUFpRzB3V3RRV0NsU2lDdWtjb3NYdzI0Q242b0UycVIwVkwvSzlB?=
 =?utf-8?B?RVpDNUJVQkdYclBickU3d1NNcE1UMStEbzN5NHMrbElLZ1F3dnJtU1RibVF3?=
 =?utf-8?B?WFBOR3NrZmgrakN0UlNoY2tBV0RkbmJTTWVtQXljeWhEWUxudmNsaXBGS1FP?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 079e7b49-9777-42c4-06bf-08dbd53bec37
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:22:34.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u1InmY6qsTysRmVP93T035rklrK54BwMu4WdVXbwiKWb64OaGF2zjLNuhS3TJX3A6M8XVAhYektqK0dqN3FDpjcmetFS1qB0JuuBBtHzFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.10.2023 20:20, Bragatheswaran Manickavel wrote:
> kfree()/vfree() internally perform NULL check on the
> pointer handed to it and take no action if it indeed is
> NULL. Hence there is no need for a pre-check of the memory
> pointer before handing it to kfree()/vfree().
> 
> Issue reported by ifnullfree.cocci Coccinelle semantic
> patch script.
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---

Thanks for the patch!
One nit, you're missing a target tag. It should be [PATCH net-next] since this not a fix IMO.
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/amd/pds_core/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 2a8643e167e1..0d2091e9eb28 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -152,11 +152,8 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>  		dma_free_coherent(dev, qcq->cq_size,
>  				  qcq->cq_base, qcq->cq_base_pa);
>  
> -	if (qcq->cq.info)
> -		vfree(qcq->cq.info);
> -
> -	if (qcq->q.info)
> -		vfree(qcq->q.info);
> +	vfree(qcq->cq.info);
> +	vfree(qcq->q.info);
>  
>  	memset(qcq, 0, sizeof(*qcq));
>  }
