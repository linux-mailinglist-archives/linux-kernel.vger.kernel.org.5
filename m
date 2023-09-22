Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA487AB470
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjIVPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjIVPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:08:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134E180;
        Fri, 22 Sep 2023 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695395320; x=1726931320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T9TFI0fveM2FGxGI3VqG98zpsHVIEmvS8/UjHAsig08=;
  b=QHTmVaZQnQYSjjkuHKO6T7RcZelkYln6TETzXUd3RCXiTa8kQEaejw4U
   DfQd0ZDKEK9ZULpmOvNXRYgFm537qv+vZmBjLW2ZFyAJz5C869UdNp6nN
   YlRX2z5gvp/I6TJVVmDrexUQraZZv+zQUpLXxka9Xvp57+jFmMfOhhekn
   IUwrOHOAA0EADWUo3dOiqAMTiUY8pwzakHVGhX8vjfdEknPA+zz6npg4I
   3COpW5FJbuVJyWSv/1gLW9TJITJ+gnvbw8AydshBG5RP5ZjDuADxcpEfD
   oUijc5H+jS6tG96fv2BGKf/d1MG+yh/QDjLaFecekhwT4MYX7idZerNgS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="444946250"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="444946250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 08:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="741124146"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741124146"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 08:07:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 08:07:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 08:07:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 08:07:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4mJSuVsGHNYfG6yieKCFmhwygzRPRLIfZr7eK12cNF55dHxeh0EF2+Eu0M47p0DTEEmaaNdoWFCNnssgSFsIPvmJmBGTMQcRGLHNVeNXI0R4vlDGtNUSrkBvqLoY/CZ2Iq0DuVSv5fZgIetK/iMB9/I4RHY8xWGUbYlYXVxy5g+komS/SEl3MwI5CsD9+LTxYof0VH6PSdS8oaeZvwtq0WyNkB8arJxbEEG3FAoQlUOJ500Id5y9L9ITx5OtgmSl8Cz/TTWiBQV/lwea4riDMTGpYnTyUjppS71RzWBaTNXJWfjLU6WgmJJ4IoUqT1fSla8DE27TLIbnsHZrDahTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAZuIyN2A6ZQeN1swpPaCPh1MnxXjHG9edVz9rCk29M=;
 b=akHS/fSvNpKZvrPJsbiiqOXDxta/BJ/hzDICOJacPdgk6rIUbBRZ0nAZ1SzegJvj7h8ovMBFqQ6m9pRKX9jCWBf80/qyrhk9GDfeOiL/xJ+4l0Bhp7eYN6wAE9jeiEmE643Mv/MSIOnI8Dba2/wqE+g0xVlJRz+4cxl8pJWzP8HHwwKYUkmAs7gitMwnZAvkBYO9V8etyvB8uhhjbLQ3W4sFlBIlyCwmvTy5IOv+iI0LzA+znsmgDtPsQy5sco40Zm1jNiUuSRU3uhVEIYaSh/t9NZYxstUQiqNzMB7o4cqHk1E5Gv9h2pLXDhJo4cl7PEO8589xiUd0yMfdfEH8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 15:07:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:07:47 +0000
Message-ID: <f2527191-281a-72e1-2dfe-c2d96c8f81b7@intel.com>
Date:   Fri, 22 Sep 2023 08:07:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 6/7] cxl/memdev: Fix a whitespace error
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <CGME20230922113350epcas2p230c0ea8019d20f8ae8d246a5566d3a64@epcas2p2.samsung.com>
 <20230922113636.3301482-1-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230922113636.3301482-1-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS7PR11MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: d527c96f-42a3-47de-2d2c-08dbbb7dae4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X96RW+zwP5fpLxX09nLavplEjdV2/VXjcGL+thzq80AvbEtA518+cM8L/TlzryUyyRtNfG2xHu3uDwRnewrZ0tqVPiAzCWEtm0KCAAWfpkQxlu6jdCRgeoX9fx+DOlG9RlZO4mcEFEMf5/tayGcQXpHQjlo4c0uUggTtuYR0f3fscyFvTnhASIoy2/DX6BsX2AEIRfmIejgU/dtCu4KOIFN5kvoF+lyIhym7UP0NOxgsoYdAM0F3qBYTFmgwCoFtZI0EtEyp5kA8aG6MLk1oL+14sKLDjO+dKCHHqz4garIeMllhoNPOFr+uDi7AgodCdHmNTl2n6kG6lGOxTmsVP4B+5SG/NAgX0vXIPc3Jg06mDI+xY0oPG6LdnMyna3eNBvZXlsDkdwwpPc20Fn3Q/mhthFz2xQBdgGnR+LljgcPwStP+zYCZ7ryNfuq9/Z7kifc9w8sEhSgk0zY3z/2fVy8gSAOiL7vCaweZMoqCPt67nvieYAtruJy2EH3F09hZcZh6bq3E+P2ENMVSLZls+KzaTPLvJZg4T50RiLde7M0IZrhhzXUgNozkXKF2IfFjUY5Ym9tzkyfpWWvOynNkKIWSLQgK947ukmzaCIlHJqiprfHNdujTReISsRGFB60H9GAi1T6tMEpx4YTGOdw0DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(478600001)(83380400001)(6666004)(6506007)(53546011)(6486002)(6512007)(2906002)(44832011)(4744005)(66556008)(54906003)(66946007)(26005)(316002)(5660300002)(41300700001)(7416002)(4326008)(8936002)(66476007)(8676002)(110136005)(86362001)(36756003)(82960400001)(2616005)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VTRlF5eTRpNlVyYkt6RngvOFhaTXFmME13d3VIazh3RzFOTGk2U05zSEdO?=
 =?utf-8?B?alhZL1NhajBsNEdFK0FWSTVJaDNIYWFGQ1djRGJyOWVPWmZzRkJuZkNsK1Bj?=
 =?utf-8?B?eVlJTlZ2U3BscG5lMDY4UUY2dzh5cHVFWDAxV24yVmVLZFZUd1RxZHQwZXpS?=
 =?utf-8?B?NDBLeWMwZVFKMHhiWWt3eGs3NWFsaHd4UzFpU1M1Zi9WcUVPT3lYc09HS2pM?=
 =?utf-8?B?UnZFRFplOVFmS3YxZStFNTRtMkp6ZWQwaUwyY3dWV1NsL1ZML01jdWNVekNs?=
 =?utf-8?B?MzloMmE2dEtjVTg4ekJ3aFcyVXd0anIvSmNCYlBHYXhtTW94UFRpdlpMVkRp?=
 =?utf-8?B?c0JuMWtnUk9USEJCVjVqOTg4bnFaK0grdUczVFZKWnJxTVM2RlVBRnBlRCtZ?=
 =?utf-8?B?YVkxNHZ3YnVMVnlGcmFZNkwvaFozNU85ajN5dHJ0WVF6N1ZWWkpxY3VDbGZB?=
 =?utf-8?B?ZmVKTlg5NFFmVW9xWnNheWVVRVFPWDkyazNwdDBaM25zbnRNR1RtM2lLZ1FQ?=
 =?utf-8?B?amN2T2FwQXNnYzBob3phWDV3cmIvWDZvS0NSd0pLOTdGT2tuNGpxODZ3ZElJ?=
 =?utf-8?B?T0NNNld4WUV4eFpZVGxOT1FtYU8rNGZHSmNZb1hINlBjSFQzTTIrQ093UVBS?=
 =?utf-8?B?RHhwTEFydnU2SjdyN2wzSkJUOFZPVDZaUXpFLyt5Y3dkOHpjQkVMaWxNTG00?=
 =?utf-8?B?T1pvbVdrcHdQdnMxT0tBWFdPL3N5Zms4U3dnQk14UEFEcjdJTW1iSitUUFZK?=
 =?utf-8?B?K2ZJVURsSkN2TDUzb1FwYmdZL2lJT1g5c3JHZ1dDd3FNOHFUZW53T1lwWS92?=
 =?utf-8?B?T0plU2djbkphOXJhelNLK1VIUHg2UGtVeDRvY2FtbUZQTGpsajYxTXZhMkdr?=
 =?utf-8?B?YUpNRkdrZTRMb085TGFTUXJxbXJiazI2OExibjdUYWJhK2dkOFZrdTJpTWdY?=
 =?utf-8?B?M2Y0aU00VXFBeitqTU0rb0NKOXZNNVdVNUZZMGpQaWxDVjVVT3RGYm9uQXdi?=
 =?utf-8?B?NjNwbng2ZzV6L1NFRFE3RjNpMTJnT0Izbm9qbmFxUnBZdkg2V2x3dEo3bGxU?=
 =?utf-8?B?MHpFTFdYbUxUTlZsdnEySnE1N3M1SHU1YnVOK0VWdHN2R3hmSHlUYm4rRjdt?=
 =?utf-8?B?dTFjeXJ2N0xzT2tDUnZjcy9HNmZ3SUY5NXZSTFVzRE83QW9MNUtjaU5iQVU2?=
 =?utf-8?B?S3MxbHA5ang4M2tkZmxCdkt2OURxN2pIL0xyZWxUZk5iaVFTVXZsNC9DUFdx?=
 =?utf-8?B?RGZ4Z1RQZzRrYWxtT21FZ1BPZy9KVi9WK1RZR0l5TWRRSTFIQWxxZS9DdUVK?=
 =?utf-8?B?b3FCSUJyWVl1QmljZlVpYlRvZXoyOTdxeTlKaEtEb1NCQkw1bnlVbmFDUWRS?=
 =?utf-8?B?UDMwdTBodWg2ZFdBM0ZNS1dTQW54WWxkMTdqY05GZ2Z6Y29OOE54S2dlRnFW?=
 =?utf-8?B?M0twRTdkVGRYMGVlNk41Q0ZxYXFBYm05T0pkRzdaRCtvY25zZHNmTkZ1Qjl1?=
 =?utf-8?B?NVFHWjZUaDZPRnQ3TXJXNWFXUGVnenYyZEc5K1VmdkUxa3dHMlgwbG02ZGt6?=
 =?utf-8?B?YThMV0x0YU5MYlJ5MDQ5SmhKTmlmUElUZng2VU1UeUk1MEVrVFJJVnVLWkNs?=
 =?utf-8?B?VHpWUTQwQmc3ZDVnTGErZyttUmJDTzFrM3hrVDRxR21YdGJodzJMbGVRYWZP?=
 =?utf-8?B?YmFwNUhFak42Q1ZjSG13RlZQY0xEQ2xKU2VBbEJjYTg0a1F0K0RBMXZhUVg3?=
 =?utf-8?B?d3kvbjN1Q0NLMGtGL0hNZlJVUFpnYytFV29mT0xnSkMxMW15azE3SUlLUjl6?=
 =?utf-8?B?T3hGbXczTjFoS0Rhb2RuV0ZabHorTWk2V0tud3FPT3B4QjgwV1ZlTWFXSDE5?=
 =?utf-8?B?dE5GWFhHQjBqNnN1aDc4L2ZzY3Z4NThlWnhST2xya3RocnBEY3cyQ0J0VlRk?=
 =?utf-8?B?Qkg1eG93UHI5djlPWDkrZnV1QjU1YUpHSlZORWgxWFdsbUlXNjlPRlpmYU44?=
 =?utf-8?B?QWVGMTFnU0NtZlIzNXpiWnI4YVh3NUd0RW85WlNYQ3hXd2p6RUJ4NHA2RGg1?=
 =?utf-8?B?cWxVZ2tXRGRLbmxrdFBDZ1NHcWMxWGM4WFZub2J6emNuemsxTmlvNHVQakJr?=
 =?utf-8?Q?MMekiFFyg5G65Hts+qVLn10sn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d527c96f-42a3-47de-2d2c-08dbbb7dae4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:07:47.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZQsz//XSAPRpuFGCmM1CL+2bKHW2upOa9dYYdTtK3UG/vW2TctjrtJ2EqYw+ee2emcuYp8z6FExDwhxnWy72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 04:36, Jeongtae Park wrote:
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..7e8fca4707c0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -935,11 +935,11 @@ static void cxl_fw_cancel(struct fw_upload *fwl)
>  }
>  
>  static const struct fw_upload_ops cxl_memdev_fw_ops = {
> -        .prepare = cxl_fw_prepare,
> -        .write = cxl_fw_write,
> -        .poll_complete = cxl_fw_poll_complete,
> -        .cancel = cxl_fw_cancel,
> -        .cleanup = cxl_fw_cleanup,
> +	.prepare = cxl_fw_prepare,
> +	.write = cxl_fw_write,
> +	.poll_complete = cxl_fw_poll_complete,
> +	.cancel = cxl_fw_cancel,
> +	.cleanup = cxl_fw_cleanup,
>  };
>  
>  static void devm_cxl_remove_fw_upload(void *fwl)
