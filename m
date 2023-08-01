Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3576BE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjHAUlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHAUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:41:18 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70C18D;
        Tue,  1 Aug 2023 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690922477; x=1722458477;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cCG+Lg2QS9XPADdfGDKMng4uqKjU2PQ3Z5OLmMo4HP4=;
  b=jhOLRrsbY+pEkKh7UbGsQ+AM3KvN12IauYUr3nvojOTntTMlZelWo/rb
   aoUDpqVnj15N5SSu811YPCrQsEUcXCK51JxDngQuls3doHs09lCEFZ5+6
   n7D68W0Me+RobND+XnHy3ynsgbbS9d6U/UtZ/M+2WHtdPSrkvWcq0fI7A
   14tfrsuN1PdwXgiTOyr+sA1yjEK2kQsYtOXGWejaKMP6uz6JOPFffe1gj
   B1gd13G9Q4A4Wsc6dhmqz1o6hVdWF5ElxdU4hc8MMTBOTBwncbnDlR8fX
   jtr1ukkNWPOCTXS27fqR3fMyG8w49gFVJM6zAyVfuEuE/3DKOpAeKI4yi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="354334966"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="354334966"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="842869901"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="842869901"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2023 13:41:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:41:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 13:41:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 13:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs9TAYzo63Zqqp3tEUwcsZZJEM9QiMa6bnz8Z8u6OWdh0M+9flWmZ/oach2FKcMCSyHp9w6xefHvZpHSISDUr5I4zz2hnQxxEfoKMB9WblOp3UMpUT/AAc2bW+3TA1AL76A+pfUjmdxK14xcbn/+Ofyk+3t66LjF4Uj1ia6GetkU3TArNcIm2DGhjJzDc8Hi7sthWoY0HuhE3lq0b/aBvlN1e903rYfqQcelPwEWuSdxXzcnCgWqqDxM2448Ookbi5n2Cs52scyn9iOLdaqp2bm0R7u9tTkscujR3cB64YF4UBnN94EYVkaUOcqE4C5ETnxEx2BUxAfBGTF6p/qwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iaqaI0AYj6yst0GnP+XuoMSUWIQdCHi+qwR9xARIGE=;
 b=kBoQg0T9rN6IAu/qBZuEYWddpBylYo/3YnQIi+vPmzSQpUMg5MmPtnSPI2Pw1LJLOPvPRqOWyyNpRXaYVNXCwXmh7xS074Sqf2ITliFOZH1lH204miHrmFU8JH+ejz8fLOsuMmuLPJQmtYIgwMuWcLdkH4+7Ho4ZAN5B0RCBWDXeh76+gfeYTnNL1PMT8zfmCfme9CAKuZbzNEUk8fRdvxhHakhxSyh36/4U/VZEMIllCeQoOydL9WdqxhEMoONK/EeYGe96owSJR7qAVEtFWjjA0jW76MMXkTU/XsSp0tQSVXs7KVnR4va8nNyy/jqnRqgQ7A+dMN2NaNpaF4iDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 20:41:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 20:41:13 +0000
Message-ID: <15a802cf-4969-f174-1e5d-1e65f3ff6885@intel.com>
Date:   Tue, 1 Aug 2023 13:41:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 1/2] cxl/mbox: Use correct handle in events debug
 message
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
 <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 210ccb03-36e9-46dd-d72e-08db92cfa57b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS1YkwP8hbdfxqkfsaikiRUcaWj/DemeDXsTn8ISwZHHQ5a+BrpyBfk/97RbYSjOsCNsCrtxUiVWFegQaqfzLIzib9FscADC9YS4wz+IoM/1lQngKWzAjx6BN+QKt+zWmc55M7zv+kIwUL0rp8vV1osEv9oACZ0lDspYwcx9cB2ieBTPrLYxr+I2SiZEwU0JOvPgZ0C0VAkAY7L+cycQI1Vuces7BXGc85WE+RRaYblITY6DgQ8f8zw45smfrYrY1deUlbM0irTj5w13soJ97PwnQaf4TQ4TapPTPsXp1gSlWJ7xjF4NbCDOedKRIAWrIHwxISBE6APuJdQ6kDX3lU9WBubFfJTiXqPlyEyXirRKrf+nwka0yPLF0WAfdO0EP4prY/clCfbo3vmJ/DRmIQTgsRE7tmx0y3HAwYVGGKJG2ZmaNLuXtmgltIz/TGNbF3ulKANegBdag+GAQt5Ld5o5o00wg+SAtTajhYNf8Nn0KXOCBDC5LnYYQWqx1a+jM0nvVIvHmmJLo4+VvOjRorJqHoXB9F2NLXS4XIStNUg4ed+S8JpcgMTKpiTOP3d6+GHpYCtWGPFeCI89cesqJaEV3i/bX84F26hPqO+g5USrb5q8I5hanGo9MTCMmd2ipaHBREfnxUXg44t25ohXIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(82960400001)(110136005)(6512007)(26005)(6506007)(6486002)(36756003)(8936002)(8676002)(5660300002)(66556008)(66946007)(53546011)(66476007)(6636002)(4326008)(2906002)(2616005)(83380400001)(41300700001)(478600001)(31686004)(38100700002)(86362001)(186003)(316002)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1BaaTkrQzZBUUZKZHZ0cE9pT2Q1UzhpZmMyWmJjcW9TV2ZVV05EK2hCb1lW?=
 =?utf-8?B?UWZUMlhST2tnWlppMHhXek4vMTFJanB3SDBqNkVCdjhkZlRlajV3OFRzblBH?=
 =?utf-8?B?dlloQ1I4bU1kYTVXcy9OWHIzaGh4TWxHbCsxVFFVanIyclZjaU51a25LSnpT?=
 =?utf-8?B?aXVaRTB5SDAvZWFGRjFnRjhmbzF6TXhYSTRnNVNSbGI3NVdoRjYySkNnV3E5?=
 =?utf-8?B?dEUrTkhOaWRjQThxT1dmWjJHZnhqUThVSFc0UWdsN2wybVc0UTcwaDcyaEJN?=
 =?utf-8?B?RUJKSFZtNkNNRTJoL00wWEJDWUZKRzNsc0RDQVJ5RzErZ0I5RU42SlJuTW9B?=
 =?utf-8?B?WlR2QVhSb1dDT0h3MENTZFhCUjNXbWpUd3NPb2VpZE03aDVuSDA1elRqQ2d0?=
 =?utf-8?B?NjVYRXVlTHRtSE1UQk9admYzVTdDZ1JCNjcyQUtFTjFIVEFuMzRIYWVmMHli?=
 =?utf-8?B?aW85REhQQmN1V3dBdU9LLzY4T1NHdW5FUzFLWEhBM3JPVWN4bDNaai9hUEtN?=
 =?utf-8?B?UFlRZmgwcTJTQS8xTll5VmlRaGs4YWJMNFdyQVpZYlpmNWorQ2hoN1pCNUU2?=
 =?utf-8?B?MWZ4RVpRRkVNN1hWaGV5aFdvV21sMTRPNkRFRGFVZk9pWjE4clhuck5lNkx2?=
 =?utf-8?B?WllyZkJGa3l1VXdhNm1QSWhMNjg0NWlZaVBIQXRnU1FSenM2bnRuZkZCVEFC?=
 =?utf-8?B?K1ljOXRZeEhFdkRXUWhGdGwvaXVldllyNzBZR093UmsrVlJZMkRybkl5VWsw?=
 =?utf-8?B?dklhSWJ1Znk1SjlBQk1vQjRMYlN5eW41RExkK2ZYRGJybldadFRDSUxyQS9P?=
 =?utf-8?B?b1d6Vkc2RTRlOXhiNE12LzVNMWJJUnRPaUJiNy9XRTUyTkI2eGduRitiSGdE?=
 =?utf-8?B?aVVTWXBjRDhPY2krYmhsMWdFNlVqNzdyaDA4MEJrYzNiMFN6WVErQ1ZMcG5F?=
 =?utf-8?B?RExtOTdmbWp5OVVUSkFPQXJRWDBhNjRZYXppZ09hdzNZald6bFczNGlWdGg0?=
 =?utf-8?B?TlE2RFYvSHI0Tk8yUlo1MVFnd1ZtNlgzbXVSVnNTbENvM0dadTJDcldXdW45?=
 =?utf-8?B?Y3g0b0NOYVJ2cmxHTTE0VWh4YVduNDFuRWlpSTlYUk16ZDJJa05scE50bmZ1?=
 =?utf-8?B?K3BrQnJJMGNzN3daa2pocE14MFdyNldQRWx3eEJCREt5NmxBWklDNzRRMUJQ?=
 =?utf-8?B?ZndHZVYvNW84cHRWTDdUdkVxaGpMRGJQc1ZRbU9reHBHK0tkd1c1bXBvREFK?=
 =?utf-8?B?d0VXUjNjdUVXcTNHelM2MDNnQkFtdGpxR1l2blBNdE1Qb0c5enU5aWFHbW14?=
 =?utf-8?B?alh1cXJFcW02TE96d3B3WmtxWmx0OUE5UWhFQ2RVSmsrejcvb0dOQ21CV1hp?=
 =?utf-8?B?MkpWSWhhYUptdmh1c1hKYll6anRER09tdUhsWE1wOThHdjJWQTJHZzlMVDJn?=
 =?utf-8?B?WjRxcWhob0JuK0RaTWVvQ2FNdTVrMDQ1N0c3bmtkaHNFVmZDM1RjaC82N2I5?=
 =?utf-8?B?RzI2SGxvVDZnN3ZQQ2NFMUtTc2RsMXRGYUNUdmJIdE0yRFJBYWVlM2VpWWxw?=
 =?utf-8?B?bWozL2FnZjJ2a054MTJEM0poUmpQbGp5eTV0R3d6MGFsQjBlQXpnTDlhQUZq?=
 =?utf-8?B?WnM4TG5JckhGTU5uejlqTTBHU0gyOC8wRE00aVI0c2ZLZU16K2ZhRXBPaXlR?=
 =?utf-8?B?OG9HZGRPZ1RtMEVWMFRPZE11L3VtWWFzY2tqNEYxWWlLTHVnN2tHeUlET2Uv?=
 =?utf-8?B?T3hydVRLQXFhSmNKNEpuR1Mvd3Yzb1lWVGhzaDhBMXl6ZDU5OFRXMVY4NUNL?=
 =?utf-8?B?NmpQTzhHOG53aDkvN2NhMi9SOWpLRWIvZ1gwWloxamhtRFgvdGdHbmFnVjVU?=
 =?utf-8?B?amVmZmdJV1UvTFdOYVJGTzdJMGtWNHFDMkk5RW4zbFRzclVVS1B1ajlwT0dT?=
 =?utf-8?B?U1lUZ3Z5YVN3YUd2czU2NmlTdktxSUg1S1dNckxaTFpaQVY5MmJCY0F2Ykh6?=
 =?utf-8?B?UkhpMGcySWZNY012dnlseWtNZ3g4Q1JaWitmOFFQdVhqWERiMmZFd3JMdTlS?=
 =?utf-8?B?Ukc4d1hvWllDbUpiMDl0eWx1MVdVcXMrdjJsTENiQW0yQncvazI3Q0lVV0NF?=
 =?utf-8?Q?1VFIhVcExoPkpO7qv9pCV2hoN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 210ccb03-36e9-46dd-d72e-08db92cfa57b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 20:41:13.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M33TcNStKJKThTq/nwByZRxAD8qirwiatKv1LQH9ODvZ19yOg1BbnR2aeCSLkJ3WizaJeEAeqCNvrX0E9HKh7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 13:13, Ira Weiny wrote:
> The handle value used to report an event being cleared by dev_dbg() is
> incorrect due to a post increment of the payload handle index.
> 
> Delay the increment of the index until after the print.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for v2
> [Dan] Go ahead and mark this for backporting
> [Dan] Remove 'To/Cc' cruft from individual patches
> [Dan/Alison] Split out the additional debugging
> [Alison] New oneliner
> ---
>   drivers/cxl/core/mbox.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..a1c490f66bbf 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   	 */
>   	i = 0;
>   	for (cnt = 0; cnt < total; cnt++) {
> -		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +		payload->handles[i] = get_pl->records[cnt].hdr.handle;
>   		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>   			le16_to_cpu(payload->handles[i]));
> +		i++;
>   
>   		if (i == max_handles) {
>   			payload->nr_recs = i;
> 
