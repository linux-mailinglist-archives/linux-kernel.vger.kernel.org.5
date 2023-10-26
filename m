Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04757D8005
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJZJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:51:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCE192;
        Thu, 26 Oct 2023 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698313911; x=1729849911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cMJWTQxgCm1mvu+sTyQHJRFOEQ5zKewRiIAJiAWxwM8=;
  b=h8ZHAvrIaULZAUAye2I7BhKXovSZc889ESXYAN3fn+rODACB8ekg9haL
   ysNtJRwkD3s9Eb+T5NBUcUpB6k8btCgJiyE5OeM1fw6MKpY+Yr5IJNSlB
   E/5Ww9v7yatqf4qrZHi09MjFHXdydSONxnZ4MmdY/BpN3S+tNMeVytIeI
   Gxy+YgA5VEubWigZBM/suSy1gn/cJlshDpIc7zg/Mq47wlO0xJ0Ejsszw
   AU8SnFf/ehllOJ5LXwGLp3OQk5RxP9WTdEiLoCHPibXWiAHVa6ILgiuql
   o86de8oAU5okJbCGeY0ueLCRrS5rotcAaRmhJyYC5VvCKqKOWuRRDf586
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377869058"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="377869058"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="824938905"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="824938905"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:51:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:51:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:51:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:51:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIq9ij+BlUIfSFcMa9S+ZD8874ypp449mrtsTs+WdF34AvHxqy+rIk4TaNkv3wvE3gDNpGvNIeIcZ7JpbfCvGD7Sxj/vKKfkqMayUmbKl3f2g144kHDYnISzGgqB7xFkuBI4f2btjRD/gKgYvEVYrFfOeN4UNSi904GTywy9dCpc72zC4x5ozN5wF8G64i+XlDTAauzqGZIyzgzaOfbUd5fBJvIK7xiCJGptkafW8ZLr+cU734lZ9fti3nJk645g3pr4xB408WmmwhC1asg8sNFvLfckcBUOP22AAGl24708qDVUWooKaGFvmlTdjQAq6WsLJsCg5rko7YXAZ+aM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uNHN96aHAjWFhYImAwQUO7J9ecAFBh3pKms3AShB/U=;
 b=GvraPBa2rcDjDNiMN93xk+TY4ruME/81yT8iqBhv8AnEa7EQk2aIP6OyIUoeZNqN9YH5ZI8ZZ0gCJ7ebnC7aQvueCG49AMQL+xiznrFBrzALc7sRijgwuc2rTIEeVMv7OwMnVdAxY9T57ryHyCSNcI2BaK31G9JdDfiUNwa15n7c4Fvcw544EO2JJPOYvfAzFZVc0/4XFqKXEGYw5f+cTWW6HJGOPPUxADYNNbFGsSPgdZBxKbSThEmndLm8+6QuOeZxhjlz08vfpX96VQofdjidA495PBK+3nWgYDcvZNp3R/IpZ5H0+aKgxX8Sm8G9Xoc8cyfic1nkJRoBFdifBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CYYPR11MB8307.namprd11.prod.outlook.com (2603:10b6:930:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:51:39 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:51:39 +0000
Message-ID: <5ef0961b-fd69-4fc5-8212-d5f502e42a50@intel.com>
Date:   Thu, 26 Oct 2023 11:51:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Remove AQ register definitions for VF
 types
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231026083822.2622930-1-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026083822.2622930-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CYYPR11MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e8d5d6-7b16-4c1a-32b9-08dbd6092661
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuTcczS1esOpxhHepeq3HUHWNsVZ94wq4JiT4/Htqm9CVHF3eQob0Vqi5ogITx5sBcZuVvZRBwcnUw50P2B1kmvirrKK2sF8WYT2OGNXPTcDZ+7HgTz36YWPENPThzb9LeQmh0FoFPwc6D89b0x5XXmjo9dJfmncIaaU3YgsyjYx6fIVDRcACXtCxncpB3KYn9TrYA6XWlzrAwm9kZE8D7td0J/L6QLsd3FzcfBNYBUpmeMjG4HWOTuPPKoxRvdggXhi1/2XOxO9A6SErpu2mRewBvUmp+2o3nqrAE71hM1CCnmj7pNgUVq0tZGk7yGfPJwD16uIoChx3+4L1LSb5+mvjdEkfq33JrcurfNUlpAOZPBu2LuEMC1ww0/voyWxl0vDKRstC2jVqCJB98ClkTE3LpNPlJ5Mj04Iv5/LlIwHyDH9YJIN25Csg10EwpdJDgBRwu2A8NXt+a44Gw3/DaWovwGDEkU9EVKQZuNwL5Tj1YHe7jX1rznTPLMO5oofKzPfCAf2ch7V8+yLil4ElEx9Njx1b3B0lUuqMWJFYzzcLEqC+DTn2qRaR4LBy6faILjDYVNJn93vCsEp5/kgIMHmlpLzRZThzKQRGwVLtE7LaDVBqv93SfL2Rpdmkccmk12O4WVO0/0ab7EP/t6fBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(5660300002)(2906002)(44832011)(41300700001)(66946007)(316002)(4326008)(8676002)(8936002)(66476007)(66556008)(54906003)(53546011)(478600001)(6486002)(31686004)(6506007)(6666004)(107886003)(2616005)(26005)(6512007)(83380400001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVwa2d1a0NINTNHYXFqeVpYTUhkbkxKK2pPWTBld1Ztdmg5L1pjekE0ZVZD?=
 =?utf-8?B?QzNLaUdPLzY1NWlDK0xlNUp2TitOZmlwT04rRkNwK3QxNDF5WGhRbjRaOGJG?=
 =?utf-8?B?MnZPYlV5T3F6Y29ta05uOUNGTFZ5ZmhIZXhkRDFaZTMvWkx4eXQzdi95ZGxN?=
 =?utf-8?B?TUxBWlBkUUJsY08yTUFscEovZzAvbldOaTVmS0pvQWZYT3pJemdOYWFlK3k2?=
 =?utf-8?B?RE5EQ3pWSTY1amgvN2p3NVhQVFg4WjJ4cmtiY0taNU9FaTYxWi9OVy9SRlZB?=
 =?utf-8?B?YnVqeDJGb2dPU25NQUUvRUFSZkQzT05pSjQvSmhDUW1Hb1IzS2dwMktvK05y?=
 =?utf-8?B?RkpoSHZWMCtKMWV4TnRYMXFsRjgrQlJPa3dONStLRmlRbFlqN2phVFlLTHZ3?=
 =?utf-8?B?WHp6eklrcktJTGpmT1hkV0ptekRFZG9JbmxRbWhYUUJsME1mc0lsdlBpQXM2?=
 =?utf-8?B?VksxN0g0MTQxVDNmeklDaWhMdXYzVGl3YkJndmZvWHArby9tMUJvNVI2NkxG?=
 =?utf-8?B?Mm9NNEFnelhYeVd1SXpJb2tLNnpSVGsvR0pBbElUWDRxM01JQ0dCeStwWkZj?=
 =?utf-8?B?N1dBOHAzVXZXNnJLd3FIS0JqNXg3RUV1SHlJc3JUcVVsMTYyNlgyUy90cTVw?=
 =?utf-8?B?b3RVQ1ZrYm1qcnlxdERROThoeWJJNHRWN1dxOVpMWDFINVZJRXBHaWgyajdE?=
 =?utf-8?B?cXFSN3BWbE1YTk5WV2tCdjcvTjRsRjNXMldVVGpSbXg5Rk5vUGxRc3NXZ3l4?=
 =?utf-8?B?YmJCaDZPZXVqZFZFLzhBQ1NLZEF1dzdlRVF2Z2FyQWxwSHhUS1pzRUx4S0Zx?=
 =?utf-8?B?QTEzQzU5K2EzVzJQQVI1ZkMyOXc4WDczNEMxMXM0RmFoNkJPaGhVT3Mrc2NW?=
 =?utf-8?B?RUcxNDRPclU4Qys3YU5JZmEwT2trejBvbkRRcy9EeUF1Mzl1RER3Z0QzcXRt?=
 =?utf-8?B?aElja3BTZ3padnpYZlgzNXhxTXBCMVZNMEVJSjZuT2JBK0NtYm53cDNuSEEr?=
 =?utf-8?B?QWZ1NlE5VUkvNStMSTdQMGRLSDBPR0d2VHZmUmF6Ky9zUWxWdk54a1lUV1Rx?=
 =?utf-8?B?QU42Nm9TUXZNYUkyZytMczJKTDl6U1NNMnoyRHlLM0RlQ0N4ZlNwU0FSNDB5?=
 =?utf-8?B?aS9uZnMyYmlRL3ljcnFoL1NvRGIxQkFyNCtEaHZFQ3M3d0xNbTgrSDYyYUsr?=
 =?utf-8?B?ZG4xRmFCaWp1c1dQMXk0bE1ZN2tXL2hiajZxb3NVTGlGSDltSzdMc29uTkVF?=
 =?utf-8?B?RlAyRURLZ3czVUZQaUk4dDhhN1NTWGFxZjNpMWdZK2RLVEg3WVNERGVCZ3pz?=
 =?utf-8?B?ejQ4UlRSZWFabVRuREJ5czljK2lINTlhVTJUUXVrUlN4RGxOTlpreFdlUlFS?=
 =?utf-8?B?VXdPNGR2NWljN0JNWElTeHVENzQ1M2llaUx5RUgxRmRMWGplMW5RdHdqSnZi?=
 =?utf-8?B?dHVtWTRKR0NIOVQwa3J0NnpVeFliamIwdDZYQVlGOGZmWFNYNEFBVjZyRGth?=
 =?utf-8?B?ZFRWWWFKQkJzYkIyZjdYZVF5aW56YnBidDhsYmd4VU8rNDI5WWxieTNQWldk?=
 =?utf-8?B?L2ltcG1pbUgrUHBvM0xka0JJdlVEVTVhYnJ2c25USWpRcG1ZK0d6Mk5IdC8y?=
 =?utf-8?B?dkQ2c05yVzNJb0RHMHk0UzVJVUZhcjY4MVRMOER0QlN1WTlJSnA1cUFIQS9U?=
 =?utf-8?B?cXI0aW1CV0FVbXJocStMdkEvM0dRWDVDZmJ0Ly9iUGxsZzBiRHVXUWdnQTlO?=
 =?utf-8?B?bjJ3TmJxWDE2OExLTkdVVER3R09oVnk0U1FyVXdxdkEwdDdEVzNaVHVHQndO?=
 =?utf-8?B?bG1sS0E2QUlKOHI4TFhpVWFLNUkrZVNMb21kVXdOcStQb2JsQmlOZm9nNjdz?=
 =?utf-8?B?SXU0bEo1Tks0M0J2ZllQWU9aeFl1WTJBN1FBSU42Tlh6andwb1V2Mis1UHlS?=
 =?utf-8?B?Z3FKSWJnRTRDZ1J2VDZpazh5enZHQUxOOTJwcnNmMklOQnFCSHVhek81OVNs?=
 =?utf-8?B?Z3JkZUx0VXROUmo4WmNVdUlyTmp1RDM2cThuWFY5c2FKS0dPNHI4aGtMSWhN?=
 =?utf-8?B?TDk5SXlaM1c1MTk0ejJQeUNmRHBWdis0SEpVL25UN3JaUVlYTWh1TmNicTBZ?=
 =?utf-8?B?QkZtUWNCL3ptTTUzV3VlS0VnaGE0WnVadldGSzBoQ1RZVk40Q0VSZkttUkhU?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e8d5d6-7b16-4c1a-32b9-08dbd6092661
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:51:39.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLWAG40ucIq3K6JamSsbFaxBGVzYzib4XsE2uMQ5DOHh3u9EJq5QRjUvmnI8ulj/60Q9iqU7CdV7vHAgnZ7K8QbC7RKewVuCNTrDJsW0cec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8307
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.10.2023 10:38, Ivan Vecera wrote:
> The i40e driver does not handle its VF device types so there
> is no need to keep AdminQ register definitions for such
> device types. Remove them.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Thanks Ivan!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index d561687303ea..2e1eaca44343 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -863,16 +863,6 @@
>  #define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */
>  #define I40E_PFPM_WUFC_MAG_SHIFT 1
>  #define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHIFT)
> -#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
> -#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
> -#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */
> -#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
> -#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */
> -#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */
> -#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */
> -#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */
> -#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */
> -#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */
>  #define I40E_VFQF_HLUT_MAX_INDEX 15
>  
>  
