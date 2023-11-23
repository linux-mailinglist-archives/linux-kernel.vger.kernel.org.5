Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120F7F5CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbjKWKp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjKWKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:45:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8201BF;
        Thu, 23 Nov 2023 02:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700736332; x=1732272332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CRnNENeW3Pq8Nht/olu3MhOqA2F9bOGoiVSyStC0GIA=;
  b=HMm0Mm/toYge4XGX7qzF8dxd5z5OERm2LM9WvffzhRZJbJFDeZqCM7CE
   AcmwnRBwqNDTE0uQSTOMZpB+wkZ9Lgx9DaoNjAJ3PP8FjLnNzCUoBrpyh
   eChYFFYzp7NC3ssuPoTc68QzMWP7LvZv8wqqTiZpl1nbLIe7rTKIDiR+i
   G7HfH+JvxAqD9XBATpksXhaS0wNgfDpSCm6uwnUzFrWjoF5ASMZjjlOqb
   vCak4MPc9I1Zy1YiURCUvoc9ioLYCb1f3BH/Pk+tQj1mFO7f2BhbhwNJR
   2sRgHhxBumb3urL6pzyr72b8t6+9ilBQ0fJmUecVVz/R08u0A+/3IyIDv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="391124134"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="391124134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890757536"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890757536"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:45:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:45:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:45:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:45:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNhbRPOGDprK2vNZVoqgoH7NuCQAmh8jWvwT7j94jAzRtIctBGJe+um23pYvGldhejuNzVICOKh1k0d9ubImlQmmbNh/BOzyrG1o74ga8Z7YqIOPSCWp8ql86LpoxrK3/fifkWaf6WumhImKLB1jFgjOs3EUqOncJBhBs5LYDote3/xvVWPBMqXG9+yDzVSrV07BMtJhTCVYO13pXIQis+57l2P3XAqH4Qtf/cz3iUoo9uoAt3jqJS9VM6iYHSuN3UHa8t8x7jZ0sEgfW1YRRUr/UKJZeYohw4iK5L2BShgedzSamlB5PDf8YMfTfMxMz5vZA5FN85ytGDB/8eaO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTzWJf55YmdchvWQ4zIgV58U6LQyFQ5pQDore6wedeI=;
 b=EIzbhChiWmg86KkfqTZS/LNT0rCSv32IdlLoRlz+3CNgWEBx2Meewgycqfcf6noJFtYD983UQcoTEsMLA6+rgN+KKheRC1IOfXTjZw3xEbQOB5zEI3Z9Lqxvt7+dN6AtnlLkCM6bGBJo3645qT1tAjHYeIg3lcppxT87MOJ51XrZl3F9M7nUGsBokBA88QH7ROmc0uAL4HEbZ/zeUPK3WnWnVcNm0/MzxOEli66jCY2bJE+N0gjMP6iZ0VgGg5kTjWftDy3gVZ3DXPLGNEjzb5Edynq14NqTkJn6dHcSjLz23a0jjdGtu0+C2ZfA6+rpoE/0HTqo85/xeaTdck+n+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:45:29 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:45:29 +0000
Message-ID: <24e4edf1-14e3-460a-bc33-0b2177a49ee6@intel.com>
Date:   Thu, 23 Nov 2023 11:45:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 1/5] octeontx2-af: Adjust Tx credits when MCS external
 bypass is disabled
Content-Language: en-US
To:     Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
 <20231123055941.19430-2-gakula@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231123055941.19430-2-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d322791-e439-4b29-fee8-08dbec114f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ictD5C2OodwoPB1/P+ZfNe7bcvvmGOuwOVUvvOJx+pQW8/00P2Jk5nBHELQFgVLHgXTfBPesVnX3lBmWbgjRJcQMLSNPpZibsenbk5S1apZLCrHrJTiluFWiUVGMcsohXuaQiasf5MqY48kPWIhrNjF5cdwGdpdfSERKS7p8ZIDAKM/ZBFLSsTSRoVk3JmXqRBp3n2ZxW9NMoX9EpQwi7TjDKVQxS9aEt1H1b+teHPDjNmXxRBvkqBlqG8s5jgfSAZWw8OM3ukXWl4Ex9yjzL67iJbq/Cd08gzu7cMJj+osPCVxX2TfyecTLRM1yZ39BFnMVZ05kmFexiPDtRvBH8Pqp2zQJkBT6Z22sFovvXUkarxcK13NbBmLu0j4u4VQAtwhcoYiDmEwsflAH35M4YYg7qNS3MyoAlBpzfxxQUTc9z0oEgeHtvnTcVpJKaZbP5W20gf5Ls0ZVkzaBXljcoiaVZGMOvlZy3VphXkw6mckyZB1enbBaJGKiKsYTXWjuQCG0kgWMeu6q75BHCI48yoPV9I7CpyHYdG4/NLUJKlpgEpAeQo9FGllbrEOZddXDs7sVCOUgEaJG4py7hm2DjLeSRVxpgfPYvNYE6Jvpx4mYDhcxDUv4ICBeIEBNkYqqR40x1srwbWyr4UM9gXaaOBhEKc6hVhqdCCBZVMbqdjH5q89BAILaScEvtoy8dQ4b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(83380400001)(6666004)(53546011)(6506007)(2616005)(6512007)(44832011)(5660300002)(41300700001)(6486002)(2906002)(478600001)(7416002)(4326008)(316002)(8936002)(8676002)(66476007)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZXd28xZk45Z1RaaDJmZGNvU29xbGQ3L0trZytIYlZoYzlVMmxlaTNIS1FI?=
 =?utf-8?B?TFVVTEZpbFVnWXJScVY5Ymsrd21WdG93NHI3d3YrMDJ6c0NNMml0c1p1S3Bi?=
 =?utf-8?B?bTg2aFBvVXhzRU1PMXpyNFRyTnZUMkRkc1VwU1grS2ZlRENSWC9OWlFXaFQw?=
 =?utf-8?B?dWRNdy8wdjB5ZVVjTWpYZ0I3TC92ZTNrL1NVd2xXL0I3Q3ZuUjhIeFQ1b1RD?=
 =?utf-8?B?STZoNm5mYWM0TUxlY0VGMXJ2QXlPVzlUUVc0ZE1TaG00RnB5cUVXZXI3eDV4?=
 =?utf-8?B?dnd5SkVsTzRCRTMrbHhVNXk2OTNrVm5xYWt6enFEZGk5VUtyV0R0ZXQ3R1ky?=
 =?utf-8?B?OEZuQ2NTYWdmLzVnTVUrWFF4K0RyV0p0V3oxTGFKd3JWRXk5OWdvTDBtV0Nn?=
 =?utf-8?B?OHhCbWlSTUR4RDdiWGFZRTJSamZYbC9iRm50Tk5HRXdDb3IraXpVN2g4YzBu?=
 =?utf-8?B?UFJJY041NjJITnJ5VWtKb3RyYUlqNWZ3ZUlzWkREdzVHdTJPOUVteWNuQVF1?=
 =?utf-8?B?UkhDb3pSUDh3d3JNUzN2NW5CRmdlRkJqYU43b0l4OXlYSnRDOG1RWlpLTWxy?=
 =?utf-8?B?QkRORjMxdmFyYXhqQUtBb1BmMHloWXV0MVZxSnhBNXBPQnNjenJuZW5Cblk3?=
 =?utf-8?B?S21ybkU4b0k3R2tacEl1cTA4L0k0K1hmNlhSMFpld040UTJ6ZWhsUlVPUjQv?=
 =?utf-8?B?SUJwMm93TUdZdHE3Rm9VK2pONGlvUENhL0l5K2JpaVV0bDI5dHNJTWlFRk92?=
 =?utf-8?B?TlUrV0RUeGw3RFVwQ1RpZXJTazl2WjZDTUFFVkQ3STFuL1pGZCtqNEpZVUdo?=
 =?utf-8?B?c1hPOGowdVlZWTRvdVBaTG1TVzZ3cUVIT2pmTncvSVhWWnBpUEUrOXBLVjFU?=
 =?utf-8?B?a0kxdUhtUkdFLzk5cjFCQkdmSnVxLzNacmgwbXZBT3RkaTFIQjdMT1Y0Q1k2?=
 =?utf-8?B?MEZuR3pJbXpWMU1ZYTZSQWtGQkpDcEIyc29ocEN0OVZJbTM2cUVSd0NKOTVK?=
 =?utf-8?B?Q29md3JPNnFqUDFvaE02U0J1VHVFMzMybERIcHV2NDh3WW1qWHJYZGNPRVBN?=
 =?utf-8?B?RHZVWWxOMFBpakpxTHI5eklVMHM3U004RU1MZEFaTWNuck0wZk1sVnoyZ1dR?=
 =?utf-8?B?SlduV3JwOFovNnV5aHlaOFE5NEFBT0ZTYlhVdHpBYUtvN05zUnpFeEJObThs?=
 =?utf-8?B?UERFbStHV2tPbStwRmt2aE0yTW4rVVM1eHRpcllmczAwMGdMdkQyZ3paZzNO?=
 =?utf-8?B?NEZwSnB6eW8rUXpYSG5yTVNjOGx4OUpROWtueUFYRmEvUHNTT2I2S0hscHVX?=
 =?utf-8?B?eVpDa1BEdFBSYUZvS3A3VjdtN21rUjJOZ2lJQkkzaG8weGZ6WjBXRGF0eFV1?=
 =?utf-8?B?bTduaEhCcnVHQjF3S2pmTGJZM1hwdWF2cHBNaGRmVmFSOXZDRVF4ZldPaHVT?=
 =?utf-8?B?SmlSekhvNHFQRm00YU8ycTNTTjMzNGtOSDQyOWV4NStNaHZKNEVDdEhYR3Bk?=
 =?utf-8?B?MWF5MjJ4di8yclhzVUdWM1hNRG9wWStieWhKeXg1K3I3MlN4NVFWaHliWE8w?=
 =?utf-8?B?anZDYVhoZVBHR0pmakdkWHpOOFhLSHNScHBvcnAzaHEwc0xGQndQV25zY1NO?=
 =?utf-8?B?Ym15L1BxTERvVStYTEJnamU0VmpzU0k4MTYrakxnRmpwME1Yb0ZaTDFmckZn?=
 =?utf-8?B?Q3FDdUQ0bExSS09Hd0tkYnFLc1dXZkRpTlA2Rmc5SDFnTHE0QkxlOFQyQUlu?=
 =?utf-8?B?bGJVMklEaDcwTmVDK1p1U0t5YlRXWlNJZ3AwWTRBTG5IN1lGdWlYZGl1NStD?=
 =?utf-8?B?L3BveHdodUtTZHRuc0t2MTZ6ZTZ1M2N1dHBOYndWQngrbCt1R0xWTy9VQ01j?=
 =?utf-8?B?bWw2aUFyby9kdElMelZoTWJGZTBLNFVLdnM5NmVJeSt5VHVjTXhaKzA0RmZY?=
 =?utf-8?B?c0I1ZEdlTnNLUXk3T2tqbFc5bFN3QVRiSk1UWSs3UlFUQTYveDloUWltMG9P?=
 =?utf-8?B?YlpqZHFqdzFmVG1FY2krc0FZbC9BVmsrUFJMUUtqV2RVTk9zU0V6YkU1OHQ3?=
 =?utf-8?B?WkkvclFZVTZvRTBUa0I0bnYzRVE2RDNsemRmMFhUenczd243Wi84Q1B6Nzdo?=
 =?utf-8?B?T0FpOEN2elFpTGVFbTBtMzZkNWtjRXlOT2ZKOFZVL2c4bTZxSkUzM3lYL2hi?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d322791-e439-4b29-fee8-08dbec114f19
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:45:29.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS1xQqVfWVC8DOYThVwjvjGCpBT1a4pLAXSyIx7TJy+vO/lGv6ICrMVIvJuYWLCoxGGvOe9AzScnIUYWSEgRiU5srecCvJPri9v7CPF8mD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 06:59, Geetha sowjanya wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> When MCS external bypass is disabled, MCS returns additional
> 2 credits(32B) for every packet Tx'ed on LMAC. To account for
> these extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
> needs to be configured as otherwise NIX Tx credits would overflow
> and will never be returned to idle state credit count
> causing issues with credit control and MTU change.
> 
> This patch fixes the same by configuring CC_MCS_CNT at probe
> time for MCS enabled SoC's
> 
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index c43f19dfbd74..d6effbe46208 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -1219,6 +1219,17 @@ struct mcs *mcs_get_pdata(int mcs_id)
>  	return NULL;
>  }
>  
> +bool is_mcs_bypass(int mcs_id)
> +{
> +	struct mcs *mcs_dev;
> +
> +	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
> +		if (mcs_dev->mcs_id == mcs_id)
> +			return mcs_dev->bypass;
> +	}
> +	return true;

If there is no mcs dev with the given id it means it is bypassed?

> +}
> +
>  void mcs_set_port_cfg(struct mcs *mcs, struct mcs_port_cfg_set_req *req)
>  {
>  	u64 val = 0;
> @@ -1447,6 +1458,7 @@ static void mcs_set_external_bypass(struct mcs *mcs, u8 bypass)
>  	else
>  		val &= ~BIT_ULL(6);
>  	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
> +	mcs->bypass = bypass;
>  }
>  
>  static void mcs_global_cfg(struct mcs *mcs)


<...>
