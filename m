Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E77D480D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjJXHKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjJXHKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:10:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7810C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698131435; x=1729667435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=88mX5iGhVtWF7PjOJB8w75+S81B0jnc26FsDtNl+81Q=;
  b=QC/V8Yl1H0AuiVymspdYYscZ5kg6P+slw+EIRIo6hTrZTs1GssgBBA5A
   lJM9DBKJnTFUXw5FMrt3f4TvTHqqjys9IKsI8kCJr5kqGKLMw9/Wk+jRM
   0LwJcoHpF3RdY5jZRyukamWFiOI4Uv9L5PFqQhk0CP0TyJb2zjI7jYQPs
   0PXF5h5xmueb/6dvvKBXTBr1vK2vVB9kuGiWo6zPP2y79j9FE6q3TT+Y6
   1gGaDQpb7iixwn9E7Xo96eoHTfxvVIB7Ur5X8meBkwfydLIF7lzljQ7wW
   zSXqCA9Mv127Wyvn17Iu9tzSC5Pa7L9Y2jdQkSuPQEBkQS2b/jFZ5oMf/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8551436"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8551436"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 00:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005579481"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1005579481"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 00:10:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 00:10:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 00:10:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 00:10:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahs76k4mcK/3iGYMUULov82A6g4qMn2mQTMQy0TfZKE7NpMXZTh5iBi6BXFdY++qR/JPGk4c/P4M2NIstSfEzGht+qAJW/Z0Kuu0eleO+7NSZpkr0hsmrEDiFeWkPqtAJe1lrQk2EV7JsRRSoDXBkqgsVraEuK1RrF45wgJhhGpCL+7owHHO1OPp+7c1ZbZbOnLLqFbKYXFWuylmoQSsVIQYZTh97PCFJ05OjtwdIPxmG5NWWjAK+U3DEyrPXXyOySGHcU+uDU5anS/7RNVfRPd+hg1lz5EZkyWwxiliKUSt5M/RzXVxYsFF8mX5HTQ4Gn5T9ctgoziaBPfLx4Zl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/oF1qOPOTS6pLoD59jOE72Hnw7LRPzZvwZjzXEcHYU=;
 b=Beysn/8sBWdkznaqC+KuGAGMGAaX7gR6aQtzRLL+eXUUnKr5NdnHfP88XcrgPneCl8dRZXN4LcWDanfUn+mRirRPQuc7Ly2eZFDRymEEVuRz6pqmaclkDkzIlnMQpfe2Sr2cbqWBqWr1LXEkfo3Uj+dw+1MzzWQIV5wwZO9rCx7MkVH7PrvfrEvuwW0FTlmyX+ONU49ImmoNgvLYhrjELUsT59JPewQKYsIEywhollD5my3mtKBEkmFbLuF/bxkf+gYDHSKVgxz8YEhK/G/1BBLSWCwugzERqXXy8or9F3zrKEgBdO7sUdy/V02jFV7cT61pNzr7n+RNF/QytY8IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB8138.namprd11.prod.outlook.com (2603:10b6:610:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 07:10:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::cc11:6433:f346:c503]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::cc11:6433:f346:c503%6]) with mapi id 15.20.6907.028; Tue, 24 Oct 2023
 07:10:32 +0000
Message-ID: <35b325ba-8575-900c-5746-8586f9b2c42d@intel.com>
Date:   Tue, 24 Oct 2023 15:09:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: mlock: avoid folio_within_range() on KSM pages
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stefan Roesch <shr@devkernel.io>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <23852f6a-5bfa-1ffd-30db-30c5560ad426@google.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <23852f6a-5bfa-1ffd-30db-30c5560ad426@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OSTPR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:604:220::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 244416c4-758f-4ac9-3439-08dbd4604fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KQcQJyPdluG0VewQ4aM8+8ToNhLZcJe4NIpA1euETjlLYJU0/WU/GArCgx/VnyBS4TEpts4XJj9CoY2OpRPQbnLwPDztpBljj5oGhW29YnU6oolPyZJTm5aGs6lbahijhQcPP9frK1larGS/GHwB5mwlnfCBOqoNpT7eJLkvc4Bpy55/WQCd3x8DjEuZ8ViabW6n62EDdNkPLvr0Tpgs6CDRmWMwwiCxDXvEnS856oDsdPnZikPx8A7tiY1EjeA0821gqsdUYrigECU436S7U93CVXztXT2hOU2i5XSy88NOUn9+DontisYMykMqJnHxol28BISxun07jq4XgWZEby3lWF+4mrCdgOTLlHRwuBwzOyeBjd7SZyVsnQUnh6cMZsFkqToK/KTkYk1+AqpcVss3wE5e3vopmXgH1ceBRjnzgAQfPOMPYyhOWMJhzpITnxBbk91J/w16AayEKlv1P5/ur69w4RjFPBJHY+oUxYi7jPLnDHw2Gxp8XhihHmzZUICQlXxiBIEf6EWsNpEUpdkgCC1tSjsZcZaZn7CemdjtZDcrmTx+jAwEuzIGQ9A4KE79r+Y11EzGDGXgAD944dUNMvsHFhZg//xHZYQyAd31eA+3Av42ghFjYua895NKCIgVrLawyvQA651wX16/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(8676002)(8936002)(5660300002)(6506007)(83380400001)(41300700001)(4326008)(2616005)(26005)(53546011)(2906002)(38100700002)(6666004)(6512007)(86362001)(31696002)(36756003)(110136005)(66476007)(54906003)(82960400001)(478600001)(6486002)(66946007)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0xkZXdZSTVubi83SkljSFViZEdNY0dKSHZmRUFhNHB2OXNvcVhvN0dtdG5r?=
 =?utf-8?B?M1hoUTl1MXkxSm9MajZPRnB0WUk1YlJqazB2ZHNOQmNBeEQxSmQ2QW9nWkFR?=
 =?utf-8?B?cVI2VFdUd0tHY3Q1QWpmL2lka2RxbWpZZnVpb3ZtWTUzMFFKdUxUNkNaSGYx?=
 =?utf-8?B?cUdjbk0zWXM1Wm83QjlpbFRWM1VTb3dwYklaai9QRVNvdlFzSi9JR1pBUjNu?=
 =?utf-8?B?TUVGSGpDN3JJU3Nva3MvZlBreVBqRlY4NXR4QjlEaFp2dzA1aDkvaG14KzBi?=
 =?utf-8?B?cW9Fdm1HeU5iSE9DU09SZUJTQVFHL3kra0N3cDFqSkRqSENOenFwRUFiei9j?=
 =?utf-8?B?aHpSSnFxd2kwN0VrZXJoSWJzNTFWNnVRY1p0bEZjQlVRSEdhN0hLU3I2YU44?=
 =?utf-8?B?MWVGWmo3OHkvcVZ3V1VvWTgyZWpDRldwR01zeXBmYXIvcEM4ZksxTUNOQ1Br?=
 =?utf-8?B?amU1UGJnOUZhZ2FDV3AxbURSSjd0WDBjTlhNRkFEYTRBbHkrWkV6ZUJkWEF1?=
 =?utf-8?B?T2I1SThRRC9VWTQrSGZ0cEgvVmszTDg2NW4rTm5IdXFBYm1rUFVic3doOFJW?=
 =?utf-8?B?M056MWZ6cGMxb29vNEpkWmFwdzcxZGdqV2VmdzF0c2c1MFNUcUQrdXVOZVIr?=
 =?utf-8?B?azl0REhmSTd0VU5SK2hlQnY4YjdwcWJqYjdOMU9WUVZVRUZBYzFrZ1VGYUJm?=
 =?utf-8?B?emNDU2tXSEtlWkxSendER0tNS2U2aW1RcXRSMCtvOUZXTFlDTFAzWGxNbm9v?=
 =?utf-8?B?eXhiQ3lIRlBYRkJMK1MycVV0bnBYcERmVXhyMzc5S3JaNThKcFBEUTJPQncv?=
 =?utf-8?B?NDZ2akVjTW9wMDBoemZ2MlpvbHZEYTZzNzdFVHlCaUJDcE5TQTZCSVIvL2dq?=
 =?utf-8?B?K0ZtcUtUUndpQlhiaGFWcnJ0Y24zWVVLNXBMbkNhQ1ZWN1BkNjk1dXIwaGln?=
 =?utf-8?B?VnFMdDdCR1hFY0Y0bjdwdVNSR3Bkb1lKYy9aRjRvcUxYMDZIL0Z1Q2JMTktq?=
 =?utf-8?B?WWs5ZzNCNFNlQi9LdmhCUFlHeWdHQ211UGp2RUdhOTdzR3JkK01oU1Zyd24z?=
 =?utf-8?B?OWxrNmNhcFZ6dUlGa1BLOVZyUHgxdmx3WEZBc3V2MDhTZjFSQ0tyUXN3YTRS?=
 =?utf-8?B?TTlUTHl5RXdHRE5qVnRnaHYwa1RGMFVaZjJ3R2lSV3ZXTFA0cnh0THRBS0hu?=
 =?utf-8?B?U0pMcEkxZnBKYnRaNW00am5oMFNBMjlVZ0RXeEpXeHhWRFM5U1VHbmF1RkJr?=
 =?utf-8?B?RTBjYnZ2TVkySHc4eTJjNmxLNVF1SEptbTUxT0VzWGhOQzQ0SW9OSmpBU0Nz?=
 =?utf-8?B?ZkJoL3BmZEdBb3pyNVp6L004VGdXdjVQdmlXS0JFY1cvZit2RE1sdjFSUk9n?=
 =?utf-8?B?NkJ5eng2eUdSbFBya0Rsa0NoREhkVndkZ2hUaVdPcDlxS2p1YzQrSXQ1akF2?=
 =?utf-8?B?cXgyaXQxOFFBSTFsRzV3VzlTVmFEc0pVOEZ1M3BBQ1VrSTNYa1RNV1JXVi91?=
 =?utf-8?B?MzNuVEhYWXl4Y09Qa0FBSE9tTkZRd1k1ZHUvS3ErUGk2b0J2TGdYVlVlaXpH?=
 =?utf-8?B?ajI1VXdpTU1IaGtOZDNyekRQTncxbWp0cnlsaWJtMTd3d012cDhOTGxscGh3?=
 =?utf-8?B?ay9leHcxQzFMdnR6aGt6VEtHY2UydGxMVDVqR3U4VjE0MXNmY3d6KzFHNEhO?=
 =?utf-8?B?dFJKYjVoWm1XbkhsMDhDUVJHc09sUE1hQ1dXK3dqTlJLZW1NdEFYVzR6S1lB?=
 =?utf-8?B?cXNaQXVLd29GMHZQQWI1K3R2YTdxMU5tdFRqK2Vad2lkTFpMVW5SWDFKdnlv?=
 =?utf-8?B?OGVsQVZQVkRZSlJ6aDJoeGxLc1VWWWQwbVl5c3M0YWlIclZPMHFMNzdRYjhZ?=
 =?utf-8?B?eFUxM1g4RUZRdzNUTlFOU3dhSHgzVks1eTdXNFR0bGhOaGJlYlZWRmJKMXR0?=
 =?utf-8?B?SzlIRXlBV3VmdDJxejhjS094REtUNlZjN014RjhPOGdGNThSN0NVSmhCd3pI?=
 =?utf-8?B?VllXOFZVVWdrbHh6SFZyZEI4QW9VR085TDFabDJRUGRJMlBxRG56M0ZXNjlC?=
 =?utf-8?B?eEdRejRpRHpOSTl4OGJEcExHNHVJYlU0TnhGakJBb3dKVW9QckVJWjVPNEtH?=
 =?utf-8?Q?xYNRGPLGVpLML3kHcWQGUTplU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 244416c4-758f-4ac9-3439-08dbd4604fd1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 07:10:32.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5M+H9dDlfw1B6Rsr8rQ8rHQFEeS69QfxeEtGeVGUZJUEFnofgfhAKwj+wyAK5yL9p1ywkoeGowOxaLLrAnXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8138
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huge,

On 10/24/23 14:38, Hugh Dickins wrote:
> Since mm-hotfixes-stable commit dc68badcede4 ("mm: mlock: update
> mlock_pte_range to handle large folio") I've just occasionally seen
> VM_WARN_ON_FOLIO(folio_test_ksm) warnings from folio_within_range(),
> in a splurge after testing with KSM hyperactive.
> 
> folio_referenced_one()'s use of folio_within_vma() is safe because
> it checks folio_test_large() first; but allow_mlock_munlock() needs
> to do the same to avoid those warnings (or check !folio_test_ksm()
> itself? or move either check into folio_within_range()? hard to tell
> without more examples of its use).
Checking folio_test_large() here looks fine to me now. If KSM could support
large folio in the future (Not sure whether this will happen in the future),
we could revise.

> 
> Fixes: dc68badcede4 ("mm: mlock: update mlock_pte_range to handle large folio")
> Signed-off-by: Hugh Dickins <hughd@google.com>
Thanks a lot for catching this issue and fixing it.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
