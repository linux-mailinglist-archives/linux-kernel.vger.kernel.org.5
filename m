Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02F7B5C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjJBU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJBU1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:27:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8522AC;
        Mon,  2 Oct 2023 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696278450; x=1727814450;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XpKH4naqzI06ptZLcNPPCybyxialqBNFWhHU+GIhMpQ=;
  b=mEzlc9UyT1D5i6v363VnaaPrBUtm/L2xgR81RAQQhSTtzNOXHdF0df1v
   2OMCtsmhgo4u7ZlzWSSkwP/YhsMzb7M1hXTofSmUlP221dPifp9Xg+3q5
   unt77Rt62TPx7sHHVGrDf8ILy1E+kvYnQCFUt8zt8uKjfpc2Bj7OfZiJ+
   aa/s0p63igVV03hyQZg0Fxlmtps2StPxbHZblnVk6Sgr26uze/yH564Eb
   lBqsJVvqRbrN75qXOgzc4Nc6sq8yXI4hiqbal5RvsmqcnBZFxJpe5jzUp
   2m+XtVY5dI1t7F18hbSHQzSP0dqJG6Y+qmVYgstMirTW5/H6WzHyscluk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449219496"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="449219496"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 13:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997746081"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997746081"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 13:27:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 13:27:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 13:27:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 13:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em1TEElFty1H3+iBsSx39DdNdxNUwEFvpjzRUQI0S6YojNuycRM/5KVthaah+CGXwGRU9iZIj04AKssEDqczJGSdnad451icj2WISxmmkwzFFR45V2N8k6wSuUoIbeHeJoG2d9ngFUAGjIxaOUiNYHIx2tYtjjqavK6pn/rj9dX3PnYeSTrVKD5WKkVNkRZipggJ1rYMGI2t4ElAchy0fkTGiulaNyWE64RD+AtODtv5Oh0VYZCzJst/3W4D51Jpj0d6HTVdsBz0Jrzv+gkKyb+rKHhAvhtdVvVrz0vm64X0Uit/N49hWwc1gR8z7UYM3eZN2OjbOO+svg+kxc/xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lauIrvlP4ipHN3hG9gtRqvVPOhhOi+psp6C4ihlFsdU=;
 b=oazGcg3Wvm1p7L7mm2XJA48YtX5DJzRYvV72I05JdYXrMeA3ASWLbTrdJ+XWU+AtvP32+fCGYKlHBp2FESEIw9jxtTJvR0+ecYp/FBS1/gkMtpCFCTiReZhmzmdGsfl6T0Hby7DRDInFeD5aC/0gxbnJs9y7gZNGhppDtFWJDpGypU6vX2T3mzol9Oc1ulKvy0ldshvTyDY/TsG7kKgU5HN6fX8zTSlDSwLdpZjQ0qkUV54/z8yY5nAsM+g06QT+a5TWMwNMsrzIBO/8QALGt2Bxa92cxpDUrT0iygiaee5O9YLcKRswbnMaeDGpUH4I/LDSSuemNClsMtvq6eftbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 20:27:10 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 20:27:10 +0000
Message-ID: <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
Date:   Mon, 2 Oct 2023 22:27:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::13) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8237e9-e605-45ce-f788-08dbc385f432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eo01Uti3hIWPUJoy/6zMHvp3lLHRcUbD2PoqK4IuPV3d23Mxx/e+dUMTwE1Sj2JAoeRLEfMqXYB2OTlyMzB+THFEG/IWIPNIKvRxslLM1Q8GG/dTD60qFvb4p4ZL7tschK+YLyZTxWntaar3fHOpQ26gRLtVlNg+eVMA8i/DJYtbCIgyuJfgLXJ28I6SLjqd0EhkLinufA/PD/qZS/vh+4Mnyj7bMYiTlmQ8lw+GBk5eTC4/eQfZ822fj3sjAOkNBVXPmfi/oRMf5UDb+MuLtXrhrfnHoBkN4vJxxrumVmsdxue//Ql1TRoM4+Hq7yRLNQ2dz5ANA4Hm+0Mss/j1zIaoNn8xbJPwmNb4fSqeRqsFryGrYzuhq+fqE/qaTkq5XkB6m+Zs5HZghpq30HcfXh2KGEm9o/hxzeuOKVSR//IOWEktRNe+bIXG6BlejlJqmgeayal5M4rwn/kWNyhYLUUkynurGrq6fn+2A9z0LBiuYok/m0xDEScfQVjhIw20DezeeNfZJP/pDA4mpkLYlGDaB+rZfabmFmYGEMmzliqG24tF3UcIRHpkNfeiK6Ii4lYsQv1yNQQQEl7QM6tQM4gbaNzql9FnWxGk//noIgMcNRsnkKxmPJwrZlZmjrIOpAO8lrN6e8GmBG8UJ7IQQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6486002)(478600001)(36756003)(2616005)(26005)(6512007)(38100700002)(82960400001)(86362001)(83380400001)(31696002)(6666004)(6506007)(53546011)(66946007)(316002)(54906003)(66556008)(66476007)(5660300002)(31686004)(41300700001)(8936002)(4326008)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBYUlFrKzYrS2Nic253QU9xQ2s4K2Z0U2VSaEhQYTRsVjBoWllYQldGZ3hj?=
 =?utf-8?B?eVl3aHMvU2FyU29hdk9mcFhuNVlwUDZOcHVFdHVlNUtRNEpTb0JRWUFXaFBF?=
 =?utf-8?B?MEdZMlV3eVRHQ0NkWXVsUWZhbXFIYkNmMTZ4OUthQ1AwWHFYN1M3cU12empS?=
 =?utf-8?B?bjdWeTF4RFllMk1tMS9IZWt6cGxJZTcxMWkxWmdITUh2U3NOMlM3UVVqTk9F?=
 =?utf-8?B?YTdLSzRKcy9JeEptV1FSUVB5cUhMQ1VYUFViZmlpdzRac1JRbFF6WFZNa3B6?=
 =?utf-8?B?NEs0MTh0Wm5sUlh0Y3h0dW5zeTFGcmtYTHMxZnJNL3dSMjhRVzdKb3RWNS9q?=
 =?utf-8?B?Rk91R29IdUFrMHc1eGdwSEEwd0dTUjRpQjRWVGNobHRsdlBybVBzb1VIVXc1?=
 =?utf-8?B?YzFzaVJSVTVpQ2NSWnBzTFpCK0JUL1dCVGRLZjNaZUxNSnlyYUlNcTZaeEpH?=
 =?utf-8?B?VlcySlUyNGpJWnkrUEFlQkk1S0xPcStYTjEwc2xJYWZrcUpnUFI5Y0cxcDJN?=
 =?utf-8?B?alNzUHFVRTFsaWMrK0FaVktqR3AyQ3I0TG9NMXBuQjk1N04rM09DMkZFT01T?=
 =?utf-8?B?N1pLdG5tSThHTUFNS0ovb2IyVk9zUTdkV3o4T3ZBeXdZRnJjMlpxT1FwamVu?=
 =?utf-8?B?WUVkVHpzN0VmWWNGMEVJMXA2ZkVnU2JjNG1WRVVoWXpCRTRYaVloNnczTzRr?=
 =?utf-8?B?S1FEMUM0dHEyVjRaQjZrRTJ1Nms4KzlvSzlFbGtPMmNCcTd4SDlFdUFQektK?=
 =?utf-8?B?UFpYVDFOOUptTDU3eWFERFpoOVRJa2M0M2NPblhSM1VOSkRhZTUvTGhBUlVv?=
 =?utf-8?B?akd2UGh3YmlGVC9XRG5qMy9OQWR5clp2b1VLQ29nR2hDRzFKeVVIZzEvTUEv?=
 =?utf-8?B?WHNnaW5MbDVNRW5lR0JzSXRtTnpoQVZYek1uNjdPRDYyYXhwR1Q0T2VENnpX?=
 =?utf-8?B?RlZPT1pDcmh4V1ZoaWQyNFJZUitFRnNUcVdXbkhOblpTUUNCay9aODVWdm80?=
 =?utf-8?B?YzVGelhwMS9MMWZmT2ZpcndudC9hVEpaa0JRNDhvd3MvLzF1b0ZXUmp3TWE5?=
 =?utf-8?B?eStVbGJ3ak9jVHkyd0tDSzZ0b1dLZ0R3eENoY3pUNXYzbFVNUlFBdzZjYTZi?=
 =?utf-8?B?ZitDNUdUbE9xOGF3SEd0WnpPN0MrUVZ4ZmRLYlZDMUdJLzVGRFpKQ1Z1UXlZ?=
 =?utf-8?B?Q2ZraVRkdUtYODc2eTFjc1JUVDk3M2hVNmI2UDdXSG93OVQ0bEV0VjRhcHdS?=
 =?utf-8?B?RzRQRTQ0dS9BbDJkT1pkc2pmMHZ2UVJUbitVeEhKdHNBWFIrekdnY0gyWHFI?=
 =?utf-8?B?MDR1emJLNTVUQURPalp1TGZJOVN4RmRlbFNxT1FkTEJaQTVRSGxOSHV0dkRQ?=
 =?utf-8?B?c28xY3VvUHhlakRUTTRoVUkvS0x4elRoTEI2ZXQwZnM3bzZrU1Vkakl4L01S?=
 =?utf-8?B?bW9VV0FNSkJvSVg4TE1USWJHYlVPR3F2dGdGTVNiTUF6T005bWhWbG5EWnV4?=
 =?utf-8?B?UWFKejFZYU9JajltK28rWWIyVUJWeDcxTnNBak44eGp5R1UzSDVxVXhrRzFx?=
 =?utf-8?B?UzJTVE5tZnU0cXBXaHM4M1pPVTBwTWl3SVpxRURKU0V4bjBaQlJuZGczdHZw?=
 =?utf-8?B?UE02NzNESXBGMXJtOTFoL0hHN2VvSTNQTW1BczJqOHBOcWZ2N2RSS2orOXlI?=
 =?utf-8?B?SGphbzNqTUxIM1VwWHFMZmh4Wm4ybWtEeWJwV1NBcVk1dG1WOHhWTmJGaFFL?=
 =?utf-8?B?VHEvR2FyOG40b0lFMTVaYnFDeE5SZUdsV2JBcFVFU2Q2QzJaVnBZSmlxOTlC?=
 =?utf-8?B?enJpOHJZSkVneUxyQmVDZGlIMHMyWW5DcStNVXA1THJRSVpxR1hFK05ITFhG?=
 =?utf-8?B?Y0gwZEZ2RGE3Ym01VUt3Z1FURlFpVTJEMklSSk0xOCtOWW1nTnJ0bHlLc1Er?=
 =?utf-8?B?V1Bob0JlZmRQMCtrdHVFT2pnV3JXcUc1dVdlMk12cFplcUhGTDFwMWFXMjVN?=
 =?utf-8?B?Z0F0Um55SGJkcERaQXFVS2VuVVQxelhRM241RW5OaUt2TkhpTU5DcXp4NGV1?=
 =?utf-8?B?QTFHQXZYOW93eHNKQVhQUXpLRk10Y1FJZkdLNzRTRHhwSW1Oak0xb0w3Unla?=
 =?utf-8?B?TTQ1djhpWmNicVJJbjQ0SHhGTnpKNC9vbUg4R2o5ZDBmeXBXUUtpd0xjVjN0?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8237e9-e605-45ce-f788-08dbc385f432
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:27:10.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIpVapP7ft/h04x3ydNsrnQPEdpJO5DApFePnYIvB438YrvmJ+2HInXfSRSnPJOS4E/iBmDRccV9G+HBQp7R9inArRxobmHil2h6znJbdC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2023 3:54 PM, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/nfit/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f96bf32cd368..280da408c02c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1737,9 +1737,8 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
>  	if ((nfit_mem->dsm_mask & (1 << func)) == 0)
>  		return;
>  
> -	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
> -	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
> -			|| out_obj->buffer.length < sizeof(smart)) {
> +	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);

This line is 90 characters long, wouldn't it be better to split it ?

> +	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
>  		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
>  				dev_name(dev));

While at it maybe fix alignment ? :-)

>  		ACPI_FREE(out_obj);

Just nitpicks, functionally code seems correct to me.
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
